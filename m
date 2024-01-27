Return-Path: <linux-kernel+bounces-41323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BB683EECB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900DB1F22473
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296812D048;
	Sat, 27 Jan 2024 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLM4L3dt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655822C862;
	Sat, 27 Jan 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374089; cv=none; b=IQugXetb3SViRpkthI1X80jWVs59ahs8FQoPlyfu3Nr7eJops1+nXRvmZnJTgmKvc3aMAbM9/Qsk96JF9ERz5ObTbulf/cKCRmvpMTqfAsHwDHupNvXfMPzEsfzZ76JeuzE+cBibn+tmp6bMJg5QnT1/dS1xGMeI6cTl5EOfiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374089; c=relaxed/simple;
	bh=OPq57q57/l0vaJyrp1dFReHXsv+Tc2EmXfdWmH42XL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuzPHc2G0CkrhJwlYMWOmlm7K5i7mAWwjzJIENV0fVzgBgd/j6xAPPs1fy75RmJI+Nx56oGPQbt8ZFD45iY1HOL25pTN91SEY96ctJ8xMeikDkHbzZSlYTaVmvbDsZXQIHq9i/YLMAAJUb7PGM9KZKFZ4sDkzkt8xVkhL6BlTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLM4L3dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A1C43609;
	Sat, 27 Jan 2024 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374088;
	bh=OPq57q57/l0vaJyrp1dFReHXsv+Tc2EmXfdWmH42XL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLM4L3dt/BKhiEalXuSOAD1IbKSf1uK73N84EdAaiMk8jPcYxiqwLYzJRMmX0Q4tx
	 bWzjPOATlxMctISSgIAxm5YpPMPVEF4GlFr7/VMCtHa86lwdop8I+EA2D5hze6Ctvj
	 NXmAW4ydGPXhI/2BmOFlfSNTNoHDDRaDjzTeqP0/+IpOfm8dm0T0NBaWIrh/GLj1Nc
	 fz2SaptdnWGOeOW4WuQInFTLgkRkzwdqgOtTKvN+CiCSQWxtJBSPIH5zLjAmS0ZxjM
	 TUCNGJp8TxS7OtV56HjLk+HERfJIIiYvwG5gwmsDLcJK1UohYGXACS6AX4KRiOaORk
	 a2WTxwgFVqxXA==
Date: Sat, 27 Jan 2024 16:48:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Rosin <peda@axentia.se>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240127-capitol-cabbage-7a9b67112a28@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud>
 <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
 <20240126-scale-serrated-33686467d91b@spud>
 <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
 <20240126-blaspheme-calculate-a4134dc1ed68@spud>
 <536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se>
 <20240127-hunting-wick-fc1eed1af6b1@spud>
 <20240127144920.455b6f0c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GjKLRvODLoSn+Ea7"
Content-Disposition: inline
In-Reply-To: <20240127144920.455b6f0c@jic23-huawei>


--GjKLRvODLoSn+Ea7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 02:49:20PM +0000, Jonathan Cameron wrote:

> > > It's all in the description of the binding... =20
> >=20
> > Obviously it was not sufficiently clear, it's not as if I didn't look at
> > it...
>=20
> Given this device fits in both categories, perhaps a tiny bit of
> additional documentation would help?

That would be nice.

>   '#io-channels-cells':
>     description:
>       In addition to consuming the measurement services of an ADC,
>       the voltage divider can act as an provider of measurement
>       services to other devices.
>     const: 1

But I am not sure that that covers things. I think an example, like
Peter gave, would be good?

--GjKLRvODLoSn+Ea7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbUzwAAKCRB4tDGHoIJi
0gVsAQCylbDj315fDC3IIidM7TlZtqSvlluKUx0X6SSfvlLphQEAqA/uvT4AisrC
flXHy0rxQQ4/TCWb21WrmXXQV3hbVwc=
=7YLY
-----END PGP SIGNATURE-----

--GjKLRvODLoSn+Ea7--

