Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB0E7D2893
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjJWCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjJWCey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:34:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635113E
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:34:50 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29CF43F1D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698028489;
        bh=/z90kVHSuesNRVY9EhRmSRFJcLC8zb/BUX/p+1SLxl0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Pzk5u6rIXZdn2jB0cZhwxhCye4wWAOb6MfsLNnQVwoUJaXy90GcjTQ858JJ/02m8G
         7Qp6LiSQAfo4Klw4vPGHTrjd44sjZAU4XFzqHaKNh3JaFuPvtBhXN4GTQUZStGKSyi
         JJBzuYfol1vKiLF26McNDrYJgPop2V6gbURAf/bFg37qPsgsM2Y9IZUQhqB2nXkOJR
         s4FgzLZb4GsOSUqNAm1EntqJq8O6Gim2pWNRaZRY5ZWEPELRHCWi+dez3AnhIZs93x
         4Ag+g/PWXUqt+l5ckHTQXn+bpfUSgMU7KHsTNGJ//NpmX6mHGOICInWOt7s09OxfrO
         JmcS3AXWlBy6A==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7a6fd18abso39105047b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698028487; x=1698633287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z90kVHSuesNRVY9EhRmSRFJcLC8zb/BUX/p+1SLxl0=;
        b=AqW64+OxLDWF7Ctpp6+t8p57MDsL0DkgJ70TI38CowLB/cxin/PpALTJMS9nt06A0E
         UNFbuIP+hSLqlxMIERyfKZsqlyyInaTIG7ZZn4OjqLRQqJO+m9PcarHsF7Lz1h/0oDEs
         vf9PaJwT1c92Tres5Fs0he2c2CdNL5oOX/iNedVVyFQXq5cg9bR2lviWv8z+xDSydOcM
         9t4UBuBbieiPkoSMV/6q4tMGfgpWTVYNgD3aZ9FdcY4/z2frDFeLu0ImZV58cQ3BfEog
         52kvS05P7+3ZtmPdKgYt8Brbf+sc1L6ZGrhxC9fESGV7mqer0XeVzUasH6Lk6oGS5pby
         2t2w==
X-Gm-Message-State: AOJu0YyJJ+A9B/geVhtKUmZvVEiFGk/7CKou5bgTMhGvsJBv99U9wqhw
        Ska3fEgHdFiOXntGnSuESzEQoucIwutG2Ts9RFwxqJE6S0aHTe86PrOT8gTx+3dik8qqZ8TnsQV
        Z8YQLOwnj4EIxkq1e/Ks4FNQ83uvUEGEbSjvhwCmt6K65B+h7KcyH4I2EWh4UOQhPXV+f
X-Received: by 2002:a5b:d44:0:b0:d85:eb7b:5c74 with SMTP id f4-20020a5b0d44000000b00d85eb7b5c74mr8143637ybr.31.1698028487493;
        Sun, 22 Oct 2023 19:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnn2GhXGcAB7IHMlOwmoGs3Q0Dar7QVxE6l0kd38MCSzy5MIBmMukQKmx5FXtss0VssztHdzc/ubLiRfOVWb4=
X-Received: by 2002:a5b:d44:0:b0:d85:eb7b:5c74 with SMTP id
 f4-20020a5b0d44000000b00d85eb7b5c74mr8143628ybr.31.1698028487217; Sun, 22 Oct
 2023 19:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231019064547.348446-1-acelan.kao@canonical.com> <mafs07cnin59q.fsf@kernel.org>
In-Reply-To: <mafs07cnin59q.fsf@kernel.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 23 Oct 2023 10:34:34 +0800
Message-ID: <CAFv23QmjV9RAtvZJT2=8BPKZn+LsZbLG45t7fr2Z7Nq2C2nH0A@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Lower the priority of the software reset
 failure message
To:     Pratyush Yadav <pratyush@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pratyush Yadav <pratyush@kernel.org> =E6=96=BC 2023=E5=B9=B410=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, Oct 19 2023, AceLan Kao wrote:
>
> > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >
> > Not all SPI drivers support soft reset enable and soft reset commands.
> > This failure is expected and not critical. Thus, we avoid reporting it
> > to regular users to prevent potential confusion regarding power-off iss=
ues.
Hi Pratyush,
>
> No, failure to soft reset can very much be critical in certain cases.
> For example, if you are operating the flash in 8D-8D-8D mode and do not
> have the hard reset line connected, the bootloader (or the kernel) would
> be unable to detect or operate the flash after a warm reboot.
>
> Perhaps it makes sense to just call it when SNOR_F_BROKEN_RESET is set?
> This way you do not unnecessarily call it when you do not need to, and
> won't see the error message.
The issue I found was on a x86 desktop, and I can find many other same
bug reports talked about the spi-nor reset failure.

The issue is from spi-intel driver that doesn't accept the reset
command and return false when calls its supports function
spi_nor_soft_reset() -> spi_mem_exec_op() ->
spi_mem_internal_supports_op() -> ctlr->mem_ops->supports_op() ->
intel_spi_supports_mem_op() return false
And  from spi_mem_exec_op(), it returns -ENOTSUPP.

So, do you think it's better that we distinguish -ENOTSUPP and other
failures in spi_nor_soft_reset() likes

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..76920dbc568b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)

        ret =3D spi_mem_exec_op(nor->spimem, &op);
        if (ret) {
-               dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+               if (ret =3D=3D -ENOTSUPP)
+                       dev_info(nor->dev, "Software reset enable
command doesn't support: %d\n", ret);
+               else
+                       dev_warn(nor->dev, "Software reset failed: %d\n", r=
et);
                return;
        }

@@ -3262,7 +3265,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)

        ret =3D spi_mem_exec_op(nor->spimem, &op);
        if (ret) {
-               dev_warn(nor->dev, "Software reset failed: %d\n", ret);
+               if (ret =3D=3D -ENOTSUPP)
+                       dev_info(nor->dev, "Software reset command
doesn't support: %d\n", ret);
+               else
+                       dev_warn(nor->dev, "Software reset failed: %d\n", r=
et);
                return;
        }

>
> >
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 1b0c6770c14e..7bca8ffcd756 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3252,7 +3252,7 @@ static void spi_nor_soft_reset(struct spi_nor *no=
r)
> >
> >       ret =3D spi_mem_exec_op(nor->spimem, &op);
> >       if (ret) {
> > -             dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> > +             dev_info(nor->dev, "Software reset failed: %d\n", ret);
> >               return;
> >       }
> >
> > @@ -3262,7 +3262,7 @@ static void spi_nor_soft_reset(struct spi_nor *no=
r)
> >
> >       ret =3D spi_mem_exec_op(nor->spimem, &op);
> >       if (ret) {
> > -             dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> > +             dev_info(nor->dev, "Software reset failed: %d\n", ret);
> >               return;
> >       }
>
> --
> Regards,
> Pratyush Yadav
