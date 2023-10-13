Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48587C9053
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJMWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:36:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2055.outbound.protection.outlook.com [40.92.40.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A030ABB;
        Fri, 13 Oct 2023 15:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+++bzcpLf2klKCZ7Q1t1AQ5+7KNe1ag665hp6eTaMx6OIZfdWXn8FHhzbRHXB4UzP9vby2QWO6MqAUdSeT31y1/HCsAqCJGFOjQca+B8enivQnWfNX/tibzwS//LcdAUsr6jI5IVb3xxLuBaKF/asgdRE4f1wYVymMJiLQsSsO/Q16rnTPiZLcR67GCIfFHpXb73vnI8XUErfZRT/A1GWuojhXDi22pI8a/ceaTlVbr/62k8l3+pemzbOYW9hZxVRopo2bs3Mf0yefdBdC/xo28PKcvmbupWfohDeo9ScK9cCjeCuXyPL+s74cXliKC4VmR8SrhJ4xv3poirOsIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn3zHTruDS1wJ5dqLfyn7yU1ZBrR8yaLg0RKs/PHMm8=;
 b=WhWeXVhOYvTUAeSvyj1FoZN6zF1cIWxJ+mB4vNQsXtaOlCFCFNSUO5V7ytEHvZeM7nXPal3hKieB1CRcHL/Pudri2iE0gOVhDBIqZ+b1m+PvGGU2nsnexzUOP4qn79G/NXN8cIu7AHRnmeQKlI9876TxHiH23uGb4kP6+uvB/LH8dt9cLwFAQLQ4qNBF+0A+j5s6q2d2YpRcJIlYCdyGTOz+1K/BXmhYgwKQInR9kxLffooAj0865QZwwa6GYZdEBjvu/m6BHC7qjcrLKsA7pWIaARRmYrQtFU8ktcd9oV84Caj1JbloFzOAsFZ5AoWh2iKGJwLOsq0fb53l1I5LTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn3zHTruDS1wJ5dqLfyn7yU1ZBrR8yaLg0RKs/PHMm8=;
 b=fBUJa7C3pEZjaJjUKbYqB/EV6ahvT1GXm7mTPyuw/LG9Bs/8f7ivwxH7OMW6AToCswk1DSuYtkzSakzyh/DA50e7PrNWlchIITIlWAEro1XkE0VgEDxhEul2vgqP/c0A6wnAwDbnTmrxxholgEyGuclRqQb/WlPTAcgzhssqHZbpApoGThhEvi7G5WX2LjHdephk9hLyXWrP44BEHLbAbmZ1aNDVr0C2GXoNJsmR68Hy0Lwd05PZeRo5noN5AkmiOfpAldG8s6oGeDbbs+C+OOuUG+bqFrp7/uor2FCchf15A2MqTQtiY1jeDgNFy0oHL1NS0FPlka48NcKoA/lbSg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4498.namprd20.prod.outlook.com (2603:10b6:303:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:36:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 22:36:19 +0000
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
Subject: Re: [PATCH v2 4/7] riscv: dts: sophgo: Separate common devices from cv1800b soc
Date:   Sat, 14 Oct 2023 06:36:12 +0800
Message-ID: <IA1PR20MB49532A5D8726768C3121FDC1BBD2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013-tibia-anteater-d96425e1d912@spud>
References: <20231013-tibia-anteater-d96425e1d912@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+87nfDHvTvVlggiG+52srXhQnSldV7Pfdu/nhrx9V1Q=]
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231013223613.6204-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 0228edb0-4ac0-4d38-d9bc-08dbcc3cd190
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WkUiF17asj78Y+2yS2Jo4hdnyozXK832OGQap4ZK2bc440HeJ6crlrDMu9/SsClE1FcCMJkI33SQvtvwwxENP2YJuk/jS3FkGk5BeMXvviRlFVzLTY+5RIJnoubjlnKrM+9EXKxZoo89/41vBOVS0dg7e1St3fcYt+6MxV/pIhyE4ojQgZplQ2IoUWdEPdVxBHb3O6iIosWO5b41106P27zzIuDKnQzo5DtIB66OF0Kol2KKkjKSnPl6B+Wb3nIUWfgX7NomgjcQGVa/FRDRrOcQgUHmWxW9y6FiYRf7K0AoqG84y8YUl2EnWw4njISf7H6ohvNtq0XAYXF7s7ppNyCQlNyV2TcSCFmG/p9QiM+51VtAvMV2wYqmd4wBlAP7BKgHIZYpFEDDLfUAiDPwHpQzeSxRTHg0ZzLrjae5TE5GDgFJ5+Zj+ktL8VUqPEa7klirQqAP4r150BJnce+ngCiarCbJ7Bo/Ekn0AdJeKm2G/IlNcy0k58pbp8S5LBWMTbwcShbFmkSMZgXke8ct2KkMvWgFtYvgyrQymfSK042vvA3DbYH15P7rBI5xMjZABytDU6GDrPXUHJYbfi37KJsiQWSxGrTAAHHtCbA8GHMj8youmQS9XAG53F1gJ2w
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKeQEV9dff9qa6wwK5h/OEQOekeH0T0vbL8TshToM4yfl7cbXu4P6wIfAOCf?=
 =?us-ascii?Q?bD2+LoaDFQ7bZE2NBVi7DjRjxjiFe3dImqpaNW+5/RRzeIEfi3naQvsTKdKB?=
 =?us-ascii?Q?RVJ79S70A7Ni4kRYS/CP9jfUcMrMZOACTFAXTSieLvKJRoOyNUt7xzvvHHOE?=
 =?us-ascii?Q?qco9XIB3651vtZCPP72eTRcTN3l74+fLL62V1olY6VwjgCYd8CJTZ9PD54ps?=
 =?us-ascii?Q?eGVdxHBPB6fXhqtg4Ao7brd16fRT+3qILdvvouA7H/bRPVQAisopIQsAEM4O?=
 =?us-ascii?Q?BSf6nxfsf8OlQlZtkDHFFwQBH1ZRK/rUDoHGpewUdC7x6ByEMfKUe/hHkoOX?=
 =?us-ascii?Q?GeCtoi0RbVPQTAzIb+PeQiIdoa0bcfTLL/1JTONZ9KUYirpeZ8Ea6e+Xi3V+?=
 =?us-ascii?Q?fmHmwuxgsdofaicAqv5CDJg8hkmgSts3Gh+gkBAMfveHwbjcIN6ejROtaPfW?=
 =?us-ascii?Q?7zAazkb7ux5Y0QJlnS1k+8FsL6IYeP46E7LaR9LRxhz38zwr0qfj3kI0Y0tq?=
 =?us-ascii?Q?pouO1/yY7+syEgMRPdeXKMc33fIIpRqcsg6v+TzsQ0S/kv8Wgx7+0i/eUWdj?=
 =?us-ascii?Q?xHjVKkE2hGqM+a/nuAbtU1A2Q++HBYPhfnoKh15lhkeZBUgYmxExsxaXL7YG?=
 =?us-ascii?Q?PqXYlPwYtW7ytX/c3gRO2/BiHikCPpVLMZt/HCAbyu++PtOlxXzlH0Ip1CBy?=
 =?us-ascii?Q?n6lBgimJ740TvV0kczY746YaN5vNE701GNymwwSl2Raezg6F7DbscczUucsZ?=
 =?us-ascii?Q?zFjd8tdhJRpPO0VvEIzbJx3NLfUMfsWsutZeE8V+fCAgDoVOIiYmWF1imWgx?=
 =?us-ascii?Q?T9CyJioMJh5siY4j90j6DmuX7D2GFkNPw6qb3l6yyWcV93jzpvsAjADTnopb?=
 =?us-ascii?Q?biC99noVMHu88eTQh1mIRsP3s8xXVExvXRAbKzY3187zLrSnlQmjxYn5qOR1?=
 =?us-ascii?Q?z7rksACd3pTST4tK2uv7epl3eeAeVmdGBYiCm+RhIDrcA2L7AG5Vfe+Zb6j2?=
 =?us-ascii?Q?JlFlDXQD3m/6TnmGz/+AFIGjHZZaWxjrb2kQMSxQw7B6wWURi4cJTX9dDMqy?=
 =?us-ascii?Q?5/YSIGLq0v4Cux2y1/2Dyt28E2yZeaVQhTasxTLiAgEmZEECDT9rOr473G27?=
 =?us-ascii?Q?mhHhPAFAxlIBEHaEpu6xtHKW98qtk3qSt5BOmRpNwSVGXnuc+0Anafs9Bz00?=
 =?us-ascii?Q?qJ80Elibloo6JEwXEDeBb2oP8UeEovVG8o3zZDZFRBqhIWgCEoYRlMxplws?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0228edb0-4ac0-4d38-d9bc-08dbcc3cd190
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:36:19.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Fri, Oct 13, 2023 at 05:52:03PM +0800, Inochi Amaoto wrote:
>> Sorry for the wrong title.
>>
>>> Yo,
>>>
>>> On Mon, Oct 09, 2023 at 07:26:35PM +0800, Inochi Amaoto wrote:
>>>> Move the cpu and the common peripherals of CV181x and CV180x to new file.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> ---
>>>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 95 +------------------
>>>>  .../dts/sophgo/{cv1800b.dtsi => cv180x.dtsi}  | 19 +---
>>>>  2 files changed, 2 insertions(+), 112 deletions(-)
>>>>  copy arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv180x.dtsi} (80%)
>>>>
>>>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>>> index df40e87ee063..0904154f9829 100644
>>>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>>> @@ -3,106 +3,13 @@
>>>>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>>>>   */
>>>>
>>>> -#include <dt-bindings/interrupt-controller/irq.h>
>>>> +#include "cv180x.dtsi"
>>>>
>>>>  / {
>>>>  	compatible = "sophgo,cv1800b";
>>>> -	#address-cells = <1>;
>>>> -	#size-cells = <1>;
>>>> -
>>>> -	cpus: cpus {
>>>> -		#address-cells = <1>;
>>>> -		#size-cells = <0>;
>>>> -		timebase-frequency = <25000000>;
>>>> -
>>>> -		cpu0: cpu@0 {
>>>> -			compatible = "thead,c906", "riscv";
>>>> -			device_type = "cpu";
>>>> -			reg = <0>;
>>>> -			d-cache-block-size = <64>;
>>>> -			d-cache-sets = <512>;
>>>> -			d-cache-size = <65536>;
>>>> -			i-cache-block-size = <64>;
>>>> -			i-cache-sets = <128>;
>>>> -			i-cache-size = <32768>;
>>>> -			mmu-type = "riscv,sv39";
>>>> -			riscv,isa = "rv64imafdc";
>>>> -			riscv,isa-base = "rv64i";
>>>> -			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
>>>> -					       "zifencei", "zihpm";
>>>> -
>>>> -			cpu0_intc: interrupt-controller {
>>>> -				compatible = "riscv,cpu-intc";
>>>> -				interrupt-controller;
>>>> -				#address-cells = <0>;
>>>> -				#interrupt-cells = <1>;
>>>> -			};
>>>> -		};
>>>> -	};
>>>> -
>>>> -	osc: oscillator {
>>>> -		compatible = "fixed-clock";
>>>> -		clock-output-names = "osc_25m";
>>>> -		#clock-cells = <0>;
>>>> -	};
>>>>
>>>>  	soc {
>>>> -		compatible = "simple-bus";
>>>>  		interrupt-parent = <&plic>;
>>>> -		#address-cells = <1>;
>>>> -		#size-cells = <1>;
>>>> -		dma-noncoherent;
>>>> -		ranges;
>>>> -
>>>> -		uart0: serial@4140000 {
>>>> -			compatible = "snps,dw-apb-uart";
>>>> -			reg = <0x04140000 0x100>;
>>>> -			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&osc>;
>>>> -			reg-shift = <2>;
>>>> -			reg-io-width = <4>;
>>>> -			status = "disabled";
>>>> -		};
>>>> -
>>>> -		uart1: serial@4150000 {
>>>> -			compatible = "snps,dw-apb-uart";
>>>> -			reg = <0x04150000 0x100>;
>>>> -			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&osc>;
>>>> -			reg-shift = <2>;
>>>> -			reg-io-width = <4>;
>>>> -			status = "disabled";
>>>> -		};
>>>> -
>>>> -		uart2: serial@4160000 {
>>>> -			compatible = "snps,dw-apb-uart";
>>>> -			reg = <0x04160000 0x100>;
>>>> -			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&osc>;
>>>> -			reg-shift = <2>;
>>>> -			reg-io-width = <4>;
>>>> -			status = "disabled";
>>>> -		};
>>>> -
>>>> -		uart3: serial@4170000 {
>>>> -			compatible = "snps,dw-apb-uart";
>>>> -			reg = <0x04170000 0x100>;
>>>> -			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&osc>;
>>>> -			reg-shift = <2>;
>>>> -			reg-io-width = <4>;
>>>> -			status = "disabled";
>>>> -		};
>>>> -
>>>> -		uart4: serial@41c0000 {
>>>> -			compatible = "snps,dw-apb-uart";
>>>> -			reg = <0x041c0000 0x100>;
>>>> -			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&osc>;
>>>> -			reg-shift = <2>;
>>>> -			reg-io-width = <4>;
>>>> -			status = "disabled";
>>>> -		};
>>>>
>>>>  		plic: interrupt-controller@70000000 {
>>>>  			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>>>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
>>>> similarity index 80%
>>>> copy from arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>>> copy to arch/riscv/boot/dts/sophgo/cv180x.dtsi
>>>> index df40e87ee063..ffaf51724c98 100644
>>>
>>> Firstly, this form of diff really threw me, I was quite confused for a
>>> few minutes. A copy plus a pair of diffs doesn't really make much sense,
>>> when the operation being carried is an extraction of some nodes to a
>>> different file.
>>>
>>
>> I was told to use -C/-M/-B to generate patch, and the git format-patch
>> give me this wired output if I use -C, using -M seems no change from v1.
>> The -B output is also disappointing. Maybe I need to generate agaion?
>
>I don't think generating it again is going to change the outcome & I
>don't really think the -C version of this patch makes much sense, it is
>hard to tell what has actually been moved.
>

I mean regenerating without -C, This shows the the code move, but it gives
a huge output, since the git can not detect this move and output all the
moved line in the diff as changed.

>> The v1 version:
>> https://lore.kernel.org/linux-riscv/IA1PR20MB495360B632D106BBB833D82ABBCFA@IA1PR20MB4953.namprd20.prod.outlook.com/
>>
>>>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>>> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
>>>> @@ -1,12 +1,12 @@
>>>>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>  /*
>>>>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>>>> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>>>
>>> Also, is moving around some bits of hw description really a
>>> copyrightable change?
>>>
>>
>> It seems to be a mistake when I splitting the patch from v1.
>> This copyright should in the next patch.
>>
>>>>   */
>>>>
>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>
>>>>  / {
>>>> -	compatible = "sophgo,cv1800b";
>>>>  	#address-cells = <1>;
>>>>  	#size-cells = <1>;
>>>>
>>>> @@ -48,7 +48,6 @@ osc: oscillator {
>>>>
>>>>  	soc {
>>>>  		compatible = "simple-bus";
>>>> -		interrupt-parent = <&plic>;
>>>>  		#address-cells = <1>;
>>>>  		#size-cells = <1>;
>>>>  		dma-noncoherent;
>>>> @@ -103,21 +102,5 @@ uart4: serial@41c0000 {
>>>>  			reg-io-width = <4>;
>>>>  			status = "disabled";
>>>>  		};
>>>> -
>>>> -		plic: interrupt-controller@70000000 {
>>>> -			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>>>> -			reg = <0x70000000 0x4000000>;
>>>> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
>>>> -			interrupt-controller;
>>>> -			#address-cells = <0>;
>>>> -			#interrupt-cells = <2>;
>>>> -			riscv,ndev = <101>;
>>>> -		};
>>>> -
>>>> -		clint: timer@74000000 {
>>>> -			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
>>>> -			reg = <0x74000000 0x10000>;
>>>> -			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>>>> -		};
>>>>  	};
>>>>  };
>>>
>>> What I wanted to comment on was this though - it seems that both the
>>> cv1800b and the cv1812h have identical plic and clint nodes, other than
>>> their compatibles? If that is the case, why create a cv1800b and a
>>> cv1812h specific file containing entirely new nodes, when overriding the
>>> compatible would be sufficient? Doubly so if the other SoCs in the
>>> cv18xx series are going to have identical layouts.
>>>
>>> I gave it a quick test locally with the below diff applied on top of
>>> this series - although I didn't make sure that I didn't re-order the
>>> plic & clint nodes, I just wanted to demonstrate what I had done.
>>>
>>
>> Thanks for demonstration. AFAIK, what you said is true. the most devices
>> of CV180x and CV181x are the same, including plic and clint. The reason I
>> used a new one is to identify these two devices without making the
>> compatible string confusing.
>> Should I change the binding name of plic and clint to "sophgo,cv1800-xxx"
>> to mark there are the same series? I think this can avoid this confusing
>> dt nodes.
>
>I personally don't find the compatibles (or the dt nodes) confusing, so
>I dunno. Having reusing the compatible is not something that I am a fan of
>either, since this seems to be a different soc (given the sram &
>coprocessor etc) even if the addresses of the peripherals are identical.

Thanks. It is more like I have misunderstood something.

>
>
