Return-Path: <linux-kernel+bounces-105443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289987DDEC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CA4B20C61
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9571C6B9;
	Sun, 17 Mar 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OroD0fM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFA1CD18;
	Sun, 17 Mar 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689020; cv=none; b=NhjFF378NgBUH9wN1JuXaqMterhMu7oSQd0DLUP8+MLyDr6nU+vpCM4o0N8fcx8qByv9D3JLiMWXSalaqLdd2BlJfHhygIzJ1x3ReIktTkhLDkmtcbWuQb6urgN2XVn8DxJfHX8/jiZ0rgT897UIn73PgppABi+4HNIKUEOiFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689020; c=relaxed/simple;
	bh=6dx8unnGyIlSOO3NCdASCvQGbnJap2AGaxT/PghIgBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcrRxlcKe2E++qXkRJi/r4B8RVKfRXgFhCLtVkejzGAeAp8DIXr8yeZavetlbBtykfI5lJ9cmrH2XfSeGFMSVwbE2xPHrOE76MaUDg3m0nQ8xgNk0ULJzklx+OdE+9/2wt1g2UJVz5j0FP24kiQpquYam5UYejcdBzACl+UUs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OroD0fM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AADFC433F1;
	Sun, 17 Mar 2024 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710689019;
	bh=6dx8unnGyIlSOO3NCdASCvQGbnJap2AGaxT/PghIgBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OroD0fM2iU5cf8kuRZycsEjYdR4NaQoMMTbogTvIm0PpRetOIKUucKqHqOKKlkMU5
	 2unHyLl3LaI9e2tZ/QkVjHD84mKizVUSo1YNb8eoGVssfhFMcUHmGshiUNqD0YHWHi
	 oZUoGusZXxD/FzqTiCW8z0muraQdZNrvjCoOYucFTdnCuEKS2Gpak8fNka5hSQa4Dz
	 6QgOEdFp59rce2XDkvyOgbqKzjCWsbc01UFZjsRy2IfsLPZMqiT3KWrloGZsH+roRI
	 nPp3QZD4H9MQbTV6LxoJ4p0OQJyD3kg4hF410FGE281/kzbiIWLEbjRDmXCiJe/z2B
	 cTtz6zQNOkLvg==
Date: Sun, 17 Mar 2024 15:23:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: clock: samsung,s3c6400-clock: convert to DT
 Schema
Message-ID: <20240317-curator-smoky-99568f9308bc@spud>
References: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="avAJPhhF1TQgfXmM"
Content-Disposition: inline
In-Reply-To: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>


--avAJPhhF1TQgfXmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2024 at 07:50:35PM +0100, Krzysztof Kozlowski wrote:
> Convert Samsung S3C6400/S3C6410 SoC clock controller bindings to DT
> schema.

> +description: |
> +  There are several clocks that are generated outside the SoC. It is expected
> +  that they are defined using standard clock bindings with following
> +  clock-output-names:
> +   - "fin_pll" - PLL input clock (xtal/extclk) - required,
> +   - "xusbxti" - USB xtal - required,
> +   - "iiscdclk0" - I2S0 codec clock - optional,
> +   - "iiscdclk1" - I2S1 codec clock - optional,
> +   - "iiscdclk2" - I2S2 codec clock - optional,
> +   - "pcmcdclk0" - PCM0 codec clock - optional,
> +   - "pcmcdclk1" - PCM1 codec clock - optional, only S3C6410.

I know you've only transfered this from the text binding, but what is
the relevance of this to the binding for this clock controller? This
seems to be describing some ?fixed? clocks that must be provided in
addition to this controller. I guess there's probably no other suitable
place to mention these?

--avAJPhhF1TQgfXmM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcK9wAKCRB4tDGHoIJi
0n1jAP4uBRwE/QjP+OzagdtaN0k4KA+oynX+Mt38hB7fNOfFLQEAst51oJuYomCe
qSldXRE+01t3wKQnk9claOuGWyjV2g0=
=ujPR
-----END PGP SIGNATURE-----

--avAJPhhF1TQgfXmM--

