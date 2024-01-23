Return-Path: <linux-kernel+bounces-35614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A07839413
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0881F23C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1401E612EA;
	Tue, 23 Jan 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlFPkc9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D185FDC6;
	Tue, 23 Jan 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025760; cv=none; b=JVXyYb23SqCXlcqFMzy0S6ppJqadYDbABLYFX21RTqejAfCKmVjBuBHpjM52o0pN1dBxTNKcjM6uWxFQvE1RDhd8h6MKPfY8K+kHCY1GF7+5HRv9p4r+cYJ1vdN+v3Ri67tGxRVmwrjSCz6uImc4TPwC48ZEZynMS5VZ0ub+7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025760; c=relaxed/simple;
	bh=6iomC1fv6XGKLh/5wOuoJeeMuD80o9yncgsidbFuLPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoYl/2J4Vnriz0328eE7wrOyOuaBdUGv9tgs1JAq/l31Q5PmxE2eRd1rznYh4aZlNSMWF1wqermFCPAd55SzvaXibDfGqe0yytSJM4l8h09Cp4kUIBXLyUk8ZSSAobQV4hpHIsx4SfmP8oQDkd+BzrZTCVpQU/Mdzx0gqaF1Pnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlFPkc9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9407C433C7;
	Tue, 23 Jan 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025759;
	bh=6iomC1fv6XGKLh/5wOuoJeeMuD80o9yncgsidbFuLPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlFPkc9haUkscVMtVhapVvG6jz3mm5RZ2lNLMQhlD1+86UeJMJaqI55N9V0vLKhDw
	 8SJ5O2/qLzEVJXuWPFpG1OvnJCkYz5T/MZsr+7sgnE6X3jcYcQ2qJ4bFtx5M7f7VfB
	 Nd8X66vzboN900SwkbUmgr5sm0weT+qJukLW2GmxdcH4txTtH+A6KmF2p/+iSLdm+v
	 skGSO11YE0/JMP6Vl80Omwb+oP30YcJiDliuloOrum4AMUpML5Oz+pLHC6gbZrORXM
	 O9jGkSmNMp9KUnrTM6t2dtVv9X7SOX5GBKQt+3kNfyc2ZEU8ycNI0W9Cy+SK+bVZLZ
	 d09blVTbqdnnQ==
Date: Tue, 23 Jan 2024 16:02:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Seven Lee <wtli@nuvoton.com>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <20240123-brewery-roving-b9ebc70468f4@spud>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
 <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
 <20240123-bottle-elevating-9fbba5424014@spud>
 <185f3912-5a92-4ef2-aac4-0df8363d8727@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CZOKZjrI+J1e9HlH"
Content-Disposition: inline
In-Reply-To: <185f3912-5a92-4ef2-aac4-0df8363d8727@sirena.org.uk>


--CZOKZjrI+J1e9HlH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:06:45PM +0000, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 08:34:03AM +0000, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 07:40:51PM +0000, Mark Brown wrote:
> > > On Mon, Jan 22, 2024 at 06:00:14PM +0000, Conor Dooley wrote:
> > > > On Mon, Jan 22, 2024 at 05:56:49PM +0800, Seven Lee wrote:
>=20
> > > > > +    enum:
> > > > > +      - 0 # VDDA
> > > > > +      - 1 # VDDA*1.5/1.8V
> > > > > +      - 2 # VDDA*1.6/1.8V
> > > > > +      - 3 # VDDA*1.7/1.8V
>=20
> > > > I would also rather than this enum was used to have sensible values=
 for
> > > > the enum itself (which I suppose means strings here), rather than t=
he
> > > > register values. Seeing "nuvoton,dac-vref =3D <2>" in a devicetree =
is not
> > > > very meaningful IMO.
>=20
> > > Do you have a concrete suggestion for how to more clearly write these
> > > directly?
>=20
> > I would use what's been given as the explanation comments for each of
> > the current enum values in the patch.
>=20
> Given that none of *, / nor . are usable in defines that's going to need
> a bit of massaging...

At the end of the day, if it is too painful on the driver, then I'll
live with another enum. This is one of the worse cases of this sort of
enum that is clearly a bunch of register values, given there's not a
"nice" explanation for them.

--CZOKZjrI+J1e9HlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/jCAAKCRB4tDGHoIJi
0rzSAP9jk8KYC7hIX1HdXqnBFVDfINXYg5zeasUhnLdvnkiJNwEA63S74iCvYyqD
L2y649pIe19v3rQ2TUGetH88CEsCxgI=
=VtcS
-----END PGP SIGNATURE-----

--CZOKZjrI+J1e9HlH--

