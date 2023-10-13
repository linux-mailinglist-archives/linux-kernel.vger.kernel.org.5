Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B07C8160
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjJMJId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjJMJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:08:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70499B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:08:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FE2C433C7;
        Fri, 13 Oct 2023 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188109;
        bh=D3SBs+wve8fXQDw91s7Zt3wTRdjNPe3bByL+Rc+UX4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is2V4cvIWfVlw+zpdr+XW81rENFQj3+Dmw/xQxMg+FeWvTAnyJSlpa27QJCJJC3ZE
         o9/I0jpCjh33sgZ9eXE6SR5PU/b/33ZqACM/ZknutLz93xWWXs/aIw1bJ9y0nMa3kp
         1ffgTRsJS4vVmkvhm8dwSyxKXVDHGriwjtlDwpDZs07yh57q1iciR+0vLa7UBe7JwX
         RJfGEFRrX3FgE83zTDeluHBESuUMGJMnosSv4ieFWewGNbJxB/nrf5sdcZdai3UhS9
         sV7/A2/Bjzb31lgn0ocwOdl98j7Q9TABaYyBxBltVM7JL5ny+kVyrmRL2tPHOc0tir
         M13gHkt8RzWtA==
Date:   Fri, 13 Oct 2023 10:08:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/7] riscv: dts: sophgo: Separate common devices from
 cv1800b soc
Message-ID: <20231013-catchable-wince-f24060feb639@spud>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
 <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HRy542+WJiRGwJph"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HRy542+WJiRGwJph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Mon, Oct 09, 2023 at 07:26:35PM +0800, Inochi Amaoto wrote:
