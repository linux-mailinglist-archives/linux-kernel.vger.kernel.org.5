Return-Path: <linux-kernel+bounces-62098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC163851B67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D98AB21316
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A423EA78;
	Mon, 12 Feb 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS+qO6QF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCF3D978;
	Mon, 12 Feb 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758969; cv=none; b=OQ5H09ppn+wMcjYHoe+bxJ1wTMNGSWKCw9RNkVcKWaNHlTX2nKerPg2izqdN5LnNC4COFUVLbXqHKRcdfN+bZByB7lI5pt3c5pF3VzYZtit2ZoNIfulmdXPdsjC/hS+CqV9Ixe67B+rpvFPZyuEzrr7DSZln2BcyOuELFztnsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758969; c=relaxed/simple;
	bh=U7CTxMmAqUerbF35qfZn9i9xTreBxXVXMPA1ApyuvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYh2tP0YpbgQMbsj468yG6hAmBCrOPrCcYrKOC771HmJrWKu6adoDTutF2CZY95XbBZBjhifMUIOvqUfrXWEYM/VS1Y7Fcrs+yMw86IhcUH1CE8PbZLAfJ1xw1qqWx3tLgId0HdrkldK6x4xZj0GYNj90JCzzeyVdDCFMfzzc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS+qO6QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6B6C4166D;
	Mon, 12 Feb 2024 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758968;
	bh=U7CTxMmAqUerbF35qfZn9i9xTreBxXVXMPA1ApyuvAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uS+qO6QFqybuxg93e/+WVVRfdxiJ2UzBuLNYzbgXEKM8DV7rBzbxR/824K9E2GC8c
	 zRPdbPwh1aEKnu9C22q+Bw18Glrc49CooqxLTcW7DCwl30V2uxfGKap4az0KySZqE8
	 IRIazPCjORKfPy76EvMVtilQmoHk6pfINOE3zl4lvQIv1qcYkASUiHLRN/z7rrksp2
	 3JVdmc848+QjDI1MOGvyDGItAjeNPXuPkpJ1PdeQBfCtai1op2WsAsFpEkkLDW/cQd
	 iJwA7odq3K4196oZKnc7j5mgKbcG2ISBpnYV3GLUu9mdX3IfVqev2aJvso7LLoexFc
	 EGHQYiCuYgozw==
Date: Mon, 12 Feb 2024 17:29:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Compute callbacks
 can be DMA coherent
Message-ID: <20240212-veneering-playback-a846c91c6f66@spud>
References: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G+lOA8hp6GVjNZIV"
Content-Disposition: inline
In-Reply-To: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>


--G+lOA8hp6GVjNZIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:08:27PM +0100, Krzysztof Kozlowski wrote:
> Apparently on Qualcomm SM8550 and SM8650 the FastRPC compute callbacks
> are DMA coherent:
>=20
>   sm8650-qrd.dtb: fastrpc: compute-cb@2: 'dma-coherent' does not match an=
y of the regexes: 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--G+lOA8hp6GVjNZIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpVdAAKCRB4tDGHoIJi
0o7uAQDW3lR5HFdqqIunG7TTZ11uZObObONkWhQlhMxcfi6cGQD+KWfidZJPDjr5
oKmF3GoKh3PZX35ntdcI1YtOS81LYgg=
=5Twe
-----END PGP SIGNATURE-----

--G+lOA8hp6GVjNZIV--

