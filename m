Return-Path: <linux-kernel+bounces-76855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97C85FDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1344D283820
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8E1534F9;
	Thu, 22 Feb 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYwmS/3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6D1474A2;
	Thu, 22 Feb 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618130; cv=none; b=edS8XtT4eafFzSB34/qS1sU8YvdYp9mP7HJB43yceJqkgHA2N1MFMwNCnO5WfT/j67E18wGALzi303mlQwOCL2EkBeiTiaoMv3BFV5LjXATrpk/cvSz5+lVMy6WZS4hcjzuU7KmNOZY9Vr5kmVlxhu3eHJysRx9u4EFRcwz7A9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618130; c=relaxed/simple;
	bh=kTLXnWnZsoedwczOpTL5BffDlpeFrsNtVM8o2rNejWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFxZufh9Zs5MWBgOYGzCzpp5VpTWPmC+tuHQ6sqtfF1/T8LuY3Vrznj8ovRC49ycwtfQu1PCEK7R/8HfVHNriyx4UkzyOjgt106RJfLiSdOnxhuxPdo6QR3RpZqXum5s4+m20Zej+isYWgigyAIRnvRgVH3i+w2Hd/xzama06ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYwmS/3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19D1C433C7;
	Thu, 22 Feb 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708618129;
	bh=kTLXnWnZsoedwczOpTL5BffDlpeFrsNtVM8o2rNejWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYwmS/3MHejuSJkKkSewFfWVUMALm1mb5c4ADq019zonk57QExftcbqz8Ow1Tcukd
	 xVqKNEu4jYCrI7bOzYlil7Ha7/k3UbgY/jlWNDo8wNsiK86j4KScDvtbdBSu8rGrFx
	 +9DGtrCLCCoFHFJGOnY/KsWRco4bPZmkMfIjl5XF7spLOpoMCOnjfd7Z/dBRFE1WqV
	 BQrzWGgxV1Hr85gfc9g9asOAEJh/iNoR335J7rz/wWhEvaT1/qMjb3fDRswGACLs9M
	 0nQ03n5lpGk6/NILENxZj0MM72ka73X4qu5YOYW2CIv2Cwn5RmeSkQL84RmjwBzzqN
	 U6s2+D23mBomw==
Date: Thu, 22 Feb 2024 16:08:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] dt-bindings: usb: analogix,anx7411: drop redundant
 connector properties
Message-ID: <20240222-election-doorstop-8c179803c47e@spud>
References: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0CcJJwfGBToPtmCF"
Content-Disposition: inline
In-Reply-To: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>


--0CcJJwfGBToPtmCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:28:19AM +0100, Krzysztof Kozlowski wrote:
> The binding references usb-connector.yaml schema, which lists all
> allowed properties and ends with unevaluatedProperties:false, so we can
> simplify analogix,anx7411 binding by dropping everything covered by
> usb-connector.yaml.
>=20
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/analogix,anx7411.yaml   | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml =
b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> index e4d893369d57..3f5857aee3b0 100644
> --- a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> @@ -23,24 +23,11 @@ properties:
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml
> -    unevaluatedProperties: false

The connector schema sets `additionalProperties: true`. Is removing this
correct?


> -
> -    description:
> -      Properties for usb c connector.
> =20
>      properties:
>        compatible:
>          const: usb-c-connector
> =20
> -      power-role: true
> -
> -      data-role: true
> -
> -      try-power-role: true
> -
> -    required:
> -      - compatible
> -
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--0CcJJwfGBToPtmCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZddxjQAKCRB4tDGHoIJi
0uEqAP9Xf9zXv7mqM14GGniZvnJbzR6Y9xYhn3ayyr5xFSWPKAD8DOItDvsLF29D
BM/6Njluym2MAlGcqvjwD+BmS3rCjQM=
=aipQ
-----END PGP SIGNATURE-----

--0CcJJwfGBToPtmCF--

