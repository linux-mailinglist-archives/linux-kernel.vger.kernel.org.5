Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBE78197A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHSMLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjHSMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:11:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830722408E;
        Sat, 19 Aug 2023 05:09:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc87ded50so12859895ad.1;
        Sat, 19 Aug 2023 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692446960; x=1693051760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCcTJ6Tm7LuQQrCoSymLgiPyZVV3vddfh8DXO175zX4=;
        b=aOhkAVOGIRygHZ5n9XjRV/xznCr6Ow3FVuntPCw3uV7272Ww+LBOHkPNptdFTsJF22
         /vhrkUNxdo9D3Q9kYgTZtWrtc3gllfJGQ+XBZNCwrz2/G0XGL41xhFj0ALXueBBVPcHZ
         4adf836ke8Cc5aNJq6jNcq/79eOBjj4Jy4FclW/Vrn69xNss6+QkV10IJfxl2FuL77d2
         HXFToL0oVvbcnttmWGXEAqYb+wl8C4cTkY3dZbbC7HTg+CNnAr0rboRZ5XUyG7TyNpFF
         8gdI+r2Wv9uZ5TyJ+lMmQcd7ufzxUkesqknWoiMepkFl2eDZp9hB5xWMSXSS9mAIFXUX
         KN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692446960; x=1693051760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCcTJ6Tm7LuQQrCoSymLgiPyZVV3vddfh8DXO175zX4=;
        b=kUoCgRCKS2ZW/9d6M2HJouT6a+Cq4jcY3qI2LJRKfkikgiAOd7TVKU+oE72aI3VHOI
         Vl6tg4qJAAlrpQwH6TAw24eDGUWGYZ5UKTRsduVlI2U17CHSIHwTvQ7k8eBH/TP2ATJr
         GiFyZQAilTnjWwKTm9P3tG+ARmD/8NIlakVHFaV0e5MuRy9bhr4CzHQJSzc7Nwo9ZRkO
         oiE+Oqaib6huCWDqF2IhsFrtLn/kYZU5tQF0qzfD/VtH5Av8cb+evt0qyFmnncvcI8NO
         k2gmjLAde0WfFkpDeG9EveKljudAA6kOo0gRRikfrU0QgcLy/MAOnamJNS0fyGfSF+Mj
         7yyg==
X-Gm-Message-State: AOJu0Yxj5wbASDdMNuglXiEdMTH8vrJ1PV8N5x2A3QMhC5ycRCoa0X3h
        GESQAXxacbu3IBUK2PcytjE=
X-Google-Smtp-Source: AGHT+IEl5OnZZn6MUTEd7rT34iadzdi4h+2cN4RhW414axiB6l5c8YBOhZ0f5YsreCs7rOjjRiF8dg==
X-Received: by 2002:a17:902:f805:b0:1bb:d045:ae8 with SMTP id ix5-20020a170902f80500b001bbd0450ae8mr1406460plb.7.1692446959628;
        Sat, 19 Aug 2023 05:09:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b001b8b6a19bd6sm3518651pll.63.2023.08.19.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 05:09:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Aug 2023 05:09:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mathieu Othacehe <othacehe@gnu.org>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, wim@linux-watchdog.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sama5d4: readout initial state
Message-ID: <1cceb853-a844-494a-9f87-bf81159cb6ea@roeck-us.net>
References: <20230819084726.11037-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819084726.11037-1-othacehe@gnu.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 10:47:26AM +0200, Mathieu Othacehe wrote:
> Readout the AT91_WDT_MR bit at probe so that it becomes possible to get the
> pre-userspace handler working.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sama5d4_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index aeee934ca51b..7d31bb6f6204 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -255,6 +255,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  	struct sama5d4_wdt *wdt;
>  	void __iomem *regs;
>  	u32 irq = 0;
> +	u32 reg;
>  	int ret;
>  
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> @@ -305,6 +306,12 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  
>  	watchdog_init_timeout(wdd, wdt_timeout, dev);
>  
> +	reg = wdt_read(wdt, AT91_WDT_MR);
> +	if (!(reg & AT91_WDT_WDDIS)) {
> +		wdt->mr &= ~AT91_WDT_WDDIS;
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +	}
> +
>  	ret = sama5d4_wdt_init(wdt);
>  	if (ret)
>  		return ret;
> -- 
> 2.41.0
> 
