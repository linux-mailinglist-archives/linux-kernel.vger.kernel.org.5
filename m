Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF9789AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjH0CSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjH0CRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:17:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2091.outbound.protection.outlook.com [40.92.45.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD211122;
        Sat, 26 Aug 2023 19:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF+/080n4c1sF5JpjDgh7DR2sC4i80zzB6fZ6pyuzcETyZNa3u+xuJ5wZOBoT7lZ36qX4tOLl/AfeKTgQqx36+cW+6d7B/Swr4+ceaNepV/8FnWmONmgEYszUyEgenmC9MQdCOqemsV6+sli3lGiIeGMglAvlrEW7l4tU2e+r6b5Wnd0DAQ84kfYDZwgSz4XK4uF7zUl2D/Kw6pN/Gux0ZUrJCgVR62FDwNfolOSSsN9ukPLdj7d3iTg4rRZN2ahzRaHegGawyJM3HofxN5o9Egg94/S0uBLERSCew4N8flXYZzODcJg6od04WhyWKmABmaPXpoIA6gV/EoMR96RbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haSnHquAyFrluQx5SsuWrV8AwA7HZAt9CC0SfqrYJhU=;
 b=cVB++7re0K9BH44NsBAP9zzrleFEuCP6Rm420ccfntZElhtoh9dBOX9x3JDO3D9NpAjFrU28UdnLsKv+RO10LEYPLxA3oMm4VVKTP10vvE8nU/q7vsgt2fjUv8zakpSehP3p6+dZ5LuHl15ENuM6w3Fsg9o468OIjQsExS8RFdjhzoPQ9s+4ufUr1sHscWtoY2dMlNlG9SUodvXZc/vpX8W7Ph6D4IaPgWSUsk5UIMBDBn70Bj9ESjVcgA9lcZPk1PiBNE1M4klJw9awZk7OrustPGjBwgXKvce4YGJs5LaP4bm90XLizx2JwENP31VNzeVF/9ywixBOfGJkKaqxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haSnHquAyFrluQx5SsuWrV8AwA7HZAt9CC0SfqrYJhU=;
 b=iZrYkH0gDSuJdq4T9JWLxb3xzWJiIOCak3iLttJNg/w5m8z7Osg83TUx5vT3ETkj22198ToHlFao81aIjjr3cpq6Wd+qAIVrMqkNrlZQQV87lu7Lid0ZLoR1JCwYDkMxdePBVOGvhbwvB9iki4o4lVIOqaT/l8Gd2B0MRIal/whdkZCp/1nOmG6c0oE0FLNbWEwpKbvxFC/8rQFvufFcaJKPE9JP/GBPzhhYwZQAtUByJ4eu3drtPKeS82RYZ2U2Jn5tUT37iLzGYdJUZfYCZv5OMgmWZ0mbeh+0RYIMeY3kivYuKP0xlBiyZ4qS2Bv8zoQhWVHk+NO7+5/OTYwMEQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB5045.namprd20.prod.outlook.com (2603:10b6:930:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 02:17:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 02:17:24 +0000
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
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sun, 27 Aug 2023 10:18:05 +0800
Message-ID: <IA1PR20MB4953C22B0FE8381C4F35A827BBE1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827-cricket-ooze-0bf6b7399da9@spud>
References: <20230827-cricket-ooze-0bf6b7399da9@spud>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN:  [fAufJkJA7CVpcJhAUn8SKV3rWyBaZJaYfyhMAtFvb64=]
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230827021805.204837-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 18555715-7a70-465e-3e09-08dba6a3c072
X-MS-Exchange-SLBlob-MailProps: lrlGrSszMGaVpEKWeJ2EJGY7AqS4jq8l2DhAyUjwzSk5/0mZN5diIHR9lXn6b65gO5+zed3q0GOIB+PwxSRT+t98W+aDRb6YXoEH07nc/MEP+Erbn1wxnyI0Wn+OYuBk5Ie83N6x9kRJMoAvJFjNGdm62q+EIiunT6TtXr2ZgWANSZlPZCueDkQUE84k6VDhuu9+1iqJVw2u7ISk9d71BCMkB7Zya6CI5R4yHddSQVCHlLAyFs/RjZbwWr7xgCzZuDEqsxZvsX1Q43H4YpqMllica8/KgXCV6Yj3Mk/im7S6yKhJi1pDdLRlxBmCR+sG/HYNFOu4skHWJ2jmrQ9yEYe9UEMZJyN84VQ1byJg05e+RDexK1ywSc87A5AzvG6ofa9IYrdX4BQ8D/CGAdcZmgRyoeBYSXbS6TUmfXIkYr62qvRSGyHjA1y0YNmLwfo7y8UM+XdUVGl/o44LPB6joEfr6rLXi86CI941XLCVfbvz0NnW6YoRRn5M+wlylMhp9LvPjv36eM67enn1s3t1jeP0IeF8c7T8p39/vsofDcc49+/bzAgU2wv4VcQB07vgPuuPaTSQrlSCDeYiF4IGg41kWXt/4TzLbKMSwp+tAnMav8mOao2W74X9NsNWSlh89gDrmHZ2hiQXK6tTaxhknje6VtYhKHWPowVH4wxq9kvxRWZ3P6VfoqB38WHRGf12wDbg3GtXyjvW+8UFEA/GumiSX06b/QIz8McVOvn2zCPbNpjzQlYdOHeGHhND8JgSGkqD5PxSpZ/BI5HPGRERDAPcr85Zz5pfbRpIrY3kNnsgi0iMKCWBv/AVIYu8JDNJhaH5dZymO5fFzooTMlgeAN3bZ6iagLb9lXVBe22AtRV3UHoUdOOZ81d1YGo4klu/ZXM9Ml0jjWE6vqqS7nUG0rZQ81E60eL+/PVaAqpi5lk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sze/8WyIyETqmXhGt0rhBCbfUbLKv76OjPWK/VV33VGJCAUcftPb5PQoq8i1tzbEFrPloxyPLjmWGjS02ciavMuqbJvmoUho0oTj/69tvQ7q+RIWvlFn4S0YEnBlSWDwrrusCpLHcsq1iaDfZV9RoZjhgUSiytHO27cJ3OdheoMRwp3W1Xd8a9ZfbRt0V34AgM2bxxprONeo7nhmfkH40dzX31x3ILsNjBIk6G0kRsuYvx2OHxdxvrK80EMy21qWe6Zr/Opavx3HN0pd35rFIhupX1XHhhwgNKTJCD2iPPl54LnoTSrI+WMZGvR3t0pc2FgGA72YgGGX+mVXTpLJDwkv7sSIGLy8mdupez7czxhLKcJLSWLdMkmRVS+fV4h34AqxqvPP0Yqr4QpCKMY8NGIHBGXqe1egcZOE9QLGq+6T8+Q/wIAcvA4gHyeQOodzoVVZ923cvXqt3S0vCraZR7OXp3iPYrDWIk1eDHtuxCnP6v/8SADWL0NYSadSDh+1gyV1X3xuiwr/TjeCMQWO6YANtu+/Bg5IXl8EeYA+0gd+PEXigslK/SehZGEppSPFzXn1nZYAPJ1Dt9K7HKuJcz402aJmCpsvzTBZh42YQrw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Za4mLMAThWbFNAijSv4PL7CSTtt6ufldo644KOLcSC1syIkHZaUofYnApuCQ?=
 =?us-ascii?Q?B13lfs8hNu5c5otGihU73eTEWoWtrr9OaQ4ydUbP+PxTObQ/U1TFQoboptCT?=
 =?us-ascii?Q?CD0KbMPqZGwPPAYuMNg6+TKW5EhxxZDin4Q0+twP6PopoaceSfa38NInqenr?=
 =?us-ascii?Q?bDBb//j0kN1G8fcenBieXFV4LA9bBLLiDj2To3LtGGwo69oJX4nzz6mVegXf?=
 =?us-ascii?Q?BThmp4KOov1hlFgX8pogNIdsCxf+hm9eiirG5f5R0xy3tZB9cHfvoRZ/kUlL?=
 =?us-ascii?Q?+S94RtRWbqG5E6BJvukZ+RPiC29fCByRQor9o5to6yNjdfjVBPUhgWolrUAW?=
 =?us-ascii?Q?9VJCW5mk8Xb3UqZOS3LJu7rrVKjYkS+gLb4fTQBJ+IKloU4cvV2oEc/nK2eh?=
 =?us-ascii?Q?YddMlyEGJBV3hZT7ThhrnoY+Ol//WBH4NkExPiP2TXrSQmCEN0wE8J4ewA7B?=
 =?us-ascii?Q?mB7JWezobOt1/kwZZHbQyXMcF7BeqMP8x4tjpjgs5ZrHXr/wbNY6XYVmohqf?=
 =?us-ascii?Q?6Lf0efsjcmkA91D1fbd6MD0euVRRFT6ATyAdDj3n1L47TiE9U6CZQ8swD4bF?=
 =?us-ascii?Q?+htvG0gesix2N+9pgD1WgpE9tNDxGGZbYgfEr2rywPYGjX5HJu7Tt40vnEsd?=
 =?us-ascii?Q?J6YE6da19if+0t86TmcZPhqkZNJ4YWZ9qKqp7T52cb6dU1LYLy+gmTv5o6/b?=
 =?us-ascii?Q?KVOnDJ2EOya9Fxd9nCbRRc5cao6CU20qCoFJ9p2s829mQOEJRnCU1XcmicfA?=
 =?us-ascii?Q?r7yv38+f8McJc4YPJxk5I9RPEE0qkzHrCZ2gxiMm7IUDsj+O79fvr6SMW3+l?=
 =?us-ascii?Q?TN5hIiRvbsiJefSuUQ7d009SBGg2Ufrg+aIYo5Qjaa2IY2zTF5zzK4MxIl0m?=
 =?us-ascii?Q?eyB8u/MMs+wAGPNWwTMwPdzHqW9rElraOCQ9cDDj65SRAIgzl4uN0mvTfb1U?=
 =?us-ascii?Q?YuS3JtttVl4DIp49iawg4OS/3Y5F6lq6rDPgRp2lLbNbW4DR2oRHS5PFbSTq?=
 =?us-ascii?Q?JnIJdhkqT1tyGYa6Ue6VelktLUCqv1GREeoosE5wbbT0ENoP7zFwIk65BU3j?=
 =?us-ascii?Q?Hqm9XdRZELwuEKjIHVi1cOqz600hvte+m9kirm0fIVAu4/ZWx/aAt9Ajs6Fd?=
 =?us-ascii?Q?qlgj5ZQWFmYnLeR2zGuy8Sn/xkL1UF0EMnUsYyk7EVW5YdWlxqdU6V+frP1a?=
 =?us-ascii?Q?HLi0l+etjdvIU42w9EFqD3Bj9XPIyC24nvRpAnXkN+kLRwXVs/XfkX/OTVo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18555715-7a70-465e-3e09-08dba6a3c072
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 02:17:24.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB5045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, Aug 26, 2023 at 08:25:04PM +0800, Inochi Amaoto wrote:
>> D1 has several pmu events supported by opensbi.
>> These events can be used by perf for profiling.
>>
>> The event value and mapping can be found in the R1S0 version of C906
>> documentation:
>> https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
>
>Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf

Thanks.

>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>> The meaning of T-HEAD events can be found in this pending patch:
>> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C217=
77BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com
>>
>> The patch above also provides a detailed example that shows how to setup
>> environment and use perf with T-HEAD events.
>> ---
>
>Firstly, you need to move the PMU node out of the soc bus:
>
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi:76.7-114.5: Warning (simple_=
bus_reg): /soc/pmu: missing or empty reg/ranges property
>
>And secondly, and I dunno WTF the fix for this is, but what you've got
>here is completely invalid as per the binding...
>The fix for this might well be moving it out of the soc bus (I think I
>fixed the same errors in QEMU's pmu node), but it shows that you didn't
>actually test this :/ Please do so:
>
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dtb:=
 soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpmcounters': [[3=
, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536, 16384], [6553=
7, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 131072], [65561, 65=
561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[3, 0, 1], [4, =
0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65537, 0, 13], [=
65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]], 'riscv,raw-ev=
ent-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0, 2, 4294967295=
, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4, 4294967295, 4=
294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4294967295, 429=
4967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4294967295, 429=
4967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 13, 4294967295,=
 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], [0, 15, 429496=
7295, 4294967295, 131072]]} should not be valid under {'type': 'object'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha=
-stu.dtb: soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpmcount=
ers': [[3, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536, 1638=
4], [65537, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 131072], [=
65561, 65561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[3, 0,=
 1], [4, 0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65537, =
0, 13], [65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]], 'ris=
cv,raw-event-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0, 2, 4=
294967295, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4, 4294=
967295, 4294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 429496=
7295, 4294967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 429496=
7295, 4294967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 13, 42=
94967295, 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], [0, 1=
5, 4294967295, 4294967295, 131072]]} should not be valid under {'type': 'ob=
ject'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro=
.dtb: soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpmcounters'=
: [[3, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536, 16384], =
[65537, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 131072], [6556=
1, 65561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[3, 0, 1],=
 [4, 0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65537, 0, 1=
3], [65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]], 'riscv,r=
aw-event-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0, 2, 42949=
67295, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4, 42949672=
95, 4294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4294967295=
, 4294967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4294967295=
, 4294967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 13, 429496=
7295, 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], [0, 15, 4=
294967295, 4294967295, 131072]]} should not be valid under {'type': 'object=
'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock=
.dtb: soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpmcounters'=
: [[3, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536, 16384], =
[65537, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 131072], [6556=
1, 65561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[3, 0, 1],=
 [4, 0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65537, 0, 1=
3], [65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]], 'riscv,r=
aw-event-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0, 2, 42949=
67295, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4, 42949672=
95, 4294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4294967295=
, 4294967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4294967295=
, 4294967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 13, 429496=
7295, 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], [0, 15, 4=
294967295, 4294967295, 131072]]} should not be valid under {'type': 'object=
'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-p=
anel-720p.dtb: soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpm=
counters': [[3, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536,=
 16384], [65537, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 13107=
2], [65561, 65561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[=
3, 0, 1], [4, 0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65=
537, 0, 13], [65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]],=
 'riscv,raw-event-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0,=
 2, 4294967295, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4,=
 4294967295, 4294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4=
