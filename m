Return-Path: <linux-kernel+bounces-116449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A6889F11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B222C2D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539A131180;
	Mon, 25 Mar 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aGhicSBE"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D961741F4;
	Mon, 25 Mar 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336282; cv=none; b=Smnyv3CeDZsP6m3iN/dFVzRgx/qKZ5Ngpn0sWQe0DZC9wqQ2T3ggsQ7+cJCfQqHC4PeGBc7xt//NW+9sWlgwhZloZSrDegDAajU4MVA3LcN+GwacFI5Y3FexdXE34i/6VnCM9dLCI7kk+TCPFXPUKScZEyQ4HQ7TnuRIHkMe7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336282; c=relaxed/simple;
	bh=QyR7G2g5fKQ3VhpVolyFdNyxQKfewgfnRzTt3lpBxJk=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=jRLxcgqvVO2++bpSriSkjRyVLSR+M0gK4O++jYAIVc8FokKw9CYySWo4Lp2s6iwwL2iPCD3B9z/w3/txRh/TF6UBhwdKaU8fcTb82AL4V55XX/iiYHKfsRsn2Os4Ns6ML+rUpVcEYUwQ1wa7j1r49LTb5yjMwF0ng2v3ABth4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aGhicSBE; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711336265; bh=APC1Tm2pZqHjaNLBkpAYawbKau/26igAPeHOWvQ6K9k=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=aGhicSBEbbRvdWpAmdE69COK4YDZCcy32qE4YNLSDl0iapF2ton3exmlyIG7T+/YX
	 HCIfugpnZxW80LFYRUY+0bZN5fzi/qi/JjGVWuef6nY5uVoBKqOB5SwHYDUf9Nd/+T
	 nuie4gPT9QzeVsIui3o7UmWSOUFYUXrZtEFIjY+w=
Received: from smtpclient.apple ([2409:8934:1ed6:2f4f:d8d3:a43a:ef25:fb4f])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 2BB9002C; Mon, 25 Mar 2024 11:10:59 +0800
X-QQ-mid: xmsmtpt1711336259t2zniab2n
Message-ID: <tencent_1C21558D2A7C7B8251DA4E8E08B82E313C08@qq.com>
X-QQ-XMAILINFO: OK7NBzdNss/RBTqjwMX7XKHxirLNSsvTfV07l/ehhcetDtvXxGNF12+pcL7cd8
	 1TGlxtdRXYjZrxfxYPLbLdEVf54pFsf/NN+VpeuWoWXBGnhq/Biho/ER3KiAOa3k7vKTmFc26pxX
	 Z01l+s2Vx6aX0XoLgVllVyifzJbI+hN2zGagES1HiC6AcFqthSvcroC2ACg8t9JgvGhgyjTzOBAy
	 c3MWgLu6L8YAT1MLFuJ4kI0znKfwNJ0xGJ3oTwIW7wlxE8u9eE2l+E+dzjkzJ7wnIHjPJrd7ZXxO
	 8xtRBJFd200WK+w92lE0ZHOVYGQJ2IjjKcaOk0X/jncjtnDht9KOd8UYtJM+2CwA6AnRrsP1Vfds
	 3i/OkrOzzF4l5Eu8vi0lliQNaVQtPwY/d3AErlugPyL5W/Bqm03PdXhIsIKrbV/nwtHeL2+GKoNI
	 LTh53U7TB2ATwGa5RkutiUsp/C2ID7EwXghUuaAVVtgCUsl7E3luqC9xGSooJMYexhkjksvYOpsA
	 isNGCi0Yj4NFnV0bTKV/vH1NigS0RC+7ATeem0uhOvgls8AeDymOnlnbsWDsrIJib7FsKlBXe+Hf
	 Z6egGeNw2CBAbNLZDCqx+gczKB++bQJAwGdKtzVFUMRox0Y9MPRtyWUxFCafmyKYgh6XKJ3zFT8U
	 aCNdLw7/VIMcMZ8yMU0Y0+H6Rb2SKLZaVudi5z0FyCqhWaJ04H3bw1VtWuvpPtwpfALl+ybsDfXA
	 OKc5x1FT+2eQ/TNZwyEcm3wWj68etTP3AjaeuZ5s4ZEUcY0/iaZXGfkQIC9QdCPSkOm26KiielTj
	 elmHSUZBw7Vo60VYCRNDuD+V6rQxDwcxZKPvUrygl+JmyZFxmAFnEeqAkcg4nUWkOGXTqwhqpQjx
	 S7MbXeukQHF6+LWCrAAr+z5zhJdqjmpPuxxhVn/Lxqz9sbLjHG8D+OyDF/mW2I8Zmgz1NeJOX6ru
	 1Y2X9LOqQqyhJctY1pid/JtkNmBUBc4WXyV7LGRBe5rVEry3IX9vkTVjTgse+p1KA6lYJ/3ITbpt
	 UaeXdJ1CR/LcTHnf94r6rZl4xcNXbqT5D+SSparg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v6 10/11] riscv: dts: add initial canmv-k230 and k230-evb
 dts
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <c052918c13069cfcf768d03518560c65c990b220.camel@icenowy.me>
Date: Mon, 25 Mar 2024 11:10:49 +0800
Cc: linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-gpio@vger.kernel.org,
 linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <BDA8DE0E-D525-4EEE-A644-54E33B2C703E@cyyself.name>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
 <c052918c13069cfcf768d03518560c65c990b220.camel@icenowy.me>
