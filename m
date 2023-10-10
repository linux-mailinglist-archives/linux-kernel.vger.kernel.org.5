Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4065B7BFD99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjJJNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjJJNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:35:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0292E6;
        Tue, 10 Oct 2023 06:35:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c63164a2b6so49318605ad.0;
        Tue, 10 Oct 2023 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696944927; x=1697549727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHLDfXtxyGaUv3XXenlR1vVP+uZsDR7fcvOl6PBIf54=;
        b=lRhLobZnOxSo4ma7raN3QNdLwG9Y0hwsgkdlR9TJKz68Q3EXzZa1aj79UlyFkccV6h
         wNHn1x0oPIzRXCLZLYQJfGr9DTwxGFX2M9wTcuRB+ZM+rNLyZjLE/NMyufPD7AaB3RB0
         lvH360stZARX+szehyeu4D3z4Q+LLl2/OXvAhDRuo+TOnyKOvpAE4pEuRyTK6hauZJCS
         Hal4Pvur5YKVJRaeUUQLLGIP5czgjhQfogzWa62rVRCrWWPrO27ArSIfmHjkBremVYQn
         WFixvwp5kZuYhHSZpFhLJKtZxfsRKH7XyNPW+f6fejHev1N77aVz23J2H8X3zr2X1+XE
         v8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944927; x=1697549727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHLDfXtxyGaUv3XXenlR1vVP+uZsDR7fcvOl6PBIf54=;
        b=N2LuKj9tUaUU2R8ClOhPHND0sUfGhVJbGMi7du05GQfX04jEg3Rh5XG16cNxeeVoP0
         HlrD/T6dLV2ljELDaEtuh0QXINVrqqsS+xw73mwSdhcMUfXe7br3JuxHhDvHRLxE3NoI
         HYL6xboN3DtqVFhbOZ+yxnCsbfUY107Gkkzb44RwYHi3So4CXQRifnB4kx+44/9BYauq
         TfAdF/QU36ZAluC6YGlu+kT0SgUeUv1qOwbV3gi3tTDulYwqxH+cgboIpDJbGgiYhfuY
         HajFQZyNfMBjIaWGJvf/7Zu1cAW5DfQD9UEZ8lMOI1S2yz04l9xh2lIjTjaPFWIb50zY
         5iTQ==
X-Gm-Message-State: AOJu0Yzz46UlYacbdUezMckkZdvk4WY+DCl4aXRpWG5AMoxjibHXJcQY
        x01Za1MRG+pZTg7pAIat25SL7JW+xQk=
X-Google-Smtp-Source: AGHT+IF+h/dNgRzdSb7qR5hGuHp56Tqltxlew00GLSvqHTyWo62d5G5PqUNn27vHeBQwvs7nSLW2Eg==
X-Received: by 2002:a17:903:1c6:b0:1c5:9d00:be84 with SMTP id e6-20020a17090301c600b001c59d00be84mr22977315plh.33.1696944927040;
        Tue, 10 Oct 2023 06:35:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c21100b001bbc8d65de0sm1531321pll.67.2023.10.10.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:35:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 06:35:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: st_lpc: Use device_get_match_data()
Message-ID: <d8e0403e-503a-4c85-b50e-eee48db68c89@roeck-us.net>
References: <20231009211356.3242037-18-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009211356.3242037-18-robh@kernel.org>
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

On Mon, Oct 09, 2023 at 04:13:48PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/st_lpc_wdt.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index d2aa43c00221..4c5b8d98a4f3 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -15,7 +15,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
> @@ -42,7 +41,7 @@ struct st_wdog {
>  	void __iomem *base;
>  	struct device *dev;
>  	struct regmap *regmap;
> -	struct st_wdog_syscfg *syscfg;
> +	const struct st_wdog_syscfg *syscfg;
>  	struct clk *clk;
>  	unsigned long clkrate;
>  	bool warm_reset;
> @@ -150,7 +149,6 @@ static void st_clk_disable_unprepare(void *data)
>  static int st_wdog_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
>  	struct device_node *np = dev->of_node;
>  	struct st_wdog *st_wdog;
>  	struct regmap *regmap;
> @@ -173,12 +171,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>  	if (!st_wdog)
>  		return -ENOMEM;
>  
> -	match = of_match_device(st_wdog_match, dev);
> -	if (!match) {
> -		dev_err(dev, "Couldn't match device\n");
> -		return -ENODEV;
> -	}
> -	st_wdog->syscfg	= (struct st_wdog_syscfg *)match->data;
> +	st_wdog->syscfg	= (struct st_wdog_syscfg *)device_get_match_data(dev);
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
> -- 
> 2.42.0
> 
