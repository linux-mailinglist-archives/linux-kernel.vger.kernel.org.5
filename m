Return-Path: <linux-kernel+bounces-137155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D270E89DDB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EAB1F27374
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9613173E;
	Tue,  9 Apr 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obPXcHZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1E1311A0;
	Tue,  9 Apr 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675019; cv=none; b=JrTElioHnXljvn7U9tJAxmQgvGjmRTw3IqTn56OiUJF4ECeY1NegPlMf7Pre6njNlGW05wO9eDKqn11noOuM8aP4f657KTWbhGZ5abB5ew61nC3HjAnitudUUYcNeEzY5SUB2OUA6yTtOaxhKFTyT5JMADbPmyLnSCBdUGaKuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675019; c=relaxed/simple;
	bh=m+H+w378Sr6HEqYhv2540iRxgWMuF296nGm682Ps7S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDhTVLNmwfQESVzj9+CebLJIgLYN5VlxhZbDkDleUA/mX+q97ms0cEGtbUAvIGQAuqWgrPf/PJ0Bka1Vu7eZQKIH5qdHsm+NIGvafMlgOsHAv/hPYaOGkoegrfuxsC7NZH4pe5QnrKF/lxsHg5o+YknUa///aL9Hyus4CWX6Vlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obPXcHZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08BAC433C7;
	Tue,  9 Apr 2024 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675019;
	bh=m+H+w378Sr6HEqYhv2540iRxgWMuF296nGm682Ps7S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obPXcHZrskluMa4NU4zR6hyOUW6yg9wkgtvhiK1C1xzCihA+aWVZaHizaG8r5H5h6
	 83HyPuJ7U2EXKxxbxHWXHTZ3O2hhMvPXMwc7E53xGT1bCvTi2hW24caQgA0/+9Kq37
	 ThZVynd+PN/jdw+FbYCtGhfvkmeU2USeeja7ZNYwWcjsT2iw8krkYZ/QHCaSvBA9+z
	 Hrd9MznNbHJg+ih4vrvoM6HneFpmZm8JPzjxWajwCuDoRQrfk0VvK1TFZfu2JLVfOP
	 jGWdy0xxUFOwAvPgaW7UBh7mqEqoO8vd4Myc6oD5IiKh2GIj1ODxqevGDr3hK54j2e
	 XiukDYTxb3flQ==
Date: Tue, 9 Apr 2024 16:03:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Eric Lin <eric.lin@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] dt-bindings: cache: Document the
 sifive,perfmon-counters property
Message-ID: <20240409-underrate-armless-697047fd61cc@spud>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216000837.1868917-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nDzQsaP24507Oliz"
Content-Disposition: inline
In-Reply-To: <20240216000837.1868917-2-samuel.holland@sifive.com>


--nDzQsaP24507Oliz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 04:08:13PM -0800, Samuel Holland wrote:
> The SiFive Composable Cache controller contains an optional PMU with a
> configurable number of event counters. Document a property which
> describes the number of available counters.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
>  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml =
b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> index 7e8cebe21584..100eda4345de 100644
> --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> @@ -81,6 +81,11 @@ properties:
>        The reference to the reserved-memory for the L2 Loosely Integrated=
 Memory region.
>        The reserved memory node should be defined as per the bindings in =
reserved-memory.txt.
> =20
> +  sifive,perfmon-counters:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    description: Number of PMU counter registers

I think this should be restricted to devices that actually have it,
given we've already gone pretty hard in this binding with specific
requirements.

> +
>  allOf:
>    - $ref: /schemas/cache-controller.yaml#
> =20
> --=20
> 2.43.0
>=20

--nDzQsaP24507Oliz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhVYxgAKCRB4tDGHoIJi
0mzBAQDysCqijpDedJMkSHubXyNjqiZS55GKu1YasR4ei55rswD+MW0xgiNKPVjO
XNXWQPiUaaqF25hlCEW4n/5lW/MwtwQ=
=9dlT
-----END PGP SIGNATURE-----

--nDzQsaP24507Oliz--

