Return-Path: <linux-kernel+bounces-104572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AE87D028
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73C6284282
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDF83F9E9;
	Fri, 15 Mar 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3FqpOfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB163E48E;
	Fri, 15 Mar 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516271; cv=none; b=Tp8o7i9dxfeZBVvICPNr5U7dHQ5DtJTzF734KrDw015fDaPMJyMt3rF5i25OEsMsUL1GU1JNdUJGizy49nh0UgnnrgFPQWLPv9U1th2kK7kdc0PHS+zNEkNamEvwRmHHxCSeWnstjBzAHJx1LqOHgTlKwjNKRp/z30OlEW8yzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516271; c=relaxed/simple;
	bh=dv2BQE3C1SVPJZ9yimIjK4LwzWdStVZ/9oh5jMElhhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwrmAkdx/XrZYLul6Vr8jPTQoKwsIFbGOnpU7+dve/MzNF3Sh3dp3i2+eU3YfAgtRJ7WPwqmc6jq7U2HLQh4dZd2fwNLVChsa201cnQ1cYUlKG1U3PzO7eJeuqGP1KDF0tDCty9VRplOfAaIBAmMngKbkoOtTp4VGCgriza0rSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3FqpOfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9BEC43399;
	Fri, 15 Mar 2024 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710516270;
	bh=dv2BQE3C1SVPJZ9yimIjK4LwzWdStVZ/9oh5jMElhhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3FqpOfrAyIR0n1E/BYxHdrafNQUI/II/3xPBGFjRQNvkIA01sH3u4copbooOrd3l
	 cRwBP0tW8u99Seoh6KsfPE1T1QtAsMbO4zDIIF7MqubfKvhbJT3QT7LuxU791IX8GM
	 UYz2rm9RIu2cFyNcBJjktCKjMZDq9YLqSWcfrs9bEa/ncZjulHerbNMkbnI07kw/ai
	 OoMWt4pwdQzPG/WHuiPEx+viosvck3Xd+K48mJL/SOPmw/pq1eHIa/T8ejz0Gm7LIY
	 kHEsgUD9Xm4HNHRh58vrGDimxevSRqZlNwLT/ZnktUXTFGENoXw00lLYMqUqOUDI0f
	 oAU6KTk/Sgo9A==
Date: Fri, 15 Mar 2024 16:24:27 +0100
From: Maxime Ripard <mripard@kernel.org>
To: "Klymenko, Anatoliy" <Anatoliy.Klymenko@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"Simek, Michal" <michal.simek@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] drm: xlnx: Intoduce TPG CRTC driver
Message-ID: <20240315-quiet-pragmatic-capuchin-79c2ab@houat>
References: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
 <20240312-dp-live-fmt-v2-8-a9c35dc5c50d@amd.com>
 <20240314-esoteric-delicate-sidewinder-5dc4db@houat>
 <MW4PR12MB7165A15E233957E3914AA297E6292@MW4PR12MB7165.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhyiww26fdxh7rdb"
Content-Disposition: inline
In-Reply-To: <MW4PR12MB7165A15E233957E3914AA297E6292@MW4PR12MB7165.namprd12.prod.outlook.com>


--uhyiww26fdxh7rdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 07:43:30PM +0000, Klymenko, Anatoliy wrote:
> > > +/*
> > > +---------------------------------------------------------------------
> > > +--------
> > > + * DRM CRTC
> > > + */
> > > +
> > > +static enum drm_mode_status xlnx_tpg_crtc_mode_valid(struct drm_crtc
> > *crtc,
> > > +						     const struct
> > drm_display_mode *mode) {
> > > +	return MODE_OK;
> > > +}
> > > +
> > > +static int xlnx_tpg_crtc_check(struct drm_crtc *crtc,
> > > +			       struct drm_atomic_state *state) {
> > > +	struct drm_crtc_state *crtc_state =3D
> > drm_atomic_get_new_crtc_state(state, crtc);
> > > +	int ret;
> > > +
> > > +	if (!crtc_state->enable)
> > > +		goto out;
> > > +
> > > +	ret =3D drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +out:
> > > +	return drm_atomic_add_affected_planes(state, crtc); }
> > > +
> >=20
> > [...]
> >=20
> > > +
> > > +static u32 xlnx_tpg_crtc_select_output_bus_format(struct drm_crtc *c=
rtc,
> > > +						  struct drm_crtc_state
> > *crtc_state,
> > > +						  const u32 *in_bus_fmts,
> > > +						  unsigned int
> > num_in_bus_fmts) {
> > > +	struct xlnx_tpg *tpg =3D crtc_to_tpg(crtc);
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < num_in_bus_fmts; ++i)
> > > +		if (in_bus_fmts[i] =3D=3D tpg->output_bus_format)
> > > +			return tpg->output_bus_format;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct drm_crtc_helper_funcs xlnx_tpg_crtc_helper_funcs=
 =3D {
> > > +	.mode_valid =3D xlnx_tpg_crtc_mode_valid,
> > > +	.atomic_check =3D xlnx_tpg_crtc_check,
> > > +	.atomic_enable =3D xlnx_tpg_crtc_enable,
> > > +	.atomic_disable =3D xlnx_tpg_crtc_disable,
> > > +	.select_output_bus_format =3D xlnx_tpg_crtc_select_output_bus_forma=
t,
> > > +};
> >=20
> > From that code, it's not clear to me how the CRTC is going to be able t=
o get what
> > the format is.
> >=20
>=20
> It's coming from DT "bus-format" property. The idea is that this
> property will reflect the FPGA design variation synthesized.
>=20
> > It looks like you hardcode it here, but what if there's several that
> > would fit the bill? Is the CRTC expected to store it into its
> > private structure?
> >=20
>=20
> It's impractical from the resources utilization point of view to
> support multiple runtime options for FPGA-based CRTCs output signal
> format, so the bus-format will be runtime fixed but can vary between
> differently synthesized instances.
>
> > If so, I would expect it to be in the crtc state, and atomic_enable to =
just reuse
> > whatever is in the state.
> >=20
>=20
> This could be totally valid for different kinds of CRTCs, although for
> this particular case, the bus-fomat choice is runtime immutable.

Sure, but we're still discussing an API to accomodate your use-case
here. Your usecase is one thing, but the API has to be cover all cases,
and there's definitely some CRTCs out there that support multiple output
formats that would benefit from that API.

And it would mimic the drm_bridge API, which is a nice consistency
bonus.

Maxime

--uhyiww26fdxh7rdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfRoKwAKCRDj7w1vZxhR
xbZ6AQCqyIWNrOekCzZErEBBgva8wYYFUxOXwSWD2p63fto44AEArbdEKOyhIRfR
TluOQSyvoL63/q0ohUCoINatpqawVQo=
=Yted
-----END PGP SIGNATURE-----

--uhyiww26fdxh7rdb--

