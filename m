Return-Path: <linux-kernel+bounces-77220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C45860249
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47C11F2920B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC102548FF;
	Thu, 22 Feb 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/7DCy/Q"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD614B837;
	Thu, 22 Feb 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628892; cv=none; b=LfO2XQzZZsH+jhzhCCsQHW/3Hl/jmVRR/jccuD0jTcgsTibGcMaFpLRg30qsR5zVMm3r4EcDHP0zcm/cee9hs3vRvMCIpbIUnfInnA5Ycxexyb/T07kRvQ1xi9QhuTkRosF9uexRtgP1lRHMYDS2AGNBJ9CUStz1DRCyvvrHTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628892; c=relaxed/simple;
	bh=Vj0CdswYrgpd1U1o0M5HTUkMxkiuvEUXaGvjLSwzlcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg8j+X/mrhEGY5+eYvZRvxz3B/R5lbd+ZvNr7kT7+Lk+VVmu+qCJfa643ixGH7/aAjguMLEhz9O4CZYc7xp1MI1fDOXk9JUj6NS4Q+uSwHr8UHdaC480WqOAHgvVZrdgrkYWvqOjgp7Tgu4WjxRU7yJOsW+CAQ2T6AQ1kylGbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/7DCy/Q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so3143137a12.0;
        Thu, 22 Feb 2024 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708628888; x=1709233688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwGHver7Zdn7kvlDq1hFb/tIb6DJ0PWghCpxj29Cdaw=;
        b=K/7DCy/QKu3Bg+TuZ+KnBDbL6HFVR0pjpi9d37QdRCmFOP3faECjUfPT1GM1p8GTs6
         ZTU3XDmfYMYp+U2sR8FGqweK8g9/2Zm+YB1fZP9IKeZQ7jpXRhtoYFdmcRgsK3DmYHzC
         be5QMWDMMpI9MVKnHtwvn0v4CklfCGaPtB4ne2Om4FbhF40SEZMXz8mPPqzERGAT20gO
         OgdaBcp/bJgK/h3ONfZdsQCj9WNTCljOsWkDWBfj6LFg0L6RKOHNe+858ycsufGww5Bs
         tY2mOwjIJ60Ny5Pi3BrYnJRwHkF4qPXzxrTnRBXVLknmrH6s4AFEunz1I7+ElGquzOce
         U6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628888; x=1709233688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwGHver7Zdn7kvlDq1hFb/tIb6DJ0PWghCpxj29Cdaw=;
        b=bSOWpa2tCsiSgxbh4EGxwk8Pvqtt/meZcXiF36kiXOhvc8UPONdRQJqzGWjfYaO9sM
         VGzd2JUDMjGn93QYXFB6NvM81Ns/XVOsyPWR9qhJWaDEAPCGAcHdEQ5F4JslqUQK7Dmp
         dRt7gSPY+feuoHczrW6Y8jErBqsSaPIuUI2Er4BnJfzKIx6ceMIM5Mo6WJ39JGFtlbBv
         ruSbzArqB9rKIpoxfkSmJ2941b42wg75ddXnd8s3PWFqBKXW0xTFSh1wJCGj8QOWeFEs
         FT9L7vClexKyGuy0kDI2G1CVV0kw38jiTecQJXkud2AVUPvsHaBFDxYeP+M2BaMEo93S
         e6nw==
X-Forwarded-Encrypted: i=1; AJvYcCUPCdEA6rxv4oewM3v0Hy/KO8mQfo0WD1+VuJ7CBy8LfMBkaCMuD/16mEuAkaF2I2dIXBZuMGij4s9H+kW0as5qvAIcCLJLDB6iEb1JoBwp0pc1a1aokLgVYNjMIFfdVRBXvgRR/55FyKtxTWPTlOZHJ/f/2TAGa4MYiEu7ywirh362x6s=
X-Gm-Message-State: AOJu0YyeM3NGI2NjEycmThTvZ5fajUlkhGGx0F+QZBxJZYmak5uwFKYZ
	MhSN1u3RJUnrTzZs9DjJZI/l9YR48C0IisY0d5E2HUvxl12MFtYP
X-Google-Smtp-Source: AGHT+IH07eQ34d4DdPWILOvpSPCbS9FOaWmp8ij6cDkZAQw5B9sGMqV+xWKbUWYZV2D0b3TvgKbqtg==
X-Received: by 2002:a17:906:aad1:b0:a3e:a3d6:eb6f with SMTP id kt17-20020a170906aad100b00a3ea3d6eb6fmr8035501ejb.48.1708628888412;
        Thu, 22 Feb 2024 11:08:08 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id xg7-20020a170907320700b00a3d11feb32esm6145225ejb.186.2024.02.22.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:08:07 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
 Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v7 32/36] drm/sun4i: hdmi: Convert encoder to atomic
Date: Thu, 22 Feb 2024 20:08:05 +0100
Message-ID: <4545275.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-32-8f4af575fce2@kernel.org>
References:
 <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-32-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 22. februar 2024 ob 19:14:18 CET je Maxime Ripard napisal=
(a):
> The sun4i_hdmi driver still uses the non-atomic variants of the encoder
> hooks, so let's convert to their atomic equivalents.
>=20
> Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index 152375f3de2e..799a26215cc2 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -82,7 +82,8 @@ static int sun4i_hdmi_atomic_check(struct drm_encoder *=
encoder,
>  	return 0;
>  }
> =20
> -static void sun4i_hdmi_disable(struct drm_encoder *encoder)
> +static void sun4i_hdmi_disable(struct drm_encoder *encoder,
> +			       struct drm_atomic_state *state)
>  {
>  	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
>  	u32 val;
> @@ -96,7 +97,8 @@ static void sun4i_hdmi_disable(struct drm_encoder *enco=
der)
>  	clk_disable_unprepare(hdmi->tmds_clk);
>  }
> =20
> -static void sun4i_hdmi_enable(struct drm_encoder *encoder)
> +static void sun4i_hdmi_enable(struct drm_encoder *encoder,
> +			      struct drm_atomic_state *state)
>  {
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
> @@ -120,9 +122,10 @@ static void sun4i_hdmi_enable(struct drm_encoder *en=
coder)
>  }
> =20
>  static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
> -				struct drm_display_mode *mode,
> -				struct drm_display_mode *adjusted_mode)
> +				struct drm_crtc_state *crtc_state,
> +				struct drm_connector_state *conn_state)
>  {
> +	const struct drm_display_mode *mode =3D &crtc_state->mode;
>  	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
>  	unsigned int x, y;
>  	u32 val;
> @@ -201,9 +204,9 @@ static enum drm_mode_status sun4i_hdmi_mode_valid(str=
uct drm_encoder *encoder,
> =20
>  static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs =3D=
 {
>  	.atomic_check	=3D sun4i_hdmi_atomic_check,
> -	.disable	=3D sun4i_hdmi_disable,
> -	.enable		=3D sun4i_hdmi_enable,
> -	.mode_set	=3D sun4i_hdmi_mode_set,
> +	.atomic_disable	=3D sun4i_hdmi_disable,
> +	.atomic_enable	=3D sun4i_hdmi_enable,
> +	.atomic_mode_set	=3D sun4i_hdmi_mode_set,
>  	.mode_valid	=3D sun4i_hdmi_mode_valid,
>  };
> =20
>=20
>=20





