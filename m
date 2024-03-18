Return-Path: <linux-kernel+bounces-106318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18487EC51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F00D1C20F34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78222524CC;
	Mon, 18 Mar 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrzZclb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980C524A7;
	Mon, 18 Mar 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776450; cv=none; b=suhnO4NV9wuk/1RcF+Um3Ver/+bcF/sYrZT6mhBOLIy7ywWRg75dz9AVQSdALAPkmy36taN6prSbcYBhVOQdNko4F9TQCI5wZSbMTNCclyPmr+AWAPjgw178C5Plb/NgtweN96PMJoq1recbrwKK1x6/QT/4qTwFx9Xvzru4u/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776450; c=relaxed/simple;
	bh=BWzf2n/KTk2PSY4rMGTnXkmXBDUr6l004eJsSKiOu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpss+aEXIGSr+7DY18LE8a0k7+A4d23tp33RB1eJacUmPashncqMslh45hYJ5LypNrbqvT/4Hk60v7TvAUs+7iaXFZmIc0MZTWCQv5r9vv/L7WqCrS81D3DHlr6qGDTy2zpYygIBLfVBzuR/K4Stymyw80z3CcqJky5m5h/WD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrzZclb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EA1C433C7;
	Mon, 18 Mar 2024 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710776450;
	bh=BWzf2n/KTk2PSY4rMGTnXkmXBDUr6l004eJsSKiOu4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrzZclb3yz5DwSbQgxqwFkkV5Twue7bEammIVZgyNP0P7rbX/YUkk3HEuuSfS9vXd
	 FGXHXi7cNrsUuEdtorblwVp3ppbJZMF+BvLeOulQvAdy4ngPiGoq2crDjmfjUEbMot
	 PvJSArnqyl2WDdJO1e/FbGq3o4vXZNtbZpSTkGmog4SKR1Zjdn2a7SaDHNGNBvbt6i
	 VuJ5JqD8ds4L6IDvxHJNuXkOehbY/4GxxxdQ4LyglvTsSflH64tXtTaIWO61fVInLx
	 3nZmamYAVDwsRoChmCO3OhOhXtqUAsagRi1BnOwqD/wCMLTB7OmyyaMHB+ikdOhpCl
	 nAAHAJQveWRhg==
Date: Mon, 18 Mar 2024 15:40:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Message-ID: <20240318-scarf-startup-64088b1d8d35@spud>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
 <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FQWX5uVVzShudAkP"
Content-Disposition: inline
In-Reply-To: <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>


--FQWX5uVVzShudAkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
> On 3/17/24 11:10, Conor Dooley wrote:

> > Additionally, should
> > they fall back to t1023-sfp? I see that there's already some dts files
> > with these compatibles in them but seemingly no driver support as there
> > is for the t1023-sfp.
>=20
> I checked the reference manuals for these processors, and all of them use=
 TA 2.0.

Sounds like a fallback is suitable then, although that will require
updating the various dts files.

--FQWX5uVVzShudAkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfhgfQAKCRB4tDGHoIJi
0qZ6AP4rkLHy/4pwZojB1H3D+KiEMKD2xUu5hFOCsowil0D49QEAl2dM5eOwFfvn
PRCDFWdm/SjfCtIDqsSwItApGL9aPAA=
=fUTW
-----END PGP SIGNATURE-----

--FQWX5uVVzShudAkP--

