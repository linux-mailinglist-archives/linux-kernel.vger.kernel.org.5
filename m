Return-Path: <linux-kernel+bounces-46526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72C8440EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2271C2633B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846607F497;
	Wed, 31 Jan 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvAQz9NU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683E80BEB;
	Wed, 31 Jan 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708676; cv=none; b=b9CEuxdofwiRCyi3XFCa5w5k3XKjwoJ4HqYZP5q7E8SbFPl3LmtfiRX8vNsLFIeNEO/K6qv9LsPBYbqbo36cxG1WcexFrOA/nLBQZkfAtueZ10HJev7gpGRdRsFrqOjcPLcD5N0JkSSx7IZNn1ZSnrkjUjQA/hC8sPW1Vm8dCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708676; c=relaxed/simple;
	bh=SufLlieLPi30s2oUf6upuvEwfnEEEnd9WcXCLJs+rlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epXtqlDMoGG4XOStrY9ChDHkzvWyr8QVyE/MeWZBSEKYq/IUJGruhGRdP+vrQEsAT3UlRzSiPzj9s37Ce/OR5WLN0u2jc03stibPCE5S5G6yB739aNdiVSl+GHBxZ1En+JEq6AXapDBCI4Vi+dK5X2tcxej6HRWLtvbMR/2dFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvAQz9NU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC06C433F1;
	Wed, 31 Jan 2024 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708676;
	bh=SufLlieLPi30s2oUf6upuvEwfnEEEnd9WcXCLJs+rlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvAQz9NUXEyRz6+czwnE77MfGpkOH3eSWDY8Zl99XrKJGD1215l5xG2U3Txkpyo8V
	 TF8d5C352ehdqzu0iZl8LCpY69rUtZ35U3rJyz4MEzeee1gqs/Ok+f4s+ekbYNh/gR
	 PLTzYqX4gGOLF2bJVfiec0+72XnWz6ny3oKhu31oFkyVe4ozZ5peF3YdbjdV7XCOsV
	 mP9HlMDflw5W+ZqdT/yrLcSf5vAyiX6md6kh3Xf0CAKZpnDJf15YeaVcxd0pD+Y+xQ
	 d1zU56fJb84AjqyKYBHP7kfNZC6STgAAtoC7wxXos54z0LyVdmR0+ymCu79E/w9mxJ
	 uT6AHgQUTcW6A==
Date: Wed, 31 Jan 2024 13:44:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: Remove QDF2xxx workarounds
Message-ID: <baf69674-7c69-4658-94ad-9b39fbb9924d@sirena.org.uk>
References: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VHVeAKT+Ivue9xIg"
Content-Disposition: inline
In-Reply-To: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!


--VHVeAKT+Ivue9xIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:27:20PM +0100, Konrad Dybcio wrote:
> This SoC family was destined for server use, featuring Qualcomm's very
> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> cores with small modifications). It did however not leave the labs of
> Qualcomm and presumably some partners, nor was it ever productized.
>=20
> Remove the workarounds, as they are long obsolete.

There's one in Linaro's test lab which gets used by KernelCI:

   https://lkft.validation.linaro.org/scheduler/device_type/qcom-qdf2400

While the platform is pretty old it works well enough and provides
coverage of server platforms, ideally more server vendors would arrange
for their boards to be available but that's not actually the case yet.
The fact that it's a unique implementation of the architecture is also
interesting from a test point of view.  Given how trivial the workaround
here is it seems more useful to keep the support, could we revert this
commit please?

--VHVeAKT+Ivue9xIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW6Tr4ACgkQJNaLcl1U
h9B9Jwf9ErQmschUIsVwr8nKmYwbiT7i3p6aBGhCbWLgbOFRvxAOfBOBHfx4UBh+
Xg88cq84Qh2ViVq1JpZRK3ZCFtnAUrT13msU7yn29FcWY4rhmaNUz5v9NOdPeQrl
12esM54mw0ikNGRxFpSVkFsQbQ/3/c7A8DR3Hd6yPvQgRqJ9RyXHxYlfFQYZmDm/
sV1EgW9A0feAyywwRhgPVuqQvGlreZecmB72RGaMXhSSb47mWVvoWssf1MHEP0cB
u+jaeCyXvlQJ1nOkcLwRH6NeUwW78MRW3namv9k2TU7wjwt90mobuAjGpqlkb/U7
UyOcS08aNIPsO3wgazntQZWtwq3g4g==
=g0T5
-----END PGP SIGNATURE-----

--VHVeAKT+Ivue9xIg--

