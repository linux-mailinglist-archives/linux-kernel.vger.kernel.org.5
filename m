Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C1C7597D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGSOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGSOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:12:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F89610B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:12:50 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F51D3F20D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689775967;
        bh=fTUvgetUaqT3wHGPq5i4Fev7+8uAQkZMBnoHSdm3l3w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YO80lpqG0A4vA4ZBUJtRcedkWFRu0+cz/UmcUipFJpLW2HbO31wCSL9cgvYuxRuOt
         MO7zV8bbR7eBUzAr2GDu33XcycsRr3CVkz5HqlWq+SXccD29gHL/W3N23kbWwupCWB
         bZycLLMpWhJp4J+/99n43pWes2SnqAGclu9mWpwCxxjSLl7fVJ9BIkfYpeLb3w+iYx
         aODv30bsKJxViZArfXSH8yeND8ComojwzJRPFqd2W3eEjzTNLU1uggT/vdo9d9Vw7J
         WCMRFa36DEI4pC00wykmi3QZVVAMYENLt7sf35HlEn/iQBSr0ByVScy5JgLAgvAU56
         GlUqQL21YoIKw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403c7ffd25eso75057001cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689775965; x=1690380765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTUvgetUaqT3wHGPq5i4Fev7+8uAQkZMBnoHSdm3l3w=;
        b=G9jBXGHJgA1onXzVHhXp3IkWcDi/dXHcUUNwST8nyU2PM0x8J6hO6xg5eqGf1RVpLd
         5PotcwFG4ZNJA1h5T2bOp5ai2Cnp/dfsLoxmCuqD8N82ev/54h5a0ayci4eQxDuR8+qr
         raC2+7OmTSIpngUDnwNroFSlIEUHKTHh+s9LhPN5QOSqkGgcgnCaJd0wIDjeH7J1C1OQ
         EvFu6bvt9iWrNEWk5ybYfMQcNlmGtIcO0hYqu7m1QdPBrH61z6SQaIQ/w1fzge4dLgE7
         DmCqfqe2bqZtaWg2K/4orkgi6a6yZOeqVkfEIRDnXLfwrPb2zxWDccigWJua4KJl3kRw
         uv7w==
X-Gm-Message-State: ABy/qLbeh6SVQZwOS4X3L5UVz8vJ3RuR8UnOb8YwgZZjWhJS7Ue/5abL
        e29xGdMV8wSICbYIvVQ6KqCxukss4cDrAg07uSk6+ti0C8/by4Y2blGTu3Y7kUYYMTo5PkV7PbS
        EurVi236ePRbnKEevKWdnqamF/eUMyVZqwEdYIMYMvLNn9FNxxfDk1CLNMA==
X-Received: by 2002:ac8:5a82:0:b0:3f9:cb01:9dae with SMTP id c2-20020ac85a82000000b003f9cb019daemr21215436qtc.50.1689775965101;
        Wed, 19 Jul 2023 07:12:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyqJAW0YcwGXzwaqtO+haPvbXa6TVCnEWDq/UNmAT5PINh4LZDlSHEpJIERRJmT2R7L69By/E3f/BC3H9q+ls=
X-Received: by 2002:ac8:5a82:0:b0:3f9:cb01:9dae with SMTP id
 c2-20020ac85a82000000b003f9cb019daemr21215415qtc.50.1689775964905; Wed, 19
 Jul 2023 07:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230717205357.2779473-1-samuel.holland@sifive.com> <20230717205357.2779473-3-samuel.holland@sifive.com>
In-Reply-To: <20230717205357.2779473-3-samuel.holland@sifive.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 19 Jul 2023 16:12:28 +0200
Message-ID: <CAJM55Z8Q-kGFKhFc57_Ew+0VsmBqwLrBAaiaiJ5zYdu_OG-wMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sifive: Allow building the driver as a module
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, 19 Jul 2023 at 08:26, Samuel Holland <samuel.holland@sifive.com> wrote:
>
> This can reduce the kernel image size in multiplatform configurations.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/gpio/Kconfig       | 2 +-
>  drivers/gpio/gpio-sifive.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index e382dfebad7c..1a8e8a8c85d6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -564,7 +564,7 @@ config GPIO_SAMA5D2_PIOBU
>           maintain their value during backup/self-refresh.
>
>  config GPIO_SIFIVE
> -       bool "SiFive GPIO support"
> +       tristate "SiFive GPIO support"
>         depends on OF_GPIO
>         select IRQ_DOMAIN_HIERARCHY
>         select GPIO_GENERIC
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 745e5f67254e..5941a817491c 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -277,4 +277,6 @@ static struct platform_driver sifive_gpio_driver = {
>                 .of_match_table = sifive_gpio_match,
>         },
>  };
> -builtin_platform_driver(sifive_gpio_driver)
> +module_platform_driver(sifive_gpio_driver)
> +

While you're at it maybe also add the MODULE_AUTHOR() and
MODULE_DESCRIPTION() macros.

> +MODULE_LICENSE("GPL");
> --
> 2.40.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
