Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381C27C6E76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbjJLMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbjJLMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:50:36 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2101.outbound.protection.outlook.com [40.92.103.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC6EBA;
        Thu, 12 Oct 2023 05:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBhFvVb/k+XdGkzX6FXtgwXBFMB1oNmEMxIrnQpSpDjh0Ql+4mLoVEKjdoyHxDssMHQT37UP5IxZX2YWRtiClHAsjK6LevbKIbFENU8nvR/EinMFz0/hq3CJmxHQp6fxsaEjphqfrHiGrUI52wkKaGon+fwnqCmv4eOEqUbe9YOhMcUao3Tgl2Wr7jEYmxoFYP+Nfa+F1ZovGWG7mGOQvuhsaT6jJKxHH4h0bTf8cIXQl3kjfuivzzbdAMq/5v2/QrN9pxVZYh4KOGstXxQkYKZOYW2I2T5xABqpxrtAzcnLHKmmAoH87WdOXRdNo/0ou0YPh9LsYWdSkWoXyKVMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE1zJz2mmYdTr+VBJGXhDUQAqCLd/NL4x6PeEREpfiA=;
 b=HdhfxLeymz1lMw6j11KSlDWgB4GkWkv7PQQEQUoaAMv9kzSVOAbuNl+0YOsjEk64UDC9LHGq2gAriKYUUyWKuI4YfbptLo/WmxvJjZDkIKDeNdKNSXkqiFqkNzPrxJMv+A54EnLtesziQaOLk2REMjS7QydQUI/X0yEJVZlVDvHWR2sj2aJuX2lpCT907BaOUbmRJ8ET/w21DVlG8H87sEQeKofbbUagc3wih2d+yxSksgL4pZaN1ocz0rG4fYGkl1IDKyrvLc9geP0IFk0qWWBag0FJiCdZiXPUxW8/rf3TlYXso7EEj9hXD4zKbiUrg2JRIl66ZCj1bqnokTjueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE1zJz2mmYdTr+VBJGXhDUQAqCLd/NL4x6PeEREpfiA=;
 b=ixv+ABKAbe5TNrvKOGaaoYMMPygC8fGKGHGVHxOYLJj4kAgl8qU7taFeTncIG+DQAJXIaQs7mb76tVxE+WHHTAfje710QGgvor/UnvCGswfoQg54Dueqstxt2Juxg5lClmV5aTqiXo/EajUxaaopDgaVx/jVTT9vGXmnACBK5q4kUXkGbOIUQ3USmGnUCagF8Ayv4uY1/hGb73zkpzTuOvrAcrIMDn6Ya+dwZW4iYsodEyPEEC9KHrtAu8r31VEmQedXeOw3S/hjmh1ykgWwClGo7XdNk9XZ2v6wjXm/oeyZQKO9W+x+MlJ/ek/dMwdI6qFWjLT0E3eltNNHB0gFNw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB0411.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:122::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 12:50:24 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 12:50:24 +0000
Message-ID: <MA0P287MB0332C3CA4A3604BA7F7C340CFED3A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 12 Oct 2023 20:50:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] riscv: dts: sophgo: Separate common devices from
 cv1800b soc
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
 <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [USmAh0k1e4tNgW/PzfNgykK3sYiyoR/C]
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <4430bb15-9856-4c1a-82bb-91e048771b5a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB0411:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a10457-5c05-4a7d-f172-08dbcb21cca3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC12LEMBDVtl0jc1eY0d5o0dJiDK/3hIns/qtQ0/uMbZnnso1/uc8zye2NKf0MnfE58H63t1MLaGiZGqsc2cCVj9Ezo0mM46ZzL0m4xme7ENufzqXsfeaIm2qhmXY/rKqHRP94h/9rfXdPICTw94YRCSQoql2CAbbomLdCZc4QO61bwEkeQSa2vOSz+4SlzIp5rKGe/JBj55bWXoRO522pkVkHZMbRPpqbEdQbaIw4DU/0JLpqaVJexOEMLNS2aDFj3LnfuIBW8SC3q/rrG6WcIvK2CvJLEePmhs98NiRKjG37i85eEee+mmCLhbSNqt4+WGMiMQGESQbI4YpAmf3lt2e6ow4Y1iY5BtbCGmuYfxeNSDtbmCYkCwIDH8kRANm83AUd4darp9Q1buFygnFJkSQoqFg+hK2TuRVlzQItg192H46s2UYN7rdRr2CU36reCIW2XFkJsi+nU3yBSe74S/ZdmQmMXO5s/KZYWW+th/ygJxlT3yp8WwPtaTT1WlDLrjJx6Clq5rURL0mZ3r/NRVFyCHWwIBYlIyCk4AuYQfEc8ZGwx32MWRO38JsVhi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDM5K054MmhtU3d5M3FxTVhzMXg2UXdsUmQ1MmVnbWU1THVnS0ZaSGk0MUd5?=
 =?utf-8?B?aTM2R0t3WEl0NTJWTkl6TGNSZHA5S1E3aGJJeU5hc3EycUkrZmhGMm95VDNI?=
 =?utf-8?B?Tk5FRmJtb3NDaXBBU2Z3Y2ViaHhzTDhKMWdOUVlXQ2lnTnkxMnlwcTQyckQw?=
 =?utf-8?B?TldLM2VyWGVmcXJ0WlNpQkp1eURScmRDdVBnSURabXcvWm4zSUM4NWlWVWtE?=
 =?utf-8?B?RHhPZ2RKNHRLVlVqell0QlpvRUlMUGVLWFRBWDU0K292ckN5ZnQzdHhVZXFv?=
 =?utf-8?B?ZUcyWVdISWZGQ2NzaUR5djBwQnd4R01kTXBYZ05DYkF0eVJHeHlrZDZINTVE?=
 =?utf-8?B?NW1ISlVDNWMweDdLMUllY2tSVGdGaXJBSmNPeGVScUphRzRpWmQ3QWRlOTRZ?=
 =?utf-8?B?dGdrVno4bFFaWU1SdkRHSUV4aDFGYjYyc2VrSkhBWTA5MlhacllpQmNpQkVm?=
 =?utf-8?B?TjEwVXNxa3VKc2NRK3B6OHo1UGdRNFNmK2tCTTVSQ2o0YmsrQ2o5UXk1NFRV?=
 =?utf-8?B?TFNIYkdLdG1jSlYyZVNQUHNvTnlhZC80cUFiTTcxb3g0SE9keUJlaFo1RWh4?=
 =?utf-8?B?czJ1T2g4MFFlbUJyeUZQM3h4d1VOUkxJMytMV05qVjdjdGVHTTNLWEtHRk90?=
 =?utf-8?B?amMybTA0V1psQ3pYR0FDcjV5NFFoY2VjdUtQbXRocUpGelMvWTlOcjIzRUNj?=
 =?utf-8?B?c2FrejVleWVhVldDV2JUeWNQMFgxWU1oSjJ6b1p2TXlHL2xqMlcwWHEyVDdY?=
 =?utf-8?B?d1hONjJNRnZERGhWVFlFaSt1UnF5MERoQmI1ZGhPTW8xeW1laGhVdlpRb2p0?=
 =?utf-8?B?Sk52YzZnYTI4NmU1VEtPaFBsOVVVVWErb0lvVFlVUjI0L3VMZjd2QjVSZ3Uw?=
 =?utf-8?B?QXk4RmtFWEVLZEE2VG9tQi9HQTVhd01yeThrYWgrQzNsa20raVp5MTlVYzZM?=
 =?utf-8?B?MjZ5SndNejJSQnB4ZnJsTUZ1ejJsWUNrRnM1a0NUR1F6YWFlSFNLSTBwd0ZE?=
 =?utf-8?B?VW9WVUFtWitFQUY2YURNUzllNzh0bHZ3WTlacmU5dWZPRXFhWDB3ZlJwakhn?=
 =?utf-8?B?QVdGaE82bGhqQWp6NzhKUFlNOVIrT0dSS3RDSHYwMDJvbXZ2MmpWei9qbElL?=
 =?utf-8?B?L0VBa1QzM0Z5RHc2MlYvK1JiK0gvWmlSTWNneUp4RWdsUmFIOFpyOTlmaUZU?=
 =?utf-8?B?UWs1cFltODQ2VDlrWU13eGZwQ3JEd09kVnZOTDlKMUlmdjA0UGZ5Vk8vR1la?=
 =?utf-8?B?V09selEyVVd6MDRrWXMrTDJCTUticE5PYTF2U0JjKzRxSW1VQzhmZ0VHTTF4?=
 =?utf-8?B?YzNsdHJ0QWxCekM2Wjd1OWhNa3RKUU41amhaaG5ydnZzMERWRmh3UXZuellh?=
 =?utf-8?B?NnpCaDlBODFqUmdIa1pkKzVEa0NSVzEzZ1RHZkdCRUFDZU9SNnpRSXhaMVpR?=
 =?utf-8?B?c2sxd1RUQW1EUWphZHFtelpZeTh5OEZFQ2lWOVdCTTVZT3J5S0dMQW54QnhC?=
 =?utf-8?B?Z2lPNnErT1U3OXVoa05qaUNsdkFncVJ1cnFwQ0ozZyswZWowUjJnNWJvUm84?=
 =?utf-8?B?anlTQzhoa1IzTE8ycXl5WnpzMkxLaHBORGRFakpMR2dHUWZ5VUk1d3N4L2lL?=
 =?utf-8?Q?Q00BU5IMNV1rUekrTDgwx5XlHbLBNtA6FNN5dVNkh6gU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a10457-5c05-4a7d-f172-08dbcb21cca3
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:50:24.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0411
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/9 19:26, Inochi Amaoto wrote:
> Move the cpu and the common peripherals of CV181x and CV180x to new file.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 95 +------------------
>   .../dts/sophgo/{cv1800b.dtsi => cv180x.dtsi}  | 19 +---
>   2 files changed, 2 insertions(+), 112 deletions(-)
>   copy arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv180x.dtsi} (80%)

