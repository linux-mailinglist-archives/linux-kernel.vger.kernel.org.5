Return-Path: <linux-kernel+bounces-29035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910DE83074F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A79E1F24A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC0200D6;
	Wed, 17 Jan 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkrqV21J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C767200A4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499271; cv=none; b=DREfBBX9SelEiLmxEjbmbnbZXr9Zfkjt1hlxXJb59b47KBy4um5K7wY03LCfOzGFy+m3c+9Wyc/wzYxFIw80aTAaUwtny5UABqnAZF9jTqlEiAkEBoUQIxDTWDvWu+iDNgOKrNAJSQuvze/fftvD8atJdRt12yhofmVLtNnwrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499271; c=relaxed/simple;
	bh=I7vQBID3G5sv3NpLhtsULacwm+dYjsLRrcvjaJpRfbA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=OTknCnux9RUp/c+wPfhEVs+rzvvSLWcTXj3KEGOq3lVNROQMQf9VA9Xge7Qda2qLC6VHx2P7C1aDt3rAII7ZuoYIvT9JtTZa7TXMSxCyMYpEke6ORUBi5R1ltrhZiOjI+Iqt9DGJkTP9rgOImIXZs02o7bIjhr/g3e8C4Dc9/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkrqV21J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BCEC433F1;
	Wed, 17 Jan 2024 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705499270;
	bh=I7vQBID3G5sv3NpLhtsULacwm+dYjsLRrcvjaJpRfbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkrqV21JZeN9qgXIJR2G+aY6Y+oJbhnCx6Nvx0jJ5s2JjH/twuRJEtgzJ/9E6g6L8
	 1EGg4xYEjyzgsew4qYqCC0y4R6EKZxVl5qTrS6SotGPC/BkItJIq9ZivWUnKZBA0He
	 M46edCDaA6pRAy6nslj8LI5aQnKb8iKnQiof6ofRPxgbn4MWPySB6LKAyX3AhzSI0g
	 ZHuc2SLLXObnB9IwL1AulZj1RL74JxsiNqUscCNbW7D1zXnHXb54kcx0eyVrLdPU/Q
	 cPyPSj1TSSAEllG2btUS9gR96knU92X1ZcDnUeynm+0cS4ACIyIgQKZanR0PkUUyLH
	 UyK6cmnA/Hnfg==
Date: Wed, 17 Jan 2024 14:47:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: Re: (subset) [PATCH] drm/rockchip: inno_hdmi: Explicitly include
 drm_atomic.h
Message-ID: <iuorynvlxp6m6u5hz3yi5d2ibfd3w6pdsm5ajlztjcsjuaczzl@f7jl7vyux2cl>
References: <20240115092434.41695-2-knaerzche@gmail.com>
 <170548481754.96553.11502916321137598260.b4-ty@kernel.org>
 <3186012.MsWZr2WtbB@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5lstoeossw6qgsw"
Content-Disposition: inline
In-Reply-To: <3186012.MsWZr2WtbB@diego>


--u5lstoeossw6qgsw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:52:04AM +0100, Heiko St=FCbner wrote:
> Hi Maxime,
>=20
> Am Mittwoch, 17. Januar 2024, 10:46:57 CET schrieb Maxime Ripard:
> > On Mon, 15 Jan 2024 10:24:35 +0100, Alex Bee wrote:
> > > Commit d3e040f450ec ("drm/rockchip: inno_hdmi: Get rid of mode_set")
> > > started using drm_atomic_get_new_connector_state and
> > > drm_atomic_get_new_crtc_state which are defined in drm_atomic.h
> > > Building does currently only work if CONFIG_OF and CONFIG_DRM_PANEL_B=
RIDGE
> > > are enabled since this will include drm_atomic.h via drm_bridge.h (see
> > > drm_of.h).
> > >=20
> > > [...]
> >=20
> > Applied to drm/drm-misc (drm-misc-next).
>=20
> wouldn't have drm-misc-next-fixes been more appropriate?
> Because I _think_ the change causing the issue made it in during the
> current merge-window?

AFAIK, the offending commit is in drm-misc-next only

Maxime

--u5lstoeossw6qgsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZafagwAKCRDj7w1vZxhR
xXhkAP9qKbp1PhY5sD3ZM1K8WsnxJlJs426f+1UdakIgqEihoQEAj9KiTUxV80b6
7rivJZ/b4AaKhqJN40Qlbi3MigyBHAg=
=6ZF3
-----END PGP SIGNATURE-----

--u5lstoeossw6qgsw--

