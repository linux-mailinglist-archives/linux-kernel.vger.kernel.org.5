Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1D802F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjLDJuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:50:12 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2031.outbound.protection.outlook.com [40.92.42.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81C1D2;
        Mon,  4 Dec 2023 01:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaMKMfl78UQNHXOfg8VPaccMfJ3tAc2k+fLkrj8Z2mlMEpyCh201HHUPsk301Tq+AdkPR4Nu1gtwxlp+0cu5r3xCcxlLq44+AWrBMXT03TezrT3vGUKfYODGHS5E4jXbKAE2T1GETEboJPJnR/KkjcfobsC2otazaqruJVH/fgFeLQ3Ah38b6nF0tJlHOG7DwYIopHrFDrmLeJd7QQQ/g3vYGBFLHxFFVKCk2ugk18Qmr59YVdTppvokwj02To2hHNKxOPWVlMydc8bDfXFWsbsrPIPTxDfdThWzKFdPURAp42P24myTl4EpQ9DhpLAx1QhlWMmuVZyPjcaVU6Ku4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rEPJ7Ou91JKHQKHaobuXJBiT2xe/YP/0K8B2ZQtSwI=;
 b=mALo1tfKqUr/RkSt2n/T2A7ZnvVtWp+bIRKxnmxWMIV/Iw3TCkhWo9X+bJaFqomHd1rXivRDu6tFkpXb6wvYPspvnR3alaU7NCqII+ngHfCP8E58I9ffzFEDUgfPfL1YOVXE6wIGZfq5HlpR/27sWY6wQLlOuQ+/J5dbt/JYYISRc1gfRrHckPsl5Lp3FV9wBvvyWXZ5MMlxAjCWO0PhEsxQjUXcoQCXDB2R+jkbfioLCMUQelRH6eDE5SAQHy+T8qCcHoOQ4Ug27BmdnwHKY3oPDtawKI2KET2/AkfDlR5DZIFCHzId3N0d5sPg9p0jnXFLqKzpItKx7JQYqQJ9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rEPJ7Ou91JKHQKHaobuXJBiT2xe/YP/0K8B2ZQtSwI=;
 b=HfrhMJCH788jvrfNS0Ef1hiPiB7i07XrkGS9j7h1aCC4KFMJxe+n5XXv1QPMjS4m4GG/Q1Jp+NfJaK1YvWy9nEGk+SwzC+dBfLmTMxGvD8Wj63T+Vj8Q2JpFUACwkLlsvRlAO6N7gwpigOhSi8jSni+ChWD1azGuF0kgU59wIhd4yl2UKPLLN6gqjb8eXvc5OAkb6rZ5PDjxrbkSEM57KL7bGDJFj6eTqZueXUvpUw5aVlXWdyayB82BAvG40qZ1IN5euwcYfAm/U0FR2/boM8dA9kQqxb2/uhX6kMckwSupXqJrz+rdPiduQhrrmevYmWPyYLI1O+g0iIMBd99VOA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB3718.namprd20.prod.outlook.com (2603:10b6:510::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 09:50:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Mon, 4 Dec 2023
 09:50:16 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/2] Change the sg2042 timer layout to fit aclint format
Date:   Mon,  4 Dec 2023 17:49:52 +0800
Message-ID: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VEFFHZhT59HiU2HY6pCnTaW4C149nu5fxDNC//HtJT4=]
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231204094954.664903-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB3718:EE_
X-MS-Office365-Filtering-Correlation-Id: 01159445-5986-4d62-10cf-08dbf4ae6aeb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eq+fJ4u1C0HmXF6YbR1z/VoYu2d5fPFdK7N+hSXUzwfiMo6UfgbgP1c3HIC9haBDrV8owh+RaVkIBqa7BHXmuj+SRBWNNdsnsdHKkSOWkfMVfYehxEudA84ctwsWzorc/asKw0lCs8lHq9pi5ESaFeCBVpxoNZzyiqyigQEJAMAbZOvgqnIcu4hagko766l8iJXh8W2EIhuLY3/VUUsmg8VjwHYqOEjBXq+fm+Qn4WYNuKiVijEhxoGrz85kFfFmY9pnwl6qSA36Z3iSPnYHc7TE/6mC01OyLB3v6C0ZTr52zqmQcPbtgShEedZ9cgPFt1oyGBowQNAb/X+wLk52vFuvcZPSfTNes19YNOaQoMVlGKLZUyt/heF1fxqQICr11tY4i9F1xUceXnwjDds2LYZVOe/aOuJ93bsDC/2QXHz8J6k4X/cQsUsII/KvuZcpe+5rOlUKCd09K/ipEU5wxTxyo2gLGeLjN3XWp2AeMaxju4WqJ31j3rv3NQRmkfjbN1GQv0FkT+1/damiZAwl6MzPilx82aIyzPDmrnUoPapYaF0qmigyuiYhITJtEE806RonJuNVOaYXyOd7tojWrB2sRxk54BdLHUgcLb6UmR6mSsiOLD33Zsn8K/tTdh+Sh8kWLHcip2ZRf7hTJdU8lzBNv0xf8gMkxHUvC0MINLE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+uO+gxUhNhWG7Wv2YEWfFJvG1RC+ZyKpPtfqLmgippLgrRtBpGSE87gYoWF?=
 =?us-ascii?Q?2rOdBt+Dy/Nr9pUGmUGjJeyBIH6gSJobhHEQ+tnp5J71CxuFo4NfgDd2RzMb?=
 =?us-ascii?Q?HK1/cjl3RLUnE6eH4mbn0yYhrsToqPpuqB7OYgpqeuTcOojEz8sEi9OFwo9Q?=
 =?us-ascii?Q?0WOHCkcZvs4HJLah87elJYkN24K1pdsmKzaikn7jGeWqlMeCTgTTOsdNvZhI?=
 =?us-ascii?Q?IdadTTtEZ1OHj7z6pvkgQ025CdRmR+//rnsBy/RwfwlbNkPP/+LzmiQmbVOK?=
 =?us-ascii?Q?HwiMf4LQjnCeyDtTznoGP546Hy2KJIbdTbrwVeMoDJpKsEQsf9BgQFtoC2Ow?=
 =?us-ascii?Q?Kz9FdGP2Yzm+4Fio/CszsavfMa5P3nNz0QVTUyNUEDsHTKy5Qxy6UkV6VG5J?=
 =?us-ascii?Q?rCJo8P1QBUElrDWxYQ5nWVNHqIUpF+PK1QIIQSI6/0mDih4va2mg5Z36vBhY?=
 =?us-ascii?Q?mVVt/QUElZZoW5BJMHmAxtRj6ONBPI8YOwvbbM2eoNjJICxjX9rrJjwRj/80?=
 =?us-ascii?Q?FbVbyOWjCXJe0tZG7VRyMBCNaWVqfFDgFB1TCcdm3W/ExTtKIoroWfq3Zwto?=
 =?us-ascii?Q?po29RWsCNBDDxCWHofrpS4cXmb+LB/s75zq5YiYHejB1IrEIDpL4V1d+O92p?=
 =?us-ascii?Q?WbYK0X0UZa0h7Hbr1PXoGM7Dd8DMK6IUGnUqINgqU+cg7Ek+RZsZ8tPj7ha9?=
 =?us-ascii?Q?sEZQrSTekiAc1AgGGZdUN69jjIsj8PtQdxOJkg2pCWECFnNTowrU14xoMabH?=
 =?us-ascii?Q?yKB2NxB1WqSJPunYYSo5E6hZGA+UsipJ8XjBYbjGZii5Otz4Pd0By43ASnjv?=
 =?us-ascii?Q?61M+ODgXxag38pkocJAeeFgAkRnB7ZL3Cebaq6DfP+/OV+M3NJpztU4x8JS9?=
 =?us-ascii?Q?L9UcAulUj3/l0au26vtRWziDaosNCsKCcy2dEEB4CWc/GzQG5qXv0DgiBOr0?=
 =?us-ascii?Q?DM6DiFvL48myNTFkXiKLqevxu17XlZ0qK22Mh+E7RzBYGqeJi8pXCQjcLfZY?=
 =?us-ascii?Q?fMMecXeCZi6uxf2aeUb21ITfjrg8mfKrYmGB4baL13SC7CktHZwjuh5UwL7q?=
 =?us-ascii?Q?/i6Y6q6d29kUnIlCScgA451f3z+am/7uaKubj42hyIVsnIpIMgyVyXfWLgRZ?=
 =?us-ascii?Q?bPEKq+KI0zJDQ4Zc3gIPzm4jZSyZntNTrCQx0WNZf9FeGGQup4uIFLz19oY2?=
 =?us-ascii?Q?VVOj1rUD74D6MRF201TvrsMgTgg8JA42jCM+POJAup73KGR1YOENAzCO7ig?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01159445-5986-4d62-10cf-08dbf4ae6aeb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:50:16.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB3718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sg2042 uses different address for timer and mswi of its clint
device, it should follow the aclint format. For the previous patchs,
it only use only one address for both mtime and mtimer, this is can
not be parsed by OpenSBI. To resolve this, separate these two registers
in the dtb.

Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

This patch can be tested with upstream SBI with the following patch:
1. https://lists.infradead.org/pipermail/opensbi/2023-November/005926.html

Changed from v4:
1. left T-HEAD aclint register in the bindings only.
2. improve the bindings commit message.

Changed from v3:
1. add all register in the bindings

Changed from v2:
1. Use reg-names to map the registers.

Changed from v1:
1. change the commit to address the reason for ABI change.
2. remove unnecessary link in the commit.

Inochi Amaoto (2):
  dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and
    mtimecmp regs
  riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint
    format

 .../timer/thead,c900-aclint-mtimer.yaml       |  9 ++-
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 80 +++++++++++--------
 2 files changed, 56 insertions(+), 33 deletions(-)

--
2.43.0

