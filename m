Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8787E8184
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbjKJS30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346560AbjKJS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:59 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4628B01
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:23:00 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4252140C53
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699611779;
        bh=fZJ7ihL+H/aiHG4LFfNsLqbqzJLeVxJjVV1iBLHcmVo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WpQXeg61a7Gz/s15smL2lpYSDgPSFDQTiuLKeZpqGHajhtxgaiFgX1KNZXWED4SqS
         0A5K9V0IiBz/THSHuHSQCJcQlvuGesCP442cEaV6Q8VFqlvPXJdZ/Sfp5kIY/3hnEX
         kfgwjsENZJSsos5KiMLlN3BqrYwDSvIUqdDLFtQYYHfLrH7V1JuPCdVEQxbM7U8VJ+
         +yP6+s6SMi5xIXQ6JAHUQSabib+3tgfVMi3i4TdEH9xYZ/ZHrTntE72gof9vX2YfUo
         8kaVUkEuiRVWCW3XVrrefxK4e0exyU61r/wwmkdvRqHePeJCl0K8qTklZ632adPe0O
         w/UXas6yD0HXg==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5af16e00fadso27440757b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611778; x=1700216578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZJ7ihL+H/aiHG4LFfNsLqbqzJLeVxJjVV1iBLHcmVo=;
        b=lhsQhPd/DTWbgXlOuncJIbgCjPneUQkkT5pvvhldbsGGNcG5Fs8bYymEEYZDxrLzED
         GpeuEE6Jjj2qqsWBiWqSpzqk7bzNzrqyb1ToHlnBsfk0d5DP9p3UwZJ8XnusAEn+WGZv
         Jh8qpvKsxldwI2KTIXc1V4MrOxzu0Tr5xyBV9Qot7HVhqz6nIYc9DpKgN8v5X0H/mdvg
         YibIJTdHQ2PYch2S6rNXrf6JYACZv6KO/vbQbud0i0mNnevFWzgKwvPF0A0wwCq0wR8j
         AnQ1hMox4iw5FM3CpyNt1z5JU/Lt7BsGpaR0K/kswQAMbQARbc/dmva82FqI48UDr3Gm
         R32g==
X-Gm-Message-State: AOJu0YzH5siTPWxK5gseVCZBfc7wDvety9fmioOszcFDQFyRS046ORE2
        trH8J/8IUFRhP0vHseZJpSnz62xOk63yCFu//oH7G925XOf1GKBCyd97lkK5yG1jgae7rbov8xd
        GHvno53+ew9gXQPu6kh5Q5wYhZe76OWxG3MO22FhR5jWmDN22SPzXbS831w==
X-Received: by 2002:a25:680d:0:b0:d9a:bddd:f714 with SMTP id d13-20020a25680d000000b00d9abdddf714mr7635716ybc.9.1699611778096;
        Fri, 10 Nov 2023 02:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkKJkczeQZ47oF8/S4UM4zzdUAIJr51XuUDWp6l7tpCgZL7uAW0Thvva0hGqz87HubMlEp0HtnqeOO3B2pxro=
X-Received: by 2002:a25:680d:0:b0:d9a:bddd:f714 with SMTP id
 d13-20020a25680d000000b00d9abdddf714mr7635709ybc.9.1699611777746; Fri, 10 Nov
 2023 02:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20231108094303.46303-1-acelan.kao@canonical.com> <30509dedc61b0590b322e2860abbd109@walle.cc>
In-Reply-To: <30509dedc61b0590b322e2860abbd109@walle.cc>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Fri, 10 Nov 2023 18:22:46 +0800
Message-ID: <CAFv23Qm7DdBEg2V0NTKh8DyHEgjcESRctkHfHSJ3CJnKJuHqKA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op checking
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Michael Walle <michael@walle.cc> =E6=96=BC 2023=E5=B9=B411=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> Am 2023-11-08 10:43, schrieb AceLan Kao:
> > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >
> > No functional changes are introduced by this patch; it's a code cleanup
> > to use the correct error code.
>
> This error code might be returned to userspace (I guess?).

