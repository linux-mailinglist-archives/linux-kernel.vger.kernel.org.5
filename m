Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D37797361
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjIGPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjIGPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B13DE66
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DndtovPCeM6CL7XBjFF6JEMGNX475/qvfDL4Vjc2hTOb2hDaQu8G9+Fs+xD361TuYh/aDdc8a2CbsSwHEbvK/5QlRV7rRGg2iJbC0ERh3+8Y2ZsPsQnxo6g1+7W1nt6BAytRFkkASjCafe7MR+NGlcgJNUBrO9x6vb0Rd/++MHsrPrpymHo3nwjCfS6fpNsp3+j1e3sqCDpP3ZnNb57oaSBZuTjaZ+URgjmLEb6DQqlW8rfGxrEoGpFhq4U83sIh7WO9r3QiDk/YYvybk5038Fc80ufwr+lcTjEYrAHPKXDBUklnIfSh4usrVOyVrSTwCk44Jey8fixkwjZBTIGGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJlUdLZHWLiINY4h+QshIeymsgrAoPH+3UZgJ4MDXZA=;
 b=oSrG5gGqNmm5L4yiTlLyhRIsf8B4ktj8yvjTOykLmVjKTQY1Xa6pOMfFwP5ETo6K6MZJnmpN+Wy60ojTR/I75HKqkTqqnTrbiggP/jiTzY940Xj7Gk1IWibOIFSG76BHLpsoVQWzXQ1rxXkYS/490zZ63lYZ/75l0SCxwrjUauAwd5KgjgzfFn3D/Glo25H+gk7ykY3orLRVj1EgDkJKYtiEJNLBSyFGKFF+unq3tXFqaaqWlSrzd4isaQS1K1DoXfB2l+lbYYxUrB7uiaAkvmk1OKNZn/MqP1OMGHE1mcNFZiTCsV6Aj+226Z+lFHtyaPkaj0e9nvb0TLiGLQ3jcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJlUdLZHWLiINY4h+QshIeymsgrAoPH+3UZgJ4MDXZA=;
 b=DOc/c3DzxkA5lTI3t4MOKrPj9ZucGcWpbPGUB14UVyLve3AaTfbGRMW9cQjGKHgqmjsj90TrJOnQQWLwaU97QAdkEeqHsoHBKeAocw84Wu5ChJBvpUDIniQzkJ8wmct+nIVW46bl4Tv31JvYuynlEf8eAHa8yXhWZUOEzKOmG0FhSntxHzex/DsljpQ82rrj+70zSYnSduy/ic3Onr0ZSpjfKEEJaC9OQguV1XiGlLOLyTYcUO7x/CEXR6TBL58e+fQTfzJNvKhueIyr3dtfjivcWu0zbBwUcriEwuJO+Ex85S1Olzooe2nH5Jja0FIJf+hDunCXD4OBfZ6qqmIIRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB4249.apcprd06.prod.outlook.com (2603:1096:4:155::5) by
 SI2PR06MB4249.apcprd06.prod.outlook.com (2603:1096:4:155::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.36; Thu, 7 Sep 2023 13:19:50 +0000
Received: from SI2PR06MB4249.apcprd06.prod.outlook.com
 (fe80::9860:f43b:19bf:8903%2) by SI2PR06MB4249.apcprd06.prod.outlook.com
 (fe80::9860:f43b:19bf:8903%2) with TransportReplication id Version 15.20
 (Build 6745.36); Thu, 7 Sep 2023 13:19:30 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:04:52 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 1/3] scsi: ufs: core: add wb buffer resize related attr_idn and exception event mask values
