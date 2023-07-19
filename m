Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD95759805
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGSOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGSOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:19:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CED3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:19:22 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 540FA3F721
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689776359;
        bh=GQssMG4sr5GfDopggRQSgpxYtYsDKGG3T/Izx89s/GE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kLnO9KgSxuoBAXPoIrbV3r6dACuF99vODNb4FiTam2yTl08ldlX20EQ9m7/m3hOBD
         Pez7rBxrzwTNBdhUR+m3fOEHh1vnqjZrVHceXg3ole6aWSHrzHuAZHC9Rh85XERyB0
         OvuZePXRjoMcuhKhMbGbfk5akMC8lnbgfzJt4opGoTVu8xTv7w/UovZuweCCW7fNmV
         Ju5Mk/VSNGf/FbqqLZC2RWGnriOLukhg4Dsb9r5eXk2KXnMs7Ytg9BPAg60HkpmHXY
         JvGqrVen7GmaTocsYtbRb84Ma2GXKb8z7HXhNsdmL+53qLGRUNykUb6NBEHLVUD+Ek
         dzaHOEYs+AvLw==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403fc19a7a7so18602931cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776355; x=1690381155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQssMG4sr5GfDopggRQSgpxYtYsDKGG3T/Izx89s/GE=;
        b=TXw8aG0IhE0GNaPnj8E9BSfWA+5G/yfjCbmHzomdoqacukHggkguyVCqF8OAVYz+CN
         doU87uSKKf88IKNkCyZH/Dwc6uWzgiIN/s3U5Wi2vmZWcUobaJNBIKPx/unkIYpwyy+n
         4d7e8wpMZZamcRjWAcnUmxzDC6wXERqq11v6PVGWLEE8FXyg3jcZSOpiisJpM/qTPI8Z
         DscQUyrOuFAezXkbn2KIQlAVnxWBQWn9Jbh+mPEj7G7LYIV90cvaZNRQOWrG7tuPDYl+
         z1XcA2WWmSoO/Rwhglzw5AcJq0qLnDFamzr53xfUqjiRACq9Ik1HGH15zuqKU1ToLRKi
         DZ6w==
X-Gm-Message-State: ABy/qLaPlFHuuuf3WXyOziNWGj273iMN/X5u0kGc+m1OD248pV9nu7nn
        tGCkqoOlyl6L+JXzjSc2LShO0sfKoIWtlKrTVTra+QowqKybu9oll4uJww0gSd0v/dUhtr+YMlz
        I0JV+AUmzRsOUPBU4mTogYYkkcJE4Rcsi6tgiiXaZiTJtSyCSnSGEb0FiqQ==
X-Received: by 2002:a05:622a:1043:b0:403:e841:58cf with SMTP id f3-20020a05622a104300b00403e84158cfmr7250705qte.10.1689776355281;
        Wed, 19 Jul 2023 07:19:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF6ArzibyjU/HIAo8zVRkK4K5uiAaxY67dwKUBWu+e77t8a+bRUMd76ruBG00lvDGu4BDbxlfoFwop3e5WhMrI=
X-Received: by 2002:a05:622a:1043:b0:403:e841:58cf with SMTP id
 f3-20020a05622a104300b00403e84158cfmr7250684qte.10.1689776355066; Wed, 19 Jul
 2023 07:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230717210356.2794736-1-samuel.holland@sifive.com> <20230717210356.2794736-2-samuel.holland@sifive.com>
In-Reply-To: <20230717210356.2794736-2-samuel.holland@sifive.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 19 Jul 2023 16:18:59 +0200
Message-ID: <CAJM55Z9B6atT_t4321kOCGWoeqLxe+ZBsJDr4BeV1byaeYw5fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: sifive: Allow building the driver as a module
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 10:07, Samuel Holland <samuel.holland@sifive.com> wrote:
>
> This can reduce the kernel image size in multiplatform configurations.

I don't mind this, but booting without this driver also means there is
no uart for debug output or any other peripheral until the kernel gets
to the initrd to load the driver. Does the earlycon console work all
the way until we reach the initrd? Otherwise I can't imagine many
scenarios where configuring this as a module is desirable.

> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/clk/sifive/Kconfig       | 2 +-
>  drivers/clk/sifive/sifive-prci.c | 8 +++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
> index 2322f634a910..49597d95602e 100644
> --- a/drivers/clk/sifive/Kconfig
> +++ b/drivers/clk/sifive/Kconfig
> @@ -10,7 +10,7 @@ menuconfig CLK_SIFIVE
>  if CLK_SIFIVE
>
>  config CLK_SIFIVE_PRCI
> -       bool "PRCI driver for SiFive SoCs"
> +       tristate "PRCI driver for SiFive SoCs"
>         default ARCH_SIFIVE
>         select RESET_CONTROLLER
>         select RESET_SIMPLE
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index e317f3454e93..8c67d1a7c8df 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -7,6 +7,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
>  #include "sifive-prci.h"
>  #include "fu540-prci.h"
> @@ -618,9 +619,6 @@ static struct platform_driver sifive_prci_driver = {
>         },
>         .probe = sifive_prci_probe,
>  };
> +module_platform_driver(sifive_prci_driver);
>
> -static int __init sifive_prci_init(void)
> -{
> -       return platform_driver_register(&sifive_prci_driver);
> -}
> -core_initcall(sifive_prci_init);

Maybe also add the MODULE_AUTHOR() and MODULE_DESCRIPTION() macros
while you're at it.

> +MODULE_LICENSE("GPL");
> --
> 2.40.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
