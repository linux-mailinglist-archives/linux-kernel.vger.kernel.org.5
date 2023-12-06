Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE78065CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376527AbjLFDmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjLFDm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:42:29 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2043.outbound.protection.outlook.com [40.92.45.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC69122;
        Tue,  5 Dec 2023 19:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDTup3yzcrjq5tPm7BjXGDrvIdmdLd55zAM9em3s8ScmJ3p/7pJcsDDgBnVfD0YrGb7X1VLcDNtIgSycTtJOIVrrPExXM0C0SMU419oRRVySOynPipb7njTzrFFzi71jPo6v7AuYUQFgJ8BBxfBtlt4KCkR+l6G86YeWa/8Dle7MFB+WT05nyf4Mbq4k8L1rRylmUnRhSXKTx4IaKo4Y5tqf+Tm6rQTep6vY7bpKCroz2xRdQS91u55+1v1w6sxNHAEXJWGA5z2cYyvAcEIsjSbVlrysJ/ybfE/wny8//wmhRBsAieoJiaplFuIXFfi2bNDiKATBw4HgT5ThYlMePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh+BoS2nl18fl+3QHxJMVTnwEBoLFPwS5STxbUe51fc=;
 b=K4eIfnyv3mFka7kXeUEiMHBdKXKne1fskQwz4WtSHfe1asRdv5WBTPCEowVaYKIfc1q/RgSWZizizVlcRegKuGWe11vcJXGwHfrz6W2EYc/+4jNPFtpZtzmv8uKQb7UMc79ZEju4G5jSZl0bDN0/iPhcCEsCJf61HUnl3kfL+QGesz7t2BcCeI7+rVa9ZrRXo+UOGePSZM6UIolOpHp6+3DjayOpxf9tHuCBdImzivT6oQU34yvO4lxRNkgZvSl8Iuhcn+qfkwEU2jQS72guhtzwfFofpNAA2QlUELVd7mGxDsFoCUH2LxcjREQZ4fKCIrSXLo1wDs4w2p1PKu3rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh+BoS2nl18fl+3QHxJMVTnwEBoLFPwS5STxbUe51fc=;
 b=SpyhFwWZM8sUP4N86gR8zGDzaT9j/ZwdoYpf/9IbnlOCvkcbSSDf+TfpZOWzk6+Pdk3p4CvKx+dDPb/DdOggOYEO5p87Cf7fsN5Z4fDXu6HBhoUCBRVoGipM27tBcx9x3W3pMzJ43SL2wWQWLAPf5lod7lHzR8OX4aNMMWmR9C6eW4oZho4VlUlGxsJKBhU2fmVIj0C20GYJuADHa35Zni2HPVfV5r4TO7Z21cuBlivPT9OJHsQjEDmphue3lnYiEi4Uii1EzpSWa83AM122Kq7gYgsNIqEVl09pVahJ+mzzjKo3Nviqi2M1dxHgPr3+QwgvRsicONjBUBSa3Gxhbw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4347.namprd20.prod.outlook.com (2603:10b6:806:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 03:42:33 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 03:42:33 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chen Wang <unicorn_wang@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] clk: sophgo: Add CV1800 series clock controller driver
Date:   Wed,  6 Dec 2023 11:42:29 +0800
Message-ID: <IA1PR20MB49532959D6D95B0D9D5E6A4ABB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <MA0P287MB03329157B1914F38A3485402FE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB03329157B1914F38A3485402FE84A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XKw5lLxmXAP2Tu/kC5AciE2Abmslvwc4fm07vKtrUwU=]
X-ClientProxiedBy: TYCPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:405::33)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206034230.390587-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0620049d-a148-4499-603f-08dbf60d610e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vihPqrQpANjlhSW/mvPcdAgmBnjgRYySZpiUoosCVOK/7XPSMioN5/MazQxX/jtlPF9gb+gF7XGKlCyHPibGPY1LD6ZDv9WxePcGHQCWPrVbMXqoAKMiDvmm1ASXkDpg/IjnMkvlTB3Hv9L7VWYxdNuTMcCUTZn2yvwwjNp9Ssu54m4vpo92XxVYIARuDJNy5GWqDvlnTIStNg302yrh9Vy2NB8uk0UgySeBm0aY24AO4ZqGkehV/qa2a2yRN2iP7r+RxewJZnalSWWRKNT7BHE7tP4l8cOXxLSsK1YWKnUD+vf5lPEnH7hVrL0TqGUXYZUjrJkcllKy9HajSeEqoCgUw3uHmWpPEYrUaCtn+iIcpA9v9Yy46YaPkvByKlZSC3aNWZ6bNBhFTDQHVmaOUo3S0vDSmrSTHotiPps44oJvUYw9YsgloBi2mov2ucpCXCxzEg3YMwfXlNiEQQSsyyjXDd+/oHDjmHvIB9CZYnt7UbWuLbcc7dgfdzaV97YFZbzgURdqqFSo0mHRqZs7z0PDhNI6oYUydg60tP6aaapo0wiKzYjOZO+mFpw2nYac8kIMjCSwNySBzSeksIl1idKnonSzL+XR5Ai+2kTmSwg4nKPwJ7WqC1CZkNzXQd1NeC6EGEPBymFQc6kcGPQSz/cePsBLobWy/KZZDPNDX8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9AfavXYT5AQ+QIVxEMQCMtL4wIw5TlgNvygqbFrCtcDoWY12YFJr+wkQdaVz?=
 =?us-ascii?Q?kaAQstFpwnV9aWJv18ybtaMQFibEL9Xz7bK7AEqiKtjcvTymTFOwL3FuVqv/?=
 =?us-ascii?Q?o3jZlHh+o9eF2YoB10HxcX5KHz9tHoV5NT3vd7bo3MUBA6lm9LoKkijqnqVB?=
 =?us-ascii?Q?97X+Ln3l90YmG4o6n4RLsJ8qeg3L4YLoSHSTTbX6boCphSer9nLWlYBhTopZ?=
 =?us-ascii?Q?pufvxrbps+2PINI609kPS0oAfz6nS8P6lJ1CU+XZqJNR8OccAJtvC0LLJrE2?=
 =?us-ascii?Q?uBFg2bNQmjn0Hv/UkFnnxI7Qxg2mEaPQ1ejMx2PFvFzqRcK5xUVaJW2El4em?=
 =?us-ascii?Q?0+xZ/13B5gFSaOFlGBGTBou6P+BYtThwfT6I0tyP92fcSdDJmRHNmPH+PfH6?=
 =?us-ascii?Q?kBxezsa8dt3Bk/m6RBnwPZK5qj8Cpfh6+6as1ynGGgkekCbulrurwfrg7i7G?=
 =?us-ascii?Q?5/qzbnR6Pg/zK/ljivezPHAMmGeKPvR7qz6ibYAQmyusk/jd1h6NlcGr0/ni?=
 =?us-ascii?Q?vUKgLVAyiuIOFNNvwnTBDZzAxxa0cwHFxjQq1GJ47QGrvo5HlwE82SByod5c?=
 =?us-ascii?Q?tXs7RF9xTXxZi4tc4sdrwaz35pFdnbemA7+VPARrWLOfxuGlNoz5ITZsORB0?=
 =?us-ascii?Q?UV3uPoEszcjGdWUZxhLcaA5zKE8RweGDJt4vdm0VmhoRiD2RA75Nor3cf1JS?=
 =?us-ascii?Q?LoxhovyMm4SZiI5VyZhx5sGQX7Xy4H1UyYSFnxerfaWnnBZG9xzB0GHLdtBJ?=
 =?us-ascii?Q?s4hHFiXufwPdNpqD8yxZBk3LHWfkRo4BZPcEW0y0ttczm92RdKQVRpV3t7VJ?=
 =?us-ascii?Q?bkhfDfZh+Oszs4iaDpo84udSKOcEizj8zY+ZCBTohspyA0px7tTl32czdrme?=
 =?us-ascii?Q?k2I5AI+tTj6pbFGVanBN6lbealgKysUYk6Mv30oMjAxzNWMg+C7o3+mIykXj?=
 =?us-ascii?Q?nGe1OqQ/uuH5F0CjZ4RNFEZr5vDqo21ShP2LbWlU0O0SFyzdQXpuzkLSst+U?=
 =?us-ascii?Q?cihobWB4rPbzPXFibvndDHajJdajGhfAmQysQ1qWNlUtLdJo241rS3Bvvonl?=
 =?us-ascii?Q?NWdWsRuT8qjtiu8VAOT/+ZV03sfKdkTjyO8deO8YCSqcMHviefxTSW953J/1?=
 =?us-ascii?Q?7s2O84rdRpoSPblx5CPoN3UsKyLyvNZAz7M/tj2jcC+IcGCebYe0FZ6nhYHZ?=
 =?us-ascii?Q?Ouaj1uHPb+3Gw0jTLscJk/sH/R76wbDtsSYZT8JoSz7zItSjVHK/WX49iS0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0620049d-a148-4499-603f-08dbf60d610e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 03:42:33.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 2023/12/5 19:55, Inochi Amaoto wrote:
>> Add driver for CV1800 series clock controller.
>Add more clarification on your changes. Seems you add several files with different names for different products, what's your design idea, please add some brief introduction.

In fact, it just adds the driver for the whole CV18XX series. I do not
think its clock controller has something different for different product.
The CV181X does have more clock, but it shares the same driver code of
CV180X. All the things just follow the manual and are for the hardware
design. Anyway, I will have a try.

>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV180X-Clock-v1.xlsx
>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>> ---
>> ......
>> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
>> new file mode 100644
>> index 000000000000..243d58a30117
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/Kconfig
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# common clock support for SOPHGO SoC family.
>Drop this comment line, moving forward, this Kconfig file will be re-used for more different sophgo products.

Why? I do not think this have some impact on reuse.

>> +
>> +config CLK_SOPHGO_CV1800
>> +    tristate "Support for the Sophgo CV1800 series SoCs clock controller"
>> +    default y
>> +    depends on ARCH_SOPHGO || COMPILE_TEST
>Suggest to add some help words for this config item.
>

There is no extra information other than this title.
In fact, I think the description title is enough to describe this. Add
a duplicate help is useless.

>......
>
>2.43.0
>
>
