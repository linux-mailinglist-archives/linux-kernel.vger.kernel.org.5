Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81B87AD9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjIYOOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjIYOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:14:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83A107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:14:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so107888381fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695651277; x=1696256077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdnJlM7JF+2moVzvS9KjkKRpM+IbzLyByhBc3qmxTkk=;
        b=PKHGfQxGT/tP6UD0QTtbwCY/3v7q9/i5nGv22ya9Ob3Dq+qE1DQYWviKu9WYUQh34V
         4SUU4Kr83hls+ojtFBPQOMrKF9hnDUVES18U1ShHdSaH6B7Fq8oZg+dP3m5Ts2/5qJ53
         D1Z5g48lHweCJDC6iz8OlchTM0+0ukPtnrJe33xBmN2ts//jDLBfY1k1C22KoxPxlv+s
         d99QYKXZNtunN+BU5icdoxp2xI65xnpDhqgH09TRx0orA1dipwprJUrlyHFdnYGAKyHP
         YGUJkDL26DL7ZcnZoOgl03j6x0GK9a1mIyEUA7yiMKKtWeKPELo6e49srAeGL/4BlLbF
         /3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651277; x=1696256077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdnJlM7JF+2moVzvS9KjkKRpM+IbzLyByhBc3qmxTkk=;
        b=spqbz4sI0t2p3RyAnajpRa09Qoetl++1tB/M4zr6aTerl+JJ6Bv3/5s6hhhvPyqeWB
         qMhk9bssG5HnsUVbtNm+/rjE9K2cMNKfY7hl4+3VnLK3Yg+Sj9nwvbXuIzRYZ4wAPjx3
         4T3bsK0z1e6YD2Mgnk9LyKlGLrcJbb4Y6sGKfw7U4O3Qle3bkYWOJnhiKhmHBSXvJgxl
         EGRl132T8Upjs+tDBIPNpnrhFIxXX/Tqdrn3UQimgzfa4Phv8H2HYP1WL70y/GNbAo5z
         XyQSur478p1JZS+TB1QaACbsMSugE9cWJ/wOABphHEmTAaWf+wTYjiPuEKnOJrQIDa1l
         lK4w==
X-Gm-Message-State: AOJu0YyukgmviKXnOiyacgyHpkjOY9y/4bcYKZL13ThRGygpq/h8Vu3M
        OKF/EyUs80yScN+VkVOEx0XViA==
X-Google-Smtp-Source: AGHT+IGhaYzxMKF7ZSmvAOx7GaYoTLNfcicvBe0KzT7q28wHCznj4BobprovMg1GbwAPzPjv4Mw60g==
X-Received: by 2002:a2e:b04c:0:b0:2c0:240:b564 with SMTP id d12-20020a2eb04c000000b002c00240b564mr5478516ljl.15.1695651276877;
        Mon, 25 Sep 2023 07:14:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906089100b0099ccee57ac2sm6343849eje.194.2023.09.25.07.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:14:36 -0700 (PDT)
Message-ID: <3ad5d3e4-dee1-74b5-6bb2-4a4fa3d2e071@tuxon.dev>
Date:   Mon, 25 Sep 2023 17:14:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/8] drm: atmel-hlcdc: add LCD controller layer
 definition for sam9x75
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
References: <20230915104849.187146-1-manikandan.m@microchip.com>
 <20230915104849.187146-4-manikandan.m@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230915104849.187146-4-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.09.2023 13:48, Manikandan Muralidharan wrote:
> Add the LCD controller layer definition and descriptor structure for
> sam9x75 for the following layers,

s/,/:

> - Base Layer
> - Overlay1 Layer
> - Overlay2 Layer
> - High End Overlay
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index fa0f9a93d50d..d30aec174aa2 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -462,6 +462,99 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 = {
>  	.layers = atmel_hlcdc_sam9x60_layers,
>  };
>  
> +static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
> +	{
> +		.name = "base",
> +		.formats = &atmel_hlcdc_plane_rgb_formats,
> +		.regs_offset = 0x60,
> +		.id = 0,
> +		.type = ATMEL_HLCDC_BASE_LAYER,
> +		.cfgs_offset = 0x1c,
> +		.layout = {
> +			.xstride = { 2 },
> +			.default_color = 3,
> +			.general_config = 4,
> +			.disc_pos = 5,
> +			.disc_size = 6,
> +		},
> +		.clut_offset = 0x700,
> +	},
> +	{
> +		.name = "overlay1",
> +		.formats = &atmel_hlcdc_plane_rgb_formats,
> +		.regs_offset = 0x160,
> +		.id = 1,
> +		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> +		.cfgs_offset = 0x1c,
> +		.layout = {
> +			.pos = 2,
> +			.size = 3,
> +			.xstride = { 4 },
> +			.pstride = { 5 },
> +			.default_color = 6,
> +			.chroma_key = 7,
> +			.chroma_key_mask = 8,
> +			.general_config = 9,
> +		},
> +		.clut_offset = 0xb00,
> +	},
> +	{
> +		.name = "overlay2",
> +		.formats = &atmel_hlcdc_plane_rgb_formats,
> +		.regs_offset = 0x260,
> +		.id = 2,
> +		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> +		.cfgs_offset = 0x1c,
> +		.layout = {
> +			.pos = 2,
> +			.size = 3,
> +			.xstride = { 4 },
> +			.pstride = { 5 },
> +			.default_color = 6,
> +			.chroma_key = 7,
> +			.chroma_key_mask = 8,
> +			.general_config = 9,
> +		},
> +		.clut_offset = 0xf00,
> +	},
> +	{
> +		.name = "high-end-overlay",
> +		.formats = &atmel_hlcdc_plane_rgb_and_yuv_formats,
> +		.regs_offset = 0x360,
> +		.id = 3,
> +		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> +		.cfgs_offset = 0x30,
> +		.layout = {
> +			.pos = 2,
> +			.size = 3,
> +			.memsize = 4,
> +			.xstride = { 5, 7 },
> +			.pstride = { 6, 8 },
> +			.default_color = 9,
> +			.chroma_key = 10,
> +			.chroma_key_mask = 11,
> +			.general_config = 12,
> +			.csc = 16,
> +			.scaler_config = 23,
> +		},
> +		.clut_offset = 0x1300,
> +	},
> +};
> +
> +static const struct atmel_hlcdc_dc_desc atmel_xlcdc_dc_sam9x75 = {
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.max_spw = 0xff,
> +	.max_vpw = 0xff,
> +	.max_hpw = 0x3ff,
> +	.fixed_clksrc = true,
> +	.is_xlcdc = true,
> +	.nlayers = ARRAY_SIZE(atmel_xlcdc_sam9x75_layers),
> +	.layers = atmel_xlcdc_sam9x75_layers,
> +};
> +
>  static const struct of_device_id atmel_hlcdc_of_match[] = {
>  	{
>  		.compatible = "atmel,at91sam9n12-hlcdc",
> @@ -487,6 +580,10 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
>  		.compatible = "microchip,sam9x60-hlcdc",
>  		.data = &atmel_hlcdc_dc_sam9x60,
>  	},
> +	{
> +		.compatible = "microchip,sam9x75-xlcdc",
> +		.data = &atmel_xlcdc_dc_sam9x75,
> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);
