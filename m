Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF77B474E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjJAMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJAMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:19:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2082.outbound.protection.outlook.com [40.92.47.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7D194;
        Sun,  1 Oct 2023 05:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmvDyNB856a/AhZNSh5VAu6niP3Js/w6jo04QGK0yVPxrVbqFNYpX68GtFccPOD2h+nBMpZdSPqiJqaTDTzR74JJAazYo/h4xn72UnJl5uUbrh1oTrMJpmdld5aKsaUrrV5lBTB4c9LmtLtXgATa/bdqpDLRHFJwZi4j0FXCuC5TNuzTYwLKi7wdADbFT4y0I7B0GsYuwRxP+Z50Olh0pSj+P/U86l0Q38ed2mNgD1PIlwqZCRiC29F/8PZmR/AG8NcghMxGK2lgtTKGX7NFIe4+sl62kfmgGkIcgLCctkeIfSaAJMd0QTUk4MI1NrsT8UHsyQOPtq9awQQCwDBEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKUfDPPhnjWV6avCasOAemWYue0/9CxdMlR7n0seVMY=;
 b=GD8YdWOaZHtO5DuyHeNSgKGcCQ/u1fphi73fSWfJVWB4RT5Wl3Wn8NeOG5ynwUtk4D37j/ShSe+ak8gcHGNwgovncNNheghjEKYLuWaNfhw+bMgMwnWNkan8KBIEK09d/ofsw/EIeh0WO9yyLbW+YYv6RN9qc9a50ZSVCM+MsoMInsI2J7werKfZa5UKzMjbwiLjyr1/xs1+oEr2l1Mxjnw+AtuBtalbT5ITdmqAyUOJpxctKp4ymjOwdrJV5H0qqc6FAifaSn7ZX4CcZkbbfILE+JKOJUuH+HGuMYNr3AoNd9sVBFIGFgHfcMn81uQjL/3qX2TU3zAZhv+YD8ZgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKUfDPPhnjWV6avCasOAemWYue0/9CxdMlR7n0seVMY=;
 b=rPBvdV2Mb84PV3xJCrZT+vrkKlWri/5aKkTwUOp9TpFnAQ485o8jYAhF7Rkzrpu1ugbs747lC2fL9ouwKBTRG8cpLo+eIByx+qhe9YTxLm+sOnIwb1EhsLL2N+d5ekMANy5tjFEXkeMxIioaYAuXE1u2661NIBX5yHC/wkf/vcpr54V257G2mqMzx7PN7FAqmWmp2qWw7XHNf9em2y51E2wzp7iLz0dJz7NbDdcqFNXpvOFGgoONKyexwnttA153V920rt6ymrAF7aL1ozSLOQSjglSL+41yD5+MipreDqqmC1VE1OfR58APPpi7wSHAd/VVzjRzVaatZO9bBVLNkg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6018.namprd20.prod.outlook.com (2603:10b6:510:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sun, 1 Oct
 2023 12:19:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 12:19:02 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor+dt@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device tree
Date:   Sun,  1 Oct 2023 20:19:02 +0800
Message-ID: <IA1PR20MB4953D58BA3ECFD487918E3A4BBC6A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001-abruptly-giddily-ef340b924774@spud>
References: <20231001-abruptly-giddily-ef340b924774@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1ybW5I2qJkAKsYqv9NdCLEe+8HagrBCW/c8AOT9gRwQ=]
X-ClientProxiedBy: BY5PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::46) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231001121902.659221-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de4266e-2439-4021-56d3-08dbc27898ad
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZ4ZVZ0l64JYPrUfCNm/dEl7BWFRBG2/ms+BdFLoQ1vG+T8TEpN7IZwE8e12eqLFkW6a7yhTP6ev17olXcQg5C1kZpBErleoSrc95WgCKb3A8M+Fpe/QvYfxDcTHsX5o2fOOKYX7GW+nI0Ma8ZrjO1wf8QkZQRkGDfE3urquQ3FfYhIFYqs0/zk2+djdIBjEcZ0oyDpY8MrlNMhSs0AmsAVQTIC+3xOZAVyBwrls51kKBK3ShZ8QFy/jSgOW9W965/Lgk65HxlTNvcAJvfiVpPVmqzguKNvUrJgTc6GFkYZpOtwSU6ypUqGxD3eftW2mLFFyWfb7LVtJFoguCaqlanI2maLSp12XppVJv26G8xM8gY9h8mkmKwoC1pXWHbIf7PLTeM5uD+dCB2Om389thf47KDiipJ0q4cceNHSkUc4cyWopu+MQZuNxL9Az0Gii5+sy/c/l05rshqnu6HVjIpbJ9tnS+8WA+SIYRnjNrq+SwDvTBEKot9Yh1WNFzE3sSuai0EX5XCymnhIakxacw2RlVTul3QlBlRrIdmj4NmRMz/8QhEBl9oo3ngXs5MDJtrdQwB6yhhkn2zbkZ82YpiDBYHP78UjyrGEIu+I5tWrRxZhwX6xP8gMlmRr9PoGM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sCYHH2gQky47lTnWPCPZaLVqi2gdka1hLnOxz5sg9kkUb5kyoAHGQttSFvc+?=
 =?us-ascii?Q?uvcRAANsWjei3VY3MT30sSRgJ95UANopMBZgk4bvDUwufypkoEJCYYPusw+e?=
 =?us-ascii?Q?wzNNg8BVuwjg6fJxytQuEwZriGvNdkUqdKawAXs1vuGf8qbbJfTVnH+17oXj?=
 =?us-ascii?Q?g1KyPwPaeXSYkq68Z7d7+H37YA6VvZkitj/NRUovTzvmH1RfdHvcbhybdTS4?=
 =?us-ascii?Q?HSLKSe8kpThG/TDQM9iGa3INPOSRZQSTrX+6iaLKV1O8Fau3b8C/Szep6lf3?=
 =?us-ascii?Q?zpemH8aA3/mXzlzXrIkg+DrO863cnSsLExSBGDuPJn4MroTkylPnU9JR02TM?=
 =?us-ascii?Q?0FZfL7hjWP4AIiArxfMypdgjaXp8PJAzTMvb83l+GzwM9z63aLEdkhqb6roI?=
 =?us-ascii?Q?TWaCwAUQsa01h/Qk7HayiLXvq5KDHf7B9eymbb4r2re7unSfpqXziGvTQQSe?=
 =?us-ascii?Q?TajV4cFKpYcCay1bnS27bgKaBLe09J8CE9DrpYDbFGUdU1bXuoP+WSVtM3Bp?=
 =?us-ascii?Q?Caa9fRuHdqCBab0/K0hC1FPzYINacwGXQRequy7DlwDHpzxKNjJYSAb6k0Os?=
 =?us-ascii?Q?W/dB0Gpd6CvShfKv1n18lZZQl03jGxHD4UYMkiuaOrLrhl67a9BIZc+t/+mB?=
 =?us-ascii?Q?duuVS0FFDbVhafRQD4BOu1LSiO3IZKQXsJU1fmNXJqSwAGXy6kA4bzBJmtFx?=
 =?us-ascii?Q?32gSJ8v1q+7M05PeFhoSmc04Use4Tza9GpG1Diun6gHzLLSA+f8cPHKkI3j0?=
 =?us-ascii?Q?tP4831voGxScHi2qN0iFceuf/xUoB5xiROA15QIJYvYfx0dZX/kxpQdcgrqV?=
 =?us-ascii?Q?6PTFt2+EclFURVvlpcBEWkJnB1aU7w/PsYnPbQFCzV8EPxZ75MEcmniHz5d+?=
 =?us-ascii?Q?stFS+tXkgvr6efbPhqGRcmlH8DB+UX6Xv5kilUSLyTulPNcfHuUaaaYyxYc6?=
 =?us-ascii?Q?RTUFC8+8vwUK/fFeT1yVqT7Z5rp+GrRpNkxOStWmtLsfw05tOQ3VdL/6PpVa?=
 =?us-ascii?Q?NO20CZ14L2J8MXA9/KIdlHgBPBmQNdt6hC9+ZZnS7yYCRT9CCPb2wh+VCpjM?=
 =?us-ascii?Q?Y/qeMjrE2VxXzpKegDMc7RCRlzN5acSPweVlVxQfecx5J3t48gTDwQEj5Le7?=
 =?us-ascii?Q?sfPr4STLVJyglAGkJHLCWsaWzVRTUmuM3z+o9gBGm6t56FUhBFFlETsl21Ty?=
 =?us-ascii?Q?oDa+OQRB/4K8ibCqPDY0REUKIVz4dCH6vanwgwOaz6SroA93k6huDbsyymU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de4266e-2439-4021-56d3-08dbc27898ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 12:19:01.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6018
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, Oct 01, 2023 at 06:34:21AM +0800, Inochi Amaoto wrote:
>> Hi, Jisheng
>
>>> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>
>>
>> You add the clint dt-bindings of CV1800B clint, but I don't see the clint
>> node in this dt. The SBI needs this clint node to provide timer for linux.
>> AFAIK, the dt of SBI comes from the linux or the bootloader, and bootloader
>> may load the linux dt and pass it to the SBI. I think it is better to add
>> the clint node.
>
>> In addition, please separate the peripheral node to a different file, which
>> can be reused by both the CV1800 series and CV1810 series.
>
>How do these SoCs differ?

AFAIK, the most peripheral of CV1800 and CV1810 are the same. there are
only a few difference between CV1800 and CV1810:
1. CV1810 have mmc interrupt, but CV1800 have none
2. CV1810 have more RAM and a more powerful TPU.
3. Some models of CV1810 support I2S.

Also is some you have already mentioned, the video capabilities (including
encoding, output steam number, input steam number) are different.

The only board with a CV1800 soc is Huashan Pi (CV1812H).

>Documentation seems rather lacking, but I was able to find something on
>github that suggests there is also a cv180zb. The difference between the
>three seems to, from a quick look, be their video encoding capabilities.
>Is that correct?
>

Yes. it is correct.
It seems like you have forgot a chip called CV1801B, which has 128MB
RAM. But I see no board with this soc, so at now it is not necessary to
care it.

