Return-Path: <linux-kernel+bounces-46710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F6F844309
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EC11C210B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41083CDB;
	Wed, 31 Jan 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqaceoEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7686AE7;
	Wed, 31 Jan 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714934; cv=none; b=F+lBsPGKB5BCFvct6vJWalgNjISlzcMuhM5XxbhYHPTmEv1lW/0GvAEuHUYeXeZo2aO6jRmeIP3QDZ50SPz7x+q1OCdyv/3RXgoxXIllogTvqiZcm7jGVOxlV0d4Nf/TiZ5ceUBGhBMmqyBqIiBRHUElHYUMP9IAV+XVKt8h/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714934; c=relaxed/simple;
	bh=GZeYPTgLLW3nuyk0bMnjWwMTvzrJyNThCEoPaW35O9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMm9KO6hKl6N50Hu1sQzoAP5v+LN92CeWUZDDA8K89q9u/fsTgk5LUd98eXOuSQhta5iEgj9HDh9q7e0p6FJEQ02oY8q5FjL3rr2fqehUt1hY1TFkCpNLM1N7tqHuyk4fsTkHuHnMcRXl6ticSlMIYlQtHUEOQVQ9r+iJ8O88J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqaceoEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D714DC43390;
	Wed, 31 Jan 2024 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706714934;
	bh=GZeYPTgLLW3nuyk0bMnjWwMTvzrJyNThCEoPaW35O9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqaceoEM/jWYvScv0/8jEqOfV9SI/68cRQTue5W7+ihQvqVWuKt2M7COhC8knJI0v
	 L3YHz3q3jA1oP+XRrQlAXbfU5DijlGMhBQt0q2RUWTsV5wOSXPRtsVOn+gKVZZVOLH
	 iJd0nscqUY1EwSafI2Ou6XkWL2mIajQERbz66/9XA8nmNrSuaHuxA9j3GtutPhNQAO
	 u1rYlD2doRl5ISd7aUtwa2qr8GnOT/2pAPCFBpoKryrXck6rUJHlU5DwOx1ON6bQD8
	 JRAwjFAEw3OoQrGrxYulB3qmRYjt6MMqWsAu1JqDAu0uSBNkpDTuTIsmrESyB2rMob
	 GsHBHdWJVEoZQ==
Date: Wed, 31 Jan 2024 15:28:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics,
 Inc. prefix
Message-ID: <20240131-elderly-passover-341b89f65189@spud>
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ff9R7WnZ74Ln9dDx"
Content-Disposition: inline
In-Reply-To: <20240131105153.8070-2-clamor95@gmail.com>


--ff9R7WnZ74Ln9dDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
> Add missing LG Electronics, Inc. prefix used by some older devices.

Is it? You're only adding these devices now as far as I can see.

>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 309b94c328c8..b94ac977acb5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -767,6 +767,8 @@ patternProperties:
>      description: LG Corporation
>    "^lgphilips,.*":
>      description: LG Display
> +  "^lge,.*":
> +    description: LG Electronics, Inc.
>    "^libretech,.*":
>      description: Shenzhen Libre Technology Co., Ltd
>    "^licheepi,.*":
> --=20
> 2.40.1
>=20

--ff9R7WnZ74Ln9dDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbpnMQAKCRB4tDGHoIJi
0gXoAQDBQjeZqnVsP26PtC6fdOMh7Ttn8q1muLU+rSCjPpicUwD+O1fO+s18HIio
l0LDxWECZ3nZFjSyesMeJlJu0ZTs/wc=
=BTyo
-----END PGP SIGNATURE-----

--ff9R7WnZ74Ln9dDx--

