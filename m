Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20407700CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjHDNG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHDNG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:06:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435546B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:06:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso9985885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691154413; x=1691759213;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rlZuOg6ridU2oL/YgDCUFD2V+jpLeaSwHN8QANuvONc=;
        b=LAnglxPc7+nD0AzRAB9lvPWLJkuHtgbHNObL3I7Wec/+3ZKXA5TZE0T30KYATHz3gS
         uYj34rpD/IeoF2OHzkr0UD/JZBGR2we0NsfjfEPmdgHy0qhOc3sPWnNfKST2GOvsXjt5
         /uAy3KXvGiz5iXsIqG26RrUh9roRCs53ba5mh5/ZavpwudIGbGcINPAhXpHHwgywPSJq
         o+gqgmniSQQICvJ2Yt1y716qySCQ/xOHj9xddDQodmd7QjLtLhz9Xkj02e4036gjuG/v
         7YY7IBxErbpCqjlNe1zXFmL7tM/uW587OB37cwg2KYnCG22nlZsH+4nhtZX8N4IVXw5b
         Dsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154413; x=1691759213;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlZuOg6ridU2oL/YgDCUFD2V+jpLeaSwHN8QANuvONc=;
        b=licpvMi07ztQAPVdViAXU1MiOPeX4DQDs3+GjHasbHor7GqnNqtSgHCDzsklBxH7ln
         vJMmpWuhNapQUDTLXpshp4pgS5YDLNc3DBE88AxmEPR0Z5qOkLYj1rqu50FImhti11O0
         1WFoS78sJpbc/5+oNTTs0ZyKbKfSajle52nkWJQGIymtw3meZOYujotZiZLyyqaxtxjz
         YG/LVKKkFeZvgV2MF2VLXJRmvpq3AuJfvAQp8XJdRx/O3XXD1lsCCMQpCxotBPPnS8wc
         yQWQs4NAGDpHuN24DnfP1J9U5VQS1gs4jucy934pkais8cacDJc0gfkdMFyOJ/O+M+u6
         /cZA==
X-Gm-Message-State: AOJu0YwWn3raKpaEktV83+5R55uOBuzCKFSQgUb6WYCDv6RCVX56Lbhm
        /xQmV2KgaNhxQRb8I+DINGuhOw==
X-Google-Smtp-Source: AGHT+IHa6Nwfh6ow7wfModh8UuIlAHZP6n+N+ZgX3AzpcC+kTQR5ug+Re+apTuGnpXmEaVzI7iKlJg==
X-Received: by 2002:a1c:f715:0:b0:3fe:196f:b5f5 with SMTP id v21-20020a1cf715000000b003fe196fb5f5mr1545604wmh.16.1691154412906;
        Fri, 04 Aug 2023 06:06:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:62a2:ed99:fec9:25cc? ([2a01:e0a:982:cbb0:62a2:ed99:fec9:25cc])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d500b000000b003143c9beeaesm2495827wrt.44.2023.08.04.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 06:06:52 -0700 (PDT)
Message-ID: <be865807-9d23-00c5-c3d0-46cc458cd40e@linaro.org>
Date:   Fri, 4 Aug 2023 15:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/4] drm/panel: sitronix-st7789v: add support for
 partial mode
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
References: <20230718-feature-lcd-panel-v2-0-2485ca07b49d@wolfvision.net>
 <20230718-feature-lcd-panel-v2-3-2485ca07b49d@wolfvision.net>
Organization: Linaro Developer Services
In-Reply-To: <20230718-feature-lcd-panel-v2-3-2485ca07b49d@wolfvision.net>
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

On 04/08/2023 15:02, Michael Riesch wrote:
> The ST7789V controller features support for the partial mode. Here,
> the area to be displayed can be restricted in one direction (by default,
> in vertical direction). This is useful for panels that are partially
> occluded by design. Add support for the partial mode.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 43 ++++++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index 0ded72ed2fcd..ebc9a3bd6db3 100644
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
> @@ -345,9 +348,14 @@ static enum drm_panel_orientation st7789v_get_orientation(struct drm_panel *p)
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
> @@ -487,6 +495,37 @@ static int st7789v_prepare(struct drm_panel *panel)
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
> +		/* Caution: if userspace ever pushes a mode different from the
> +		 * expected one (i.e., the one advertised by get_modes), we'll
> +		 * add margins.
> +		 */
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
> @@ -494,7 +533,7 @@ static int st7789v_prepare(struct drm_panel *panel)
>   					     ST7789V_RAMCTRL_MAGIC));
>   
>   	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_RGBCTRL_CMD));
> -	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_WO |
> +	ST7789V_TEST(ret, st7789v_write_data(ctx, mode |
>   					     ST7789V_RGBCTRL_RCM(2) |
>   					     polarity));
>   	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_VBP(8)));
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
