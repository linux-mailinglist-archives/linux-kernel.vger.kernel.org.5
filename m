Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F0779490
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjHKQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:29:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2A109
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:29:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe7e1ef45dso3475095e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691771377; x=1692376177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbKVVoKe9lHcyRo4G8rW0bpG63v+YaiDvH2/j+9t1mI=;
        b=SbAG2zKZSMMoEpRYns/zRlmuufpAnNqHQGewndCVdfcVCr4uhxup4n9UumeVFIwqXY
         Amx8twMOA8+6bQhEk+DJpN1SJrdq4z8gLX3mhUmPr5KjcMmbRoWAJlhD+tbu6y6/Q0mW
         2SwxiANcpcVG2qOhL9ZeQBK5/C/xQ3y77YRk8fC5MWAeRwuJZXOrRJxlRnZT1pV8qZeB
         JRaDONxCMRDtJRopqnfJTK81yRBs85W3ODsecpT0mOJyg7RWqWOhQ0CR9UWaCSWSVUUS
         OwJShiyp6F/Km0029weOZdsHJTtfrjAMsf2qX6pQn/wjaap8FfuFXmOzuohc9lyLgm+Q
         wfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771377; x=1692376177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbKVVoKe9lHcyRo4G8rW0bpG63v+YaiDvH2/j+9t1mI=;
        b=aePH5qLYzfRoKeUI7nejC+QINHSSz66X5sEm8wXWlEG9cyT/mj2wKgV4nqQeuGjL/0
         zAh8fQMDJQUiu0oIN+r20+UFXi4peMMewAZum8gEUKI212otT5JS44e3sqtIQ4SN9WyK
         pzxcjWreTcDxtz/AUC91Ex7yE/CzXhxySNXLsM99W8kBQy+mZjyq6uUB/DkARTbbtW0L
         GfiDx4hFJm9RIVWgz3REoUILHDKT9UwA6K9ShNt9zOrkRxnC1i49i2n2BQfvurtPu9jn
         bKIQ2VXatyKV8Gra9/chS53r0PnaQhBrPEHfL82YWItiqpzX1RRL110GpT914vzyhJPe
         cT6g==
X-Gm-Message-State: AOJu0YwiGkAqehmlXfcmu/HdwJ2nAZYAwbQuq7ydXA425Tz4t1UTzKBk
        blCszqZn2V1DF5aYJx4B6NI=
X-Google-Smtp-Source: AGHT+IF+1Fy++yU+PI4XAoVkFXGJbBZoVEDN/KP3rXNDgmjv6ZKNGYZvlyGomVg5KFlM+OJTLhhNAQ==
X-Received: by 2002:a05:6512:203c:b0:4fd:fabf:b923 with SMTP id s28-20020a056512203c00b004fdfabfb923mr1646459lfs.14.1691771376530;
        Fri, 11 Aug 2023 09:29:36 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id a5-20020a19f805000000b004fb9536bc99sm778839lff.169.2023.08.11.09.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:29:36 -0700 (PDT)
Message-ID: <e74e055d-b3df-4ac9-aef6-8b07b2062a7f@gmail.com>
Date:   Fri, 11 Aug 2023 19:31:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/bridge: tc358768: Print logical values, not raw
 register values
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-5-1afd44b7826b@ideasonboard.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230804-tc358768-v1-5-1afd44b7826b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2023 13:44, Tomi Valkeinen wrote:
> The driver debug prints DSI related timings as raw register values in
> hex. It is much more useful to see the "logical" value of the timing,
> not the register value.

I'm a bit confused by the term 'logical' value, I think you meant
decimal, easier to read by humans numbers.

> Change the prints to print the values separately, in case a single
> register contains multiple values, and use %u to have it in a more human
> consumable form.

But, yes, decimal is better for the dmesg, as I recall I had a tool
which was using hex numbers so it was better to have the prints also in hex.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 9b633038af33..0ef51d04bb21 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -739,57 +739,59 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  
>  	/* LP11 > 100us for D-PHY Rx Init */
>  	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
> -	dev_dbg(priv->dev, "LINEINITCNT: 0x%x\n", val);
> +	dev_dbg(priv->dev, "LINEINITCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_LINEINITCNT, val);
>  
>  	/* LPTimeCnt > 50ns */
>  	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
>  	lptxcnt = val;
> -	dev_dbg(priv->dev, "LPTXTIMECNT: 0x%x\n", val);
> +	dev_dbg(priv->dev, "LPTXTIMECNT: %u\n", val);
>  	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
>  
>  	/* 38ns < TCLK_PREPARE < 95ns */
>  	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
> +	dev_dbg(priv->dev, "TCLK_PREPARECNT %u\n", val);
>  	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
>  	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
>  				  dsibclk_nsk) - 2;
> +	dev_dbg(priv->dev, "TCLK_ZEROCNT %u\n", val2);
>  	val |= val2 << 8;
> -	dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
>  	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
>  
>  	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
>  	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
>  	val = clamp(raw_val, 0, 127);
> -	dev_dbg(priv->dev, "TCLK_TRAILCNT: 0x%x\n", val);
> +	dev_dbg(priv->dev, "TCLK_TRAILCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
>  
>  	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
>  	val = 50 + tc358768_to_ns(4 * ui_nsk);
>  	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
> +	dev_dbg(priv->dev, "THS_PREPARECNT %u\n", val);
>  	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
>  	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
>  	val2 = clamp(raw_val, 0, 127);
> +	dev_dbg(priv->dev, "THS_ZEROCNT %u\n", val2);
>  	val |= val2 << 8;
> -	dev_dbg(priv->dev, "THS_HEADERCNT: 0x%x\n", val);
>  	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
>  
>  	/* TWAKEUP > 1ms in lptxcnt steps */
>  	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
>  	val = val / (lptxcnt + 1) - 1;
> -	dev_dbg(priv->dev, "TWAKEUP: 0x%x\n", val);
> +	dev_dbg(priv->dev, "TWAKEUP: %u\n", val);
>  	tc358768_write(priv, TC358768_TWAKEUP, val);
>  
>  	/* TCLK_POSTCNT > 60ns + 52*UI */
>  	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
>  				 dsibclk_nsk) - 3;
> -	dev_dbg(priv->dev, "TCLK_POSTCNT: 0x%x\n", val);
> +	dev_dbg(priv->dev, "TCLK_POSTCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
>  
>  	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
>  	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
>  				     dsibclk_nsk) - 4;
>  	val = clamp(raw_val, 0, 15);
> -	dev_dbg(priv->dev, "THS_TRAILCNT: 0x%x\n", val);
> +	dev_dbg(priv->dev, "THS_TRAILCNT: %u\n", val);
>  	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
>  
>  	val = BIT(0);
> @@ -803,10 +805,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>  	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
>  	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
> +	dev_dbg(priv->dev, "TXTAGOCNT: %u\n", val);
>  	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
>  				  dsibclk_nsk) - 2;
> +	dev_dbg(priv->dev, "RXTASURECNT: %u\n", val2);
>  	val = val << 16 | val2;
> -	dev_dbg(priv->dev, "BTACNTRL1: 0x%x\n", val);
>  	tc358768_write(priv, TC358768_BTACNTRL1, val);
>  
>  	/* START[0] */
> 

-- 
Péter
