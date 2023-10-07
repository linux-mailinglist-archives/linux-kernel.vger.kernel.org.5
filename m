Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95937BC7B2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjJGMnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJGMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:42:58 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2094.outbound.protection.outlook.com [40.92.103.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5338B9;
        Sat,  7 Oct 2023 05:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io6N+uFgbCwOIed4MpLRW+rxsMbLaG4GRX/5pAE2EWn5cfs8KTzChK7pSEzzojfp5NRkRTAb5QHMbDcnhj1Zo53Ztj5h9BiMs9wOyJivrCtpPyGyNFKaehiOOKtiDX9VZJtoRjyvotN1d/LOLeLWkTSzv0jLO//y52+I+5n1Rju9hduSlfi1HmHqFiZpFmaKgoJLOpaQFGc4ZgRH9yizNCWEh5CiQQRkFBE7sqizAug4hzvXJLhmNgxXiQ2F6uqT8wr2PHrYkRzCEoswUO/Z1HMytCS1d6DNOyOOZOYAtCsFXL7pEeJLrIExiRTJYHSKszJ5YillzVhigg9X3AL/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsIzFPf7jlbV9/e05HrS1fBdI4QaqzUiLAd8mEJkEI0=;
 b=HcPei4Yx5h2w42HNtd6pTxUCTbjomE9fRYTPofpF+u3CJ0UkoBbloU4fkS1m5sJFq/v2OL/OZWRNAwRcOZsbXCNH2PDuO6QNpumsulgLUj4eXEveuLS6iZhnbcdJOxpNlZMj8qUI6VrtCIwzQdH34ZrP2HHPcjeY5nUWZ6FuV7XR1dp9ugylmVF/WZzheBmVikv+07jCF8V+mLdVPQbrlPskkMg5ST95W0/3gFB6jfuM37FrT8VunqPezZz9vQHJvCG+ITVX0RXqEz4JSjTVnj/xv2WKd/RfXYpS1Zz7whAkt+w/Sos2BHi/4YK2IOAfb4JSQ2HzTZ0qgi9/2Aajeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsIzFPf7jlbV9/e05HrS1fBdI4QaqzUiLAd8mEJkEI0=;
 b=RbLp5l5qL3j0dlREkvIVBd4nlqUFVxg8AnPh8oN6V0m50dEiZGQxPZsX2fZtTquyfQ83eAh447lx7vYzM78joaXTiFi+xNra4IB1b65dX6ZsEHbW2IddFI+aUaHMokHlaZBnNRXdttW76RZ4edaDFQWQ4aZ1gYCuwDQp01u/itDjHWLpSNuDq7MmOxaYwZfhSWDPsrGt1mEbDnVKqkVP8GsSMbxKt+wQSIBFx8e1HLmE4YiSACCICAHWCkF+t3YYXUjjSs7jK4sxzDNil1rFOGNi1j3CtxG2NAHMHV8Abj0QGJtveiCD1Jw3E0Fx0uTlDTYZ9AM2TeLUIyUSTTlYtg==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB2441.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.37; Sat, 7 Oct 2023 12:42:49 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 12:42:49 +0000
Message-ID: <MA0P287MB03322FBD8B7E02888E788492FEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 7 Oct 2023 20:42:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] riscv: dts: sophgo: add initial CV1800B SoC device
 tree
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>
References: <20231006121449.721-1-jszhang@kernel.org>
 <20231006121449.721-5-jszhang@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231006121449.721-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [zgbg3E3OAT7HIBqsNUF+ur0DIqK8772C]
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <27a31dd2-9635-4595-852f-17a1e6c9d49d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB2441:EE_
X-MS-Office365-Filtering-Correlation-Id: ee81e219-0dc7-42f6-8e56-08dbc732e995
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xLjbTKXR2nVZt6q89Jsu1iLIcqQuMiZfO8/5Ah4YryHgOP+vDC6JWIillg6ltU7qJD+pfFwGU3Um+cvR3EwLc91kcaT4YnBWUQHWsvk5ZoGVeHXwrxCyRv8wRiEbwRVBlmn7qmb/tOEQiF6oIeDPrvMBl0GMUXeMsoXXj8cORqL1h/fn9z3BkdNbrptuyVXVNiFhthc+BGD9Fyh76fSc2wC11YIGz4mM+xXE3ojGAEjA/G1G/nj+ddrhsZnqgYHHIf7Gqp/0dNb7mTI2wOVmP52VdyvtlIrbtNZD2rP9glUtXRma8zjPfugaE+dUBdorZj/Dv2eioovZte0r1MKpWRmBMmGDLtk/8JGEotaHOfwRVDw2wrm5X0eWyK2b56WdhGxTEjXAF1mbQ6MgwBdp+ekcbg37H919LyZdj8nfWj4jh1ylwLvz7xEg1Um9q+AQnWaYt4QWwl6QXbxhbhCYwHU2aS0/Xro7blFYfI8ufdE/HdDgn4TgGCZ4YKx1+I/QnVeoqdp9m36wHWw8im9IV+AAaqGhLgGPSsdGr6BwHLWfINt4L+Db77MwrhmvhMr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHB1K2dudzRiemFrbzBVV3VzWWhLU3NMK1pOSXdTNFM4N2hKVjFuN094WUQ3?=
 =?utf-8?B?b2x5Mmg0c05DK0VEZDdkc292bncwdi9PYmtINy9oOW05QzA1ZVcxMnNsbW9w?=
 =?utf-8?B?WmFvTUtOSUFvWHBTeW0vcHRrdkVtY1VRaXZnTElQZ1hlRW1CbmkzV3BNakdy?=
 =?utf-8?B?NnNKdGorZUh2czhDdmdDZXRiaEJ0RjIwUllaZmd0RmdJdGw1c1RmdFpaRFlM?=
 =?utf-8?B?dnY3akNabUxVa1RXV08ycGNId1Y5MzBNcFZXYlllRlRlbG9VNERKQ01JNG1l?=
 =?utf-8?B?YTRZYUR5bCtaK00wU2ZycEdQMm9rMkt1ZVFnNTh4Y2JLRWZXKzdua3VOcjQ4?=
 =?utf-8?B?d1JtT3ZvNnlQejN2OFAzZFRnWFRRSGc4ZG1WcmVEZ3BFNVY1VTRZdWgwNGk4?=
 =?utf-8?B?TWF4anhlVlAveFh3YVZOYmF2dU1aMEZIbjFwZ3FjUU1FL0YrWndwWU5EaVBo?=
 =?utf-8?B?dXJVVkxxWU14OWthN1NZQWNCT1NjRHBwUkk1UWNQTnF6WVVTLzd2cUVvejE2?=
 =?utf-8?B?Zm9aZjNMbDhrTVZBcitPSnJwVlhMU0sxSE9pQ0dNY1AzNUo4eHdzUExUelR6?=
 =?utf-8?B?MzhLUTRVNkdiMnpVMXBFWWpJV1pHSnV5MCtmYmlLcGdIOXg3L2xXY1lsejh6?=
 =?utf-8?B?anBPeWo1ZndRalZSd2VMZkZVbXlQWVd1N2JIeFYxOTVkLzRiZHlOelk1TW5z?=
 =?utf-8?B?Vk5xbzBVcXMvS25EUEU0MS9jZmowL2FvUmpCM1JYZGZLNEhSeVZIcWJmSkxh?=
 =?utf-8?B?MVIxbWxvWFBUYThTdW01VEtadWZQcDVtZk9raU4vQUx5d05DbGF1ZmE1WXcy?=
 =?utf-8?B?TDh0Z0lpZWhkQ3VmVHJGTk5SVFk5WmNyU3RBYmJYRWpJSzRLN1Z3eUppdjNz?=
 =?utf-8?B?VENUUnYyMkhSMXJYWThWajhYU2IwR0ZFb2FjVHJqOStsbXBXSWxEbXpBNUFJ?=
 =?utf-8?B?OGI1Zmk4Yml1S3ovRElhMHpCbUQ0UXIyWDNHREZTdDd3NkZEV3VBSVJ0NEJP?=
 =?utf-8?B?ei9TVTVLaTI4c0xaclJTOGQzY2VSaUhCckNYbEQwUGl0Q0RubHppalRPNTVF?=
 =?utf-8?B?NE5LY0xzUVpYK3JHNFBzTmYwNFErYUNhNGFWN0hqTTI5S3JPMjJXa3JYcFdw?=
 =?utf-8?B?Y3FiczNaUlVRT1FLck53UGlsU3F2aFFZMzFva1FCRXNLdXJqQ2NIMlNHY2JS?=
 =?utf-8?B?TjVKSy90Mm5IUngxREdjaHRmaEJPTy9wOENKVDgvbWU3TDlhTEFmVSsyRU0y?=
 =?utf-8?B?aXNUSS9Jc3o1QWNsVm54a2VNY2RxTmdkVmhmNS9QdnFseHFZVVVDR2VuSGt3?=
 =?utf-8?B?dUpnSVdmbktZVU4xY1VIVWtnMGs5dGxaR3VOODVLenp5enY1VEZneDYyNHRi?=
 =?utf-8?B?UkRPaE5qalpxWmVoTXZGc0ZBNmdVT1pIRkpRR3cvdTJmYlBTOTU1blVKdDlP?=
 =?utf-8?B?bEJ6VHgzNU5UV1hXSERLenRlbVVVbUJhTlZ0Y2QrVlVFeHJVUHJYUFNOM2Vs?=
 =?utf-8?B?emNSTFZ4dlJYalpLQk82aXJsYnBVaG1lazQ0Vm9hREF1dXRHT0N2cHRQS0Rr?=
 =?utf-8?B?QWlvQWN2SHJOcWJZVVlsSFR3KzUzMXZtQS96L1A4M0U4K0hiMWJGN2dRM0k0?=
 =?utf-8?Q?ipkeLsPS67pFbCivB341RUzDtiJ+FBxudh2uH7/IQ4tA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee81e219-0dc7-42f6-8e56-08dbc732e995
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 12:42:49.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2441
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/6 20:14, Jisheng Zhang wrote:
> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Chen Wang <unicorn_wang@outlook.com>

Thanks, Chen
> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 123 ++++++++++++++++++++++++
>   1 file changed, 123 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> new file mode 100644
> index 000000000000..df40e87ee063
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "sophgo,cv1800b";
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
> +			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> +			reg = <0x70000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <101>;
> +		};
> +
> +		clint: timer@74000000 {
> +			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
> +			reg = <0x74000000 0x10000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
> +	};
> +};
