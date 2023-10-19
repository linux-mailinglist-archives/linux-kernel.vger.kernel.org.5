Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9F7CF7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjJSMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjJSMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:28 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2054.outbound.protection.outlook.com [40.92.103.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3837B198;
        Thu, 19 Oct 2023 05:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G30Monmj6n9ov1cA0xG1FrgI3iKwd8m0MUStIrWzTbJLy4VuWwGwsBCPcblBbiJSeexQ7c2Ko5vqOYfNrwJ4UdLVDqjctl+3PjUnSkqGf10ZQHbcgmAcXeWdVbnQjfmNu1vPV1MlvoJYoq+YZ+OPYKcI871pcQ79cDdUJfr84hZBUxSfnFb5hOPXy+/sobjYVoCb61jwPCMkbMfM0PoT2DEGiJ7Zje44LkPvTUqOhHigZtvUhfEMONzw5FYToisOALptECJukulWu/lANgYwMEBVqZ0s8wZDaDgzO1Pd1SV2X5FGN6ZKys7xhjH7Cg+/WA20jWSSsW9zJEPtmAdLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6XOFQJPiLxuy13QHpCKBgOlZ/hyk3g/YfLEhZjDFZE=;
 b=avv7UXsMDneaMDP3MePTUpV74Rj7RiIg0gBsEiC8EPEbHJ+gINuwoABYh5ZH6/cFXHNma3m3J5e+R1LVXSvhkNBP1rTJ12qA0XhE00BTYvv3uSYQetCnn4LDLRY0LpRONrFnEl3p0kAT3DCWpq7ee+51L/loY5JPGDTfLWhDWe2ObZkhEmxkoIKqLKir4D64QOYI9pYVZKMSQT3BXge3EvEXTOkYFyu+3NZM8+UP0Sa2WwBlNBRMM/hzcHn+2BdfGY44IE1ndUmUAb0lnvaWqfg04ty7SMJ9+mkTi7tG8BEzn5c+b7gXZNfsce1TkI1IW1Jw2YIkPVsgReGui6do/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6XOFQJPiLxuy13QHpCKBgOlZ/hyk3g/YfLEhZjDFZE=;
 b=lZ4nuCWeHfiqIk2hbhk0IQOGC9K1DTUB4tUN2t0rL6M23fVozCzjcMykwE2dL3nluJmy627SUv+HGgRvpreDNL5WIQZnRYUkRY5uHfmx9aJv6IV+CV3TnLqBCZ+esL1HorwjFb6BuX26y6qNBco3Vqhjs+qnl1hu10qn7XsCKzFNYYYQvgFtPL3hd4YjOgxoe+rIfyXN+C+F99y+G8UscQgjB3wP5sDZ47pP+q9y9Hms+eWlyszvpUmTRFr6dhF3ezyxmbufuxqQOFl1TbsityEAEm3/5RkeJ7C/tK2A42QITET6CPJ4CnoTfy1Qc+Ij9oRDB/fCQmEZiEiOp6T4uw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0739.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:fa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Thu, 19 Oct 2023 12:02:19 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b66:61a1:8ed:cc6a]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b66:61a1:8ed:cc6a%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 12:02:19 +0000
