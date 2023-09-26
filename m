Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA57AED0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjIZMlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjIZMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:41:28 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B310A;
        Tue, 26 Sep 2023 05:41:22 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34deefc2016so25189445ab.2;
        Tue, 26 Sep 2023 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732081; x=1696336881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFH4UUFDGK0s+fchU0DAK9Uwv9kWi/10rg3EOpapn18=;
        b=Duhmbpj07pHnjaLNqS8RhaAKrDEMcBCXf4Frn9yRMyIeFqeluFXJx2R0gUjgZio4LB
         LcTs7RPZVt7TLnol8lTCZaw3jwGjnovP0LjpeMRL4pDfxEE4BajBI47TMjmiAGj9JMD9
         3VoFpfigpMos7JP+F8A48yInTZdH52UXjzxaKXrQcO8BMtw767MM3ACWn6zoVMb/KYAT
         ZtKJlPai0vwoCO3R50RuCHQTbmF7gQ0KuEn9Bp62ndAdcilMxfIZyHifOFYsKldoaak0
         xHmhLLvKB/D8rchbQ6fV7B4VWNSzoQvvCmPRSkOxcZ82mQbRZ5cey1MjTu7Vg8lKVMcD
         NVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732081; x=1696336881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFH4UUFDGK0s+fchU0DAK9Uwv9kWi/10rg3EOpapn18=;
        b=Znqoz/6G0rQsjO3I1Ly2r8QSZ5hXOyt/CLBz9oHJNKAhrteBDjDP2sYt9j4cbc98th
         eI5enxgY+Z//H0yDoDjj2y2J4h/pEVzVuMPaX7HX4TW8chFWz58Wh28G2ABSr5VoB50i
         jAZ+R9INzFJjJ3nYxJTPilulicXvIWHbSFkDXv9Jr9FG4jdVxrGEX69AyOVIoOoZ1BtS
         kZnCoxenciwLh6IsuIRqOtje4pETq/l/e87mmAb2ybwzJcOoGzth5ip8LfszosKFbWtD
         zI/T5RhwrZDHWs6jiHVMXjE0gHOhh1BH2iG6zPG4s6MnwZVLx3CFrBzBmcnCf758XXoc
         uC6A==
X-Gm-Message-State: AOJu0Yy0m2Lhk3y1ILI5NJ6GYUN+OMkJxrvwXl9Q5YH2cAXj9/9WMb+R
        qK5/E7K51MxYfhugnxk7aik=
X-Google-Smtp-Source: AGHT+IFoaKbI98CJWnRbXXEp2j4ZyVdE7Fx11AUN6r6lsypvLcFyBL7AL6HXW4Ap7C41/wAB+zbItQ==
X-Received: by 2002:a05:6e02:1a8e:b0:34f:77bc:8d49 with SMTP id k14-20020a056e021a8e00b0034f77bc8d49mr11982732ilv.23.1695732081170;
        Tue, 26 Sep 2023 05:41:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id do25-20020a0566384c9900b0042b1a9f8480sm3207749jab.35.2023.09.26.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:41:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Sep 2023 05:41:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: ixp4xx: Make sure restart always works
Message-ID: <eb1e31b2-272b-4ebd-a0cc-b627faa9c65b@roeck-us.net>
References: <20230926-ixp4xx-wdt-restart-v2-1-15cf4639b423@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926-ixp4xx-wdt-restart-v2-1-15cf4639b423@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:13:44AM +0200, Linus Walleij wrote:
> The IXP4xx watchdog in early "A0" silicon is unreliable and
> cannot be registered, however for some systems such as the
> USRobotics USR8200 the watchdog is the only restart option,
> so implement a "dummy" watchdog that can only support restart
> in this case.
> 
> Fixes: 1aea522809e6 ("watchdog: ixp4xx: Implement restart")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - Switch debugprint about only supporting restart from dev_err()
>   to dev_info().
> - Link to v1: https://lore.kernel.org/r/20230925-ixp4xx-wdt-restart-v1-1-fe2b9b131dbf@linaro.org
> ---
>  drivers/watchdog/ixp4xx_wdt.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
> index 607ce4b8df57..ec0c08652ec2 100644
> --- a/drivers/watchdog/ixp4xx_wdt.c
> +++ b/drivers/watchdog/ixp4xx_wdt.c
> @@ -105,6 +105,25 @@ static const struct watchdog_ops ixp4xx_wdt_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +/*
> + * The A0 version of the IXP422 had a bug in the watchdog making
> + * is useless, but we still need to use it to restart the system
> + * as it is the only way, so in this special case we register a
> + * "dummy" watchdog that doesn't really work, but will support
> + * the restart operation.
> + */
> +static int ixp4xx_wdt_dummy(struct watchdog_device *wdd)
> +{
> +	return 0;
> +}
> +
> +static const struct watchdog_ops ixp4xx_wdt_restart_only_ops = {
> +	.start = ixp4xx_wdt_dummy,
> +	.stop = ixp4xx_wdt_dummy,
> +	.restart = ixp4xx_wdt_restart,
> +	.owner = THIS_MODULE,
> +};
> +
>  static const struct watchdog_info ixp4xx_wdt_info = {
>  	.options = WDIOF_KEEPALIVEPING
>  		| WDIOF_MAGICCLOSE
> @@ -114,14 +133,17 @@ static const struct watchdog_info ixp4xx_wdt_info = {
>  
>  static int ixp4xx_wdt_probe(struct platform_device *pdev)
>  {
> +	static const struct watchdog_ops *iwdt_ops;
>  	struct device *dev = &pdev->dev;
>  	struct ixp4xx_wdt *iwdt;
>  	struct clk *clk;
>  	int ret;
>  
>  	if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
> -		dev_err(dev, "Rev. A0 IXP42x CPU detected - watchdog disabled\n");
> -		return -ENODEV;
> +		dev_info(dev, "Rev. A0 IXP42x CPU detected - only restart supported\n");
> +		iwdt_ops = &ixp4xx_wdt_restart_only_ops;
> +	} else {
> +		iwdt_ops = &ixp4xx_wdt_ops;
>  	}
>  
>  	iwdt = devm_kzalloc(dev, sizeof(*iwdt), GFP_KERNEL);
> @@ -141,7 +163,7 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
>  		iwdt->rate = IXP4XX_TIMER_FREQ;
>  
>  	iwdt->wdd.info = &ixp4xx_wdt_info;
> -	iwdt->wdd.ops = &ixp4xx_wdt_ops;
> +	iwdt->wdd.ops = iwdt_ops;
>  	iwdt->wdd.min_timeout = 1;
>  	iwdt->wdd.max_timeout = U32_MAX / iwdt->rate;
>  	iwdt->wdd.parent = dev;
> 
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230924-ixp4xx-wdt-restart-d6bf28493173
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 
