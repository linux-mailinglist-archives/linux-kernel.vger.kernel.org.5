Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2895789645
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjHZLZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHZLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:25:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2056.outbound.protection.outlook.com [40.92.19.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD819A0;
        Sat, 26 Aug 2023 04:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROVnb7i4Q6gIlTdeJS+Tm3TAh+THOVtcJ0fEygjB12OJ9HBPJYmsJlDtc3eVLvbifSCPiwAHebclPAMeYb3N+zun3iUtvKnUG0fE0c6TrSc7M+NzTKT7RB5kgTaLiz1D52lQnvLjpvqrcmdev7etVisB+22R6pcWCZRtSnqynUcvb4Q2D1IDguarD7Luo6spovdWra3oXzWJLiUayVrcy71kPlCXwrSBSKDu/FBFQmo1mILXxquUTGeFJ7jZ4VYhsjUFwlJSWdDsMM4a9+axEyfvI5QP+ZNrZKVgBk/uA+u0Ob+Tirr7KUjiDsBrcZBac+UaKXDmBXl8eUAtnf1UKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfBWcWVwTw1TvoG95OBJ2z/n1RzHQQNDC8yDsdwQ/3U=;
 b=gebTyfTH0iWeh2CDGq4FhL/jqYKKxYLcy+KDjZhpAc2znrSDUsAuJ899N99lJXm+gf37DRgU6LNlxnK2bFMSChp3XqUKU/UiB9xd2gbdZFNyZTEpjfzpwX963RRBQlZtufWQqq3wskun5mGEx1Qrf2l/gu3kpV9Iq56HDQjuBtwu4hxknMZ8t/D8ppj/9JTu/T76lZFp7hCLrAQowwb1kCdORZlcCjABIEL/Exh01a81zlSG+OTU32+EGyPdEV922/5GnQC5Pilq57EEMXs7gvO6xBe2V5W6xEEUDwzEHSrrMmoSiuYvYAQLyQDgqI4gMepCR1XhFGYlAEGwYCSy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfBWcWVwTw1TvoG95OBJ2z/n1RzHQQNDC8yDsdwQ/3U=;
 b=THMcBHwZZ8/VPMfvCniAfsiD1aUoBh3dxZzNjYGddmrca8t9HYfxmJ+aUXvP1vtue6IUPihXLWou/rZcmFAqettX8Kl5jDntGd1q6Jicw8GJcNw1VI5TlOODtwt1TxhTgQmIDZjEiKQ0hCiDP575v5j+rziVI4ghfE63kqOplsOyyP6Rz9jppyCzvEddH2DrF22jt0cD5LLhyx/4UZlEcSLGhtwIvMdifmonWnNdmbGgYVppbygZku+O0T6qq8KcBhyIyNKyRdOE+1BF7JcTZaUYgUanwqboF+g0XKhRbX0+l+cpYTf5vynmv6GnuyBS+V61x9IGdOi2gfnq3UIV3w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5395.namprd20.prod.outlook.com (2603:10b6:510:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 11:25:15 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 11:25:15 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sat, 26 Aug 2023 19:25:43 +0800
Message-ID: <IA1PR20MB4953161A592F3B8B00596FD0BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826-reverse-unroll-a2e0b2365dc1@spud>
References: <20230826-reverse-unroll-a2e0b2365dc1@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2jcQjahLILcT0ViS7npU9uFop2ri/cQ7UVu/v08QL0I=]
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230826112543.270446-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 1883d9ca-b45e-444c-895e-08dba6271ec8
X-MS-Exchange-SLBlob-MailProps: 0YULWdH+7mAieM4T+hjowknaCTQ/xRTmWMZFlVd1V0vzCap1iBna5aaTB8COFm0eYUvA18qzMeDpteHO1O3B5kN5y81hjE4w1zbK1pCWEAZoRrausXdbUQmZSQmZqqThr9urrdYQnAr5UoayA8aJs4i6qa4m/D1LrQsmZJGoBURTnmo7ZQFWZGqYsNuOoMmlyvCJs7VLvZtIGGZiN90T6OKxyF8bM1xoyvPn18jTKhdo5NvwcxHmz7mOOx4bPNR/qv4Z3UGdyg7AcWZSrZOmjIFNJ378/CSCxY6byngjopeSvD45WPg6DYed9x/36Ty8LKDb71TUh4I6FVIWN+KGKWi/K41tTD6MQlr4+BBj0y3YBuLL24Bgg919fbEVbdOZBXfijZ/xtbvaJv6vs8KAAtF1DfALmLKOgN6gr3H2Ob5Mm9viAB0R+LqPJMDX2efjh5VmRYOraeYt3x6Jvj/js7h1Q99GRGFWsvQWfmpJR9LDP0PUVRK8NE+c0J56efenlAbIi3Qi/UWQNh/dtoBmqrreylSRqGk3tZdefXx95KbPFz09tDcKW8XvLS2zdRm2FeNbcohHmrea5TVZpBDf3AQH1FAZDyipo+WhV3A8J04qlSbU6trf2fuqhfOETkDmlpXly1Ycq9sJMe43ICZdmK9MXGrKagvZAHzkO8d0soCzfAZBc1nhHqOpxdruPLL9HC4KPneHQSVGXuuxxFsW3rfG4pPzA5oTGnAnIZuVabGoucWW3Yvq/9gHuzfs5y/a0ENqD2kfpqPwDaz5DO80gt2N4lLYJBQe5HDFo420EVlLHkL41Bv5ngt5ggTv88qg/D/nAnVvqqzVfs0ABd32nlJA+G4A0X2kY/QDgMF/6o2kEcflyRlPPA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uugqti4sDfZehgFJSlISRmo7aRccVutsSQvcbfjSiKgMnXF7RmWhwNax/NqoGU8W3JoiywRAfuV6Vmy9npf9UQGMYV03W6hKG1HH1FpXJ7QNOxqyaSrbu5ZkvoTfWTkUNiuvIvdWH/q3GejPpeFZ6kI6MmrP3pYjUrcD99Y2EeDhb68EKWAui4i43/JH/VqIQ3wckCwiHEtkq8QGfU1N/9iFpkEjo84WliZB3SOvra0GkUR78CgHs2mP6hsc+Uv86hRlMXpxpDZI3rtBEIqSJpQHMAsuTwrFRgEf67cjw4F9u2GPTd9v7F4Jv6Ae9A7TsWF7ugLnyOBcHt0O32+D8R15cSHzH3jdWtKHQ87OB+ZJSgg7oZq3UV1NidKGAejDLqL3Bog/6jtPl9VT6iDfkhBsYEr2MTpWbXSOh1sTNWs/RZiKdxdrdhWN8WULi6G6y2QkVAIRdiTsPz7ItO/+gDGGtbAcuYkP0AGKdm3D8TBMxuTNK3bfcKm/vDSWVL9wwWuuvpg2ZLLcyxeTp8pYOXhd2KKVmTqiXjwkEMLkt1ntmJM+9hu2kOfTJNQjexMXnp5JFQfqMf2WUvYDamBY62AEE1pskt076BAJGMDKobc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSMGwxb8a/Lt5VnqqNFUOaYHBori5ZGrp/FTvSnKJx8USxmY0Fczyq3WwLP2?=
 =?us-ascii?Q?Mmgkr0NGbohFgds0uyTy39vJhva0BhLDgS4uaqaGxYufQzRD+KaA80S8AwyZ?=
 =?us-ascii?Q?g29U9oaJF/VRlhZMybkaWKO/VKv6agSfg05+0bJOPIYWzL1izQJ1W+IdIT1Q?=
 =?us-ascii?Q?wI8CTYkdhU1CwD9jtQQCpum4LeGfZrumHSVcqQmuaUokwKljSnxYHvsfovJO?=
 =?us-ascii?Q?by2Nb3pWySoqP0a2zk3MAXlrmWg9R8GsNZqmEA+nJBIupEiWP7MPoYu+pdax?=
 =?us-ascii?Q?k05n/100FKkC39vN86SwMRVvwhqwyhz/4KxZ8BDb0XEcSmLC/Yv5K/UjaWHX?=
 =?us-ascii?Q?v6f6I8Eb3jT9jVJEi3Ey5rd6yEa/GkR0jg0GE5zmzdguMf35lDZcdAw/qKUN?=
 =?us-ascii?Q?quOsFNwjuoCu1n5n67J/LTKNnvpX4kikF2AiYaJvl20EF0i/u4NPkuAXMqnL?=
 =?us-ascii?Q?snRbDDswCMoAJT8Q0bDe9BawCMW/yjdN4JPv0YuYcQpIE9P062PMCjjyVjR4?=
 =?us-ascii?Q?RaD5YbP6EByLFUiQXv7nQSYpr/+Cnat7IA6YbRYSmRm53avdJACdlY4wE88e?=
 =?us-ascii?Q?u3C8FWdVvL/Axg2mM1gxJ31czZHGYEtRZ4YS0YPYf4y5XEEDnW3KHoXRbCnF?=
 =?us-ascii?Q?VxACfwBJscrAQ3CDlgEbfGGpgbrRaiHO/L+YGv1VVi3UdmxwGl5nP2J0/rad?=
 =?us-ascii?Q?QaQehThkSI9fmc2GNSM8zNCU556XIs7odqKsDPsxvhELNSWQ+CiRpLGPbDlZ?=
 =?us-ascii?Q?e2xzutHvbaMpbDk5Qi5NHDRsQE8aE+nyLPbYk/aNIHg3py+8Jq4bTBoZoMFW?=
 =?us-ascii?Q?7NgAiNesfZbvrclYGNFiuQi0GF1CLeoxpaBYPkBzXn0nkJ8FO5nxkhcmlnmR?=
 =?us-ascii?Q?sXJ62x5wtGZTNfVJJxsbwvAtGLqsU8GLA+O8JePsjkLyD/lvpe4ikv1NHz43?=
 =?us-ascii?Q?+9suB86f+Ux4OPjCa5kVFfGBRHzViEVxw/rpzlyLVxrvhbVJ45UdHeGtLHqx?=
 =?us-ascii?Q?Lw7X2O+5o9hXgLU614MfbpeQude3UAI1w009vrxKg1pIYF2foposQzRuisGE?=
 =?us-ascii?Q?OfBEhYWCFQFfzoSG8LwhQzvb8s9zWog3oqgDjgfW09Tw20P2ajyj/hZIzo6q?=
 =?us-ascii?Q?Fhm2bzxpGqeojz39hOQ5N8A/89T0nqmajgl4oien+kJw0YpdaqlpFkhoz8XS?=
 =?us-ascii?Q?ZaAK5m85umbm+ts2+mGL+2S/CL8KqG3kW+y/Q8vHm4oqIwRd02RBl+RW1EY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1883d9ca-b45e-444c-895e-08dba6271ec8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 11:25:15.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT field of riscv,pmu for opensbi can be found on:
https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md

The value can be found in the R1S0 version of C906 documentation:
https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf

The meaning of T-HEAD events can be found in this patch:
https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com

The patch above also provides documentation for T-HEAD events and a example
that shows how to use perf with T-HEAD events.

>On Sat, Aug 26, 2023 at 04:38:53PM +0800, Inochi Amaoto wrote:
>> D1 has several pmu events supported by opensbi.
>> These events can be used by perf for profiling.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>
>Could you please include a link to some documentation as to where these
>values came from? I know several people have had some trouble with
>understanding the pmu DT stuff & having some documentation would make
>this an in-tree end-to-end example.
>
>Thanks,
>Conor.
>