Date:   Thu,  7 Sep 2023 15:04:06 +0800
Message-Id: <20230907070439.1546-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 228bfacb-8449-494e-db78-08dbaf70bbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L3ShNYQ8n6ljAoTpfCgh4iERAFH/djS6BUzetaz2Ct4xU9+xCwM2RI+ghlrhJv9lfFh08B6dGBxo8U/B3zcs7UIPiZTQPAdawsVimZMT8RFPZ2DwNYglLXtrNOK2iUtYqaouRzH2mMMaz4usOVYsH72mu4fgnM4TGOqwIiBhyhsC2kDXls0eBnN6JwjHVXpY3aCgl+zPbcqC5wzTzdfaJt7NUH7qyBOy2uzE8E/z4sA1GLykwP1a+z5/TSfjNuMqeCElr3ifDtDbZJjdr71kaJScR75s5+6I5X0R9ahVS8DedysI84SPUdvagZT4w2Xb97ooS7Y+uBFd1Fvzb6FC7m0HA+xUky63eXRotskJBYwABn+xuLYMFGxk2swWuXSZqmVq4unNp6k3ITQWM/htGh7HUQvN3YrXLXJV32R36mpR9SYLHdGLuAavvEez7Rs7p44oF0VA8srzTMp9Yu2CSGk/HOI9krkcpV8SH95UzQ+AAUJ42jv3ojkY9p+W96rtavGMxmC9MA5Ckm/YIIy821QZdUWWyWhJAyxd1AAo46EzB33ZDNLs1t+hodknHVos7UkNH18HW+dclCQgq2l2SnTBGzJfc6LF/EscLNWVDocWA0QnH+BEkY+nj5ZPUba
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB4249.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(6506007)(6486002)(52116002)(6666004)(107886003)(1076003)(6512007)(2616005)(83380400001)(478600001)(26005)(2906002)(110136005)(41300700001)(66556008)(66946007)(316002)(4326008)(66476007)(5660300002)(8676002)(8936002)(38100700002)(86362001)(36756003)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUD8hJwpvbcHkE++2y6rKQ9UOkZ/CP5t13xHX+88MqEWs1G+0Apo8HjVM0ZU?=
 =?us-ascii?Q?O6AOC8xMDv2QIr2ceKY1/3UABCKjAL6afsu9MQBpJs7RivUQvA4OQZTKT24y?=
 =?us-ascii?Q?XPTDGgqHTBukxbRh5MGzuAXK9xOpnEpnoqKPBFtgpwy/WC9eukGu00nvPZIi?=
 =?us-ascii?Q?mbxn+o136Zve+WmA1KgC0s0YYecmteQliLfrIn10a8YLR9ATX9qTv1uvTRhX?=
 =?us-ascii?Q?QRjU/5nRxFbYZrX5DQVkSHwKt//4EQBSJSyVicmhZGuCGMvPSrlIIuKM/c0G?=
 =?us-ascii?Q?hOwpUKOUOtt0hEbx9li8jFfdvnyhiIAW4yxLP3bgoB58GDmKutT4GgDVleLd?=
 =?us-ascii?Q?2rbifnmGz32Bhp3G2K4cJ68PXM76fwH0itTE4xu3yesqklUqtmBhX+wrZAMy?=
 =?us-ascii?Q?vWoP2vVwGWm5bYWv0Fvpve4bWIetAxgRdqnNcBZGsshuT2yDDq1zOWP9ro9P?=
 =?us-ascii?Q?ZvJ3zTqWWSE362Miw2K59Xq6Lq3tCe2vLJ1kvnaLixwooqUG4ys8EEItM+Uh?=
 =?us-ascii?Q?ejMN+UfxzbKoTNkhbNuN4atW72QoeiGAGKvWpMvNaCJdzHrRNRxXUHFM5DTY?=
 =?us-ascii?Q?9ot1Bk92EGRNHC81au/f0qfjm/iUIYaiMf8643xr0SzOcFxJXAGorD4E4rfs?=
 =?us-ascii?Q?8QeuN/yRe8WRAiyx8qqBrTcwvHRzK123HtfdJD8nJ2DM4hPgmeMDBbcBocZm?=
 =?us-ascii?Q?tAZt+eOxl92VSRx2e95KU5Pry+9z2R8SG6PwOE5eCBDOcqqheBdlhpLdntZk?=
 =?us-ascii?Q?ls6XVfcewov9zNNeC1Fesv4HLwEmdBrbRziPg+aTfYeedTCXoaQ37RyxMWF7?=
 =?us-ascii?Q?kBNUVLpFU1ZAXIG+Nh+GqOVROX6m7uMqUG8KDaUeVHhNHqY4szD5DI+G7lqx?=
 =?us-ascii?Q?PBLSspX0aOmF2NNceVagPK/nZhH50620PJPovLeY2WlVZesm0OmUYHhE0JgZ?=
 =?us-ascii?Q?y3As61C5hyRGOxzQXcWJpCcfzEHLYarzcCKO3/k6up93MXZedQ4yealSoykT?=
 =?us-ascii?Q?dQuZYnkc0nahJMuXwaEe7ITy1/UATuPfEurKJoq1u6o9Q+94jYEpqXnZJR/6?=
 =?us-ascii?Q?18LPcw6wKdE5uF5FfTk7emV5/21XakxJWbZJijz3WBE/CyW5Py2ly9vdr57A?=
 =?us-ascii?Q?fdqAmHC3NV84m+Rue/lwC9QGIvxXWXtvTLwYVdtXMFIhPpYjc5eAc+uEvXFd?=
 =?us-ascii?Q?ZkMob25L9HjPJNzvMbP8XZnoMOUPy/PrjmEnVINFww8PA00zK+s+nk1iPaWA?=
 =?us-ascii?Q?2kN4ujaPSZH1JcGTkWDRSfHugZGKt3Ms4Gc0eSBVP2+pjUc7VjUu1FsDR32M?=
 =?us-ascii?Q?MNdp5YQdNK6GOyYMKO4eBkqb15YLPcmWWJnGIdXCdViwULx+WDy7Vl+uWAJU?=
 =?us-ascii?Q?JQP5aeqEHPnDekCLOEdt9fGxn60p0WeVCjAVBkQTh4Wb6t5j4UQOJSAlzEEM?=
 =?us-ascii?Q?0ZKBZqfnHEbvYzKrxSlz3wqN+9Q55MEeznV8pPlmeUyAeKe7ecZu28S40pEv?=
 =?us-ascii?Q?RHIaU004ZXJe7essPChwzTB1Q/dr8VAovW8dLoxq5iFO9eSCCxegLIP2hZR1?=
 =?us-ascii?Q?E4Yl+xahjMsbgI2rAFTrgqazO/nKj0xDtIMt7TjA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228bfacb-8449-494e-db78-08dbaf70bbac
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:04:52.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spNludLJ8pUkuZ2Ibqi57EtXy2CP1Z5c7TIT/zIsU4Mko/PASA1jAUgplz2FMJ8cCPMFs+vN45OyrX0rQPpMyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS4.1 will support the WB buffer resize function, and UFS driver needs
to add definitions for attr_idn and exception event mask values related
to this function to support this feature.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 include/ufs/ufs.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 0cced88f4531..d9dca1b9eb08 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -179,7 +179,10 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
-	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT	= 0x3C,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_EN		= 0x3D,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS	= 0x3E
 };
 
 /* Descriptor idn for Query requests */
