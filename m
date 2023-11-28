Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3737FB59E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjK1JYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1JYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:24:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99251D0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:25:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbda959062so4569720b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701163500; x=1701768300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIvMM7mjQbdSWD76tI3zt2v2Np/Oon7r71veftvgKKI=;
        b=G0tYhW7QXHfqpHgOaLstVLQRLosHrP++zSzDnBLVkJ2USaeLduF0hy2abhLudNZfwZ
         ARxHVMevOGO6YLm+QTgVhAK45l0o7gjymjRVq6AIBZnkddQLruwF9jYRSr3JkwnR2uCJ
         Se6XzJJiaxyZmqygGRgxbfj7iO5yzFGon+LaIcm6AOPKYmdY8FCH3Gy6KXZp8Y7kBrzT
         0vaJVIIh9Ky2mDscRrFjpGMKgkaX1O7YWtSl01FNTxhr7lfOS6NqXjfcwVS4mVmwN5D8
         UB4jm96J9C/r1lJsRU3DEyVfVXbVqxCMoyHF3+vZZb6umcdBZvGWkhsVCB0BmDJVnwTA
         P8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163500; x=1701768300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIvMM7mjQbdSWD76tI3zt2v2Np/Oon7r71veftvgKKI=;
        b=VfpEFR7LSAEVLCdJHqkSazffVNepMw/h/8a+h+ow2W0gGLHAAtMb/KQiNOOj1k5fK2
         NimAYKkiziCcy40i89UCFg7fmyF5Uh5D7bJh0bJoDzD/NdMEKFaB5G6fR8PRW93iiSL2
         6cfz7f4/jSka07LoiMWVjyVuqKE/ezpheOp9AG0WVjbZEJ9+Z5IQTNhitkN7fDClxaF1
         nZVAydpHr/P6b+y5pF4RyTjvqqRY9R6LZBNSVlEHmCnbilKFz9mA2eHF0pUew0Xy8tuY
         N4EfDbP505HTv5kpkbuVx3SO43CSZrjNy6M4eV+HjAkelz88Ze4/eOFCwPZWqkdCbfoU
         G7Jw==
X-Gm-Message-State: AOJu0YzThW+qEoUyjDr+Sx0ySFexrGR8OGeEroA4fJLehhbTy5Dhoxq2
        TeUhD/+TJ3kARtZs+UfoJbgng/YPuIkrI1/U/gI=
X-Google-Smtp-Source: AGHT+IEGq36rOUe7b5le7iMjD2HJ/EEhduxdASKLlAWaV1gEw0963o6fSX8ebv1LJqnqSJoaTn1uwuCDLGAFBCokBtI=
X-Received: by 2002:a05:6a20:258b:b0:18c:64e0:447b with SMTP id
 k11-20020a056a20258b00b0018c64e0447bmr10422700pzd.28.1701163499911; Tue, 28
 Nov 2023 01:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
 <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc> <20231128100313.3c990f69@xps-13> <18ba4126dbd9e49846344b517ad2fbdd@walle.cc>
In-Reply-To: <18ba4126dbd9e49846344b517ad2fbdd@walle.cc>
From:   liao jaime <jaimeliao.tw@gmail.com>
Date:   Tue, 28 Nov 2023 17:24:42 +0800
Message-ID: <CAAQoYR=ZAEVeoCwkRmky2CHVeKGX55JijM8Q6D5msz_5iW+jtw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        jaimeliao@mxic.com.tw, pratyush@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


>
> Hi,
>
> >> > The mtd data can be obtain with the mtd ioctls and the SPI NOR
> >> > flash name can be determined interrogating the sysfs entries.
> >> > Stop polluting the kernel log.
> >> >
> >> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> >
> >> > ---
> >> >  drivers/mtd/spi-nor/core.c | 19 -------------------
> >> >  1 file changed, 19 deletions(-)
> >> >
> >> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >> > index 25a64c65717d..6de76fd009d1 100644
> >> > --- a/drivers/mtd/spi-nor/core.c
> >> > +++ b/drivers/mtd/spi-nor/core.c
> >> > @@ -3517,25 +3517,6 @@ int spi_nor_scan(struct spi_nor *nor, const char > *name,
> >> >    /* No mtd_info fields should be used up to this point. */
> >> >    spi_nor_set_mtd_info(nor);
> >> >
> >> > -  dev_info(dev, "%s (%lld Kbytes)\n", info->name,
> >> > -                  (long long)mtd->size >> 10);
> >>
> >> I'd lower this to dev_dbg() and print the jedec id. It might come in
> >> handy for a quick glance during bootup if debug is enabled.
> >
> > Ack. Although, your boot time will almost be unaffected if you don't
> > print the info messages to the console. What takes the most time is not
> > writing to the kernel buffer, it's to display the lines on a serial
> > console, and dev_info() are by default discarded, you need to select a
> > lower log level manually, and if you do that it means you're not
> > looking for quick boot times but rather more for additional
> > information.
>
> Also with recent (or planned, dunno the current state) printk won't wait
> anymore for the slowest console. I really don't have a strong opinion,
> either dev_info(jedec_id) or dev_dbg(jedec_id). Whatever Tudor prefers.
>
> >> > -  dev_dbg(dev,
> >> > -          "mtd .name = %s, .size = 0x%llx (%lldMiB), "
> >> > -          ".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
> >> > -          mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
> >> > -          mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
> >> > -
> >> > -  if (mtd->numeraseregions)
> >> > -          for (i = 0; i < mtd->numeraseregions; i++)
> >> > -                  dev_dbg(dev,
> >> > -                          "mtd.eraseregions[%d] = { .offset = 0x%llx, "
> >> > -                          ".erasesize = 0x%.8x (%uKiB), "
> >> > -                          ".numblocks = %d }\n",
> >> > -                          i, (long long)mtd->eraseregions[i].offset,
> >> > -                          mtd->eraseregions[i].erasesize,
> >> > -                          mtd->eraseregions[i].erasesize / 1024,
> >> > -                          mtd->eraseregions[i].numblocks);
> >> >    return 0;
> >>
> >> Part of this is already available through the spi-nor debugfs,
> >> although not
> >> the actual mtd properties. These I think, should go into the mtdcore
> >> itself if really needed. Either through dev_dbg() or debugfs.
> >
> > Maybe we don't need this at all, as long as one message remains about
> > the JEDEC ID, but keep in mind that spi-nors are commonly storing the
> > rootfs and if your spi-nor does not boot you don't have a userspace yet
> > and all the debugfs entries are purely useless.
>
> Good point.
>
> Just curious, do you know any boards which has the rootfs writable on
> the spi-nor flash?
I am also interested.

>
> -michael
>

Thanks
Jaime