To: Icenowy Zheng <uwu@icenowy.me>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Mar 25, 2024, at 00:23, Icenowy Zheng <uwu@icenowy.me> wrote:
>=20
> =E5=9C=A8 2024-03-23=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 20:12 =
+0800=EF=BC=8CYangyu Chen=E5=86=99=E9=81=93=EF=BC=9A
>> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan
>> Kendryte
>> K230 SoC [1].
>>=20
>> Some key consideration:
>>=20
>> - Only place BigCore which is 1.6GHz RV64GCBV
>>=20
>> The existence of cache coherence between the two cores remains
>> unknown
>> since they have dedicated L2 caches. And the factory SDK uses it for
>> other OS by default. I don't know whether the two CPUs on K230 SoC
>> can be used in one system. So only place BigCore here.
>>=20
>> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
>> CPU1, the CSR.MHARTID of this core is 0.
>=20
> I assume as these two cores do not have any coherency, they are just =
in
> different hartid namespace.
>=20

Thanks for this hint.

>>=20
>> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
>>=20
>> The user manual of C908 from T-Head does not document it
>> specifically.
>> It just said it supports B extension V1.0. [2]
>>=20
>> I have tested it by using this [3] which attempts to execute
>> "add.uw",
>> "andn", "clmulr", "bclr" and they doesn't traps on K230. But on
>> JH7110,
>> "clmulr" and "bclr" will trap.
>>=20
>> - Support for "zicbom" is tested by hand
>>=20
>> Have tested with some out-of-tree drivers from [4] that need DMA and
>> they
>> do not come to the dts currently.
>>=20
>> - Cache parameters are inferred from T-Head docs [2] and Canaan docs
>> [1]
>>=20
>> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
>> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
>> L2: 256KB, PIPT 16-way set-associative, 64B Cacheline
>>=20
>> The numbers of cache sets are calculated from these parameters.
>>=20
>> - MMU only supports Sv39
>>=20
>> The T-Head docs [2] say the C908 core can be configured to support
>> Sv48 and
>> Sv39 or only Sv39. On K230, I tried to write "riscv,sv48" on mmu-type
>> in
>> dts and boot the mainline kernel. However, it failed during the
>> kernel
>> probe and fell back to Sv39. I also tested it on M-Mode software,
>> writing
>> Sv48 to satp.mode will not trap but will leave the CSR unchanged.
>=20
> It's specified by the spec that writing a unsupported mode to SATP =
will
> leave SATP unchanged, and it's also how the kernel detects for =
Sv48/57.
>=20
> If a hardware fail to implement this behavior (make SATP changes when
> writing an unsupported mode), the kernel will fail to boot and =
manually
> specify MMU mode by putting noXlvl to command line is required. This
> behavior may be observed on FSL1030M SoC of Milk-V Vega (if it ever
> runs mainline kernel).
>=20

OK.

>> While
>> writing Sv39, it will take effect. It shows that this CPU does not
>> support
>> Sv48.
>>=20
>> - Svpbmt and T-Head MAEE both supported
>>=20
>> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based
>> memory
>> attributes and is controlled by BIT(21) on CSR.MXSTATUS. The Svpbmt
>> is used
>> here for mainline kernel support for K230. If the kernel wants to use
>> Svpbmt, the M-Mode software should unset BIT(21) of CSR.MXSTATUS
>> before
>> entering the S-Mode kernel. Otherwise, the kernel will not boot, as 0
>> on
>> T-Head MAEE is NonCachable Memory. Once the kernel switches from bare
>> metal
>> to Sv39, It will lose dirty cache line modifications that haven't
>> been
>> written back to the memory.
>=20
> As MXSTATUS has a S-mode read-only mirror known as SXSTATUS, maybe the
> kernel should detect SXSTATUS to decide whether to use Svpbmt or
> Xtheadpbmt (BTW Svnapot conflicts with Xtheadpbmt too).
>=20

