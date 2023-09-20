Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4202F7A7E19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjITMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:15:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2075.outbound.protection.outlook.com [40.92.42.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16410AD;
        Wed, 20 Sep 2023 05:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiWAbT45QsUbT3Mlxs3SbZyStARQWnW8iu4VdVjH0l8u5jk0j3Ph+TfgFGKcIYMhJ9zMCuFH6TSbvhR/5zx39+BPSmixth+7shj5Eoa2OWK2bzEPqdjuhGNehDA2V01JNkTLxXF5MWgJQErhWutMXocvGu83Il5JfaLHvbgtQ0yQgpA4Z4SJhCjuJBUIhshWfx5+vgI6RWOuq/j4LCF+7uvwkZ7lVX/kIIN+cjtiH1YenBr33hFLPT3sWVR3RRhQYDdUh4qFhDWt6NXdASLSQOkchBL0xOfJPL+uPbYot21Omt56kRmkfLsM7+MX5EJxJLBopoMiRWzDi+GXWB+SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2bnxP2YZKFWQuXLpx91MI2m9acbgVyNcRQGFpyYzgY=;
 b=BPBiRqLyt//dkezIH3504SdRzXIc2IrfE4Mt6rH4Mkx/dOYVtHUNfKK6FwBlZNNapz3Y3y0odsFJZUuzgaB8PTPD0tDRwKqXSsxR0Kn9En7/60vx/x3xL5Sas7fUV+5Ju3rCTL50JxV+2c+OwTPq/6Emaf1gmJUu5U4KMxbYPh5HJUtDxm2lsn7rUk7NePZ/xxVfAuZ0vu2toTdP9RzwLeqVFv+eZwg1CIvG4otstEoSlPScTzPmi1i37jAVRQIW4cEdFHYhCH2fV0nIr6jK9mxFaRf0ZmOa5g8qnTVjNV2WC+WbbwmPdE1L6XSv/kbkKZU7dJxxJOzApMifufAqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2bnxP2YZKFWQuXLpx91MI2m9acbgVyNcRQGFpyYzgY=;
 b=uJ3Hp+GNEY0IM8lSy6zDR7vOpXsFWdOcEstifQR5xW529EWRRqDaJji8X6A03X59PEanRZKJ4a2qpNfhGZCnnzrQ0Ym2qd5doxy1OffwXWG9fm+7nsuRZ8T14NTyeZ2O0AJK+CTfBOMaDXv3RuxL9RBJ2PA5U1DHWa4FZphgWcGspGnO5wv0i5DvuhNvFbxAjBTurVSDQ/MvBWlg9IwpXbIAAn+YGedy+7hA0b/qXV61M44pa7C83k09RgKDSyzvlV0w28G9QZvpU9qfLgkuseFawMI5rS2qwTpwNLVqawvpAiFN5/0hI4pVenkzwjrQJH+NFyI8RThAqDRJ7u7Plg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB6491.namprd20.prod.outlook.com (2603:10b6:610:15f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 12:15:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:15:18 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Wed, 20 Sep 2023 20:15:12 +0800
Message-ID: <IA1PR20MB4953117947BA7DAA60C1F435BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0b84ef92-f6b7-f3bc-fd51-8f61cbc91ff8@linaro.org>
References: <0b84ef92-f6b7-f3bc-fd51-8f61cbc91ff8@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pF5Eq001uIcYQ2ktPRyMTUfgBuMSKsj9BWe67WDBrnI=]
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230920121512.193296-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bcb162-2b57-4e90-ed4e-08dbb9d34117
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbzSeT4IdxxtmrmWyunKnkcTX2uhXvwF/bszEXrFFQK0V+VpuSHbohAQiNJc4A9s1BsyJA9WPxq1mPtes/DI4mDUE78ZpbxGUk6sT0xSSo21+NYzldOGVQ0r3eJlLKpg+LiiO41MvqlzPQoWFlQo906D2SvAV6yOD6KODa7JIMRY16kCY2m//kohceCFTl0OUfUqHUdPJVlTxzy3hEyyT1goUkOwi9IMRjfY0ZiPPH1P1Tdi7UmdeitSJjeP2se1BfXI2LbSWtqQGwAIcKnIkiEnFGBGUvSJH1gRD9cYk7//t1txM6Y3u5HN3tS49mL+OMpKMhIcW43DDwbVgVOjyUKrPjdyFdxldQwYkes4r5pdx56m7RgjMbsCxo+QL0+Ml0ooOJPbEl4d+iUPdxWRxmmGhLUCI7LB2wlatdgRNr22SH9jeaNZzMpuikMVZivrJCpwAK+EYZCs7KbS4Bq1Gjo/Y9VzJ9wZ1ByKq+oo2Aw2+/TTgyFWxKyWxZMQRFEPeJfG0IVDTl55MWSoUm80zZFY5+h/x1oIqfBfDVBRzub+oDM9YCi6GvFcix8OXmPshwBerkD2XLjlEnkuw6cXmAeOTYww5DruIsqhyawGgQMUtmjB/NpRAOAzvL9o7JgzXQyOe8axKBivVbeva90Fyg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w493NV8UQdYgAMo5e5Sqcc549pCyggTq0jYY0R74SynDkKm69cjmnjGpck9e?=
 =?us-ascii?Q?sc893pZlW3IM1PIuh2E5E7uQBL3p37OxCDqMhRF6ub+IZ6HmlubdzmqIhvxP?=
 =?us-ascii?Q?8IBF+xiEaBx5pxPSyh5ciUvbIBOZwlqG0IMdp3osy3nxfX/ngqQC/BEYX4XC?=
 =?us-ascii?Q?fM9/psuOmtNsUdedcl/ttQR5mg1/f0LWrtXZMcoAzEHLi4xT236iErbKgZMi?=
 =?us-ascii?Q?mIJq+SD+MLcFLXGA/6acFIPf5UkC+H2+l3+JiA5R/qlr1M+8g8HyerE2d+Qq?=
 =?us-ascii?Q?gGkAjEg/9Vn+K30wLVoFOTjcR+7CgGllW4F+kDQHoIC79U3YeaBBJ/WcR45y?=
 =?us-ascii?Q?PTXCMbY0D/QDwrcylyPSrUU5CTX4tVzS3mlptQxvjwTBqj9zB+4LFeO4rhvo?=
 =?us-ascii?Q?U/eRB7rDvXDDLQOnAFdXxFFZKbwyIpmV7DRJbQs1VhVKaq4qSq3PGRrmij+S?=
 =?us-ascii?Q?rBzey05zvHa8yVQwpzIG4ctsOmGWfORHkQeaJ1gXyv6rKfWhVVROLUk3XIYN?=
 =?us-ascii?Q?ystC7r9a2GWOb2Y+9KAg+QiT9oJE36q30SibncFqTJEFpN++silmaisSZtZt?=
 =?us-ascii?Q?e9TLpyx+mFY/7uPDi/2QdDQ2UGMDIYhhkypT5aaa59qd1VbGSFk1dHfEp+PL?=
 =?us-ascii?Q?7cM45gTlXldReQfU0m8ES60AvCTqTa31Js/awv2KcpdLUDg1XuvkAQ41+eEv?=
 =?us-ascii?Q?R9fbZgdHs1EctDqbe3PRJunaYK3x9M4ekKdS8zIiyRA+saR5be3uuOUUk4aR?=
 =?us-ascii?Q?yWk6y+aqzEnTx42+EKc+3raPasZnRo/l/eR+lX6022rs98w9GVqtC/Cr6S2u?=
 =?us-ascii?Q?48I1fhgcMfxfAT0maD3iJmLcMmv6rT6hHIf/zF4ZsiXj1ShJudxEBO14pCwf?=
 =?us-ascii?Q?KdiAf588fZsKX78XfpsWm0DxCqZL7Cifwd4NPk8tMQMmMHh3wtjOSj1b8ovC?=
 =?us-ascii?Q?GEiUp4PMIXHVgLYr7n8EFm3AjQzyQ6rDrCPpvOPe/Atcr9orc9MUP9mh75mf?=
 =?us-ascii?Q?ermxunLAHx3gXa3ABkE9k+R1H+reP7WtdsJXAr5CUaaZbjfU8GyZ7S2NgF88?=
 =?us-ascii?Q?v8wsn6F6se/V0oCD+uRcs3PruGtpS7lpCxicBGJlbHShFx4vGz5Bp8jA/SZY?=
 =?us-ascii?Q?W3VsMgbjSDK6KciyRy0Fy85tcH1khqHMSByu/WtWSDZwMSnxlR5ZZOMkVjMC?=
 =?us-ascii?Q?AWIZboayuzgNom7o+ZQXIaRgRu/jPPAdNHxANmv1AQsB5QD27H0t3P2f2nw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bcb162-2b57-4e90-ed4e-08dbb9d34117
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:15:18.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 20/09/2023 08:39, Chen Wang wrote:
>> From: Inochi Amaoto <inochiama@outlook.com>
>>
>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>> the timer and ipi device separately, and do not allow c900-clint as the
>
>Why?
>

If use the same compatible, SBI will process this twice in both ipi and
timer, use different compatible will allow SBI to treat these as different.
AFAIK, the aclint in SBI use the same concepts, which make hard to use the
second register range. I have explained in another response.

https://lore.kernel.org/all/IA1PR20MB495313B7E9B2FC529BE0BB2ABBF9A@IA1PR20MB4953.namprd20.prod.outlook.com/

>You received comment about it, so please provide proper explanation in
>the commit msg.
>
>Same device does not get two different compatibles.
>
>You also did not respond to my comments, so you basically ignored it and
>send the same.
>
>NAK
>
>Best regards,
>Krzysztof
>

Sorry for this, as I mistake the idea of the last message. All of this
will be fixed in the next patch.