> Move the cpu and the common peripherals of CV181x and CV180x to new file.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 95 +------------------
>  .../dts/sophgo/{cv1800b.dtsi =3D> cv180x.dtsi}  | 19 +---
>  2 files changed, 2 insertions(+), 112 deletions(-)
>  copy arch/riscv/boot/dts/sophgo/{cv1800b.dtsi =3D> cv180x.dtsi} (80%)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index df40e87ee063..0904154f9829 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -3,106 +3,13 @@
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>   */
>=20
> -#include <dt-bindings/interrupt-controller/irq.h>
> +#include "cv180x.dtsi"
>=20
>  / {
>  	compatible =3D "sophgo,cv1800b";
> -	#address-cells =3D <1>;
> -	#size-cells =3D <1>;
> -
> -	cpus: cpus {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		timebase-frequency =3D <25000000>;
> -
> -		cpu0: cpu@0 {
> -			compatible =3D "thead,c906", "riscv";
> -			device_type =3D "cpu";
> -			reg =3D <0>;
> -			d-cache-block-size =3D <64>;
> -			d-cache-sets =3D <512>;
> -			d-cache-size =3D <65536>;
> -			i-cache-block-size =3D <64>;
> -			i-cache-sets =3D <128>;
> -			i-cache-size =3D <32768>;
> -			mmu-type =3D "riscv,sv39";
> -			riscv,isa =3D "rv64imafdc";
> -			riscv,isa-base =3D "rv64i";
> -			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> -
> -			cpu0_intc: interrupt-controller {
> -				compatible =3D "riscv,cpu-intc";
> -				interrupt-controller;
> -				#address-cells =3D <0>;
> -				#interrupt-cells =3D <1>;
> -			};
> -		};
> -	};
> -
> -	osc: oscillator {
> -		compatible =3D "fixed-clock";
> -		clock-output-names =3D "osc_25m";
> -		#clock-cells =3D <0>;
> -	};
>=20
>  	soc {
> -		compatible =3D "simple-bus";
>  		interrupt-parent =3D <&plic>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		dma-noncoherent;
> -		ranges;
> -
> -		uart0: serial@4140000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x04140000 0x100>;
> -			interrupts =3D <44 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&osc>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			status =3D "disabled";
> -		};
> -
> -		uart1: serial@4150000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x04150000 0x100>;
> -			interrupts =3D <45 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&osc>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			status =3D "disabled";
> -		};
> -
> -		uart2: serial@4160000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x04160000 0x100>;
> -			interrupts =3D <46 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&osc>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			status =3D "disabled";
> -		};
> -
> -		uart3: serial@4170000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x04170000 0x100>;
> -			interrupts =3D <47 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&osc>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			status =3D "disabled";
> -		};
> -
> -		uart4: serial@41c0000 {
> -			compatible =3D "snps,dw-apb-uart";
> -			reg =3D <0x041c0000 0x100>;
> -			interrupts =3D <48 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&osc>;
> -			reg-shift =3D <2>;
> -			reg-io-width =3D <4>;
> -			status =3D "disabled";
> -		};
>=20
>  		plic: interrupt-controller@70000000 {
>  			compatible =3D "sophgo,cv1800b-plic", "thead,c900-plic";
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv180x.dtsi
> similarity index 80%
> copy from arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> copy to arch/riscv/boot/dts/sophgo/cv180x.dtsi
> index df40e87ee063..ffaf51724c98 100644

Firstly, this form of diff really threw me, I was quite confused for a
few minutes. A copy plus a pair of diffs doesn't really make much sense,
when the operation being carried is an extraction of some nodes to a
different file.

> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>

Also, is moving around some bits of hw description really a
copyrightable change?

>   */
>=20
>  #include <dt-bindings/interrupt-controller/irq.h>
>=20
>  / {
> -	compatible =3D "sophgo,cv1800b";
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
>=20
> @@ -48,7 +48,6 @@ osc: oscillator {
>=20
>  	soc {
>  		compatible =3D "simple-bus";
> -		interrupt-parent =3D <&plic>;
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
>  		dma-noncoherent;
> @@ -103,21 +102,5 @@ uart4: serial@41c0000 {
>  			reg-io-width =3D <4>;
>  			status =3D "disabled";
>  		};
> -
> -		plic: interrupt-controller@70000000 {
> -			compatible =3D "sophgo,cv1800b-plic", "thead,c900-plic";
> -			reg =3D <0x70000000 0x4000000>;
> -			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
> -			interrupt-controller;
> -			#address-cells =3D <0>;
> -			#interrupt-cells =3D <2>;
> -			riscv,ndev =3D <101>;
> -		};
> -
> -		clint: timer@74000000 {
> -			compatible =3D "sophgo,cv1800b-clint", "thead,c900-clint";
> -			reg =3D <0x74000000 0x10000>;
> -			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
> -		};
>  	};
>  };

What I wanted to comment on was this though - it seems that both the
cv1800b and the cv1812h have identical plic and clint nodes, other than
their compatibles? If that is the case, why create a cv1800b and a
cv1812h specific file containing entirely new nodes, when overriding the
compatible would be sufficient? Doubly so if the other SoCs in the
cv18xx series are going to have identical layouts.

I gave it a quick test locally with the below diff applied on top of
this series - although I didn't make sure that I didn't re-order the
plic & clint nodes, I just wanted to demonstrate what I had done.

Cheers,
Conor.

-- 8< --

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/=
boot/dts/sophgo/cv1800b-milkv-duo.dts
index 3af9e34b3bc7..a9d809a49e7a 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -5,7 +5,7 @@
=20
 /dts-v1/;
=20
-#include "cv1800b.dtsi"
+#include "cv180x.dtsi"
=20
 / {
 	model =3D "Milk-V Duo";
diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/=
sophgo/cv1800b.dtsi
index 0904154f9829..e69de29bb2d1 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include "cv180x.dtsi"
-
-/ {
-	compatible =3D "sophgo,cv1800b";
-
-	soc {
-		interrupt-parent =3D <&plic>;
-
-		plic: interrupt-controller@70000000 {
-			compatible =3D "sophgo,cv1800b-plic", "thead,c900-plic";
-			reg =3D <0x70000000 0x4000000>;
-			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
-			interrupt-controller;
-			#address-cells =3D <0>;
-			#interrupt-cells =3D <2>;
-			riscv,ndev =3D <101>;
-		};
-
-		clint: timer@74000000 {
-			compatible =3D "sophgo,cv1800b-clint", "thead,c900-clint";
-			reg =3D <0x74000000 0x10000>;
-			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
-		};
-	};
-};
diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/s=
ophgo/cv180x.dtsi
index 64ffb23d3626..1a2c44ba4de9 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -48,6 +48,7 @@ osc: oscillator {
=20
 	soc {
 		compatible =3D "simple-bus";
+		interrupt-parent =3D <&plic>;
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
 		dma-noncoherent;
@@ -174,5 +175,21 @@ uart4: serial@41c0000 {
 			reg-io-width =3D <4>;
 			status =3D "disabled";
 		};
+
+		plic: interrupt-controller@70000000 {
+			compatible =3D "sophgo,cv1800b-plic", "thead,c900-plic";
+			reg =3D <0x70000000 0x4000000>;
+			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <2>;
+			riscv,ndev =3D <101>;
+		};
+
+		clint: timer@74000000 {
+			compatible =3D "sophgo,cv1800b-clint", "thead,c900-clint";
+			reg =3D <0x74000000 0x10000>;
+			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
 	};
 };
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/=
sophgo/cv1812h.dtsi
index 3864d34b0100..c0a8d3290cc8 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -15,22 +15,13 @@ memory@80000000 {
 	};
=20
 	soc {
-		interrupt-parent =3D <&plic>;
=20
 		plic: interrupt-controller@70000000 {
 			compatible =3D "sophgo,cv1812h-plic", "thead,c900-plic";
-			reg =3D <0x70000000 0x4000000>;
-			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
-			interrupt-controller;
-			#address-cells =3D <0>;
-			#interrupt-cells =3D <2>;
-			riscv,ndev =3D <101>;
 		};
=20
 		clint: timer@74000000 {
 			compatible =3D "sophgo,cv1812h-clint", "thead,c900-clint";
-			reg =3D <0x74000000 0x10000>;
-			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
 	};
 };


--HRy542+WJiRGwJph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSkJCAAKCRB4tDGHoIJi
0hLjAP9uhdq/uFqw1y5AWsBajuIbbjWB6T8ehBPoOgeVL2rkRgD/WmLiknuSuAEI
BQ55/MLUDoaZ5d+USumgf+i775N/UQg=
=YNF8
-----END PGP SIGNATURE-----

--HRy542+WJiRGwJph--
