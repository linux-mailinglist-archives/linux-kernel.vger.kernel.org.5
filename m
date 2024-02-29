Return-Path: <linux-kernel+bounces-86945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5586CD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A792858B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8114A4D3;
	Thu, 29 Feb 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHm2Bsnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BADE136994;
	Thu, 29 Feb 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221657; cv=none; b=LA3vhBt0onLGO7tu9b7VLaOg9DxAkURellKo2C3nP/D6Nv+cuwSSWZlExx8IZl6zfSrXngk7EO7OAh29Z4zwGNSHXBpiR64v7c6tUrh3lNicFh9JCbsuDO2IyAvR/cSmqoPklOsE7wY20lmzuua+D20hbl8RkF1+7Tse61/nExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221657; c=relaxed/simple;
	bh=6MwWwGABMR1tStQFsRanamb+Pz2oDGsaJjQykCh7zEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDGwgKBI/xkVuNE6SGC7tvHdTYV6pvQhKnPD74g3+JPu6/72jPslKIG6a8QuvNjouIPx+XOi2qbkUR7ohojzHjGAyP48olZVeI1mxttg+qZ/eZb08mzLtiP4iRbwpeEYdKglh+Vb/8rsC67lwn/5UdzE0JnfeMS9FjXAUwL3Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHm2Bsnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0987CC433C7;
	Thu, 29 Feb 2024 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221657;
	bh=6MwWwGABMR1tStQFsRanamb+Pz2oDGsaJjQykCh7zEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHm2BsnbQnpkG+AeQ9rRis6geBPGUKHD/Z3DGjAb6Hh7OB4qDfp+EPSPhuDkX5QXF
	 GIcT4chP7012SToqzwJzgfpX1UQuf2WHUa8eR7SrFtdvrNC97Wr+etsqvUPQN2wmTW
	 3HhuPftPRy1OWXsVQVPfDAuD6QYuErn3e3xX0oa/8aj0jwkIazr1wrkNpWJ0KlS7TG
	 7Adyo6ihsIzec0mtRQNi37sNqN6A2IOIwuJMLFf/4+E+kwJWf9C9OZ+A7IRbSo5+xB
	 980pvhFnXMz880yX+E0NvFAS/fFHoJId69zfwledK5h1GLcI+3aRgODFMa31Z3YwUK
	 I5p1EIWF7/0cw==
Date: Thu, 29 Feb 2024 15:47:33 +0000
From: Mark Brown <broonie@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [broonie-ci:regmap-test-format] [regmap]  af560701e3:
 RIP:__regmap_init
Message-ID: <2d5fdeda-868d-457f-b462-8d5552a7fe1b@sirena.org.uk>
References: <202402292329.a1c8a83f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XitRPifAMX82Jp5k"
Content-Disposition: inline
In-Reply-To: <202402292329.a1c8a83f-lkp@intel.com>
X-Cookie: Marriage is the sole cause of divorce.


--XitRPifAMX82Jp5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:43:55PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "RIP:__regmap_init" on:
>=20
> commit: af560701e366502504aebae54af374710e35b55b ("regmap: Provide a call=
back for bus specific initialisation")
> https://git.kernel.org/cgit/linux/kernel/git/broonie/ci.git regmap-test-f=
ormat
>=20
> in testcase: ftrace-onoff
> version:=20
> with following parameters:
>=20
> 	runtime: 5m

I have no idea how I'm supposed to be able to tell from this mail what
on earth this test is, and it doesn't seem plausible that anything to
do with ftrace would be related to a change in the regmap KUnit tests.

--XitRPifAMX82Jp5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXgpxQACgkQJNaLcl1U
h9AFDwf5AYzFGOlcogugWywRt3YoVXAvjx1Cf6x5ZNF0EoQgTnVRl4zlTnxLk6Ty
IsRdkxkidzqZzLPZtHP3H11fnLLCLSo8QdH+9DGYPJqtUm3ecaBUrwMGQnX0Sy+k
vWWbBTYriBHzFeq/8zquVsEfTnCA0dsXZLsPAT1thCYSMB1rog3zBs5lunfUIGXD
EEczRqmvHcLpYeHPrAbT01wfdZZqw7TKQK9RzCiy/uHOj8j4tByPIDsruE4MbUfr
KQq7ResHxv9MqXBtzSI/Kxy9mv9bWpfvbHKR99kx2wFm3GPo0wzL8XTwim8/wAGQ
yxV6kLCyaYr6wSg8X4kV3WAlLHo4zg==
=WAE2
-----END PGP SIGNATURE-----

--XitRPifAMX82Jp5k--

