Return-Path: <linux-kernel+bounces-79816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B74862724
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49B12818EA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F64CB41;
	Sat, 24 Feb 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqxq4AUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EC4CB20;
	Sat, 24 Feb 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804307; cv=none; b=S+ngmPVOHKHZvrga3sH5eAvWTvK84orDa5BKhbjxMbO4bc612PvPslMLfCYGxUlgUL8JWgjpbsvrcbFq5q2iOkUPW6Pvd8bFLgl7l2p3EAAF0cdJHRlKJmdsuEP8OrK4WmEsDzeGMsNZ++wcLmpJP+SNcA6ip7G7YL6++TTQq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804307; c=relaxed/simple;
	bh=3FCTdNX2pfFEE6oEI8MTGFLwkAbKa1ZZICUDgcqmLYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig2dcSrppgQmJqDCPK1QnNMVe8/T9HjzyvOY+Q+lVs+NpS53WkifZuty7TQ9eYrc34Fz+8kxFr1W/7kEjF7Rh6pzITXqhWDucICoj1TfBGSI9UzEO/5EGqV3Ld6/3/HxiMMnjqVznR2KXBGw1kHEiFLEYKsHh175ChXzgrL2ATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqxq4AUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66849C433C7;
	Sat, 24 Feb 2024 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708804306;
	bh=3FCTdNX2pfFEE6oEI8MTGFLwkAbKa1ZZICUDgcqmLYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eqxq4AUL+C7sFnFmN2FLP1rMotpWmsntp1ICACch7naFVB5Zr1cpS7gd3xRC9D0O0
	 +TGUrD8Tfr+guIkqulUyjOCJCJktiIS3x2GwI8JDTaOt+8TLH1m86udRtxt9lwc3Cz
	 vEEsXZgnrbFscCEI+7yw1WhMQBEpkaUm6JlICbGrxk6VUMm+yY+Qn/cn9Bxo/4LcQA
	 axOyt61zjc82rwSti5TYNecFhJhnFPZ5D7x75NAjje9OMsad+J3iIg+qW/7opS5iPN
	 cfVLJ4GdY4PWC7bQwPE3uuczPNu8ZtqvK9+v+MtAH6Z9AHn6ULf7cVz434QYLbVeUe
	 cOehlcUS+7HBg==
Date: Sat, 24 Feb 2024 19:51:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/39] dt-bindings: rtt: at91rm9260: add sam9x7
 compatible
Message-ID: <20240224-unmasking-gracious-8d2734d28fea@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172552.672094-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g6zluE1BE81oDQMG"
Content-Disposition: inline
In-Reply-To: <20240223172552.672094-1-varshini.rajendran@microchip.com>


--g6zluE1BE81oDQMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:55:52PM +0530, Varshini Rajendran wrote:
> Add compatible for SAM9X7 RTT.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Changes in v4:
> - Made sam9x7 compatible as an enum with sam9x60 compatible as
>   suggested
> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.=
yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> index b80b85c394ac..a7f6c1d1a08a 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> @@ -19,7 +19,9 @@ properties:
>        - items:
>            - const: atmel,at91sam9260-rtt
>        - items:
> -          - const: microchip,sam9x60-rtt
> +          - enum:
> +              - microchip,sam9x60-rtt
> +              - microchip,sam9x7-rtt
>            - const: atmel,at91sam9260-rtt
>        - items:
>            - const: microchip,sama7g5-rtt
> --=20
> 2.25.1
>=20

--g6zluE1BE81oDQMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpIzgAKCRB4tDGHoIJi
0jAdAQC2ZwVSNgzyiiECpqHHTXdrbzfZ4WBMrumaRAZvuraVVgD3Y+OseCnhk9Na
mcyfR4/K2oD+/wcsNxVHDAO4+2tsBQ==
=Vrmd
-----END PGP SIGNATURE-----

--g6zluE1BE81oDQMG--

