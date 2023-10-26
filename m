Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF977D7CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:22:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1B3189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:22:09 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0026C3FB5A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698301328;
        bh=z38Oz/Mtbr9Xt0C0ZNzKPQKhWmhzEaxeE+ZSwP8lwk8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FG/TkCEjF/8chBeu8opWQMxLWSk5H63qw6HdRS5RXJxkQuZd2nqCsYrBaurvr4a1q
         TMNaX0o7PiwHTS7KOcwzPoGK6XXXnMJwicMowMJBeeF5rRcg2RGEY40Gcsd6uVntBs
         XKt86R/eruVxnTcdXkhroWYAI70STNtviwHDoT6QQowSyZ77yBMxOK6nNWOwfsLaKW
         CX9rrCIR9/oaLHAFQhhmVQSa2GbIEsaqmGM/aNkj6GyHhXo9hIazHvrGBUY118wtVt
         4IQ0wFPczRzvjMF0TrgvlzV6e/cKyPI6c9MPS0EUVIX/d31rgr4g1HRR6sXX84HHuD
         YlBZYygm3Or3A==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5a8ead739c3so4961057b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301327; x=1698906127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z38Oz/Mtbr9Xt0C0ZNzKPQKhWmhzEaxeE+ZSwP8lwk8=;
        b=Qc8nwrzEF0GEl51qQDZRLGxinPiXhZlUUjC5xPUMzUiD7ZCqumy5MzElASBwxHMoWB
         ziFfBNMyZ9+5maBS9SrPm/yez1Zv3HTEPLxLF0nE3c495VekfUAkgwIcyK5zLzy4tEz7
         pXXDxLtfbLdoIYHo73tJahvDmICNDHAG1bN6I9ZoHMjG62v33Rmkz1Lxa1jBuYAj1EYv
         EdXlhF/wR6qFeIod29vt0C+vCvBH/TAB7MS+hwFaTWjVlExHLA+YyMG3OGyBu1M1sTFl
         kgHhlJZkrXAZQbVgmhXtuy+l75T/AOD+8xFsB8bN083SNxZiOgmB9afp6TU/lkJty8+R
         B6Tw==
X-Gm-Message-State: AOJu0YwP/Cji72JDmDQ/SHRuXmvqW3mIjJOh4y9zKJSeuuEA1ToCTHSj
        TEe7AFxBLY9p0OP+KWby1tOoW2o7+2IaUl960BsQIGJjvYDJmJrC9ahbAVgzKkWlyOIq3k2WOBm
        a9jE4zLLihnOROglE/KxRZX4Bbno+vyXkqwkfEQ68WMduRq3OVXK5hL4flA==
X-Received: by 2002:a25:2d14:0:b0:d9b:4f28:f6ce with SMTP id t20-20020a252d14000000b00d9b4f28f6cemr17333069ybt.1.1698301326892;
        Wed, 25 Oct 2023 23:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5PqzqKXKjiv9pPATB/SXMg3Ux/7AIueNRDtpnk0Z46tFQQAt6NVTeptyV5v8FU27yjN2kCrMWfAO4Xe9VFig=
X-Received: by 2002:a25:2d14:0:b0:d9b:4f28:f6ce with SMTP id
 t20-20020a252d14000000b00d9b4f28f6cemr17333053ybt.1.1698301326645; Wed, 25
 Oct 2023 23:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231026012017.518610-1-acelan.kao@canonical.com> <20231026061143.bjbgfkyhnnyh2ovb@dhruva>
In-Reply-To: <20231026061143.bjbgfkyhnnyh2ovb@dhruva>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 26 Oct 2023 14:21:54 +0800
Message-ID: <CAFv23Q=UXVd0qGBD3irDQejFhiK=qQaWf6B4KpiMkCzzGmP4hQ@mail.gmail.com>
Subject: Re: [PATCH v4] mtd: spi-nor: Improve reporting for software reset failures
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dhruva Gole <d-gole@ti.com> =E6=96=BC 2023=E5=B9=B410=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Oct 26, 2023 at 09:20:17 +0800, AceLan Kao wrote:
> > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >
> > When the software reset command isn't supported, we now report it
> > as an informational message(dev_info) instead of a warning(dev_warn).
> > This adjustment helps avoid unnecessary alarm and confusion regarding
> > software reset capabilities.
> >
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> > v2. only lower the priority for the not supported failure
> > v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only
> > v4. move the version information below the '---' line
> > ---
> >  drivers/mtd/spi-nor/core.c | 5 ++++-
> >  drivers/spi/spi-mem.c      | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 1b0c6770c14e..42e52af76289 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *n=
or)
> >
> >       ret =3D spi_mem_exec_op(nor->spimem, &op);
> >       if (ret) {
> > -             dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> > +             if (ret =3D=3D -EOPNOTSUPP)
> > +                     dev_info(nor->dev, "Software reset enable command=
 doesn't support: %d\n", ret);
>
> Does "Software reset command isn't supported:" make more sense?
That's because the op is "software reset enable" command

#define SPINOR_OP_SRSTEN        0x66    /* Software Reset Enable */
#define SPINOR_SRSTEN_OP                                                \
          SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 0),                 \
                     SPI_MEM_OP_NO_DUMMY,                                 \
                     SPI_MEM_OP_NO_ADDR,                                  \
                     SPI_MEM_OP_NO_DATA)
op =3D (struct spi_mem_op)SPINOR_SRSTEN_OP;

>
> > +             else
> > +                     dev_warn(nor->dev, "Software reset failed: %d\n",=
 ret);
> >               return;
> >       }
> >
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index edd7430d4c05..93b77ac0b798 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const stru=
ct spi_mem_op *op)
> >               return ret;
> >
> >       if (!spi_mem_internal_supports_op(mem, op))
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>
> >
> >       if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(m=
em->spi, 0)) {
> >               ret =3D spi_mem_access_start(mem);
> > --
> > 2.34.1
> >
> >
>
>
> --
> Best regards,
> Dhruva Gole <d-gole@ti.com>
