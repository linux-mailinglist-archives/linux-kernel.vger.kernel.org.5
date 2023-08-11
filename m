Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757DB77943F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHKQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHKQVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:21:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A12728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:21:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0c566788so3390742e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691770906; x=1692375706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLDri0jvZJfj7mGD0JyPOhugI1LYfhwOtVS/jje4bxA=;
        b=K9rMRoupby6QdTPnm22QVt5NzSt/YP/r9okFLwJvRrhVXZiqVNOZ1dq8TnOucVQjBW
         lAZcluiy5zc+y1mRQXUXdv/ndVf8KB7Mdr2PGu3vpxQA1XwTTlI1bfPwLRcfsHUHXMK0
         kUUg0PODHCklG9X/zmHpTtiwGUG0zOwfdHujTA0BSZlkxmo5n2ngFpMLQTJ9kcRcA7sc
         8lT3N55G/tdwV7smH6BUcXFXaGqGQRY7MrhTv3dq36NgMTjNWEUAmFRuJ3/TjPpSomnr
         2zlykM+XnorW9sQvww2yWd9mTPC5DJJjPGcUkbf4Q/t5roooiXHnj+pJ4Ju+u8pF6L9W
         s4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770906; x=1692375706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLDri0jvZJfj7mGD0JyPOhugI1LYfhwOtVS/jje4bxA=;
        b=koL3HLDPAPocudqgQXIaPggRzed2bfJq9GVctold9xyt8vwC2qJ3bTf/L9GlsZadg7
         Pvs+xhppDSn3AY53IFm085rpDU8O0ljIBYnRidIsfFL1WrAKfHUXWArrvn69uDxrwDJ4
         cPxbPtlVL+GTV7N3pGJHx0x+ZMy1gxyrmA10VlXzfJ2ZXsEXFZvZBA2l5DatkuyQWQLL
         GbEcMKEDgBiXV7O5TPYLykFmnBEX3Qyi/O9pg2kT+CBvkbGLIE8pgtUAeqeK0PntYMYO
         2QkT3VjOZl+qQR6mlgrgrFaSEFPNzYEFkC7Rdm0Pmd74aMiXukK9DeCpBSA3OfBKVMPW
         VXFQ==
X-Gm-Message-State: AOJu0YyUIzrdvgLYl4foG1dNWCfnWH9q2hkSARwQwfsh5NPnuAf/V9LI
        pYg4Qcj338D1EIa3i/ojk/A=
X-Google-Smtp-Source: AGHT+IGuQWDDOMFGid/bM+iY6jyj/AI00a6xZWHcx+lJToKGyKs2rPO2yFJtbfVUKprVCx1jF1zukg==
X-Received: by 2002:a05:6512:39d3:b0:4fe:5860:7abe with SMTP id k19-20020a05651239d300b004fe58607abemr2218937lfu.7.1691770905786;
        Fri, 11 Aug 2023 09:21:45 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id q17-20020ac246f1000000b004fe5608e412sm780128lfo.170.2023.08.11.09.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:21:45 -0700 (PDT)
Message-ID: <cd5d39a2-4f4c-419a-8137-d2719135e205@gmail.com>
Date:   Fri, 11 Aug 2023 19:23:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/bridge: tc358768: Fix bit updates
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
 <20230804-tc358768-v1-2-1afd44b7826b@ideasonboard.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230804-tc358768-v1-2-1afd44b7826b@ideasonboard.com>
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
> The driver has a few places where it does:
> 
> if (thing_is_enabled_in_config)
> 	update_thing_bit_in_hw()
> 
> This means that if the thing is _not_ enabled, the bit never gets
> cleared. This affects the h/vsyncs and continuous DSI clock bits.

I guess the idea was to keep the reset value unless it needs to be flipped.

> 
> Fix the driver to always update the bit.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index bc97a837955b..b668f77673c3 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -794,8 +794,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  		val |= BIT(i + 1);
>  	tc358768_write(priv, TC358768_HSTXVREGEN, val);
>  
> -	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
> -		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
> +	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
> +		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
>  
>  	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>  	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
> @@ -861,11 +861,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>  	tc358768_write(priv, TC358768_DSI_HACT, hact);
>  
>  	/* VSYNC polarity */
> -	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
> -		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
> +	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
> +			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);

Was this the reverse before and should be:
(mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : BIT(5)

> +
>  	/* HSYNC polarity */
> -	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> -		tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0), BIT(0));
> +	tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0),
> +			     (mode->flags & DRM_MODE_FLAG_PHSYNC) ? BIT(0) : 0);
>  
>  	/* Start DSI Tx */
>  	tc358768_write(priv, TC358768_DSI_START, 0x1);
> 

-- 
Péter
