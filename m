Return-Path: <linux-kernel+bounces-102335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3687B0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A5C1F21629
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57765604CD;
	Wed, 13 Mar 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgf8pdfT"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B94D9ED
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353504; cv=none; b=WKrYoLSKmZZT8EJpNVg0FRxCljb4eUt1/Q0sUijGGBj1yKaLiHCJ9NrEh4LXdYp/TSnegDI6o023hS+VOELeV0mr7IxKX1JSUDT57USyRdSDbX5KS4WO+eFPgleIujQlgi3OtIjK0oiFBdItUvPO0VMZPt4rV5L2M6sUiGRxObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353504; c=relaxed/simple;
	bh=d3jQk57yyoR7JCgVH53hzXnD48IXGwC9kwCjVNQl3uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2WQeXuOcRVPoVsVBBcbMt8MjVunLy9Dq7JhvRYsI6y3QhOhGu+JrRVQNKz6pjsTe/oQ/Q7e/fPRchTW5cNDzw6sTUj+tT7JDxC5calTi9WAp6Zu9ffgNEykf+4kzbE+eiWyhDv1lArhM0lHnmrf1rlE5LmMzwzOcowM8BwfIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgf8pdfT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a465ddc2c09so13443866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710353500; x=1710958300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW43et20TFanng2wHbIlKUXSGaDrwCfaBPMPmqrkSI8=;
        b=Tgf8pdfTk2UT6/Amwf3KW3xSbgqkdk/xzJ8bWtDgF5uH+WWCNs0SJHoipkQGudbJ4d
         eRqMjmR22gfJYuwViXJDaJfTZykyStfdffCsaovOUA8bO8n5a4SKIHjCWdjPEwQd+l0F
         qgalTvsdGK3AlCeT7qCG/9ud8DuwreZqlXI0R/LZ/tQWsn9S/tP3bIQTuY1aKCs/S2D0
         kAPXIi4JNtEPVDZw8a8mULov4hpGQn8PmZCEQyQDo4cYN1/1BiUfLvq6g5vylEinMVoT
         BNqfAZjOp3ePMp6kiCx7tfHjxOkHjCOam8fq2SQYWOM7+QKYwnvbm48i0x7nK+dkQSrm
         BqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353500; x=1710958300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW43et20TFanng2wHbIlKUXSGaDrwCfaBPMPmqrkSI8=;
        b=fHyV+pNEy/OM9wkXdVatrwlSJY8TwUuZZ72sThKtamNyloSQ/noi09P4FuJlZwjSL6
         rw818r4J66kMML099LeKkK0lYyWrNhxAcYUNcboSc7H+o/tP3/5d651zdYSclZBHIVsd
         j3wYT9qSTMrsANS5rzewHeK5f0vFA7/438uwBUAZnfY31AHi9Ot6kIOe5up9VIakRwqq
         HtTc0g8SGhiW6BF7krEOtQiRTde3pNxq3bHNTkypgq29m7RNgpqGcEIdDVtJEZjIa7S+
         cPIlSdCr/MnkLElsX84+r3I1bedbecX/3aOSa5m5B7T4qR7fGxGBLwjkuUUoXvjk/NNb
         /WCg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/mUN86jVpClva8v94g4xB5Ti31NbRc29Ep9CdpDI5QLkkFBYTtAvxBF+JyLJ7+YgBxZdUZSNY8axcuFMv3pYuTAXv0yjbx2gFdxp
X-Gm-Message-State: AOJu0YyoEmxluTMaMnE27P/SjK5/3pRdi4ovO9hAhMSZu3D+5Mp3kNvg
	XEb0mCcGCSs4jR8Sw1cJjyTlTYEawGt6u+PaUo9nLxp2PO6WuYd4
X-Google-Smtp-Source: AGHT+IFScmFk1ldBKJ8z8B585gjb18wAYdKQkZQyPD8jeKv97wE2CSFX+9yQLrXWKs0jhSFx/xnSfQ==
X-Received: by 2002:a17:906:24d6:b0:a46:47cf:16bb with SMTP id f22-20020a17090624d600b00a4647cf16bbmr3623131ejb.2.1710353499286;
        Wed, 13 Mar 2024 11:11:39 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id lr1-20020a170906fb8100b00a442e2940fdsm5116418ejb.179.2024.03.13.11.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:11:38 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: Icenowy Zheng <uwu@icenowy.me>, Ondrej Jirman <x@xnux.eu>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH] drm/sun4i: tcon: Support keeping dclk rate upon ancestor clock
 changes
Date: Wed, 13 Mar 2024 19:11:37 +0100
Message-ID: <3793448.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>
References: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Frank!

Thanks on tackling this issue.

