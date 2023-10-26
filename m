Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494787D8047
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjJZKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:09:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96675195
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:09:10 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E89813F6A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698314948;
        bh=yVpX8CL6o5DmvaeUJSfyJmDacrR2aNsv8UsIqu8d7TU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=swZSBOerfSL4/+YebM2/Pyw18WqtFqv7KRSrSvxjfrX+5Q1vsrhg8B/TK5zT4kkBV
         S6uhadnCOTZhpUZVsd+pCmW61BH7SsTidQBZJBsSCvL1L3HCga5A5XJIDweVfZHsC0
         XcZrhpEOSDTdmKLsEThklxkznnjgocKRIsVZwYwQT2Qj2YJWHN9vIlc9J4GPZT21qG
         Xi179bAFZoqO9mFDkzmtPEPJWbQUeKjA0KJgmapGAnwcBZvaZn5Y6Ln/OZ1mLSjD+O
         7DPvWQpBdYcaV4Fidp3niJxPILoFrXcfgbHUCJrmqHFpjkexVVuxlb6Y2R96w08Z6x
         tv0u5vtcEnCdA==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7cfdacf8fso17968317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314948; x=1698919748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVpX8CL6o5DmvaeUJSfyJmDacrR2aNsv8UsIqu8d7TU=;
        b=OCoMvVKnlkDX5i3H+N3sUDpPaUWAfX8ktfVrshh2Ks6wweA0jymu1OgnJkEk9bfDBy
         ONZxrpyY2gItdACUT2TJYXzfKlIRxgnO1KrwFD4fdbH3gM1xhnpznCz7gYKoaixjfKIj
         gWybnMENM4rwlAFaTbWutU+R9ZhzHVBTA1MDh46Fafhzsc0QYtJxyM8KCI4aZ572+H4t
         MzReoEi2MmoNiShZlVVSOP8jC8qC0j+8+4bTKTu0OmD0aNlpW+HqaWGzS/Y/XSLhp2tM
         hgaz42HdEtzePIWjCcFCiKQnMlHdDP1b8vsUgQFnmWMji7ScfX36HnXAFd/pEVTzZ70w
         u1Sg==
X-Gm-Message-State: AOJu0YzP0neaDqYs71XYS0ZS9YVdMWi0YzOTmIexbTTw2YNSf7zJFDkq
        lsSXMZuU03lqepxd7bHSw1RvtxVyED42kZC4zwPcST0zk/P2r9T7hztvtBB9UpTkss4fR2z3G8W
        ZI2jFCsxeH6cdqLO2JYG6ATTGZ+qouN4Qzh4bI4P9Dd3MkK9cBMOq/rDAjw==
X-Received: by 2002:a25:41d2:0:b0:d9c:fdc7:632c with SMTP id o201-20020a2541d2000000b00d9cfdc7632cmr3466422yba.21.1698314947955;
        Thu, 26 Oct 2023 03:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIDb847ZCAjDIAVlTecREh4iwiNarhki3PIESweqv0q4Yk66ziCj26/rqPI+wOUsEiCv70OWqm4zHNn7CYYtM=
X-Received: by 2002:a25:41d2:0:b0:d9c:fdc7:632c with SMTP id
 o201-20020a2541d2000000b00d9cfdc7632cmr3466396yba.21.1698314947647; Thu, 26
 Oct 2023 03:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231026012017.518610-1-acelan.kao@canonical.com> <F56F4D7D-1264-41E1-9CE7-5DA410A22D73@walle.cc>
In-Reply-To: <F56F4D7D-1264-41E1-9CE7-5DA410A22D73@walle.cc>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 26 Oct 2023 18:08:54 +0800
Message-ID: <CAFv23QmHvvib=E3RPtGXN-jAT9dXuZ6_-62xy0OjBYGRmrFPwg@mail.gmail.com>
Subject: Re: [PATCH v4] mtd: spi-nor: Improve reporting for software reset failures
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
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

Michael Walle <michael@walle.cc> =E6=96=BC 2023=E5=B9=B410=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Am 26. Oktober 2023 04:20:17 OESZ schrieb AceLan Kao <acelan.kao@canonica=
l.com>:
> >From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >
> >When the software reset command isn't supported, we now report it
> >as an informational message(dev_info) instead of a warning(dev_warn).
> >This adjustment helps avoid unnecessary alarm and confusion regarding
> >software reset capabilities.
> >
> >Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>
> NAK. You surely missed my comments on the previous version.

Hi Michael,

It's strange that I didn't receive your first reply, and I just
checked it from web archive[1].
I quote your opinions and reply them below.

> It bothers me that we use ENOTSUPP here. We should really use
>
> EOPNOTSUPP.
> The core uses EOPNOTSUPP everywhere except for the intel things.
>
> Please have a look at changing that to EOPNOTSUPP. See also:
> https://lore.kernel.org/linux-mtd/85f9c462-c155-dc17-dc97-3254acfa55d2@mi=
crochip.com/
Yes, this has been done in v3

> I'm not sure this is helpful. It's only the intel SPI controller which
> does magic things (instead of just issuing our commands). Mika, do you
> know wether your controller will do a reset on it's own? I presume so,
> because AFAIR you have some kind of high level controller which also
> does
> SFDP parsing and read opcode handling on their own.
Mika's replied you,
and I think even if intel SPI controller do the magic things, the
error message is still annoying.

> I'd leave that as is, because how are the chances that the first one is
> supported and the second command, isn't?
> When working with the intel controller, we'll return early after the
> first spi_mem_exec_op().
Yes, this has been done in v3.

And then I checked again and found you have replied[2] the v3 patch
and I still didn't recevie that one, too.
Now I got your point, will revise my patch and submit v5 soon.
Thanks.

1. https://lore.kernel.org/lkml/20231024074332.462741-1-acelan.kao@canonica=
l.com/T/#m7e5e7872151a913d5fe274fc20b7981bd10dd09f
2. https://lore.kernel.org/lkml/20231025030501.490355-1-acelan.kao@canonica=
l.com/T/#u
>
> -michael
>
> >---
> >v2. only lower the priority for the not supported failure
> >v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only
> >v4. move the version information below the '---' line
> >---
> > drivers/mtd/spi-nor/core.c | 5 ++++-
> > drivers/spi/spi-mem.c      | 2 +-
> > 2 files changed, 5 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >index 1b0c6770c14e..42e52af76289 100644
> >--- a/drivers/mtd/spi-nor/core.c
> >+++ b/drivers/mtd/spi-nor/core.c
> >@@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *no=
r)
> >
> >       ret =3D spi_mem_exec_op(nor->spimem, &op);
> >       if (ret) {
> >-              dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> >+              if (ret =3D=3D -EOPNOTSUPP)
> >+                      dev_info(nor->dev, "Software reset enable command=
 doesn't support: %d\n", ret);
> >+              else
> >+                      dev_warn(nor->dev, "Software reset failed: %d\n",=
 ret);
> >               return;
> >       }
> >
> >diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> >index edd7430d4c05..93b77ac0b798 100644
> >--- a/drivers/spi/spi-mem.c
> >+++ b/drivers/spi/spi-mem.c
> >@@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struc=
t spi_mem_op *op)
> >               return ret;
> >
> >       if (!spi_mem_internal_supports_op(mem, op))
> >-              return -ENOTSUPP;
> >+              return -EOPNOTSUPP;
> >
> >       if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(m=
em->spi, 0)) {
> >               ret =3D spi_mem_access_start(mem);
>
