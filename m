Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D327999F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjIIQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244978AbjIIQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:29:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989B35AB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 09:29:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso3984336a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694276804; x=1694881604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gErk2fmDPN9zspW0gxfBB3yKqfpmHz9a2nWUFiDbRqE=;
        b=QyVtgMDNt8wGKjUoziG/IkPJPXAhTRKaE/8xP86o36N6MTewqci3VywadXjpr1R7UX
         B+unONW/rlWmB2vlh0hd1n/6G/2h9g72iOCpnwkvb8AHjfq02o8z/EVkan/RjOeEwSQ1
         i9l2pS1iU2b4OGqBvMOWxLWIrHhwMjSz736NVPKs/IbAF2To86E+FCQSbhvFz6OSVAH0
         MwPHFUWs8YmD/4dJuWAmc5MIKLI0NF4USNZPi9qrd5RaEnbHXaBJxYJMBPwi7qZF/jli
         DQiv17fH7I4uwwoYR4dWQDQ/PuEcRgTHJARl4HoRP2GrKySB8TFw1D7E6zBu7yjorcy8
         wnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694276804; x=1694881604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gErk2fmDPN9zspW0gxfBB3yKqfpmHz9a2nWUFiDbRqE=;
        b=tV4eh0kWSTDGfouwrmwzWiqpeEAJU03+FXSXULLs/7ySAmZOmCZQ6MYnjdusJErg46
         9Nhxb7C9KXZnHr5vK4cVDWbdryvB5AoMxh5w9hsZvZiKH0LQ3aLmLGjeuyPf3vMMZx6Y
         Y5GfWAzZxo2HQ5X0DinIEYql/QQ0gqv72adjY4IXrarUUxOwxaErrDqIu9swGbNHxmF5
         ujDPiH8tHARJ/RfK404vdUlRpZuMnbvgkeObMK4/YOIFsa8cz5uoy2Wf0mEesppqAZnW
         nMdfiBFG/7qs6rH0gdT5Igms769sprbhkccExVhX+ohlRlNIwMPfLKYiYxNUaRzt0rRv
         Wisg==
X-Gm-Message-State: AOJu0Ywc5sZtu0wEvcg3uguO78nmJggjJ0o6VDlccvTL97EoDD9a8JI4
        L8udrzV+QqPYTCMuQMDmdKY1qg==
X-Google-Smtp-Source: AGHT+IFgt36OdnvJBSVSriNawPcCIHp40ArBHJDt/BFPQWS2kGOmdHyNu//mVtsP3fu82deHfqRT7g==
X-Received: by 2002:a50:ed03:0:b0:52a:1d9c:83ff with SMTP id j3-20020a50ed03000000b0052a1d9c83ffmr4307642eds.1.1694276804644;
        Sat, 09 Sep 2023 09:26:44 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7d94f000000b0052338f5b2a4sm2327139eds.86.2023.09.09.09.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 09:26:44 -0700 (PDT)
Message-ID: <d0652f8f-deb1-0fa7-54ab-c2df1a333e9f@tuxon.dev>
Date:   Sat, 9 Sep 2023 19:26:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 7/8] drm: atmel-hlcdc: add vertical and horizontal
 scaling support for XLCDC
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
 <20230825125444.93222-8-manikandan.m@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230825125444.93222-8-manikandan.m@microchip.com>
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



On 8/25/23 15:54, Manikandan Muralidharan wrote:
> update the LCDC_HEOCFG30 and LCDC_HEOCFG31 registers of XLCDC IP which

s/update/Update

> supports vertical and horizontal scaling with Bilinear and Bicubic
> co-efficients taps for Chroma and Luma componenets of the Pixel.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 ++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  4 ++++
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 20 +++++++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index d30aec174aa2..ae3e1a813482 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -536,6 +536,8 @@ static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
>  			.general_config = 12,
>  			.csc = 16,
>  			.scaler_config = 23,
> +			.vxs_config = 30,
> +			.hxs_config = 31,
>  		},
>  		.clut_offset = 0x1300,
>  	},
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 8b05a54b5fd0..27074a4c5aec 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -198,6 +198,8 @@
>   * @disc_pos: discard area position register
>   * @disc_size: discard area size register
>   * @csc: color space conversion register
> + * @vxs_config: vertical scalar filter taps control register
> + * @hxs_config: horizontal scalar filter taps control register
>   */
>  struct atmel_hlcdc_layer_cfg_layout {
>  	int xstride[ATMEL_HLCDC_LAYER_MAX_PLANES];
> @@ -217,6 +219,8 @@ struct atmel_hlcdc_layer_cfg_layout {
>  	int disc_pos;
>  	int disc_size;
>  	int csc;
> +	int vxs_config;
> +	int hxs_config;
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 26caf4cddfa4..a06ae2dc5909 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -972,6 +972,26 @@ static void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
>  		atmel_hlcdc_layer_write_cfg(&plane->layer,
>  					    desc->layout.csc + i,
>  					    xlcdc_csc_coeffs[i]);
> +
> +	if (desc->layout.vxs_config && desc->layout.hxs_config) {
> +		/*
> +		 * Updating vxs.config and hxs.config fixes the
> +		 * Green Color Issue in SAM9X7 EGT Video Player App
> +		 */
> +		atmel_hlcdc_layer_write_cfg(&plane->layer,
> +					    desc->layout.vxs_config,
> +					    ATMEL_XLCDC_LAYER_VXSYCFG_ONE |
> +					    ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE |
> +					    ATMEL_XLCDC_LAYER_VXSCCFG_ONE |
> +					    ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE);
> +
> +		atmel_hlcdc_layer_write_cfg(&plane->layer,
> +					    desc->layout.hxs_config,
> +					    ATMEL_XLCDC_LAYER_HXSYCFG_ONE |
> +					    ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE |
> +					    ATMEL_XLCDC_LAYER_HXSCCFG_ONE |
> +					    ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE);
> +	}
>  }
>  
>  static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
