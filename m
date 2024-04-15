Return-Path: <linux-kernel+bounces-144980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC6A8A4D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5B7B21704
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CE60ED0;
	Mon, 15 Apr 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yyl0jw8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384A5FB9D;
	Mon, 15 Apr 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180110; cv=none; b=OKWcdSYpxHEJErXGOSllEI9ajlBynw2vFcky7YrYOmMF6HRRs2XRKu2RXTPA9JV+DTMKYJ/bA13v4if7mYR6Tji5BNSxN8RlCb0YkpheTrmwUs1Gj7u/h9gY2p7w2BZFi+kbdWRVT+3P2bk7vSxIME54soBzdfbemFVuJPbsk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180110; c=relaxed/simple;
	bh=zaeta5YRsGP9vG705wmBldVE6zWx2ubesmRsCMtwiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh1xmuQyDj2lN66LYGaoHxbcc2CnmhKiCMRnI9TLynlcoKRTJdH9/uOGU6TTNBNRY4R72ualtvG0D8VClU/w3HeZ2H0J4WysiiDnU5v6ycQq4ErebToXMns2FeVIZoOD3zx7qooR7ccryTLm1KbcsdURCcUhziXM59smAduSrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yyl0jw8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F5DC113CC;
	Mon, 15 Apr 2024 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180110;
	bh=zaeta5YRsGP9vG705wmBldVE6zWx2ubesmRsCMtwiKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yyl0jw8FOgIlaxoOAe3p2F9YP256URFG19ccbzwnvLP+nXPKhgD5ZpMounJJGJTGl
	 W56F7hvPz3yssyAye//nUgEICHyExmh3si6KPUCTQVp+F3t+vLFGf9crAm/lbPZ/tG
	 oYVox67bc7RG6kHrc53DAHLbGGYZcw0qIMfntJXAZfcS1WFZVqdlHmxrcw0KYz+okp
	 Pkrupra89W8My0fKez1OycDL7lFi3BMj9x0gWr6hV/lLIp2y2H5n0Od+vGtF3NYO0c
	 CRzHx1TYaq8LcPQqKjZbGk4YUzmaWnW59PnqFLEdHv4oY9iqpgJNXI7PCDHsTpTWV7
	 4/moMdyU2qz2A==
Date: Mon, 15 Apr 2024 13:21:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-sunxi@lists.linux.dev, 
	linux-mips@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 0/7] drm/display: Fix display helpers depends on fallouts
Message-ID: <20240415-sloppy-invisible-crocodile-da4545@houat>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <117b0d3b-a60b-4bc0-9f2c-f0e4fffe634a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="wn4eudraeu4chaua"
Content-Disposition: inline
In-Reply-To: <117b0d3b-a60b-4bc0-9f2c-f0e4fffe634a@sirena.org.uk>


--wn4eudraeu4chaua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Wed, Apr 10, 2024 at 07:06:39PM +0100, Mark Brown wrote:
> On Wed, Apr 03, 2024 at 12:56:18PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > Here's a series addressing the various regressions that were reported
> > after the Kconfig rework for the DRM display helpers.
> >=20
> > Let me know what you think,
> > Maxime
>=20
> Is there any news on getting the rest of this merged?  It's been more
> than a week now and the Designware display controllers are all still
> broken in -next, causing widespread breakage in CI.  For bisection
> purposes it probably makes sense for the defconfig updates to go along
> with the changes to the Kconfig for the driver...

I was on holidays so I've admittedly hoped that it would be picked up /
reviewed by the relevant maintainers.

Aside from the changes on sunxi_defconfig, I haven't seen any review
=66rom the relevant maintainers so I'm not sure how to merge this. Should
we get an Acked-by from Arnd, Olof, Catalin or Will and merge everything
through drm-misc?

Maxime


--wn4eudraeu4chaua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZh0NywAKCRAnX84Zoj2+
dorNAX9YIzjToH375MPL7Ax5ZuueLWq41eVy07FoPTf31aMEQyEy/VR56sILKVLf
TzYFX28BgODebjC3eC3QNfJYDoWKcB+vda0h0cCbUxE3QnqF2xMfORawm4oSmu2E
dt3E8cNkCg==
=f2Da
-----END PGP SIGNATURE-----

--wn4eudraeu4chaua--

