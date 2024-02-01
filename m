Return-Path: <linux-kernel+bounces-47778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E48452B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426BA1C25C69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E6159594;
	Thu,  1 Feb 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Dhlfos4y"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F57208DD;
	Thu,  1 Feb 2024 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776150; cv=none; b=eAfwL1PbBQLlMagX15txgcU8kJURMkURNU4iucRb3ZLNi1iyGJuO4jJbiFEFXWaIpqeWko/xScPlHeLsjlbPtEygycdx3lvrKtUZNKqsVOjIwZTUpZm1g16mrJCZmL5q0LsXEIa0AFluzBt1yn2J+45WR7CFDKod7jE+gCIxB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776150; c=relaxed/simple;
	bh=aAEPwHBMhvs06qKUqIQOH0eIMJYGZLZUqs6EJXIJ6Vc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxI0Sx3NalBh/c4OB3Ybz0eYovLHewQQXLra5CtKOX7R0ckRNmVsuqMUPjx1a4T3k61IB3c1AFyGsXZVF5BRHAVgSFK8DdS3WVEPIGmlynUwG0qtiNA31BZj4fsKI3omimHdFnw9BdqoyvNVkw/ub0qzRNf/M2+vGImFHCyBW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Dhlfos4y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706776150; x=1738312150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aAEPwHBMhvs06qKUqIQOH0eIMJYGZLZUqs6EJXIJ6Vc=;
  b=Dhlfos4yUPCq4kBpD8Flx/cE5BxfdI1SinXVJJbbDPlsnI8yCKzrFULv
   c52Jg4+YA7DHXuI5K7TLJPuvALTAxslb+6DmdVc/c9BNuZGO4Rcmp41vA
   uIVazlvx/wXTuKR0AQkqOoI5Kqh9nqOVGyphpHBaiSf1l4wb/oeAb7Nog
   Mcgf6T0RHOPYLRLEKzzMZ+UAtn3kiNLphUAyNjHLh9wRPXb2FP4/Bx2tZ
   56FSO/j0tW84h32cFStsvqADynAJrVbZWHUNtXt9uZ9K71oKFADx42J50
   XgliG1sYvDg0KJkUYJnxA9qd2xTaaMPq5Ge0StmJ6ouKB0lhRCw870v6s
   A==;
X-CSE-ConnectionGUID: BKt1nUV+QE+jut1LZSBZSA==
X-CSE-MsgGUID: zGYG3IuvSuCoVTuOFUOF7A==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="asc'?scan'208";a="15607613"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 01:29:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 01:28:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Feb 2024 01:28:43 -0700
Date: Thu, 1 Feb 2024 08:28:04 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: =?utf-8?B?5b6Q5rC46KyE?= <ythsu0511@gmail.com>
CC: Conor Dooley <conor@kernel.org>, <jdelvare@suse.com>,
	<linux@roeck-us.net>, <corbet@lwn.net>, <Delphine_CC_Chiu@wiwynn.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Message-ID: <20240201-peso-album-360208dc74c0@wendy>
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
 <20240131055526.2700452-2-ythsu0511@gmail.com>
 <20240131-eraser-given-8381a44f41a4@spud>
 <CAE+7-j=uWxQhEVF4YhAGmyjrryzMxF2E9Qi6xgRVYwusmaZMMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CCoDc/ir44IAA2yC"
Content-Disposition: inline
In-Reply-To: <CAE+7-j=uWxQhEVF4YhAGmyjrryzMxF2E9Qi6xgRVYwusmaZMMw@mail.gmail.com>

--CCoDc/ir44IAA2yC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 08:34:32AM +0800, =E5=BE=90=E6=B0=B8=E8=AC=84 wrote:
> On Wed, Jan 31, 2024 at 11:41=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
> > > Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
> > >
> > > Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b=
/Documentation/devicetree/bindings/trivial-devices.yaml
> > > index 79dcd92c4a43..088b23ed2ae6 100644
> > > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > > @@ -129,6 +129,8 @@ properties:
> > >            - mps,mp2975
> > >              # Monolithic Power Systems Inc. multi-phase hot-swap con=
troller mp5990
> > >            - mps,mp5990
> > > +            # Monolithic Power Systems Inc. synchronous step-down co=
nverter mpq8785
> > > +          - mps,mpq8785
> >
> > q sorts before 2, otherwise
> Okay, I got it.

Apparently I am wrong, sorry about that! Please ignore this comment.

Thanks,
Conor.

--CCoDc/ir44IAA2yC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbtWFAAKCRB4tDGHoIJi
0sbKAQDIDuEx9DkoRbJqLhVfM+jO7J1InETLgtByeLSDmNDzAQEAlKELUYFDeKFJ
4UrgmTlYHnO7hCz2iY6GhpHAfvH+oQk=
=C6+A
-----END PGP SIGNATURE-----

--CCoDc/ir44IAA2yC--

