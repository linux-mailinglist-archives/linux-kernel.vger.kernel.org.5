Return-Path: <linux-kernel+bounces-116426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F8889EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF616B240BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199DB15B125;
	Mon, 25 Mar 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fm+HL0cF"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B99374718;
	Mon, 25 Mar 2024 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335675; cv=none; b=HvF4mqzPT4V8y2UTU/zY3RxvtfTJt5kALvdSTr4mJJmEszKT5sKKmO1/MIx/XgGEin5wwbS2xrioBi/tRYr6jhWcRX3hzmoldhTYCOXfJdvbReDCIe3W/4+vdl5fRsd0ZakJJCnqezioRKzsLGJLBExyvCtQ5udiJayQ1z+bMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335675; c=relaxed/simple;
	bh=VXgeAPFF1rTPjx3kRfbCpsmSbzT6YcISYipy3cGGt40=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=kcTQ0ArrtAeaAUSY9/UsDRu8taFOPoYR6Ubtv/UG3s4GzAuFmk0YMMbr8fjd3IFvIV1m60hRdZERjuuLODn75Uv9Mwyh4k92MqC4rAo30pUX4pYg43/nfM56nj3kaHvNS2Y1lxbqPoYVxWHOT228JIkXHDr3gtgPFE72Mc0YoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fm+HL0cF; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711335658; bh=UbW4W4tDsqy0oW2t2W5alPaZDTsu9EiVE5yXBkkWlPE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=fm+HL0cFW8CPraNqxdGc3N9dAacVhh0pRVgoSi/+gcZbf6KgbL0ILznOJOwZNlrZ4
	 +VrB0ck5RI76jGQOmS68pmBLwrkHKRaIfSvXd6eJyo7+doHqbIzW6XxCjsg5Y6GnDP
	 Bjg7j3kSzuoHWG/tF2T+NpTKREUuyF9/tIYiF5Dg=
Received: from smtpclient.apple ([2409:8934:1ed6:2f4f:d8d3:a43a:ef25:fb4f])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id EEB2B8C9; Mon, 25 Mar 2024 10:59:43 +0800
X-QQ-mid: xmsmtpt1711335583tbr2cbzf9
Message-ID: <tencent_8D87083646F1F50B566B87380EE1A2C6400A@qq.com>
X-QQ-XMAILINFO: MPaKaX623R7Y3L+KntZXBnC8s97fvZdHtqkRcEVcfuyicfEK3XGJmSr4XQIfjZ
	 KyOx4TEqgHvttfv+R1jFaHtuKBOS2UU9Qk7i01cNPm4L0d+w9wDKQuAgL0/YivGsTS5FvXVf0/nk
	 j/EHpCJwpPrB4XZ9kiv7VxxgI/WjZfZbNlPIaoVVbzyoaLRoYcNRpNwS+YL+JTxSWF2ALX2jr57/
	 uQmcIISEHFnvVwMl09oyfnC4smEodnCbbyF4YD82tuHhoQjaHAvKuX1wVkuABBIys8L6MvIDHL6F
	 E6nwsa0ts+9zQjr/Yc5HH76eJsqm0SBfsQKrNFBYyuuKPc2qsYOutSQLj5JtsLATsMW26pj1WfWp
	 I5L2xZomAW3HR4vvgAYEBxYpEG67okZ//xs7esTekcfg194xv6TMzA4QiEX7KtaCwrjyTT7IYthN
	 Ko8F9BkQwSeEK7OU6LBiFaaIZLelhl8uSwqepyOKya5/xoG4rwr3NAef/E1xFRyvOhmLyu1fi6J2
	 56si97T86z16pq1ePT/Cj1xhnePSVjGZ00KSU4+aiCT0oXbwVFlLvbayE0WagDNAHpsiTq5VbpXp
	 wtxr2jq6EDrb4rqXtbR0zQdjG01br2iUraq0f9zF6kOJu82hfsiAtIOcpqYm6YmaMlxoWFUTGbc/
	 CAPcdSc99rguCu5g1HJpUkH0G/8ZyIpdjMD46pzb2W7dk5U+6LQxBZIHOuUMfvftfJuLrAMTdL4z
	 IDpo1lMMSyJ8Ep4t0lZhDi89eOGX/2QCMPzicYKzdwmAiddwHtV8Hxy8VmaSCuiH69tT4V1DA494
	 37Ufe6SsEvSfkjXA9Hv0ufXLcJhF5C35GHwPp0ELgbixLQLp31gq7vzZx0C3tM3z5Q03mLClKeAz
	 jJQgb8o/bdnL1I3u0gApmIl7Yrt9iNacKYWVn/VBThEoWikxLm75mDLdUSgcDYp5aNIOUDhvq9w5
	 XaJ2ax8qOTImSt/4vaNBRyDQuikCJl4Q4FUjVqPOYEHVglnypsS99l82D0v+QxxZLHcIWKgHQ=
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
In-Reply-To: <53963127c181a76f97ca34b721d11158b45d7f65.camel@icenowy.me>
Date: Mon, 25 Mar 2024 10:59:32 +0800
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
X-OQ-MSGID: <7FE50D77-E6FB-4C1C-BFC2-3E4588F4496E@cyyself.name>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
 <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
 <53963127c181a76f97ca34b721d11158b45d7f65.camel@icenowy.me>
To: Icenowy Zheng <uwu@icenowy.me>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Mar 25, 2024, at 00:24, Icenowy Zheng <uwu@icenowy.me> wrote:
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
>=20
> BTW did you test on K230 EVB? I think only CanMV is currently publicly
> available.
>=20
> If K230 EVB support is not tested, I suggest not adding it.
>=20

Actually I got one K230 EVB and tested on it.

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


