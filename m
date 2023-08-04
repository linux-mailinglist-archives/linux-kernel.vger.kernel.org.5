Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413AE7700CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjHDNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjHDNHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:07:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425EF46BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:07:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3159d5e409dso2006832f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691154418; x=1691759218;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi6YMeFBt1L+Fit1CKog6y9vH6ID1o58p4b0KyxCMYs=;
        b=ZFAexSb3A27g6ag6/MOuWZLM5Z4Z4SsS8Jlc3HUzjCYHJgp8/DEP1gM4WcUVl2047c
         Yxhz0bPeIRwCvOMG4KgJe8H8hjsQzvu1KHKazzcqNM/6d0Ahwv4cej0GKlR+djdSi4Nu
         Q1cMsTpAJkuT7xjOlHX/zlbnAbQ3590C2DpmdqNKOZW8BrvrU3OLN2UDY21lmvN3qXcX
         6gC4HpDeFXiFUi+w88axq9uanR96+U/MyHIlcQEM29CBHlOaXJtD4DqOZwzyUk4WxnVC
         jiCMswfVSO0TYGUVaQSdBaYwTOyUP/0Z64EH6PZrMAHxx08B/ZK+QGOQAlrrE1Wcyt7E
         v+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154419; x=1691759219;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi6YMeFBt1L+Fit1CKog6y9vH6ID1o58p4b0KyxCMYs=;
        b=NhKSK72k2GWoHxzkdeXu9laNc0fbX8Hjq/GaeqfoonikoJweU4libOXdPb2uFpUiLc
         wyc7edX6+mYrWqNRJ08qH3PteN3R9/z/+RjJrw2GB1VEfWgZ5EM6eCnD3ErWYPUN11U+
         8LrBjbr0Dtz1RXsUvh+mqFAPBX90LLF3/nmI61v23pvEXxWgxQEoPPnH/A77mIPncjjo
         6WB6dZh9OEtf39KxLVaTzdlPt2U8aICCVGWvN7FsyDLkrXGYhB4N8CI/CTslCka6NNI2
         Fjupo5Ew60L39F19bnuQ/Wh5/1aOgy+1bzn8ptcLp6NhIGuhbeLoIwTocAlalLHuWAi+
         7MBg==
X-Gm-Message-State: AOJu0YxoQhcIKq+Cm8RAhxiZ15JH9Zdr8Rq8jU3v390f6Xv8alKb2+D3
        /nfTEeXbZaPRZeN57nOWr6+UIw==
X-Google-Smtp-Source: AGHT+IFq8Mz2gY+4oDrtjVqZQkyqp4qTJo3crQ8J2hX6njwODAlrR2OHkcZVfDE2AjqlzrD/xHGlig==
X-Received: by 2002:a5d:58f5:0:b0:317:36d8:d6e8 with SMTP id f21-20020a5d58f5000000b0031736d8d6e8mr1511817wrd.25.1691154418779;
        Fri, 04 Aug 2023 06:06:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:62a2:ed99:fec9:25cc? ([2a01:e0a:982:cbb0:62a2:ed99:fec9:25cc])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c22c700b003fe1a96845bsm6603901wmg.2.2023.08.04.06.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 06:06:58 -0700 (PDT)
Message-ID: <bdad8391-53f2-4968-95f0-d6c69de88903@linaro.org>
Date:   Fri, 4 Aug 2023 15:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/4] drm/panel: sitronix-st7789v: add jasonic
 jt240mhqs-hwt-ek-e3 support
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
 <20230718-feature-lcd-panel-v2-4-2485ca07b49d@wolfvision.net>
Organization: Linaro Developer Services
In-Reply-To: <20230718-feature-lcd-panel-v2-4-2485ca07b49d@wolfvision.net>
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
> The Jasonic JT240MHQS-HWT-EK-E3 is a custom panel using the Sitronix
> ST7789V controller. While the controller features a resolution of
> 320x240, only an area of 280x240 is visible by design.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 29 ++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index ebc9a3bd6db3..88e80fe98112 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -279,6 +279,21 @@ static const struct drm_display_mode et028013dma_mode = {
>   	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
>   };
>   
> +static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
> +	.clock = 6000,
> +	.hdisplay = 240,
> +	.hsync_start = 240 + 28,
> +	.hsync_end = 240 + 28 + 10,
> +	.htotal = 240 + 28 + 10 + 10,
> +	.vdisplay = 280,
> +	.vsync_start = 280 + 8,
> +	.vsync_end = 280 + 8 + 4,
> +	.vtotal = 280 + 8 + 4 + 4,
> +	.width_mm = 43,
> +	.height_mm = 37,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
> +
>   static const struct st7789_panel_info default_panel = {
>   	.mode = &default_mode,
>   	.invert_mode = true,
> @@ -303,6 +318,17 @@ static const struct st7789_panel_info et028013dma_panel = {
>   		     DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE,
>   };
>   
> +static const struct st7789_panel_info jt240mhqs_hwt_ek_e3_panel = {
> +	.mode = &jt240mhqs_hwt_ek_e3_mode,
> +	.invert_mode = true,
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> +		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
> +	.partial_mode = true,
> +	.partial_start = 38,
> +	.partial_end = 318,
> +};
> +
>   static int st7789v_get_modes(struct drm_panel *panel,
>   			     struct drm_connector *connector)
>   {
> @@ -635,6 +661,7 @@ static const struct spi_device_id st7789v_spi_id[] = {
>   	{ "st7789v", (unsigned long) &default_panel },
>   	{ "t28cp45tn89-v17", (unsigned long) &t28cp45tn89_panel },
>   	{ "et028013dma", (unsigned long) &et028013dma_panel },
> +	{ "jt240mhqs-hwt-ek-e3", (unsigned long) &jt240mhqs_hwt_ek_e3_panel },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, st7789v_spi_id);
> @@ -643,6 +670,8 @@ static const struct of_device_id st7789v_of_match[] = {
>   	{ .compatible = "sitronix,st7789v", .data = &default_panel },
>   	{ .compatible = "inanbo,t28cp45tn89-v17", .data = &t28cp45tn89_panel },
>   	{ .compatible = "edt,et028013dma", .data = &et028013dma_panel },
> +	{ .compatible = "jasonic,jt240mhqs-hwt-ek-e3",
> +	  .data = &jt240mhqs_hwt_ek_e3_panel },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, st7789v_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
