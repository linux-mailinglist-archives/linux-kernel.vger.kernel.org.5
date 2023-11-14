Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C077EA813
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjKNBHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNBHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:07:11 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2083.outbound.protection.outlook.com [40.92.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0CD5A;
        Mon, 13 Nov 2023 17:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3DsMIn1c5MrioIy6jOks30o8JhxPCNdmqNGNRfEKSKJ+4R/a6PKBgxzs3QEQ7OriFrtp7vdtXLmzRqzwR9W6uqdAQKA3KppsNNiq1VJ3Q8CTjGypmcJyaZz0fbQXLCMDkNUvvZj1+L4co5lp/GE3dX/56NMMuKjloGuET812f59LB+/b9B68UaZP3PexhsUlrZKVvBBlxH3p6KCKgT5Frg0HtTPQw9vlLNeSAb0sj8aVhtcBn3oBAdQCnJoWlzEs6yn2xTjelZquF9B1/heMyJqlUbWIqMGUdkI6vsyKaSE5aDwXEDpOmgSnDn8geEQewkQ17KcIz+TKMp9qKCUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqORvdgMYbkAmzTQOm0j8n6D7aPAtaP/eNuyob3g8Z4=;
 b=abeReScx+mevYJaiam/imZ+KyK2lflS9Ai1MiAXXvK0APFPoca3PavT1G7Yaep7N4cSn1WUuIx6klBlMdnp2k7TOvW5J/VWaO2rgGn4L9tKSeoow0+/oZJ0lueokBeFI6XDswGg2fORyykhlA6CtE/OEDs9kjc+l+byQAOARWFe4izN1fBAjVfRADqOAauvYW1wykCjXgdlg2XvMpsHQJgRRBne72t/ZFFAC98oMT80GIKfTJ8Shwa435xts5mq1VkxZNRFgZglL4YtCMLJ461J54JaHYts6GyfGTmnQouX/KBBpaJS5b91oeRqR9PVlj9UsucFPUpRGFZ9nedBuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqORvdgMYbkAmzTQOm0j8n6D7aPAtaP/eNuyob3g8Z4=;
 b=ox4myKBPIG/OgkJmimCE7yALco1Lc1UrKidxx2rg4RdgqQrzSXLUIuU29J4PjMrOIZKpa2notJnSJgnwllfS4d8iA4wSMCDeHRugrax9WYtsrdHG5xPe+7DZYiIJ3Sx9OV76qdJJmpWgr5A8cMctyvgKVcVzg1PDRkEDkngXnpYE/F8oz0A5GSYEu0zo6t7uETYZPxFQhGw/dqwQa7iMD+7iekcwHhMKLNOpAQecL++ItcErj/d2bQZ0GFm5Dq3+0pXAd+lLlsydVaZWMQMgJuQ9fhB5bc1bN2Y+pv8DyLxerXvSbO6Wyi6h31Trhsn2fC32cj8bmMeZTwW7wdLz0Q==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 MA0P287MB2474.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:139::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 01:07:00 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 01:07:00 +0000
Message-ID: <MA0P287MB03326E8AF2EA63CE8CF108CBFEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Tue, 14 Nov 2023 09:06:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: dts: sophgo: separate sg2042 mtime and
 mtimecmp to fit aclint format
To:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Cc:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953B943AF1B43CD1EFD7BC4BBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953B943AF1B43CD1EFD7BC4BBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [ML+9KNToxo9mw+TbJ97mgo4pqZHPKNfp]
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <bc5c9495-3b86-4801-950d-caedb176df56@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|MA0P287MB2474:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb4f3a6-b427-4256-0e3d-08dbe4ae008f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24yBhlYOlIo9riloLIt+4WTba09959HUpahqRaX0axvXfkEEWimLlJB1QHlvW/xw9Lepf98cosh3KHH4N8YecnugK1RXMB+oHT2i4CyZ/NFgrtcTV6COSWXLa7ar2EGu7Nw2zhG6SAfbs5+SGSmG70Ho+myN5qNErCHNO8cpmeKo0tR408Y3i0sr2unJ7wn1pSVrVF9PsgzNQDzyLvfadG9b+HwtIqcUAKSQOVi50lJgKw9hfk3sCje1XQes+ttoLPgu8KEG2UB86Gr2EIsnf5zhex30n5dZrgXgl5S/ldg6MtUARmtGNxo1JwZfY3/5EryOCSb2AQfIpwoQkOh3GjG9TL1rw5+rpEjhXP1wfBzkXDEuteYNpVa6m4adogb+ZQ30u30hDEwQn3uJ561vbvQB1foJ3u6zLsCQNDJZTFS730FzEqSf57ucYgIkcvhQoxTsg9kbDwvoD5dW8GgnJFu7+lKwfF5FlOHsmHSRO0KOrdR+NX8/8Z8Q1ivXwiZ47qYTN/jlXcY9urOZrQ4oNWzlgAs9In2soy/BWY/DBhw16FNm/vfZZT9D3yi/PLoW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZvSVJCRDhVb1BzQXM5THk1NDY1MEVOMWNPKzF1ZHpiYWNoZXZCeUVWZllq?=
 =?utf-8?B?dEFLcy9Jd21NUW1yZ0hBL2sxNHNiNHhSdWFnUklhVGQrUFYxdjZXa1pTbTUy?=
 =?utf-8?B?UE82NXVMYjBBcHBSbFNQdFRZOFI2SHJMYjlEdG54ZzRPUFowYXN3RFM5YXBI?=
 =?utf-8?B?Qm41bWVtazlNcy84b0p3Z294eGtzNUptR3p0MFZlS3ZhUzlsR0IwdVhHRU5R?=
 =?utf-8?B?RlZueUhVSjlQTjJIWTZtbFFId3FNU1NyRlI1UDhMZEFydHNnbkhRVzlJWWNh?=
 =?utf-8?B?S0tPV1NJaXlPWEYvc2lBMGRpakhqWWgzdEgxSEpaVk1TL2oxVFJRV00zbCtT?=
 =?utf-8?B?ZTh2VFNMZDNJbWYvVzZIdkJZYUo4TGJPbUViVkFobXJITjBWTG9veFViTlZt?=
 =?utf-8?B?TWRYUWExekFxWEJ0MlZycjBZc0RDTGxQd1l1eWtlRjJKeVNoSlhEbklTMEV1?=
 =?utf-8?B?U3lmZTdOenJtdVBkU0tRUE5TeUJsSWppQTRFeUxnbWRSRzRKK1huN1JOQ09k?=
 =?utf-8?B?NEZDRUVJSjVPTTF2WUZCbEl4N09yS0xGc2pRSnJETloxL2RqYkNlQWNaSzF1?=
 =?utf-8?B?TjFUUytqTy9DSFRvdnBPT0U1MGJKWlRCL1IwTUJTR1lRbnVtTWxBQW9JZnhH?=
 =?utf-8?B?bUd3NVVjaHRha2htVG1JMnRoNXRyK1ovUzZpYzFPTlU1ZUFoNnlTMGRPK3dv?=
 =?utf-8?B?R05yb3U1ZmdESG00UE5pL2N0Ylk5Q2NsMWxYcWlCOWRncndHZE1MNGpkOHNa?=
 =?utf-8?B?SG91Q2JiOERPdlh0dGZNUFIyMCtLK2x0WFNXYndTYXJxZ1NiSEZZNWNhNFdT?=
 =?utf-8?B?ejBSMUNpWUVwR0RNTExuTjBGTmZyc3VZUUIyWS9CeVVTQ3JaR1A5QXpxZys4?=
 =?utf-8?B?Nkw0UFVrVHlmYlEzN1JaOEpxbUE5dGwyMnU3RmFKOTJCZzNtZ1ZpVkQxSlVx?=
 =?utf-8?B?cFlHdVZOenNEMERQUXlybkhpQ1JqdmxQeDkxaGd5OGo0akF5ODhvUysyb1V3?=
 =?utf-8?B?OGxpUHdNRnhleDNjQTFUVVJEOHk2SGx1UGJwZ3hCUXljNnV4NHdYL0RYUElq?=
 =?utf-8?B?cGpNdlpyV25SVnMyejRTQWtYOVZIczNickdNWXc1Y1djdFRNRWtrSzJ1UDdX?=
 =?utf-8?B?ZENqWnROdkdlakxMdnlwQUczVm1KMlF2MUtSRWs3QjdURzNwQ2xJMituYnVu?=
 =?utf-8?B?cnE3U2hOTE5DcVk0QnhrTk5yNWRjQnNpWlJSVFJnTTZIb2EyT0FIYzdnM2c1?=
 =?utf-8?B?SnlMWGs1OHhxN3RJZmV6VmZvdDBodHlEQ2F5eTdGVVdySGEwMDJDMmF2bFN2?=
 =?utf-8?B?R29OTlNDd09JaG5wYXdRSW4zTmpORGgwc1JYazJjSlJhdEp1bVN3VklpdW5R?=
 =?utf-8?B?b3Z1VDlweUpYVStzNDBDa0Q2VUYrcWJVdnc0MFFOMFdFbU52WnpUaExqYkNz?=
 =?utf-8?B?d3JXZlhtY2k3ekxFcWpyeFhiVWdiSE10eWJjY2EremdsL1NRV1I5dlk3T2JN?=
 =?utf-8?B?YVpHajlRMWtwcmFNbXZKaFlaWXNFcFBBMFBFZTJ0amwwUnZBMkkwRU52RTlw?=
 =?utf-8?B?a21QWWFjZ3VpRkovMklqb0FCZ3FqaHlBRW5peFNpcXJ1d29wMmpDTzhESEFx?=
 =?utf-8?Q?L2xe/v8ghZFF9skwptjAdnrtDuMOd2WZJHJXW/5gPsuw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb4f3a6-b427-4256-0e3d-08dbe4ae008f
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 01:07:00.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2474
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/14 8:45, Inochi Amaoto wrote:
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
> index 93256540d078..0b5d93b5c783 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
>   					      <&cpu63_intc 3>;
>   		};
>
> -		clint_mtimer0: timer@70ac000000 {
> +		clint_mtimer0: timer@70ac004000 {

The address of timer register is changed,  and I guess it is another 
change not directly related to the topic of this patch.

Can you please add some comments in the commit message?

>   			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
> -			reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
> +			reg = <0x00000070 0xac004000 0x00000000 0x00000000>,
Why the length of first item is zero? Can you please add some 
clarification in commit message?
> +			      <0x00000070 0xac004000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac014000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac014000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac024000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac024000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac034000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac034000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac044000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac044000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac054000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac054000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac064000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac064000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac074000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac074000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac084000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac084000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac094000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac094000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac0a4000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac0b4000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac0c4000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac0d4000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac0e4000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
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
> +			reg = <0x00000070 0xac0f4000 0x00000000 0x00000000>,
> +			      <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
>   			interrupts-extended = <&cpu60_intc 7>,
>   					      <&cpu61_intc 7>,
>   					      <&cpu62_intc 7>,
> --
> 2.42.1
>
