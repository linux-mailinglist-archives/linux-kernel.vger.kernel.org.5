Return-Path: <linux-kernel+bounces-94027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F208738A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350171F26AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07B131E32;
	Wed,  6 Mar 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLLpJbRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B05DF27;
	Wed,  6 Mar 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734459; cv=none; b=pNeZzAk7ABAV7Ax4RBE13nnM5GvHiE5K3IeBN4uh4Hl0MvtvE3VnHSkrgo06DNTd9Qskffob/tYYczksxAjZ1dbXWMgeyfn3LrhiolvX6a4o0BjbO+AkMsGUgA25j/QcaFBXIah2fp562njdyBaM8OJhI8R1An5Yz02PXCIygAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734459; c=relaxed/simple;
	bh=WIKTu97/GHeWLs/loOTdSuwxaW/iFGLGrqJns6l2xVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+kxCUK5cJ2tuqrSbLqW7Qgzy0YzBdP7yDrKNk1NXi187mO8PhO4tLvWbgwn9D3Q2PLJ6F1/zS3fvyxiS1FzFRPDzP//i+N78bVZdYUmE/RBilDracUm7inUoUOgR7UhYRh0xF9KzzvLmDUphkBPcvpPaZt9wbLPr93hAA6w1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLLpJbRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A43C433C7;
	Wed,  6 Mar 2024 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709734458;
	bh=WIKTu97/GHeWLs/loOTdSuwxaW/iFGLGrqJns6l2xVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLLpJbRabgifZKGJMJ6fgLVSinxL0cRS4XMQ7vZ1Hm2Z4OpQRIC5qFTc5MVKXSaqS
	 Mv1uICGzG390Tzd3yZKlKBBZG/hKfBUsbOgC3YDlMv6dHBL1ijjCIJ+lK7uyPiderP
	 9HTXFFLj42HOhFd4NBOI86XfzNQ65xG2a4dGUI/mVrOpt6WI0nb23fQQiZLcwGJZ0f
	 b6XpMRPudLmt9pXFItgYH9wRBjPlrFmckdGMc1QoxxFnR4GIQ5/hdWFlm3VxT2C+0K
	 VVdYFWsqp3aN88cJaFEagcSLmprnMPgei7mvYlFk+vlhhMDWbcCmLB33yp7R1WTu92
	 tBEmsNZ/+mrPQ==
Date: Wed, 6 Mar 2024 15:14:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Document requirements for driver-specific KMS props
 in new drivers
Message-ID: <20240306-hulking-funky-fox-b9581b@houat>
References: <20240229202833.198691-1-sebastian.wick@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jx5njdxurrf2cgix"
Content-Disposition: inline
In-Reply-To: <20240229202833.198691-1-sebastian.wick@redhat.com>


--jx5njdxurrf2cgix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 09:28:31PM +0100, Sebastian Wick wrote:
> When extending support for a driver-specific KMS property to additional
> drivers, we should apply all the requirements for new properties and
> make sure the semantics are the same and documented.
>=20
> Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> ---
>  Documentation/gpu/drm-kms.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index 13d3627d8bc0..afa10a28035f 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -496,6 +496,11 @@ addition to the one mentioned above:
> =20
>  * An IGT test must be submitted where reasonable.
> =20
> +For historical reasons, non-standard, driver-specific properties exist. =
If a KMS
> +driver wants to add support for one of those properties, the requirement=
s for
> +new properties apply where possible. Additionally, the documented behavi=
or must
> +match the de facto semantics of the existing property to ensure compatib=
ility.
> +

I'm conflicted about this one, really.

On one hand, yeah, it's definitely reasonable and something we would
want on the long run.

But on the other hand, a driver getting its technical debt worked on for
free by anyone but its developpers doesn't seem fair to me.

Also, I assume this is in reaction to the discussion we had on the
Broadcast RGB property. We used in vc4 precisely because there was some
userspace code to deal with it and we could just reuse it, and it was
documented. So the requirements were met already.

Maxime

--jx5njdxurrf2cgix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeh6NgAKCRDj7w1vZxhR
xduLAQDWHzR22qPgjQfjobO9zEFwx3q0Cfg112/Dqo7VmDn4DQEAoshXfdwKoAl4
/YStjp8eyrAPpOr5jgxK6Xqh7WXF6gM=
=Z2rn
-----END PGP SIGNATURE-----

--jx5njdxurrf2cgix--

