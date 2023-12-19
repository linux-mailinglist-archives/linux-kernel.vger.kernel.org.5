Return-Path: <linux-kernel+bounces-5216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CE818813
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D729B24E34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E218E3C;
	Tue, 19 Dec 2023 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BemzYmdp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816F18E16
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EB9C433C7;
	Tue, 19 Dec 2023 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702990516;
	bh=iqbTkJE/kFb6PPq0syjfJC3eznEYOBBXqJD92Sg+bSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BemzYmdppMBq3ngm33vsXSgndG7PuSv4kxKUFHXX6J6iXIAc/OL/kQQ0tf47iBRgM
	 7nw7lU2aM6uejG8LY8xt687oh1OxKyO5ugoDjlG40VsGbPfG7nsmXoOOnrGg+OKcFe
	 NMMFJPb3ZlVtqXr2XiHxXSLQGxFj5v5k5BiVfsEq4QtxH2ADYFdVvFYWFHbJr5PlaQ
	 yeV83j4Lce7ynDXooiKCexGsMzGQvwQXdTZLcEJCHxcnFFgiNvS6cdoiXG2yffLkmw
	 LDw4aSo32b3yBIshn3CeDEzW/w/YkUeFN5JpS5tW2l2vjJQK0vjHX/kRiiqlWgjgA3
	 AsK92ELQqKTEA==
Date: Tue, 19 Dec 2023 13:55:14 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/rockchip: rk3066_hdmi: drop custom fill_modes
 hook
Message-ID: <evaq3yfbqf4gchsps2qoojemtii7tmcss24aruiuze5kkzlnhy@mih7rky7viqz>
References: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
 <410b116b-cb63-7ba7-3689-4f0832ab5796@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhhc2p3e2bqgegpc"
Content-Disposition: inline
In-Reply-To: <410b116b-cb63-7ba7-3689-4f0832ab5796@gmail.com>


--fhhc2p3e2bqgegpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 18, 2023 at 04:49:06PM +0100, Johan Jonker wrote:
> CRTC size validation for the display controller has been added with
> Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
> hardware capabilities"), so we can drop the custom fill_modes hook.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

I'm not sure those two are equivalent. CRTC and connectors usually have
different requirements and capabilities, and thus different,
supplementary, mode_valid/atomic_check implementations.

Maxime

--fhhc2p3e2bqgegpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYGSsQAKCRDj7w1vZxhR
xaOfAP47dRFiVGd7R/o+q+Utk5341Z7rt2jlf3mk8SWj4yz56gEAgEsj32uxPsfc
sbBYzBbBTn1lTci++BiPymZmkwWfSAo=
=HFiP
-----END PGP SIGNATURE-----

--fhhc2p3e2bqgegpc--