@@ -411,14 +414,15 @@ enum power_desc_param_offset {
 
 /* Exception event mask values */
 enum {
-	MASK_EE_STATUS			= 0xFFFF,
-	MASK_EE_DYNCAP_EVENT		= BIT(0),
-	MASK_EE_SYSPOOL_EVENT		= BIT(1),
-	MASK_EE_URGENT_BKOPS		= BIT(2),
-	MASK_EE_TOO_HIGH_TEMP		= BIT(3),
-	MASK_EE_TOO_LOW_TEMP		= BIT(4),
-	MASK_EE_WRITEBOOSTER_EVENT	= BIT(5),
-	MASK_EE_PERFORMANCE_THROTTLING	= BIT(6),
+	MASK_EE_STATUS			 = 0xFFFF,
+	MASK_EE_DYNCAP_EVENT		 = BIT(0),
+	MASK_EE_SYSPOOL_EVENT		 = BIT(1),
+	MASK_EE_URGENT_BKOPS		 = BIT(2),
+	MASK_EE_TOO_HIGH_TEMP		 = BIT(3),
+	MASK_EE_TOO_LOW_TEMP		 = BIT(4),
+	MASK_EE_WRITEBOOSTER_EVENT	 = BIT(5),
+	MASK_EE_PERFORMANCE_THROTTLING	 = BIT(6),
+	MASK_EE_WRITEBOOSTER_RESIZE_HINT = BIT(8),
 };
 #define MASK_EE_URGENT_TEMP (MASK_EE_TOO_HIGH_TEMP | MASK_EE_TOO_LOW_TEMP)
 
-- 
2.39.0

