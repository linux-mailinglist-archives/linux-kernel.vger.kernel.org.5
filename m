Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7461B76FC30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjHDIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHDIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:41:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231B30F3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:41:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso28743111fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138474; x=1691743274;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gHVgXi4q0hNplY5PHR/UwxCfsuZxoF70UBwiGy6j+e8=;
        b=ZUqbnW9+MXEVtqhnWj72R4EET8RBzi9yS3QZIKqVcTyA/U5yg64QSRrlsmKexvxIED
         ZnPmJhsZGWDb27QDfII36bmfhP2INMt9U61y1BLBqAy6r2E3f15PUCGhgbmo4Gp6Hozj
         PY8OpLmvZVMgBYTlqP1alMBbazFj+bNATV3itMg0Wny44kSTR1CZb5pmwcgfumc18rG2
         ORKjxDizsrnIolxCNzVBGPv2tXrwYjLasSXeITA3WLU4s+PXpyd2ATwfve2DNbaLkMA8
         zj3LOSNMz+jFAoPULd2tm/3w4GFjT92C9fA4tuzXSi6onXWU5sW4TZLXvC++gUX5wACP
         vlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138474; x=1691743274;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHVgXi4q0hNplY5PHR/UwxCfsuZxoF70UBwiGy6j+e8=;
        b=gE8gPls2eJzS5ps0Jfz/oxFc68PmUNzoPVf4bP1CabiL14UREg6CAtmPP5N0ffHALM
         r4TbiTEo/HzYkrs4p887jnZwK/2eR7iPY6Mucr3owsRmpAV9DH7GidWY8F/lX7DQcA3Q
         5W9VOU5TErbRKwwn4dqxSQcLZ3SErqaRmgj5nsqDr0+kc8AJyZlge0peivC77JFUMPWP
         PEGoDmK8OEvZGWpL04JZCUJ9nAfylt8S6Wi4VosndR4Qz71Fz07oK4IN/KQNZsS31AMt
         C6/AxlMfvixYCvWd7sebEaTwunrSzsTdGpP7DRAh7TlFhBBWdVYoYtyhKAN/ZRwmzqr3
         igoA==
X-Gm-Message-State: AOJu0YxM777kGtTUPObFpi3mHZS9TQWVyGGEkoQG+44JaeAl1PPrpZrK
        0KKP8R+LmDX2at63Cp3XSqgo/A==
X-Google-Smtp-Source: AGHT+IHIflDqh+n2nenaR8a7bQEM6ZeeYOt16HwI6fT6a4x296diDGkDZAG9Ew23xnClpm0sZaaFUg==
X-Received: by 2002:a2e:a40e:0:b0:2b6:efa0:7c36 with SMTP id p14-20020a2ea40e000000b002b6efa07c36mr1013121ljn.21.1691138474104;
        Fri, 04 Aug 2023 01:41:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b003fe263dab33sm1805293wml.9.2023.08.04.01.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:41:13 -0700 (PDT)
Message-ID: <422faa68-a741-0cf0-6a90-a9b46424e201@linaro.org>
Date:   Fri, 4 Aug 2023 10:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/4] drm/panel: sitronix-st7789v: add support for partial
 mode
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <20230718-feature-lcd-panel-v1-3-e9a85d5374fd@wolfvision.net>
Organization: Linaro Developer Services
In-Reply-To: <20230718-feature-lcd-panel-v1-3-e9a85d5374fd@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 18/07/2023 17:31, Michael Riesch wrote:
> The ST7789V controller features support for the partial mode. Here,
> the area to be displayed can be restricted in one direction (by default,
> in vertical direction). This is useful for panels that are partial > occluded by design. Add support for the partial mode.

Could you send a v2 with a comment in the code as Maxime suggests ?

Thanks,
Neil

> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 38 ++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index d16d17f21d92..729d8d7dbf7f 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -118,6 +118,9 @@ struct st7789_panel_info {
>   	u32 bus_format;
>   	u32 bus_flags;
>   	bool invert_mode;
> +	bool partial_mode;
> +	u16 partial_start;
> +	u16 partial_end;
>   };
>   
>   struct st7789v {
> @@ -330,9 +333,14 @@ static int st7789v_get_modes(struct drm_panel *panel,
>   static int st7789v_prepare(struct drm_panel *panel)
>   {
>   	struct st7789v *ctx = panel_to_st7789v(panel);
> -	u8 pixel_fmt, polarity;
> +	u8 mode, pixel_fmt, polarity;
>   	int ret;
>   
> +	if (!ctx->info->partial_mode)
> +		mode = ST7789V_RGBCTRL_WO;
> +	else
> +		mode = 0;
> +
>   	switch (ctx->info->bus_format) {
>   	case MEDIA_BUS_FMT_RGB666_1X18:
>   		pixel_fmt = MIPI_DCS_PIXEL_FMT_18BIT;
> @@ -472,6 +480,32 @@ static int st7789v_prepare(struct drm_panel *panel)
>   						MIPI_DCS_EXIT_INVERT_MODE));
>   	}
>   
> +	if (ctx->info->partial_mode) {
> +		u8 area_data[4] = {
> +			(ctx->info->partial_start >> 8) & 0xff,
> +			(ctx->info->partial_start >> 0) & 0xff,
> +			((ctx->info->partial_end - 1) >> 8) & 0xff,
> +			((ctx->info->partial_end - 1) >> 0) & 0xff,
> +		};
> +
> +		ST7789V_TEST(ret, st7789v_write_command(
> +					  ctx, MIPI_DCS_ENTER_PARTIAL_MODE));
> +
> +		ST7789V_TEST(ret, st7789v_write_command(
> +					  ctx, MIPI_DCS_SET_PAGE_ADDRESS));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[0]));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[1]));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[2]));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[3]));
> +
> +		ST7789V_TEST(ret, st7789v_write_command(
> +					  ctx, MIPI_DCS_SET_PARTIAL_ROWS));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[0]));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[1]));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[2]));
> +		ST7789V_TEST(ret, st7789v_write_data(ctx, area_data[3]));
> +	}
> +
>   	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_RAMCTRL_CMD));
>   	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RAMCTRL_DM_RGB |
>   					     ST7789V_RAMCTRL_RM_RGB));
> @@ -479,7 +513,7 @@ static int st7789v_prepare(struct drm_panel *panel)
>   					     ST7789V_RAMCTRL_MAGIC));
>   
>   	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_RGBCTRL_CMD));
> -	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_WO |
> +	ST7789V_TEST(ret, st7789v_write_data(ctx, mode |
>   					     ST7789V_RGBCTRL_RCM(2) |
>   					     polarity));
>   	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_VBP(8)));
> 

