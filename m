Return-Path: <linux-kernel+bounces-145549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05948A57BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B861C22A48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F7811F8;
	Mon, 15 Apr 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB+FLZpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8D2E40F;
	Mon, 15 Apr 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198507; cv=none; b=uTif1e8Y2IhShHsV1tkLIdUgmUgPAfuHj/yuP9yTDL13yBTFnIYRpspmNxaSRpZqQGVf8y/THyIaHNfXRNsXzuLW5e7Q9qNEITJFEj4vChJTZfkil87nFAnELAh2/kljrieQThey120uNcSHAoA083bjysnxWrqbpbJORRGQxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198507; c=relaxed/simple;
	bh=xd4zvV2217rXjsgC1Jt7muitA/KOg/7nS/ZWUlJXcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY0/fN+/Sdwi02is4FB2gfcf+Vum46x25krBCFQk9AWbg5H2jz++8qo/CamAlizH45Rs4hbZipZQUdQGP/EguDsaBBgWLOf+YkGCQTh8YitqTqLunaZXEQdZOO3vmVtGjHpP9Ffpkc/zh12PWmNbxQRgs9dJIV+AjUe3iV92uPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB+FLZpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D936C113CC;
	Mon, 15 Apr 2024 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713198506;
	bh=xd4zvV2217rXjsgC1Jt7muitA/KOg/7nS/ZWUlJXcUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GB+FLZpGab57zGWMooAXQke1Jk9XKqTzMel6R8NzSDNHyB4cVZ60BmevVdH+1mjM+
	 thtucU/I0aDwLd/SCPdqqaFgkhbLAFA+sEm573RPb9q/5kuQY0fV+Y9bhGEj3O+CGe
	 qtKnzQ7SbP94Fw1zdHCmPG/58vVNzjrP84XOAV3Us2fTBf07NTCHx/jhiAMyDmJhYR
	 mhYsCEoklIMnG2ufcwSD9NsMJxud+H8vzHOFunxkTFgRg2Y0ySVIfvYNLM1OTr9gcV
	 Vi0H4m6bpgAzvM8bWqR3L4hXY/dXTaHX/QLnnHEoHxmvCKFsFxuGqQCqfvxGhg1UzL
	 5YCwGfc3IPL5g==
Date: Mon, 15 Apr 2024 17:28:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: sre@kernel.org, benwolsieffer@gmail.com, chris.chapuis@gmail.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: max8903: specify
 flt-gpios as input
Message-ID: <20240415-pretty-recite-127842ed9a10@spud>
References: <20240415151645.1986014-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JCzRbrKQeuOfJEof"
Content-Disposition: inline
In-Reply-To: <20240415151645.1986014-1-github.com@herrie.org>


--JCzRbrKQeuOfJEof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 05:16:45PM +0200, Herman van Hazendonk wrote:
> The FLT pin was incorrected documented as an output. The MAX8903 uses it =
to
> signal to the processor that a charging fault has occurred.

I guess this is just a matter of framing? Input to the hardware running
the OS but an output from the max8903?

I'm okay with whatever wording causing less confusion, which may mean
something that specifics what this is relative to?

>=20
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

The SoB email should match the from email fyi.
Cheers,
Conor.

> ---
>  .../devicetree/bindings/power/supply/maxim,max8903.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8903=
=2Eyaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
> index a8d625f285f1..86af38378999 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
> @@ -34,7 +34,7 @@ properties:
> =20
>    flt-gpios:
>      maxItems: 1
> -    description: Fault pin (active low, output)
> +    description: Fault pin (active low, input)
> =20
>    dcm-gpios:
>      maxItems: 1

--JCzRbrKQeuOfJEof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1VpgAKCRB4tDGHoIJi
0jw/AQDaumli7edYvHrMoE4DDwEVzCH7wtuaBqIpvwcPYZM7xQEApHEIX3B9VcZx
5Gw1n8eCthaQuGt/yznp5f+vfVxRUAg=
=1mQ7
-----END PGP SIGNATURE-----

--JCzRbrKQeuOfJEof--