Dne nedelja, 10. marec 2024 ob 14:32:29 CET je Frank Oltmanns napisal(a):
> Allow the dclk to reset its rate when a rate change is initiated from an
> ancestor clock. This makes it possible to no longer to get an exclusive
> lock. As a consequence, it is now possible to set new rates if
> necessary, e.g. when an external display is connected.
> 
> The first user of this functionality is the A64 because PLL-VIDEO0 is an
> ancestor for both HDMI and TCON0. This allows to select an optimal rate
> for TCON0 as long as there is no external HDMI connection. Once a change
> in PLL-VIDEO0 is performed when an HDMI connection is established, TCON0
> can react gracefully and select an optimal rate based on this the new
> constraint.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
> I would like to make the Allwinner A64's data-clock keep its rate
> when its ancestor's (pll-video0) rate changes. Keeping data-clock's rate
> is required, to let the A64 drive both an LCD and HDMI display at the
> same time, because both have pll-video0 as an ancestor.
> 
> TCONs that use this flag store the ideal rate for their data-clock and
> subscribe to be notified when data-clock changes. When rate setting has
> finished (indicated by a POST_RATE_CHANGE event) the call back function
> schedules delayed work to set the data-clock's rate to the initial value
> after 100 ms. Using delayed work maks sure that the clock setting is
> finished.
> 
> I've implemented this functionality as a quirk, so that it is possible
> to use it only for the A64.
> 
> This patch supersedes [1].
> 
> This work is inspired by an out-of-tree patchset [2] [3] [4].
> Unfortunately, the patchset uses clk_set_rate() directly in a notifier
> callback, which the following comment on clk_notifier_register()
> forbids: "The callbacks associated with the notifier must not re-enter
> into the clk framework by calling any top-level clk APIs." [5]
> Furthermore, that out-of-tree patchset no longer works since 6.6,
> because setting pll-mipi is now also resetting pll-video0 and therefore
> causes a race condition.
> 
> Thank you for considering this contribution,
>   Frank
> 
> [1] https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev/
> [2] https://codeberg.org/megi/linux/commit/a37cda2fff41a67a2bacf82b1594e10335d0bd8a
> [3] https://codeberg.org/megi/linux/commit/24dc09128d2c8efc6ddf19249420e9798e967a46
> [4] https://codeberg.org/megi/linux/commit/728a93d46f99f0eb231ed6fa8971a45f97c7182c
> [5] https://elixir.bootlin.com/linux/v6.7.9/source/drivers/clk/clk.c#L4669
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 70 ++++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/sun4i/sun4i_tcon.h | 12 +++++++
>  2 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index a1a2c845ade0..b880bd44049a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -108,9 +108,11 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
>  
>  	if (enabled) {
>  		clk_prepare_enable(clk);
> -		clk_rate_exclusive_get(clk);
> +		if (!tcon->quirks->restores_rate)
> +			clk_rate_exclusive_get(clk);
>  	} else {
> -		clk_rate_exclusive_put(clk);
> +		if (!tcon->quirks->restores_rate)
> +			clk_rate_exclusive_put(clk);
>  		clk_disable_unprepare(clk);
>  	}
>  }
> @@ -343,6 +345,53 @@ static void sun4i_tcon0_mode_set_dithering(struct sun4i_tcon *tcon,
>  	regmap_write(tcon->regs, SUN4I_TCON_FRM_CTL_REG, val);
>  }
>  
> +static void sun4i_rate_reset_notifier_delayed_update(struct work_struct *work)
> +{
> +	struct sun4i_rate_reset_nb *rate_reset = container_of(work, struct sun4i_rate_reset_nb,
> +							    reset_rate_work.work);
> +
> +	clk_set_rate(rate_reset->target_clk, rate_reset->saved_rate);
> +}
> +
> +static int sun4i_rate_reset_notifier_cb(struct notifier_block *nb,
> +				      unsigned long event, void *data)
> +{
> +	struct sun4i_rate_reset_nb *rate_reset = to_sun4i_rate_reset_nb(nb);
> +
> +	if (event == POST_RATE_CHANGE)
> +		schedule_delayed_work(&rate_reset->reset_rate_work, msecs_to_jiffies(100));

Do we need that delay though? Since clock is set exclusive on TV TCONs, then
it shouldn't be changed. Alternative, simpler variation would be something
like this:
https://elixir.bootlin.com/linux/v6.8/source/drivers/tty/serial/8250/8250_dw.c#L333

> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void sun4i_rate_reset_notifier_register(struct sun4i_rate_reset_nb *rate_reset_nb)
> +{
> +	if (rate_reset_nb->is_registered)
> +		return;
> +
> +	rate_reset_nb->clk_nb.notifier_call = sun4i_rate_reset_notifier_cb;
> +
> +	INIT_DELAYED_WORK(&rate_reset_nb->reset_rate_work,
> +			  sun4i_rate_reset_notifier_delayed_update);
> +
> +	if (!clk_notifier_register(rate_reset_nb->target_clk,
> +				   &rate_reset_nb->clk_nb))
> +		rate_reset_nb->is_registered = true;
> +}
> +
> +static struct sun4i_rate_reset_nb tcon_rate_reset_tcon0_nb;

Is there any specific reason for global variable? Note that R40 and T507 have
2 LCD and 2 TV TCONs. If it's ever used there, it won't fly. Please move to
TCON struct. You can drop a few fields for doing so.

> +
> +static void sun4i_tcon0_set_dclk_rate(struct sun4i_tcon *tcon, unsigned long rate)
> +{
> +	clk_set_rate(tcon->dclk, rate);
> +
> +	if (tcon->quirks->restores_rate) {
> +		tcon_rate_reset_tcon0_nb.target_clk = tcon->dclk;
> +		tcon_rate_reset_tcon0_nb.saved_rate = rate;
> +		sun4i_rate_reset_notifier_register(&tcon_rate_reset_tcon0_nb);

Can't be registration done at TCON init time?

Best regards,
Jernej

> +	}
> +}
> +
>  static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
>  				     const struct drm_encoder *encoder,
>  				     const struct drm_display_mode *mode)
> @@ -360,8 +409,8 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
>  	 */
>  	tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
>  	tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
> -	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000 * (bpp / lanes)
> -						  / SUN6I_DSI_TCON_DIV);
> +	sun4i_tcon0_set_dclk_rate(tcon, mode->crtc_clock * 1000 * (bpp / lanes)
> +				  / SUN6I_DSI_TCON_DIV);
>  
>  	/* Set the resolution */
>  	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> @@ -434,7 +483,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>  
>  	tcon->dclk_min_div = 7;
>  	tcon->dclk_max_div = 7;
> -	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> +	sun4i_tcon0_set_dclk_rate(tcon, mode->crtc_clock * 1000);
>  
>  	/* Set the resolution */
>  	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> @@ -516,7 +565,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>  
>  	tcon->dclk_min_div = tcon->quirks->dclk_min_div;
>  	tcon->dclk_max_div = 127;
> -	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> +	sun4i_tcon0_set_dclk_rate(tcon, mode->crtc_clock * 1000);
>  
>  	/* Set the resolution */
>  	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> @@ -1503,6 +1552,14 @@ static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
>  	.supports_lvds		= true,
>  };
>  
> +static const struct sun4i_tcon_quirks sun50i_a64_lcd_quirks = {
> +	.supports_lvds		= true,
> +	.has_channel_0		= true,
> +	.restores_rate		= true,
> +	.dclk_min_div		= 1,
> +	.setup_lvds_phy		= sun6i_tcon_setup_lvds_phy,
> +};
> +
>  static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
>  	.supports_lvds		= true,
>  	.has_channel_0		= true,
> @@ -1561,6 +1618,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
>  	{ .compatible = "allwinner,sun9i-a80-tcon-tv", .data = &sun9i_a80_tcon_tv_quirks },
>  	{ .compatible = "allwinner,sun20i-d1-tcon-lcd", .data = &sun20i_d1_lcd_quirks },
>  	{ .compatible = "allwinner,sun20i-d1-tcon-tv", .data = &sun8i_r40_tv_quirks },
> +	{ .compatible = "allwinner,sun50i-a64-tcon-lcd", .data = &sun50i_a64_lcd_quirks },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index fa23aa23fe4a..bd4abc90062b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@ -243,6 +243,7 @@ struct sun4i_tcon_quirks {
>  	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
>  	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
>  	bool	polarity_in_ch0; /* some tcon1 channels have polarity bits in tcon0 pol register */
> +	bool	restores_rate;   /* restores the initial rate when rate changes */
>  	u8	dclk_min_div;	/* minimum divider for TCON0 DCLK */
>  
>  	/* callback to handle tcon muxing options */
> @@ -300,4 +301,15 @@ void sun4i_tcon_set_status(struct sun4i_tcon *crtc,
>  
>  extern const struct of_device_id sun4i_tcon_of_table[];
>  
> +struct sun4i_rate_reset_nb {
> +	struct notifier_block	clk_nb;
> +	struct delayed_work	reset_rate_work;
> +
> +	struct clk		*target_clk;
> +	unsigned long		saved_rate;
> +	bool			is_registered;
> +};
> +
> +#define to_sun4i_rate_reset_nb(_nb) container_of(_nb, struct sun4i_rate_reset_nb, clk_nb)
> +
>  #endif /* __SUN4I_TCON_H__ */
> 
> ---
> base-commit: dcb6c8ee6acc6c347caec1e73fb900c0f4ff9806
> change-id: 20240304-tcon_keep_stable_rate-5729c7706343
> 
> Best regards,
> 





