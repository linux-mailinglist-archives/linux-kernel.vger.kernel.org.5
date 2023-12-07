Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7580862C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjLGJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:42:44 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2022.outbound.protection.outlook.com [40.92.23.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B321AC;
        Thu,  7 Dec 2023 01:42:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiumRbEqC1SzoAC+D+6+i9oiJWPRraJUNBxvfe9ASOh4mFrQTZBSueJUHzea7eaW9n4SJO2SUM8ZuUotxlPVVOVycyUx1NML9kr7xFzZV3oW/ws5xaYNs3K8xt4NIIdgIzNlKrkBdfytE6RW5bCbpBRt1BnB0hArGNsF1QcB5hNe0gRwDGpzgcr58cAOJZEY9LQOdsRqyqgbSxM3nN3aTyxVxlkkpSRZxvDg5ZPJwk/CCRkz1UONE5cypdgh7mlUS1sk0QAXuiPJY6nUW5cD3CyDrBm1Yzh2HBKG12GT6Wf/mWzH7Bn0TjFHYM1Di/Q5Y+zK+UXLfacCuiSta+wnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX3XkRp3/VRyxwdQXJkyluoK+kiDhhrf88QaGWutMHY=;
 b=NdnhloAsdAYlGZQV8GgDMvmnmDIkSZjp1hj5+s+O6YFfi94RKzSIyNVo+8+iO5zbFgvXbm8qxCk0ZOgetJROZXkap2yzYTmM4BdYIjIxLjS86GIp/5411BNX3KrOK3OVfcUTm6Q7ufZUoFHPFblgjXXZtlkejXElGcgJBl8hLNtsOqmgaSNVKOHbLFPDCaANO75HYEBeypVwW7zj07iVMAkS/08wtI+zrIft8bfPXaJ8AGOv5HtKnEewsW7Kn503v6+4zSroR2p6B2iqP1OG358+g8O4mGGBmQmxYbiXPVPJtYy5Rac2CgzgU0QXUKgpmyDubc31EI1Q5+k/NpKG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX3XkRp3/VRyxwdQXJkyluoK+kiDhhrf88QaGWutMHY=;
 b=gU6hcHtRUtAPuEIAvvbfo10ccSr+KJoL5CWMUx5F962hVL5u3FwH7aW9TpU8qMJNkgS823o8N3egSMDk/X3B2FnT3vb5ardi/H8Fqy0mjbtXkPanaNB7ByyuSRlkyBqhXkecpHDZVLU8h8GKAl8QTA2tkW6/dB//AW11dHc053cLm8Hgea9t39mXWiTZFU3je7uSXfcUqewotS+5AxhRtRbEsx48qV7DURaLv8runfEhplOp47SrumnMdYAgNNcT0I56BXIwogCwX3xnUHzeDQY7SOydPQJ1V+0mzCK0g/oCidCziWf4mFwgYJU+TYOvnrd+qGVDv3zK1oDsaPfA6A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5436.namprd20.prod.outlook.com (2603:10b6:806:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:42:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 7 Dec 2023
 09:42:46 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Liu Gui <kenneth.liu@sophgo.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        qiujingbao.dlmu@gmail.com, dlan@gentoo.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/4] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date:   Thu,  7 Dec 2023 17:42:40 +0800
