Return-Path: <linux-kernel+bounces-92697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C25872477
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1421C22F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42F3201;
	Tue,  5 Mar 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="B5aX4l5Q"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65979C15D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656656; cv=none; b=HMHgP9hFrZ/Og29DB3Q2WOYDYJHCk9I9nyB3j55PO530RGa/PBQs2eMSz/DPkyKy/LFrwsHyzDzAQBKfLbmM96bEw8MCL6mgTPlaQlgTvGLBb89b1bqQTOjaWgwhKUHSxHHBB0QWPu9dEnFc8/NGnS2GdKzTjgy8Nb4PFh5ixjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656656; c=relaxed/simple;
	bh=J0RRABHKT8p5Q/GQBsVXtk+hL1XUxxR4YjY2uM+vOZ8=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=t2WBNYWtI8yqPI1SJzYay3WlKX+cXd5J+Qf0jnjSxb8zHAXIjRzrgbd53+7SDkSoG1ajtUTjMHpuLzdcZVIEsMBxwIcRqoGGUf5wlFz8mCzJUdjl/u35iseeI9ssB9+wLzphYSrophYPZzM+Oidj7nQeMig1awOTGUlMuHX1vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=B5aX4l5Q; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709656650; bh=Gzy5PWMu7Yf6Y7aoDGfFeTWBQ5BLdTnCcxSVt+GMTUs=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=B5aX4l5Ql723yUIbuu3ZLO/ywgmCQn4dQIa+eDpmcsVLQLtv3bVLvpHwldcqU8w1K
	 wHcRy47SnN3FPQSW1M4T9wvqDxIQ5qm95sGNz9VHPJsFed60t/FMWKyiXhr138bkZ0
	 8XHvfzWuo3Qot4/k4UpSaexk07lwWDCs7kCxesNE=
Received: from smtpclient.apple ([2001:da8:c800:d084:84f7:c158:bab8:8899])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 95AB161D; Wed, 06 Mar 2024 00:37:26 +0800
X-QQ-mid: xmsmtpt1709656646thr7j38gv
Message-ID: <tencent_B2C1146D4947315C8018AE90EDC64F3E6207@qq.com>
X-QQ-XMAILINFO: NLNuKjcZ2ePXzpUHGnPFvvBha1MWlRgd848/rDtOT2aUS59DS6vMBBeC5CploR
	 OqwjnOhN0MeVXUhavML7QtKxgbkvPl47RAohVZGZJc3Jn9aH/ptxtZ19RzsZeXqp6GSEax1DY/qP
	 cyNHnAG4rARTuE7+VaC52+YQmMPs05DVJXyaY+7ivXTVqMyz1rMkgywgUV5fRHZ6n+COix47qeo2
	 OzXWUkec3VB4BCFeBBBg0ayNwqKIPSZKgnNrouYnB/LmJq7NMHHgfiGa6UFH5xgJZi9Kq/RwR9FQ
	 bt5zS+JIeQJRkNQ5kDHl/fryr1OpOp/TT0RvElwo2dmAS1ToHcoIsKsKw5X3yD2VR0SBiiZwSGZR
	 tzGCDodliCwZBPD1mF4cSA3li9oPNU2ud23NdAMSVeuF/iwwSfa8tRWb2P1QiWuwI87sJJnyjWAJ
	 095YS8UwWupRa8hhF5kvqqHm2j+h58fpGyTWtJrnZNZ9aZ6xwR7wql5NwgMVPlBJn2Io8Bhx21yM
	 qUM4YQ8nKwWf2+8vZyM7ad3VaR58pnZBD/hXggu3gaxdgAoCYh4vzQfibF4oreCyMEPJcR4myX+F
	 YPcFz0447hxKsPgvyssCt02BkVvXlpxQG6Hwsx/oiWEYaXW0KK5ceCUJOuKw6jq7vqUoKv4lczAI
	 R3mTLKlvSCP549PhTIDFjO2tLxtefMaFUdEy0TGyjtrCLoGEUznsWyuAFeUh2X1fTzL7zVkCT/D6
	 685dUl9TSpATrmCTL28hVvsjyy+wjNsouAUZIPYmqeFt83Aajk/qJzjbP7h1l9bV5EAew/Ls/Buv
	 nCSFQHrhSuG+Q8dB+CBkZ+d0YHgoM9sJPq9E+noODTc4141GIHroEBHLlRduqjGjJWMC4ph5o3Ct
	 p3ht9GKlKz2ShfWpakQViNWF781gQ64z9knixEnGYnOrtVZlmCBDpyb3fTnKHe8MvfSuECUhxwQ2
	 w2GJvtlXeq7MG0/X1T+3gQe4KPOD70Psyn46TFwBQ3DCLydpMF0T51F30tWcTbY5YrW838PwczvM
	 +LdVMt7vhmaZozgF1vTq4eRsddbXRXnTeabPEvW2dCt0ouiVeryC4DsmR6ecSwi2tlfMHWDV8V4P
	 0/GRbOyDXssJVK4BllhzG4T68GCw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3 6/7] riscv: dts: add initial canmv-k230 and k230-evb
 dts
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <7A86D933-B85F-4B29-8D6D-AB414A42AC06@cyyself.name>
Date: Wed, 6 Mar 2024 00:37:16 +0800
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>,
 dlemoal@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 guoren@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <E4987AF4-D5F6-416E-A1CC-DD58BA9134BD@cyyself.name>
