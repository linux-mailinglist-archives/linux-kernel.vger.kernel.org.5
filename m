Return-Path: <linux-kernel+bounces-62111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B5851BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B831F23D20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A03F9E0;
	Mon, 12 Feb 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIj5PTad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F973F9FD;
	Mon, 12 Feb 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759261; cv=none; b=FO0XOQlty+EtQGOG7kxEbojWXEDSCk2/bcCg1khSL2EZ3tnqm6dCxUzX4XeV/vkuKfHseZgyZKwHA8EqwzlkOGu29T2Ta4oCmDM9IL6vw5UAA8lrtISg48BWy0D67RZJSKevmH1+rJYBfwsKnv/7FgfDNRMfc7CyMtnlLyPG2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759261; c=relaxed/simple;
	bh=viUeDktGlffUbGubUITq4jf7HIhZr28ZVIahNTPb2L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVjsRczym+ZMm8kcfykh1t0KU5IqdKmo3wz6Z12fo9MZ+TyhrakbLeJ+rXce7yd8cDVFJ34vNz3inIXaalyLy+kfkOpm9+ZcUrMDXBWe/sYZxMPPextL81hgO0PK4TZC3Q1GhZcttMC6rSRSMJNNwcDy1sTnBsozLziR4XC8rpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIj5PTad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63103C433C7;
	Mon, 12 Feb 2024 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707759261;
	bh=viUeDktGlffUbGubUITq4jf7HIhZr28ZVIahNTPb2L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIj5PTad9hBa3fRiojsZ1WNwkpsstBZkTZiK3YdeztobrVFxWNflW9XbyFVv1LrkT
	 iIzVaD9mkeho6FcDtBfX291iLnAH35nWl+Nro5LZjwt3Mnr3TSw5hCDy3+xG+rC23Q
	 xJLV4N9xHGUm5DXEJntBil+DYOUhXs7HYTLiktLwRku+57axhNCfhh+OhSso7LNdYI
	 wxWuMBt+Ya3IKwFih1rujFdY09P73vpwLRZc3l88IL6pqjY+xB4L27Z3Z889Ry1BK+
	 atPpyleg/MPckkO3YhZ0HpPcLyS4lZKKWwDdCU/FIkIyypwMNMSWeh4dG0qgo5rvBy
	 YSQPfjx67j7tA==
Date: Mon, 12 Feb 2024 17:34:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module
 3H and Longan Pi 3H
Message-ID: <20240212-stowaway-cartel-3aee8992cbd3@spud>
References: <20240211081739.395-1-jszhang@kernel.org>
 <20240211081739.395-2-jszhang@kernel.org>
 <7ee6df91-76fa-44e8-ab81-fd4b63b58ce9@linaro.org>
 <Zcn0POS-4BFGlRm9@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0uyXRW8V1u8HTXNs"
Content-Disposition: inline
In-Reply-To: <Zcn0POS-4BFGlRm9@xhacker>


--0uyXRW8V1u8HTXNs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 06:34:36PM +0800, Jisheng Zhang wrote:
> On Sun, Feb 11, 2024 at 05:29:32PM +0100, Krzysztof Kozlowski wrote:
> > On 11/02/2024 09:17, Jisheng Zhang wrote:
> > > Add name & compatible for the Sipeed Longan Module 3H and Longan PI 3H
> > > board.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> >=20
> > This is a friendly reminder during the review process.
>=20
> Oops, I forgot to add Conor's ack...
> >=20
> > It looks like you received a tag and forgot to add it.
> >=20
> > If you do not know the process, here is a short explanation:
> > Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> > versions, under or above your Signed-off-by tag. Tag is "received", when
> > provided in a message replied to you on the mailing list. Tools like b4
> > can help here. However, there's no need to repost patches *only* to add
> > the tags. The upstream maintainer will do that for tags received on the
> > version they apply.
>=20
> IIRC, the b4 can only help on the latest version. If I missed the ack
> in v3, the ack tag will be lost. So how to handle this case? repost or
> Conor gave an ack to v3 again?

I think what the form letter means is that b4 could've been used to
update the tags before you sent out this version.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--0uyXRW8V1u8HTXNs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpWlwAKCRB4tDGHoIJi
0vfmAP9vnhNT21FPEZvJBVqAq/zGnEYv66OKEvr9wmbMN0SKhgEAz5hJd9Pze5gc
WNJ0kmlU85hnwoHnzp0By4eM5hPO6Qw=
=Vnxj
-----END PGP SIGNATURE-----

--0uyXRW8V1u8HTXNs--

