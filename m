Return-Path: <linux-kernel+bounces-93121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7678872B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53545B27EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BCC12DDB0;
	Tue,  5 Mar 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBLh9UyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39E3FB9B;
	Tue,  5 Mar 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682956; cv=none; b=VBUfISSSvqUn58r5HgShUZY6i+6lZK+Xfh7j4j2fHv5uiFwomoGEsne5g+eLbh73fV+dQAI4+VXWflT/ThmH9t1i1N/AZo+Re0QjmXPKFUWXQ0fhH7P/seS5WGaoweVpo61LFZ8mUrU8oBocoRgk8k98XViknPtteuUMSHkUaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682956; c=relaxed/simple;
	bh=K2M8IRbGRRrt6WDdOgPA9jwzpbk47dmDS80DCvaK7XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAzGs4f0QHfrYKl/HnZkFr+DkzL+JvW+097a95WgouK8q0/ZgZSjnlS6TdxYCylD3QvU1lldgkmXzdH7SvtTJChj6XoGQ0K3T3nzHkOxxoEQKw1cXmogiKJJkmAJ9Mc7jAUbJKxbN4Hvjq0N/y2G2xL41YUcrz0zNpHBAQv7Sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBLh9UyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E91AC43390;
	Tue,  5 Mar 2024 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709682956;
	bh=K2M8IRbGRRrt6WDdOgPA9jwzpbk47dmDS80DCvaK7XU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VBLh9UyHVeZU6me7O+Cu8WEh3GfJFMu0KpJzjJYE8iVpGu+9hOVtreM5ihrGuxbJ0
	 iwabB1kis7UU0eUIsdITR6FEFH9fe5S4QUzk5RH50U/9gmBCP/szS6RQTgGlLDA7/1
	 JtoVnlI/k4DO9p6tmHgvs2dgFtblhTuMpH47lPbPgMmC3NLLYTFPS2x6rzLeGg3no+
	 Q+ncXseP6CRvWqH3DJ1qgSv0tQ6X3l/iYdM4ApVyElo9FRwvFZCdlPZ46GnezXHccJ
	 iXqbQmn5a95Wqumbn3VMGq1lyr8xD20kmlPFPbr530M4TUEsOq19Kh320YZ1EaptkQ
	 5WYUyTcJTx4eQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a450615d1c4so53787366b.0;
        Tue, 05 Mar 2024 15:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPA5pv+Vz0nVDs/FtlbPg4On5iUybQphJ7gpcVQ+Z0n+olFFgMjFp3Uxa0uaEMUQsNDNB+/Mt0w6JVyHYjUSYqVbwgxYsTlklrg7z4MCLLWtfISQzsJkCAlOdfEfQJXIS62GwHQnbDYA==
X-Gm-Message-State: AOJu0YxTvhzr4CqT53e3pRr/1qQNPrkinuaq2OfqzONoblEpw/UJcUou
	dfCDyjWKdP5YnhuZRbijZ9/je2eObjH3CAMwO1MV5p4uRB/Lo8etBHdLstMKPcKN+JJmbTNCbHG
	RGWMV29jMUTZ+xKVuEpaJzsmUFKo=
X-Google-Smtp-Source: AGHT+IEEFsHwpxSL5jtmu0+B7opm6luEOGNK+fpH5nEbajaCYnpeEq2XXk/nzuU6pKOwOcJtuajidg7FupBApWpkLZo=
X-Received: by 2002:a17:906:a24a:b0:a45:a9ce:f814 with SMTP id
 bi10-20020a170906a24a00b00a45a9cef814mr3130018ejb.15.1709682954673; Tue, 05
 Mar 2024 15:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_587730262984A011834F42D0563BC6B10405@qq.com> <tencent_4AA6C678842835E2F069095268533A76E20A@qq.com>
