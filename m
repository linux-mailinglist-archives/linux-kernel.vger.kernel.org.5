Return-Path: <linux-kernel+bounces-67300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEAC85696C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF002291593
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B213474C;
	Thu, 15 Feb 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faTn9wRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F9133402
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013898; cv=none; b=APS7X5EaDeEc8h8Ae22+D9aGXNZUSDiaL8xyBwsGkILXb+ThILZWsyQJ+HBiPwFQko3baYqsO3m9h8HbUwfezPQkRNvk6jpPpUvwffMp+cigTxAj7eUdZTInmqrQw2GX1FssMVvwbVeaSQ3Sp2y2ppJ3nWFBAnKlda7O26Y5i68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013898; c=relaxed/simple;
	bh=rFj7ZYPGwt3dukN6sX7sSwBG4zymzqaxZX0faqq5PT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiXiqbzsHftFGX2iai9y74coG8ML5I3lVCNdTKnXq6W1HeUZRh0OwZ+Mvg1NOODVuNOYNyp8t+rP30Tvec/EVBArVUgnbUIg5Xj1fp3ySc4SbfupOXEK+A36ImeaQBpsqpKmbDzyAq94zrZBP87uj8tz4krAW+VXzUzSAgaUpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faTn9wRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F98C433F1;
	Thu, 15 Feb 2024 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013898;
	bh=rFj7ZYPGwt3dukN6sX7sSwBG4zymzqaxZX0faqq5PT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faTn9wREIGVbMi3iKWssOUTbmYXdeevgcoxpixVSlGSXGr4Qm8mQWDsBr9DRlRXeQ
	 8nU9lWzLBKVctMGSbDB48iHAZxL9F/LkWQALSKZRMaArmpPzhVbEZg0BEP59JEl5Pd
	 hVwuYrj8CI0jvC27KAmFmHi3dDUhme6ZgY+Zn/We/nSfIxfJxO1Cm3BJtUUKmp4JMV
	 m2mml3i+7r0LhBP/jpHCdFcoKAHXx1L5f2uXSAp4tZN82vkhZqAKuH9FqGbQmzJIDe
	 KGlfV3wE+Rv7hfUPZQUikhO4XrMPV2sc7O21zYL3dr5BaaQCATB83ghUi0tUy7P0Ap
	 Q5mUZ4DKGdUBQ==
Date: Thu, 15 Feb 2024 17:17:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sarah Walker <sarah.walker@imgtec.com>, 
	Donald Robson <donald.robson@imgtec.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
Message-ID: <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsdlmxoxczgidwuf"
Content-Disposition: inline
In-Reply-To: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>


--vsdlmxoxczgidwuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven wrote:
> Using the Imagination Technologies PowerVR Series 6 GPU requires a
> proprietary firmware image, which is currently only available for Texas
> Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, to
> prevent asking the user about this driver when configuring a kernel
> without Texas Instruments K3 Multicore SoC support.

This wasn't making sense the first time you sent it, and now that commit
log is just plain wrong. We have firmwares for the G6110, GX6250,
GX6650, BXE-4-32, and BXS-4-64 models, which can be found on (at least)
Renesas, Mediatek, Rockchip, TI and StarFive, so across three
architectures and 5 platforms. In two months.

We won't keep up, and there's no point in trying to. Especially so when
the only benefit is for make defconfig users to hit 'enter' one time
less.

Maxime

--vsdlmxoxczgidwuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZc45EwAKCRDj7w1vZxhR
xQsQAP0WlGML9yfIPbBp7h40rujXE/j6/8TXbZpzP+yf+r8OhgEAzvPX0Jj707Lw
BKCOCLJsjgNZ3TD5SLNovdPUI1epCws=
=ytBJ
-----END PGP SIGNATURE-----

--vsdlmxoxczgidwuf--

