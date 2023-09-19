Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D27A5735
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjISCBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISCBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:01:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B094
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPFdcVmae30HCPKabw1AdSsHMqroM4/qaqvTjwZs1B+hU9iCaXVYrZayAfpUron6YujZG3+kGGLCEYc2wqkq+gAmYlllvMUzPAJF3ET/9qJf4d7RC8gLcpEcgJ2xIcVMtl8gp/XGDAH4dm4jEoBzxTROlwrA84mBs/5pwoIaJJIFqQsxD86egYxFCYwGEiL0gyXOvPXRSfprtWGQl8SEFEKBi34EEVuoqjg5f9PYlCBmFpURok31b+Gw0869PigNH6q9Um4SHrN4wqJzlUIZCi2C3/5FTT4X+vf8zk6GmqXdvUOAG80LNuMgoDBZqNg8xqeRv9RTR+UoMsX0doK3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQevtfHBq9GksYefzKrOPC7J9UHj1W06K5ClUJCG4b8=;
 b=EvP+LE38cr5FXol9bfprighJjHNG1G6o5MXrjI1QYaX/1tzp0Xmd/A/TCgAFbO5B7KT2i/SvBzppVEOLMm3Y8dfzD1G0fud5enaiD5nkCRdkPtHR/drB4h/hfg8cZKQ61AzsNGHfGZjNP67NJDOHAPzAp15c9W0zgBaaKdacMvd5uaigCmM718qPxr3+PIgHc395h3OJTJcWg5aLzEs6V+I1aI4rFTfzPbhtGeyykSMC1irKbaHiww/w5SBAaz/FZbn3bkqn22dsc/wQUjt0yqMXUwZbO0Nul28xS+wbv7iPENAwu+d3Ki9ZCoJSLI+4vUTpA0cHWylLP6+ar6bzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQevtfHBq9GksYefzKrOPC7J9UHj1W06K5ClUJCG4b8=;
 b=QYFu++9insymdNX0Uf3G4CgwJ1UEI8HHWgx9IxhsVMBNkgDXU3uOfwdbNRBjS7KEsSHVbbRyPAAZzbnmh6v2pEryeIDuOSueGRnsFpwKndG5iKHF7vxZyVqq2Rg2rEaHk6uqz66BNvM9UqoESG8TmQUdWUU4C7QbD4cKktUJIL2ed+15zZuA1ZTHOQVivMp9nvQQBnZZO8bQCfMzggMxcrfBaDfDScOoCkTbR6zA1PTlrN8PKbdGudDni8W+UVUZMcMzVtPHLKuQolKUtdKEZX4CmU4M50Dts1s84JVldh+iznIofxMUYOV3g/4VTWxz20DJHwzc8ctpueFLGtWQVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6478.apcprd06.prod.outlook.com (2603:1096:990:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 02:01:25 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Tue, 19 Sep 2023
 02:01:25 +0000
From:   Huan Yang <link@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [PATCH v2] mm/damon/core: remove unnecessary si_meminfo invoke.
Date:   Tue, 19 Sep 2023 10:00:57 +0800
Message-Id: <20230919020057.29388-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: eebe33fe-a60a-4006-7c7d-08dbb8b45435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dDKYVOzLUaU4DMIhAf+moBmwW7/DrdEUEfuxt8R++jwmbU/dTqCLkGx4Oa1DXyVa0en+VGgPDWQGKj2L9aGGMj+C3jzZlbovLgHw+hSXmJJOeRoj/AghZCYzVwcqljLIpN8Pb0DizSRuFq7vBFvMO3u31EdJtz14gVeyXs894pUmOnGVpTRzp5FbL5/LvsVCh/ui/wwzmNKepxLGSZU8oKeSF8vQBk3aNxHOAahJw6TZ4a6sZf5kB4Thm1dhuXExDOnliuL+hfXXwHMjK4G8YoFHd0edV7Zfg48iH8YMbQna2NPSUoMIJnJfPbdB39B3PRSf4qqSPfsJkmO0SrmI4d1Uj7vVBwo/E3jWqNesETnsnCdrV0FP5gCLqDk6ToYCH2BaHkm3OXIzTA5TJAwR6AF7szCtsZtF0X0mMsTvEE+r6oWYNZKIXtR6H5jjyX1I63hyGFRgOOhb2ui05+3M25WU9ivdCYNkpRkPS+HggN5wn+1iQp8tld5F6lvd9UG0uDMjAqR34PIsYO9jmj7yYtOoIiWyJFuvJP84CPaueEezcJg4V9GCkB0zkKsASLfPjJmMcgKdPE3tRb1pu6s4Tnf4LbwJmW89uMtsgD2uMqWZbOrSXO/lE0DAQ07l7ZM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199024)(1800799009)(186009)(83380400001)(36756003)(2906002)(38350700002)(38100700002)(2616005)(66946007)(66556008)(110136005)(66476007)(52116002)(6506007)(6486002)(316002)(41300700001)(6512007)(6666004)(86362001)(26005)(5660300002)(478600001)(107886003)(4326008)(8936002)(8676002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1pIhWYvW0rX73qCfvWiMBEE8udJsaSh6a+e5BUd3Xn8M90EFZuoVVLFW+cDi?=
 =?us-ascii?Q?cEncqtn6ZhZVcP2NyHRHvEobDO6PQb1WswQzUJV6eXmo8MTez9ZyEQ5D7Bgr?=
 =?us-ascii?Q?60N7JSiho0pk1SRUz8HmyYKCE+MByANJUZtKo0XMn2gCl2XzDG9azarsIVuY?=
 =?us-ascii?Q?wPAetCWfTo9fNCX46x57hkIDOGtqqMBRcbgQLe+EyagRs26/wdNLmCzVVntQ?=
 =?us-ascii?Q?hSX+2zmO9BlBSVEnBjcy12jcHHVe8fc1/pyQJyKp/j5CxCudpEHoG3xKp94t?=
 =?us-ascii?Q?afsN7h/QlTxoddp9iiajW6R+Ojb/EFzfeXexM+FyylxHjkmVcHcI1e8Nz7Ty?=
 =?us-ascii?Q?YhocJN3ao3JNd+KUazHHx13m1k5NQQzbqMMYOVGgqd/FjAIZlRXAG2RFELjB?=
 =?us-ascii?Q?JA5hbx/eia/U3V0JoN0ErcmiX+j191yh4dJLExceM1EB3mZGcEyLuJu5XzTW?=
 =?us-ascii?Q?/Zf3myvBLZol52Itqbub5tEr0wrMpjo1eTk62I3Gtm5vl/QoIP5HNYu3Y0vR?=
 =?us-ascii?Q?nMTJjC7awSCd70yYtrkqvr2rtV9etObRG+Jww+xwIm7gV3ao7yHxk1v1MHhQ?=
 =?us-ascii?Q?SlGgirhz8X3WRpiofpbey+iqhTqnYvkXxffBL2Dshh4fVT4t2Y4o3LBAYvGf?=
 =?us-ascii?Q?QwVLVkPp5/21bVkLRwohjddZXUgLcXmwpgEIe5hEa6poWmk3tCW4lCuxlqPu?=
 =?us-ascii?Q?ZPJQXzNcfpizI3EF6FXaHW+hgBh3i2Yy+N0ewoS3N/GjJP/Brm56K5C4PcR3?=
 =?us-ascii?Q?UdkzUe2bza+OP5JSDxKYQ1pNPxYZehQDteSlLDWl/Ut19s11e743h/uXgzAY?=
 =?us-ascii?Q?JvapCC9pO9v5l5Wtzr4M0R92pqP6NMbQ3RfB2/BMIx/bqIM9vzrMDcRrbZaA?=
 =?us-ascii?Q?6DZ2oI6wWY9G/kigSu380d6DGjvVd2nSbk9duvqXKwxHjQo7jQYZcLRpDA8f?=
 =?us-ascii?Q?NkEKE3+lyDDx4E2FOFidG5n21/t7PeJ1DBBcPKxF0Wmqf/r05gFv3t4OKVNP?=
 =?us-ascii?Q?pCmE8Q5wyt+dfj0Cyx7SATVMt7b2LrCZa0O2N6B6ufGy/Ybt5VwgqHin+XoU?=
 =?us-ascii?Q?vvJVo/ibXcHQgPNiNVeLneKrTrrdWK2Fx5kJ8udUm0RMKgUq8ND7/rSBmGnu?=
 =?us-ascii?Q?6OYAkq5O4LqU/xo6F9hFqaPjE3+Fws7g59LFzpfo+/hq1ugTemUcHsaEaGIc?=
 =?us-ascii?Q?T78NiI/8VZhzlnJx9uWK10svWBrgFmQsQPfqwunoRiNxJ/em0qpR5422Lx2C?=
 =?us-ascii?Q?6EHGHVExjUGVh4WtDFLvkZMI0+ZjN4+64X+u6l1TDrUEUWw8pLFEPCF1+tI3?=
 =?us-ascii?Q?yoomRLSQTpk8dOETWt3g7AJJ5tTT469Mc4wmP265yuVqfjo7AwIIkEVUOCvy?=
 =?us-ascii?Q?wG+fkRstcbPkYJnTUd/aM3FOC+gjirCsTfbSVuqtonYIfOe4sk78FvEKF34L?=
 =?us-ascii?Q?m8TSfhjg4wNkM6h9ojoaCib50kiPhe2Iu4ON2BekQ8lTMKnCmThH0yI1q8Ch?=
 =?us-ascii?Q?AoPZVG9bEmw0fLnbXOzzTDrToe0M/RZlNI5sFBYulbzvTHF+kE1hdG+iWN6b?=
 =?us-ascii?Q?0PV+DTRux+0jc0O7QPQFdh2agl/UIXEbW2pK9O1I?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebe33fe-a60a-4006-7c7d-08dbb8b45435
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 02:01:25.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zfCZ3BOXHdFudFmEW8HJ7W8RaUU/8EiJl2C4UkWhj6LCwzeZawDtkWC7FrRhk48r8V6pamIRbSiwgk5p1USKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6478
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si_meminfo() will read and assign more info not just free/ram pages.
For just DAMOS_WMARK_FREE_MEM_RATE use, only get free and ram pages
is ok to save cpu.

Change from v1:
v1 fold free mem rate logic into __damos_get_wmark_free_mem_rate and not
invoke si_meminfo, just get free/ram_pages in global.
v2 cancel this __damos_get_wmark_free_mem_rate and just calculate rate
in damos_wmark_metric_value to keep it simple.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..a3f812d78267 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1280,12 +1280,9 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 
 static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
 {
-	struct sysinfo i;
-
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		si_meminfo(&i);
-		return i.freeram * 1000 / i.totalram;
+		return global_zone_page_state(NR_FREE_PAGES) * 1000 / totalram_pages();
 	default:
 		break;
 	}
-- 
2.34.1

