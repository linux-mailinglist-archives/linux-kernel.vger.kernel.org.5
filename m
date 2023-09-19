Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52B7A5EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjISJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjISJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8EDF9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2WI5qhIlOHlK2ksSspjZm7bDIRkxx2EkT2L3cv8bn8AFvcQnDKMuIPRPyFFa/Uq2jUXWg3TvkMFSTmtfccqiOu0qSc1IdvftYKRBT1060E0c9gCDb100vSlGA1Cvj2LS5eu4gI5AYnkicrqSdhhr6xfZJ028H8mYgzV5tCxfbQ/VZu52gQ8acUAsKMJET8DWY1tN+dBgdfooSbkLiOnSjU0yUsA1vOPrgK2XBfFIE3shLpKDIZ3UzPhh9wqbTqV7w5DKD1IogUxx8qopJXxc/xMq6q5AQfvuk2QU6rSkDH6s0232Z3YjYC59kxAZOgfz6POd6LR7RySbRXXzr0DbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ALlgzzumrsJfztPGkWD4xJtPV8fLQKJHFgAMHE5RsY=;
 b=eBDWLESPR5wN70UFpGnRM3oV6dqTZ8dqMHhyeSogR1rFDMqcmAKzJ6R4aUmu9ZCn/SEzsoVJ6Si+w1WYUiuM0Vke/VY6BKME6aLjgywRsHDvVUr3/JnpssYafyR4rDgLVga/9ZhHT8hC3kqDQYeYz5aCKHReAwZEMFQY3Y7E9t1BSKSPdEwZ0ROj3iAfeHkWp2k/HIuQMBkc/tdxYKGJZM3Dudheho4Zt6fZIyeInFFbZXdcTjXI+16v7z6BM4JoS+TRIvRO7sKTCDCY+7hm6d7dDI55bORTxlCdY+nbw6XmkXUO/pAXGhDVzVAihyNgxcs49Nke7zxfn7O0fDLK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ALlgzzumrsJfztPGkWD4xJtPV8fLQKJHFgAMHE5RsY=;
 b=cj1/5SF5ylEwInA2SiG1HAJz7JZAThSyg/wuVOeAciO87diYhm6n6+Q92Us6MSHYRpMLgAc5f7E/V1HFsBaxfFEF8hnlOOjb/Kwo6I93MOB6a38Zt6I+OLi/VnwWyUe3vKGuC4IRJIedr1LrGE0Fh2u0UUBpXxpir8FZWySrgQr36wb1N3waPZQePhzV8LQGzVrMMZj9G/JKEibKJVzuPVyRmbKoi/+8uaaEZWTG0Yt9BLsH4m0ji7UKB8GePXBg+dQXzy3Irog+ZJb2dVVb+Luf1Ee3vOhGfjcfRvp94P/okIEG1+EiupTx+VeftamfqU8UBi/x2x+CDxXXncCoxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6982.apcprd06.prod.outlook.com (2603:1096:101:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:53:04 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Tue, 19 Sep 2023
 09:53:04 +0000
From:   Huan Yang <link@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org (open list),
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR)
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [RFC 0/2] Damos filter cleanup code and implement workingset
Date:   Tue, 19 Sep 2023 17:52:33 +0800
Message-Id: <20230919095237.26613-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4445225e-4bec-43ab-d3bc-08dbb8f6380d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZQ7AuzLmA6fKbcsti7Z3kW4EjOWkSJn240CXOqHC19cyJbdc3Wcq6DtN0Wk0htjF70PhI0cDLhhEYiz1mmtSB4KwFA1ygdRiXiJoIywDqnwYsZQsWKyR7THEM20322dW3TOsMz6oJvAc0mVhBgIWQY09/hvU9mpI2i532ad/q2jVccAKmBYhQwbuHKjoXGiQ3PGzLDaFt9wiPgheuYvzjUc1zZuMK40shp/eKUt8PumawkBdq0+h99Lsn0J9EKAw0np4E5hrE0zBkex/w3z7u9vNf9K7JbVBiJIK4wg0ZFmNTo7Qh2kK3RUzkPzYRcGqy6xLeZ/8HxoQU+ZGIVRqtvSoAb7qHXxwax8AW6AzFbPA2W/D2mwhViYkfoHExLBrxA+smFC3HBrKAq94YBrZ+Oz7NxrH2h0PYyZx13BZjFz4KQ3sw5s5Az9u3uGtPv+Z2E7eVGfVMGVcGLwF96fZisRMiIEvMP0hpAUGsXk4Gc/o2pKXGN6s9VmQld+W7daI2NEg1bbNmZEEvR+62jCQt5qUIiYttVBMtdnSL/vvmdqqwjkoVEEixZrvjqPCsphZq7HR0/6jpJii03djZNjvnwArjJ17Ma4swR5SGJK4UQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(4326008)(5660300002)(6506007)(6486002)(52116002)(8676002)(8936002)(316002)(41300700001)(66946007)(66556008)(478600001)(66476007)(6666004)(2906002)(110136005)(6512007)(83380400001)(1076003)(26005)(107886003)(2616005)(38100700002)(36756003)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jLvyEy5vwBVu64xIi+BqA/lXW9s293dqFuijnWXCOuel1t/5H5LrID3mipc?=
 =?us-ascii?Q?Q0MiHXozbLjYeeC9UQJOMCuRmpZ+vGfsYAU+xKYhb5oiOmDMVaJFK0b2l31i?=
 =?us-ascii?Q?8WIQSKShAfNjuidnfnwbH+Ss7EkrMDajHpSWfqecNQTC5Lv0W00OydeGMn0H?=
 =?us-ascii?Q?JfBKZf5f/RxXzdP8V6F5rtnnk83U//sFjXnSPfYo81d+6n9bcrKoMdCzFksB?=
 =?us-ascii?Q?B2Gxq0vVgl9hBaizj1Lo6lHMcK7MKnNIzZOys4k34qz4JIDmQ18VGjzZlR+L?=
 =?us-ascii?Q?RojzwtzPmRE4gSo/SeIDmSCfg/AqDF7avG0MXy6vsHm/Z2AS9qkIjg4f3Qt6?=
 =?us-ascii?Q?Avl7U8tDvtSkucfzv99YsjkSO89rXL9KooP64kaKBqABlN1o2Fw8RU7pudUi?=
 =?us-ascii?Q?hmvQKBacNyQYJt7AgmH90x2RtG/lr2mHRhohfDoABwdGHoQ6ar1M5yvTd7RO?=
 =?us-ascii?Q?K1lAlfC94LI6FFLcivj0lV8DiJBP1pakLU7qAmjGp039BpGBeLJCyJ8n8IN+?=
 =?us-ascii?Q?hKJlWXJtZ1g6BUw1uKU5rm3oK13uFbecEvsPzKtjuvimOwI9S5MFwf7xVSVc?=
 =?us-ascii?Q?57pNFAN8YmkN4VKBiRW2W7zAjwHfC2JBWnko4qGE5sflu0u7yAvB/gdU50dG?=
 =?us-ascii?Q?LRW9GJPIglufLm9x6J7H+LILOHQH1GLpklfWEoLmzIoOk+l7Pvp/TJrZAQJo?=
 =?us-ascii?Q?Yx8HV7hl9bDIpGYlC/lCXPDXUJSK+J7HmHP4RrdntP649v42+s+avvrpHTuC?=
 =?us-ascii?Q?gekMryYDgHU3mgGKqKZVTB2EY0C3HApu9JNTXKZrlnE7wBFcfiNkCvZ/ND/k?=
 =?us-ascii?Q?G5TXxv48Vw8rvzuW8OgUJ0NN4FO12NzIfQvCgxtNH9nWo40VECCI47rrMFeq?=
 =?us-ascii?Q?/v+seUBNw/Gs0YJZYf1SEsymcQvygM/nFHkVazVeeOojPBQTmGbU2Sagdcxr?=
 =?us-ascii?Q?dBuQc7uE6ZJj3bVMTLOz6uO8DFGZVM2GtzAeZJYwt7fKTS9NWez4whkqJQuu?=
 =?us-ascii?Q?RIxALmY8ZXnVx9yw+FKYKKQ7aAmKAaTMZrU36LTWsK6M1hhZ/8w/PWZf2Pe5?=
 =?us-ascii?Q?rksUSbABJP6cjRcpWe2DQKLegHdS110NWn6Y6Yq5C6Tn+8dUXtjhlslRK7tb?=
 =?us-ascii?Q?QaFt3tlnqKsnMb2D2kYl4bdL6FhAWHTTabIRCUIE5n6/ahx92GpyLhGOW2fW?=
 =?us-ascii?Q?GDl53VEPiSwPbC0TeAfei7txERHlnNuK7382SaB4s1LmYSNNTgCmxljP9SR+?=
 =?us-ascii?Q?H1u8QsJbtEQUUhu9+0bvJHqmXPRWBF3BGVS9U/R/B02vE4PDfGVwPy4VUh9d?=
 =?us-ascii?Q?PK+rQ/+jTsuFibIZVdroeJeEBcyll2UVH2a2hC5ZoA6b4eKvlYTxnuTx29d4?=
 =?us-ascii?Q?303nILWUa3zBKlWdwys2vwtEluFCswx3rCGZmeTwEt3wu7clNR13QxdzAGsX?=
 =?us-ascii?Q?sO94x4BQiTZ5iz11DwMR4KyeD+tD2AxibpAybK377K+gpv+TUxJ+7DWfFXAF?=
 =?us-ascii?Q?bKcXRFCpY2wLIen6oFsYQMUHjl8EIx3donteLZgSd8iF+psiHNFdYWVu4wAL?=
 =?us-ascii?Q?DCFkHEmWl8jlorpcmU5mr/Itgz3Ua5onceT0694n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4445225e-4bec-43ab-d3bc-08dbb8f6380d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:53:04.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuc8bGPFoIYhUzRWHGAc1FN3lNUzA2zAAIWCGDDjPdxxuWhKJiR636BoSs8B/57zqOmm2NyAQjTBIEd+4BeDuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now damos support filter contains two type.
The first is scheme filter which will invoke each scheme apply,
second is scheme action filter, which will filter out unwanted action.

But this implement is scattered in different implementations and hard
to reuse or extend.

This patchset clean up those filter code, move into filter.c and add header
to expose filter func.(patch 2) And add a new filter "workingset" to 
protect workingset page.

Do we need this and cleanup it?

Huan Yang (2):
  mm/damos/filter: Add workingset page filter
  mm/damos/filter: Damos filter cleanup

 include/linux/damon.h    |  62 +-----------------
 mm/damon/Makefile        |   2 +-
 mm/damon/core-test.h     |   7 ++
 mm/damon/core.c          |  93 ++++-----------------------
 mm/damon/filter.c        | 135 +++++++++++++++++++++++++++++++++++++++
 mm/damon/filter.h        | 119 ++++++++++++++++++++++++++++++++++
 mm/damon/paddr.c         |  29 +++------
 mm/damon/reclaim.c       |  48 +++++++++++---
 mm/damon/sysfs-schemes.c |   1 +
 9 files changed, 325 insertions(+), 171 deletions(-)
 create mode 100644 mm/damon/filter.c
 create mode 100644 mm/damon/filter.h

-- 
2.34.1

