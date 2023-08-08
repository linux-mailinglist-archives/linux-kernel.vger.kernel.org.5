Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AF47741B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjHHR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHHRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28745205D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:11:04 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd092cba5dso377564a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511012; x=1692115812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=etYCtJmLUCZjgywwSxSW6CC3Fb9cpk0onn2CuiX0ydvmojDmd7LrLe2ndD4aeacHjX
         u7dwW31Y0DupC5REnES7of1LQGPIBxz0BiJn4wuQmsTMrqYkhNfoYV72Qu6sSIw7kINT
         EkrLn1dxE3okvkQnD5a+S1M8fqDjCuN/FtqGvDLzzKipHFsqF3h4lf/+OCvKqCGr2sX7
         ZX6QX/LLr/w9qr/mAZMPpZPOs8Hu83lULi9B876KoQ6N+X4Y6VXIk7TLcq13W/DrzhC2
         RR4unF/kMaQHon9+aLvv5cwEFU7DWnpOTvISNPKX3iTBMM80OROWbncYCDL52Eog+pPn
         Mplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511012; x=1692115812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=REOHBYS7Dfw+Am/j8mQFnFiq4O5RYZWiHOhymMkLlrMDWtzaCUCeFFLiS9t1sDecrI
         Ccex/2Zjmcpk+k2e46jitF2JOT8hMV63yU0sMHRu22pNtha+rMS/3N3RmvbipzwAGfZu
         rhfsxjAnWDRHncbgTdiqTf9QHK2AwoQWYDIuLTCFLXez47xEpPKsjXKEfBTG0D1j/fmQ
         SKTl8xqwnJv7luG/L4mNt6xKztVuC1qVwtgb/sLaHZs7CHrIqqQrIU1OTccn0RaYCY41
         rObVL/KQmu0tYxIkwAJIC0kVSp5R9a2oomSTYh7kAcfUQDVZxK8CLfD1UdiIXFiV7bOA
         ShiQ==
X-Gm-Message-State: AOJu0Yx+kDVFoHf5PcR8/V1g+R2D4JgmDrTsxxEOIo/M8r8LaO/KW8mv
        NE69wIY3oIApIDJ2T8ff59cOiF9KEH+/1zkq5GIRIlh0IdiNpJ5C
X-Google-Smtp-Source: AGHT+IF66ZIg71BsvfIXpCtaWYgCcZU8SNpF3fi8QtXBlp/Ozl2bOkN0RcX0VeXVj4YAJiEXbN2H1G1ZyCw5KxmnN8o=
X-Received: by 2002:a25:aa21:0:b0:d15:3761:3513 with SMTP id
 s30-20020a25aa21000000b00d1537613513mr9704045ybi.19.1691486159218; Tue, 08
 Aug 2023 02:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230801173544.1929519-1-hch@lst.de> <20230801173544.1929519-3-hch@lst.de>
In-Reply-To: <20230801173544.1929519-3-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:15:23 +0200
Message-ID: <CAPDyKForXd2GFVmXXM8hsnAYSQcKhp84t1aOunppUY+MFe0qag@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: au1xmmc: force non-modular build and remove
 symbol_get usage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 19:36, Christoph Hellwig <hch@lst.de> wrote:
>
> au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
> and callbacks in platform_data that sit under arch/mips/ and are
> always built in.  The latter than call mmc_detect_change through
> symbol_get.  Remove the use of symbol_get by requiring the driver
> to be built in.  In the future the interrupt handlers for card
> insert/eject detection should probably be moved into the main driver,
> and which point it can be built modular again.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/mips/alchemy/devboards/db1000.c |  8 +-------
>  arch/mips/alchemy/devboards/db1200.c | 19 ++-----------------
>  arch/mips/alchemy/devboards/db1300.c | 10 +---------
>  drivers/mmc/host/Kconfig             |  4 ++--
>  4 files changed, 6 insertions(+), 35 deletions(-)
>
> diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
> index 79d66faa84828d..012da042d0a4f7 100644
> --- a/arch/mips/alchemy/devboards/db1000.c
> +++ b/arch/mips/alchemy/devboards/db1000.c
> @@ -14,7 +14,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/leds.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/spi/spi.h>
> @@ -167,12 +166,7 @@ static struct platform_device db1x00_audio_dev = {
>
>  static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(500));
> -       symbol_put(mmc_detect_change);
> -
> +       mmc_detect_change(ptr, msecs_to_jiffies(500));
>         return IRQ_HANDLED;
>  }
>
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 1864eb935ca57f..76080c71a2a7b6 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -10,7 +10,6 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> -#include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/leds.h>
> @@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1200_SD0_INSERT_INT)
> @@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
>
>  static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == PB1200_SD1_INSERT_INT)
> diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
> index e70e529ddd914d..ff61901329c626 100644
> --- a/arch/mips/alchemy/devboards/db1300.c
> +++ b/arch/mips/alchemy/devboards/db1300.c
> @@ -17,7 +17,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/platnand.h>
>  #include <linux/platform_device.h>
> @@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m.  We can only be called once MMC core has
> -        * initialized the controller, so symbol_get() should always succeed.
> -        */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(200));
> -       symbol_put(mmc_detect_change);
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1300_SD1_INSERT_INT)
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 159a3e9490aed8..f7afd179dd10bf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,11 +526,11 @@ config MMC_ALCOR
>           of Alcor Micro PCI-E card reader
>
>  config MMC_AU1X
> -       tristate "Alchemy AU1XX0 MMC Card Interface support"
> +       bool "Alchemy AU1XX0 MMC Card Interface support"
>         depends on MIPS_ALCHEMY
>         help
>           This selects the AMD Alchemy(R) Multimedia card interface.
> -         If you have a Alchemy platform with a MMC slot, say Y or M here.
> +         If you have a Alchemy platform with a MMC slot, say Y here.
>
>           If unsure, say N.
>
> --
> 2.39.2
>
