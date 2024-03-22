Return-Path: <linux-kernel+bounces-111908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ADA88727C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61371C20F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86639612EB;
	Fri, 22 Mar 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dITseOQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0988612CA;
	Fri, 22 Mar 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130569; cv=none; b=bYQttpZ2w0puWa4ZN4Z71mKwoeervlpb2HMS+Ck52XB6B+p6MOPbeDk3haIpwXQlbzjyPl4PKtxPBnmPZbAaFXHoFpMvSMkLIVzFfGnRlhp/ot9jKo66wcEK/z7yLeryXfpqay/LVBrCjvCVudN5vARUQvo9xmlYhTfiqQTIiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130569; c=relaxed/simple;
	bh=BSoC1Wq8BPWT1DN1i//NEYLXMsxbq8aPxjQOfaeKiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz9G/aOt6upNWCyEVmIMg3bMS6/wW2bJ6KNs76Mavi80crM4eFln+kY6wDMXHo9+iYGZUoCXV3R8VKzAW/nLhPl2vLW7ssDbTdzGnO9m02YxHHLtT9ekkNI8nrSljegy2RacT/gQ1PtVtN0zbEy7D2wNUzkmFJ5xmiX0wmE1HEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dITseOQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64B3C43394;
	Fri, 22 Mar 2024 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130569;
	bh=BSoC1Wq8BPWT1DN1i//NEYLXMsxbq8aPxjQOfaeKiKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dITseOQn+/dTzQK4dAIS0UcCi/aO1Ru6irgxF8Pm8XeVf/Q1ypA6KKDi6SrGy5SJq
	 /tJkvv+m9Xxg1YE2NP55xQQ1dRHPRmjbRxPbVUrJUvAkk3yeygzuqobBd+bGwPO7LT
	 Z5DyeAlJT0pR3IPfr1RCQeZOrAR6i0joKHlar99ukWqHDOXkIKJQ64J2qC9muGLFEB
	 08ZpmO0DDZ0X/9sbbOD02xwxvClpydNiAvKKy4AaXHQHOILOG7oMd8Arw3x7wXgI5u
	 x/M8ajyNkOpkYS4nn3wUTg+b81c8gYbX/yXAvggojCCnTlSwxFPd9EtY+SCyOLh7l6
	 NYqL8Whmi9vNQ==
Date: Fri, 22 Mar 2024 18:02:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heiko@sntech.de, jacob-chen@iotwrt.com,
	ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v1 1/2] dt-bindings: media: rockchip-rga: add
 rockchip,rk3588-rga
Message-ID: <20240322-exemplify-nimbly-760eb580b203@spud>
References: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
 <20240322052915.3507937-2-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QEz8+7jKQmViUp2d"
Content-Disposition: inline
In-Reply-To: <20240322052915.3507937-2-liujianfeng1994@gmail.com>


--QEz8+7jKQmViUp2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 01:29:14PM +0800, Jianfeng Liu wrote:
> Add a new compatible for the rk3588 Rockchip SoC, which also features an
> RGA, which is called RGA2 in the TRM Part2. It is the same core as used
> on the rk3288 and rk3568, which documents the same RGA2.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QEz8+7jKQmViUp2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3HxAAKCRB4tDGHoIJi
0uvyAP9rl+bMFQbx1J0oIWtHbzYAN5mf5Acthk+OHV+5zjkORAEAnu33smhHZkfC
/LbDCrNY/h+TUvv6Xh6UDO4ZiYGfOwE=
=KlYs
-----END PGP SIGNATURE-----

--QEz8+7jKQmViUp2d--

