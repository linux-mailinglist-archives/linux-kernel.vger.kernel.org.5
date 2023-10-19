Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9777CF85C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345607AbjJSMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345639AbjJSMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:07:16 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2041.outbound.protection.outlook.com [40.92.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC51A8;
        Thu, 19 Oct 2023 05:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpKmeISLmdX5vLEby+zb3Lnjc4B/fPwgNPkDYNtkDGr1NoZod47JdCuj1Lf7D0S1BeZJqJWBw2be2ehgF4XyQtF0g7XXLU9b2Ir08KO2vc6EmhvotE/sHFHMja1VvpRKf/75Zn41faBF/mQ85ByHYdu0N0+ZfhQg6jqqxTRvbsoGKZ5nZclETLqPNQpVyrnPt0VpzWOzGvK9cy0rKqFrLV2W3gM2ioFmwaNdxTvU/rmKFBa7S+BfBsI9D/ZD6XtUqdgT+MRsj/bbEH7RJrQbWtIYm75ygb4yVOnWlUdiCudNjIpvhTnCCA5wgk1egEGx01JMa57ReRn06PtdbqdwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a+p/jbfLIwMTri/vmxhLMkTcf/dI6sVEhQHZQUTd94=;
 b=IDRbM0G6DWpsghoefXTlFDnDLFxfb/S9pExWxaSxLZYtEHbmbYJArELK6agtsvwVzuBOQ7f9/Om9F6Z5eRjlLzokofOFyZtU6IJvSQaw6web59pvoKMIS4aMwHbz3xoons49hIgCEyvG4smb1QNqHHxQwM23APfu/HZJ/zooJwCcfH+RWtbXQZNborz14ZpC2BCu2kH++Y4ROWU35DE65NCNnL21v+Cmihk6cYOFXdDMXV98hICflg007vl7FEA/QKpyXSpNQyvHAO/cBUL8t4yimQmh19p3uOLU5OGGTU1yRjKy23qQgsV5s23Hi8JjiT1u3mKK1YVvN6FbMyE65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a+p/jbfLIwMTri/vmxhLMkTcf/dI6sVEhQHZQUTd94=;
 b=gkLK8FKNtLKhOBPZT9wVMH90St2fjWrSpdMohhjjPlVeBU4iMYmQFzSv1HF/vr8IAZWKDf71HE5zxS6B/j3zxOZ1gP5BFa27OpTBEVsfqvzYDCHu4iQFQBXE3JgPBOEnofAecZmyP7HajAM26p0zd1LHkpPjzdtPLJv0NJr2gJOwOCmmyHbOQundpZxpR7h04RD+o1XCdDkZLV1Za2jXYEvkl0Hofc3A0kmruwuiamZ9luIEOBgyiK5ttcSqKnZCQxD8qhhFREmsaLTiCMs9/5PUGlOOxFGlj4qIn3s3hI9somr1pCN67YnA7+yK/xtze6JRUjQULdaXl7HhpvDGjw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0739.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:fa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Thu, 19 Oct 2023 12:04:32 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b66:61a1:8ed:cc6a]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b66:61a1:8ed:cc6a%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 12:04:32 +0000
