Return-Path: <linux-kernel+bounces-93171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4B872BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B332BB25EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE71612E;
	Wed,  6 Mar 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fbRR/pNg"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08555139D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685185; cv=none; b=bt1MAoAriZoLmJYY2Xf2cFJAoFQYxWYnV3NwQLja1C6SLLpwquKOqmWoj30vxZoxE6LYjo7zPdluWw4K9phODXQxid4nY1S/nb/Td65/QVJ0yU2pj1nrME4brZ/TaE4qrdSuflqMSwaylvx0TJYoywAiWqv6Kg7ZWZLerfT3mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685185; c=relaxed/simple;
	bh=CSFXV2L5fXt997UjPiPcy7wlrK2/a6AmHhunEEDQRpY=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=bi1DSRXnz8607TYEL9GaSn25nThPzlpau7PBpCrkv/duxUafRw+PIMjHqG7SNT5lhRTSNc4y0gVuRqWRZTPBWMfAy8MFKK/OvU7Y5+bCigvAVnQ1Yia85FJ0DqhTx7eodm6npy+vD2vQqvkYKdb+O0T7QJ6OKgPrEwF34N2eeIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fbRR/pNg; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709685179; bh=x4EPX/unzZFoeIl3jLbRWqFEmfzubh3lbLQvLYdUtMI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=fbRR/pNgDB0xMOBBV6jVc6ovXs2m2LtxhpBkuqjVgkPsJ9YqNplt8l/1AzZgtEHIN
	 vE5u3S+FuB6CVKLcr2CISkIYlCZ1Juhup5QtOOJDffEKZS2N/pFAE2+fwfBmniXyEj
	 UTcY2KbkFad+GJpkEKnSR7PgIM6EjJh3fS1ts6nA=