References: <mhng-f1aa91d4-211f-4eb4-a94d-a9d88b0d3f6a@palmer-ri-x1c9>
 <7A86D933-B85F-4B29-8D6D-AB414A42AC06@cyyself.name>
To: =?utf-8?B?6ZmI5rOx5a6H?= <cyy@cyyself.name>
X-Mailer: Apple Mail (2.3774.400.31)


> On Mar 6, 2024, at 00:22, Yangyu Chen <cyy@cyyself.name> wrote:
>=20
>>=20
>> On Mar 5, 2024, at 23:54, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>=20
>> On Mon, 04 Mar 2024 13:06:00 PST (-0800), cyy@cyyself.name wrote:
>>> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan =
Kendryte
>>> K230 SoC [1].
>>>=20
>>> Some key consideration:
>>> - Only place BigCore which is 1.6GHz RV64GCBV
>>>=20
>>> The existence of cache coherence between the two cores remains =
unknown
>>> since they have dedicated L2 caches. And the factory SDK uses it for
>>> other OS by default. I don't know whether the two CPUs on K230 SoC
>>> can be used in one system. So only place BigCore here.
>>>=20
>>> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
>>> CPU1, the csr.mhartid of this core is 0.
>>>=20
>>> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
>>>=20
>>> The user manual of C908 from T-Head does not document it =
specifically.
>>> It just said it supports B extension V1.0-rc1. [2]
>>=20
>> I'm seeing
>>=20
>>  3.1.6 Vector instruction set (RVV)
>>  For more information, see RISC-V =E2=80=9CV=E2=80=9DVector =
Extension, Version    1.0-rc1-20210608
>>  =
URL=EF=BC=9Ahttps://github.com/riscv/riscv-v-spec/releases/download/v1.0-r=
c1/riscv-v-spec-1.0-rc1.pdf
>>=20
>>  3.1.7 Bit operation instruction set (RV64B)
>>  For more information, see =EF=BC=9ARISC-V Bit-Manipulation =
ISA-extensions,    Version 1.0.0, 2021-06-12: public review
>>  =
URL=EF=BC=9Ahttps://github.com/riscv/riscv-bitmanip/releases/download/1.0.=
0/bitmanip-1.0.0.pdf
>>=20
>> so I think maybe that's vector 1.0-rc1 and the final bitmanip?
>>=20
>=20
> Yeah. I just want to say what subset of the B extension is supported =
by
> C908.
>=20

Oh. I misunderstand it. The version of bitmanip is 1.0 rather than =
1.0-rc1
I said before. The version of the vector is 1.0-rc1. I will change that =
in
the next revision.

