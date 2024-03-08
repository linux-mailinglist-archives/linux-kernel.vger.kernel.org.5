Return-Path: <linux-kernel+bounces-97330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0A8768DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FEE1F214A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9818B1B94E;
	Fri,  8 Mar 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMxSm6nY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB381C2BC;
	Fri,  8 Mar 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916621; cv=none; b=L4bVjbdTORCR1ibs+YhlwXRPBzVh4HrYs/2n0P/yqjS7rPA7n/FSJWFWS1qL53urSebD/ys1U0vBneJHDMO+wPbpIG8z7detB46PSqRTnRHFvNynV/8sl0gw5YVsRvcZxaDQhOaqZOA29gIgg3DnNpgWJYSSaT+NJNiM/lp0qxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916621; c=relaxed/simple;
	bh=j8B0Mnr7gZ1c43Rkz5y5HQ2cNt70Z/gVxxFt62Y5pPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/V5PqAt7l4jUFmDK+eLXoOfbLRbxu6fcwWLZaASeiAXb6kDLBEVswlC+sx6hClWoL5urj4+goQeuxMEBqJYYcmSl81mV+ElsBn7HayFI/eyDXdNQPXZ14j4J8aHbkHUQsN3Iu4PEIJ8El29pK3S/8Y5af7T8DTiVD9aBx3O3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMxSm6nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDF7C433F1;
	Fri,  8 Mar 2024 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709916621;
	bh=j8B0Mnr7gZ1c43Rkz5y5HQ2cNt70Z/gVxxFt62Y5pPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMxSm6nYTHIJuhc+3PaAQjHLvfR3TfRhS67RJxZxok0diPEStJLFqQb0dkq6y87tR
	 iAjmrwMbJ4/Ja0MWiJnnfAWd+mo5TOZcpDhnxRf9edaw9T/PUU3smEGJfq/PITT1js
	 E+Ge/3AXwCkNB5XSMRYNz9IvJ0FmEXKkCI4yz2T3qbwLCQZ03dF3c0tXZVUGZn+E/a
	 /rVBUg9UOifnfcxUsf+t5SxpUi9xdG8TaNfDWoiNucC7vOGoTzMUm03zgqpQYkUlHI
	 KsjztzI4AuRMP/3feNzx48GPxS84x5hQOk+ezMEUXAubvjIeKDdIbTmkHRfpbbBEfp
	 RV8wj7Cr9JOag==
Date: Fri, 8 Mar 2024 16:50:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v4 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Message-ID: <20240308-blank-issue-857c16294c17@spud>
References: <20240305152608.287527-1-julien.massot@collabora.com>
 <20240305152608.287527-3-julien.massot@collabora.com>
 <20240307-retract-aloof-9ff1fde79a82@spud>
 <8f6972a1-e174-4c0e-808e-afece9b529bf@collabora.com>
 <20240308-footnote-landmass-e1efcaf72a6d@spud>
 <7d0197b9-9008-4260-86e9-4b7f7017b3b6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W40v6fOy9DpPu/pY"
Content-Disposition: inline
In-Reply-To: <7d0197b9-9008-4260-86e9-4b7f7017b3b6@collabora.com>


--W40v6fOy9DpPu/pY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 04:48:16PM +0100, Julien Massot wrote:
>=20
>=20
> On 3/8/24 16:07, Conor Dooley wrote:
> > On Fri, Mar 08, 2024 at 03:08:12PM +0100, Julien Massot wrote:
> > > On 3/7/24 20:21, Conor Dooley wrote:
> > > > On Tue, Mar 05, 2024 at 04:26:06PM +0100, Julien Massot wrote:
> > > > > Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
> > > > >=20
> > > > > Signed-off-by: Julien Massot <julien.massot@collabora.com>
> > > > > ---
> > > > > Change since v3:
> > > > >    - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
> > > >=20
> > > > Why? The filename should match the compatible, which /does/ have an=
 f.
> > > All the work has been done on MAX96714F variant of this Maxim GMSL2
> > > deserializer.
> > > The driver and the binding remain suitable for all variants of this c=
hipset,
> > > since they share the same
> > > register mapping, similar features etc..
> > >=20
> > > MAX96714 exists in different variant: MAX96714 / MAX96714F / MAX96714=
K that
> > > will be easy
> > > to add support for this binding and driver later.
> >=20
> > Either document the non-f version if it really is that similar, using
> > all of the same properties, or name the file after the version you've
> > actually documented. I don't see why this particular case should be
> > given an exception to how bindings are named.
> >=20
> > What is the actual difference between the f and non f versions? Is it
> > visible to software?
>=20
> Yes there are a few differences visible to the software, for example the
> GMSL
> link rate since MAX96714 support 6 and 3 Gbps, while MAX96714F only suppo=
rts
> 3Gbps.
> the registers map is the same, but a few values are not possible with the
> 'f' version.
>=20
> I will add a compatible for the non 'f' version, and will do the same for
> the max96717 binding.

It's not immediately clear if that means that the f version should be a
fallback for the non-f version, but sounds like it could be if the
difference is purely that there's a reduced set of link rates or
similar.

--W40v6fOy9DpPu/pY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZetByAAKCRB4tDGHoIJi
0htFAQCAGppnh/GHai75MVlT/b9AYRkgXulrdtlLA0WKqO4j8wD8DpKGzCGrayAO
kmkKQV5kZ2cr4pNpysciMQAsApZZfAA=
=Mxh+
-----END PGP SIGNATURE-----

--W40v6fOy9DpPu/pY--