Message-ID: <MA0P287MB0332183EFC268D6A7AB5FCEBFED4A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 19 Oct 2023 20:04:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] riscv: dts: sophgo: Separate compatible specific
 for CV1800B soc
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953C128FDDE7A2249669213BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953C128FDDE7A2249669213BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [LXg5H+R9rpISbHJDfx6XHXjrvjlAmDw9]
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <aaaf5dd1-4f75-421e-b4b4-0df918cf6f46@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0739:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b5fe57-1442-448d-b671-08dbd09b8da8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZcVsjsdN6l8uAp8alneOB2IFkN512HmTEhi6mlrTQ9c/BjRREBhuitD0lV8SFNxPkl9fyXAxm3qWyk+6Y0XxTXnHohG4Ksd8bL42eomj3ICLdt3ciT63YCSk1HbGe40kRI85NuVGfDd3HxdzQVwqchnycioIhB5inApqKrS1gpIHslI2iTRdzqT/L9zX6j7OdAsFSNwKQHc2hCKUK0Ye3qATL1YoxU9jHrNf1e2fI0r6U2Ti1Qz4mV3MNeTiaOicvAGRmYyH7UU7PGdKlAt6O8DbQO0GR5tYNcwl+E5NvGJbaZrdbVXWJbHc9PnxEsWQQJetTFrh5JZdabOlv7nnUKy1HqW+8+OPsH0X0aAZSMVUFYBGDA4N3++NZIhX1fbk1R/Tsv1KaNZD56czMZ6UWPPpqheR5QjPNJ7i+BUHMIawCSq/g4GqV85o/wpsSYxQ/mcnXv7BjguUQvs2fACJcwi2ASZd31C6VUGEIaEiAcqBnfQR10IiXwHIvxpz0ZVC49T7EWcgw4x2wcCSiHlD13JFIIybC6J/5QQ1Llfb35C1/OpeJc+CMbxtr0Ze/3u
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNIZGV3WjdxTnI3NGFOdXFFaW9lMEJ3YVR3eUxjQVYvY1hJMXhGUW4vTHNh?=
 =?utf-8?B?a1FiVGNrZ3VpbW9wNzhnNFpHTjN5QXRYMkpvVlBCUEdIR2RNcmpIMjJJL1ox?=
 =?utf-8?B?VEFNU0FEQzhDb2FGeEt1Q2h4UTJwOHdPWmdoQ3Jxdm1CaW5sVG51T0NVZm9D?=
 =?utf-8?B?bDdNZnZvR2I5MzBRMGtLM3l2WFp6K2RubmpKZ3NVVEJNY0hxbXdJbVFSc283?=
 =?utf-8?B?OElnVGRkb1NNZWJkK0V2WmZLanFsVnoxbFVzRE1mNityTFVOWnFaWTBIQy9o?=
 =?utf-8?B?NTFSdjV4RnFkbTNUa0NMMUtKWlB4WDgvOWp6bExNUm9yeTV4M3JEVThJZmNX?=
 =?utf-8?B?ZFNOS0UyYlNQK0JqemFuQlJNTk5sR3BVTFNyQTlLK0NCY0tJTHJGRkRyeEdk?=
 =?utf-8?B?RC93Y0cybVZEbWt0d0tJYW9CdEczdDJkV1JnUmdsQm9jVGFrakR6bWxyVk4y?=
 =?utf-8?B?aldteGg5WWFTd0p0RFRXeWVsWU1CMmpBbTRoTzFFS2NKRGRtZlVudkR1VnI3?=
 =?utf-8?B?M29KSFhaeENDZmtVUFRncStEMWt5OWNMenBKZ0FRbmY1U0YxZmRBN3psb1N2?=
 =?utf-8?B?eXpCOEVWOGp1Z3g1L3hiMW5kdGg5VkZDTWpzVUJNc09wdXR4SWJVaWNXM2RL?=
 =?utf-8?B?akhGTkdMZlZzbC9mc0xZb1p2dDUxSWVKZTFzdDhhcjdMeGdNd01FblBla2lO?=
 =?utf-8?B?Q1R6REIwdi9RRWhRUCtZbWs5aDBVTUE1Y1E0MGRWaHovOFo2NmszaEdtTUNm?=
 =?utf-8?B?dkwvcTNRSktUOXB4RXpnT3RRM0p3ME0yTVRicTEwVzVMeUM2WHhFTElEUHBz?=
 =?utf-8?B?K0xwZzM2aDRGUUp3RmlLQ2pKMDBIN2FtUUlWWmkySllRelNTVnlxMk1lUXZi?=
 =?utf-8?B?Sy8zRmtmNmFuMVM2OTh6QS8zSFFqSGd2QkkwQlZuWWkydWFjdFFGekxLK3No?=
 =?utf-8?B?cFBLL3JIOStZR2xIbkozYXpxWFJvaGdEZXFOSXk1TEdEWGxOZ1VwTktHaS9J?=
 =?utf-8?B?OVg3ckEvRXJiMEtUczVPeHFkdy9aWUN0a2srb0ZPY252azJ0MkRHbEpER0gw?=
 =?utf-8?B?M2R4bFpPWldsNklaa1JGZU8zR0FXZlIrclU3V3ViOFNMemlUeUpON3AwSVdI?=
 =?utf-8?B?YTM4NXNCcTF4d1FVWUFBaUwzdkFLQU5pNUZvUFVxK2FVTTBTeWw4anpJZVBa?=
 =?utf-8?B?MzJGSis4WGdreWtQSk5LYWNtT3ZpdzNwOTFyQUNrYU5LVmhvTnJSc0FNejV3?=
 =?utf-8?B?RFVSWnUySk9VbXQvU1JZbzBhUjJ1bzJHWVRhU21JNkQxZ3RxNmZGeWYwMUhx?=
 =?utf-8?B?RkVHcXphSmJRN0hBdW5IT2ZELytSQWdVSFNMM1BSaGJNRnNwbE81aEplVGxE?=
 =?utf-8?B?OUI1MG5aRkFyUEpOZVpZRWtJYy9JbGpYOUJUdTBqT3c3SkVaNlhWeG5CSzE2?=
 =?utf-8?B?VW5Jek1Ma3NPamh6QStxcGFCWXRrUEZiUjV0RjNLZTZ2OVplUnZZWWxEK2Fn?=
 =?utf-8?B?MUtBTXNzYTVDa1ZTZ2JyTW5vamJvZHlMelF3NWVaSEZnMkZKTkZhZE5LUnZs?=
 =?utf-8?B?dThEMlQ1M3dzamx5YkVoQzQrT2NUdDFMaEg4SEIvR2ZGcFY4NHA4R3VzbmZH?=
 =?utf-8?Q?V6P+/It/DMNU1IlZ1DLQPZKh/vJnwQ4cV56osstcPhNs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b5fe57-1442-448d-b671-08dbd09b8da8
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:04:32.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0739
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/19 7:18, Inochi Amaoto wrote:
> As CV180x and CV181x have the identical layouts, it is OK to use the
> cv1800b basic device tree for the whole series.
> For CV1800B soc specific compatible, just move them out of the common
> file.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Thanks, it looks good now.