It's not likely the value will be returned to userspace.
I didn't find a path that the value will go to usepsace.
>
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> >
> > ---
> > v5. distinguish -EOPNOTSUPP from -ENOTSUPP
> > ---
> >  drivers/mtd/nand/spi/core.c | 2 +-
> >  drivers/spi/atmel-quadspi.c | 2 +-
> >  drivers/spi/spi-ath79.c     | 2 +-
> >  drivers/spi/spi-bcm-qspi.c  | 2 +-
> >  drivers/spi/spi-mem.c       | 6 +++---
> >  drivers/spi/spi-npcm-fiu.c  | 2 +-
> >  drivers/spi/spi-ti-qspi.c   | 4 ++--
> >  drivers/spi/spi-wpcm-fiu.c  | 2 +-
>
> This is missing a user in spi-nor/core.c (in
> spi_nor_set_4byte_addr_mode()).
Right, we should change the check to -EOPNOTSUPP
>
> -michael
>
> >  8 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index 393ff37f0d23..d1df5cd401cf 100644
> > --- a/drivers/mtd/nand/spi/core.c
> > +++ b/drivers/mtd/nand/spi/core.c
> > @@ -973,7 +973,7 @@ static int spinand_manufacturer_match(struct
> > spinand_device *spinand,
> >               spinand->manufacturer =3D manufacturer;
> >               return 0;
> >       }
> > -     return -ENOTSUPP;
> > +     return -EOPNOTSUPP;
> >  }
> >
> >  static int spinand_id_detect(struct spinand_device *spinand)
> > diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> > index 3d1252566134..370c4d1572ed 100644
> > --- a/drivers/spi/atmel-quadspi.c
> > +++ b/drivers/spi/atmel-quadspi.c
> > @@ -272,7 +272,7 @@ static int atmel_qspi_find_mode(const struct
> > spi_mem_op *op)
> >               if (atmel_qspi_is_compatible(op, &atmel_qspi_modes[i]))
> >                       return i;
> >
> > -     return -ENOTSUPP;
> > +     return -EOPNOTSUPP;
> >  }
> >
> >  static bool atmel_qspi_supports_op(struct spi_mem *mem,
> > diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> > index c9f1d1e1dcf7..b7ada981464a 100644
> > --- a/drivers/spi/spi-ath79.c
> > +++ b/drivers/spi/spi-ath79.c
> > @@ -146,7 +146,7 @@ static int ath79_exec_mem_op(struct spi_mem *mem,
> >       /* Only use for fast-read op. */
> >       if (op->cmd.opcode !=3D 0x0b || op->data.dir !=3D SPI_MEM_DATA_IN=
 ||
> >           op->addr.nbytes !=3D 3 || op->dummy.nbytes !=3D 1)
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       /* disable GPIO mode */
> >       ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
> > diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
> > index ef08fcac2f6d..d96222e6d7d2 100644
> > --- a/drivers/spi/spi-bcm-qspi.c
> > +++ b/drivers/spi/spi-bcm-qspi.c
> > @@ -1199,7 +1199,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem
> > *mem,
> >
> >       if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 |=
|
> >           op->data.dir !=3D SPI_MEM_DATA_IN)
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       buf =3D op->data.buf.in;
> >       addr =3D op->addr.val;
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index edd7430d4c05..2dc8ceb85374 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const
> > struct spi_mem_op *op)
> >               return ret;
> >
> >       if (!spi_mem_internal_supports_op(mem, op))
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       if (ctlr->mem_ops && ctlr->mem_ops->exec_op &&
> > !spi_get_csgpiod(mem->spi, 0)) {
> >               ret =3D spi_mem_access_start(mem);
> > @@ -339,7 +339,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const
> > struct spi_mem_op *op)
> >                * read path) and expect the core to use the regular SPI
> >                * interface in other cases.
> >                */
> > -             if (!ret || ret !=3D -ENOTSUPP)
> > +             if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP)
> >                       return ret;
> >       }
> >
> > @@ -559,7 +559,7 @@ spi_mem_dirmap_create(struct spi_mem *mem,
> >       if (ret) {
> >               desc->nodirmap =3D true;
> >               if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
> > -                     ret =3D -ENOTSUPP;
> > +                     ret =3D -EOPNOTSUPP;
> >               else
> >                       ret =3D 0;
> >       }
> > diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
> > index 03db9f016a11..f3bb8bbc192f 100644
> > --- a/drivers/spi/spi-npcm-fiu.c
> > +++ b/drivers/spi/spi-npcm-fiu.c
> > @@ -556,7 +556,7 @@ static int npcm_fiu_exec_op(struct spi_mem *mem,
> > const struct spi_mem_op *op)
> >               op->data.nbytes);
> >
> >       if (fiu->spix_mode || op->addr.nbytes > 4)
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       if (fiu->clkrate !=3D chip->clkrate) {
> >               ret =3D clk_set_rate(fiu->clk, chip->clkrate);
> > diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> > index 4c81516b67db..0877dc5058a1 100644
> > --- a/drivers/spi/spi-ti-qspi.c
> > +++ b/drivers/spi/spi-ti-qspi.c
> > @@ -613,12 +613,12 @@ static int ti_qspi_exec_mem_op(struct spi_mem
> > *mem,
> >       /* Only optimize read path. */
> >       if (!op->data.nbytes || op->data.dir !=3D SPI_MEM_DATA_IN ||
> >           !op->addr.nbytes || op->addr.nbytes > 4)
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       /* Address exceeds MMIO window size, fall back to regular mode. *=
/
> >       from =3D op->addr.val;
> >       if (from + op->data.nbytes > qspi->mmap_size)
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       mutex_lock(&qspi->list_lock);
> >
> > diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
> > index 852ffe013d32..d76f7b5a9b97 100644
> > --- a/drivers/spi/spi-wpcm-fiu.c
> > +++ b/drivers/spi/spi-wpcm-fiu.c
> > @@ -361,7 +361,7 @@ static int wpcm_fiu_exec_op(struct spi_mem *mem,
> > const struct spi_mem_op *op)
> >
> >       wpcm_fiu_stall_host(fiu, false);
> >
> > -     return -ENOTSUPP;
> > +     return -EOPNOTSUPP;
> >  }
> >
> >  static int wpcm_fiu_adjust_op_size(struct spi_mem *mem, struct
> > spi_mem_op *op)
