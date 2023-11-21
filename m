Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98277F253C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjKUFYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:24:09 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2104.outbound.protection.outlook.com [40.92.102.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98CE8;
        Mon, 20 Nov 2023 21:24:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSClK6lc4+ZyiQvhTiFhTnX/7Q8TSRLA8oqYi0krtMzPQb7qXoY+Z9ufegEg1AjJCzLaikxrBc8Y1Ht+qNeZRxc6sCxK88+8nRvBUQs+zwpyMcFYhkHKciP/4zjIDbbh4GvN5s5iqL6zjlT+xcmS7/ng/VnwTWx8vCItKMBkBqERRxliGxstpmfm4qfaxn8g6miRJV3q2VksQuYTv8JMF0WTQyWwtbgVSpC0SNpLGfDeDJPF49pzfOqMj+R41/unEAMMcwAml1vdgeErKkcr0mttGLZfbVXE5qJArJwsDAaps8ptsSj08pVNX7hbvyEwlnmBzCxzu1DPjUfc6Nh18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb6IfHB18/0TQjWknL4Vp9aEMsi+NKpkMvIcgEzHEoE=;
 b=e75NvCMhhJkSgXdwEBkxUjGDGTRnbLLj/Dp/xvrBAbVcMbEe6mDpdWyAKkgfzvYY2xmYSXkfUff85IultuP4k3NK2/it8zxmuyUPsM6IDxzX5G6vfTJ9u8yJiQw9aPAPIi5OVLK2GHE4wZgUoUKm8j1LYsk9ysxhT9PA8ivr2shv+hSvhjZ7haqmrL1RzxmX3T98aIj++BbsCVsiNRW5k3Rodgvm5kSsexiJXHCjwKFqKitVIdZN8bJQKA3ublmuNBiQfBJrrmFk7SdbxTCN7gKW5mZS2cL+j8lI6XJ2oPFRBLyADg8RaF8ukC6+/zkHUVqWcN8UN3sF+ftDyth5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb6IfHB18/0TQjWknL4Vp9aEMsi+NKpkMvIcgEzHEoE=;
 b=fn5dq86g16/Hng2LzhsdxXmYNPAZC5Gw+Ulkx/iq9QzlhXS5kmi83FepHtriqJnJbGn67rPcH2S4GdRytbMpMZdcL44uld1/d/gQUelDSwqUr3Qex4/bB7qAD84CQioFP1M7u5FSY6cqY/q7PEQwkPtlMb82mRFz8HA7ihhIMoYGkXfaoDZriyJb2f8SqJ9xR3revUa1X6gw/Zz7kQ9GVfy4X2iMtxrcPoayVoqBo6OBzhYpHfKVmZL8BjfnL09sOAJWydVtTg2emz9rhWJTy5dKgsJhqp1Fg+EMlz4b5D4lEcDB6noxnXCpGfqRPv3doxmz1bPpRpxTmeSbQbKosw==
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d6::7) by
 MA0P287MB1708.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fe::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Tue, 21 Nov 2023 05:23:55 +0000
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd]) by PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd%4]) with mapi id 15.20.7002.026; Tue, 21 Nov 2023
 05:23:55 +0000
