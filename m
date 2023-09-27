Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC2C7AFEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjI0IfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjI0Iei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:34:38 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2025.outbound.protection.outlook.com [40.92.102.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A9CEC;
        Wed, 27 Sep 2023 01:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM8kSHlOGhXeOSzn9Jk8ejFT+DGOe5kF7s2CCxRcrRH+2zcPOdlMxp/zN5sm3V5lmKPZwSa02v8VSHt4b9YX2/GT2GbOu7kxmFV9xyzADVAqV440apO8AQ4zvd0ziXtD4y+44+KbZliXtcoIEhkfpRkWlIvyZF2hzOvarp07uEtu4jogwqckbeL9cZMVXlH+smWynAyr0Lay051Q5+Z6lhxpCcWYa/TQYLzHnLPBCVuK/u5Kauju1T7lyXibgPZ/kEM22Gwap87SrzRZ9b8qOCG2ec/i+xg22TkqfQx2+zhHbP8dkHiR+In0miaefhsqC41zKvrGOz06TLouGlevgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvxgenKQ4s+a8qaBuCX8J/ixWtMbdrgKLwMy+WHbVRI=;
 b=GiJLMlCKyUBcdM4mlb/sZ9bErtT9rd+tfggat2DCh8cz1zlXjSo9T1Z7TGxsudR1YiPLBvMjIxu9hW27IPbAb3FeWIPPmSXeb2rGkA4cU0XiB/184kvVl+/RdOY5XLXjUWiQLTVAbE5dpfCfLiaTSn+z20itWNJuoPzk30dessvWHnR3K8XNtPP9YjJjHazei6McxHgPjcQOMiNU/YDsXDYFJRdgQBg8tS699Ru4jX/mSBCnUWR/qrE85vdIvb/TUeep4LWlCJAXzMLnZVxo0dU2zm8aViAXwUC82Jupd+r8AZu8yEo23f9KQ+cI4oBjManbqLrp4V9kiuql7pBI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvxgenKQ4s+a8qaBuCX8J/ixWtMbdrgKLwMy+WHbVRI=;
 b=hbg7W/6C1D0n6xs8vRjInYBUHJ6+kpdrrPTPiWlAQUmR2+HSVAcN0+TtmfIl0AWMKNUHvIlkVLo1YftoRqikuiUsC3Pj7MKhk2VpEC9NKhAAoxiGKuDy03fOhIB1HrL+gMg2UORu0AF6eFg6/AdJKLL6AIr8hX7gsbeNN1UlzUW7ENaAUI+x8KUmQUViKMLBJgJgMZYkpfjlV3BaiIm6y6MCss1CKgb0xQeN/yv9Dic45kgfdDrJOcKzI4kuooc1ohohv5DVDP7tHB4AZy6oWNSlqiL0/YMytzIIpqlAiYlU0BelpwjuvdruZu0sTaOpSVy1SP1WTkqzGaekWipuIg==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB2035.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 08:33:47 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 08:33:47 +0000
Message-ID: <MA0P287MB033210178B596249ECBC7F8FFEC2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 27 Sep 2023 16:33:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] riscv: Add SOPHGO SOC family Kconfig support
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
References: <cover.1695800389.git.unicornxw@gmail.com>
 <bfa07dce9eb268b312bd64059773acf055727f17.1695800389.git.unicornxw@gmail.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <bfa07dce9eb268b312bd64059773acf055727f17.1695800389.git.unicornxw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [fq+dl+4kbWfmXncgSeQuIMvH5gyXjcOg]
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <99219ea9-c817-441d-b412-7eb25f4ba1bf@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB2035:EE_
X-MS-Office365-Filtering-Correlation-Id: a13e8ed6-800b-421b-c661-08dbbf347793
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zlk4A6YUFrZzCSPSFJ63jl6kLsAbJW5lSap3fuwMMcoxCUZyK2stzaHfJf7xUSjs4CmUPw51eN4OApUX36V4bE+7Dut/FMdibSj4d4cZP3rFesRIWf0OCPhY2z0bxdbWBXZUGQuvXYvXpw8e89i464cwjv+xpWHvqXyYPCqUNb8aA9/njy8+k3UezihVcndBvxeAGwtoz4Z7L0nhV26pxaN68tzrYg05ft9HY6M+b+9FDKiVJekP2q0pYNQK34N8eucBfevzHOb/EgyGynkS3UPIxruuTXNRXlpCyo4LjeQ0gm2Ar6bRThy5/PUrqfnhbzNUzIFdncPFl4v7Y0PWPRCKL52fHD3YZpEDT5t+M94y3bws1WbNINX/1w8ZC9uQVHLq3s0LBHqq7ADIVuaC09IcWRW0xMmAKQIor+7fSGpDgF99bNbfERQP1O9bnpTJrYvmW1pILt5SZqB9gXhzlrFn9XRQ3Zn/D6ih0d86Hx+IJ0xQBmU2jxKhgsUVyuMyCR+ZUDadsgs2eJVMADWc+phgR8qL2Vs3oWwWc/0TVW8d/HASzToLk6265M3fFYwr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODNmblNRMkdoVUdEV2dBZGFnMDAyVUxnZjd5QmJXdHlucUVlVzJpdEtUd1I0?=
 =?utf-8?B?NkV2eUg3WHliczNtaU9jeEhYbkdYMEZaVW1BZUtyb2tnbGJPN2N5VlJiZXAv?=
 =?utf-8?B?WUVSM1l4Q2U1djVaTjd4R3E2ekF0cEMyUE1tN2h3ajRhUWgzbmp6TFBGbzRr?=
 =?utf-8?B?UWI3bkdXelJXMFpwTWh1Z21BUU1QeGVlV3BaVlZsdUZBMWxJcHFFaFhJRmRH?=
 =?utf-8?B?SVJiM3VTaWJBeWkyVEVTd2M5djZvWDhodjRmZ3huUkc2SDlpbkJIR1pucVlm?=
 =?utf-8?B?SUswR2ZhRU5hTEhBV3dpTUE3dHAzZlJhaFF1VEd3cm95ZmIwUlZhYjNyT1p0?=
 =?utf-8?B?THF4OC9zNWJ4M0p5aHNIa0ZLaUFNWFllZmNSSU5ZNGdlNC9MYWthSUp4bFFh?=
 =?utf-8?B?b21hdXVnM3VQQzdDZDhCVldVYnNnaGd3RXNDaGpNY0hPank1bmhaa20rWWxS?=
 =?utf-8?B?TEdOQmJidks4VzcxSk1iK0drNWp2L1pRb2NkY0lRb2x5ZzJrSHk4S3ltQWlO?=
 =?utf-8?B?ajFuWHp3SlFuUUswSG5jdWl2MWtpdVprZXFzb0wrOWlwaTRzY2hvN0FqS0th?=
 =?utf-8?B?aHJSWWMxczBxU1kyS0p3OEw0dlVwbkdvelcya0VtUXU2SVlqa0xTd0FMSFBz?=
 =?utf-8?B?RE1mZnVlR0JzZkVta01aM3JNcm5oaG5GMGlzWlQvTjNNTlljcmlDWnRvSVVr?=
 =?utf-8?B?aU5uWEFRNEFRb3dWN2pDUUc1enZpT3FkUnNrSnczTWVudXpmdjYxRFM0VzYv?=
 =?utf-8?B?UHlnQTU0a1IvdmFmV3BKbGhLc3VhdmdQUnY4a3RIK0ZDRlExTFByM05lUlpx?=
 =?utf-8?B?T01kaEZZRVZqaHZvVXVIdVZZemlOdDNvTlVkYnJLOHpsQVBvMGoxWk13eHk1?=
 =?utf-8?B?d2RUSmYybG1UQjVJSnpCaFpNYWx2bnkxLzlKYk5ERU9GZUk2Y3IrZmdLRGFL?=
 =?utf-8?B?ZGkrY1lmc2dVcEpPWWNRTXRRS1BFN255UERCT1pFTENTcVBaSXdpV1I0OUUv?=
 =?utf-8?B?VTFteno3QVVVSWVGOW9SaXl1VXFSMDFUbzB5VnJkczlNdEpmTGFyYWlkemhv?=
 =?utf-8?B?NjhxNFRrcXk1cTNuaUt3L2RsYi9zMXZBMTU4bDhiK1BBbXBHSHkvWE9nb1lD?=
 =?utf-8?B?MktWWWx1UWpDWmo2V2RlU2Y2d0wzZnMrbXhVV1NCMCtSZS9zcjBSdURIcHNr?=
 =?utf-8?B?RW00cUdpVDZCaVlOdkhINDNoOTZaZmdLRmN6eDViN1hHY1ZuOXB0T2hYdHhR?=
 =?utf-8?B?ak9TS3lyUGlWd1ZTVU50ajJIcERxSHBKaUZzbTVPY1pHekVPMWdwSlVMMkR3?=
 =?utf-8?B?VzR0R3JGQ2xJRVp1TWhGTXQvckFPQTc1RVFuSFhlcjdiVWM3alFSdVM5NjZz?=
 =?utf-8?B?U1Q3WitWSnZJMFJ0b3pJKy9KbUFiQ3h2MDZ4RXZ0Kzd0eXFPVUdtcmsyb2ho?=
 =?utf-8?B?YVVpenRJZTd4Wm1CcWJYRWY1SDRLWi9laEs5NkorSFlyR013d1E1alhlNVVH?=
 =?utf-8?B?TUNkaUR0RTA0Y3hmWFlNQ001ZlFXZU5JdGdHOXFGWHlWZEpSMzRuRnhYdzdT?=
 =?utf-8?B?dmhrVnBMZTBoSCtabzlTQ1ZjbU8ybWFKdW1DRTVsU2Z2RU12ekx0MVloOWVV?=
 =?utf-8?Q?+DOlwQ1aYgoBwc75jCGCalhsZNiBQu6/WZhW708nqxdM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e8ed6-800b-421b-c661-08dbbf347793
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:33:47.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2035
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this email, the subject of this email is wrong, I 
will re-send another one.

在 2023/9/27 16:28, Chen Wang 写道:
> The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
> cores.
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Chao Wei <chao.wei@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> Signed-off-by: Chen Wang <unicornxw@gmail.com>
> ---
>   arch/riscv/Kconfig.socs | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 6833d01e2e70..d4df7b5d0f16 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,6 +22,11 @@ config SOC_SIFIVE
>   	help
>   	  This enables support for SiFive SoC platform hardware.
>   
> +config ARCH_SOPHGO
> +	bool "Sophgo SoCs"
> +	help
> +	  This enables support for Sophgo SoC platform hardware.
> +
>   config ARCH_STARFIVE
>   	def_bool SOC_STARFIVE
>   
