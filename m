Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64D67B52CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjJBMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjJBMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:17:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8810CDB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:09:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D81DC433C9;
        Mon,  2 Oct 2023 12:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696248583;
        bh=XF2JWUI7upFEWvpMLleiS+AFi4n6n/o2bBoXGwL6lk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BecpC1VYEdSlAGMnwJk1z8khG//CgJLN0SwRus9GT82CKiB7g/tbumWSmDLt0FJke
         oLiLsb8Vb4QWoTjlHWfOrKu7z5MGtTb086eMcu1FWrGG+Sio6gs18EwlMaHt0aG0Hj
         bwXKNTQuOsAjQ6aBI4WQYiuZiUGZeKKSYu4mfMVEXgPMxXazT5mm77UwSV4L40cEbh
         Htp754cmmiGJoyjKjbiwPisxe6JPTbpXHD1KNI1fBF0goFDGAs2tLAExKbsstW99U1
         nu6BrQyyDn/M7NR7BM2SqqRcUNWhqGtLONpWzVVbODbuslYRijBSqz/s2JUNbMPq7r
         6CaR5wQk84OOA==
Date:   Mon, 2 Oct 2023 13:09:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device
 tree
Message-ID: <20231002-pessimism-sycamore-a854a098cf43@spud>
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ADpDYkm6P9PW77/"
Content-Disposition: inline
In-Reply-To: <20230930123937.1551-5-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ADpDYkm6P9PW77/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 08:39:36PM +0800, Jisheng Zhang wrote:
> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 117 ++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> new file mode 100644
> index 000000000000..8829bebaa017
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible =3D "sophgo,cv1800b";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	cpus: cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <25000000>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "thead,c906", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			d-cache-block-size =3D <64>;
> +			d-cache-sets =3D <512>;
> +			d-cache-size =3D <65536>;
> +			i-cache-block-size =3D <64>;
> +			i-cache-sets =3D <128>;
> +			i-cache-size =3D <32768>;
> +			mmu-type =3D "riscv,sv39";
> +			riscv,isa =3D "rv64imafdc";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> +					       "zifencei", "zihpm";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#address-cells =3D <0>;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +	};
> +
> +	osc: oscillator {
> +		compatible =3D "fixed-clock";
> +		clock-output-names =3D "osc_25m";
> +		#clock-cells =3D <0>;
> +	};

Is this a stub that will later be replaced by a real clock controller
node, or is this actually a fixed oscillator? If it is the former, could
you add it to the commit message if there is a respin?

Thanks,
Conor.

--7ADpDYkm6P9PW77/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRqzAQAKCRB4tDGHoIJi
0pUpAQCeg85iTvHhxt7N5JpBUouXbz8728VXeHIyIz55IAQEtQEAgvB4/xg9EGuu
tvn8dqb7SzCgq/xW6fGN6uoZFBmJUQI=
=Jjvq
-----END PGP SIGNATURE-----

--7ADpDYkm6P9PW77/--