Message-ID: <PN3P287MB0324E7BD72776FBBC79D2E4AFEBBA@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 21 Nov 2023 13:23:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] riscv: dts: sophgo: separate sg2042 mtime and
 mtimecmp to fit aclint format
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953C6D3C913E4D18B3E6344BBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953C6D3C913E4D18B3E6344BBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [PQWB9DaVwIWMLfRswRqUSmBcBVJ81czq]
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:d6::7)
X-Microsoft-Original-Message-ID: <3b6ac5a9-ecc5-490b-879b-fab564557922@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB0324:EE_|MA0P287MB1708:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b7283f-c936-4a55-fe81-08dbea520e4e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/WBrUozWE1J0dLVXL1xTnYqKSYh2FIdipE8sQfXyQPEb2l90a++FRf0/kCgG6IWA1Hc66kVcM/wU4FDEGO8LgYOeZl7fLIGQ8FnA/L6InPfhrVlFVRjxTtCCiLEKI0KtnRhWyGlFmJyaEPsnXVRflSoABsX6HEwD6NCPe9e1J2SqCwYiQxeYzWooqq9ad6GQ4pZ7pEmRYXS5eYP28gWWJtTtL81WxjzysTIJeTozK6R0rgd7qxN+uN9PusJN7dRBqbsQqOJHrOFoEn7p0pTbiieUGcJ/0i8S8Dt71sjFXfcUiolm5W+jrMztZtRKFDaTSOwPHred90NnQ3AD6kMbBKFxLyqNiNsdwlFO0IruBUQBGRAl1lWBOoOk7FmpCO763qQqbw8Kb60V83QfQrdHCCBWe7jok//kpIK1IymrAPr2JXAX2tmQYUA1qlIA3A0xnJ7UCReFR4szgBwD1q99XHhSEVapbM02btVKtmnXfUP6fnvfHLwv3B9cIvmZSgr37jAJPWIpEQVw/JpYAAqB577Kga+1NrQxqrNMTz/1zX7S3G69qCf86Z0a5ahKPcC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1k2aEUxZ2tMMjRiQXQrUVQ5dGFUY2tORE9NeUJvUVllTEtwN285dmtzWlBS?=
 =?utf-8?B?Rjh0L1Y1MWluOU9JNCtqSmZoZXBFdXRUdDFKVG9yRnNPQ2grOWFHOU1XTUNM?=
 =?utf-8?B?ZjJTMndiTUFyNmJaS2hmclprSUFjSUwyM3RsaXRSQTE3ZFJpdFYxVDNyUmtB?=
 =?utf-8?B?SEhNSXdKek9tcGlwbWVEYVZWNFZxRm1hMnJrL05CMVBwQUhwemV6VDQxRUpz?=
 =?utf-8?B?bzVnQVNJaVU1bldxcGdSV2FHdStPL0NoVkE2akF5cVpQaWJRTXJGZzR6SlNm?=
 =?utf-8?B?YitWbzhuYmFTUk01V2Z4VUFOYWVTYWZXckdXV3lHaStYMGNaOHpBVjQ1Sjhr?=
 =?utf-8?B?TXNKYWQ4SGxGNFdVU0pVQWZhR2lJMEQ5bzhiQzFBS0lsKzI4akR3MW1zMmlW?=
 =?utf-8?B?d2wyclptOVZkSkVPbTZ6UWF5UEMyY2wvUnJNTVY1ZlVaVFFDbGVMWnkzdjNp?=
 =?utf-8?B?VUtpejRUQXc3NGthWWhZS0hWbUl0ZnZWOW1ycGRvdllpVk5hcHFvV3ZadzZt?=
 =?utf-8?B?N2JMR1N4d1J1RlQzem9tR0RNWUlvdzF6b2wvR1JCcTJFVms4Y0FiRDY4M25t?=
 =?utf-8?B?bWxrZXVHbURBaXdzdkQrZGJ2MVNURG9LRDRDWVdqQktyL3EwRVhkb0hCVzlU?=
 =?utf-8?B?MG44ZnRFQWxGTHlRUVZ1bGpFbEp2ZWoxWm4rZnByNFh5MXlsSHdkMXdwL0dO?=
 =?utf-8?B?WGdLNEFzQkVPWXhaTllYM2xPWWpHRkNWbHN3bmp4WlpZamZoRHRqREJYKzNi?=
 =?utf-8?B?OTM5ZVFnSmRYVjduWnR2L205Sjhtc29DYVFWRE1NTDh2RXQvZFdhOHNqdmg5?=
 =?utf-8?B?UW1EL0pTNzFmN3JDUFVSbFErRmM4Tjl2M2ZvNUxjSHc0Z1kvUEpvWlZodkR6?=
 =?utf-8?B?MFU3Z0svbEJjcW9sR1U4QTZ1eUtMaEFXcU5nZUxwckNLNXhrVW9Pb1lJMDQz?=
 =?utf-8?B?MnZ2YnpabjhhamM0MFE2bWxOVldGd05lRGwxREFwbTgzT29JUFBtOE1UMkhs?=
 =?utf-8?B?VFlHMjRybmxKa3FkRDhoa3ZKdXNrNFVVRWFXWElKcWoxS2d3N3YyUnFGa1Rr?=
 =?utf-8?B?cUIzRklzMkdSSHBJZEFSQ2RLVjY0WUJCVGx6UlpDZUlyVlo3Tmk2MDZlTSts?=
 =?utf-8?B?QS9IZjVzeXk0RzVWN3NvZUJscUhaeUx4ZktxeDhZbjRyMmpvbW8wMzArYmt5?=
 =?utf-8?B?d3IyWVFLR3IvTERBQk1TenRQSHpaLysvd2hJSDZ4QTFVdmI5V0ptaWR3VGlH?=
 =?utf-8?B?U1lrMWtkVVdRa0d4eE5HL0lnVXhJZDBiNndMemhUZkhIMWpydVA3ZXF1NUNj?=
 =?utf-8?B?OHpid0ZMY0VEYThudUNjTzZ3My9ITHZBU1ZKZUJxQUVWTTFScXdSdHVBYTVp?=
 =?utf-8?B?dTNSdVFMZGZXYTB1ZXJBZHo4bnV3dDR6T1JybVFyZ0htVjNPR1FvRkZyTGJB?=
 =?utf-8?B?WVdtcmdrTXpLT3pySGJSVThYbzE0OStuV2xLeDlnaFIwZGhUdW1JWGRMOTlU?=
 =?utf-8?B?MkVrOEQvNTJneG5QZVFvbEtkeW1qYkRWOWlsOHd2dHZGVkZISW9zek9iZ3Vq?=
 =?utf-8?B?RnZTcUlxRzFsWmkrYTQzWDR4UDFRbTBybEF1eWJCK0VDWXg4dVdxaDVWR1ZE?=
 =?utf-8?Q?D0akhX1RFy+c7u12aqAswYB9vWTOf4yqcasvoK5LgyBE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b7283f-c936-4a55-fe81-08dbea520e4e
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:23:55.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1708
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/18 15:10, Inochi Amaoto wrote:
> Change the timer layout in the dtb to fit the format that needed by
> the SBI.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tree")
> ---
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
>   1 file changed, 48 insertions(+), 32 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 93256540d078..ead1cc35d88b 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
>   					      <&cpu63_intc 3>;
>   		};
>
> -		clint_mtimer0: timer@70ac000000 {
> +		clint_mtimer0: timer@70ac004000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac004000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu0_intc 7>,
>   					      <&cpu1_intc 7>,
>   					      <&cpu2_intc 7>,
>   					      <&cpu3_intc 7>;
>   		};
>
> -		clint_mtimer1: timer@70ac010000 {
> +		clint_mtimer1: timer@70ac014000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac014000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu4_intc 7>,
>   					      <&cpu5_intc 7>,
>   					      <&cpu6_intc 7>,
>   					      <&cpu7_intc 7>;
>   		};
>
> -		clint_mtimer2: timer@70ac020000 {
> +		clint_mtimer2: timer@70ac024000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac020000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac024000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu8_intc 7>,
>   					      <&cpu9_intc 7>,
>   					      <&cpu10_intc 7>,
>   					      <&cpu11_intc 7>;
>   		};
>
> -		clint_mtimer3: timer@70ac030000 {
> +		clint_mtimer3: timer@70ac034000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac030000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac034000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu12_intc 7>,
>   					      <&cpu13_intc 7>,
>   					      <&cpu14_intc 7>,
>   					      <&cpu15_intc 7>;
>   		};
>
> -		clint_mtimer4: timer@70ac040000 {
> +		clint_mtimer4: timer@70ac044000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac040000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac044000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu16_intc 7>,
>   					      <&cpu17_intc 7>,
>   					      <&cpu18_intc 7>,
>   					      <&cpu19_intc 7>;
>   		};
>
> -		clint_mtimer5: timer@70ac050000 {
> +		clint_mtimer5: timer@70ac054000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac050000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac054000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu20_intc 7>,
>   					      <&cpu21_intc 7>,
>   					      <&cpu22_intc 7>,
>   					      <&cpu23_intc 7>;
>   		};
>
> -		clint_mtimer6: timer@70ac060000 {
> +		clint_mtimer6: timer@70ac064000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac060000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac064000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu24_intc 7>,
>   					      <&cpu25_intc 7>,
>   					      <&cpu26_intc 7>,
>   					      <&cpu27_intc 7>;
>   		};
>
> -		clint_mtimer7: timer@70ac070000 {
> +		clint_mtimer7: timer@70ac074000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac070000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac074000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu28_intc 7>,
>   					      <&cpu29_intc 7>,
>   					      <&cpu30_intc 7>,
>   					      <&cpu31_intc 7>;
>   		};
>
> -		clint_mtimer8: timer@70ac080000 {
> +		clint_mtimer8: timer@70ac084000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac080000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac084000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu32_intc 7>,
>   					      <&cpu33_intc 7>,
>   					      <&cpu34_intc 7>,
>   					      <&cpu35_intc 7>;
>   		};
>
> -		clint_mtimer9: timer@70ac090000 {
> +		clint_mtimer9: timer@70ac094000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac090000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac094000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu36_intc 7>,
>   					      <&cpu37_intc 7>,
>   					      <&cpu38_intc 7>,
>   					      <&cpu39_intc 7>;
>   		};
>
> -		clint_mtimer10: timer@70ac0a0000 {
> +		clint_mtimer10: timer@70ac0a4000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu40_intc 7>,
>   					      <&cpu41_intc 7>,
>   					      <&cpu42_intc 7>,
>   					      <&cpu43_intc 7>;
>   		};
>
> -		clint_mtimer11: timer@70ac0b0000 {
> +		clint_mtimer11: timer@70ac0b4000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu44_intc 7>,
>   					      <&cpu45_intc 7>,
>   					      <&cpu46_intc 7>,
>   					      <&cpu47_intc 7>;
>   		};
>
> -		clint_mtimer12: timer@70ac0c0000 {
> +		clint_mtimer12: timer@70ac0c4000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu48_intc 7>,
>   					      <&cpu49_intc 7>,
>   					      <&cpu50_intc 7>,
>   					      <&cpu51_intc 7>;
>   		};
>
> -		clint_mtimer13: timer@70ac0d0000 {
> +		clint_mtimer13: timer@70ac0d4000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu52_intc 7>,
>   					      <&cpu53_intc 7>,
>   					      <&cpu54_intc 7>,
>   					      <&cpu55_intc 7>;
>   		};
>
> -		clint_mtimer14: timer@70ac0e0000 {
> +		clint_mtimer14: timer@70ac0e4000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu56_intc 7>,
>   					      <&cpu57_intc 7>,
>   					      <&cpu58_intc 7>,
>   					      <&cpu59_intc 7>;
>   		};
>
> -		clint_mtimer15: timer@70ac0f0000 {
> +		clint_mtimer15: timer@70ac0f4000 {
>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
> +			reg-names = "mtimecmp";
>   			interrupts-extended = <&cpu60_intc 7>,
>   					      <&cpu61_intc 7>,
>   					      <&cpu62_intc 7>,
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> --
> 2.42.1
>
