Return-Path: <linux-kernel+bounces-62271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E7851DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357E1B22673
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9146B8B;
	Mon, 12 Feb 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDz21uGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C334C99;
	Mon, 12 Feb 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765936; cv=none; b=kDeNZDn8ONmKBh8HvI6cQ42T09pUqFZ3ny0274fPeqoQoV0nKJDN/yCEdwq4v5AGCCdMfGc1WKLRfSn4xrrv6JMU0v4ZOAIV/UiR3j8uUlHZwsPy26pTHURq4P1krmajjYK+gIN6x+8zlyraeS+dBb7WrF3K6TKJ43wSBi3ngrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765936; c=relaxed/simple;
	bh=Ifv2UA2u9qLCFJ4rYKTsSh9pWHc5yMrYJGUYt3+kTfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMUfdvEM3HeqAWEdnj6PuJOt2NTvMnXYFsgU3wZcqAVodR6Cn0MG21UU5kQXynHL5/vnKJ8IFB4y6mSLwVGgr+Em9DV37/09gP7UQwebHBnjzPBv0WC5XboW1USZDGL16ZAW3WizcXE+SScEw93C/jyayzG+5NljK+JPyo85ifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDz21uGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4BBC433F1;
	Mon, 12 Feb 2024 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707765935;
	bh=Ifv2UA2u9qLCFJ4rYKTsSh9pWHc5yMrYJGUYt3+kTfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDz21uGSAJMsQojY4zNQHDBmeYROAhZY2Q9+i8DvurpVDKPCPiQH8JgCnOz06s6pu
	 yTukdG6zcfgyiwVAXwT5vq2GAnja4b/MVJhJbuZyN7vX1ySzrroxziB5z7srBW0XXR
	 NOeNhp3DWj8UkwYpi0dyJWDMIvfxjmETxA+WybtyGGaaj4R5y8Eq9+XYAU8BQRh63Q
	 Gz3dvUbyLJDjlDf82kgKzO0rDpjjdbWVR0HnuGPRKkFeyfdRV4QTOZA5LL9rcav7/b
	 TXcHeagtkBslcE9CfWYUohb+85o/yr1Y2JofkwQ71QvswEoHkQwoUj2DyKpZN2ufZ/
	 yzFDs6lewfJ5A==
Date: Mon, 12 Feb 2024 19:25:30 +0000
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
Subject: Re: [PATCH v2] dt-bindings: net: qca,ar9331: convert to DT schema
Message-ID: <20240212-macaw-dispense-e073f5d73fe3@spud>
References: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fcUA6sBRBV6Rzmja"
Content-Disposition: inline
In-Reply-To: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>


--fcUA6sBRBV6Rzmja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 07:29:11PM +0100, Krzysztof Kozlowski wrote:
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
> new file mode 100644
> index 000000000000..fd9ddc59d38c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

I don't recall whether or not Pengutronix are on the carte blache list
for relicensing bindings under the dual license.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--fcUA6sBRBV6Rzmja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpwqgAKCRB4tDGHoIJi
0rZBAQCnmSlsUkNKiF1EbeNrwFSMFHCiK7573SU7slOuioXr7QEAqjY2doilVGlZ
gmamZT+SKO2X7u2G8Nyht4qPQsVNLQ8=
=4FTj
-----END PGP SIGNATURE-----

--fcUA6sBRBV6Rzmja--

