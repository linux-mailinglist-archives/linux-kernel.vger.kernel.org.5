Return-Path: <linux-kernel+bounces-147258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E2E8A719F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E61F21A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52112D741;
	Tue, 16 Apr 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeHRO+SC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AB2EAF9;
	Tue, 16 Apr 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285895; cv=none; b=Ubw0eGpGHCUcHPUWrExNCS8bA8uCL1jWj/Pcsd3BZTAwZG8scskd4ejISZ68f5NnH4lXYSqpX8IP/N0B+pAMZJ53Vs7Ly2rtSGa0ikOvGw4bby23wJSg+jCR+r1KO0ighKJwKVRVqvXY0bqHAX1PzRIJ8+DJ5f1IBCzRXUcjBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285895; c=relaxed/simple;
	bh=WFbKwxX8WMuQfW+cB0Y60i7L1vzoyLXTtdrcolu9Gbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxDD2VjIF3xLckXP653mvGr7yekTYSWAzowSDuzm/+49yLBKj9m0JzCI/G46IHGNx3HCi0hxtqM2OJAyJ4a9171k0UwPI6crWNR5nuF+ku8s/N0TWbW0q2tPoS0YBdawsov5sfAtacvC22689t9vUM50XaP7odxR3D+N+bnZabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeHRO+SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1573FC113CE;
	Tue, 16 Apr 2024 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713285895;
	bh=WFbKwxX8WMuQfW+cB0Y60i7L1vzoyLXTtdrcolu9Gbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeHRO+SCyFOm2lrN9+zZTmXWsbUPJELegE9c39+uTW+nLXLSzamhs5IfwqkA+a6B6
	 Imhs4el6W1gohJ8crDSFfRT+CbcC287m/o8+qtxv8NSOJ83MvJ8CNQ5yVxn1XCD7ju
	 HH8VYsaEnVDRMHLSOqje9X8tDJ7A0WU40EgDZYQsuMl8hsG5Ds48ERNiijWgpQJPhr
	 0BgekzClovYy4FWHFNn5G9BXvJ/lbopZnmR/QMdngL3MBt88qYThcx0FNS+2aOwAX1
	 sGGuVhZ8PaH/t3ISr5UgWSXqw1CeyO+2NrV5V8YVbMsJsie54xtDQ3+l7KevVqdimA
	 nrjcKEKNv1mRg==
Date: Tue, 16 Apr 2024 17:44:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2042 support
Message-ID: <20240416-pretext-cognitive-295526072596@spud>
References: <cover.1713258948.git.unicorn_wang@outlook.com>
 <032c06642b01f06c86ba8bcd2108d18c005b57eb.1713258948.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Oj7/7BmivF9LBeQt"
Content-Disposition: inline
In-Reply-To: <032c06642b01f06c86ba8bcd2108d18c005b57eb.1713258948.git.unicorn_wang@outlook.com>


--Oj7/7BmivF9LBeQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:50:37PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.
>=20
> SG2042 defines 3 clocks for SD/eMMC controllers.
> - AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
>   and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
>   source, so reuse existing "core".
> - 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
>   existing "timer" which was added for rockchip specified.
> - EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".
>=20
> Adding some examples.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 67 ++++++++++++++-----
>  1 file changed, 51 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 4d3031d9965f..a04ccae216cf 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -21,6 +21,7 @@ properties:
>        - snps,dwcmshc-sdhci
>        - sophgo,cv1800b-dwcmshc
>        - sophgo,sg2002-dwcmshc
> +      - sophgo,sg2042-dwcmshc
>        - thead,th1520-dwcmshc
> =20
>    reg:
> @@ -30,23 +31,36 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    minItems: 1
> -    items:
> -      - description: core clock
> -      - description: bus clock for optional
> -      - description: axi clock for rockchip specified
> -      - description: block clock for rockchip specified
> -      - description: timer clock for rockchip specified
> -
> +    anyOf:
> +      - minItems: 1
> +        items:
> +          - description: core clock
> +          - description: bus clock for optional
> +          - description: axi clock for rockchip specified
> +          - description: block clock for rockchip specified
> +          - description: timer clock for rockchip specified
> +
> +      - minItems: 1

I don't think this minItems is needed, this is for one device which has
all 3, no?

I also think this combination should only be permitted for the sg2042,
since it is not valid for the existing devices.

Cheers,
Conor.

> +        items:
> +          - description: core clock
> +          - description: timer clock
> +          - description: card clock
> =20
>    clock-names:
> -    minItems: 1
> -    items:
> -      - const: core
> -      - const: bus
> -      - const: axi
> -      - const: block
> -      - const: timer
> +    anyOf:
> +      - minItems: 1
> +        items:
> +          - const: core
> +          - const: bus
> +          - const: axi
> +          - const: block
> +          - const: timer
> +
> +      - minItems: 1
> +        items:
> +          - const: core
> +          - const: timer
> +          - const: card
> =20
>    resets:
>      maxItems: 5
> @@ -96,5 +110,26 @@ examples:
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
>      };
> -
> +  - |
> +    mmc@bb0000 {
> +      compatible =3D "snps,dwcmshc-sdhci";
> +      reg =3D <0xbb000 0x1000>;
> +      interrupts =3D <0 25 0x4>;
> +      clocks =3D <&cru 17>;
> +      clock-names =3D "core";
> +      bus-width =3D <8>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +    };
> +  - |
> +    mmc@cc0000 {
> +      compatible =3D "snps,dwcmshc-sdhci";
> +      reg =3D <0xcc000 0x1000>;
> +      interrupts =3D <0 25 0x4>;
> +      clocks =3D <&cru 17>, <&cru 18>, <&cru 19>;
> +      clock-names =3D "core", "timer", "card";
> +      bus-width =3D <8>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +    };
>  ...
> --=20
> 2.25.1
>=20

--Oj7/7BmivF9LBeQt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6rAAAKCRB4tDGHoIJi
0qoyAQCTaZUNTGi76+cefoQMna0yBcbNZZK6zaaeA6hNVqADngD+LinzXBk8I+hU
Bdhb0V7rfjXZ7RK2SnqiZSWXNVclQAY=
=+oDk
-----END PGP SIGNATURE-----

--Oj7/7BmivF9LBeQt--

