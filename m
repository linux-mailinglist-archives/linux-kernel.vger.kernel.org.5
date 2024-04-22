Return-Path: <linux-kernel+bounces-152678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7E98AC2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1528136D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7101525E;
	Mon, 22 Apr 2024 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJkoQaMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002324683;
	Mon, 22 Apr 2024 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751502; cv=none; b=LpfrPzel6L064obfGnc1vTHGN2ftK6DxIH8R4ojqrI0wTww3ZoT7ri4Gq/+qUWxHffLRgKIdPvOLKXp0EmsY4+LNojkyUym1+VorF4tZNbSwgDF4smT2aQCcqwFpBU0Mak15vmLzUH9WQguFGhzVdZQaEovw/uOnTrk7o9Zjy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751502; c=relaxed/simple;
	bh=fzXmb+POP3i93NnWFRs4NFOVjHrZFZYEeB53ck3J/pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya55v1cgeb8pQ4W84Fbldzd4MjvpHN1SPHRUOmnbPmfdIBCbWUCLD9aCJFtZ+KgtPVN3/gw2PZBIIBH0+HxUaeT1vCj76NOobGSKkTROH2gvpwq2E6pamD0gqd1vQD5uQhB7BEgG63sSGunuohlyaae1NxmTo7vgXKhC+sIqe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJkoQaMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2836AC113CE;
	Mon, 22 Apr 2024 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713751501;
	bh=fzXmb+POP3i93NnWFRs4NFOVjHrZFZYEeB53ck3J/pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJkoQaMdDrQ6K3nJ8klWuECeZXN34baayUPTnW8v9n8GNGYA0OWQkcFL4ZWA1Om3F
	 Yurvcu3N5OU3X6n/M+ScORwz/7rij/yHc3ALNI5ziFt+noi0tx3ivYUaBQoefUcARK
	 LljQU29DdFe6SB1qM/Q9pyb5qNTuqJGtvBosSE1tHx1VpAX6hXcHvfbijMyf73L+77
	 KtCykc2L4q7vPD5JsUAIy05lJBVyG4LFtE/+mFvhPz/OWNFiEwz/4uLHxxHmfQ8Le8
	 Wp+ILkzKXNjXCBi2h6lDwOQ+VbMsVFghyD78pyva1Blx5rtxsFJB/tOnUwpuKQ78mS
	 THwMtjbarHbWg==
Date: Mon, 22 Apr 2024 11:04:59 +0900
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com
Subject: Re: [PATCH v4 5/7] regulator: Remove mtk-dvfsrc-regulator.c
Message-ID: <ZiXFy8JgrpWtjxQT@finisterre.sirena.org.uk>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
 <20240418094134.203330-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HUoyRpzKwSxHqOzt"
Content-Disposition: inline
In-Reply-To: <20240418094134.203330-6-angelogioacchino.delregno@collabora.com>
X-Cookie: TANSTAAFL


--HUoyRpzKwSxHqOzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 11:41:32AM +0200, AngeloGioacchino Del Regno wrote:
> This driver never worked, and never got even compiled, because it was
> missing the DVFSRC driver entirely, including headers it relies on!

Acked-by: Mark Brown <broonie@kernel.org>

--HUoyRpzKwSxHqOzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYlxcoACgkQJNaLcl1U
h9CN2Qf/aWyZJQvCpcJSwuOcFKIIUS/36lM8ghBa2puZ2HIcX4pDT0+I2BCj1axn
g/YdYFwOGG+kJKrYKvjsgG9+QksdByu+boaggr/9XBD/aL31FD1U2X1S2A3Pw0dM
JC22KGcr+WUkOLlY0zSAA6vwN3J4zGTRSc2E/MMFcOyWsfjqk6/H6WkSBd2HsdBa
K/ipgSismupevwK1oYCCE0Tn3qQfIcqWPZl5mWynzSbIEY4XQoIcw5JesWRcr0dy
MlC/01VnwtcOfqwh3YzMExqFA1TtY+ZzwhAL2h3ygGI/Ws/rprknS/cXKtdS8/TT
r3/k1UrYmf4aJfkxcU9Gg3pgbqTAHw==
=R6Nk
-----END PGP SIGNATURE-----

--HUoyRpzKwSxHqOzt--

