Return-Path: <linux-kernel+bounces-77237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FED860358
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644D0B30F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B834548F5;
	Thu, 22 Feb 2024 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FteNlzM1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326314B834;
	Thu, 22 Feb 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629258; cv=none; b=Dyh2jAHLj1xpVFuX6ekXp1Tl2Bu9PXzDo63YvC2BdA7XLo+7NodRu34rjGVrWKGGxHVwQijDcuvJkmNM6VEHyOZxrdn7KE31+umE6M8mfytahuCoLJu6hWOMuS+0e5VI0dtkfF7TcgGxx7DB0F04L/60maz4Y70yh0S9r+UdsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629258; c=relaxed/simple;
	bh=2XBasCnRQB/j8di2GX6Y7RgaAgaXKoQzXox64LgP3hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afGZ1nWBM3yZ11WiPQ+x7PldMfxUybKplFrHM10xUqtd1/zsUl8gk2Z1xMGnH19BvX7Cll/A682yXESfKGCyebWocpJHoy+8rajwpYRaekJtEJJijcRTvCEPIVwHj+O2nbtFbKaig63sN2ZJsnV5wUv6PxMXHKz0+9oaAV7tFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FteNlzM1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so15905966b.0;
        Thu, 22 Feb 2024 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708629255; x=1709234055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edVmxwSP8F253S2ziQ2zDxNJAvn61Q4xr461VKmjj14=;
        b=FteNlzM1X6N+KrQrDIasdV92PJuCIAOE0nawTN4gA8JQk0cVsN8kdmAUAok0nMlu+b
         PcywjpXO8K0KtpF10YK69iZC0ipZnu1A4zngVcddx+Mux/GKbCs3yMQG9E/MmUGLKwme
         ZL8E5AlIzFBwWvpga0916agIcfK8sccm6z1cykfvLG0Eyy5D8FJuCLH4d8TmlZ3vAEkf
         uU2v3LbKklg+W4fdS/7NXuFHki3809mH0SDaYScFbzPLd5KFS9j99I6Q9HQr9a9aHGDS
         SAOhwZM1xsif2S8sgvD8i4C8hWm9PHXJOZm61Mw9+IHzfX7xt37ri1XCKtGAtDr6LaVR
         oPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629255; x=1709234055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edVmxwSP8F253S2ziQ2zDxNJAvn61Q4xr461VKmjj14=;
        b=pzLZirfP5X7sxh4SDgsYfdyWFVkQT6V+HTqQX4Hzz7JmYWjo9ZXfIUsqZTtOLQW8Y2
         GhQT3rjY4wj5p4AWwJdwz2smZkTMq5yROjlHLHhkAyhRLhFX+jXrojUvk7MsixUeupv/
         TUD5v/CYWYq6OkDkBd0s2Nh4OAYgN6dbloHXIeV93r2OrQ80EE9Y0EfuV94PJwRRhTyx
         1b8P5QXuA7KrDs8HTyv15MqpxIUMvhcf/g8UJqeUJ5qpO91Q4gZBXYTGi1aPA/UA6SP5
         EfDkvaVLyGJoP4CGWig5vb236f2u7Ew/E5Pz4Tzi00f7szgXG51e7rWEsVdYSNewCZ2g
         0Xuw==
X-Forwarded-Encrypted: i=1; AJvYcCVwfeFkLymP4c5mTmvl50gk7+oCAUxeN/GgIQYGf1kswd9yhpe2cU8J1xYaPwUrF8zlIwq2UbRwKifipSxzpxM+pMuaW1x9cC/jxa3c2+buLyrPmrztLGKxe6ulU+pGK70KmqthN6FpO6Zwn2ombcIDnH7BFjMlGfzQYNfGegCnJKtx504=
X-Gm-Message-State: AOJu0Yz17H8+q/NQQI0TMG9qoEDsUmh+UsqPkSF2EYqadShQtaNJ5CAu
	H+JM0+rbzRatck9wSUW4LcrabifPMo7/0P1D24nygQCl0L3CSB43
