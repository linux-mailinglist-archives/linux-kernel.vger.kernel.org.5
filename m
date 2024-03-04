Return-Path: <linux-kernel+bounces-91241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA06870BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A987B22981
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877FC8F68;
	Mon,  4 Mar 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NThvY6bN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA817C8;
	Mon,  4 Mar 2024 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584426; cv=none; b=GVEWCYUY5wHJmik9kFo7/hElJHCUzu9BASYd98n9t1EcD7rbIl9t/f8S5yu5sRA92AWd3f2l1cckgbyzftY6YG38u5cw2x8jXqfnjDok/NfLv3BosFAGKSZb+t/IHgbx2T5pcqaupcz8LITxA0jUGYqaqCkaJ4GtHZxkQxB+HZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584426; c=relaxed/simple;
	bh=+vUgXfLly9564GB6TAKpG+X4isiloia4IJPGxEv0M0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1XSNPIU2PRFd9CemAITS6jUbJ2SVmmxUyKe2Wn2V5dPTh+7+E5BHOdJ0B9vu21m3B+74nl1gWbXFSLbHxPOg32NEc0zyfMC/5eprTikgAOyoNOzoRAfdGi2WyLqvWDTHfvBMTvL0tOcxN8i6AEhYIhPn/iwX5YQQnwJHA5F2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NThvY6bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223AAC433C7;
	Mon,  4 Mar 2024 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709584426;
	bh=+vUgXfLly9564GB6TAKpG+X4isiloia4IJPGxEv0M0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NThvY6bNrXVL3/dcCQa4m/D/F83UuO/S1jXhCSTc1RXQCdegroAN6Rt7/m8mjmuuy
	 blnOr0Fp5boFs5wIPF54FgzOLIo1YDfCBIEtxn23+/tBzykNemik0NQRisU4Nw/edb
	 MwD54cmY0WCMX9gMhwc7mlpi/r8N7VgbYcOeJuRTUXFRWMm6wTzs34+qoXWQJe7riQ
	 BxloNcbO5GN2OFkVfuSfXulw4QXDvrUAhsBfM0msb6MRfslFWOX6wSYqDZQ/vfzPjf
	 lVwzknc2yNuPiT5cZbHyOORbdcgq/jiHqoLGPU7x6JYV7s4zGUkrVEV7enE+IGZo1k
	 MnEx/bzuFMjqw==
Date: Mon, 4 Mar 2024 20:33:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: timer: Add Canaan K230 CLINT
Message-ID: <20240304-skinny-old-2fbbb0ee6aa5@spud>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
 <tencent_84166A6B39E6E062C4F8872436FAF1D10A0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="amzJJAj79FLb+Rx5"
Content-Disposition: inline
In-Reply-To: <tencent_84166A6B39E6E062C4F8872436FAF1D10A0A@qq.com>


--amzJJAj79FLb+Rx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 11:16:22PM +0800, Yangyu Chen wrote:
> Add compatible string for Canaan K230 CLINT.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index fced6f2d8ecb..9840a21c40ca 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -37,6 +37,7 @@ properties:
>            - const: sifive,clint0        # SiFive CLINT v0 IP block
>        - items:
>            - enum:
> +              - canaan,k230-clint

Same here, alphanumerically sorted please.

>                - allwinner,sun20i-d1-clint
>                - sophgo,cv1800b-clint
>                - sophgo,cv1812h-clint
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--amzJJAj79FLb+Rx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYwJQAKCRB4tDGHoIJi
0rECAP9gFv7OMFq/elzlpBLldmYGelbKu5hYdGkAyRIValwYFQD/atngNqIRUpkp
qzJLvCosjFdXcsD/Ab7HF4RmtsYnJQ0=
=NR9C
-----END PGP SIGNATURE-----

--amzJJAj79FLb+Rx5--

