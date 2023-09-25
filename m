Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589637AD9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjIYOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjIYOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:14:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC27FC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:14:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so7512658a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695651264; x=1696256064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdRnBQhusGIL2b+v+H5dfPPmDF9lKDRORIGAAQ+Woys=;
        b=NuvsRN+8S7EMpVCauIiLl50WRygRZSAF4E/HKnGx6aUA4Px16dEg1ntffjmgYQ7FE7
         97ZjAscny8bLBirlLc6Hjxh7l8zJFaWZfzqgWqBOPzxGlB5UdQHgzBu5BuhT81P+idzr
         0ifxU3NG1y73WM8I8kGnCR+35dnmAMLJXqqb2iFspMshs5iWxmkd39fajj4MK0hug2Ru
         eJslZCc291B/TXptYQaYsNhCBFXhULI3E3l6ydy0ZTLcTuAUGuKrxty+PAtbnhC3j3gv
         +Vwdt6/HW886/k1KSaHlqczUiZWJDoq/txvxKs2C7ldt1z/ZVv0AmV/oVqYL3EJ155T7
         Ex9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651264; x=1696256064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdRnBQhusGIL2b+v+H5dfPPmDF9lKDRORIGAAQ+Woys=;
        b=hPlnCw+Jg96n/a29et0HaoJ4LR5Xj2S7K4SAl+CYgsIhd+WBY5hhAgpamnvaVMciKO
         0jqEZ7YzmoflafMrzqW3u4nTzYxrHhLLyGA5ZG3o6r906E/cSruYTcVuIB6L8+iEKk8I
         OByOd0WCgVZsxsK9BDBwC7wxCrmcHrcvruMgl3MkwVkZUgq/sPfwqxtYN5/Iswp6e0ll
         vJv6w7L7gXhxtfVfBrJ1axhABTmx+wbfkL0V+KFCZwjFfmG7LfH/j0ACzRbXVIlMwfxi
         Wr11ynrH6+MF/7abv6luMw0OrkRnOshH53WAb4BNCP/wlaIK0jial1tetoAJQRwub8m8
         Lj4w==
X-Gm-Message-State: AOJu0YxMRVIhJ/JdSKW1qyF4cNMScM+Twp9z3yafuiJ8un5ufsfoMORj
        BCIGJy2Yr++BukPRikgjVVcMcA==
X-Google-Smtp-Source: AGHT+IG3P2pMWfKC6BxP+BEDyGl/OKpELub+ARSQfEls3L7kOdsakdL4CdWODUbaZsReEBrgZPKR+A==
X-Received: by 2002:a05:6402:27ca:b0:52c:f73:3567 with SMTP id c10-20020a05640227ca00b0052c0f733567mr15302759ede.13.1695651264216;
        Mon, 25 Sep 2023 07:14:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7d3cc000000b005259dd903e5sm5533339edr.67.2023.09.25.07.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:14:23 -0700 (PDT)
Message-ID: <2e73d0c0-4a3f-bea2-9779-bf929341296d@tuxon.dev>
Date:   Mon, 25 Sep 2023 17:14:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/8] drm: atmel-hlcdc: add DPI mode support for XLCDC
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
 <20230915104849.187146-7-manikandan.m@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230915104849.187146-7-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.09.2023 13:48, Manikandan Muralidharan wrote:
> Add support for Display Pixel Interface (DPI) Compatible Mode
> support in atmel-hlcdc driver for XLCDC IP along with legacy
> pixel mapping.DPI mode BIT is configured in LCDC_CFG5 register.

Space after .

> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> [durai.manickamkr@microchip.com: update DPI mode bit using is_xlcdc flag]
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 1ac31c0c474a..b0051ec02f7f 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -30,10 +30,12 @@
>   *
>   * @base: base CRTC state
>   * @output_mode: RGBXXX output mode
> + * @dpi: output DPI mode
>   */
>  struct atmel_hlcdc_crtc_state {
>  	struct drm_crtc_state base;
>  	unsigned int output_mode;
> +	u8 dpi;
>  };
>  
>  static inline struct atmel_hlcdc_crtc_state *
> @@ -164,6 +166,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  
>  	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
>  	cfg = state->output_mode << 8;
> +	if (is_xlcdc)
> +		cfg |= state->dpi << 11;
>  
>  	if (!is_xlcdc && (adj->flags & DRM_MODE_FLAG_NVSYNC))
>  		cfg |= ATMEL_HLCDC_VSPOL;
> @@ -176,7 +180,9 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
>  			   ATMEL_HLCDC_DISPPOL | ATMEL_HLCDC_DISPDLY |
>  			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
> -			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
> +			   ATMEL_HLCDC_GUARDTIME_MASK |
> +			   (is_xlcdc ? ATMEL_XLCDC_MODE_MASK |
> +			   ATMEL_XLCDC_DPI : ATMEL_HLCDC_MODE_MASK),
>  			   cfg);
>  
>  	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
> @@ -374,7 +380,15 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  
>  	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
>  	hstate->output_mode = fls(output_fmts) - 1;
> -
> +	if (crtc->dc->desc->is_xlcdc) {
> +		/* check if MIPI DPI bit needs to be set */
> +		if (fls(output_fmts) > 3) {
> +			hstate->output_mode -= 4;
> +			hstate->dpi = 1;
> +		} else {
> +			hstate->dpi = 0;
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -478,7 +492,7 @@ static struct drm_crtc_state *
>  atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
>  {
>  	struct atmel_hlcdc_crtc_state *state, *cur;
> -
> +	struct atmel_hlcdc_crtc *c = drm_crtc_to_atmel_hlcdc_crtc(crtc);

Keep the blank line here.

>  	if (WARN_ON(!crtc->state))
>  		return NULL;
>  
> @@ -489,6 +503,8 @@ atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
>  
>  	cur = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
>  	state->output_mode = cur->output_mode;
> +	if (c->dc->desc->is_xlcdc)
> +		state->dpi = cur->dpi;
>  
>  	return &state->base;
>  }
