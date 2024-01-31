Return-Path: <linux-kernel+bounces-46726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCBF84433A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FBF1F21C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26835129A97;
	Wed, 31 Jan 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OosamAdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76984A45;
	Wed, 31 Jan 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715676; cv=none; b=eXwSmngMf2xxCtO0DML8LPHLi8MUiB9V9GawqILEXO6rRY9uulV0xanbcNB7i6ASOiMCcVEIQd5hHcMZxROvTkxe63PnN5RKeDigWX2g/TYlr7hXm9bMPOvQNuhJ7fNyQlDvMzPqI+OHg62XDYEYOunjo2k0rqe41ZaAffAxkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715676; c=relaxed/simple;
	bh=YETHkpmr5YM40bpj6aoJ2u+DexwoDbq9X+cjJRuQMdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ8Fi5oEasvUZdytn2DmNLkRQwK6VT6wLBBz0shaFj/BAdO/77zGbPR/vqYXcke3eKFJ9fK5Tde3m7HiEd/1OGlxTZ78mTZkAcWZeAKxe+ASVBfCfjkC+zHhW08+Z63hf/kfMd1Vf7qLpywiXuxq/WMQ8+xyEunWLcqlrRXudJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OosamAdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82A9C433C7;
	Wed, 31 Jan 2024 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715676;
	bh=YETHkpmr5YM40bpj6aoJ2u+DexwoDbq9X+cjJRuQMdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OosamAdvjDTxxfLr6wIZ01YbEV+jA1E2PcoqdcJ4ptgvD35AG4c3tXfiTdbihjwgY
	 qiDXj+Bo5tzRPy6MJJ97yoHez7kBtPbZI/G5SWiucbIsuzuKVKfY+M1B/i9H2Sw1jk
	 gMQbNPVbMHuDICS0Tko9R6w8xRKC9bGTvbkS8cT93lAz27avD3V8De5/eNEgKZ2AGT
	 1BRTboEqBM+/OMbQHFfskI4k6JdwBfBauzyORLMdsUGpqUUR4iHHAHsk6pFibfNL7l
	 fpM8edPMEoUu1RPgeTgbM3ka6Rg6IGiU+2bogCiW+ftnG1AphvT28lMzg2hdP8Y6RO
	 N8jvFGjcajueA==
Date: Wed, 31 Jan 2024 15:41:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Hsu <ythsu0511@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
	Delphine_CC_Chiu@wiwynn.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Message-ID: <20240131-eraser-given-8381a44f41a4@spud>
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
 <20240131055526.2700452-2-ythsu0511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m66BftHqStl+GNYh"
Content-Disposition: inline
In-Reply-To: <20240131055526.2700452-2-ythsu0511@gmail.com>


--m66BftHqStl+GNYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
> Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
>=20
> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 79dcd92c4a43..088b23ed2ae6 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -129,6 +129,8 @@ properties:
>            - mps,mp2975
>              # Monolithic Power Systems Inc. multi-phase hot-swap control=
ler mp5990
>            - mps,mp5990
> +            # Monolithic Power Systems Inc. synchronous step-down conver=
ter mpq8785
> +          - mps,mpq8785

q sorts before 2, otherwise
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>              # Honeywell Humidicon HIH-6130 humidity/temperature sensor
>            - honeywell,hi6130
>              # IBM Common Form Factor Power Supply Versions (all versions)
> --=20
> 2.34.1
>=20

--m66BftHqStl+GNYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpqFwAKCRB4tDGHoIJi
0qYaAP4xddNh9fWSycXAJDADTsANGspUUp18ZNjQ2r8vNSx3bgD/bEkz0EmGXqsd
94PzQ5Cx0XmBb1XNSIsXNgNymrhg4wM=
=/LVW
-----END PGP SIGNATURE-----

--m66BftHqStl+GNYh--