X-Google-Smtp-Source: AGHT+IGJnuh5knoqwFurZPclruNoFy29+PgrIe7JAmBNkID3j7bYRW/rEkP5PwLYezHAgNQTB1U/6A==
X-Received: by 2002:a17:906:6c96:b0:a3f:2272:f26c with SMTP id s22-20020a1709066c9600b00a3f2272f26cmr5504108ejr.50.1708629254832;
        Thu, 22 Feb 2024 11:14:14 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id tl23-20020a170907c31700b00a3fa5cf6d15sm352471ejc.191.2024.02.22.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:14:14 -0800 (PST)
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
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v7 36/36] drm/sun4i: hdmi: Switch to HDMI connector
Date: Thu, 22 Feb 2024 20:14:12 +0100
Message-ID: <8335826.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-36-8f4af575fce2@kernel.org>
References:
 <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-36-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 22. februar 2024 ob 19:14:22 CET je Maxime Ripard napisal=
(a):
> The new HDMI connector infrastructure allows to remove some boilerplate,
> especially to generate infoframes. Let's switch to it.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 80 ++++++++++++++++++++++------=
=2D-----
>  1 file changed, 51 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index b7cf369b1906..8a9106a39f23 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -36,30 +36,24 @@
>  #define drm_connector_to_sun4i_hdmi(c)		\
>  	container_of_const(c, struct sun4i_hdmi, connector)
> =20
> -static int sun4i_hdmi_setup_avi_infoframes(struct sun4i_hdmi *hdmi,
> -					   struct drm_display_mode *mode)
> +static int sun4i_hdmi_write_infoframe(struct drm_connector *connector,
> +				      enum hdmi_infoframe_type type,
> +				      const u8 *buffer, size_t len)
>  {
> -	struct hdmi_avi_infoframe frame;
> -	u8 buffer[17];
> -	int i, ret;
> +	struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hdmi(connector);
> +	int i;
> =20
> -	ret =3D drm_hdmi_avi_infoframe_from_display_mode(&frame,
> -						       &hdmi->connector, mode);
> -	if (ret < 0) {
> -		DRM_ERROR("Failed to get infoframes from mode\n");
> -		return ret;
> +	if (type !=3D HDMI_INFOFRAME_TYPE_AVI) {
> +		drm_err(connector->dev,
> +			"Unsupported infoframe type: %u\n", type);
> +		return 0;
>  	}
> =20
> -	ret =3D hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
> -	if (ret < 0) {
> -		DRM_ERROR("Failed to pack infoframes\n");
> -		return ret;
> -	}
> -
> -	for (i =3D 0; i < sizeof(buffer); i++)
> +	for (i =3D 0; i < len; i++)
>  		writeb(buffer[i], hdmi->base + SUN4I_HDMI_AVI_INFOFRAME_REG(i));
> =20
>  	return 0;
> +
>  }
> =20
>  static void sun4i_hdmi_disable(struct drm_encoder *encoder,
> @@ -82,14 +76,18 @@ static void sun4i_hdmi_enable(struct drm_encoder *enc=
oder,
>  {
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
> -	struct drm_display_info *display =3D &hdmi->connector.display_info;
> +	struct drm_connector *connector =3D &hdmi->connector;
> +	struct drm_display_info *display =3D &connector->display_info;
> +	struct drm_connector_state *conn_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	unsigned long long tmds_rate =3D conn_state->hdmi.tmds_char_rate;
>  	unsigned int x, y;
>  	u32 val =3D 0;
> =20
>  	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
> =20
> -	clk_set_rate(hdmi->mod_clk, mode->crtc_clock * 1000);
> -	clk_set_rate(hdmi->tmds_clk, mode->crtc_clock * 1000);
> +	clk_set_rate(hdmi->mod_clk, tmds_rate);
> +	clk_set_rate(hdmi->tmds_clk, tmds_rate);
> =20
>  	/* Set input sync enable */
>  	writel(SUN4I_HDMI_UNKNOWN_INPUT_SYNC,
> @@ -142,7 +140,8 @@ static void sun4i_hdmi_enable(struct drm_encoder *enc=
oder,
> =20
>  	clk_prepare_enable(hdmi->tmds_clk);
> =20
> -	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
> +	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +
>  	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
>  	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
>  	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
> @@ -195,7 +194,7 @@ static int sun4i_hdmi_connector_atomic_check(struct d=
rm_connector *connector,
>  	enum drm_mode_status status;
> =20
>  	status =3D sun4i_hdmi_connector_clock_valid(connector, mode,
> -						  mode->clock * 1000);
> +						  conn_state->hdmi.tmds_char_rate);
>  	if (status !=3D MODE_OK)
>  		return -EINVAL;
> =20
> @@ -206,8 +205,11 @@ static enum drm_mode_status
>  sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
>  				struct drm_display_mode *mode)
>  {
> -	return sun4i_hdmi_connector_clock_valid(connector, mode,
> -						mode->clock * 1000);
> +	unsigned long long rate =3D
> +		drm_connector_hdmi_compute_mode_clock(mode, 8,
> +						      HDMI_COLORSPACE_RGB);
> +
> +	return sun4i_hdmi_connector_clock_valid(connector, mode, rate);
>  }
> =20
>  static int sun4i_hdmi_get_modes(struct drm_connector *connector)
> @@ -253,6 +255,11 @@ static struct i2c_adapter *sun4i_hdmi_get_ddc(struct=
 device *dev)
>  	return ddc;
>  }
> =20
> +static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_f=
uncs =3D {
> +	.tmds_char_rate_valid	=3D sun4i_hdmi_connector_clock_valid,
> +	.write_infoframe	=3D sun4i_hdmi_write_infoframe,
> +};
> +
>  static const struct drm_connector_helper_funcs sun4i_hdmi_connector_help=
er_funcs =3D {
>  	.atomic_check	=3D sun4i_hdmi_connector_atomic_check,
>  	.mode_valid	=3D sun4i_hdmi_connector_mode_valid,
> @@ -274,11 +281,17 @@ sun4i_hdmi_connector_detect(struct drm_connector *c=
onnector, bool force)
>  	return connector_status_connected;
>  }
> =20
> +static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
> +{
> +	drm_atomic_helper_connector_reset(connector);
> +	__drm_atomic_helper_connector_hdmi_reset(connector, connector->state);
> +}
> +
>  static const struct drm_connector_funcs sun4i_hdmi_connector_funcs =3D {
>  	.detect			=3D sun4i_hdmi_connector_detect,
>  	.fill_modes		=3D drm_helper_probe_single_connector_modes,
>  	.destroy		=3D drm_connector_cleanup,
> -	.reset			=3D drm_atomic_helper_connector_reset,
> +	.reset			=3D sun4i_hdmi_connector_reset,
>  	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
>  };
> @@ -637,10 +650,19 @@ static int sun4i_hdmi_bind(struct device *dev, stru=
ct device *master,
> =20
>  	drm_connector_helper_add(&hdmi->connector,
>  				 &sun4i_hdmi_connector_helper_funcs);
> -	ret =3D drm_connector_init_with_ddc(drm, &hdmi->connector,
> -					  &sun4i_hdmi_connector_funcs,
> -					  DRM_MODE_CONNECTOR_HDMIA,
> -					  hdmi->ddc_i2c);
> +	ret =3D drmm_connector_hdmi_init(drm, &hdmi->connector,
> +				       /*
> +					* NOTE: Those are likely to be
> +					* wrong, but I couldn't find the
> +					* actual ones in the BSP.
> +					*/
> +				       "AW", "HDMI",
> +				       &sun4i_hdmi_connector_funcs,
> +				       &sun4i_hdmi_hdmi_connector_funcs,
> +				       DRM_MODE_CONNECTOR_HDMIA,
> +				       hdmi->ddc_i2c,
> +				       BIT(HDMI_COLORSPACE_RGB),
> +				       8);
>  	if (ret) {
>  		dev_err(dev,
>  			"Couldn't initialise the HDMI connector\n");
>=20
>=20





