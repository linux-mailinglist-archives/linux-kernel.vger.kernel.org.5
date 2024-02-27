Return-Path: <linux-kernel+bounces-83385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8FA86970B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E50E1C22A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570E1448FE;
	Tue, 27 Feb 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGPhCUgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AF1420D3;
	Tue, 27 Feb 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043448; cv=none; b=GndZ66Y0SLX9/sVf7PE8kW6IZ6QZwYeaep2TWkUY0fX5wi0ScDXZD5raUlW3gboOWEZGyq3LSUfTQQf5BmGvvLh3AKACv8et/P3UzUvxpFh54VRvKTDYs6dlw3DlhDrm8q1gKdJzgXcfLazu+5Tx+LssCvUAMJCwyvGV/hlrZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043448; c=relaxed/simple;
	bh=ADzwJh+wwhaZu8qPK/rCCE4BZn8TPmuYDkYThGMuoGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLYHfxaoEZbWMeciLbtAgslipR4BtlruQEqowaOOUf7gf9sOV+5fSp7nYsC00QLyunTDEmxPxJFWaTev8ObQ6+agLiDo68kZPXnneWlVVPxhBUJ8hP64Th9q0aO5OfAZUMR2UI4VhOXRidUkHFCj77fKvZo7vwyEVvoNoc5v5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGPhCUgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27FEC43394;
	Tue, 27 Feb 2024 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709043447;
	bh=ADzwJh+wwhaZu8qPK/rCCE4BZn8TPmuYDkYThGMuoGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGPhCUgMvUMvzLULnPkAPfAyzN1GRZ8xPgvmN4qCylzQx2VkwC/sVPuLMswwLZ0tR
	 cY+RuPyFMyYlC/CgUvytr7WSh1MMeXvVAi8L5DrVeNt0nLe+gGcKPZSHHEdo30Gis2
	 nYehEoo+jWY0zQFfgC3ofMdlF9PKHdYnU9/EBM9Dh/hnCqJhrE/QrpcfSvGud+MteS
	 BmyNLlQSvSpp9LWduQLnim88nG3AbO5KrX9/cBTsD/hTO7t8WUP74HzFAeJ5b1nyxm
	 iMZRRRV8RpLyxRZZ66BS49UzvXlx2fC68gqt7sViRTbDvmw4ctDmMccFsV6OPrfFXu
	 anmwB62jzvazA==
Date: Tue, 27 Feb 2024 14:17:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, kernel test robot <lkp@intel.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	kernel@pengutronix.de,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] spi: ppc4xx: Fix fallout from rename in struct
 spi_bitbang
Message-ID: <c06fe3e9-e74f-4e80-8b33-23aacdceecf6@sirena.org.uk>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
 <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
 <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
 <76fcc5ec-0180-4f75-aaac-5ae74f2f687a@sirena.org.uk>
 <6nqpvqodqhk5vwwqgdez2lwsdlh4xrzfstkaf7o2mjz46ub2xf@zjacuzux5jdm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WxzOEfWF7Ds8gXso"
Content-Disposition: inline
In-Reply-To: <6nqpvqodqhk5vwwqgdez2lwsdlh4xrzfstkaf7o2mjz46ub2xf@zjacuzux5jdm>
X-Cookie: Please go away.


--WxzOEfWF7Ds8gXso
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 02:45:05PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Feb 27, 2024 at 12:50:15PM +0000, Mark Brown wrote:
> > On Tue, Feb 27, 2024 at 08:23:06AM +0100, Uwe Kleine-K=F6nig wrote:

> > BTW the issue here is that you sent this without comment in the middle
> > of a series of fixes the other two of which *do* apply to mainline,
> > ideally it would have just been sent separately since it needs to go
> > separately but if you *are* going to send a single series like this
> > things that are -next only should go after any fixes that are for
> > mainline.

> I expected that adding Fixes lines is enough documentation but I agree
> that in retrospect it would have been a good idea to mention the
> expected target branch for each patch. I'm willing to take half of the

The Fixes would have done the right thing if the ordering was what I
expected or if it had been sent separately - basically I wasn't
expecting to find -next material after a mainline fix in the series so
I'll not check back further in the series.=20

> blame you assigned me as in retrospect double checking the Fixes lines
> or doing a compile test of the ppc4xx driver would also have been a good
> idea for you as maintainer applying the patches. Sorry for my

I have a standard set of checks I do but as you pointed out the driver
doesn't even build with a PowerPC defconfig, let alone cross
architecture - at some point it gets to be the same situation as with
if drivers for hardware I don't have works.  The coverage in CI systems
is generally good enough for long tail configs like this, but AFAICT
even 0day didn't notice here.

--WxzOEfWF7Ds8gXso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd7vIACgkQJNaLcl1U
h9BrNgf/UtB/mMUMjmUKb0A+gfwA640wE5TbrLTmp+E5DJ33wBGCyCpsMzIHehZy
QpQpYp+GowQnpxdckO1EUk5AcdbsXXJoRLGlpVW9HaqQNM4ago+EmqAaoe65kakI
ccJpxNDui2snwQqi1O+Ykdk8ujf9EuPg+HRzM5jXViRY3uj4opOQQN5aEIhQYNa2
uGk1rVvTJV5ffTU2TRHYtMU4ywQvQlLXE0THQBcRG27KNqUFM1qzgpw/8eiTZXnc
gKws6iNp5nfmsm3WIxOEeWxh8lKmjmU8ygG4OQc4fQy8DQHW80AOHzex7ViwR+Tb
2KQije22cUmwIK+ZxO01QFW3oQZ0Lw==
=TuU4
-----END PGP SIGNATURE-----

--WxzOEfWF7Ds8gXso--

