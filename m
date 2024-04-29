Return-Path: <linux-kernel+bounces-162147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CF8B56AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886E7B20B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907E44C6B;
	Mon, 29 Apr 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckzv3usm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23340BFE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390228; cv=none; b=YkUuB+EcLC8noOwePxNY3ADuuhe6wiSBr1/qG7V3/WjvGn0OvRx/QzoC430SCLzBhBpRXYiBKlsRdbjNj50krE+8AQTTLeo5HecFX/kkrEL7dpetJIavc8FJalIV9otC+pFYxGCO3TfbgCOo1UWvIe5wj6fBHeIsph5bNZclFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390228; c=relaxed/simple;
	bh=s9la03KAqMZbmHkM+p4tM0f8zTwprOrhAE2ZUhSrgT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRST1jljhzE+pLPwt/y2KI4uw2OeIgMDM5VHRZv5N+vFXkp4z/8YUNfjIj2CAkOQKnsny44ivCpDXI+yDIc885u44o6I1dO87KGDVuS+bI6PluQ5cU1E2VmD8QFyRJLuRlsT3bLSU23QeIiXaD/SkZSK5f2WKLVme+/qeDWbvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ckzv3usm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545B7C113CD;
	Mon, 29 Apr 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714390227;
	bh=s9la03KAqMZbmHkM+p4tM0f8zTwprOrhAE2ZUhSrgT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ckzv3usmQnXsMZi87PZnCjE/Nxq7K4+bTiq8vaRhF8+cT5QoYUkxgpxNMihah1YT5
	 JnYf8LjFRMDjHR5ntgTQGPe6bfhS2WEwlyJHACA1IXvO9DOypJ49rRlWGrxTGgZ2J/
	 wZecRbCGYkGG7NN6VhQlFancLWTC/R5VGLM63d/uczlSjTlD0Y53UHzSHezR0yj7cc
	 MpxyZoO25b3331Wi/9RXZci+Vwgg7oEjxlOSWJ48I4xYJL2E+hQoe609OvWvW9rKvp
	 P4QLbk/+ZW0Vud7cwH/YTSIJxgjZPLsV0787ZBLNvJ6+2/MgRh4Z78xeFW8iDYSdMv
	 It2NBHhzGQXOA==
Date: Mon, 29 Apr 2024 13:30:24 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <suijingfeng@bosc.ac.cn>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Douglas Anderson <dianders@chromium.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: drm/debugfs: Drop conditionals around of_node pointers
Message-ID: <20240429-enchanted-cooperative-jacamar-cf2902@houat>
References: <20240321222258.1440130-1-sui.jingfeng@linux.dev>
 <caa6fb05-8080-444a-93c3-2d9283ccb74d@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3nmuggz3oikoizoh"
Content-Disposition: inline
In-Reply-To: <caa6fb05-8080-444a-93c3-2d9283ccb74d@bosc.ac.cn>


--3nmuggz3oikoizoh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 04:52:13PM +0800, Sui Jingfeng wrote:
> ping
>=20
> =E5=9C=A8 2024/3/22 06:22, Sui Jingfeng =E5=86=99=E9=81=93:
> > Having conditional around the of_node pointer of the drm_bridge structu=
re
> > turns out to make driver code use ugly #ifdef blocks.

The code being ugly is an opinion, what problem is it causing exactly?

> Drop the conditionals to simplify debugfs.

What does it simplifies?

> >=20
> > Fixes: d8dfccde2709 ("drm/bridge: Drop conditionals around of_node poin=
ters")
> > Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Why do we want to backport that patch to stable?

Maxime

--3nmuggz3oikoizoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZi+EywAKCRAnX84Zoj2+
dvtsAX47pT1uA7b31OvET3HBHTtXyenRfki8jPgwaCBOQV19P4BIYankTKkwNNly
1KoRjAMBgMAjKByVUU852HrG8xSBQ++PQ9em26hkmkBm2QkB0VQoIpSlDN+gEyB9
Fhk/ZF5o0Q==
=B2q0
-----END PGP SIGNATURE-----

--3nmuggz3oikoizoh--

