Return-Path: <linux-kernel+bounces-97023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E43876485
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859CD282306
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5991BDE6;
	Fri,  8 Mar 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FYIJisH5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06E134A9;
	Fri,  8 Mar 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902034; cv=none; b=L+q2+lwh7qwh01xD3bmMHoWhuXxbnb5Z2xyAmF9bl/w0gXbM9vmLP9/Y6OSLudszB+fFyWt5bGaxLqGxPU3NlFO0F1Jsp/HH/8T2JL8Ad95voibMwqCjMqJiRSTOqRVYDYolA4aLyrwAEdZu/thZHnoa7CEL2KiKXivunLNSeOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902034; c=relaxed/simple;
	bh=r0E8P3eS2fPLIZC/WXD3R6+t1g6tiVHRmSxOWR+UqQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWwLmMXFim/DoVIkVqLdd4fA/jA1T0roKAR56uLN4IzoNlItD1/b0ocGTgS/pz6wRAE/idvYtxLjdKQCgpg0o0PKSiCf+2xbV1pjWLaCec3e5WzlIAXl4htqQNMjcL7H3Sb9aO18ZEkZ0KadG9Fbe4fUMVTw9CrwnLkg6kTteu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FYIJisH5; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709902031; x=1741438031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OqWbJSFvT2mL6M2CdG7o1ku+JZOpcSiYXFT30Jidi48=;
  b=FYIJisH5MAMvOfTvUKo6sGRO1TRwFnLZG1rICIT3dzM0LiSxlZFH2M7g
   txptwNSKximNB3UsUcFYPJIspWpeTRywCFu0x5Inkfmcy45581cXJvI+A
   OpXCIBIdyDanwFE6R11DSXsj1+ar95YDW3SScHDwRblClDbf+63O813zL
   tqNTa2T17rP/cV93QwrqkhGOKMxIlAkcTMYMTVxuKeqefE7c1LQ6Yav8s
   WdNG0/ADtfnl8OaJ/XiMPYmSlzTN+a+ThbMGGa61HjLcgK/oCwTEB5IvA
   sGVjqUCkarnINsXVn88IXeO5Juo4rcT8dmqDgissViTMV1MWXjQhlABPL
   g==;
X-IronPort-AV: E=Sophos;i="6.07,109,1708383600"; 
   d="scan'208";a="35809634"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Mar 2024 13:47:07 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E1DF028007C;
	Fri,  8 Mar 2024 13:47:06 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v8 20/27] drm/connector: hdmi: Add Infoframes generation
Date: Fri, 08 Mar 2024 13:47:08 +0100
Message-ID: <3612623.R56niFO833@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240307-kms-hdmi-connector-state-v8-20-ef6a6f31964b@kernel.org>
References: <20240307-kms-hdmi-connector-state-v8-0-ef6a6f31964b@kernel.org> <20240307-kms-hdmi-connector-state-v8-20-ef6a6f31964b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Maxime,

