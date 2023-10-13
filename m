Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9B7C8279
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjJMJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJMJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:50:44 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2033.outbound.protection.outlook.com [40.92.45.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336FBF;
        Fri, 13 Oct 2023 02:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC67QQxBVxhNcQ9JkTiiguqFirVM7nQrfq/Hgg0d9213+rb1An72VNWzubkwgvNsKpRGCBhy1L+TqtVYRcnzynVu93ui/ejZgeSIWjzQ+HUIxUkCfS29O0HC0v3yIySfM1xCqH/dBwLUQqjAN00qTX/BB4pfisMTtxTemmo3p6EHLmmhjolyb9rmmr7sIUPd2VW1g0Zs24muMbEcpPWNdXWnn8zZz/pjM+THYh2eFaAO34uWYyALKAQCPqxPxbo9CIYZN9o+pMvP2JUP2eXmAqCzPGnVSOuvCumWFr7fhv5tCGmcMG+DUjmt0sSdChqau9Q8QrruEud93HD6eq6gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzJgfP9hUj9DpduC+NUFd068C/1o21fRhl69xFfbeD0=;
 b=A+6SaZo8gnOvvsqTmu45M9nuf+KpS/19/h7xw/wEg/yNdJccQG6z3gMsRmO9EJLVm+zEqS+oOT7/SVVCcR0Jj1TUIpmnyAZNoa+rFO593zBxQotALtz4ulUJ9mUCMwVBKPTRL41W9aG1MMNmBynCCnwsqRTEhMlh84C2Q/YO0L7Vzs45t+r5AG821WwTuR29TSx1PtebVHgFbdMxYxWWuMBlOY15r5vqJTnVdkPEGnrsMx1bDJDThKROuc6HDXoV6MeZqWNkL9xXtcY9pNyxli3+d4LD6ZE5e1O3WFU4i2WaifnTr28XSYbnoCTa8uHHzGy0vcWW5jAYTScSX5+ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzJgfP9hUj9DpduC+NUFd068C/1o21fRhl69xFfbeD0=;
 b=vQ0rTrMGF7IorOvxZlugsSRaXigsgXduNGpeK6CFclmYsmY5qTNcGNwdLd87fF/xQKS7Y1P1RGJF2B9sIX+dKJq+jMYjBlaOERAguP61Jp/NVp0Y6JUJQirxd8trI+5z47uNf9iXAkKE4+8zff6wdH7o4o9TbFNE+bLiJjeuR7kQAKAvuW3cIFJeYRnnXmsKncV28H6UfDPAOhNUFRoWrvp9TvlhQ5K1c0sHN+MkY+jhJ96uRh7rfaTX2qxo8OsKHa18cKnCKX8z5mQRbL5RCLPBcxXlXQts+9pY3mYkwz6dS05DMEq26PVmx/5wguVIhAr4C+l+hcBGVG3GTv0ZmA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CO6PR20MB3681.namprd20.prod.outlook.com (2603:10b6:5:344::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 09:50:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:50:37 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor+dt@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
Date:   Fri, 13 Oct 2023 17:50:49 +0800
Message-ID: <IA1PR20MB4953DCEB2CD26CAA4E5C039EBBD2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013-catchable-wince-f24060feb639@spud>
References: <20231013-catchable-wince-f24060feb639@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ORdOs4sPXoJDsStO0puoVEpyWvAM72IAOLxXyhWdvjQ=]
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231013095050.152777-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CO6PR20MB3681:EE_
X-MS-Office365-Filtering-Correlation-Id: 218a5be4-edf0-48b5-2fba-08dbcbd1d9e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjTtRWfjY9okKadB+ZQT/GC7xEUaBgxxWAGTVbM4JzT9+Vf3zxoLBNYfGqe5EEvLpdoQNWd2K1aBHJOdZfi+4TQfQRNMIONU4BZNr0hQqRvjeeAkEGB5GnDitM8uf/rcVjU9/z/v1pgwbUvnZZeQa/TxqlByeFfgoJz/xZtLqPCgytSy18AJEcWeqp/A0CFNw1rUyBoZ8M4DkRbSwk3tkOqAQVQOv8UgX/lm7BwCQu2YLihTdEWkO/Vh4vYkx+GRhDWHlCRBp7KkZ3b29kw/nc787cuJkInEMKtfqgaXWuh7Y+HcdML3aFxQPvW3nnZ1Lbr3o4hgHNhjKjL5AOujovORRRqtl47oktWm8/LftQ/URoMXwAG2Q9p6WLAU3GwzStPL9h53a/Mu2avyEyKRV0/iAXntzo6TcDZyrd4KF8ocpSwZpkPjsj1aBlOkWNPzNgeLHtAvPU0UKrarLhFVfmKCj2HewYjudGbXuzqHYS0LuYQdz6+yuLk/h5LsTeSPlxsgMiwQo1fv96WMYrKW4vdkHvvm+Mn+UQGiUOJitOBWYxQMRZLQ/FSsy1tdrfQDjqhbkk+bBfp8+Yf98fRD3cqgcd/tXRivDNrGuZi8HaFzdPNLtavCGi0/EjkB1SOz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JvdmP3295sQbtCju5jg7w1M6fDT5dRANBpseTDRdXVBIi4vioN5hiGlUiAxN?=
 =?us-ascii?Q?SOC/m9G0iD8lLc+vWDKiNLWilVaQtjkYDSVKzpnW4FYIL4W/Ph9aCflfr5m2?=
 =?us-ascii?Q?mkP8EbxG0Aeq3i6kqJwyN46nrDW5tT2L/X80WxB7ZyPkGY06a5xtxDp0xtwL?=
 =?us-ascii?Q?uyttjFAtwUjga7E9k6nOehScREbO5ErAyNG6HWFlc8YYmoo6NufSU3Q5pUa2?=
 =?us-ascii?Q?aV+sVL6nBNd9sw9lJ0g4PSH6rbb2kQygIdLWTso5wvluW5midq+Z/4VsiIrk?=
 =?us-ascii?Q?nGDX3Z6k3L9qoyocKj3VgQZ72IZ6U+VGQ7yASfGcXYD4Zz7443smZm+iYzCc?=
 =?us-ascii?Q?EAKhe7dLLbkL0aRpddZMrOG7rMhxa2a6FG1vz9n3hf1qPwzgegBFQsDo8j0/?=
 =?us-ascii?Q?O+1A2KLqcWpoIdf0ld+FWoDQFlhI+dkNiz/ujkDe45sH4WONIcpf1d1f2rPi?=
 =?us-ascii?Q?+tsZ7oV/DSh/UDVgc8U3VvswLoloTfgbL5SsX+hn7+KAlyQ1EDh/iMQ7r29/?=
 =?us-ascii?Q?QNXpatyfEovOxcxUYuJGWlmHHG2sujQRFfBw723EgjZ6mTASUZNFqRfW9Mjm?=
 =?us-ascii?Q?wZOjtsJsocV8K124KLJMSHTvWXfu4SObDNjj+5TwZ3MtH4bZi7tZ4x9BR1L4?=
 =?us-ascii?Q?H7li+nucl5n65rJA7kUNtbGFTlMymqUfnilGPkYJwoyoStGX5DZauvAwL5f9?=
 =?us-ascii?Q?ugMRWbsjmgoqM1jAvb03hrFt44W+M3vz1BUfC1CSUVAjXFW/ppztxpYsIBuD?=
 =?us-ascii?Q?64lzzmeDYKFTlN8+vARRDEc439894Y62C6QZWq+wJ9xjY8iiR551AcqjguDi?=
 =?us-ascii?Q?6pKcWqavQX5p9kow5ImGHw4ckkxGyyHdYxXM8bcUCOz2d+fEXwo4AloTMfnO?=
 =?us-ascii?Q?Ky1Pl9qQ4OtfA04uoO+prlKfGnhQ1yu9DKwUBhkYzY1Ho2f2t3yr1eEAZZ5q?=
 =?us-ascii?Q?+mgVBHMiE/yarLrr2SkWjCuFpgFLngeByMJ7v8ecKrrWl4g4StNheX1LzY1x?=
 =?us-ascii?Q?2ZzR98TUA9I6Zr09bRcWeC/HFjrusqh3DRPnWdaaggZJWUwmBEeuL2mn9jDR?=
 =?us-ascii?Q?t9srNkemeNt1b6ojM6O3aFM/xNXQ4bcheMDi2wZ931Dp8/fv4s/8sfA045Be?=
 =?us-ascii?Q?0+eYGHJiYMivTIKvwfNgLcm1o+5e684CFvIYBu/8//Htm27BwM1aG0HbgC3i?=
 =?us-ascii?Q?8hedteQzDU3WETCW1hHBnLqeGNV7yl+XQHY9EsHYGFuc2g7q/mKtTBOifdI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218a5be4-edf0-48b5-2fba-08dbcbd1d9e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:50:37.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR20MB3681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Yo,
>
>On Mon, Oct 09, 2023 at 07:26:35PM +0800, Inochi Amaoto wrote:
>> Move the cpu and the common peripherals of CV181x and CV180x to new file.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 95 +------------------
>>  .../dts/sophgo/{cv1800b.dtsi => cv180x.dtsi}  | 19 +---
>>  2 files changed, 2 insertions(+), 112 deletions(-)
>>  copy arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv180x.dtsi} (80%)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> index df40e87ee063..0904154f9829 100644
>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> @@ -3,106 +3,13 @@
>>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>>   */
>>
>> -#include <dt-bindings/interrupt-controller/irq.h>
>> +#include "cv180x.dtsi"
>>
>>  / {
>>  	compatible = "sophgo,cv1800b";
>> -	#address-cells = <1>;
>> -	#size-cells = <1>;
>> -
>> -	cpus: cpus {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -		timebase-frequency = <25000000>;
>> -
>> -		cpu0: cpu@0 {
>> -			compatible = "thead,c906", "riscv";
>> -			device_type = "cpu";
>> -			reg = <0>;
>> -			d-cache-block-size = <64>;
>> -			d-cache-sets = <512>;
>> -			d-cache-size = <65536>;
>> -			i-cache-block-size = <64>;
>> -			i-cache-sets = <128>;
>> -			i-cache-size = <32768>;
>> -			mmu-type = "riscv,sv39";
>> -			riscv,isa = "rv64imafdc";
>> -			riscv,isa-base = "rv64i";
>> -			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
>> -					       "zifencei", "zihpm";
>> -
>> -			cpu0_intc: interrupt-controller {
>> -				compatible = "riscv,cpu-intc";
>> -				interrupt-controller;
>> -				#address-cells = <0>;
>> -				#interrupt-cells = <1>;
>> -			};
>> -		};
>> -	};
>> -
>> -	osc: oscillator {
>> -		compatible = "fixed-clock";
>> -		clock-output-names = "osc_25m";
>> -		#clock-cells = <0>;
>> -	};
>>
>>  	soc {
>> -		compatible = "simple-bus";
>>  		interrupt-parent = <&plic>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		dma-noncoherent;
>> -		ranges;
>> -
>> -		uart0: serial@4140000 {
>> -			compatible = "snps,dw-apb-uart";
>> -			reg = <0x04140000 0x100>;
>> -			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&osc>;
>> -			reg-shift = <2>;
>> -			reg-io-width = <4>;
>> -			status = "disabled";
>> -		};
>> -
>> -		uart1: serial@4150000 {
>> -			compatible = "snps,dw-apb-uart";
>> -			reg = <0x04150000 0x100>;
>> -			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&osc>;
>> -			reg-shift = <2>;
>> -			reg-io-width = <4>;
>> -			status = "disabled";
>> -		};
>> -
>> -		uart2: serial@4160000 {
>> -			compatible = "snps,dw-apb-uart";
>> -			reg = <0x04160000 0x100>;
>> -			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&osc>;
>> -			reg-shift = <2>;
>> -			reg-io-width = <4>;
>> -			status = "disabled";
>> -		};
>> -
>> -		uart3: serial@4170000 {
>> -			compatible = "snps,dw-apb-uart";
>> -			reg = <0x04170000 0x100>;
>> -			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&osc>;
>> -			reg-shift = <2>;
>> -			reg-io-width = <4>;
>> -			status = "disabled";
>> -		};
>> -
>> -		uart4: serial@41c0000 {
>> -			compatible = "snps,dw-apb-uart";
>> -			reg = <0x041c0000 0x100>;
>> -			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&osc>;
>> -			reg-shift = <2>;
>> -			reg-io-width = <4>;
>> -			status = "disabled";
>> -		};
>>
>>  		plic: interrupt-controller@70000000 {
>>  			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
>> similarity index 80%
>> copy from arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> copy to arch/riscv/boot/dts/sophgo/cv180x.dtsi
>> index df40e87ee063..ffaf51724c98 100644
>
>Firstly, this form of diff really threw me, I was quite confused for a
>few minutes. A copy plus a pair of diffs doesn't really make much sense,
>when the operation being carried is an extraction of some nodes to a
>different file.
>

I was told to use -C/-M/-B to generate patch, and the git format-patch
give me this wired output if I use -C, using -M seems no change from v1.
The -B output is also disappointing. Maybe I need to generate agaion?

The v1 version:
https://lore.kernel.org/linux-riscv/IA1PR20MB495360B632D106BBB833D82ABBCFA@IA1PR20MB4953.namprd20.prod.outlook.com/

>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
>> @@ -1,12 +1,12 @@
>>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>  /*
>>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>
>Also, is moving around some bits of hw description really a
>copyrightable change?
>

It seems to be a mistake when I splitting the patch from v1.
This copyright should in the next patch.

>>   */
>>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>
>>  / {
>> -	compatible = "sophgo,cv1800b";
>>  	#address-cells = <1>;
>>  	#size-cells = <1>;
>>
>> @@ -48,7 +48,6 @@ osc: oscillator {
>>
>>  	soc {
>>  		compatible = "simple-bus";
>> -		interrupt-parent = <&plic>;
>>  		#address-cells = <1>;
>>  		#size-cells = <1>;
>>  		dma-noncoherent;
>> @@ -103,21 +102,5 @@ uart4: serial@41c0000 {
>>  			reg-io-width = <4>;
>>  			status = "disabled";
>>  		};
>> -
>> -		plic: interrupt-controller@70000000 {
>> -			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>> -			reg = <0x70000000 0x4000000>;
>> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
>> -			interrupt-controller;
>> -			#address-cells = <0>;
>> -			#interrupt-cells = <2>;
>> -			riscv,ndev = <101>;
>> -		};
>> -
>> -		clint: timer@74000000 {
>> -			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
>> -			reg = <0x74000000 0x10000>;
>> -			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>> -		};
>>  	};
>>  };
>
>What I wanted to comment on was this though - it seems that both the
>cv1800b and the cv1812h have identical plic and clint nodes, other than
>their compatibles? If that is the case, why create a cv1800b and a
>cv1812h specific file containing entirely new nodes, when overriding the
>compatible would be sufficient? Doubly so if the other SoCs in the
>cv18xx series are going to have identical layouts.
>
>I gave it a quick test locally with the below diff applied on top of
>this series - although I didn't make sure that I didn't re-order the
>plic & clint nodes, I just wanted to demonstrate what I had done.
>

Thanks for demonstration. AFAIK, what you said is true. the most devices
of CV180x and CV181x are the same, including plic and clint. The reason I
used a new one is to identify these two devices without making the
compatible string confusing.
Should I change the binding name of plic and clint to "sophgo,cv1800-xxx"
to mark there are the same series? I think this can avoid this confusing
dt nodes.

>Cheers,
>Conor.
>
