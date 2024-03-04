Return-Path: <linux-kernel+bounces-90526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D687009C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED5F1F26FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546F3A8FE;
	Mon,  4 Mar 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd5qKjsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BA3A1D1;
	Mon,  4 Mar 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552763; cv=none; b=QNmnNzIg1/A+p5oZrsbIdiP11rFdIzEj6aOvvp5I1WYERY/Y2s7KaOzq7zWZCWrCwCuGiNSC7ncaPDlE6cYr9TfTPef4Znb0puD7MqXTaXN2rvm2eUJqEqiVGsdl6uFsaLp4OS5ZceSLUMkSy22NMuGOyz8kSmLCHBFwVr+O23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552763; c=relaxed/simple;
	bh=qCfn8+14iH8PjhcmL/Dqov86jABrctnZ8SOBmrrpc0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO7dh+Iqy6YslTuqOTqRZOfvfC3RWH+AK3GYKmh/A5GkTJL0aJA0sHrkZoQRVDaZsBC9ssm2yAEDYjN03qdsMIFFgRTrbCxisKWj9GYH6QbDObmjQDN3EepjmHcR2DbmwgJQg09kCoIIOlKOsNSjs1bFFRbm0Guj0JtUETIq50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd5qKjsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D5BC433F1;
	Mon,  4 Mar 2024 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709552763;
	bh=qCfn8+14iH8PjhcmL/Dqov86jABrctnZ8SOBmrrpc0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cd5qKjsm7tlNWam9UmT9oCfjUa/fwI5qFHbnGZWcPollBsT6lFWcCN1J/onilOiVz
	 lRtcwRD6A+P6/22MrtyreM/qk5bzoAn6xz+qIIO8rwsmgzLJRF+qxG0DsYg6WnfPXe
	 SyIUHRKmhSTWOx9EPXP/t/a/Tl22MeVwE+rGUB/ltmiJ5TsxZ8n57AN15SVWhimrpZ
	 Q+64iix0NdZSm8PhMdmOet8pDHoAcQ9OMkMmBcCXTb008nPLAC6xmckqWcsF8uVyXO
	 obCk6lzQBYuIiE1ZDL/+czEuIc/tHNkfEvwMCNhjPkDLvNycINaB9tJVI/y10upcEC
	 cAHFx5Qxd4pFA==
Date: Mon, 4 Mar 2024 12:46:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, 
	Dave Airlie <airlied@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Message-ID: <20240304-brawny-goshawk-of-sorcery-860cef@houat>
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qhf5po6j5zzjeoj5"
Content-Disposition: inline
In-Reply-To: <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>


--qhf5po6j5zzjeoj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 04, 2024 at 12:11:36PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> > The arm defconfig builds failed on today's Linux next tag next-20240304.
> >
> > Build log:
> > ---------
> > ERROR: modpost: "__aeabi_uldivmod"
> > [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
> >
>=20
> Apparently caused by the 64-bit division in 358e76fd613a
> ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):
>=20
>=20
> +static enum drm_mode_status
> +sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
> +                                const struct drm_display_mode *mode,
> +                                unsigned long long clock)
>  {
> -       struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
> -       unsigned long rate =3D mode->clock * 1000;
> -       unsigned long diff =3D rate / 200; /* +-0.5% allowed by HDMI spec=
 */
> +       const struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hdmi(con=
nector);
> +       unsigned long diff =3D clock / 200; /* +-0.5% allowed by HDMI spe=
c */
>         long rounded_rate;
>=20
> This used to be a 32-bit division. If the rate is never more than
> 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> the expensive div_u64().

I sent a fix for it this morning:
https://lore.kernel.org/r/20240304091225.366325-1-mripard@kernel.org

The framework will pass an unsigned long long because HDMI character
rates can go up to 5.9GHz.

Maxime

--qhf5po6j5zzjeoj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeW0eAAKCRDj7w1vZxhR
xcNXAQCCkNjiY0JsktvmYZxKxBoofaQq7Q2nAcC6MriD6vV3BwEA//ChFlHIKtWA
r/JmCAoccPnEhcl+Ei+VFQT6vwm4UQM=
=GTZR
-----END PGP SIGNATURE-----

--qhf5po6j5zzjeoj5--

