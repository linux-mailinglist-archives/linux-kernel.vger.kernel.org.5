Return-Path: <linux-kernel+bounces-38960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BCC83C905
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EBF1C2552E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C8813AA37;
	Thu, 25 Jan 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6T4alu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86313473A;
	Thu, 25 Jan 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201476; cv=none; b=IhiwDsvvZjH05OwxymxwEdq80OIoONn2QUZrYB9drbt9adPucZacGBDV+IWxcV9OeiD6BrYgvIIZTt3iY9WRp6tVTQIra9qbJ7jX/eXPUrGMucAgbJA4VOlyI/s05Hwov++r6zXf7Jm/J0Ex75itIYntdrfv1NgMCPvM/PrTuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201476; c=relaxed/simple;
	bh=nYjwLe0Lvyg1hMkpp/UsWB21LIhFUpPdnQZaz+AhIYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF3c6eMtUQjgeMrgl0pCe1EDjhhPR7y8JaXTQpntG0lLErKCjg3gGAFc0gEjeAQX0xh0zPmSRbo+Nl7iSUA03UhkoliZn0VY4H2JSV12UPCVEADa1i6ZFECKsGvPGQhwMcXevnZCDJjMkaFjNKDMwS/61su+t2veD/2zpJdjg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6T4alu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5479C433F1;
	Thu, 25 Jan 2024 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201476;
	bh=nYjwLe0Lvyg1hMkpp/UsWB21LIhFUpPdnQZaz+AhIYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6T4alu4t4AH8J60KPnFJ+RWxTMs1rVpTJ9vwhs0MrjuNVi7tDbWsuxrpkwrgqVdq
	 QmHKgs5tZuc4PVLbyqEp6X+KXNTN5ZCNuph+sfTOaOQMVKs8q06Em6wjXWVgENuj4k
	 tC1VwNj1BELTvyNtfVNZktKzk3oN334vM9BrN0/g3QYFLhZ2ybU6UsFycqB3uUxE4I
	 mp5MCzF3j94W5IgkHuaYD2pswBse3rq/6qNiGo6ReGKeM/gY0x5JpAVtq8R+wZrQMu
	 f4m13oz9eNCWR0sdZR/xKeGOounAfneQyRQbjFfHu/8oWwCkWYcrOSeI/CLeWECuka
	 8sBfwIvLiqK1A==
Date: Thu, 25 Jan 2024 16:51:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal-zones: Don't require
 polling-delay(-passive)
Message-ID: <20240125-wildfowl-confined-25c6b276cdcb@spud>
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
 <20240125-topic-thermal-v1-1-3c9d4dced138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9G4ehHYANaVFMdfb"
Content-Disposition: inline
In-Reply-To: <20240125-topic-thermal-v1-1-3c9d4dced138@linaro.org>


--9G4ehHYANaVFMdfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 01:11:15PM +0100, Konrad Dybcio wrote:
> Currently, thermal zones associated with providers that have interrupts
> for signaling hot/critical trips are required to set a polling-delay
> of 0 to indicate no polling. This feels a bit backwards.
>=20
> Assume 0 (no polling) when these properties are not defined.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I think that makes sense.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml=
 b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index dbd52620d293..68398e7e8655 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -228,8 +228,6 @@ patternProperties:
>              additionalProperties: false
> =20
>      required:
> -      - polling-delay
> -      - polling-delay-passive
>        - thermal-sensors
>        - trips
> =20
>=20
> --=20
> 2.40.1
>=20

--9G4ehHYANaVFMdfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKRfwAKCRB4tDGHoIJi
0pGsAQDca7xs/EsXv3IRvEB/5hgF1s7CAwqVWnSWD29/BZI0zQD8C1KYjqJ2fxIi
8eGcI7MuIS7od6Hh7oMlYnwvV49k0AY=
=OSpF
-----END PGP SIGNATURE-----

--9G4ehHYANaVFMdfb--