Message-ID: <MA0P287MB033232F5C170767F51198EC4FED4A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 19 Oct 2023 20:02:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953C1E5F9EAA3699EA1D3DDBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953C1E5F9EAA3699EA1D3DDBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [fOxk78Ghb30hptZywXd4ak6Z6A/ZKpOu]
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <bb58eafb-0271-4f56-8dde-0dac4cbc5c1f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7fc00d-427d-416d-6482-08dbd09b3e3e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CH59cMKqDk/I3uyAXGarV99hO/iA7c7pARrxkPCDrdfY37y7Q2OK0Z5jsRqyEh6HZc/O/60ECT6J6r4GSX4y5rFdTWq8+X6htQzhiigrHO7+uiN1gznHVhPSSaKEw6/HWLsPB6txYPaIn8AqDgVtAYQ7+GUSDZZGOfOZaj/PoO8A+sQD5ZzFDY+nhrlAJDgFLXH8yka5183pQRCMpsGkbdJu3WO+VG7CPE/YnDonUQvWEQz8EzqLz9CzRchvcVnVpiRxBA/CejpIbjolV9jz7wtx+AGMhk9LJcfXZQeHldTnJ3GCnjOunDbVIcjqkrg2dp4AxPXNga1pi1HqJafMiudn3yvNeY4MUD22WTc50BUho+EkFUyWeiUuiaNGW24Qb54KRl6FKupYqPnkEKUlh6TmPJuFNWxfI4M3rWoIOztkzOZUvA9uWP4Y6v8wcYvr1Hx8Kd7asgIJl3K0yhejwGDwwDG/5y0lmOJqJqwXkEwA25YBfFMa3mUft4TPxYhxCeslmr10A7z06Oj8BwnreLGvY3OtW5qpMwPkGf0/ERlW75X2S9rszE4rVAlVUzV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW81d3JBNnB6VkhrK2F5V292cUNKSkNONXdoalZ3d2FCdmJ3RUZYT3hNUUtV?=
 =?utf-8?B?RXprdHZDU0NrR2NUS25yemxaMUpYSUxvM0JXV0dieXk5Y0RXaUJVTHlQS0Jo?=
 =?utf-8?B?RVo5bmozdzJHNmpEZzNkenhnZzNpdWJYTVpLU2xPVElLWitvU2sydTUyTE1R?=
 =?utf-8?B?anQ2ZVpOdno3WGxEbkVJdFN4SlNQU3lzVVVHNjdlMG9EYTcrUkZEUk9kNGRQ?=
 =?utf-8?B?MzVQVldqajNEcjdOWHJWU0Z0cTdjYXljNS92SkVDWDRta0dka0Noa3oxSnFP?=
 =?utf-8?B?cmhDdmx3T05UTGMxd0ZUU2o5QnQ5UlZEWHVpN01EUjUwK1ZsQWZlME9wbnB0?=
 =?utf-8?B?b0NVQzRla3VVWTFtdlBBM1lnT3VNWmVKMlVpK25DdEhadTlrVFc5dDNWdUtK?=
 =?utf-8?B?ekNBYXd4cm9EdklaZmcxdjRCbE1iTWsrWi9iaEZJTjVDRlRiQXMwaUxqSEF0?=
 =?utf-8?B?N2FJUkR4ZjJaUXFjKzRhZVY3aW54anhmYzB3WUcxWE51WEFGQjY3bnBLNWVO?=
 =?utf-8?B?cFZIdXdSWHdUK0xwa2piQU9jUExZdlJ6bXRlWnFsQ2lERVBKZjNibGlHZEpp?=
 =?utf-8?B?UVlib2FyMzJPWUpmQzRyMmZhWVo1QWtVNVlpKzR3K094R21Bc1FiNGVnLzhF?=
 =?utf-8?B?b1hTZFdsNUF2N2NmdXB2YUhWdHNzSXRIa0tpNllhdUZZMzNOczhkYWxzQmpI?=
 =?utf-8?B?MGhqY1BFVGFXTVRHU05hNEExZlI1QkhjcWhyY3gzYk4rZnZpSXd0Qmo4c1V2?=
 =?utf-8?B?MlR2aG5PTk1LUlk1MDZMSkFSMjRmbktQVDNiaWRrWnFuRmI1RytVSEwydUlp?=
 =?utf-8?B?VENLM2JNRWdTckdPdGNoY0RlY2dDN1hVZk0waUMwRktGeUh4TmxtTldzQm9V?=
 =?utf-8?B?enlQUlgwM3h0Um80S2pIN1VIbHhlUHQzREc3TWFkWCtoREZoVGtNcmgwYW0x?=
 =?utf-8?B?bkVVYVJyTktxa2IzSlNsUitZbmx5eVk5VEczM0p0V09EODlTRC9SdGZLQ01K?=
 =?utf-8?B?dzdhbE84T2hpSlc5bCs1Y0Q4RUFmNWh6akxHOFBFTjJhbWhRaXVGREw1T3cy?=
 =?utf-8?B?U3RiQnhJY1k3R2lXUHQyZEFqNjg0TWVTOEIwTlBMbk1jTTBDZUZWSTJUMTJB?=
 =?utf-8?B?OWlRRjN5L012WEN5UGQyVE9WMlgxUVFoTHRxNEs2citlOEhScWQvSnhxbFIv?=
 =?utf-8?B?eGpJZE5vbGRQZUpBakxTQUFtcWYyNWM2eEZtcW9QVnNkbGxGQU1LTDFOYmM2?=
 =?utf-8?B?M2R1VXNnK1hwaHp4Sjl4MXV6Q2k2RVREZm5yY3ptYWYwNE1ac1RUb2N1SEhQ?=
 =?utf-8?B?Tmk1UXN6WTFYMDRGbTg1dmNjaXdnUXpwcWgrdGJsTnFHSTVyUkQ2YXlXY3pI?=
 =?utf-8?B?THdoNmxubGpCR0VQL1UyYnlESDBFZWt1Nm05UTBlSWE0cjYxekJ1cjJOY2Yy?=
 =?utf-8?B?TzZiRjRQZVR3T0ZpSisxRWZNWjBMRWtPMmhqSUc1Sk43Z1lPVVlndHI0UStD?=
 =?utf-8?B?RytJU0VVZXA3TmcvSG0wa2lRcW5DMFlGNW1rOHFFRGNkaDl1SEovaU1mUERw?=
 =?utf-8?B?VFRTUEFIUmtJQ0FvcGxZaDc0Sm5udmRVTGZjTWdORkhYTDRKZ3pLQ254dWgz?=
 =?utf-8?Q?bLZjoIdNYZ6MKo8iZ++BKoFZOhk++qrr/TZUtA9GhJnY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7fc00d-427d-416d-6482-08dbd09b3e3e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:02:18.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0739
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/19 7:18, Inochi Amaoto wrote:
> Add common GPIO devices for the CV180x and CV181x soc.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

LGTM.

Acked-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 73 ++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 55d4bc84faa0..d415cc758def 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>   /*
>    * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>    */
>
>   #include <dt-bindings/interrupt-controller/irq.h>
> @@ -53,6 +54,78 @@ soc {
>   		dma-noncoherent;
>   		ranges;
>
> +		gpio0: gpio@3020000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x3020000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			porta: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		gpio1: gpio@3021000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x3021000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			portb: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		gpio2: gpio@3022000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x3022000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			portc: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		gpio3: gpio@3023000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x3023000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			portd: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
>   		uart0: serial@4140000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x04140000 0x100>;
> --
> 2.42.0
>
