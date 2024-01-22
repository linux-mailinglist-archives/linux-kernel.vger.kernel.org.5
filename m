Return-Path: <linux-kernel+bounces-33756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC2836E33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBDC1F27DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78364B5BC;
	Mon, 22 Jan 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQhvKgCQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DD4B5A5;
	Mon, 22 Jan 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943552; cv=none; b=oIoGrK56BFxzN6cEBkXGWvsFAG4SSXDCtlttPzpJGsh+cnXUSN+92QN57Rfl301qZBX1IZmryoOdZOMINO8CrTo4RjnUSS7wQ0Wvfh4dVLmQFOK1WMu3382LumhIe8uCBH+g6FBYJh2HP2ImKDWn2VrAipnITknm+jU+tWzorEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943552; c=relaxed/simple;
	bh=FaIC2T5lnXb5UyX04tjerRUZFs1cl/YjtZm/ySeUnMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVJU1nHv0P1ME4qAFICwj3kq2J8BtZ7IedvBUPKpDcEqjaWZ8b6opbHP4G/NjD1Pxjifj69rkH8AJ2rrBw/WXAtIlNwXLL1LssW3Uv06gkr5icIYwqIDKOrXeEl7awUlQOG9qA58sCGooEfq7smX/8aywN9uh9312HnGl/jgdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQhvKgCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E2DC43390;
	Mon, 22 Jan 2024 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943551;
	bh=FaIC2T5lnXb5UyX04tjerRUZFs1cl/YjtZm/ySeUnMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQhvKgCQRN7TRWntwh+PHd8vUSluk+R0HJE2SL24r0wGMP7J6YpoYZuaqudXhNj+x
	 tu8ZFaM32piopWgRudrf4zCsTNYRNMFOY/PlECpHBEJhHtTylB9YR2Hal7I6ERj9/Q
	 S7wvvTaBULMWVYVC4unRYeMos0y12mOwejsbnDrMs//jBCMtCucoJQuLjJHUdwu6CG
	 uDbghL3oAxLNaUAPzRrmSkTkuCuaKp3B63eXf2uqVKkg8cCQNJ3FaiQ7+YA+KldJAr
	 7dfTScH5DHN4AlcWm412RvkLeHbyheujLb7HqCTWZbfbW/Tx3XgYOeQYBxa8aoD4qi
	 6cIukHf0hJ/vA==
Date: Mon, 22 Jan 2024 17:12:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 08/10] dt-bindings: watchdog: renesas,wdt: Document
 RZ/G3S support
Message-ID: <20240122-mahogany-dastardly-f8087e9f28e7@spud>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-9-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2aXKdcl0xK084Ddu"
Content-Disposition: inline
In-Reply-To: <20240122111115.2861835-9-claudiu.beznea.uj@bp.renesas.com>


--2aXKdcl0xK084Ddu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 01:11:13PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document the support for the watchdog IP available on RZ/G3S SoC. The
> watchdog IP available on RZ/G3S SoC is identical to the one found on
> RZ/G2UL SoC.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index 951a7d54135a..220763838df0 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -29,6 +29,7 @@ properties:
>                - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
>                - renesas,r9a07g054-wdt    # RZ/V2L
> +              - renesas,r9a08g045-wdt    # RZ/G3S
>            - const: renesas,rzg2l-wdt
> =20
>        - items:
> --=20
> 2.39.2
>=20

--2aXKdcl0xK084Ddu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6h+QAKCRB4tDGHoIJi
0j8oAP913+4XCq8gn1k2THbD8Dx+5oJcfz0y3Ia5R2VopsJpEQEAlF3W4mym2WwK
P5sPOP6qyvqQ6z0lN04L6msIIrB0jAg=
=Ndlo
-----END PGP SIGNATURE-----

--2aXKdcl0xK084Ddu--