In-Reply-To: <tencent_4AA6C678842835E2F069095268533A76E20A@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 6 Mar 2024 07:55:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSWZ8j19jSXsNH=b+_dS3o8yVBYHMg_xP6BDVPduYiifg@mail.gmail.com>
Message-ID: <CAJF2gTSWZ8j19jSXsNH=b+_dS3o8yVBYHMg_xP6BDVPduYiifg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] riscv: dts: add initial canmv-k230 and k230-evb dts
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:39=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
> K230 SoC [1].
>
> Some key consideration:
> - Only place BigCore which is 1.6GHz RV64GCBV
>
> The existence of cache coherence between the two cores remains unknown
> since they have dedicated L2 caches. And the factory SDK uses it for
> other OS by default. I don't know whether the two CPUs on K230 SoC
> can be used in one system. So only place BigCore here.
>
> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
> CPU1, the csr.mhartid of this core is 0.
>
> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
>
> The user manual of C908 from T-Head does not document it specifically.
> It just said it supports B extension V1.0-rc1. [2]
>
> I have tested it by using this [3] which attempts to execute "add.uw",
> "andn", "clmulr", "bclr" and they doesn't traps on K230. But on JH7110,
> "clmulr" and "bclr" will trap.
>
> - Support for "zicbom" is tested by hand
>
> Have tested with some out-of-tree drivers from [4] that need DMA and they
> do not come to the dts currently.
>
> - Cache parameters are inferred from T-Head docs [2] and Canaan docs [1]
>
> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
L1i: VIPT non-aliasing
> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
L1d is PIPT
> L2: 256KB, PIPT 16-way set-associative, 64B Cacheline
>
> The numbers of cache sets are calculated from these parameters.
>
> - MMU only supports Sv39
>
> Since T-Head docs [2] say C908 should support Sv48. However, it will fail
> during the kernel probe when running Linux on K230. I also tested it by
> hand on M-Mode software, writing Sv48 to satp.mode will not trap but will
> leave the csr unchanged. While writing Sv39 it will take effect. It shows
> that this CPU does not support Sv48.
>
> - Svpbmt and T-Head MAEE both supported
>
> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based memor=
y
> attributes and is controlled by csr.mxstatus. If the kernel wants to use
> svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to zero
> before entering the s-mode kernel. Otherwise, the kernel will not boot as=
 0