294967295, 4294967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4=
294967295, 4294967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 1=
3, 4294967295, 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], =
[0, 15, 4294967295, 4294967295, 131072]]} should not be valid under {'type'=
: 'object'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dt=
b: soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpmcounters': [=
[3, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536, 16384], [65=
537, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 131072], [65561, =
65561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[3, 0, 1], [4=
, 0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65537, 0, 13],=
 [65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]], 'riscv,raw-=
event-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0, 2, 42949672=
95, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4, 4294967295,=
 4294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4294967295, 4=
294967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4294967295, 4=
294967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 13, 429496729=
5, 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], [0, 15, 4294=
967295, 4294967295, 131072]]} should not be valid under {'type': 'object'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb: soc=
: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpmcounters': [[3, 3,=
 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536, 16384], [65537, 6=
5537, 32768], [65538, 65538, 65536], [65539, 65539, 131072], [65561, 65561,=
 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[3, 0, 1], [4, 0, 2=
], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65537, 0, 13], [6553=
8, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]], 'riscv,raw-event-=
to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0, 2, 4294967295, 42=
94967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4, 4294967295, 42949=
67295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4294967295, 4294967=
295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4294967295, 4294967=
295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 13, 4294967295, 429=
4967295, 32768], [0, 14, 4294967295, 4294967295, 65536], [0, 15, 4294967295=
, 4294967295, 131072]]} should not be valid under {'type': 'object'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>/tmp/tmp.SOQ8Wz6Pug/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-p=
anel-480p.dtb: soc: pmu: {'compatible': ['riscv,pmu'], 'riscv,event-to-mhpm=
counters': [[3, 3, 8], [4, 4, 16], [5, 5, 512], [6, 6, 256], [65536, 65536,=
 16384], [65537, 65537, 32768], [65538, 65538, 65536], [65539, 65539, 13107=
2], [65561, 65561, 64], [65569, 65569, 32]], 'riscv,event-to-mhpmevent': [[=
3, 0, 1], [4, 0, 2], [5, 0, 7], [6, 0, 6], [10, 0, 11], [65536, 0, 12], [65=
537, 0, 13], [65538, 0, 14], [65539, 0, 15], [65561, 0, 4], [65569, 0, 3]],=
 'riscv,raw-event-to-mhpmcounters': [[0, 1, 4294967295, 4294967295, 8], [0,=
 2, 4294967295, 4294967295, 16], [0, 3, 4294967295, 4294967295, 32], [0, 4,=
 4294967295, 4294967295, 64], [0, 5, 4294967295, 4294967295, 128], [0, 6, 4=
294967295, 4294967295, 256], [0, 7, 4294967295, 4294967295, 512], [0, 11, 4=
294967295, 4294967295, 8192], [0, 12, 4294967295, 4294967295, 16384], [0, 1=
3, 4294967295, 4294967295, 32768], [0, 14, 4294967295, 4294967295, 65536], =
[0, 15, 4294967295, 4294967295, 131072]]} should not be valid under {'type'=
: 'object'}
>	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>
>Thanks,
>Conor.
>

