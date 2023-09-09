Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B4799A09
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjIIQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjIIQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:39:37 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6061700
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 09:38:41 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so5143171e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694277123; x=1694881923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWbjfl/Hk2RnIlFWrrwiyHEBruSksmwSJroOLaBDIVU=;
        b=qnKcJSa/EqdxB6z+nbdcFsQkchfvUZ4VgH0g2iZishdSRRiFNgPDkqkGBOlLy6Gr56
         IEHnuGtxAZ/zd17+Ean65DZnNrzyoGdLiLdomHJirMaCMTLRhTqFR0GeIOsTwzgF6wvg
         kHwXZOQKnI0wUmD6Q6J6WrKpLkAtFo+4JOGD9TZ8R3rYoC/jVtdvyqy8ZQq1EPnkNlV8
         Jdb0ChxpLXQf/4vLbZ66DZwF3JeUg4dzR2PP4blxMSjdanLFfiYge4x0zqJBGPpshtSi
         /2pDKnu3pY0mDW9r7KZ20A2yWE0ANitz3SOo7b1s/8o362M9p0X37BXzWoiScG8sWtxR
         pmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694277123; x=1694881923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWbjfl/Hk2RnIlFWrrwiyHEBruSksmwSJroOLaBDIVU=;
        b=qvUAQV9AUjPVQ9YWUHrgGHFrzumxfZ2h3XCKk7vWj8QHTgxJ6Xxqc+gcNUMUPBJAoz
         NkGpTxrxDEesBel2LP/T+OIYSG+f0ZLJtGbMExyTo/qPl9XeHdM12g1fdDCKKZZjO1Zs
         P1rlYIrhgP9k5QSVkATM6uJ/FO3me3BGqLRnxJ6sTq+9iH640jqDjru4gbwRAydER1ud
         zrYOUzcAa6anch4j6iltOxIEQfiKdCBz9SxJLAeZTvmy1EzKykWHD2yimwJUxCyixJeP
         TPeSb60JFM4X+tTv2SRljURwkONzVyF3uknDfQIPALgyuQUtxWcvCXGv3VRqwIHaHOVr
         by6Q==
X-Gm-Message-State: AOJu0YyaWyUYiQjdSxZOzpvKIuOXsIygZHBzdZ5z5W/u/LWS8DXPwYW3
        wzm5HbVXi83TTVGKf+nMSkkURhA9vY3SeQt3s20WwQ==
X-Google-Smtp-Source: AGHT+IE6HJLyxwxwQFrPSlfHd1gw3Q9wvTkYQGJDMz+fXr2oDA9FkHmK+u9f26Z0fQGULOWUI4pYOw==
X-Received: by 2002:a19:4f11:0:b0:500:bf56:cca6 with SMTP id d17-20020a194f11000000b00500bf56cca6mr3613215lfb.53.1694277123430;
        Sat, 09 Sep 2023 09:32:03 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id u7-20020a05640207c700b0052889d090bfsm2324360edy.79.2023.09.09.09.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 09:32:03 -0700 (PDT)
Message-ID: <7806f8d4-4bd3-e088-5a7d-2dfa8b1cc45b@tuxon.dev>
Date:   Sat, 9 Sep 2023 19:32:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 8/8] drm: atmel-hlcdc: add support for DSI output
 formats
Content-Language: en-US
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
References: <20230825125444.93222-1-manikandan.m@microchip.com>
 <20230825125444.93222-9-manikandan.m@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230825125444.93222-9-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/23 15:54, Manikandan Muralidharan wrote:
