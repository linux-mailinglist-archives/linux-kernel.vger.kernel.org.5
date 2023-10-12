Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2937C6E80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbjJLMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbjJLMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:52:56 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2032.outbound.protection.outlook.com [40.92.103.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A884BA;
        Thu, 12 Oct 2023 05:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGKlTsCoW9KqqBQ1yw/omFpEaY0dR6ETz+czfy8x/w8AxwApGUTc8n7XHAZ0vz4PR5yY1KQKqJi9c/aQbV2WO0h/Fbigi+OArL2f//GO1dLnaCY/CV9aauKq4DW0mtdKkRJi+66045hsyX9ktSxRBvexFqqZfG2s4QfdyEhA1I2L/2r5xT5oZ1Mwcv2GwFp2WJtPjD9ZA8svFrfCtRq49ioh9zTqMeYQsGdVrmGXI0LC9VHhxEIl241GCBkLZYiguare0PZJ52bfUNdE6hw215yooJV35nRw6ifw/raOHTcVNYJItjtOdR/S/3cl0C5S1QQJ5eVwWWqdmu5CwIg2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w5xCFJIaajxy6UwdviwE6atHVEyUROskUy6K9WxX5s=;
 b=G0xqA/ddrxq5+v3OW0QIalg7I5OXROgQiZs8lRthQqmGmAKQ5YlMEhG9fXsEfTtmIvvJxjjfiLZNQ/+aoXffh1m8+g6ORI1TQvRViy2nxJwEl9v3ThBdC8CjHAP1+KAtwAZdt68A/OBxw1hsPMuuw3zS88abE6PO4zr3T/PNWud2LspUT8BArJXx44VSVL6iwCt9sbjU2ifjTB0Fka9eOPO5xR0+2P3EXEUc/eBkuLUqjSW/N9SvrBcrz61wzhqegCS0lo+7+4NPHNEHHwdqVqreYVk7f6DD3ZfbdvqjrmC348i2h9PwT8oKgXO18ZIN5c5AfO+PSxG8KUbDqMn1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w5xCFJIaajxy6UwdviwE6atHVEyUROskUy6K9WxX5s=;
 b=lkFMtvc8IJqWjOZyjQN7Mf2YOlhUV4i6qcm3grDprVmLMx1R1+ogLm1WdCLaqlCfa/Sr3FkDIDWb9P/UK1do3jDfzvWazR9sC3RT1YwE0CoXboZm8Y3/kKd/rLn/gZSzNiO3KGXfYY3fv3TfRSJSADrmBOZX4kbfICVhkCQ+M85PJV9Es+UjF3cvBGVaH6Tj45yhfHC82TfzbAKecnsj3F9nI7dEC073/zn/Qzv0I4aWYIiJBABRk7lWskFHvuu09B73SRfh/PBYWzHizP9BoYX+HED2xfMFH6pujy/TnEqHUmr2DhOQ4ZV1o5rwf35zAxJJdM8ZHX5HZ+lSoTCUlw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB1646.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:126::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Thu, 12 Oct 2023 12:52:48 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 12:52:48 +0000
Message-ID: <MA0P287MB033295D78BAE57B7E77C79E7FED3A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Thu, 12 Oct 2023 20:52:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] riscv: dts: sophgo: cv180x: Add gpio devices
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
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
 <IA1PR20MB4953F4BA74C7E9F011C88166BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953F4BA74C7E9F011C88166BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [Fhik9GxzG5XapULgzlrNSyWkJKwteEQb]
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <f67980b4-017f-4cba-b5dc-1bc10fee1e81@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB1646:EE_
X-MS-Office365-Filtering-Correlation-Id: c993cafc-8649-407a-da46-08dbcb2222af
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3ypDBZTpipS7Dz3XuZc9TL3gZbZ5GGiRZtPD5HPKd5HKCkPpO3KDFPuyzhGFDPXBXWD1ZOAZ7HmWDsBQ+5v5sYVDgwsD6Qpfi98D0ybNrp+FBCj2Hg4WmYkwGKIzgnIQ7NviMUrRHm/nM/IbBSPe76621q/BQpFcHoN6QzlZimckZxW2WI+sMvmpoFDi8DaQiIrlEqKKIdUGXvRVyEGBDqwSZQTXAykfCYkvyMmenZugmDf53RDx2bSgfCK5Dcq1VZQQ6UEy4pnnfzsQ/rbEDEokVbrmBjBx8aZT+8vONYGb3AuE5PMo7YRcEFzu+5W39fCLIVgHMVeBVzBCy5kdAKO21ZUJpwQ/dkpia/KmdhGRzRLg1adcamk5FVySHVdXNCPdvWXVdW8wIilYQWIX66GuKIIS5YGHIRAI9psimzS1jCiXSocBwA2cIlWQENiT9MshmZM1M9kY834SaWLxfC1IeqmJOqWsvvJJQ+i0GPr635qcEoCPmYxIBD1LRbwvH4teOdowGDrp7gqgpZMQML6zOi/p3eAg96REZrvq+3styqXuWjZh4jPFpsEOGEe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9HV05iOHZiSVhlOEJLT09BSTVUTEFxT0owZ3BJSEc5U0VYVkNRWTJLMDBt?=
 =?utf-8?B?RnlDa3lER2NSQWpIbCtoVlJHREFUbnBMbm5WV2lJL0thWWgveEN5N3oyQkNM?=
 =?utf-8?B?SXA4bHBRdGFvK2N0ai9sWTFUMTdrWkR1c1dlcTJudXJlcHE5a3M5RmtlVUNT?=
 =?utf-8?B?SnBnNm5Za09iMVVKbkx5REgrc3Bwb1BYb2tEWUp4eUZVbWNVVjZiMzdIWm1E?=
 =?utf-8?B?ZklwYld1VWlOalBubTZ1eHJnYmFqcXYyTUV5STVIS0psU0dQRkRxb2FocEFp?=
 =?utf-8?B?NXZZOXFtNmUrZmZ1TGl4ZVpnWDBWUk9TTENMOWlHRjFuL0VPbkdxSlNvbDJ4?=
 =?utf-8?B?TzFvV0NhQklOTWNyVUNWUjcrUVl3cWpLMkMvQWhoSlc5Y1JNQytjYTJBYUFz?=
 =?utf-8?B?Z2VwTHNLclUrOG9ZcnJrSnlUdEJSMUlleWpQamhKQzBFdTNFbkpiOGptMW9j?=
 =?utf-8?B?cDVSZ3JOK2I1Qk5OUm4yOGIzSVhIVy84N1VZKzdrbGJIMlVtM1B2RXBKMUZa?=
 =?utf-8?B?aXB5WGRNTnJuZEZGaDdOMmlPRWlBSjZTWDROUjE2eGJmWkM0RTc5Q1pLcW41?=
 =?utf-8?B?TzkvZlhwQkFTb1lrdmplZm52eVp2dUVsWUEyeHg2Q2Y3UHFaR3BYK1dWVmwz?=
 =?utf-8?B?NHNYdU9STXE0QVZIWW1oYlJUbXM4N0c3TStWb3pyblBXUlA3TGQzamVrQm5D?=
 =?utf-8?B?RlRWVUtuRXB0aVlCK1FWdTFZSmIzRkpuL0Z1U0ZQNjlFbHh1eHVqbFdxb1d6?=
 =?utf-8?B?eWVlTEVmSWY4UFlQVkY1aEdDZEdlcWFrR0szeXhHQmE2ODh5TzJHYWk3R1A2?=
 =?utf-8?B?UlpWODFjNk91YUs1ME9GKzc2VG5HUXgwYXQ3Y1BFSWFOWktSTng0MnVmaTN3?=
 =?utf-8?B?QnAzUmQ3bjZ5akJnWEUrZ0VEaDh5dGNaUVdSMjJsSGRqWjB2enZTU2VmbitP?=
 =?utf-8?B?aFRqcWUydkhzTnNuT0Z0dkpxS29IZ2JPdVg0UGxzYlJZenphaGZvbDN6ZjZo?=
 =?utf-8?B?SThKMVcyVVBpL1N0SU5FVDMwcFh2VlVleHNSMnJnbHZjNHhSTy9rOGY0Y3VY?=
 =?utf-8?B?YytzRHpqaDF1ZXZKbmpYMW5ONXZhYTh2dFhZOXp6YlB6U21tTUtNOGY2eXdv?=
 =?utf-8?B?bWhvVHlnd0t1V1BwTkVJNEFQOVUxNXQrQUFGQmdPdXp3UHpWZHJhZitSZFdF?=
 =?utf-8?B?WFlvMytVZjcwOWw5cG5WRkd2Ry9mVTl1RklrdWJSQnN5R1NwWUFzVERGS0xj?=
 =?utf-8?B?dms4MzB1cEoyTHlwS1dVK0dUeEpzUWQzSkh1ZldxYUxvakVCb0I4WG5Ib05U?=
 =?utf-8?B?dDl5QjFZdmIzUnZFK1hVSXNyblJVRU1QUjRZTnZ0QllRdjNNQUV3OUVPcWNR?=
 =?utf-8?B?L3p2U1paaUg3LzlEMjROcUhYRFFHdDRlREdJek5CVUNBcGsrbmc0REhUMnRB?=
 =?utf-8?B?QkZGcUFjRXVGYk5QdWhLUFdKMUlER2dyMzhDOC9LdjhlQjQxQUdsODRVUlNK?=
 =?utf-8?B?SEVvQkpmSmVVMVR0UmNicmR2NUxjUmFXV0ZzMFJjZ0hJUGJORTZkcCszQk0y?=
 =?utf-8?B?czZLSEV1NmxYc2ZERDVMdyt4bzJ4aFY5bzRPWkt1WTJXSXYxemYxc2lpOHc3?=
 =?utf-8?Q?6esDPJT/eHyFbftYHKENi/TZKJZOpqFj06IRbWzPsB7U=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c993cafc-8649-407a-da46-08dbcb2222af
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:52:48.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1646
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/9 19:26, Inochi Amaoto wrote:
> Add common GPIO devices for the CV180x and CV181x soc.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv180x.dtsi | 72 ++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> index ffaf51724c98..64ffb23d3626 100644
> --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -53,6 +53,78 @@ soc {
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
LGTM

Acked-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen


> --
> 2.42.0
>