Sorry for this as I only test the compilation.
I will run the check and fix this.

Thanks,
Inochi

>>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/=
boot/dts/allwinner/sun20i-d1s.dtsi
>> index 8275630af977..d9031ccdec89 100644
>> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>> @@ -72,5 +72,45 @@ plic: interrupt-controller@10000000 {
>>  			#address-cells =3D <0>;
>>  			#interrupt-cells =3D <2>;
>>  		};
>> +
>> +		pmu {
>> +			compatible =3D "riscv,pmu";
>> +			riscv,event-to-mhpmcounters =3D
>> +				<0x00003 0x00003 0x00000008>,
>> +				<0x00004 0x00004 0x00000010>,
>> +				<0x00005 0x00005 0x00000200>,
>> +				<0x00006 0x00006 0x00000100>,
>> +				<0x10000 0x10000 0x00004000>,
>> +				<0x10001 0x10001 0x00008000>,
>> +				<0x10002 0x10002 0x00010000>,
>> +				<0x10003 0x10003 0x00020000>,
>> +				<0x10019 0x10019 0x00000040>,
>> +				<0x10021 0x10021 0x00000020>;
>> +			riscv,event-to-mhpmevent =3D
>> +				<0x00003 0x00000000 0x00000001>,
>> +				<0x00004 0x00000000 0x00000002>,
>> +				<0x00005 0x00000000 0x00000007>,
>> +				<0x00006 0x00000000 0x00000006>,
>> +				<0x0000a 0x00000000 0x0000000b>,
>> +				<0x10000 0x00000000 0x0000000c>,
>> +				<0x10001 0x00000000 0x0000000d>,
>> +				<0x10002 0x00000000 0x0000000e>,
>> +				<0x10003 0x00000000 0x0000000f>,
>> +				<0x10019 0x00000000 0x00000004>,
>> +				<0x10021 0x00000000 0x00000003>;
>> +			riscv,raw-event-to-mhpmcounters =3D
>> +				<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
>> +				<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
>> +				<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
>> +				<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
>> +				<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
>> +				<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
>> +				<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
>> +				<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
>> +				<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
>> +				<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
>> +				<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
>> +				<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
>> +		};
>>  	};
>>  };
>> --
>> 2.41.0
>>
>