Acked-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 119 ++---------------------
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 120 ++++++++++++++++++++++++
>   2 files changed, 127 insertions(+), 112 deletions(-)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index df40e87ee063..165e9e320a8c 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -3,121 +3,16 @@
>    * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>    */
>
> -#include <dt-bindings/interrupt-controller/irq.h>
> +#include "cv18xx.dtsi"
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
> -
> -	soc {
> -		compatible = "simple-bus";
> -		interrupt-parent = <&plic>;
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
> +};
>
> -		plic: interrupt-controller@70000000 {
> -			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> -			reg = <0x70000000 0x4000000>;
> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <2>;
> -			riscv,ndev = <101>;
> -		};
> +&plic {
> +	compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> +};
>
> -		clint: timer@74000000 {
> -			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
> -			reg = <0x74000000 0x10000>;
> -			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> -		};
> -	};
> +&clint {
> +	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
>   };
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> new file mode 100644
> index 000000000000..55d4bc84faa0
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <25000000>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "thead,c906", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <512>;
> +			d-cache-size = <65536>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			mmu-type = "riscv,sv39";
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> +					       "zifencei", "zihpm";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	osc: oscillator {
> +		compatible = "fixed-clock";
> +		clock-output-names = "osc_25m";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@4140000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04140000 0x100>;
> +			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@4150000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04150000 0x100>;
> +			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@4160000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04160000 0x100>;
> +			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@4170000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x04170000 0x100>;
> +			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@41c0000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x041c0000 0x100>;
> +			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@70000000 {
> +			reg = <0x70000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <101>;
> +		};
> +
> +		clint: timer@74000000 {
> +			reg = <0x74000000 0x10000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
> +	};
> +};
> --
> 2.42.0
>
