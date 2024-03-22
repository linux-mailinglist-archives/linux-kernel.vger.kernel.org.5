Return-Path: <linux-kernel+bounces-111925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9208872C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF522826BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C756312B;
	Fri, 22 Mar 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obdcky9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97571629E1;
	Fri, 22 Mar 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131296; cv=none; b=n0TP8KDzrtqqXnzuA1fRf25jZXbcKF11nh2kb9P8nva54O1d9adU0UbmzMbPsHqRxLM0/WMq5V2olmt8Bp7skAKJugg9sDAADowXHbnswMn+dCLbahrZNUMdIVwlV9fiVBlFegIKMB8pSKmV59goRRonuKyaKEnmSr+Wkpzqg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131296; c=relaxed/simple;
	bh=DEavfyTSzhSIPEVOuu8RE2UhFHpGDtsEP2ybPexmXYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Nx85dAfDe10iLsiHlB67BwEv1CCWBBED8kD0JIbut8xHNd9cJkijg1EPSDah/OO5zD9pFVLYMj9HDv/nFMH0+JKqv+pHwEODBMJaAtrPMo9mPk1Vb7eex7r+FP3fRT3KkvtKWGEqqH53s/pgbIreVicMOwx2Qx3BPSU2sOgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obdcky9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D7EC43390;
	Fri, 22 Mar 2024 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711131296;
	bh=DEavfyTSzhSIPEVOuu8RE2UhFHpGDtsEP2ybPexmXYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obdcky9nxyxFzet8aQsd7STsnAvEhd/fahMSbiqN2Ir+Bu9+8jqzl6flZHCSE6Nb6
	 gpeQINSQ/qUPNmalQ2EjlsytcdsryU+BOebyXMMDGWvV/OVnnviPLMiFB1uShvy1zs
	 cml6xh9FHWtWl8tGdPg9HjZiS0V2wvN6KQ8UpzwiOHQBu6mchQql61eMiTYZLVr5DP
	 JB9wHpjHaPvdwPZOMWstvd0CDhcGUyvelpBT7cxiPKPSj0LQ5/IFuK3Kp1PnF/NCoJ
	 3uNBFDnCm754aVh1dSgkGTT54+PUhMAfLeXgxM66X8FlC2fmzBD+wS99LuhajZfmMD
	 /R0ow9HkZqKMw==
Date: Fri, 22 Mar 2024 18:14:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Message-ID: <20240322-stool-hardwired-036a30767775@spud>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
 <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
 <20240318-scarf-startup-64088b1d8d35@spud>
 <fa047914-da03-4234-b48f-eebdf350795e@linux.dev>
 <20240319-fondling-implode-322a9cb570b8@spud>
 <d947cb15-aafc-487e-8bbd-54d786683470@linux.dev>
 <024ca6eb-c3d8-4764-946e-1070d1bfb806@linaro.org>
 <bcb82d05-3c8f-40f4-a8d3-a0d7c17497b3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B4lVthT6dLZC1AjG"
Content-Disposition: inline
In-Reply-To: <bcb82d05-3c8f-40f4-a8d3-a0d7c17497b3@linux.dev>


--B4lVthT6dLZC1AjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:26:10PM -0400, Sean Anderson wrote:
> On 3/22/24 03:01, Krzysztof Kozlowski wrote:
> > On 21/03/2024 17:21, Sean Anderson wrote:
> >> On 3/19/24 13:55, Conor Dooley wrote:
> >>> On Mon, Mar 18, 2024 at 11:48:06AM -0400, Sean Anderson wrote:
> >>>> On 3/18/24 11:40, Conor Dooley wrote:
> >>>>> On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
> >>>>>> On 3/17/24 11:10, Conor Dooley wrote:
> >>>>>
> >>>>>>> Additionally, should
> >>>>>>> they fall back to t1023-sfp? I see that there's already some dts =
files
> >>>>>>> with these compatibles in them but seemingly no driver support as=
 there
> >>>>>>> is for the t1023-sfp.
> >>>>>>
> >>>>>> I checked the reference manuals for these processors, and all of t=
hem use TA 2.0.
> >>>>>
> >>>>> Sounds like a fallback is suitable then, although that will require
> >>>>> updating the various dts files.
> >>>>
> >>>> Yes, a fallback (like what is done for the T-series) would be suitab=
le,
> >>>> but given that these devicetrees have been in-tree for eight years I
> >>>> think it would be preferable to support the existing bindings for
> >>>> compatibility purposes.
> >>>
> >>> Just cos stuff snuck into the tree in dts files doesn't make it right
> >>> though, I'd rather the bindings were done correctly. I don't care if =
you
> >>> want to support all of the compatibles in the driver so that it works
> >>> with the existing devicetrees though, as long as you mention the
> >>> rationale in the commit message.
> >>=20
> >> It doesn't really matter what the schema has as long as the driver sup=
ports
> >> existing device trees.
> >=20
> > We do not talk about driver now but bindings. You add new compatibles on
> > a basis that they were already used. This cannot bypass regular review
> > comments, so if during regular review process we would require
> > fallbacks, then you are expected to listen to review also when
> > documenting existing compatibles. Otherwise everyone would prefer to
> > snuck in incorrect code and later document it "it was there!".
>=20
> To be clear, the existing nodes look like
>=20
> 	sfp: sfp@e8000 {
> 		compatible =3D "fsl,t1040-sfp";
> 		reg	   =3D <0xe8000 0x1000>;
> 	};
>=20
> which is perfectly serviceable for read-only use (as the clock is only
> necessary for writing). As these devices are effectively identical, the
> compatible could also look like what the P-series has:

I'd rather you just picked the oldest device and used that as the
fallback, rather than introducing an "<blah>-sfp-2.0" compatible.
The 2.1 and 3.0 ones don't have anything like that.

> 	sfp: sfp@e8000 {
> 		compatible =3D "fsl,p2041-sfp", "fsl,qoriq-sfp-1.0";
> 		reg	   =3D <0xe8000 0x1000>;
> 	};

None of the seem to be documented either btw:
rg fsl,qoriq-sfp-1.0
arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
371:		compatible =3D "fsl,p5020-sfp", "fsl,qoriq-sfp-1.0";

arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
339:		compatible =3D "fsl,p2041-sfp", "fsl,qoriq-sfp-1.0";

arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
386:		compatible =3D "fsl,p4080-sfp", "fsl,qoriq-sfp-1.0";

arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
366:		compatible =3D "fsl,p3041-sfp", "fsl,qoriq-sfp-1.0";

arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
331:		compatible =3D "fsl,p5040-sfp", "fsl,qoriq-sfp-1.0";

>=20
> but in either case, it is desirable for the driver to match based on the
> more-specific compatible (as well as the less-specific compatible) as we
> already have enough information from the more-specific compatible to
> select the correct implementation.
>=20
> --Sean

--B4lVthT6dLZC1AjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3KmwAKCRB4tDGHoIJi
0qy6AQCy2Mqzl0FytfXDnfzIChMNhJ1Vd131DSEeOB7C/luO0QEAr5rdhiuDdOpC
x68Dl5Hpq3juPiE/iC7Vz53EGKEEHQM=
=EDr5
-----END PGP SIGNATURE-----

--B4lVthT6dLZC1AjG--