Thanks for this hint. I may need to change some code in the T-Head PBMT =
probe.

>>=20
>> [1]
>> =
https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datashe=
et.html#chapter-1-introduction
>> [2]
>> =
https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369=
347/XuanTie-C908-UserManual.pdf
>> [3] https://github.com/cyyself/rvb_test
>> [4] https://github.com/cyyself/linux/tree/k230-mainline
>>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> ---
>>  arch/riscv/boot/dts/canaan/Makefile       |   2 +
>>  arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
>>  arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
>>  arch/riscv/boot/dts/canaan/k230.dtsi      | 140
>> ++++++++++++++++++++++
>>  4 files changed, 190 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
>>  create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>>  create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
>>=20
>> diff --git a/arch/riscv/boot/dts/canaan/Makefile
>> b/arch/riscv/boot/dts/canaan/Makefile
>> index 987d1f0c41f0..7d54ea5c6f3d 100644
>> --- a/arch/riscv/boot/dts/canaan/Makefile
>> +++ b/arch/riscv/boot/dts/canaan/Makefile
>> @@ -1,6 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_CANAAN) +=3D canaan_kd233.dtb
>>  dtb-$(CONFIG_ARCH_CANAAN) +=3D k210_generic.dtb
>> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-canmv.dtb
>> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-evb.dtb
>>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
>>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
>>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
>> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> new file mode 100644
>> index 000000000000..9565915cead6
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>> + */
>> +
>> +#include "k230.dtsi"
>> +
>> +/ {
>> +       model =3D "Canaan CanMV-K230";
>> +       compatible =3D "canaan,canmv-k230", "canaan,kendryte-k230";
>> +
>> +       chosen {
>> +               stdout-path =3D "serial0:115200n8";
>> +       };
>> +
>> +       ddr: memory@0 {
>> +               device_type =3D "memory";
>> +               reg =3D <0x0 0x0 0x0 0x20000000>;
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       status =3D "okay";
>> +};
>> diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts
>> b/arch/riscv/boot/dts/canaan/k230-evb.dts
>> new file mode 100644
>> index 000000000000..f898b8e62368
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>> + */
>> +
>> +#include "k230.dtsi"
>> +
>> +/ {
>> +       model =3D "Kendryte K230 EVB";
>> +       compatible =3D "canaan,k230-usip-lp3-evb", "canaan,kendryte-
>> k230";
>> +
>> +       chosen {
>> +               stdout-path =3D "serial0:115200n8";
>> +       };
>> +
>> +       ddr: memory@0 {
>> +               device_type =3D "memory";
>> +               reg =3D <0x0 0x0 0x0 0x20000000>;
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       status =3D "okay";
>> +};
>> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi
>> b/arch/riscv/boot/dts/canaan/k230.dtsi
>> new file mode 100644
>> index 000000000000..7da49498945e
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/canaan/k230.dtsi
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/dts-v1/;
>> +/ {
>> +       #address-cells =3D <2>;
>> +       #size-cells =3D <2>;
>> +       compatible =3D "canaan,kendryte-k230";
>> +
>> +       aliases {
>> +               serial0 =3D &uart0;
>> +       };
>> +
>> +       cpus {
>> +               #address-cells =3D <1>;
>> +               #size-cells =3D <0>;
>> +               timebase-frequency =3D <27000000>;
>> +
>> +               cpu@0 {
>> +                       compatible =3D "thead,c908", "riscv";
>> +                       device_type =3D "cpu";
>> +                       reg =3D <0>;
>> +                       riscv,isa =3D
>> "rv64imafdcv_zba_zbb_zbc_zbs_zicbom_svpbmt";
>> +                       riscv,isa-base =3D "rv64i";
>> +                       riscv,isa-extensions =3D "i", "m", "a", "f",
>> "d", "c", "v", "zba", "zbb",
>> +                                              "zbc", "zbs",
>> "zicbom", "zicntr", "zicsr",
>> +                                              "zifencei", "zihpm",
>> "svpbmt";
>> +                       riscv,cbom-block-size =3D <64>;
>> +                       d-cache-block-size =3D <64>;
>> +                       d-cache-sets =3D <128>;
>> +                       d-cache-size =3D <32768>;
>> +                       i-cache-block-size =3D <64>;
>> +                       i-cache-sets =3D <128>;
>> +                       i-cache-size =3D <32768>;
>> +                       next-level-cache =3D <&l2_cache>;
>> +                       mmu-type =3D "riscv,sv39";
>> +
>> +                       cpu0_intc: interrupt-controller {
>> +                               compatible =3D "riscv,cpu-intc";
>> +                               interrupt-controller;
>> +                               #interrupt-cells =3D <1>;
>> +                       };
>> +               };
>> +
>> +               l2_cache: l2-cache {
>> +                       compatible =3D "cache";
>> +                       cache-block-size =3D <64>;
>> +                       cache-level =3D <2>;
>> +                       cache-size =3D <262144>;
>> +                       cache-sets =3D <256>;
>> +                       cache-unified;
>> +               };
>> +       };
>> +
>> +       apb_clk: apb-clk-clock {
>> +               compatible =3D "fixed-clock";
>> +               clock-frequency =3D <50000000>;
>> +               clock-output-names =3D "apb_clk";
>> +               #clock-cells =3D <0>;
>> +       };
>> +
>> +       soc {
>> +               compatible =3D "simple-bus";
>> +               interrupt-parent =3D <&plic>;
>> +               #address-cells =3D <2>;
>> +               #size-cells =3D <2>;
>> +               dma-noncoherent;
>> +               ranges;
>> +
>> +               plic: interrupt-controller@f00000000 {
>> +                       compatible =3D "canaan,k230-plic" =
,"thead,c900-
>> plic";
>> +                       reg =3D <0xf 0x00000000 0x0 0x04000000>;
>> +                       interrupts-extended =3D <&cpu0_intc 11>,
>> <&cpu0_intc 9>;
>> +                       interrupt-controller;
>> +                       #address-cells =3D <0>;
>> +                       #interrupt-cells =3D <2>;
>> +                       riscv,ndev =3D <208>;
>> +               };
>> +
>> +               clint: timer@f04000000 {
>> +                       compatible =3D "canaan,k230-clint",
>> "thead,c900-clint";
>> +                       reg =3D <0xf 0x04000000 0x0 0x00010000>;
>> +                       interrupts-extended =3D <&cpu0_intc 3>,
>> <&cpu0_intc 7>;
>> +               };
>> +
>> +               uart0: serial@91400000 {
>> +                       compatible =3D "snps,dw-apb-uart";
>> +                       reg =3D <0x0 0x91400000 0x0 0x1000>;
>> +                       clocks =3D <&apb_clk>;
>> +                       interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>;
>> +                       reg-io-width =3D <4>;
>> +                       reg-shift =3D <2>;
>> +                       status =3D "disabled";
>> +               };
>> +
>> +               uart1: serial@91401000 {
>> +                       compatible =3D "snps,dw-apb-uart";
>> +                       reg =3D <0x0 0x91401000 0x0 0x1000>;
>> +                       clocks =3D <&apb_clk>;
>> +                       interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
>> +                       reg-io-width =3D <4>;
>> +                       reg-shift =3D <2>;
>> +                       status =3D "disabled";
>> +               };
>> +
>> +               uart2: serial@91402000 {
>> +                       compatible =3D "snps,dw-apb-uart";
>> +                       reg =3D <0x0 0x91402000 0x0 0x1000>;
>> +                       clocks =3D <&apb_clk>;
>> +                       interrupts =3D <18 IRQ_TYPE_LEVEL_HIGH>;
>> +                       reg-io-width =3D <4>;
>> +                       reg-shift =3D <2>;
>> +                       status =3D "disabled";
>> +               };
>> +
>> +               uart3: serial@91403000 {
>> +                       compatible =3D "snps,dw-apb-uart";
>> +                       reg =3D <0x0 0x91403000 0x0 0x1000>;
>> +                       clocks =3D <&apb_clk>;
>> +                       interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH>;
>> +                       reg-io-width =3D <4>;
>> +                       reg-shift =3D <2>;
>> +                       status =3D "disabled";
>> +               };
>> +
>> +               uart4: serial@91404000 {
>> +                       compatible =3D "snps,dw-apb-uart";
>> +                       reg =3D <0x0 0x91404000 0x0 0x1000>;
>> +                       clocks =3D <&apb_clk>;
>> +                       interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
>> +                       reg-io-width =3D <4>;
>> +                       reg-shift =3D <2>;
>> +                       status =3D "disabled";
>> +               };
>> +       };
>> +};
>=20