> Add support for the following DPI mode if the encoder type
> is DSI as per the XLCDC IP datasheet:
> - 16BPPCFG1
> - 16BPPCFG2
> - 16BPPCFG3
> - 18BPPCFG1
> - 18BPPCFG2
> - 24BPP
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> [durai.manickamkr@microchip.com: update output format using is_xlcdc flag]
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 123 +++++++++++++-----
>  1 file changed, 89 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index c3d0c60ba419..0d10f84c82d8 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -287,11 +287,18 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  
>  }
>  
> -#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
> -#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
> -#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
> -#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
> -#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
> +#define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
> +#define ATMEL_HLCDC_RGB565_OUTPUT		BIT(1)
> +#define ATMEL_HLCDC_RGB666_OUTPUT		BIT(2)
> +#define ATMEL_HLCDC_RGB888_OUTPUT		BIT(3)
> +#define ATMEL_HLCDC_DPI_RGB565C1_OUTPUT		BIT(4)
> +#define ATMEL_HLCDC_DPI_RGB565C2_OUTPUT		BIT(5)
> +#define ATMEL_HLCDC_DPI_RGB565C3_OUTPUT		BIT(6)
> +#define ATMEL_HLCDC_DPI_RGB666C1_OUTPUT		BIT(7)
> +#define ATMEL_HLCDC_DPI_RGB666C2_OUTPUT		BIT(8)
> +#define ATMEL_HLCDC_DPI_RGB888_OUTPUT		BIT(9)
> +#define ATMEL_HLCDC_OUTPUT_MODE_MASK		GENMASK(3, 0)
> +#define ATMEL_XLCDC_OUTPUT_MODE_MASK		GENMASK(9, 0)
>  
>  static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  {
> @@ -305,37 +312,83 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  	if (!encoder)
>  		encoder = connector->encoder;
>  
> -	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> -	case 0:
> -		break;
> -	case MEDIA_BUS_FMT_RGB444_1X12:
> -		return ATMEL_HLCDC_RGB444_OUTPUT;
> -	case MEDIA_BUS_FMT_RGB565_1X16:
> -		return ATMEL_HLCDC_RGB565_OUTPUT;
> -	case MEDIA_BUS_FMT_RGB666_1X18:
> -		return ATMEL_HLCDC_RGB666_OUTPUT;
> -	case MEDIA_BUS_FMT_RGB888_1X24:
> -		return ATMEL_HLCDC_RGB888_OUTPUT;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	for (j = 0; j < info->num_bus_formats; j++) {
> -		switch (info->bus_formats[j]) {
> -		case MEDIA_BUS_FMT_RGB444_1X12:
> -			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> +	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI) {
> +		/*
> +		 * atmel-hlcdc to support DSI formats with DSI video pipeline
> +		 * when DRM_MODE_ENCODER_DSI type is set by
> +		 * connector driver component.
> +		 */
> +		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +		case 0:
>  			break;
>  		case MEDIA_BUS_FMT_RGB565_1X16:
> -			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> -			break;
> +			return ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
>  		case MEDIA_BUS_FMT_RGB666_1X18:
> -			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> -			break;
> +			return ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +			return ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
>  		case MEDIA_BUS_FMT_RGB888_1X24:
> -			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> -			break;
> +			return ATMEL_HLCDC_DPI_RGB888_OUTPUT;
>  		default:
> +			return -EINVAL;
> +		}
> +
> +		for (j = 0; j < info->num_bus_formats; j++) {
> +			switch (info->bus_formats[j]) {
> +			case MEDIA_BUS_FMT_RGB565_1X16:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X18:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB888_1X24:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB888_OUTPUT;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +

blank line here.

> +	} else {
> +		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +		case 0:
>  			break;
> +		case MEDIA_BUS_FMT_RGB444_1X12:
> +			return ATMEL_HLCDC_RGB444_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +			return ATMEL_HLCDC_RGB565_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +			return ATMEL_HLCDC_RGB666_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			return ATMEL_HLCDC_RGB888_OUTPUT;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		for (j = 0; j < info->num_bus_formats; j++) {
> +			switch (info->bus_formats[j]) {
> +			case MEDIA_BUS_FMT_RGB444_1X12:
> +				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB565_1X16:
> +				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X18:
> +				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB888_1X24:
> +				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> +				break;
> +			default:
> +				break;
> +			}
>  		}
>  	}
>  
> @@ -344,14 +397,16 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  
>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  {
> -	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
> +	unsigned int output_fmts;
>  	struct atmel_hlcdc_crtc_state *hstate;
>  	struct drm_connector_state *cstate;
>  	struct drm_connector *connector;
> -	struct atmel_hlcdc_crtc *crtc;
> +	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>  	int i;
> +	bool is_xlcdc = crtc->dc->desc->is_xlcdc;
>  
> -	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
> +	output_fmts = is_xlcdc ? ATMEL_XLCDC_OUTPUT_MODE_MASK :
> +		      ATMEL_HLCDC_OUTPUT_MODE_MASK;
>  
>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
>  		unsigned int supported_fmts = 0;
> @@ -372,7 +427,7 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  
>  	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
>  	hstate->output_mode = fls(output_fmts) - 1;
> -	if (crtc->dc->desc->is_xlcdc) {
> +	if (is_xlcdc) {
>  		/* check if MIPI DPI bit needs to be set */
>  		if (fls(output_fmts) > 3) {
>  			hstate->output_mode -= 4;
