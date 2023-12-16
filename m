Return-Path: <linux-kernel+bounces-2175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FF8158F4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB1A1F2331F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4B23761;
	Sat, 16 Dec 2023 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS9YnZQW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32414AA5;
	Sat, 16 Dec 2023 12:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C64C433C8;
	Sat, 16 Dec 2023 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702729567;
	bh=0oeIUsrlXs5c6NYNpXEs7Wnj16HATAm77+R7IxPQ1qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PS9YnZQWHOao0EY1i6Oy9j43am7WUay4ybAfqccsc0TphcvQMagpFiM4I3wwTOo7O
	 aYSHVe0r4vIXuTSYtcw3UPahEk7MnA7U+EQOTmLtbm99GtY4ZZxNva63ehrPRM4Jw3
	 OX+Q5CtVKmHQJe3tUKvCN8NIAba/tecmk85ItVV+Yhi0gFWqTBcFzRqMCc1DYCxgiA
	 ovDKqV04TEpPniSCAJdsq7zGuGolGSTX0FtX1il2NMbPpUjFC205s1Bcb2PyFjKsMY
	 bH60W2Q+m4UzK+is8AkUFBdfMUEXU6q07ECq6YrwqUsC7TUyKQhd8a15R5OVVrwQ8T
	 9PiIaeQ3WnB9w==
Date: Sat, 16 Dec 2023 12:26:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Zhifeng Tang <zhifeng.tang@unisoc.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhifeng Tang <zhifeng.tang23@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 4/4] dt-bindings: clock: Add reset controller bindings
 for Unisoc's UMS512.
Message-ID: <20231216-service-gallows-797dea781edb@spud>
References: <20231215081003.8373-1-zhifeng.tang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GgSUqh2kPZiHFsMB"
Content-Disposition: inline
In-Reply-To: <20231215081003.8373-1-zhifeng.tang@unisoc.com>


--GgSUqh2kPZiHFsMB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 04:10:03PM +0800, Zhifeng Tang wrote:
> Add Reset Controller bindings to clock bindings for Unisoc's UMS512.

This is what the diff is doing, but there's no justification for why
this is the case. I _assume_ that the clock controller register block
also contains reset bits for some of these peripherals, but the commit
message needs to say that.

Cheers,
Conor.

>=20
> Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml=
 b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> index 43d2b6c31357..6b0892d637fe 100644
> --- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> @@ -34,6 +34,9 @@ properties:
>    "#clock-cells":
>      const: 1
> =20
> +  "#reset-cells":
> +    const: 1
> +
>    clocks:
>      minItems: 1
>      maxItems: 4
> --=20
> 2.17.1
>=20

--GgSUqh2kPZiHFsMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX2XWgAKCRB4tDGHoIJi
0kiJAP43JtrM14++P35LKrXG5klsr/OJjlApZw7S1S0MkmbavgD/QuEZ0BzUaDvP
ONpLEnqB2jvHnLpzkb58PHDSqhgQBgk=
=clIu
-----END PGP SIGNATURE-----

--GgSUqh2kPZiHFsMB--

