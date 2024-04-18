Return-Path: <linux-kernel+bounces-150456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0958A9F99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19ECB242C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92D16F8F3;
	Thu, 18 Apr 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TftbM3dO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D502168B0D;
	Thu, 18 Apr 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456494; cv=none; b=EeZExZnEcgmrBecOFjm7+PiXz5nma5A9URP2Tyw+xwlHlFl376wsgJ5d11LNUqv7s4Gn6enr/1W88T1pThGkOMgEZY9+7KGu102CIr6icwbzJoemU45m4Rw40pRf+Wt4lSat80olu7dUaeB0SCLtdlF5zu0WB3xIOwMBQI9FoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456494; c=relaxed/simple;
	bh=rkrTpsLO+50r5ibEQOEvU3vQMmfUVtgFiQ5k83m5StM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUPuHCssJyNBmxoAzQ84znEBOrxRUvArwW73t6gj8WZ4f2p4+j5jQJ2YyBZL7fGtFlKNGJigXJutBMbUM/lLkSaA+qsYk9LHpHZuONGQ9/th+Y8AWP9QIyFlMfvHd3Kjf/eGX7OWDcbczQVSMEkwpF46syhC2n45wYV5MUZxFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TftbM3dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C54FC113CC;
	Thu, 18 Apr 2024 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456493;
	bh=rkrTpsLO+50r5ibEQOEvU3vQMmfUVtgFiQ5k83m5StM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TftbM3dOE3svEIaqrs8h/enmkXGrctoHLiseUF3xQMbQvYuNBYPYXtIAbtEonZ5b1
	 41TO3gaVUdFt3J52keySYXF+cB4AfcNmvXY4z2m/R31WbwOFgffs3GuPoagJqG+PWk
	 1YDt8QAR76YXXN5ZOy6B5Q9TXC3cX+UBFZSHUb2RAVsYzUREmpv3qGMzyCizDLjUi8
	 F6O9Pyj0boTNTgetVQOl58vEVR/ZoQshLTyHAIbiibz/7uC61KyIy1tfU+Mfe4TcMV
	 AheGu7QrCaOrVlc+1rBv1za5Y03RUdUGODesrbMktYMEdOOiHdGZzmh+lvBP1YJne2
	 hgJ2wfppFkKZg==
Date: Thu, 18 Apr 2024 17:08:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: liujianfeng1994@gmail.com, krzk@kernel.org,
	linux-rockchip@lists.infradead.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, mchehab@kernel.org,
	p.zabel@pengutronix.de, robh@kernel.org, sfr@canb.auug.org.au,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: media: rockchip-vpu: Add rk3588
 vdpu121 compatible string
Message-ID: <20240418-tipoff-neon-8c1fa60385cb@spud>
References: <2a516484-ea87-444e-a89d-9fe33d08148f@kernel.org>
 <20240413155709.802362-1-liujianfeng1994@gmail.com>
 <1774986.o0yEF5yP89@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sKET8aOPU1iKBZV1"
Content-Disposition: inline
In-Reply-To: <1774986.o0yEF5yP89@bagend>


--sKET8aOPU1iKBZV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:19:56AM +0200, Diederik de Haas wrote:
> On Saturday, 13 April 2024 17:57:09 CEST Jianfeng Liu wrote:
> > I'm sorry for my unkonwing about the kernel patching process. And I'm
> > sorry to let maintainers do extra work. Thank you for teaching me this.
> > I will do this right in future patches.
> >=20
> > I did received a Acked-by tag from Conor in v4:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > I note it here in case someone forgets this tag.
>=20
> I think it's beneficial to send a v6 with the following changes:
> 1) Make this dt-bindings patch the first in the series
> 2) Make sure you've collected all the tags you've received to all the pat=
ches
> 3) Specify the base commit
>=20
> ad 1) I don't know if it's a hard rule, but I've seen a consistent patter=
n=20
> where the dt-binding changes come before those changes being applied to=
=20
> DeviceTree files. It also makes sense as when the dt-binding change hasn'=
t been=20
> applied, then the DT file is technically invalid.

It is definitely preferred, since there is tooling that checks for
undocumented compatibles etc that would see spurious errors during
bisection, were that to be done. Generally I wouldn't suggest resending
for the order though if it were the only thing amiss.

> ad 2) You shouldn't make maintainers do extra work to get your patch(es)=
=20
> merged; you want to make their work as easy as possible. Thus you do the=
=20
> (extra) work and provide a new version of the patch(es).
> Sending multiple versions in a single day is generally not recommended as=
 you=20
> should give reviewers some time to do the review. But it should be fine n=
ow as=20
> several days have past without new reviews.

I dunno, the best way to save our time is to not omit the tags in the
first place (or give a reason as to why you did) as we'll likely pull up
the previous version of the series to see if all comments were
addressed, if made by another maintainer (at least I do that and Krzysztof
must have here). In my workflow sending another ack takes much less time
than looking up previous versions and checking to see if things were
dealt with - probably that's in-part to me lacking automation for dfn:
lore search from mutt though..

>=20
> ad 3) The `git format-patch` command has a `--base=3D<commit>` parameter =
with=20
> which you can make explicit upon which commit the patch is based.
> That works a lot better/easier then a textual description.
>=20
> HTH



--sKET8aOPU1iKBZV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiFFaAAKCRB4tDGHoIJi
0o0pAP9fk55H5h1zSZnxIKk23cdN+HBXKww/TkXCqriIsMnC6gD9F54oAW2uS2/S
BilcF9zkehoRlEKSh4CiiY5wD9hLGAM=
=YI8b
-----END PGP SIGNATURE-----

--sKET8aOPU1iKBZV1--

