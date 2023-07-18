Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C0758017
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjGROtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjGROso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:48:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F36A1998
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:48:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so53981825e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1689691711; x=1692283711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3PeHDGShv0/Y1SaTBcwWlp0DgIC2lqoORc+f/lyUag=;
        b=a8ZhbREt0uH7gJ9cBW17TnUuIeY9lua9HO/AozN0hssszX/Phmw738FVOnzPEoqKPM
         9g4ej6yAf/cuK4nEWyxjfBYtwq2t48q5q+nSJ+5OQlOzhsONtMZQnc+j6RCyZcUN1oz/
         WJHBxQoDbrIWi0QyPl72CzT34+UDqSNvbRnQbvEHLyPBKdnn5nr3RT3iXFXMDi5NLpyh
         FK1WZibGA4JoIsa4IL/UxG9P0jvEctbL10XGpyZRaKz+cEvrufbngxfwDfXOD15lMLC7
         etDDOD4GaZZtjqltQf05sbbfL2Pe45hszeZCcAgOKSgMQQVmIrrOfYsXhwu4Vt/0vXQy
         ekaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691711; x=1692283711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3PeHDGShv0/Y1SaTBcwWlp0DgIC2lqoORc+f/lyUag=;
        b=ek5VUZ0w4pzbyuROwAHi/FqP2FXWky7hRn0d6KI1mJrpouEgPdXoOOU+GcaVRhtrkm
         oHXVNcRG7Nc2etsW9RS5UYR5pkdaiK9MrGs/KnxcPcdLbkS7wJP6hZUeR3Zlkbe3TqPA
         /eMkr488z1I+V68j/n1Ksh2By88mg86tDxwo7hn9CV496f2apySIiFJ7XuH8Yn3vZQQK
         XUIsucoT32xWFLZBTjyvmFrZ66KQ3mL2R3ToULudhBgNhryQRvG2EAdttpCzcodZD+yA
         2OkPSQuOb2e9RgDE5GbBAGuoVwWB0TrbIpNc4JODQVHmwVcALl7LH3pWWKfsm6rGbybV
         3Q8g==
X-Gm-Message-State: ABy/qLbn7kH1xEWt9ZhA56httlfuSU4tNMuFhT4sOvq19FWD8wgRRtq2
        EfxbtXXWjvGkBMw688oDLXClHw==
X-Google-Smtp-Source: APBJJlH8FgksFnhHrYa/bYaQB7Lf3bViTB+cyeDz8GdO0wx0X43DqCQgnSsDAnuYgKuzpQVErJxIqg==
X-Received: by 2002:a05:600c:d5:b0:3fc:5606:c246 with SMTP id u21-20020a05600c00d500b003fc5606c246mr2052029wmm.22.1689691711290;
        Tue, 18 Jul 2023 07:48:31 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm10659329wml.18.2023.07.18.07.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:48:30 -0700 (PDT)
Message-ID: <b0bdccb7-e10e-8d8a-fb64-0d41248adf8a@tuxon.dev>
Date:   Tue, 18 Jul 2023 17:48:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/10] pinctrl: at91: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-7-andriy.shevchenko@linux.intel.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230717172821.62827-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2023 20:28, Andy Shevchenko wrote:
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pinctrl/pinctrl-at91.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 39956d821ad7..608f55c5ba5f 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1657,7 +1657,7 @@ static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
>   	return 0;
>   }
>   
> -static int __maybe_unused at91_gpio_suspend(struct device *dev)
> +static int at91_gpio_suspend(struct device *dev)
>   {
>   	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
>   	void __iomem *pio = at91_chip->regbase;
> @@ -1675,7 +1675,7 @@ static int __maybe_unused at91_gpio_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int __maybe_unused at91_gpio_resume(struct device *dev)
> +static int at91_gpio_resume(struct device *dev)
>   {
>   	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
>   	void __iomem *pio = at91_chip->regbase;
> @@ -1903,15 +1903,13 @@ static int at91_gpio_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static const struct dev_pm_ops at91_gpio_pm_ops = {
> -	NOIRQ_SYSTEM_SLEEP_PM_OPS(at91_gpio_suspend, at91_gpio_resume)
> -};
> +static DEFINE_NOIRQ_DEV_PM_OPS(at91_gpio_pm_ops, at91_gpio_suspend, at91_gpio_resume);
>   
>   static struct platform_driver at91_gpio_driver = {
>   	.driver = {
>   		.name = "gpio-at91",
>   		.of_match_table = at91_gpio_of_match,
> -		.pm = pm_ptr(&at91_gpio_pm_ops),
> +		.pm = pm_sleep_ptr(&at91_gpio_pm_ops),
>   	},
>   	.probe = at91_gpio_probe,
>   };
