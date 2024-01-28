Return-Path: <linux-kernel+bounces-41577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9583F4C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1351C2130D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C33CA4A;
	Sun, 28 Jan 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMwxc7Qu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A8DF56;
	Sun, 28 Jan 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706433847; cv=none; b=OgU5IgKYSxbQtLaBoPzizDf2I6m/fXDIbNF2QyI/5S7YXRG8XPlURNqfOBvoTfpOc5/PVGqqea3CwZlJDpjuBX1ooi+kHCOhLiFlNFMXKDWUGdmJy2tT8sgFMDHyD79703OCrWCAWJ2BdMC+PffH0QnzigLg6wmS2O6gQmwOkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706433847; c=relaxed/simple;
	bh=vAmi5VfiuPfMgpUzWVLhzkemLp43TOQ6SblaolpCpeU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv+qKwNTzcTR4Mm8qyFvkzjg3SCHgWtXxViverhnxyTqOaEHaLBUta2YUcPqzmTfUPgvfIJ71U+H36/oMYmw8kt7AVJeXMMmFUQdh0Vt4Pibw1XqnaTHqnEjOLFwrwycnIk9cGc8a25Vzm59t4Wp6i5ErJesz1GYOMkBsBH9se0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMwxc7Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16448C433C7;
	Sun, 28 Jan 2024 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706433846;
	bh=vAmi5VfiuPfMgpUzWVLhzkemLp43TOQ6SblaolpCpeU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=lMwxc7Qu0oHVJPI91GXXDLoO+fz95+HJ9gMP4NbphuEoMcrSG9m0cDtYmdaL+mc0D
	 8ye0Pm1XOyX9C0eEm4+3RXpCD8HukjES5r/RWWVh5RBrFE1QEr34M6pLtJ6mU12Cx/
	 WxDJ9Bm8MQ+X83R1CtubiX91LIAJfvlQhQy5CByGrKE+rxGUx9bNv5cjkB8jMxb0x6
	 TXVe0Vx2dgish6qtjHNFUfU+5Ts1N8aIDd3OUWbCJaqGkgngaV+Chgypy+iQySjVXr
	 wTsOyO73lllXi3Hi1f9ROIg1cIYPW2pREtE4baRZUzOm69tHS8lo9OLj/Q4+7k6XW2
	 jONH1sldIYSlQ==
Date: Sun, 28 Jan 2024 10:24:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>, 
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"michel@daenzer.net" <michel@daenzer.net>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "mikita.lipski@amd.com" <mikita.lipski@amd.com>, 
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>, "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>, 
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>, "fshao@chromium.org" <fshao@chromium.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jani.nikula@intel.com" <jani.nikula@intel.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Subject: Re: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
Message-ID: <vyh5wg2ltmrtqw2mhtyj2lii6i4eccrjjlynzpfg7x63tkrav6@cxbz3sasvjjm>
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
 <20230307145613.xvhru3fpcudlpazt@houat>
 <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
 <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogyu5zjbyc4numbu"
Content-Disposition: inline
In-Reply-To: <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>


--ogyu5zjbyc4numbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 07:17:21PM +0100, Daniel Vetter wrote:
> On Tue, Jan 23, 2024 at 06:09:05AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > Hi Maxime, Daniel,
> >=20
> > We encountered similar issue with mediatek SoCs.
> >=20
> > We have found that in drm_atomic_helper_commit_rpm(), when disabling
> > the cursor plane, the old_state->legacy_cursor_update in
> > drm_atomic_wait_for_vblank() is set to true.
> > As the result, we are not actually waiting for a vlbank to wait for our
> > hardware to close the cursor plane. Subsequently, the execution
> > proceeds to drm_atomic_helper_cleanup_planes() to  free the cursor
> > buffer. This can lead to use-after-free issues with our hardware.
> >=20
> > Could you please apply this patch to fix our problem?
> > Or are there any considerations for not applying this patch?
>=20
> Mostly it needs someone to collect a pile of acks/tested-by and then land
> it.
>=20
> I'd be _very_ happy if someone else can take care of that ...
>=20
> There's also the potential issue that it might slow down some of the
> legacy X11 use-cases that really needed a non-blocking cursor, but I think
> all the drivers where this matters have switched over to the async plane
> update stuff meanwhile. So hopefully that's good.

I think there was also a regression with msm no one really figured out?

Maxime

--ogyu5zjbyc4numbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbYdMgAKCRDj7w1vZxhR
xSJlAP95bsUAyxzHt1gZmvkN8tKWAggATAYm9apK9+8NFj/3MAEAnkts/Yh2y6zr
dzc9/lsQ2HaDBNTsjGfOxrlJGX+aKwE=
=2xdS
-----END PGP SIGNATURE-----

--ogyu5zjbyc4numbu--

