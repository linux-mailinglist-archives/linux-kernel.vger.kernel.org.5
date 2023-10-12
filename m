Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18A7C6B64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjJLKrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjJLKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:46:59 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2058.outbound.protection.outlook.com [40.92.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109C90;
        Thu, 12 Oct 2023 03:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZXvHqoAb/IwM+m8dnPSwkbq+sgrD2utMX5sFSO6HCPHyTJZAQWgPW/pP2FQ/EK18Sl3f9uCapKvWObMUeP2mClgGBgZtEiuItdFPpQsbTVZJeMoZdI1G9rXgJXssLOK9G49idBijAQ7vR1jx5M1nDg30S7mYGw8TGo9uyQ2Zf0QA/F4z3NgN5BwbnVFjCaFUyClN8GLKUnZ2DkquTKIr4S3+4GrqIp3rhEaYcrmJVjAZnmx+mFoG4qFmS24MlKDdhanf/iFoxxUgBDsWxjRnOlDdMcTZgDdkfOkHA8ry8Uo1X5tzRjsg4T0/4Oq8BFDeDj7362JopFZUZ5nVSq2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpJoUGUd6x+Ych9wRM/uPeZlbQX5FHuBXZEtLbZhPyk=;
 b=aQ0SVPeLsKEIbLRUxjFXmRF8ICgN1XS4qFmqwBLFj8xV0K8wxpHvjCfFJkKOk6kPNKn2r/02ayImDpvslAcmnbAb9vLsIWVi9saKOhIAvP/JZvsmKZdQKAvUUz2FBXMojpnzTFTQ/Kei+BglbGhA7XCDABwrILtB3mswvRZyhTfoi9AqvYESQrv2bSx9MZPZbs6hOz8a5sXQPShQEUYjzPRG9Y11xiJYaWgjGqqwfAi6URVjjzxjw1UFN+1P7KTKYlHpKqqqrmEhuPIsz1Nu3YpsDzJwIF710XLlb5S78wXAyrZlkRBLovqSjPJh91CrIFhb5lR980hG+qHlY/QZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpJoUGUd6x+Ych9wRM/uPeZlbQX5FHuBXZEtLbZhPyk=;
 b=Vi1oWOYORwCrDUl/yBkb0Cmp3qnrViyzG9/KJ0AlmT4d5215Yn8H8pKm8MA/+FWqTvJUdPlwtZXIfwg1zRwbYBxiAFuHvu9XN4z8GDxn5yr6pFqppVzCqYdRVgHfHbZ+jiul1zwluKQWEkMibfKrZ8O6FlcUd0NJhCRArzvWZpANZ77c03u0WV1kKGZDyuc1H21NN8cEBFSPZTRTwq4y93CVw0u7Qvo9vYolQ9I+bstjsuinZWkaIgTEUk76SqvJLcHN9hQEqH7A9fqT/yW9Csw/qd+udilyurApApI3xKyz4vIpvZchFDRiZJ/opKNIjNRXoxRKALKOgHh+TxRzWA==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN3P287MB1071.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:178::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 10:46:51 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 10:46:51 +0000
Message-ID: <MA0P287MB0332A5A99911CC90948CDF44FED3A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 12 Oct 2023 18:46:45 +0800
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
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
 <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [5B6K+2bwd/fpWzi7UBnG1bSZT7iFNQ41]
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <d2d5d921-8392-4e9c-aef6-3d73fc45f092@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN3P287MB1071:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfee05e-c9a1-4838-3a07-08dbcb1089fb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RfgYfIY3AZ3lQ8qU14rUrEonhEFoIJDaueIY3Gk9XHgRSIkXOlJdUu6ZvWMc8k3oynX8iRQIVYcj6Su4EsDemmnC0WSXXFOXwA9pgDmLDdBFisA6iypUj7O5a1204v8E583+MpEd6nfSKMLQcUtQwX8YXMnca3e6nuVP6YahMGdwAHNoW5Eyi0mRSLCt6HfchXmZNIxOUCUlW3qDNGSb5fBuIZtHuHKOywvlXQhzL2NPxgQwHtWvgsGTeffL+YRuM/NIi7Tw0mSe8lnJVELQrzL0+ZarIge5UKbL6gwA5HPTIvJEaVSNyZxaK3C792fCT9YdoESgRvtixARhnIygFNDr1a1uHy+CCGdiMywApwzbbIUEB4En1NFxSCdmdOO04/bf+RzE8rawl58rw6GJGF+1y7QTAm2j2f9tSQCUD070lRidxHbsg3cd8s4RqYAUdourNEf8HsK2TbYoYk+hSSkxq5P/dppU5DpwCtX91LkwNV/Bb9RywJN++DbMNB8m5PJi2/ZJX6GElAj1CmsiJWkYRrO2E/BpFmkI+nkG9+ap3EzRZU9H0JxeW7VJbma
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlRbXZaa1NFT2FxRWtIcERqeWtLR2V3OUVSOGZUZmhiZW5zNm1RR3J1TWxQ?=
 =?utf-8?B?T1d3Q1ZsU1Y2UkNpc3VvclFCLzRYQXlRekN2L3NGZ0ZnZHlVZTdRODNueU1k?=
 =?utf-8?B?OUhWQXEvYThyTnRMS2ZzQXFVWXRSUHJaeXR5cEdPN1dPWDVSSnZ6bnYxUWpN?=
 =?utf-8?B?TGErYmM2MWtSTXQyZHB3VzNSTWpnTThMV3FHSVM3OEpUVllHRWdqdmFMSlRV?=
 =?utf-8?B?c1ArV0FrM3ZSZ3pTK1FXU2RXcW5DckFFZ3dreEVFNStnNmEwWDNmc3NOM0Z2?=
 =?utf-8?B?U3U3VVF3bzVNbXJNUnRmS0RCVUticDY5L2V6SmlvUW1McXhQbmZIVGNINWlP?=
 =?utf-8?B?c3QrNTh6bnZqNVRGajMvaDhMTm9yNnNDK3dCK25LOUx3UGVvTUZyQnU4YkF1?=
 =?utf-8?B?dWRUZUdQdGJBRDFJb3llbGNiNkwwanJLM1g3Y2Q3dkJ1UFkxaFYzWDc3UDFK?=
 =?utf-8?B?dzRVNnRrdSsvaWcyTXZjVWVMdFJyS1BtK1lCTkhNV0c5NWJtQzJ4Mit3c3Vo?=
 =?utf-8?B?cys5cU1YK3VlM2F2cVdEY2o2MXQxOXhVOG8yRy90WCtub3RFcllaUG5FZlQ0?=
 =?utf-8?B?YkRsTHo0R1QyTlBydmJueU5DODJ3cHZuWEppNmRZUUlSQXZNNHpuQ2NlRFVv?=
 =?utf-8?B?QW9tOC9pY1BObHRYdW94RjdkaEhhWnRtREVKY0J5am1JeTRsV2lmT0tkYXly?=
 =?utf-8?B?WXJ1U3NVdG9xK25VYXFJQjRyR3hxTFQ2ckJ3R01RQUo3aTUyWllHclIzOGNC?=
 =?utf-8?B?bGhKc21sZ3NKbHVEdjBSejBMNDQ3MnBuRk1PY1lNcUR4S1N0OHltTUxSQUNO?=
 =?utf-8?B?bzJ0N015MmFUTHU3ZTBLMStKV3psOUJEaEx4ZW0vMHFRVTVsbzQyemdjTW1O?=
 =?utf-8?B?RDYxdlM2dEFXbUVUL0xQVWw2SG9ueC80UzRhcFk1UHpDMzEzTTl2ek1jdG02?=
 =?utf-8?B?NFFaZURNOFdFZmoraGFmMUJvTlZBNndxQUpaTjBaUllPQUpwNjg3cS80bG51?=
 =?utf-8?B?YzJlOVpUVjZ6VjBEUGQzNFRzZ1JVSFNTTXZnRFZ0RTl1bU1JVmhucklGWnZx?=
 =?utf-8?B?L2Q1bXhLWmVpbWNxZkpIRzhIZy9vTEhFL0tMNUZYeWh3R2t0Vm81cUxuV0hB?=
 =?utf-8?B?Y2t0V3F6K0JXYXZBNXNkR3hOaU1xc2JiZWgrLzVYOVVYd2VEUkdSVHFja1J6?=
 =?utf-8?B?VzJBRnM1aUhwbGZ4QVRRK3Z5WGk4Z2hXd2xlY0tNMCtySkd5TnJTRmQyVHpF?=
 =?utf-8?B?ZzhOMllkeUM4QUo5alZiTkJJZi9yZm13d1lRMU9SekhSN05TeDN4QVlOVnZz?=
 =?utf-8?B?cnRaZ2w1NVV2bXRXWTJlZXFrWUxSbTdzSGhPWGR6bWxzNUV1cUdhNlRwRXgx?=
 =?utf-8?B?T2dFY3BvWjhyQkVpK1hyQzJTelZwZ3Y5THUzODdyd2xWeEcvVUdBN2lzeUw1?=
 =?utf-8?B?LzFWSngrUU1PTHMvcFhQSEtaM0ZoYnd4KzV4N0dLWTRUazM2clZjNHVRMjNu?=
 =?utf-8?B?QzYwRHFheWp5MGJFNHkzNnpEZXNWNlhKcDhTUytZZWVvakVnSXJscGp5Ylpj?=
 =?utf-8?B?TzRRd0JTeG1FSjh5aytVNlpWVW5oSTV1bmV6Mko1Kzd4Z29DMVVhUzZZR2Rs?=
 =?utf-8?Q?8se68AJsAuslJdWlh4u+TIJAsWEa783H3m3INH/rAmMw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfee05e-c9a1-4838-3a07-08dbcb1089fb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 10:46:51.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1071
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index df40e87ee063..0904154f9829 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi

Hi，Jisheng

Do you have any more comment on this change related to cv1800b?

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
