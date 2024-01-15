Return-Path: <linux-kernel+bounces-26231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB2282DD25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD231F2420E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B7317BA5;
	Mon, 15 Jan 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dft+f3XU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B8179A8;
	Mon, 15 Jan 2024 16:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCC0C433F1;
	Mon, 15 Jan 2024 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705335282;
	bh=oFHDHrfraifWkAfPssyWtOw5eGjlMh4j/nlEhzflvwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dft+f3XU+5q3JQBtexvHhU6cEfGUjuSI603NmeD+e1JJjcj7UIoTng0azn869Hu2S
	 TxWSE8ATbD1Wr6Vvr1w6QiQfDBLMaBmFaPuKyGzOlTkvlxEJ0lSXXvJfgQE4rnnIOI
	 GjU/ezHf9cownn6Od5kCjxy5GTaJtOxtiFWixXEGxQVkcGGU1Jkrn0Vo2tyD3d6MpS
	 XonskVhb0semD+wCq67qG5jJrMWxKW2T6tYfWE5pIlyM8TcRYlj/g+IfrmjysUFq6u
	 0xs9H5ZRjvawhdeNG8PfdOddcpL+UNCnwDPgddIG5W5Tb3EPDO3ZVWHvNN8nv5TVWK
	 fQwH0+wcBKIyw==
Date: Mon, 15 Jan 2024 16:14:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, praneeth@ti.com, nm@ti.com,
	vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com,
	kristo@kernel.org
Subject: Re: [DO NOT MERGE PATCH 2/2] arm64: dts: ti: Add common1 register
 space for AM62x and AM65x SoCs
Message-ID: <20240115-penpal-pluck-d156ccf21b2f@spud>
References: <20240115125716.560363-1-devarsht@ti.com>
 <20240115125716.560363-3-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EWEsO7gptdwlcP6E"
Content-Disposition: inline
In-Reply-To: <20240115125716.560363-3-devarsht@ti.com>


--EWEsO7gptdwlcP6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 06:27:16PM +0530, Devarsh Thakkar wrote:
> This adds common1 register space for AM62x and AM65x SoC's which are using
> TI's Keystone display hardware and supporting it as described in
> Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml.
>=20
> This region is documented in respective Technical Reference Manuals [1].
>=20
> [1]:
> AM62x TRM:
> https://www.ti.com/lit/pdf/spruiv7 (Section 14.8.9.1 DSS Registers)
>=20
> AM65x TRM:
> https://www.ti.com/lit/pdf/spruid7 (Section 12.6.5 DSS Registers)
>=20
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---

"[DO NOT MERGE PATCH 2/2]" but no rationale here as to why this cannot
be merged? What's the problem with it?

Cheers,
Conor.

>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++--
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am62-main.dtsi
> index 464b7565d085..298bf8d5de8c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -779,9 +779,10 @@ dss: dss@30200000 {
>  		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
>  		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
>  		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
> -		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
> +		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
> +		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
>  		reg-names =3D "common", "vidl1", "vid",
> -			    "ovr1", "ovr2", "vp1", "vp2";
> +			    "ovr1", "ovr2", "vp1", "vp2", "common1";
>  		power-domains =3D <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
>  		clocks =3D <&k3_clks 186 6>,
>  			 <&dss_vp1_clk>,
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am65-main.dtsi
> index fcea54465636..5b2d4365b911 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -1019,9 +1019,10 @@ dss: dss@4a00000 {
>  		      <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
>  		      <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
>  		      <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
> -		      <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
> +		      <0x0 0x04a0b000 0x0 0x1000>, /* vp2 */
> +		      <0x0 0x04a01000 0x0 0x1000>; /* common1 */
>  		reg-names =3D "common", "vidl1", "vid",
> -			"ovr1", "ovr2", "vp1", "vp2";
> +			"ovr1", "ovr2", "vp1", "vp2", "common1";
> =20
>  		ti,am65x-oldi-io-ctrl =3D <&dss_oldi_io_ctrl>;
> =20
> --=20
> 2.34.1
>=20

--EWEsO7gptdwlcP6E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVZ7AAKCRB4tDGHoIJi
0gmVAQCycsV6IY+P0AFXj/AlMt4Agx6vSdMMVnVZ1KF6EhRZMwEA6d3M1RbFwm8/
6axXz/B9afZdx33i6/6CYSYqgin5QA4=
=N28P
-----END PGP SIGNATURE-----

--EWEsO7gptdwlcP6E--