>>> I have tested it by using this [3] which attempts to execute =
"add.uw",
>>> "andn", "clmulr", "bclr" and they doesn't traps on K230. But on =
JH7110,
>>> "clmulr" and "bclr" will trap.
>>>=20
>>> - Support for "zicbom" is tested by hand
>>>=20
>>> Have tested with some out-of-tree drivers from [4] that need DMA and =
they
>>> do not come to the dts currently.
>>>=20
>>> - Cache parameters are inferred from T-Head docs [2] and Canaan docs =
[1]
>>>=20
>>> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
>>> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
>>> L2: 256KB, PIPT 16-way set-associative, 64B Cacheline
>>>=20
>>> The numbers of cache sets are calculated from these parameters.
>>>=20
>>> - MMU only supports Sv39
>>>=20
>>> Since T-Head docs [2] say C908 should support Sv48. However, it will =
fail
>>> during the kernel probe when running Linux on K230. I also tested it =
by
>>> hand on M-Mode software, writing Sv48 to satp.mode will not trap but =
will
>>> leave the csr unchanged. While writing Sv39 it will take effect. It =
shows
>>> that this CPU does not support Sv48.
>>=20
>> I think that only works due to a bug in our sv48 probing routines -- =
unless I'm missing something, we mixed up the sv57 and sv48 probing and =
if sv57 fails to probe then we disable sv48 as well.  So I think we =
probably need some cleanup in there.
>>=20
>=20
> However, the sv48 probing routines work on some other chips with sv48. =
At
> least I have tested mainline kernel v6.8-rc2. And the attempt to write =
sv48
> to satp by hand tells me it does not support sv48. I think it might be
> configurable from CPU RTL, and the K230 taped out with no sv48 =
support.
>=20
>>> - Svpbmt and T-Head MAEE both supported
>>>=20
>>> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based =
memory
>>> attributes and is controlled by csr.mxstatus. If the kernel wants to =
use
>>> svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to =
zero
>>> before entering the s-mode kernel. Otherwise, the kernel will not =
boot as 0
>>> on T-Head MAEE represent to NonCachable Memory and it will lose =
dirty cache
>>> lines modification that haven't been written back to the memory.
>>=20
>> So I guess we need the bootloader to just be accurate here?  ie: =
whatever extension it tells S-mode kernels is enabled is how S-mode =
behaves, and then this should just work itself out.
>>=20
>=20
> Yes. Currently, I have patched OpenSBI to disable MAEE. Conor Dooley =
said
> from a public irc group that he wants to control the enable of T-Head
> variation of zicbom and svpbmt from dts, in addition to mimplid or
> something now. I think that will be a better way for the bootloader to =
tell
> the kernel whether the T-Head MAEE should be enabled.
>=20
> Link: =
https://github.com/cyyself/opensbi/commit/b113c1c01d700314a4a696297ec09031=
a9399354
>=20
> Furthermore, I wonder whether a CPU node like this would be =
acceptable.
> I don't have any other details of how another CPU from K230 SoC works =
on
> Linux.
>=20
>>> [1] =
https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datashe=
et.html#chapter-1-introduction
>>> [2] =
https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369=
347/XuanTie-C908-UserManual.pdf
>>> [3] https://github.com/cyyself/rvb_test
>>> [4] https://github.com/cyyself/linux/tree/k230-mainline
>>>=20
>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>> ---
>>> arch/riscv/boot/dts/canaan/Makefile       |   2 +
>>> arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
>>> arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
>>> arch/riscv/boot/dts/canaan/k230.dtsi      | 140 =
++++++++++++++++++++++
>>> 4 files changed, 190 insertions(+)
>>> create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
>>> create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>>> create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
>>>=20
>>> diff --git a/arch/riscv/boot/dts/canaan/Makefile =
b/arch/riscv/boot/dts/canaan/Makefile
>>> index 987d1f0c41f0..7d54ea5c6f3d 100644
>>> --- a/arch/riscv/boot/dts/canaan/Makefile
>>> +++ b/arch/riscv/boot/dts/canaan/Makefile
>>> @@ -1,6 +1,8 @@
>>> # SPDX-License-Identifier: GPL-2.0
>>> dtb-$(CONFIG_ARCH_CANAAN) +=3D canaan_kd233.dtb
>>> dtb-$(CONFIG_ARCH_CANAAN) +=3D k210_generic.dtb
>>> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-canmv.dtb
>>> +dtb-$(CONFIG_ARCH_CANAAN) +=3D k230-evb.dtb
>>> dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
>>> dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
>>> dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
>>> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts =
b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>>> new file mode 100644
>>> index 000000000000..3ab5c8de11a8
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>>> @@ -0,0 +1,24 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>>> + */
>>> +
>>> +#include "k230.dtsi"
>>> +
>>> +/ {
>>> + model =3D "Canaan CanMV-K230";
>>> + compatible =3D "canaan,canmv-k230", "canaan,kendryte-k230";
>>> +
>>> + chosen {
>>> + stdout-path =3D "serial0:115200n8";
>>> + };
>>> +
>>> + ddr: memory@0 {
>>> + device_type =3D "memory";
>>> + reg =3D <0x0 0x0 0x0 0x1fdff000>;
>>> + };
>>> +};
>>> +
>>> +&uart0 {
>>> + status =3D "okay";
>>> +};
>>> diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts =
b/arch/riscv/boot/dts/canaan/k230-evb.dts
>>> new file mode 100644
>>> index 000000000000..42720113c566
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
>>> @@ -0,0 +1,24 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>>> + */
>>> +
>>> +#include "k230.dtsi"
>>> +
>>> +/ {
>>> + model =3D "Kendryte K230 EVB";
>>> + compatible =3D "canaan,k230-usip-lp3-evb", "canaan,kendryte-k230";
>>> +
>>> + chosen {
>>> + stdout-path =3D "serial0:115200n8";
>>> + };
>>> +
>>> + ddr: memory@0 {
>>> + device_type =3D "memory";
>>> + reg =3D <0x0 0x0 0x0 0x1fdff000>;
>>> + };
>>> +};
>>> +
>>> +&uart0 {
>>> + status =3D "okay";
>>> +};
>>> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi =
b/arch/riscv/boot/dts/canaan/k230.dtsi
>>> new file mode 100644
>>> index 000000000000..0bcff67b78a8
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/canaan/k230.dtsi
>>> @@ -0,0 +1,140 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +/dts-v1/;
>>> +/ {
>>> + #address-cells =3D <2>;
>>> + #size-cells =3D <2>;
>>> + compatible =3D "canaan,kendryte-k230";
>>> +
>>> + aliases {
>>> + serial0 =3D &uart0;
>>> + };
>>> +
>>> + cpus {
>>> + #address-cells =3D <1>;
>>> + #size-cells =3D <0>;
>>> + timebase-frequency =3D <27000000>;
>>> +
>>> + cpu@0 {
>>> + compatible =3D "thead,c908", "riscv";
>>> + device_type =3D "cpu";
>>> + reg =3D <0>;
>>> + riscv,isa =3D "rv64imafdcv_zba_zbb_zbc_zbs_zicbom_svpbmt";
>>> + riscv,isa-base =3D "rv64i";
>>> + riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zba", =
"zbb",
>>> +        "zbc", "zbs", "zicbom", "zicntr", "zicsr",
>>> +        "zifencei", "zihpm", "svpbmt";
>>> + riscv,cbom-block-size =3D <64>;
>>> + d-cache-block-size =3D <64>;
>>> + d-cache-sets =3D <128>;
>>> + d-cache-size =3D <32768>;
>>> + i-cache-block-size =3D <64>;
>>> + i-cache-sets =3D <128>;
>>> + i-cache-size =3D <32768>;
>>> + next-level-cache =3D <&l2_cache>;
>>> + mmu-type =3D "riscv,sv39";
>>> +
>>> + cpu0_intc: interrupt-controller {
>>> + compatible =3D "riscv,cpu-intc";
>>> + interrupt-controller;
>>> + #interrupt-cells =3D <1>;
>>> + };
>>> + };
>>> +
>>> + l2_cache: l2-cache {
>>> + compatible =3D "cache";
>>> + cache-block-size =3D <64>;
>>> + cache-level =3D <2>;
>>> + cache-size =3D <262144>;
>>> + cache-sets =3D <256>;
>>> + cache-unified;
>>> + };
>>> + };
>>> +
>>> + apb_clk: apb-clk-clock {
>>> + compatible =3D "fixed-clock";
>>> + clock-frequency =3D <50000000>;
>>> + clock-output-names =3D "apb_clk";
>>> + #clock-cells =3D <0>;
>>> + };
>>> +
>>> + soc {
>>> + compatible =3D "simple-bus";
>>> + interrupt-parent =3D <&plic>;
>>> + #address-cells =3D <2>;
>>> + #size-cells =3D <2>;
>>> + dma-noncoherent;
>>> + ranges;
>>> +
>>> + plic: interrupt-controller@f00000000 {
>>> + compatible =3D "canaan,k230-plic" ,"thead,c900-plic";
>>> + reg =3D <0xf 0x00000000 0x0 0x04000000>;
>>> + interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
>>> + interrupt-controller;
>>> + #address-cells =3D <0>;
>>> + #interrupt-cells =3D <2>;
>>> + riscv,ndev =3D <208>;
>>> + };
>>> +
>>> + clint: timer@f04000000 {
>>> + compatible =3D "canaan,k230-clint", "thead,c900-clint";
>>> + reg =3D <0xf 0x04000000 0x0 0x04000000>;
>>> + interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
>>> + };
>>> +
>>> + uart0: serial@91400000 {
>>> + compatible =3D "snps,dw-apb-uart";
>>> + reg =3D <0x0 0x91400000 0x0 0x1000>;
>>> + clocks =3D <&apb_clk>;
>>> + interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>;
>>> + reg-io-width =3D <4>;
>>> + reg-shift =3D <2>;
>>> + status =3D "disabled";
>>> + };
>>> +
>>> + uart1: serial@91401000 {
>>> + compatible =3D "snps,dw-apb-uart";
>>> + reg =3D <0x0 0x91401000 0x0 0x1000>;
>>> + clocks =3D <&apb_clk>;
>>> + interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
>>> + reg-io-width =3D <4>;
>>> + reg-shift =3D <2>;
>>> + status =3D "disabled";
>>> + };
>>> +
>>> + uart2: serial@91402000 {
>>> + compatible =3D "snps,dw-apb-uart";
>>> + reg =3D <0x0 0x91402000 0x0 0x1000>;
>>> + clocks =3D <&apb_clk>;
>>> + interrupts =3D <18 IRQ_TYPE_LEVEL_HIGH>;
>>> + reg-io-width =3D <4>;
>>> + reg-shift =3D <2>;
>>> + status =3D "disabled";
>>> + };
>>> +
>>> + uart3: serial@91403000 {
>>> + compatible =3D "snps,dw-apb-uart";
>>> + reg =3D <0x0 0x91403000 0x0 0x1000>;
>>> + clocks =3D <&apb_clk>;
>>> + interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH>;
>>> + reg-io-width =3D <4>;
>>> + reg-shift =3D <2>;
>>> + status =3D "disabled";
>>> + };
>>> +
>>> + uart4: serial@91404000 {
>>> + compatible =3D "snps,dw-apb-uart";
>>> + reg =3D <0x0 0x91404000 0x0 0x1000>;
>>> + clocks =3D <&apb_clk>;
>>> + interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH>;
>>> + reg-io-width =3D <4>;
>>> + reg-shift =3D <2>;
>>> + status =3D "disabled";
>>> + };
>>> + };
>>> +};



