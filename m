Return-Path: <linux-kernel+bounces-41877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F3A83F91B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2691F21895
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA02E652;
	Sun, 28 Jan 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAsPL0lA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A42E631;
	Sun, 28 Jan 2024 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466050; cv=none; b=hlcJV+LXw0h2bS2wyjldMclu0Wk2Ypls6b5Y2FDLJOCJ/ZBivU8N7SiDpG5HtdlFUAPW0NkkdC3wdtZomz+nVs5iym/9ExsthmZvwgISt17tDNLyvotKvtjDpeXZBBsywtkS6oIkFOPMbwXSt4UC0+X6bJQOQfJ4G+esthmSs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466050; c=relaxed/simple;
	bh=/EDJ9bPZKL6/KP5P7C3TliaYe+1owN1nZgWeE1J7WBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liH6EDj17gNzVbsZVNZ5ZI53RcW9d/Mz+SlEDG/AdB/r5JN8lWFKCDRrZWVdTzhzM1akITpssVD2Po9ATPKUcN84QZedpWjsSYIY7et5xQmoeso+GWVunDd75gJ02swiIuYvjON8sN7cPwqqqcLxCYj8veDk6+7lBb+CD2sXL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAsPL0lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E69EC433F1;
	Sun, 28 Jan 2024 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706466050;
	bh=/EDJ9bPZKL6/KP5P7C3TliaYe+1owN1nZgWeE1J7WBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAsPL0lAQCw74SQy+jYwS6G5zWkRkNkYsGE5/qlePSLZMp6mJCJGd4klmM3QCx/gW
	 nz3nDvPAvxhP2u6qsZPq5XdOAX6krXiZaQCecF/NbA+NkgMiGOo86gF1GHPCLKc7S6
	 Z73hl2Ku4eC5w1uyJBMofScDirpuaetbM1ZTJ1r8O5uHArG6ZEfTw5NnXqu7BY7R4P
	 dMEZueYdG5srJjtd5J2wht/7PIYg/04LGo8XWxqCschJxvw02kfh9CyIEjyTyaHwRg
	 l6s+03XlLCYvKlnZvvnhCJcM0v/Z/Wc6UUP22E3JJ8AYFCz5I/M+T0GN6bjSpeNeUc
	 GaUtE7ozOVldg==
Date: Sun, 28 Jan 2024 18:20:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: riscv: cpus: reg matches hart ID
Message-ID: <20240128-simile-endocrine-9e8af979d361@spud>
References: <20240128180621.85686-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKcSv7G0/mXgkSng"
Content-Disposition: inline
In-Reply-To: <20240128180621.85686-1-heinrich.schuchardt@canonical.com>


--NKcSv7G0/mXgkSng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 07:06:21PM +0100, Heinrich Schuchardt wrote:
> Add a description to the CPU reg property to clarify that
> the reg property must match the hart ID.

That is the expected usage alright. Did you come across something where
it was not being used in that way?

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index f392e367d673..fa9da59d9316 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -74,6 +74,10 @@ properties:
>        - riscv,sv57
>        - riscv,none
> =20
> +  reg:
> +    description:
> +      The hart ID of this CPU node.
> +
>    riscv,cbom-block-size:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> --=20
> 2.43.0
>=20

--NKcSv7G0/mXgkSng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbaa/gAKCRB4tDGHoIJi
0oSVAP9orjnFbFNcVF/CMAf/Z7LSEnENkf2VgiqS+fQSrBNA2AEAuYDxybBQO7rx
W1n4LVgR0qVah3M+242qdzT9vbg9RgM=
=t3Zf
-----END PGP SIGNATURE-----

--NKcSv7G0/mXgkSng--

