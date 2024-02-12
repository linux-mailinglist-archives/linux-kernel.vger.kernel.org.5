Return-Path: <linux-kernel+bounces-62145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659C851C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F2F282179
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A893FB3B;
	Mon, 12 Feb 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKoSQVXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A4481B8;
	Mon, 12 Feb 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760375; cv=none; b=Cgu9j0m/3UNo1N2p2itzdFeAQKx2tZX7PAc/HHbq2T/QxbneJBjFo8PU3oa/3HOuDTH1zeIigjlC0V8A+DV1a6ZkIg4exjfbdaqmhLnh1Ua+8Xcrf4Foxtdd8NeWmmsmRilhCm/RKvkEv83hG2/AwvEanFKP0mZsynIPl3+h6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760375; c=relaxed/simple;
	bh=siY669FZ6RXJrctnpBX04wiLC7H2qfVhFbtIGFlZ2/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRJmLwf2hiAKvMdMCvYfBxanCO99inQpGvTNHji+TseEDzXTvOXcdDDcxdvrGaCy2OpwhQnkbqqIobDB/RSrcv6prv12CdYTcIzq2ag53NyBLbTIIsQkm4U/twjDl89otUXS7RnX2M88CsdLzvFmRA+RJexAZ56PLsr++G82B8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKoSQVXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D341C433C7;
	Mon, 12 Feb 2024 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707760375;
	bh=siY669FZ6RXJrctnpBX04wiLC7H2qfVhFbtIGFlZ2/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKoSQVXxnma+6s1eD5MZLUMIcglrYaYh8l+Q3olqyG9DAPS4/txam6oJqEtkOli+E
	 3cX3G1erolcFJnizQC/Sdc8j+QdYkRCeYml2c+H8Swo0AhrOTarwcYP8jlIOmdUfQL
	 yd97GfJlJ4x5z6Zxjud53CBaWeU4taUg4iMKe/TUt1FuFUqYP9jGB7c4ZSEM5/fI1Y
	 YUz6eIvzg3fxNFvBT+BhJk8L4+0unG6nfGMyVDpqwl6LfpDi5KEDsc+LZEAvJCKTWo
	 6vP2q/q463oZk1DQlEnOSqSz64R1UMZ2vxhvNxeGO+0SeopWshIK3J7VnK7W4OdlqX
	 8SwHS8VTHJ6kg==
Date: Mon, 12 Feb 2024 17:52:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: qca,ar9331: convert to DT
 schema
Message-ID: <20240212-wildfowl-bubble-227ae356d652@spud>
References: <20240212105445.45341-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O5dTm4RSUa0ofWQs"
Content-Disposition: inline
In-Reply-To: <20240212105445.45341-1-krzysztof.kozlowski@linaro.org>


--O5dTm4RSUa0ofWQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 11:54:45AM +0100, Krzysztof Kozlowski wrote:

> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      interrupt-parent: true
> +
> +    patternProperties:
> +      '@[0-9a-f]+$':

The thing I don't quite follow in this binding is why this regex is so
permissive. Is it not limited to "just" phys?

> +        type: object
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg: true
> +          interrupts:
> +            maxItems: 1



--O5dTm4RSUa0ofWQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpa8QAKCRB4tDGHoIJi
0iqDAQDU/QNRC8C7WyvBGo1WA4MrnTHyQFctUP7NhoVFbexTEAEAl5Dlwhns4N0H
AKM5s/88h1MISG8C/NpkabLZnHmQ2wA=
=rOaj
-----END PGP SIGNATURE-----

--O5dTm4RSUa0ofWQs--

