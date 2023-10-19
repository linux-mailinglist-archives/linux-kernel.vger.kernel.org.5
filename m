Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FF7CFAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjJSNPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJSNPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:15:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C19F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVgxGL0IfKP5BsYpz2xx1YpLeAnl8FYLpbrfNP0ul8fUVvSArm/xcxGWsJpIIii4IKJa1Z2abtEFmtLz+o0A00z0cG8NViZJ8a0ruMD7cHZ8rTKAsN5MNCLIZ/z5wQZW4qThprcLx4eghi8TWeGChYwW/oKN3cBxewoOI9Js+lMKHFHknsSxRWYTNPgMUdr3q7VC2COjROEfrCF1315Ce6CKwL/tPNkNXY0aVsKI14ziAhKop2MiuinJaz+d72N08FfETO7H0kreImGCyiiuJsxUO4cYa+gIp1kJCLHqHF7pKTxkRZFS9tJQMh09ut6s3m+CnkwDehIiaE2SOF5C7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+W6fmJ72ArZzY33LmCyBv0xsV450yR0iejgRMpA4iw=;
 b=WzlWUazOM12osh5dZOY1RC/azrBGdAVdhRuIQpmW5opup2SmM71J+JE8sv2F3aMC2oLwkhlA1ZFhgnAaJVxFzkCoNIYI7obxGwbMTePralZ7I7SpyHswxjNuoVv1b5cAFtZQCsCyrR/UOkF7qzeA29u4/HlMDBU83cxfiTyqlb+S5RTVw3QBeaHlJhoPM/f0gW+eF16jyJtGJEBpC/31o+itSYwwkx4PNDUid3XTf/eaNvRbHEpULb0wVpDZQ1ovcv8bpcw35WnFK64AyY3VOBeMeYoB1sIKKF7VwdaJtaifZzUL1Ztns+nyfKgG2G+y8CAMgNHDMm2m37WBTp4ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+W6fmJ72ArZzY33LmCyBv0xsV450yR0iejgRMpA4iw=;
 b=E4OhPqtByr1T51mLLXH1xZ2x4OsE9PvykU4CF8skgj9maG53gv+7ef8uTutyME6CtW6cmhJqr9iLts5hv5rjEF79NoKMMRhDPsW8Sl3H7CDEtQt1cvoC9MNm8OC1TKdFjC/pYpM35N9XXlCm56dhhLaiKOFLaHjSwRPNuJXSszJKSk/e5H+qQMW3e42Vd6E9jVPMtRCzON3O0YMT2ixWLFLQh9S47aWctrH2j2vARYcdAknViRH+iKdQH8h8KMoGfR2TS/Bicw7tFQJBqPqpQuCZCOmsyxCuDtsKIfOrdzJ9i2d2fkbqbpAZxjIC0/zG9NgFOhk2GW1nlbDNEz++hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PSAPR06MB4470.apcprd06.prod.outlook.com (2603:1096:301:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:15:00 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:15:00 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 2/2] mm:vmscan: the ref clean dirty folio skip unmap
