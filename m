Return-Path: <linux-kernel+bounces-24875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E7182C419
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B923B1F24747
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669517C85;
	Fri, 12 Jan 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sryWrizc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE517C78;
	Fri, 12 Jan 2024 16:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7067AC43390;
	Fri, 12 Jan 2024 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078689;
	bh=R017C35XZgULOTl/xha7MyuS1RZo/GZh2uHIhJvPTbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sryWrizcLFiIRtjL2T2O6J7y4Xf1KNRTjVhxcm6onbBPZtNH00DpE2nWImgF/qG90
	 Ez4H++i94x6WyBeSN83a+c5wPpBwvKUtxeeb/jd+RGn5zmF2Tf0D/iquqSX4iJns7M
	 /wMfqFRKTi9z77H8BuEOmD18h4fE5G0KOBhZqRt86tmOg1gcouFERrO3ihwf51HSnx
	 QVjcn8ILDd40b+hv9NeRCMs9P6MmY/rDOpj6JJUz6ESYxRHnLJlK49B/5bafsjOia3
	 JUNWm5H6MniZio06IaTuyedkZ8zoObTyH4H1orTW07gFL7FyWD0iBZE02oA2/8x/f1
	 6marEdWt9+q6A==
Date: Fri, 12 Jan 2024 16:58:04 +0000
From: Conor Dooley <conor@kernel.org>
To: KyuHyuk Lee <lee@kyuhyuk.kr>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1S
 board
Message-ID: <20240112-granola-underline-36a525dc789c@spud>
References: <20240112134230.28055-1-lee@kyuhyuk.kr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8SF8l+0YFEFPpEIl"
Content-Disposition: inline
In-Reply-To: <20240112134230.28055-1-lee@kyuhyuk.kr>


--8SF8l+0YFEFPpEIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:42:30PM +0900, KyuHyuk Lee wrote:
> Add device tree binding for Hardkernel ODROID-M1S board based on
> RK3566 SoC.
>=20
> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index 5cf5cbef2cf5..cc37d2118131 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -566,6 +566,11 @@ properties:
>            - const: rockchip,rk3568-odroid-m1
>            - const: rockchip,rk3568
> =20
> +      - description: Hardkernel Odroid M1S

if the vendor for this board is hardkernel...

> +        items:
> +          - const: rockchip,rk3566-odroid-m1s

=2E..why is the vendor prefix here rockchip?

Thanks,
Conor.

> +          - const: rockchip,rk3566
> +
>        - description: Hugsun X99 TV Box
>          items:
>            - const: hugsun,x99
> --=20
> 2.34.1
>=20

--8SF8l+0YFEFPpEIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaFvnAAKCRB4tDGHoIJi
0n/AAQDkHzkEpbkEcPgsWiysuI7BEp4nrEoSAcQvm/4eChZuegD6Aztb5FfajYfD
gJvPbsipxJ9PyVMsiM5/pyUwU68MZwk=
=bjqJ
-----END PGP SIGNATURE-----

--8SF8l+0YFEFPpEIl--