> on T-Head MAEE represent to NonCachable Memory and it will lose dirty cac=
he
> lines modification that haven't been written back to the memory.
>
> [1] https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_da=
tasheet.html#chapter-1-introduction
> [2] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//16992=
68369347/XuanTie-C908-UserManual.pdf
> [3] https://github.com/cyyself/rvb_test
> [4] https://github.com/cyyself/linux/tree/k230-mainline
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/boot/dts/canaan/Makefile       |   2 +
>  arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
>  arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
>  arch/riscv/boot/dts/canaan/k230.dtsi      | 140 ++++++++++++++++++++++
>  4 files changed, 190 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>  create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
>
> diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/ca=
naan/Makefile
> index 987d1f0c41f0..7d54ea5c6f3d 100644
> --- a/arch/riscv/boot/dts/canaan/Makefile
> +++ b/arch/riscv/boot/dts/canaan/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D canaan_kd233.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D k210_generic.dtb
> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-canmv.dtb
> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-evb.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts b/arch/riscv/boot/=
dts/canaan/k230-canmv.dts
> new file mode 100644
> index 000000000000..3ab5c8de11a8
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k230.dtsi"
> +
> +/ {
> +       model =3D "Canaan CanMV-K230";
> +       compatible =3D "canaan,canmv-k230", "canaan,kendryte-k230";
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       ddr: memory@0 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x0 0x0 0x1fdff000>;
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts b/arch/riscv/boot/dt=
s/canaan/k230-evb.dts
> new file mode 100644
> index 000000000000..42720113c566
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k230.dtsi"
> +
> +/ {
> +       model =3D "Kendryte K230 EVB";
> +       compatible =3D "canaan,k230-usip-lp3-evb", "canaan,kendryte-k230"=
;
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       ddr: memory@0 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x0 0x0 0x1fdff000>;
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/c=
anaan/k230.dtsi
> new file mode 100644
> index 000000000000..0bcff67b78a8
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230.dtsi
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/dts-v1/;
> +/ {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +       compatible =3D "canaan,kendryte-k230";
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +       };
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               timebase-frequency =3D <27000000>;
> +
> +               cpu@0 {
> +                       compatible =3D "thead,c908", "riscv";
> +                       device_type =3D "cpu";
> +                       reg =3D <0>;
> +                       riscv,isa =3D "rv64imafdcv_zba_zbb_zbc_zbs_zicbom=
_svpbmt";
> +                       riscv,isa-base =3D "rv64i";
> +                       riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "v", "zba", "zbb",
> +                                              "zbc", "zbs", "zicbom", "z=
icntr", "zicsr",
> +                                              "zifencei", "zihpm", "svpb=
mt";
If we use "isa-base + isa-extensions," why shall we keep riscv,isa?
It's a little bit of a duplicate.

> +                       riscv,cbom-block-size =3D <64>;
> +                       d-cache-block-size =3D <64>;
> +                       d-cache-sets =3D <128>;
> +                       d-cache-size =3D <32768>;
> +                       i-cache-block-size =3D <64>;
> +                       i-cache-sets =3D <128>;
> +                       i-cache-size =3D <32768>;
> +                       next-level-cache =3D <&l2_cache>;
> +                       mmu-type =3D "riscv,sv39";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               compatible =3D "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <1>;
> +                       };
> +               };
> +
> +               l2_cache: l2-cache {
> +                       compatible =3D "cache";
> +                       cache-block-size =3D <64>;
> +                       cache-level =3D <2>;
> +                       cache-size =3D <262144>;
> +                       cache-sets =3D <256>;
> +                       cache-unified;
> +               };
> +       };
> +
> +       apb_clk: apb-clk-clock {
> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <50000000>;
> +               clock-output-names =3D "apb_clk";
> +               #clock-cells =3D <0>;
> +       };
> +
> +       soc {
> +               compatible =3D "simple-bus";
> +               interrupt-parent =3D <&plic>;
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               dma-noncoherent;
> +               ranges;
> +
> +               plic: interrupt-controller@f00000000 {
> +                       compatible =3D "canaan,k230-plic" ,"thead,c900-pl=
ic";
> +                       reg =3D <0xf 0x00000000 0x0 0x04000000>;
> +                       interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_i=
ntc 9>;
> +                       interrupt-controller;
> +                       #address-cells =3D <0>;
> +                       #interrupt-cells =3D <2>;
> +                       riscv,ndev =3D <208>;
> +               };
> +
> +               clint: timer@f04000000 {
> +                       compatible =3D "canaan,k230-clint", "thead,c900-c=
lint";
> +                       reg =3D <0xf 0x04000000 0x0 0x04000000>;
> +                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>;
> +               };
> +
> +               uart0: serial@91400000 {
> +                       compatible =3D "snps,dw-apb-uart";
> +                       reg =3D <0x0 0x91400000 0x0 0x1000>;
> +                       clocks =3D <&apb_clk>;
> +                       interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart1: serial@91401000 {
> +                       compatible =3D "snps,dw-apb-uart";
> +                       reg =3D <0x0 0x91401000 0x0 0x1000>;
> +                       clocks =3D <&apb_clk>;
> +                       interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart2: serial@91402000 {
> +                       compatible =3D "snps,dw-apb-uart";
> +                       reg =3D <0x0 0x91402000 0x0 0x1000>;
> +                       clocks =3D <&apb_clk>;
> +                       interrupts =3D <18 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart3: serial@91403000 {
> +                       compatible =3D "snps,dw-apb-uart";
> +                       reg =3D <0x0 0x91403000 0x0 0x1000>;
> +                       clocks =3D <&apb_clk>;
> +                       interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       status =3D "disabled";
> +               };
> +
> +               uart4: serial@91404000 {
> +                       compatible =3D "snps,dw-apb-uart";
> +                       reg =3D <0x0 0x91404000 0x0 0x1000>;
> +                       clocks =3D <&apb_clk>;
> +                       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg-io-width =3D <4>;
> +                       reg-shift =3D <2>;
> +                       status =3D "disabled";
> +               };
> +       };
> +};
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren

