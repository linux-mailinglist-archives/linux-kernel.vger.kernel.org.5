Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD87CDA69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjJRLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjJRLcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:32:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2106.outbound.protection.outlook.com [40.92.19.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60FE128;
        Wed, 18 Oct 2023 04:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5DoZfXJmbe3HrdU55eKYwyeTg2jaqpzJ37RfuVlIgapZTm5WuV86PJ0ij8fUzaquRvc08rvSVruTYYaqU+NgE5dxMRfBska9vdvgWc1Oc8BvlAAzeEAMXI3PeEFWZNaACP1OEyJOMSARHaXYrFmNpK1SsUxevZjaNCjf4MgHlcAzGi4yqL5kdg2OEJXje9fDrjqfOIENbeWvhCscwEQcStnrLJvaVaOO+G4OwcUMd0WJtMVkcdB6sfhydutDO/TnbuJLIcHCvp1zRSTdeEciz+jivpHsLBTI92ZIoB5tkRE1p+mn7heNXZS7tYW1Feh/yLFEThHNSr6NbjncSgocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/s7p3+fTsVg2gf8SVIXagYsMNWEfoOfstvhSjrOVu4=;
 b=iGq7dC7MvgqJJJdJ1Z0ammDcwfr488btbMbYjZmdUVwT/7dSEFr0c4kJ+cuSI6iEuN93KPmqcUfQVb029n/nlKP0dqrwoWW30hqS91IGJmhveOgGs7enQykTbZLoOgG+NqWD2yYBp/zcmhtQ8uP+tLLzNaTdrvclFTlkVaUaZ6nyBcYLoCcsCyts6mbWnmwU9oOiJWTCu8mwvvOFQEux4cJ51FrbkbO+dQFzJ6g8MHgZN2xveJKTeR9mhQ9+Kc2NwzRC73bY03b0N20y9p4Y3ad7IFoKRVvuuVDb5BNYjbwq2PLyBPDy8qn7nqG3QJt6Aq5JtmLAXOXf8HiLrpFNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/s7p3+fTsVg2gf8SVIXagYsMNWEfoOfstvhSjrOVu4=;
 b=YNAkemGfX/5u56fScvSyfNbDzOVGBQRixXyIycp5jd5W4mo3ZpyEPxhVNTcBUb2SlxV3adKsYUAiKula/vPPxSSudNWCEemYCHYp0aEEhDfNqZahScoTcmSaZqrVn6UZNtXSgTqYl10jUA+2cepPBGSLe6vgpMTZZSY02NTA3J3SFUoVVXGkYXYFT+Do9Krf8AKYDy9aK7QOkN/92It6PGH+R3VcqRS8aVUoUOGWmgkHLgSFH4HfxVLCj78ZyJGpZrnPnBR6dke7icwKwo+uLbMpo7XA8ka0nBf9qpgfutbMP4BzoUcicOTEfmQ6UiNxdVf4UBM0lBhSEJIkQtP7EA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB4059.namprd20.prod.outlook.com (2603:10b6:610:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 11:32:15 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 11:32:15 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] riscv: dts: sophgo: Rename cv1800b device tree file
Date:   Wed, 18 Oct 2023 19:31:49 +0800
Message-ID: <IA1PR20MB4953267AE83D7E6FED7C06ADBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [67jmYEbwx0bcn5gevE2IXsUeEOwGt6DeTVhZvOaGydw=]
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018113155.1605537-4-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 701e6075-55ce-41a3-8b75-08dbcfcde0b8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+dZ+TLKT4ZdLYZd6TK47St0IJMOkyZBgkiTtXLS3hnMxb9IaiaJntJSkcfLOZ0isZapoHZ+Ws55WJxaur/R/TNRNveLCWIt8EhgK3nn0G7XW2+67UYFKzccC4tCc6GL8AXPSEr/IywIIA8ml/hDv4lgo73SlrcBLnC6DEmkQWUmWfifjUSYxHf0vzuiNrYH8Z8UnONn/sNYB/a0nJFSTfsdk134Sn4dnTvAlZ/qUFas48iuGNt2vs1erAmCC38tp4E7uUsIgwSMjrEV6AeCzcwAc1ADvUwjSKiC2DK3i/O2nCQCDB+oTbmXYSBOCrRgunQCyc64vd5sUgYmeGYtGvVQB1Zci2YgBzmUtkiLvl2B8w5VCJqjvMS8wfYF3TBhR19DU/97FlrBiwYu56XQuBwGjHp9INf7kPt0SsHP5hYWDVheDh4qZpJE46lj221fyn8ik3tQ3Nwf82stK6wzembb3szaQrZroOxyOzrmurBGQQUhbwbK+0EyMUhlTZJ14ummqaw+6T6BAcOtYJJ7NOT0iQ580yKOGHBA+Dj+quPLGg1AuATeDojBK8IyWy+hgw2kEgHoMY+Ho+5axvczxJadEtFjZx6S+ZCBGGzTK+o05bKYeqo1mh4Bm6jX3aka
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SedbK3B7TA/YAuubCZuh3dBhcEGWPbEKzN/K2YjSDqFzcGsjAtQI4au636lk?=
 =?us-ascii?Q?sqfS6h5ZoQASSVG7ucyzWP2cI8AHntS+fqlcz0p6tn/fdn1sNeBEcfkqhQ3n?=
 =?us-ascii?Q?a1fdNSXHR2Hyb7RKskKEqZLgUYGKce+lVA1Qv2/HX21g/OPSe1GshFDPmi8u?=
 =?us-ascii?Q?Gv4LZi2goYxYfESiS+uIC10Oy9qC0O6QPG/PshHi1IuVFZK5nUOLA/nk3RaP?=
 =?us-ascii?Q?B5BlGMN64dujTyrvMLxr+tzFACORQz0Cuvy05zEBjPnqIgUkrAw7WrA2M2Zy?=
 =?us-ascii?Q?Y28V+iAG5LeeDBlNYCjSdFIqVY1USbHOuz6TdvonwszpaMptk3QB3TUYjFpA?=
 =?us-ascii?Q?R0SyivS3eLB9BJ0NwjzLgsgXcfopXVy0x+4JB7confAaNfe/q8b34k4HF2Sb?=
 =?us-ascii?Q?DCneoId60B66dwVOV+CFRxRhUvd0CHv4IeMgzqIx1M2cvZPpfAVqkCrnG7bJ?=
 =?us-ascii?Q?pQzcdb08S9DG9/radiMztKAesnlA2sTkFh4R1yZsuzeKRqrbVu8z75dAKHxx?=
 =?us-ascii?Q?eg8V/0n4FBGu66YVTFgDlJPKUBjr051WpNpN/mbE4Ga+Z/LG8GY6bRse7Lkz?=
 =?us-ascii?Q?/mv03dskhuZPLXxvZKJfoGE0IbzYyIe17jAHHtgRDk08ox5vdLeHJ/eefigE?=
 =?us-ascii?Q?J4FNaZxjyC1pMn46HfIjvfueeDJkM6A9iIl9CtfxE3hdOVWlBcViYyLhEVhy?=
 =?us-ascii?Q?2fG5wIEXpVwiByEfpH+wqSbKXaT/U6vT8g53emA29XNu9cqO9Vi3WpBiOL3O?=
 =?us-ascii?Q?hC02WpmytrT0oaV9/FIiidQqGlXvyKSY8DVRyo6jFJc43FRQ6qpDp/lwVCb4?=
 =?us-ascii?Q?Q/GYLnR7QYeh7366KnfdOUf1lE/g+7W91kT6ejEmuQ9+g4d+NPlbcpwyGHW1?=
 =?us-ascii?Q?0dVezmqZv5v70jbhRJw6wB64s6BheAZ1OWRe/NNETinGbo5lGqKtrxrMnf51?=
 =?us-ascii?Q?RCmSygMj9Mq/+YDN41rI7oAu8DjjeDr4c2OlYyyj59bobpQpNz0UEM5Tj8Kc?=
 =?us-ascii?Q?9SL4OyRHInXKK/9uHJwt3i35xa3srIoUtPL37sSZUMQqFInZRqflOK00stPB?=
 =?us-ascii?Q?AHrQd8nOrW405U+t9oyEdyeWINQAD5JhDiecxd3J2hlMNxJZiLZKJPmh9Jzl?=
 =?us-ascii?Q?P9tCYkWJKFi+Mu6a2tKXvOhMwk2WSttLppeFflgfA8UyEyl3/0RAk1NIV6YB?=
 =?us-ascii?Q?5FtCdSVYVqJifvi3t98RRpa9P8f/DVUtoVJWuE5gBYDX18+18XNqMgHuUtI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701e6075-55ce-41a3-8b75-08dbcfcde0b8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:32:15.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB4059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As CV180x and CV181x have the identical layouts, it is OK to use the
cv1800b basic device tree for the whole series.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv18xx.dtsi} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename arch/riscv/boot/dts/sophgo/{cv1800b.dtsi => cv18xx.dtsi} (100%)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
similarity index 100%
rename from arch/riscv/boot/dts/sophgo/cv1800b.dtsi
rename to arch/riscv/boot/dts/sophgo/cv18xx.dtsi
--
2.42.0

