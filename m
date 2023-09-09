Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690297999E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjIIQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjIIQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:25:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D97E71
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 09:25:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502b0d23f28so292623e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694276724; x=1694881524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQE6ckc0oZWZqJvmZPgbajkRP4Z8CAIaomWfQSYs+5o=;
        b=KlTjli2FzNXZ8tOAM6wUW2QNuqO++8DIv9dk/LzR50Z175EHcK2VwJJItGK47tZ1ps
         WklC+RcxBc98pFj7F96I8HpRbmQ+tj+zMUvozmPGmcslfBlX7NzZmZQKTF6Mr7QeE9yF
         1/gQ/3pB6dOynoHXLWvfBp9ZzeZgEw53DigPeb8lRgmTF2wQNM+ixjh/iyu4y9WEOBQd
         LFjFTBV5YLG7x4hrOdH1nbB7BJNzkNVsF1TaRGSEJC7XCTvvNSlo7LgSTQ4QfRfCYp33
         R4BpBFgoUEze6s6E7NcRomNRNEEF19zIOme+N7xI64bf4ib9dc/QCI0xaC3BEmCxMJWX
         LgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694276724; x=1694881524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQE6ckc0oZWZqJvmZPgbajkRP4Z8CAIaomWfQSYs+5o=;
        b=jQUOiuZrtSfymJpA0qx5XcCyU7RhTQjbQwYRK+P+ghfRhFP7VRw3dAGxTWtIyoZzzK
         957/2JDu1YpkczQQmd1zBIFdDEkC7NxVtavQHE9znS/PheZ5npdNOkZa/rw/6CAY2/Am
         gMHglkt2BMlCajn3wKGrV2gI9znmMJWdidISzJ1qc8Uiylb3y5PhTvE4wtxLkkW6S1Is
         G0/1jtNJHFu/95T2r0re5zXmTTqhXySBZVvTtnVH/vwF+AllgCigNZRIKMgmLsWSyTLA
         R21CoI0Oh5aVDpGgUz56mWUJP+vm/09UP85wkdwIdo7tqEvPonNdeGIVYp8DxXDbg+Li
         G5wQ==
X-Gm-Message-State: AOJu0Yyv9fDD+BakECEZpRZYcRikKFZu1HnYhzPXgWgylbfAzKEsJUKT
        b9xL2XZ1vvq2TdZIQ7r3tHTlGA==
X-Google-Smtp-Source: AGHT+IEfVZuS1Jpmntu4yEY561Ek36RST0fB8NMR+natsnsDl43t7oQj2yqxoe5fUi+Dr4a/NGrLQQ==
X-Received: by 2002:a05:6512:6c9:b0:500:86cf:124b with SMTP id u9-20020a05651206c900b0050086cf124bmr5353066lff.62.1694276723592;
        Sat, 09 Sep 2023 09:25:23 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f22-20020a056402069600b0052a626daf4csm2346689edy.47.2023.09.09.09.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 09:25:23 -0700 (PDT)
Message-ID: <a86388dd-4130-a3b1-cad0-a59dbf0a7eef@tuxon.dev>
Date:   Sat, 9 Sep 2023 19:25:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 6/8] drm: atmel-hlcdc: add DPI mode support for XLCDC
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
 <20230825125444.93222-7-manikandan.m@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230825125444.93222-7-manikandan.m@microchip.com>
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



On 8/25/23 15:54, Manikandan Muralidharan wrote:
> Add support for Display Pixel Interface (DPI) Compatible Mode
> support in atmel-hlcdc driver for XLCDC IP along with legacy
> pixel mapping.DPI mode BIT is configured in LCDC_CFG5 register.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> [durai.manickamkr@microchip.com: update DPI mode bit using is_xlcdc flag]
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 4b11a1de8af4..c3d0c60ba419 100644
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
> +	bool dpi;

To avoid confusion, better use u8 to avoid shifting a boolean value in
configuration phase.

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
> @@ -366,7 +372,15 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  
>  	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
>  	hstate->output_mode = fls(output_fmts) - 1;
> -
> +	if (crtc->dc->desc->is_xlcdc) {
> +		/* check if MIPI DPI bit needs to be set */
> +		if (fls(output_fmts) > 3) {
> +			hstate->output_mode -= 4;
> +			hstate->dpi = true;
> +		} else {
> +			hstate->dpi = false;
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -470,7 +484,7 @@ static struct drm_crtc_state *
>  atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
>  {
>  	struct atmel_hlcdc_crtc_state *state, *cur;
> -
> +	struct atmel_hlcdc_crtc *c = drm_crtc_to_atmel_hlcdc_crtc(crtc);
>  	if (WARN_ON(!crtc->state))
>  		return NULL;
>  
> @@ -481,6 +495,8 @@ atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
>  
>  	cur = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
>  	state->output_mode = cur->output_mode;
> +	if (c->dc->desc->is_xlcdc)
> +		state->dpi = cur->dpi;
>  
>  	return &state->base;
>  }