Am Donnerstag, 7. M=E4rz 2024, 14:38:47 CET schrieb Maxime Ripard:
> Infoframes in KMS is usually handled by a bunch of low-level helpers
> that require quite some boilerplate for drivers. This leads to
> discrepancies with how drivers generate them, and which are actually
> sent.
>=20
> Now that we have everything needed to generate them in the HDMI
> connector state, we can generate them in our common logic so that
> drivers can simply reuse what we precomputed.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig                            |   1 +
>  drivers/gpu/drm/drm_atomic_state_helper.c          | 327 +++++++++++++++=
++++++
>  drivers/gpu/drm/drm_connector.c                    |  14 +
>  .../gpu/drm/tests/drm_atomic_state_helper_test.c   |   1 +
>  drivers/gpu/drm/tests/drm_connector_test.c         |  12 +
>  include/drm/drm_atomic_state_helper.h              |   8 +
>  include/drm/drm_connector.h                        | 133 +++++++++
>  7 files changed, 496 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 872edb47bb53..ad9c467e20ce 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -97,10 +97,11 @@ config DRM_KUNIT_TEST
>  	  If in doubt, say "N".
> =20
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> +	select DRM_DISPLAY_HDMI_HELPER
>  	help
>  	  CRTC helpers for KMS drivers.
> =20
>  config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>          bool "Enable refcount backtrace history in the DP MST helpers"
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index e66272c0d006..46d9fd2ea8fa 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> [snip]
> @@ -958,10 +1100,195 @@ int drm_atomic_helper_connector_hdmi_check(struct=
 drm_connector *connector,
> =20
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
> =20
> +#define HDMI_MAX_INFOFRAME_SIZE		29
> +
> +static int clear_device_infoframe(struct drm_connector *connector,
> +				  enum hdmi_infoframe_type type)
> +{
> +	const struct drm_connector_hdmi_funcs *funcs =3D connector->hdmi.funcs;
> +
> +	if (!funcs || !funcs->clear_infoframe)
> +		return 0;
> +
> +	return funcs->clear_infoframe(connector, type);
> +}
> +
> +static int clear_infoframe(struct drm_connector *connector,
> +			   struct drm_connector_hdmi_infoframe *conn_frame,
> +			   struct drm_connector_hdmi_infoframe *old_frame)
> +{
> +	int ret;
> +
> +	ret =3D clear_device_infoframe(connector, old_frame->data.any.type);
> +	if (ret)
> +		return ret;
> +
> +	memset(old_frame, 0, sizeof(*old_frame));
> +
> +	return 0;
> +}
> +
> +static int write_device_infoframe(struct drm_connector *connector,
> +				  union hdmi_infoframe *frame)
> +{
> +	const struct drm_connector_hdmi_funcs *funcs =3D connector->hdmi.funcs;
> +	u8 buffer[HDMI_MAX_INFOFRAME_SIZE];
> +	int len;
> +
> +	if (!funcs || !funcs->write_infoframe)
> +		return -ENOSYS;
> +
> +	len =3D hdmi_infoframe_pack(frame, buffer, sizeof(buffer));
> +	if (len < 0)
> +		return len;
> +
> +	return funcs->write_infoframe(connector, frame->any.type, buffer, len);
> +}
> +
> +static int write_infoframe(struct drm_connector *connector,
> +			   struct drm_connector_hdmi_infoframe *conn_frame,
> +			   struct drm_connector_hdmi_infoframe *new_frame)
> +{
> +	int ret;
> +
> +	ret =3D write_device_infoframe(connector, &new_frame->data);
> +	if (ret)
> +		return ret;
> +
> +	if (conn_frame)
> +		memcpy(conn_frame, new_frame, sizeof(*conn_frame));
> +
> +	return 0;
> +}
> +
> +static int write_or_clear_infoframe(struct drm_connector *connector,
> +				    struct drm_connector_hdmi_infoframe *conn_frame,
> +				    struct drm_connector_hdmi_infoframe *old_frame,
> +				    struct drm_connector_hdmi_infoframe *new_frame)
> +{
> +	if (new_frame->set)
> +		return write_infoframe(connector, conn_frame, new_frame);
> +
> +	if (old_frame->set && !new_frame->set)
> +		return clear_infoframe(connector, conn_frame, old_frame);
> +
> +	return 0;
> +}
> +
> +#define UPDATE_INFOFRAME(c, os, ns, i)				\
> +	write_or_clear_infoframe(c,				\
> +				 &(c)->hdmi.infoframes.i,	\
> +				 &(os)->hdmi.infoframes.i,	\
> +				 &(ns)->hdmi.infoframes.i)
> +
> +/**
> + * drm_atomic_helper_connector_hdmi_update_infoframes - Update the Infof=
rames
> + * @connector: A pointer to the HDMI connector
> + * @state: The HDMI connector state to generate the infoframe from
> + *
> + * This function is meant for HDMI connector drivers to write their
> + * infoframes. It will typically be used in a
> + * @drm_connector_helper_funcs.atomic_enable implementation.
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connec=
tor *connector,
> +						       struct drm_atomic_state *state)
> +{
> +	struct drm_connector_state *old_state =3D
> +		drm_atomic_get_old_connector_state(state, connector);
> +	struct drm_connector_state *new_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_display_info *info =3D &connector->display_info;
> +	int ret;
> +
> +	if (!info->is_hdmi)
> +		return 0;
> +
> +	if (!info->has_hdmi_infoframe)
> +		return 0;
> +
> +	mutex_lock(&connector->hdmi.infoframes.lock);
> +
> +	ret =3D UPDATE_INFOFRAME(connector, old_state, new_state, avi);
> +	if (ret)
> +		goto out;
> +
> +	if (connector->hdmi.infoframes.audio.set) {
> +		ret =3D write_infoframe(connector,
> +				      NULL,
> +				      &connector->hdmi.infoframes.audio);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret =3D UPDATE_INFOFRAME(connector, old_state, new_state, hdr_drm);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D UPDATE_INFOFRAME(connector, old_state, new_state, spd);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D UPDATE_INFOFRAME(connector, old_state, new_state, hdmi);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	mutex_unlock(&connector->hdmi.infoframes.lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_infoframes);
> +
> +#undef UPDATE_INFOFRAME
> +#undef UPDATE_INFOFRAME_TOGGLE

UPDATE_INFOFRAME_TOGGLE seems to never be defined.

Best regards,
Alexadner

> +
> +/**
> + * drm_atomic_helper_connector_hdmi_update_audio_infoframe - Update the =
Audio Infoframe
> + * @connector: A pointer to the HDMI connector
> + * @frame: A pointer to the audio infoframe to write
> + *
> + * This function is meant for HDMI connector drivers to update their
> + * audio infoframe. It will typically be used in one of the ALSA hooks
> + * (most likely prepare).
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int
> +drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_conne=
ctor *connector,
> +							struct hdmi_audio_infoframe *frame)
> +{
> +	struct drm_connector_hdmi_infoframe infoframe =3D {};
> +	struct drm_display_info *info =3D &connector->display_info;
> +	int ret;
> +
> +	if (!info->is_hdmi)
> +		return 0;
> +
> +	if (!info->has_hdmi_infoframe)
> +		return 0;
> +
> +	memcpy(&infoframe.data, frame, sizeof(infoframe.data));
> +	infoframe.set =3D true;
> +
> +	mutex_lock(&connector->hdmi.infoframes.lock);
> +
> +	ret =3D write_infoframe(connector,
> +			      &connector->hdmi.infoframes.audio,
> +			      &infoframe);
> +
> +	mutex_unlock(&connector->hdmi.infoframes.lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_audio_infoframe);
> +
>  /**
>   * __drm_atomic_helper_connector_duplicate_state - copy atomic connector=
 state
>   * @connector: connector object
>   * @state: atomic connector state
>   *
> [snip]

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



