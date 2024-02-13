Return-Path: <linux-kernel+bounces-63957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCF8536C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084201F2526D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732825FBAB;
	Tue, 13 Feb 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgBqo9Tx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A395DF18
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843830; cv=none; b=Dd5sfr0glY+7jHOOum4y6745VXC6om0o197NVxPR0Fg4EaMPd9Rb28fwU46I30PFDtq16I6BDeIi1VL8BU0wQcJIPJbNvkyUF7rYow3O9SsykhEauLr98ZTDfLgRVuWsQEiV6z7nLfy6nrkyH4bujDErjKPXq252jMT7U9cCayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843830; c=relaxed/simple;
	bh=q7+xWVE0I6osa/gPF+FQiuUXTh5GqT+0KjgOI2Rb03w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsgaT9w5PKtVMNfAA+Cn4Ig4cQrfx+CkUT8BABA9+WatSr7tEN+vcFwXYEARloOAj+JW5HjM6XEit8DHboY+QwKcT4hn2Vxq9TuJMrVqXzJZMydQUz4Kl3eo8scJe7uDD0Ofea8dvIdTBBlHuCMd6oqwMg612/wc2g5JjDvkCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgBqo9Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9EBC433C7;
	Tue, 13 Feb 2024 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707843830;
	bh=q7+xWVE0I6osa/gPF+FQiuUXTh5GqT+0KjgOI2Rb03w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgBqo9TxxkDM/5KYqNsrdYxH3cTyb5AnwH9smKkDkQ7xah1lYkkTfDnWx0hnN4Ydo
	 nMn2KKmPAukiw0crNK3sddD33o17oyd80x7x7Z7nW/1vng2CNwPge0Lw3yiygXLy4y
	 +SLg1lKw/XBoFDF5eRd+sYnUBYpKe+G7snQp4LC/CTemZ6m6LWb3Z0hr8lNO7RVZLv
	 wAN9IHeTcvY4yHxTXb7BJcIXAkSN+hw12d5M82WI8QKF341slR7m39jc3+dxN+Of/H
	 BJoO0OQjq8VLAmRjPhoZGZ37hNv0w945z5XuJQy9zQX+iRu9Uvg5COw0HwARh+5gtQ
	 2C9fuA1+BRNeQ==
Date: Tue, 13 Feb 2024 17:03:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>
Subject: Re: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified
 privileged ISA versions
Message-ID: <20240213-limping-ether-adbdc205ebc6@spud>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yUxwhrkO4imUANZK"
Content-Disposition: inline
In-Reply-To: <20240213033744.4069020-3-samuel.holland@sifive.com>


--yUxwhrkO4imUANZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 07:37:33PM -0800, Samuel Holland wrote:
> The baseline for the RISC-V privileged ISA is version 1.10. Using
> features from newer versions of the privileged ISA requires the
> supported version to be reported by platform firmware, either in the ISA
> string (where the binding already accepts version numbers) or in the
> riscv,isa-extensions property. So far two newer versions are ratified.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
> Changes in v2:
>  - New patch for v2
>=20
>  .../devicetree/bindings/riscv/extensions.yaml | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 63d81dc895e5..7faf22df01af 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -121,6 +121,16 @@ properties:
>              version of the privileged ISA specification.
> =20
>          # multi-letter extensions, sorted alphanumerically

> +        - const: sm1p11

Why are we beholden to this "1p11" format of RVI's? We have free choice
of characters here, what's stopping us using "machine-v1.11", for
example?

Thanks,
Conor.


> +          description:
> +            The standard Machine ISA v1.11, as ratified in the 20190608
> +            version of the privileged ISA specification.
> +
> +        - const: sm1p12
> +          description:
> +            The standard Machine ISA v1.12, as ratified in the 20211203
> +            version of the privileged ISA specification.
> +
>          - const: smaia
>            description: |
>              The standard Smaia supervisor-level extension for the advanc=
ed
> @@ -134,6 +144,16 @@ properties:
>              added by other RISC-V extensions in H/S/VS/U/VU modes and as
>              ratified at commit a28bfae (Ratified (#7)) of riscv-state-en=
able.
> =20
> +        - const: ss1p11
> +          description:
> +            The standard Supervisor ISA v1.11, as ratified in the 201906=
08
> +            version of the privileged ISA specification.
> +
> +        - const: ss1p12
> +          description:
> +            The standard Supervisor ISA v1.12, as ratified in the 202112=
03
> +            version of the privileged ISA specification.
> +
>          - const: ssaia
>            description: |
>              The standard Ssaia supervisor-level extension for the advanc=
ed
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--yUxwhrkO4imUANZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcug8gAKCRB4tDGHoIJi
0thLAP9cXpHvg9SDbU0RqNcZc4VWrOyPfy1boWluL81Vs60v2wEA+cADBm70GqWU
6KjORhTQX5dBoW0MJ3C7R5KpKm/oegU=
=0J4l
-----END PGP SIGNATURE-----

--yUxwhrkO4imUANZK--

