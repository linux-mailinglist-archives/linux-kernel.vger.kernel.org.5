Return-Path: <linux-kernel+bounces-79009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC087861C30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76851C21499
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17E143C4D;
	Fri, 23 Feb 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma/O6afa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587D125D1;
	Fri, 23 Feb 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714587; cv=none; b=HzpfUZ3KC1jQkLVzdAJMRS3N/WjfmBWoqzOF2ysp/LkDbG4i/tK/8aMdtAz8+1BDiCEvB9SnS676GVf66duSIqRuPrpwoej5ZBRPY4sXewxztgK53GUfdP34SVDw29+LdD8slYcuth4GREP8eWRXrSJgA/NqhOxeaeXiHCZ4oJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714587; c=relaxed/simple;
	bh=92v8dqYoQe0iX+4jAPOv06DZwhWuz2g6WcnnQUex/Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKtjLV9mI9JPHJ3t/cL+pKbjbfcAXhlGpNFbJ2EdKgz8qs7tLLdzknkuTLnQsbXpMZj5TttdcTlEaCxQXnInQZj0Dd7aShZW2jhQEMWndttSGlvluHi1cg4S7q3jNPZhIHvjbPPqQuun75KHyim3s4DZf/Qg7mC8QHot7uX242o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma/O6afa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E74C433F1;
	Fri, 23 Feb 2024 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708714586;
	bh=92v8dqYoQe0iX+4jAPOv06DZwhWuz2g6WcnnQUex/Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ma/O6afag1lu+G6qSE6ZHE/afi7v0njoztfieEfet3YitV2DTYNkMjYA1qjQZMupF
	 e+hP5RGpdKb4LM+Vy/wVzveSW3dh6MzE+Xe9FnNv8eXR4K0LxS9XSXNoNaEht548F5
	 rQQyjSgd7T3I3gMkIK9K4i1fK0J/D0eHo9Cz+bWhCSvMJXFdJhj/Ojqq0KSFHKcf9O
	 FU2KBVGswGcXVVA++lZxinDtdJDbRHLgoHbf1Q2DwYhR1qqjrYbFa3McRq08oSmm2N
	 vpumBXTlEyECJOeZjLY2YY/5u46jDpM4A3fpec/owucX3QgZT8h/Ha+U/pKnfhrCXO
	 vADUqJtyyhgwA==
Date: Fri, 23 Feb 2024 18:56:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: Mehdi Djait <mehdi.djait.k@gmail.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 04/14] media: dt-bindings: media: rockchip,px30-vip:
 allow for different variants
Message-ID: <20240223-repose-snuff-54d75755e9f7@spud>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
 <20240220-v6-8-topic-rk3568-vicap-v1-4-2680a1fa640b@wolfvision.net>
 <20240220-catchy-cupcake-e600e5af7650@spud>
 <5bb0b0a9-3d4c-4303-aa43-38789bee286d@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c2uw00hLgTWLWAIx"
Content-Disposition: inline
In-Reply-To: <5bb0b0a9-3d4c-4303-aa43-38789bee286d@wolfvision.net>


--c2uw00hLgTWLWAIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 08:03:20AM +0100, Michael Riesch wrote:
> Hi Conor,
>=20
> On 2/20/24 19:58, Conor Dooley wrote:
> > Hey,
> >=20
> > On Tue, Feb 20, 2024 at 10:39:14AM +0100, Michael Riesch wrote:
> >> Move the documentation of clocks and resets to a allOf: structure in o=
rder
> >> to allow for different variants of the IP block.
> >>
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >>  .../bindings/media/rockchip,px30-vip.yaml          | 58 +++++++++++++=
+--------
> >>  1 file changed, 37 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip=
=2Eyaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> >> index 675a1ea47210..7168f166798c 100644
> >> --- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> >> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> >> @@ -24,32 +24,16 @@ properties:
> >>    interrupts:
> >>      maxItems: 1
> >> =20
> >> -  clocks:
> >> -    items:
> >> -      - description: ACLK
> >> -      - description: HCLK
> >> -      - description: PCLK
> >> -
> >> -  clock-names:
> >> -    items:
> >> -      - const: aclk
> >> -      - const: hclk
> >> -      - const: pclk
> >> +  clocks: true
> >> +
> >> +  clock-names: true
> >=20
> > This is, unfortunately, not how we like multiple soc support to be
> > handled. Instead, the widest constraints are added at the top level
> > and constrained by the allOf. If none of the names etc are shared, at
> > least the widest constraints for minItems and maxItems should be able to
> > be here.
>=20
> Just to make sure I got it right:
>=20
> clocks:
>   minItems: 3
>   maxItems: 4

>   items:
>     - const: aclk
>     - const: hclk

If the names themselves are all different, I wouldn't bother with this,
and just constrain the numbers at the top level.
Otherwise ye, on the right track here.

--c2uw00hLgTWLWAIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjqVAAKCRB4tDGHoIJi
0sgDAP9NYmoVCik3KPzxF03GN7LgK3kwRDne9lST8Qo/eYyBHgD/V//mwx3Ir5bf
1SauEFkTl53Jdn4kpgjw4RAfMwEhDg8=
=E6bW
-----END PGP SIGNATURE-----

--c2uw00hLgTWLWAIx--

