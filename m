Return-Path: <linux-kernel+bounces-79810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA6862714
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEDD282BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBE4CB2B;
	Sat, 24 Feb 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duONKiU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182C4317B;
	Sat, 24 Feb 2024 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804120; cv=none; b=ihlPvo1cz+y9hgwTivpSFrr/F3zgLn/Gw0Ppgy7BbMpje1E3KybCwflJ4iYVg4wVTFZegR0X+k3up9OMS/KRDak6WdERdzOenVgv+/P8k8v8Ar7A4ROl/aABVG/PQTv6IOw1xS5XE1ahcvwBRc1zaPPMAR0x33j3FI9gItXFj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804120; c=relaxed/simple;
	bh=DrXEA5LfQtyiBzKY/GgIWRK6O4zFVc1tt6OpMvzP0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCpwMEf65PoiDxY8pE6U7mJhfuAM5wFn571LHs6RjgQ9SU5Fc1YUfAWxLI0o3RcyqjZmTYodIGNtrJWKfb3T7a2pI5ABfxWCzj+IMW0icccDa0qE0fuOQrdahfiUKIXmAsbOnPdTyLux2+j4OqaFEp+ssA07I6rNNHPn6H06iuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duONKiU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B23BC433C7;
	Sat, 24 Feb 2024 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708804120;
	bh=DrXEA5LfQtyiBzKY/GgIWRK6O4zFVc1tt6OpMvzP0T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duONKiU8o2/aF9dShN9pM1Jt/VDiYdpOIKqD2ixaszIx5VxL4mL8dWCLESyqQiBbX
	 d9kiVBZCtakOUubpduacqMM7JSEGIsJcu189cLdzQVPhsegSn/mDUzeROeuZUcF23F
	 x8uperuvNzjLHdlfZTlrmd9c/rMlY390HkcqWsaP8jcqrPCuRYijG5YnjANiWFDGxc
	 i93QvOIh7kdJ13F3HcRAevT83jyMHf0+j4PnGRhzWlPnNIdLG6UUjQXeZZAOf3TCHi
	 EKwuuf4/G1pKLvtPd2AY7XpcFXppHKbkdj4+ftZeZNxqH7U5TTE5diTTpftudy62HH
	 PtlEqkSwrMqZg==
Date: Sat, 24 Feb 2024 19:48:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/39] ASoC: dt-bindings: atmel-classd: add sam9x7
 compatible
Message-ID: <20240224-vice-lunchtime-fd456448d41d@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172608.672190-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GCI4KyNPv+vKZusj"
Content-Disposition: inline
In-Reply-To: <20240223172608.672190-1-varshini.rajendran@microchip.com>


--GCI4KyNPv+vKZusj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:56:08PM +0530, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Changed the subject prefix matching the subsystem

> - Removed unwanted '-items' from the syntax

Did you? The diff looks identical to v3.

Thanks,
Conor.

> ---
>  .../devicetree/bindings/sound/atmel,sama5d2-classd.yaml    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd=
=2Eyaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> index 43d04702ac2d..ae3162fcfe02 100644
> --- a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> @@ -18,7 +18,12 @@ description:
> =20
>  properties:
>    compatible:
> -    const: atmel,sama5d2-classd
> +    oneOf:
> +      - items:
> +          - const: atmel,sama5d2-classd
> +      - items:
> +          - const: microchip,sam9x7-classd
> +          - const: atmel,sama5d2-classd
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--GCI4KyNPv+vKZusj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpIEwAKCRB4tDGHoIJi
0rqeAP0T/vcukep+lXBA0E6SieaRS5/yTwFDjelCml6dZ9FuPAEAmcrwGIUWtiu9
CqsI65afkbEy4WSEXseZIFo6hs+MhA4=
=BpOz
-----END PGP SIGNATURE-----

--GCI4KyNPv+vKZusj--