Date:   Thu, 19 Oct 2023 21:14:46 +0800
Message-ID: <20231019131446.317-3-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20231019131446.317-1-justinjiang@vivo.com>
References: <20231019131446.317-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PSAPR06MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: b9920517-d3fc-42d2-a33d-08dbd0a5661a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQhOuWlQ0oT2Q+AJCAaqD8oJwWDSLRd3fyAgqfst0sOxPMFYT/Kt7xColcxu5dlcm0LWd0Jk4M5qxnCxMgEB0DhQiC4RKIXQsIEbXPCcfztnCJPnoBOms4QevXO8c2C0nEwDWJCMGdSwmpQ+k1NGk69HmYjBQroJ48R5/Nz0CZmqsrXL3NT2tKDlncaYA232VWDDAn04yPou9HMs+ygM3ohFxRJFJ+QbuRW4I40JiV1YrolXdLGTAOQAej1RoymHfjWvQKnXPKXS1CeKJg2vXXzCVXI3VJTj6gX52RCmCS43ZWx3YlrZs5+RINKoVPQyRN/sj5xSh4DR1HeWsOwC9bhgensyOQIWVS4ZJycUigsel1HFModobdiz94+zQy0poMHI3uhxxxIdmIUdLWX7KbEZa+LKHahmScwDo4aDnHHM8uE2/SG4HfcYWccY8K70idBWcZ7runSiCvsLsdPs6gLDzXB/EG6MuttqQvtjzaOMNqK2Efqc3Fpr85NLfgtFXTJv50LvGchLDmME23ZzWEO3yU5fEUSO5K8j1g7pjOAdshCDlb11CrpaV4htI/dmB2hgNquAMor5n4hSc0/fb8DWJAzEm8BS1Gc10c9OhTiojyaz2p8vH+UT+OEM4jWhQFwOUlRrtIBKX9cbKChnuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6666004)(2906002)(52116002)(6506007)(6486002)(478600001)(4744005)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66476007)(66556008)(66946007)(316002)(83380400001)(36756003)(26005)(38350700005)(1076003)(6512007)(107886003)(38100700002)(2616005)(86362001)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4uu7QOBAHDbWdWb5j5e3zRNghc670D7e1kMlur1BKKc1U4Fj0Ehi0vcRbVF?=
 =?us-ascii?Q?rWPysdGoVLul9zXQQ85kA5jFPiVMxKBJEPDj4cuVhO6cs9nguHhfeJ2Pa9rf?=
 =?us-ascii?Q?XiN9QOPvRnB82HEtYOdL/KW3/E6BezQLFlrIRXeiPLbtZihqC74pYQOAfUwF?=
 =?us-ascii?Q?K+6IO5Q13a/FDN2LXhNhOwcVhVEOZn0otAN2na5fflPxOPqI0IJ94Zcg0jGL?=
 =?us-ascii?Q?RiP+5HtftY7c/XK+nvDclGOCkCPGMEXm3DZ+iBZYnCQTWJW5k9KLp04QIKI+?=
 =?us-ascii?Q?amXyhqAMqoSp5TXtiGBkWtuTm7awY8cjS+t8XXrJHyGw3yyS9dBjh9BObFTd?=
 =?us-ascii?Q?P/EBG0c7yqx2T9JL/Wk3jFVkMtSiNweZDLIWKnLHXAWeqtC5bUXVdoUDPHcM?=
 =?us-ascii?Q?SaE1k2TJGsRHGazJBv+lbTYdH6xQn8EHFbvaWuEJfiuJ9P7qPpz2/tA8vKRf?=
 =?us-ascii?Q?M/9wPdB4abFFvi4NyNyPx9bs/4rDhjw3EEUkLmbDf0OxgAi+fQhdm1hCtEsf?=
 =?us-ascii?Q?YC9PJtXtBVMhWo/NpFPLTF/K2J7ZDBySQm/Pe7j4rsqxTQSheVwde2O7sNV+?=
 =?us-ascii?Q?/k5umd0p5Tzck9itaNStZuNbiwAC3VbC7W2bzlgdp0W8fAVElvDDpya57YiJ?=
 =?us-ascii?Q?eYGKWALK4V09nkL66ktwDYtd2Y8wCyFoeiAznTh0PM+YRkxvK8jd2DQM7ZrZ?=
 =?us-ascii?Q?LG/zgRHa7NBlD+yerDeXneegNqSy56C1fDYWDWXyxfvArxuaa2OPpbW26SXv?=
 =?us-ascii?Q?pUFhsm3AzJ4HXEk492RyWXLV0gG+C8FJc/dy7l1+2s8m6o5wlPLWmHFmHbvM?=
 =?us-ascii?Q?Lue87im21N5i43lyG9Mo623Do/pk4uy9NXmuSu3QG2gd++0tc6WP9/zZYmpf?=
 =?us-ascii?Q?mtXmMFwfiGKIYDYfNUUX6Uk3hko5bLmVb2V6V9PlkxlPC/80KgPzK8A1oba8?=
 =?us-ascii?Q?JQJzOz779hx5xGQzVDr6TbKhVIfAeuOCDGC1D4fn+Hi3GJ0Twfd/PSUSTa3t?=
 =?us-ascii?Q?Le7hZfwY4ztOxraW7Tl9upiUuPY8FRYdQdhiUkJZOj8dsni0MZfTOZ+5n47M?=
 =?us-ascii?Q?fK9v2om3VV7PAuRF6iQwCW7T+c7cw6fHwT1wZIXceeO8QIVhdgThksNy7Wkj?=
 =?us-ascii?Q?lcZYVDRIUtHzOrxJhGDqK+jkekNnh/KXQcCoiSs0JBNq8vlZB0dhD5rwKY0j?=
 =?us-ascii?Q?7S0I+gUgjm4W3UOVt0lWKojbAkjS/3ow0zseB6mO5xT31sSXMvPS4KPn+I0u?=
 =?us-ascii?Q?BGDPyjGUzJkURHQj0cesKea/KnkgMhzqvCUeCCcjyPZrw9F0RP5OL6ms7I4M?=
 =?us-ascii?Q?TjlTAr6M8qU6YCrxUUFoTvdMFduJFSuNDZo9z1/DLHIVBp8u7OyrTJJtN8IT?=
 =?us-ascii?Q?iOv8T2DWsi98NN++XvsKG8+qbOPrr8XzRB42x8IZFMSgl8WBNzi8xNDsO8bd?=
 =?us-ascii?Q?aXqgr6RciqP8Ci5TBiIAERdcOCY99tf9pgj46N8POj2ZFT8H2ljWHHpTig1/?=
 =?us-ascii?Q?sxAltp3lFCKDyyoAQrsWE1eU1nSgKfh2uClDfqy17DH5NYOBC+SZW0RwekYL?=
 =?us-ascii?Q?KUndvFnN3TYz0Y0HwXQUvybrrCfPaWeXk6ueccEu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9920517-d3fc-42d2-a33d-08dbd0a5661a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:15:00.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beufrBEs7jxiCr+SCX/viJVePdCXPh5heSnT22NZQ+jQzxwrvJLsGgqAIJtdbk0hJ0S1sK+8zcutFnd0Fv3OGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dirty folio in folio_list which is inactive file lru is
FOLIOREF_RECLAIM_CLEAN, the dirty folio can skip unmap in advance
to reduce recyling time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Changelog:
v1->v2:
1. The dirty folio in folio_list wich FOLIOREF_RECLAIM_CLEAN skip
   unmap in advance.

 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e067269275a5..e587dafeef94 100755
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1225,7 +1225,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			stat->nr_ref_keep += nr_pages;
 			goto keep_locked;
 		case FOLIOREF_RECLAIM:
+			break;
 		case FOLIOREF_RECLAIM_CLEAN:
+			if (dirty)
+				goto activate_locked;
 			; /* try to reclaim the folio below */
 		}
 
-- 
2.39.0

