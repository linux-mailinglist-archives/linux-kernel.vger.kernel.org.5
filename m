Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786D37E711C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbjKISFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKISFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:05:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF312139
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:05:35 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1222240b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699553135; x=1700157935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBmuvcNq/HL/4uuuxt5Bl834w8qMdTUve8ra3EWo+14=;
        b=mZmkTrv9Yd+pmLF1j1hSLS9hQyQNFoFFiYeByJtW7JqxhdaQgfNo3Yq0f5Bt32KPc+
         suMn5bV54QoLDq57zKdij9FYTKHGx4usoE0v4IAUnMB+Cc6tkEfnryK0AptAwsaxf3l2
         DxXyN8CMf3mqzNRKQyd5jLMsqozHvvbd9iHRDYCQYPWdPEkD1tUJCqb+5jpdceMapAK3
         fsE8sDDum9H5pakdPfu9+H6oKT0c9EFgYIwm0Bw045vc8bVLPM2MlSK0n06e5VLivQfL
         q1Vs9YKyT2NmvkbylReG0fIcWdLu6DjU2VWuB0ddBlZenZ8n/darI3wa0HNcMwQOGJAy
         iMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553135; x=1700157935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBmuvcNq/HL/4uuuxt5Bl834w8qMdTUve8ra3EWo+14=;
        b=vnGbJsZ96X710mtzsiO8O0xM5rwU82UZDm6c2SJFG5iD6V5Wbp8NwcVUKF6yEHwYBC
         Tblo7M224X1gKHG3wX6qubM9Q3cH0RqOIofkpr/LfGMDI9qrrJWPamYEJvdXaj9Oltcu
         ltLQn3aIX+ygMdySsse+lG8XcnsuS6GOF2Qbgdz1BvVnkq7KhQlwCSzT7wp8t5vpb0wI
         /d5ucq9P8tO6QtSHfNg1fb7DR1g+sFAmsUqi1fFHRnuFD6kZAwDQ2/K3ziPix21z+WJJ
         BFIIu248p9orIlNvchHLMOkg1AYgGozJPUnzFOz44uH9bV9ZyzutN+I4lIgBVdxBKdZ8
         Pytg==
X-Gm-Message-State: AOJu0Yzyl873m0Fm5ANBkUq6IvuHWvg0ynd8AeSpMGVeL9KeuKIIlwjp
        5CVB3W3dWNYU69nHegKKqXE=
X-Google-Smtp-Source: AGHT+IH6HZ63j3z4hnX4ukKs2vnCjJsrXU1fnvPvWQdZOdW8UREYq1y1qKBrpCe4oxFk38H2Hv2ssA==
X-Received: by 2002:a05:6a21:7786:b0:181:731:89b7 with SMTP id bd6-20020a056a21778600b00181073189b7mr7210352pzc.41.1699553134864;
        Thu, 09 Nov 2023 10:05:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c99d:e08e:5968:1b85])
        by smtp.gmail.com with ESMTPSA id t12-20020a65554c000000b00578b8fab907sm4509390pgr.73.2023.11.09.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:05:33 -0800 (PST)
Date:   Thu, 9 Nov 2023 10:05:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Allen Ballway <ballway@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915/quirk: Add quirk for devices with
 incorrect PWM frequency
Message-ID: <ZU0fa6fvT4ZWTNXr@google.com>
References: <20231017175728.1.Ibc6408a8ff1f334974104c5bcc25f2f35a57f36e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017175728.1.Ibc6408a8ff1f334974104c5bcc25f2f35a57f36e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Tue, Oct 17, 2023 at 06:01:39PM +0000, Allen Ballway wrote:
> Cyernet T10C has a bad default PWM frequency causing the display to
> strobe when the brightness is less than 100%. Create a new quirk to use
> the value from the BIOS rather than the default register value.
> 
> Signed-off-by: Allen Ballway <ballway@chromium.org>
> 
> ---
> 
>  .../gpu/drm/i915/display/intel_backlight.c    |  3 ++-
>  drivers/gpu/drm/i915/display/intel_quirks.c   | 26 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
> index 2e8f17c045222..c4dcfece9deca 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -1388,7 +1388,8 @@ static int vlv_setup_backlight(struct intel_connector *connector, enum pipe pipe
>  	ctl = intel_de_read(i915, VLV_BLC_PWM_CTL(pipe));
>  	panel->backlight.pwm_level_max = ctl >> 16;
> 
> -	if (!panel->backlight.pwm_level_max)
> +	if (!panel->backlight.pwm_level_max ||
> +	    intel_has_quirk(i915, QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY))
>  		panel->backlight.pwm_level_max = get_backlight_max_vbt(connector);

I think it would be better if we did:

	if (!intel_has_quirk(i915, QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY)) {
		ctl = intel_de_read(i915, VLV_BLC_PWM_CTL(pipe));
		panel->backlight.pwm_level_max = ctl >> 16;
	} else {
		panel->backlight.pwm_level_max = 0;
	}

	if (!panel->backlight.pwm_level_max)
		panel->backlight.pwm_level_max = get_backlight_max_vbt(connector);

The "else" branch can potentially be omitted if we know that backlight
member is initialized to 0 (I suspect it is).

> 
>  	if (!panel->backlight.pwm_level_max)
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index a280448df771a..ff6cb499428ce 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -65,6 +65,12 @@ static void quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
>  	drm_info(&i915->drm, "Applying no pps backlight power quirk\n");
>  }
> 
> +static void quirk_ignore_default_pwm_frequency(struct drm_i915_private *i915)
> +{
> +	intel_set_quirk(i915, QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY);
> +	drm_info(&i915->drm, "Applying ignore default pwm frequency quirk");
> +}
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -90,6 +96,12 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
>  	return 1;
>  }
> 
> +static int intel_dmi_ignore_default_pwm_frequency(const struct dmi_system_id *id)
> +{
> +	DRM_INFO("Default PWM frequency is incorrect and is overridden on %s\n", id->ident);
> +	return 1;
> +}
> +
>  static const struct intel_dmi_quirk intel_dmi_quirks[] = {
>  	{
>  		.dmi_id_list = &(const struct dmi_system_id[]) {
> @@ -136,6 +148,20 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
>  		},
>  		.hook = quirk_no_pps_backlight_power_hook,
>  	},
> +	{
> +		.dmi_id_list = &(const struct dmi_system_id[]) {
> +			{
> +				.callback = intel_dmi_ignore_default_pwm_frequency,
> +				.ident = "Cybernet T10C Tablet",
> +				.matches = {DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
> +							    "Cybernet Manufacturing Inc."),
> +					    DMI_EXACT_MATCH(DMI_BOARD_NAME, "T10C Tablet"),
> +				},
> +			},
> +			{ }
> +		},
> +		.hook = quirk_ignore_default_pwm_frequency,
> +	},
>  };
> 
>  static struct intel_quirk intel_quirks[] = {
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 10a4d163149fd..70589505e5a0e 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -17,6 +17,7 @@ enum intel_quirk_id {
>  	QUIRK_INVERT_BRIGHTNESS,
>  	QUIRK_LVDS_SSC_DISABLE,
>  	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
> +	QUIRK_IGNORE_DEFAULT_PWM_FREQUENCY

You want a trailing comma here.

>  };
> 
>  void intel_init_quirks(struct drm_i915_private *i915);
> --
> 2.42.0.655.g421f12c284-goog
> 

Thanks.

-- 
Dmitry
