Return-Path: <linux-kernel+bounces-91240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D4870BA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C11B2821AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E88F58;
	Mon,  4 Mar 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0p/wUtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983DB663;
	Mon,  4 Mar 2024 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584399; cv=none; b=J6Pu1b87Q/kHQtIMmgWkXExXbN98eTbNEexW6iAsLpzb7YwzwhgbspYitl9GTUg2JXH0vXIkSJZc7oZjFdrBg5fWNF+SrJgxrNnqjmdt/alNvJr4/JfrapRrlkiGRkgVC8hO0uu94cnkURFTDeASW1mTrMJQs6zT1Vrs4aZYDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584399; c=relaxed/simple;
	bh=kpA/7pn9mASzroHmqDoFxSE2elACiXObSuvnlyB3WC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH48YelbHjGhqg9+8sDcAVQAERj1mx4wqdq6E8ceRrFzMDA+34RansIW1EJN1WNmwhQpvsJlbfxrjXyxX9a30UEZR0dEBvcj68gpiddlydt7oROzCqr9cO/YBxKcOBE1hpGpD0u7w/DPHt1tAxMgJOTCcomLmOcZvINyaIm49dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0p/wUtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A327C433C7;
	Mon,  4 Mar 2024 20:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709584398;
	bh=kpA/7pn9mASzroHmqDoFxSE2elACiXObSuvnlyB3WC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0p/wUtlCENa0byHYGPMmupleg8lrPhhXs1o1qKUEb+SRYVOrehff1u1dEjYMoawr
	 4pc2tOJQFbjUUnLq0ETNLwgdIeUS/FYMtrLqM+Lyj/TNhEZwVEX9Vo3H1SJOmRhj6q
	 xUbh+9H0MF1vOxas6WZd6Nax+MzUY9+C6rP3Yvf2iHB0Kx3HsE7vc3Oj2lNfwHYWBh
	 AWbitvC/2Nmm2kZ75G+mf9CWOAGxD9AJf8AxHVp720gjU5swjYVPwFijnWu28tt5HF
	 YXAn8mBz+paSX03iBMcIrSgwrbcfwGeft11VA1kM/fOpD/SerTeMK6o8v01xcbnKnQ
	 ZC72KDaIDdvOA==
Date: Mon, 4 Mar 2024 20:33:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: interrupt-controller: Add Canaan
 K230 PLIC
Message-ID: <20240304-froth-ecosphere-9ee29b2085ec@spud>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
 <tencent_23A08076AB6331AE43CC64C87FA3081F8006@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CACqwa9A6+6CIXkZ"
Content-Disposition: inline
In-Reply-To: <tencent_23A08076AB6331AE43CC64C87FA3081F8006@qq.com>


--CACqwa9A6+6CIXkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 11:16:23PM +0800, Yangyu Chen wrote:
> Add compatible string for Canaan K230 PLIC.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 709b2211276b..da147faf32bd 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -69,6 +69,7 @@ properties:
>                - sophgo,cv1812h-plic
>                - sophgo,sg2042-plic
>                - thead,th1520-plic
> +              - canaan,k230-plic

Add this in alphanumerical order please.

>            - const: thead,c900-plic
>        - items:
>            - const: sifive,plic-1.0.0
> --=20
> 2.43.0
>=20

--CACqwa9A6+6CIXkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYwCgAKCRB4tDGHoIJi
0stTAPwKRfMRoeIDnrMRXeK7RYpCbLmlvm8J8cf/OixdlnJk9gD+KTSYTpv8jygT
ZSw3TqHWSdZ0u27JE6N5rE2R2h7pMw0=
=tgwG
-----END PGP SIGNATURE-----

--CACqwa9A6+6CIXkZ--

