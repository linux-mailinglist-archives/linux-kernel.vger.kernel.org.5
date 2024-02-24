Return-Path: <linux-kernel+bounces-79823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEF3862733
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEA31F21F94
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5144CB55;
	Sat, 24 Feb 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8kvZBfq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E333DBBE;
	Sat, 24 Feb 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805020; cv=none; b=dlsKBv2Q/WxobNtxzmiBc/O/mn1OC7BXP6JpHCv/y5t6peFhJKnS7Lh/2cMXZbNgCSsgyqoTznGZ6/xYmqaeegL6OZ8XvNbszJSSLuTCFTtFN+QXo2jlRm+zat/Dkr61c44D1vE2cQ9MSFpCJNb9M/UqATu0nQhUYqdqdI1aF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805020; c=relaxed/simple;
	bh=ojiP1XJL7iEzoVWOF0TCCzqlsWpGiCncAp75LawgMWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOB5JkNZBVq4Iyvq1ETBs2I3ewPCYUCp+05fHIcW3C/6NjRCxujzmKW39TW7CnfgHmOFZI4awonOcRpLrGn+yM5IgQa5MNruL3kPWT/zgU2+VuI4DL80idn/Tp7yHkXEm+RpNcdLgAD7Wtttp9y+ZUM0Trso6mAhNSb2H6xYqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8kvZBfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3802FC433C7;
	Sat, 24 Feb 2024 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708805019;
	bh=ojiP1XJL7iEzoVWOF0TCCzqlsWpGiCncAp75LawgMWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8kvZBfq6kv8LLlkxwxGTYsr0RpV8MlTHOwLIZl8GstsdtX2vbizVnIVFyqtzaNPl
	 GCrWqwaDpSF+u/8OuEUex02Xc/dq6pThU/A0K4nEcMYfAdQA+/yclyjMBjiJOJ10El
	 nluCxP2TLcYOExTKG0ESKa9QecONge4657Tnp66qSN7zOoWnqTokidI+nt71IwExzn
	 XltUdURWmQtrO3Nsx+A7jW8tstjUJwc70i7T8ofXZItWqwzkOI/uRLQpibQuzcVX6q
	 3TY/oqjKpvJa0uqgC+HzbcWw/QVqXuUmbakBF4u3cUc7mzd8oTOiIUvO9gkp2w04lb
	 F6JdMY2IGgPaA==
Date: Sat, 24 Feb 2024 20:03:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: claudiu.beznea@tuxon.dev, u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/39] dt-bindings: pwm: at91: Add sam9x7 compatible
 strings list
Message-ID: <20240224-henna-bok-f3cd3eb4ca36@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172619.672262-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VlS/8o4+CHt0TOhs"
Content-Disposition: inline
In-Reply-To: <20240223172619.672262-1-varshini.rajendran@microchip.com>


--VlS/8o4+CHt0TOhs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:56:19PM +0530, Varshini Rajendran wrote:
> Add compatible strings list for SAM9X7.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
> index d84268b59784..96cd6f3c3546 100644
> --- a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
> @@ -25,6 +25,9 @@ properties:
>        - items:
>            - const: microchip,sama7g5-pwm
>            - const: atmel,sama5d2-pwm
> +      - items:
> +          - const: microchip,sam9x7-pwm
> +          - const: microchip,sam9x60-pwm
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--VlS/8o4+CHt0TOhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpLlgAKCRB4tDGHoIJi
0jr5AP9g29amgYTFpo+cPzKqQoOA8YgdSMh6j8vwxcC1A6e7ewEAps8dKqsaK9O3
aJ9bMtTSp+wtE3MvQ4qqODpIReQajQA=
=2JoO
-----END PGP SIGNATURE-----

--VlS/8o4+CHt0TOhs--