Message-ID: <IA1PR20MB49531D4EFD4626834B5C604ABB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f9db367c-a96b-4789-9884-f2062499765a@linaro.org>
References: <f9db367c-a96b-4789-9884-f2062499765a@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ypxpWER17HkRn39YM82V1ZRSccTMiSKur+j2azGot0M=]
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231207094241.901455-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: e78b8317-c46a-4cd2-11cf-08dbf708de06
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XP/iClkC7YWSExQals7psXtyAh/0eRW/BYWg6ZFtcfya7dFJBzgizh938oHmhH+H0+eDNGzjuF0baJzrjI40n/AXa4Jy/OkbuBWUy84xTc77d/3n+EDDRcNqxRaJiIKsiwaaIkQ2Ufrq1P1yE1QV90Wp5C4K895IDPF++3XX8xR+g/lYAoIIrRvsQAJ6DvtAXMjNVDb9DOBq6gqoOymhYqqiEOmRUpsfoq8grLP/7N4rU1lD+BEgr6OX259IljobYxlpm4hEAbCREMwqfqMCtT4Tr7O2imf4nIQHrE/D5udLg6gEJ5iZwH1CumeJfbIOHB3VBmpTiBYNuOckVmrsH/QOeNNAoeb9NOE3FhdGC7Pfsiz8BtuZMO49/j61BkylwHr83474cti1l8VbCjPRb3hMZy2Qw6MI8RuhUrZ+kHVBefX6JdjyeVj8pNQSKiINwnipeMDKzVGWSanS7YvawytQgjKe/Y1XuSp53YpVMAJtxzKAfOoc9m3+vldQgYHu7y/c/qBaPydBtHJe71UTSOxFujpwGIOefSpdehGerWMAbBlBPBkj9uSV+UXUAgSrZazH6qusg9BQAN87Qhp3Z/cvMccZMzKyU89RlfLvqhwIWom4WLo9dkvlEql2P4Pd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SizSLvF+3l50RpYEMP/hdu/Tf8O7SXO2VUwbUxE+n7TdC7cvjllb0thhotxg?=
 =?us-ascii?Q?B1HgaBOSNMKCPw/+w+3jaOJIeEu3lOAFAGkxEIVUcoRvfd2QoJUSQyKXdRkf?=
 =?us-ascii?Q?ICnXz+lLqlWcHhImCG3BL3o3uWYMBEi9LWOxug40TVB0t7Tkzvkg2p54ZgJe?=
 =?us-ascii?Q?aKrbCQAguvX0El3Uo6nZ44a33b/H2XgRHDD2U1ugUHczIM0fmTM56hn/iGwu?=
 =?us-ascii?Q?DvEHfXlJUAELsfhmv21nrAbn+kjxif6fuMR/Op3pKUGNU1MhZvobI2rUJmyz?=
 =?us-ascii?Q?6SPYXZUAQ6qo/ljcSWyUE3NKvgcKp4mfaeKgX3zTGYvUVgIKBdmRNE90wV4c?=
 =?us-ascii?Q?ZhnAHDlIr2X/LzLbSO2hAPNYmBLjzxi/Fj+h1/1kZrhQY+9tzObeWV9dS/MM?=
 =?us-ascii?Q?1z4a+vA9YWrh19MgdwIhqY5VqPfgN5em/bemvWUgRjuLflh7490y8TfY7vOp?=
 =?us-ascii?Q?fesnzh3IMla98pDH7j+UCAinCcENz3EjObP1kJyIrzDvSwfNieAZQV3ISDOX?=
 =?us-ascii?Q?CuM7WJv2VcYjmVDBPbL3VoDMNjN1CEl4kXPueUab981Nglr6fNmhPFJOvKKF?=
 =?us-ascii?Q?7QgjMiIbD7w4TRFpPGjIZwGgrwvTPk4MPGfUzVT0agh80Ov7Vx5t4uLPe8IS?=
 =?us-ascii?Q?SLaExPf5XcBfuJJRFWmwEV4l5K2jnAT7nvNl4sSEwtq7/aFZ4dkE0rWQDKov?=
 =?us-ascii?Q?IBtRrng9fE7YivXv5+UWCHyACqrLBba42CRbLZhIE5ug2UVxF7wLnUNH4ga6?=
 =?us-ascii?Q?rri4urn7O4nMGFJlN7wt1DN54aQO7gwzmuoU/A34wvtzftyKKvgaw0l1WK6+?=
 =?us-ascii?Q?Ir5x5UxS7peY+D1DYIozHEEfI4Io+cm8EaUhfXRDQDiUCrnS0SxzWeQyGuFx?=
 =?us-ascii?Q?IgCYHms9sVvnGWZwv8dExg8bmRV6H24slecra5XtD2k8Ml865YrHXFUBzjmu?=
 =?us-ascii?Q?8F6FZrcraq56wgmAic3SAXdewcpGOyka55ryEwf7f4XMk8iwhEsqmMd9zfVl?=
 =?us-ascii?Q?JlpVFfXxXy8ipYBkyddCzs7c71ywFlPhgsU+H088Bvc2FmTRvUAKfR2L4IZm?=
 =?us-ascii?Q?0w6CuzmKyrPJDb0qQuzLKrnhhAidHmiVtkRf8HcSbXL4EmhtcLOxFV+vOtTT?=
 =?us-ascii?Q?2FYVpds4eDc4N6lthxH9LodEPSkt02vFVXS6UOUE8yBYP4/ymWpeNXlnLUYy?=
 =?us-ascii?Q?a4tVU2bjfF0MVo/Timg5BkxhATs72WVpjp2X2c/yEydCbnvOwudXCDmpYUc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78b8317-c46a-4cd2-11cf-08dbf708de06
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:42:46.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 07/12/2023 09:37, Inochi Amaoto wrote:
>> Add clock generator node for CV1800B and CV1812H.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> ---
>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
>>  arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 4 ++++
>>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 6 ++++++
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> index 165e9e320a8c..baf641829e72 100644
>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>> @@ -16,3 +16,7 @@ &plic {
>>  &clint {
>>  	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
>>  };
>> +
>> +&clk {
>> +	compatible = "sophgo,cv1800-clk";
>> +};
>> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
>> index 9a375935b00c..83243c918204 100644
>> --- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
>> @@ -21,3 +21,7 @@ &plic {
>>  &clint {
>>  	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
>>  };
>> +
>> +&clk {
>> +	compatible = "sophgo,cv1810-clk";
>> +};
>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> index 2d6f4a4b1e58..6ea1b2784db9 100644
>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> @@ -53,6 +53,12 @@ soc {
>>  		dma-noncoherent;
>>  		ranges;
>>
>> +		clk: clock-controller@3002000 {
>> +			reg = <0x03002000 0x1000>;
>> +			clocks = <&osc>;
>> +			#clock-cells = <1>;
>
>I don't find such layout readable and maintainable. I did some parts
>like this long, long time ago for one of my SoCs (Exynos54xx), but I
>find it over time unmaintainable approach. I strongly suggest to have
>compatible and other properties in one place, so cv1800 and cv1812, even
>if it duplicates the code.
>

Hi Krzysztof:

Thanks for your advice, but I have a question about this: when I should
use the DT override? The memory mapping of the CV1800 and CV1810 are
almost the same (the CV1810 have more peripheral and the future SG200X
have the same layout). IIRC, this is why conor suggested using DT override
to make modification easier. But duplicating node seems to break thiS, so
I's pretty confused.

Thanks,
Inochi

>Best regards,
>Krzysztof
>
>
