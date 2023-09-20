Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C807A701C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjITB6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITB6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:58:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B1C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 18:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTgWJXElbecwRC00v6lsTYff98ggPgovh0zYmk7oodQvXOq7MOYjtGeaOf51qLqvQVnzbj6XSxhGaIO2eLL9W1xPLgGcZGioFPPeOKog3HOLTtnwoC+3+Fj0ZBKmdQcbCEOeSL7BVEAJHRWY38F7QxnYzCT+vIxyheFeHsCBgQvKMKF2hD0HUescgQfU589aGI21Xv3PlrfBwcgOD0ovLBYdMHXpxjUONTZFsL7dqQQ67X6hk8XlbA0MhGp037UwCJxtUHpl7xIuFqJqCrk83HHrap4sOyE7aDJlR4bYSseSfq6bsA6vyfSDCR2OsKKghPY/3IS6EAkNKhLdKsblAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwFZKJqP6TASZx+Y2sllK4SrBIaFfq9nVZikO9rzKyY=;
 b=mqlb+OnhEvHkUddjeJZJCug8K2DyGTJADA5IFz0P8qHQJsJKQF5kCxrzT5R7M5A6bp++Q1yZunMOPJpBgRKc8rgnGuy7sohGAPiGom862PR/3fiF46AO/nWOycsDG+t5666Ne9Vanfu23qLjIEAxUTgmhmakT3ZsuXLZaLvBaseU5MU3j+xicKVpC8lmnEYzmhftqA1d0OFtaiGHdT9KkLQrnbsB0/iLpFoS5a93NqlmRFnrj2keU9Hq84Hn8KOaZVI3Lp9FdNBOR3fyirmTa5906WAemHW429CZYQUrI3Mo0XGps4Kz8wRsLH/4SNoIXPWWa5pP8pGkCYE9dACV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwFZKJqP6TASZx+Y2sllK4SrBIaFfq9nVZikO9rzKyY=;
 b=kpTjzCntSwFl10eVfWLJ+QWJI8loUlrv9JLF4Y4HZioYfq+rNRnrUK6k8uyirwYw7bEsliEqckqsd1bLHfnJvb7F05VEBirVbhXV2z1qH5FLKRkP335iKnAAX5fQdVZBQUTPyd/x6Y/+x4ECmOqOFEZoSNzjbZujKxyOEzK9p8Y0sSogQ/Xc3YR5XSeUp6l1+oJ30Pi3MLkyVAEvkNrc+p/q77ikNdaSqxIgZIOkQcDmjTErFHcazOd2ZZJT5/nbn9YRCOvJoA+5SR7RAs7u3xzQ2JVYSX1BoIbVLoP47Srcd/hxKQ5AIRnpgk7KTb+p5eTOF4qoWwNY/1AYsxjPyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6954.apcprd06.prod.outlook.com (2603:1096:405:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 01:58:33 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Wed, 20 Sep 2023
 01:58:32 +0000
From:   Huan Yang <link@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [PATCH v3] mm/damon/core: remove unnecessary si_meminfo invoke.
Date:   Wed, 20 Sep 2023 09:57:27 +0800
Message-Id: <20230920015727.4482-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7b38eb40-1d74-4308-ae9a-b6aa91a46833@vivo.com>
References: <7b38eb40-1d74-4308-ae9a-b6aa91a46833@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df8955f-c3c3-4611-e571-08dbb97d17e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6QsMJCQTunNPyWXMyi0vUBRY2slg3Yr+1oHI8++h0o9zFAWAa2q/6Xp76zH345BJBkOjCSGDBg7M1aUTbF+BYTKaoh5eqJ79poZsXF5cRGQu0IT2Wyv0glf9G2NyXxg2ndgIEGbFrkb/rUxnHuWUdZqRropjxJi+zXAuS18xCNodmpkS3VoS9yxiKbrXMpowOHnZMeg0nuCzDNhySXfMe7bf/D0eEIrzmsgmXU8kU3Zr/HF+fm6exwarBddfM20Elr9UZkoU558+cfrAJZVJo2HLVS/gdkhxI22Mp6yLT/dYc935mfzpWzmWrcJOEl3Y4s4hOo4wBee/Lyfmy9plZPeXgWiUppSImATJP9npvtWzVl00cof7gRz6zeBDPA3vyiYXqg5lR7bmoR0/im4e/a190q7eO3LyRYHf3axLmq0VgcNP8wHUA+6xlISuxptOUbmli2Pa0sceUhPelpe6gcqnaV84Be1kOBPguwCADlkAqs6lxXqguzfNGG8d1bkA7MsysHonsLdppdA49DiY0U7FFMaYR46imVKEhnsqVzIjI7nOVaS8zxjNh1cVYlyfoMxb7IZ6/T5n9z9aZc4B480+oM2olm/VQZO9cY2dRcabkAwqRMz+YquYi9d+hOz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(346002)(376002)(1800799009)(186009)(451199024)(83380400001)(6506007)(6486002)(52116002)(6666004)(86362001)(36756003)(38100700002)(38350700002)(4326008)(1076003)(107886003)(2906002)(8676002)(26005)(8936002)(6512007)(2616005)(478600001)(5660300002)(110136005)(41300700001)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uGiiGr5Slk+c71/58ubIdJ2e6n29/EqsyTpDubSFRT79+nvvvTANGgXa05jB?=
 =?us-ascii?Q?ka8FaZ5MTZy1cGQ7DlrHQmbAXZGeaw4pH4BUkWg+lZvJEx1KDS3WqqVfO+vO?=
 =?us-ascii?Q?bODV/aP64ZCygZJWQinGHMV6eS/400PVzIF7srDwvS2iwJpGUj2+Fzni7GdJ?=
 =?us-ascii?Q?8xJBZINOwnMv3BaXYvjYe0rKkGKVPcS5o1V/f9iFpAhLO/itpXe2fqKv/PHH?=
 =?us-ascii?Q?DW8tL3KcIkNybQuFNWSAh05bz+e9MvXdJimtiwIwndlJDsRPG68o1bO5WlZy?=
 =?us-ascii?Q?PiRngHJYnAGGQOgIsQEkU2AfRtNjy3B1o2SsoyIwXTejj91Nvm1B7jH04kbV?=
 =?us-ascii?Q?Q6vQZTA4Rg4OTtgSKoLk5WaYwPAb7Httbcod2IIHmsPMLcb4Jfpw3sVX6eB3?=
 =?us-ascii?Q?FVqefq5wGK1I5K/6AJC1liVlHgH63CXPLrYa5vK7ogOBwbqq+mBLsiQhoMzW?=
 =?us-ascii?Q?Ez9NK4vA+dbnhFvN+A+i6j9R58E9VZw2B7KGgslCDmBogq/UsTfkrNZcqz1d?=
 =?us-ascii?Q?NHPP9LkouzJleA9zuYEAYi5K/vLd2ZAIDvzuaHhhAx/IRH9zG8D0c+s6CPB6?=
 =?us-ascii?Q?3mvg9SPn4qBNjggJ47yydHFCoSdxkZqyZGFHjCEMnOdkmnsHUsyEBVEkQ2kO?=
 =?us-ascii?Q?F4ZWzoMwoXvQUUgF+7GQG41eKpfpp0qXzH/KxcVx1yNYwUtrw5nBWOLqVZ3x?=
 =?us-ascii?Q?6fze/J+gPZEyKfUyIvegeKT5iqJhll0/xILpBcEm51ZyRDOeIK4KdAEqPuiX?=
 =?us-ascii?Q?SbrGCH5NgcLiAXUn2/wsj1SZw5qQEBxskKSCwdbYWTV/knvuVTVKDTvUGMtW?=
 =?us-ascii?Q?tRVlcHcgyE0dFGkezba9McVl0R7N15PUzitisWZFOny0kFb/3gq2kxrrG6V7?=
 =?us-ascii?Q?2Kicn3jAJylAOQoIOoSbFE4JD6H24VRDqC/RL6FpCz+N9tnEQm8R8Ssmaf+M?=
 =?us-ascii?Q?Z4ukZEerREyWQb+uVrY+T2EZIYoSkWxNexfkhmtyJGNJ8n/9anhvo1Ebl6LT?=
 =?us-ascii?Q?tRMf/x7nDKda9AqKpCTxMXiMCljw0ytDk2JndjlapMkcj/DVVpAVAAZYwajr?=
 =?us-ascii?Q?cMZkns1pUiAIeygbXGoLUMHaH4uHV0i6Z2AZOULUGH+xbcJQfe9zxqjQ2BEx?=
 =?us-ascii?Q?sN3hNTrwKZu+4jxkgr5uj/xQNzmsLfs215/Yo7Aj2xNwCyLMt/niIM37icZo?=
 =?us-ascii?Q?j1CR9Gm39PG73+GUGlKOX9FW3G2lo/O4IuSRj20doxoaTx2B9es2jquh+m1U?=
 =?us-ascii?Q?clcAxM7/1/56QKfyiE5pnrACNyEXJZpbvp16tI5hD9YhPCOUhy+h6JwM7eh0?=
 =?us-ascii?Q?WxK1vDIMvRdbRgGJt7Imc4FbglhLSOlXML0ckVSpGoW7vhDhoLFh0YdIgoNZ?=
 =?us-ascii?Q?xfgQk8f8Tj4OmsSACVD/XGWz2WyeFn4StALOF5vdOYuvzVzwqOq6twnDLb8c?=
 =?us-ascii?Q?jhCXH5O8+uZ20jD9VaShvh3Ub/6k120AMcn3CCrRaTHOyWl4jAW7bRr+6lge?=
 =?us-ascii?Q?lmFqELabhT1TYCVPX5E2m/7NdK+WgFDLZTZpsvO5CXl6o5+rAHmGb8o0kXsM?=
 =?us-ascii?Q?Si6veQ8fX8YEWFy1vPdz32rXiTX67h9CS9uEvlzN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df8955f-c3c3-4611-e571-08dbb97d17e4
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 01:58:32.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmtY0Cz8HzitpF8N+RNy0TXqk79KD/ijUx4huF+/s6s+sLBRdbyCY007Of2dfD8gEF4xeIcwqFJac2DktvsBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6954
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

Signed-off-by: Huan Yang <link@vivo.com>
---
Change from v1:
v1 fold free mem rate logic into __damos_get_wmark_free_mem_rate and not
invoke si_meminfo, just get free/ram_pages in global.
v2 cancel this __damos_get_wmark_free_mem_rate and just calculate rate
in damos_wmark_metric_value to keep it simple.
v3 fix changelog format, fix code style.


 mm/damon/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..6ceb52298904 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1280,12 +1280,10 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 
 static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
 {
-	struct sysinfo i;
-
 	switch (metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
-		si_meminfo(&i);
-		return i.freeram * 1000 / i.totalram;
+		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
+		       totalram_pages();
 	default:
 		break;
 	}
-- 
2.34.1