Received: from smtpclient.apple ([2001:da8:c800:d084:c97e:f65d:9c20:e57a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EE87496; Wed, 06 Mar 2024 08:31:46 +0800
X-QQ-mid: xmsmtpt1709685106t34dcha83
Message-ID: <tencent_67A3156E708C4B8856E3399F8F6085B69206@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznan3rGAt6euGEVlBzkTGlrfqYMs8WFHKyxzZmsi8tf/64e+h9TJ
	 E9xMhj6GKYByjkfdNB4+0Hq5lt31dBQYwGYuuqVhQ3oMInKPdY8h2JIKKXaA8THohCitLllO1UDs
	 1LoRpJ9Yt6ONuZEQ3WeiT8hVOizIGamP3d+dfNdm+Pz+8HJrUpNrLMjzBjMkRmuYiNgXwPBbnenp
	 4Erki+B6MQGyJ77VoZ3a2XOFoLNdXhxg/sTyXr84P7AlZPrl+SVLDUkiJrj6yTqOH+gDMaYD19ax
	 KO8hboLElvOCRDczDTZ+iYJI9O13XpHxZAx4fhyTtlINEsbQ7yKy7f9tqCMeqiPO1KG7tKeXrb7K
	 lwtpgMFhQ5UDvZrjdTiFwr2ebbDBPJXpntq5LIQwaJW4mRAdwG+ZTnYyO6Wp3B8lYInpe4g/Og2G
	 E5Vz3z73LWDqCeDYqKWdNWwuv9Iie6nTiKyZTmsI295lg2D5HGftc3QCmeI9bVDoie5Z08C+W47p
	 rU1gcPwAV2eTbKSs7nv53T4W8O+mS+5Zw08sWLMTEBtN6BEU6lZxN7DJA58PPZ/47glAaA+nvz7v
	 tpFWFr7q5gp+6rR1KdEzmAf42QNmUZI1cvF++erHQQRQZASG93cHmQF0lAKlt6xO/1pQ7IaWXgRI
	 BY/cRzpaBmbM2J8HTQXgVZRDFJpxpI0kiCqfC/w3f/OCiW/S7mL6/6Dr3pmrMbxwTe3NehLSeHtk
	 cwM5dLWXEoGjdZccRk52HAj2rJ/LdBpdkijyVqMCsefA6jdg0tXVY6q3ILMZJDKIrqGP+nWnql3U
	 8H1TXf9hUfJK7x7oysVoAIIwghOw+D1euz+Kne1KSF3bgB6GN4zT6icGEas2Q9AsTdwB46lIoQ2F
	 p/QZqaRXrOSVet7rLw33Ztenk3sXFRr0rn0BAyNvH7T4mdfHB2fOROT8gI2rMvdkEQ9fvWbHXT05
	 isXA8MEhTbpzgqJD3fSCW+rKSg2Zm5iEIOVsqdf5xHaudWlx+DJXi9WUyShwh8uRWV0U0uz8MasO
	 3cgoeLFg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v4 6/7] riscv: dts: add initial canmv-k230 and k230-evb
 dts
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <CAJF2gTSWZ8j19jSXsNH=b+_dS3o8yVBYHMg_xP6BDVPduYiifg@mail.gmail.com>
Date: Wed, 6 Mar 2024 08:31:35 +0800
Cc: linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <7A3C1ADE-7FA8-47D2-8C99-98701D2DCB7F@cyyself.name>
References: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
 <tencent_4AA6C678842835E2F069095268533A76E20A@qq.com>
 <CAJF2gTSWZ8j19jSXsNH=b+_dS3o8yVBYHMg_xP6BDVPduYiifg@mail.gmail.com>
To: Guo Ren <guoren@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On Mar 6, 2024, at 07:55, Guo Ren <guoren@kernel.org> wrote:
>=20
> On Wed, Mar 6, 2024 at 3:39=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> =
wrote:
>>=20
>> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan =
Kendryte
>> K230 SoC [1].
>>=20
>> Some key consideration:
>> - Only place BigCore which is 1.6GHz RV64GCBV
>>=20
>> The existence of cache coherence between the two cores remains =
unknown
>> since they have dedicated L2 caches. And the factory SDK uses it for
>> other OS by default. I don't know whether the two CPUs on K230 SoC
>> can be used in one system. So only place BigCore here.
>>=20
>> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
>> CPU1, the csr.mhartid of this core is 0.
>>=20
>> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
>>=20
>> The user manual of C908 from T-Head does not document it =
specifically.
>> It just said it supports B extension V1.0-rc1. [2]
>>=20
>> I have tested it by using this [3] which attempts to execute =
"add.uw",
>> "andn", "clmulr", "bclr" and they doesn't traps on K230. But on =
JH7110,
>> "clmulr" and "bclr" will trap.
>>=20
>> - Support for "zicbom" is tested by hand
>>=20
>> Have tested with some out-of-tree drivers from [4] that need DMA and =
they
>> do not come to the dts currently.
>>=20
>> - Cache parameters are inferred from T-Head docs [2] and Canaan docs =
[1]
>>=20
>> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
> L1i: VIPT non-aliasing

Just wonder how 4-Way can be non-aliasing. If it is 32KB, each way =
should
have 8KB which is larger than the minimum page size.

>> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
> L1d is PIPT

The document says L1d is VIPT. Even on the Chinese version released on
20240218. I think that should be fixed.

Link: =
https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1708231018770/=
%E7%8E%84%E9%93%81C908R1S0%EF%BC%88xrvm%EF%BC%89%E7%94%A8%E6%88%B7%E6%89%8=
B%E5%86%8C_20240218.pdf

>> L2: 256KB, PIPT 16-way set-associative, 64B Cacheline
>>=20
>> The numbers of cache sets are calculated from these parameters.
>>=20
>> - MMU only supports Sv39
>>=20
>> Since T-Head docs [2] say C908 should support Sv48. However, it will =
fail
>> during the kernel probe when running Linux on K230. I also tested it =
by
>> hand on M-Mode software, writing Sv48 to satp.mode will not trap but =
will
>> leave the csr unchanged. While writing Sv39 it will take effect. It =
shows
>> that this CPU does not support Sv48.
>>=20
>> - Svpbmt and T-Head MAEE both supported
>>=20
>> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based =
memory
>> attributes and is controlled by csr.mxstatus. If the kernel wants to =
use
>> svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to =
zero
>> before entering the s-mode kernel. Otherwise, the kernel will not =
boot as 0
>> on T-Head MAEE represent to NonCachable Memory and it will lose dirty =
cache
>> lines modification that haven't been written back to the memory.
>>=20
>> [1] =
https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datashe=
et.html#chapter-1-introduction
>> [2] =
https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369=
347/XuanTie-C908-UserManual.pdf
>> [3] https://github.com/cyyself/rvb_test
>> [4] https://github.com/cyyself/linux/tree/k230-mainline
>>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> ---
>> arch/riscv/boot/dts/canaan/Makefile       |   2 +
>> arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
>> arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
>> arch/riscv/boot/dts/canaan/k230.dtsi      | 140 =
++++++++++++++++++++++
>> 4 files changed, 190 insertions(+)
>> create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
>> create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>> create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
>>=20
>> diff --git a/arch/riscv/boot/dts/canaan/Makefile =
b/arch/riscv/boot/dts/canaan/Makefile
>> index 987d1f0c41f0..7d54ea5c6f3d 100644
>> --- a/arch/riscv/boot/dts/canaan/Makefile
>> +++ b/arch/riscv/boot/dts/canaan/Makefile
>> @@ -1,6 +1,8 @@
>> # SPDX-License-Identifier: GPL-2.0
>> dtb-$(CONFIG_ARCH_CANAAN) +=3D canaan_kd233.dtb
>> dtb-$(CONFIG_ARCH_CANAAN) +=3D k210_generic.dtb
>> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-canmv.dtb
>> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-evb.dtb
>> dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
>> dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
>> dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
>> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts =
b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> new file mode 100644
>> index 000000000000..3ab5c8de11a8
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
>> +               reg =3D <0x0 0x0 0x0 0x1fdff000>;
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       status =3D "okay";
>> +};
>> diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts =
b/arch/riscv/boot/dts/canaan/k230-evb.dts
>> new file mode 100644
>> index 000000000000..42720113c566
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
>> +       compatible =3D "canaan,k230-usip-lp3-evb", =
"canaan,kendryte-k230";
>> +
>> +       chosen {
>> +               stdout-path =3D "serial0:115200n8";
>> +       };
>> +
>> +       ddr: memory@0 {
>> +               device_type =3D "memory";
>> +               reg =3D <0x0 0x0 0x0 0x1fdff000>;
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       status =3D "okay";
>> +};
>> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi =
b/arch/riscv/boot/dts/canaan/k230.dtsi
>> new file mode 100644
>> index 000000000000..0bcff67b78a8
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
>> +                       riscv,isa =3D =
"rv64imafdcv_zba_zbb_zbc_zbs_zicbom_svpbmt";
>> +                       riscv,isa-base =3D "rv64i";
>> +                       riscv,isa-extensions =3D "i", "m", "a", "f", =
"d", "c", "v", "zba", "zbb",
>> +                                              "zbc", "zbs", =
"zicbom", "zicntr", "zicsr",
>> +                                              "zifencei", "zihpm", =
"svpbmt";
> If we use "isa-base + isa-extensions," why shall we keep riscv,isa?
> It's a little bit of a duplicate.
>=20

The mainline OpenSBI can not parse riscv,isa-extensions now. So keep it
for better compatibility.

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
,"thead,c900-plic";
>> +                       reg =3D <0xf 0x00000000 0x0 0x04000000>;
>> +                       interrupts-extended =3D <&cpu0_intc 11>, =
<&cpu0_intc 9>;
>> +                       interrupt-controller;
>> +                       #address-cells =3D <0>;
>> +                       #interrupt-cells =3D <2>;
>> +                       riscv,ndev =3D <208>;
>> +               };
>> +
>> +               clint: timer@f04000000 {
>> +                       compatible =3D "canaan,k230-clint", =
"thead,c900-clint";
>> +                       reg =3D <0xf 0x04000000 0x0 0x04000000>;
>> +                       interrupts-extended =3D <&cpu0_intc 3>, =
<&cpu0_intc 7>;
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
>> --
>> 2.43.0
>>=20
>=20
>=20
> --=20
> Best Regards
> Guo Ren