LGTM

Acked-by: Chen Wang <unicorn_wang@outlook.com>

> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index df40e87ee063..0904154f9829 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -3,106 +3,13 @@
>    * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>    */
>
> -#include <dt-bindings/interrupt-controller/irq.h>
> +#include "cv180x.dtsi"
>
>   / {
>   	compatible = "sophgo,cv1800b";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	cpus: cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		timebase-frequency = <25000000>;
> -
> -		cpu0: cpu@0 {
> -			compatible = "thead,c906", "riscv";
> -			device_type = "cpu";
> -			reg = <0>;
> -			d-cache-block-size = <64>;
> -			d-cache-sets = <512>;
> -			d-cache-size = <65536>;
> -			i-cache-block-size = <64>;
> -			i-cache-sets = <128>;
> -			i-cache-size = <32768>;
> -			mmu-type = "riscv,sv39";
> -			riscv,isa = "rv64imafdc";
> -			riscv,isa-base = "rv64i";
> -			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> -					       "zifencei", "zihpm";
> -
> -			cpu0_intc: interrupt-controller {
> -				compatible = "riscv,cpu-intc";
> -				interrupt-controller;
> -				#address-cells = <0>;
> -				#interrupt-cells = <1>;
> -			};
> -		};
> -	};
> -
> -	osc: oscillator {
> -		compatible = "fixed-clock";
> -		clock-output-names = "osc_25m";
> -		#clock-cells = <0>;
> -	};
>
>   	soc {
> -		compatible = "simple-bus";
>   		interrupt-parent = <&plic>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		dma-noncoherent;
> -		ranges;
> -
> -		uart0: serial@4140000 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0x04140000 0x100>;
> -			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			status = "disabled";
> -		};
> -
> -		uart1: serial@4150000 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0x04150000 0x100>;
> -			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			status = "disabled";
> -		};
> -
> -		uart2: serial@4160000 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0x04160000 0x100>;
> -			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			status = "disabled";
> -		};
> -
> -		uart3: serial@4170000 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0x04170000 0x100>;
> -			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			status = "disabled";
> -		};
> -
> -		uart4: serial@41c0000 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0x041c0000 0x100>;
> -			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			status = "disabled";
> -		};
>
>   		plic: interrupt-controller@70000000 {
>   			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> similarity index 80%
> copy from arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> copy to arch/riscv/boot/dts/sophgo/cv180x.dtsi
> index df40e87ee063..ffaf51724c98 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -1,12 +1,12 @@
>   // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>   /*
>    * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>    */
>
>   #include <dt-bindings/interrupt-controller/irq.h>
>
>   / {
> -	compatible = "sophgo,cv1800b";
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>
> @@ -48,7 +48,6 @@ osc: oscillator {
>
>   	soc {
>   		compatible = "simple-bus";
> -		interrupt-parent = <&plic>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		dma-noncoherent;
> @@ -103,21 +102,5 @@ uart4: serial@41c0000 {
>   			reg-io-width = <4>;
>   			status = "disabled";
>   		};
> -
> -		plic: interrupt-controller@70000000 {
> -			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> -			reg = <0x70000000 0x4000000>;
> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <2>;
> -			riscv,ndev = <101>;
> -		};
> -
> -		clint: timer@74000000 {
> -			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
> -			reg = <0x74000000 0x10000>;
> -			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> -		};
>   	};
>   };
> --
> 2.42.0
>
