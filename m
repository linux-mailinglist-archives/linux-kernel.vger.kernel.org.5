Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1380639D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376341AbjLFAsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376296AbjLFAsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:48:05 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2067.outbound.protection.outlook.com [40.92.45.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEFAC;
        Tue,  5 Dec 2023 16:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE0etheGx3H/ZrMfovlOfnXDj0oMbJxhEMEdCgrDQowOZEhoAC9Hi1Z3fyYwM8lynFIhh+i0dZIIEeuoaqEhk8IjlxBa5WzwZhW/J19KEW28S0gFtb36HjZpK+KoxWkRdGwSvZrEQZF45PPPWS5qOOZBxn0F36/j5Zghv6l+/uwp/3VHS+c9RzvKwohDAz/4rU3B4Yen4/GpfFldn+klhFxPdMbEX/8GKGrEdwle9D6uuKk7S3FIb844pRSPTXh+wEIjZsxBRa42Ymrde3/VFg4/sUH2HvCws86Ny7OitoVDHGY8jxn5HCQ73//uFiScJ9w+lliTQFvnQORP3MsT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+76tpxcT0TXjQAeyvLeTPj4gxiHIHm2j3veVWdkR+Q=;
 b=cjyfW8ltpgcW8we0ENwo4t5n12lpBPO8dZhUKgDra7VwTrdwSqtvxBI9PUZE3k5u4VQYFIDdevqpkZ1TgkYjDhVwnaLwVo6rMRERNbUA7V7rRx3O3kO7zeM2OOw6pAyYHBLMh+KY2Fb1G6P6CSP562ax/zbfaUhCgaXZZzTGEmJxZzonPJzHThGyhhaw73dGkJhRpwz29eIYLXsfOkpeKKWYg2FT/BX45awuqWiFF8aiYSX5l5/8vtJ6tpjeKqFQhutUmiFx7gThq7XmU7n1jXAUjec+b3D88xFUF2WX7XnWAX96kBOvm/C/zz44mmE0RB+ulEfQ2F2NcLIbaXfa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+76tpxcT0TXjQAeyvLeTPj4gxiHIHm2j3veVWdkR+Q=;
 b=JjS/CCvY3ACU+jyIAQAKqSLPullyt3Ld1g+lUs0WCTL1xuRwT4TJ7CLtoAzSGpBawDFGXL0rpZ+sH6ty4vS9WAFQ2Vie2aV7TaEzEoKBBId19WmywOZxbAfwqTPaWqHd85kEOt8j9+e73farmk0RS+0FqnbOmFWD7TbpsNE9f5i6ScozFtmuV0l0XH3dwJCO8jB+6A5RXV5HBB8OLzB89fz2rhwaiWBvbRhd41w9eOrhOTNHRYkfueCpmbgMqeQXPYTSdbuF0EmAhMxOgTdvhYwqPXXv4a3WBlrMoLJlIO8Nl4PKS/1T1UjWpsmgBh+qVZgMtJBI3SalpZ5VTGpjzQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB4570.namprd20.prod.outlook.com (2603:10b6:208:371::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 00:48:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 00:48:09 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Inochi Amaoto <inochiama@outlook.com>,
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
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date:   Wed,  6 Dec 2023 08:48:09 +0800
Message-ID: <IA1PR20MB49531468A92E2A7670F1EE0BBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJM55Z9WO+0Yb-at6CAR6=UP9j60iQz=s7MK-3qiT=w-8N6+Zw@mail.gmail.com>
References: <CAJM55Z9WO+0Yb-at6CAR6=UP9j60iQz=s7MK-3qiT=w-8N6+Zw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Q1OmhEchBwnw2v9fwt/O2CHBg3XykFYDgkGW3lbyPg8=]
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206004810.138682-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: 0533d6e9-4425-471e-00c3-08dbf5f50443
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uDvQWLPz0X2R5d9Z2IjCMpwNDXSfG52AWGmti85wju9dAm7QR/s8b3NPmxEbw6MeS6s42nhTnENRKIyfltn5D9ezJFOiU2ryCkerN1uymZCwxW1R86hzuQPrDdR4OKPMBT2cU5GWlW9uICns71UYRvUk/H9m1wKQnfZ/pN7aJ6goBzgq3p+MzrbWw9a9A1f8adc+28UeCznd1VAI7RLj+YOzvLabpIQ7mo4DR0D2yQM29sH9YrQ1m4ODqhEKu9x3ucW4tHx9c15TUm2y2QtqRsZZUBJ8twfIrGpD7xmqgjW9vI+hkDGTMW86o8Aw/mMylKy9CWpW5OemktoY38gGZtVXZ4em0MHWnCadEMnoj6P7CkER7Be/vpoFLcCuarGbO/3FnfsazoCKj0K+3D5qbgxKUSvu+etoIOeUgrCCe/3EdsaShTZxFlZLb3bt2KcE6uTrYx8tPoa1JCjbI7afPBz4A8Yru0G7Wscl6vduxyjdYFJtPEmLQgfsKMKRlSPV0eqqNgBO1R4/tkMdHbIe7GeYqru+Frm4Hyou7MXjRkh83GRNDyPYWhl2YEs5NIcnpNHfhhcEV+14YDe4n8jyADCTn1n/xxxmqQ0qjuaoLRzFncRhZ64JUw8ZlrBio3N
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Snqa2The+fJZ6LYswDNUwPWQ9cVlmfgetuW2Vp+dtL+mtiyki3jo5ybCXrat?=
 =?us-ascii?Q?/2WQAPBqbF2nCAkIYn8yvY7wWSeq3BnTqjV5qC8TtZ/e2gWR3qdpUdxuzmFy?=
 =?us-ascii?Q?MPSkzUMpamMBxFQ07XAl+2ZDpvaUCQ5RWboPqs0twlfsJ3n4pX/OmmZv6d28?=
 =?us-ascii?Q?Vwi/2BPMAdh5VB73Mf3IvdKIawlxnMOQZXkz+gubbv+DEYCviyUoZt9B7dg9?=
 =?us-ascii?Q?0eJTRV6pn2Ks6pA0BwssKddpAgHSK/5z8CzWHoig/rYCOpLuqWudLPM6UwMk?=
 =?us-ascii?Q?H6RRiwewdFr8i4LmHjFYfloh42xHjKsDlTSkq+8Bn6IhIG73sShTE8KIr3w9?=
 =?us-ascii?Q?iqEaAusV24qHK2t3JvQvy5ZuhhymlDchofY45zOdAaymPS36KqZoB/Bwwjaw?=
 =?us-ascii?Q?Febz5XzNbfomSC7weeU/RoQnOMBVI6o1sQPoFXOOj1eYr5umbCcueemki0Q8?=
 =?us-ascii?Q?n6TfS2I4XPaUqcotTngNq1GLfGYqn/PY2aqcAKvQ48siOKm5gdZKdSVo+3zD?=
 =?us-ascii?Q?50Abeo5y1aYgPjacBxGFVN8DnrS4u+DJcPVADflK2zcDEAmRmoVTyKhbE0Qx?=
 =?us-ascii?Q?p0mFXeEAS6phyKVQ3LSvbkqE2PIiO/sYVjM5isQqphNaDNZ2dKx4Rbu2cj1e?=
 =?us-ascii?Q?Wb5QlC5XJTzXECRGeguUdJDZKsiEuRQMZq1xnU7jcMenNS2kpUBywbWNVt9h?=
 =?us-ascii?Q?+lcZZvhhpyqAT2eALa0rcundvvBYzQ9q9QPu6yLhcd5xW1ZMo9+eBeqiwy1V?=
 =?us-ascii?Q?y1Ye9ppGPybHLusOF1vTJgOH5bC+RrjPVN+UuAgTaAecRv45PD0OlpLe8fTa?=
 =?us-ascii?Q?rufIEZKHSqduFTCSqwzgAQhPfeqfVTCviwbaubxYGOkZo9fhlJODnVBbsH5l?=
 =?us-ascii?Q?RT6Yt4aBoeuX7HbEb4CYye6oIb8d3K/+FM1kMXNUHFqLSI8KItp02pWX4d8N?=
 =?us-ascii?Q?XPz2KUnv2Bj1OWd/ZwOHhUWIxd6GBnZ/wE15pMQLaTseTUFLZt3BR7DnbolB?=
 =?us-ascii?Q?/j+rBoJMRF0sb1JVvOWytHcsNd/zxrv0f7owY6jpEz0znrivn8LF0YHASntl?=
 =?us-ascii?Q?ZiaVyWr/hc5x47bN0/Y5rTJwpmuftuc8tzrd9wN4xifye5o+EE2Bt2ki9f2c?=
 =?us-ascii?Q?BpHxrM3sEV5pmI6BhvpHBub6mSILDxPE0rgdWTiFvlk8zp5pHvoIR6B4ok3H?=
 =?us-ascii?Q?QXndGnwpwZUXw3zkCtQAgHMblzjhmXv+JPD4s07J6NKdVDA/YWtR5P/NY2o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0533d6e9-4425-471e-00c3-08dbf5f50443
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 00:48:09.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4570
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Inochi Amaoto wrote:
>> Add clock controller support for the Sophgo CV1800B and CV1812H.
>>
>> This patch follow this patch series:
>> https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/
>>
>> Changed from v1:
>> 1. fix license issues.
>>
>> Inochi Amaoto (4):
>>   dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
>>   clk: sophgo: Add CV1800 series clock controller driver
>>   riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
>>   riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
>
>Hi Inochi,
>
>This series seems to be missing patch 1 and 2. If you did send them, but just
>omitted linux-riscv from those patches, please don't do that. Having the whole
>series makes it a lot easier to review without having to hunt down all the
>missing parts on lore.kernel.org.
>
>scripts/get_maintainer.pl does support muliple patches as input
>
>/Emil
>

Hi Emil,

The get_maintainer.pl does not give me linux-riscv mail list for the first
and second patch. I have added this to the second one, but the patch is
held by the mail list since is too big. Anyway, I will add this mail list
manually if you need. Sorry for this inconvenience.

Thanks,
Inochi
