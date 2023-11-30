Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2037FEB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjK3JNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjK3JNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:13:38 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C646170F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:13:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCS44CyhesNKcR2TwOdQBphoy7YuOXrmdilUfqeWrkpxGXiGKEQ1xEyMyQWHPHm78LSCBM/Go0RVRHV8WB+XKIXvMYT1pYUkx0aWxaziUuAUdWnyXTSjRl4fo5gxTyEscVF+K8pieVHNJR031ZvC3Cfi6Tm1wvBI6cDA8LLrdUudNljyHRldP/RaJJkF1oY/Sfmc8NXpDlDxQB6QT16yWsXbwfoienXi++oy+K9aY02HuKBFD6i9LRcyHOoqfrXZYibGU0LEN3uq7riwdq3aW3dDWdj8yBE1/As+6RQDGo5GO/nv5bXvN7Pb+2BKkpcdPp3ufF3HlQdyy/irSmUynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBUMAl0H2V0yUdg27JTNo8RJJEBgbGxnRMuchy2OGi0=;
 b=dxDBlNxbMnV/tLv9gSD3oGPcVWQtYyncsbRIhdtqvZ+iObOcXM+j4dUCUIGW2SWijQDMbWSd1zvm4SK/ZZowsMziu5h/+XDs0a95m2X2B5v+aqd3oG8Voln9402YrLHLk51qIfF7bON44NXa0/7nHzWdp9mJcCot7KB0UqFE9vEkk8x6Fryg16zFbKaxAfiKSSej2hSaq8+0LPd6UGq6lJL5md7xsqLMf8j17f44k3npDcuaTMLcq2T5cZYOYJKauh5Nj/y48CxCkQWUX6FGcfYLf1PlvyC+D9P4evVD65rJSYgPYUQypB6zMH/Uk3/iOyZzXVkrgfZPV5H5KhSGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBUMAl0H2V0yUdg27JTNo8RJJEBgbGxnRMuchy2OGi0=;
 b=H/PKb5/qKQ13V77R8YYMd3T8UTB56YNicLMkStYTIw59VOt1Sl0JaNCzwPU6V33m7Kdwmzcs7xsWZt0pGXA7OXCAi52Ed44TdIUHmqM3b+ZyR+KpyNuGa2VJoxm8Po3/X4Lt7EYQ0mjwKRyw7efo7E1YOSYfc2WT4wCLz11jfrn6l8flW+nrUuiEbBWCHQCL+4tYTnGry4x3jrUD2L0CpDDz206bYX9xdxqxRh56/zBEqvw4cnFmORDtUuPunWy82qpAaickMUPw0eLsz7+Ssa+WSCDbcSVXPgkOQOoMmU+2c3b/oeiAlQuO4VbRS1+rPQCokXv4jUNSXqJsehjXNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4068.apcprd06.prod.outlook.com (2603:1096:820:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 09:13:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8064:576b:554f:5246]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8064:576b:554f:5246%3]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 09:13:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: compress: do cleanup in f2fs_truncate_partial_cluster()
Date:   Thu, 30 Nov 2023 02:23:10 -0700
Message-Id: <20231130092310.1297336-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 154a4494-7a47-485f-42ba-08dbf184a2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxRUnMgUyPbV0KhAar9fDRMJDO04bruMkFIJTj+TaQwBjSy7PgDmAaLU/nvTw1Ih/BpVZtP/pl1moabwvbd8RzBA3fVqIUyC8N+DFWJQbHjd3rB//eL45F55Ktq0eZ8B7T84O//T4Eu5jpjiFd2S1Qo+GUkfCxwPANYbAMrXdFUcUSwUHU6BWm9pLm8j5c5Tzks/vI42fT1npBSwgAJK1ZU3CGa61QF/NgIFEXk54sJeJ/PsY+lXMCqZaPa52OcRinaernzcRuaNh+Vj9J/sknU4zoXCeIe015OD0Cj+b/KQM+mTYJo1SbVEosBtmdmmSEBTUaSJbXOCRIW3C/FPL3t7BxPSKVtA8aU6VdsoueQmA9QwWyNEpGskXCHT7Ry2qusEvDI5tURkzri+PJWad3vjrH8alpcYng6puKaXZbJ2YRgEj1iTSL6WiQPW0b3zAjxSFuJsfldIcRvnJyT9k9+tqfiibPx9C2T/6eZMjkZiG5KsfwW32au4YzoJMjWHcZsDuT1Y94KzezyVI+e+nOgJmrfy+HZ7WJeV2LDJ09CT8pNR9eu/2Z7H5uMc1wkSiaFoMgKwPdW7X9cn/egEmDEysCC5lxazSIp6qI/+bD1X1ri5A7TGLq/ejoBTM+kf1bxuy88AhbqZE/Kv2ERwp1FC8SNCSQ4DogL/sBm5ZV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(2616005)(202311291699003)(5660300002)(52116002)(6506007)(4326008)(6666004)(8936002)(86362001)(6512007)(6486002)(66556008)(316002)(66476007)(66946007)(110136005)(8676002)(83380400001)(478600001)(38100700002)(41300700001)(36756003)(38350700005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TceAfFYlhZ8UhuzYaeMFf4CHk5eA0oelA0hV7kGRYb+0E6hdhbOPG+p9YK68?=
 =?us-ascii?Q?APn4Q8YKGVhErxy2TqJN08PyXRy7b6eEeWCittjvF12NXnpI3ZrquWGyulV9?=
 =?us-ascii?Q?645pL4M5U65Wk4Hl+h2kJ7iFSMvAXyMAyLZ0VVf9UXAxnVE25owmp7ibvnjV?=
 =?us-ascii?Q?3FQkcVRVgHbb/1h/pT5Q38SZDE1Ydp8tuelurFAkfE5mkKqyKAOg9FOz0sl5?=
 =?us-ascii?Q?gVcAQwHMX+tmdG95d8JEWfxv4d8qJi6Xsk5cOooYbWng8K6v/jkiybSRzDNO?=
 =?us-ascii?Q?wZgqJ68eH07FB9Y4IZNpSQJGo3eCYP8psMINSWIfnkp3575aVwFl5x9BqfLV?=
 =?us-ascii?Q?1HsnLwbn8CkQlKOV9yprlGgGNJ5xwFJTsPm+FaeSzTnlgPvsn/0/CS8NGvBL?=
 =?us-ascii?Q?I274SvvueJ4PtIiswBunlVTYHAqC9XmKA/hX1YVrnqro/WurVkCvVyrqOhcC?=
 =?us-ascii?Q?FKFy965VtViFXu+USHR2heR9WEay4GjnZzqTVRKF2+m2PzX1VtCL/77ZpOKC?=
 =?us-ascii?Q?ajOQlDb8m1NWvGuUJ/m9pz80t7t6ZqMbQ2UZ9dyRJXFYZxS2AgxttwUS2S2e?=
 =?us-ascii?Q?yakgakzBb5MsuTS2GWbgwvXBVRBVjPazzW6RIMydkU2aQUs1vCdZA/oMJFJK?=
 =?us-ascii?Q?cx4bzMvFHeSnKxrsH5rUVBszrghkVfACutJ+vBDRoAFCY7qVEee+97QV7caW?=
 =?us-ascii?Q?hnu51P1lnqPM/4x6DGkpwE8uhCJnreRUIjuzRH+dsUxkkh8aEeqqOnO/OBWm?=
 =?us-ascii?Q?906KzBoHgk9wSJPkDQVCQQGCxhWR+10VmrHkPRcnnT4zw5SAssAUbaLI3MCL?=
 =?us-ascii?Q?H3TxF7XTyErAl25Hvo4/r5nUWup7fU1wPXXU0FhgXgnlmfKf/n6ccTqoh+bS?=
 =?us-ascii?Q?g4pYekHMLV05zvmmECRTPl2xrR9R01UEYODHB6daQTfMM9z4xZEri2bkPMrf?=
 =?us-ascii?Q?PWzbFja1wlLL1eiR3kqp56JpmzZ18ZXRmMtazREIl7kCFOUyJfyJzPfAQY4g?=
 =?us-ascii?Q?MXym2tht8EVCFjK7IgxSgmmYKlr16W55Kmu7SSIEp8ta0+TneBCEUycGOGPt?=
 =?us-ascii?Q?+kyv7pTUKIa3HTl3+qLBOqfNWuNHG9tYC51o3D2hylZ3PN+9CbvON/5HjnNI?=
 =?us-ascii?Q?FvwdOT58nc/M0cytakbj3cz5Q+Tl/8G7vqAv0M1eQDbRFQoVK14horiS7mlU?=
 =?us-ascii?Q?nCEdvDvk1Q77IoErOo2UMFpvFt58wSk6ppPehq3vnzmb8v953gpJ62x6yhDw?=
 =?us-ascii?Q?/8KYDjCmKNFgPiUPROtHHqTmPywhf3qZ003IO2W0qAckQulAzfw/hheSKaB3?=
 =?us-ascii?Q?He00S5u9ThQbLOt+tkoCU+v4C7JQqJsJHz6cr4wutN598FkCAJIdU8LCQn64?=
 =?us-ascii?Q?NLqLOhZPCgLC0QC3seo3RAbWO4TDFl7Y1ZQwaNLo/SlxoMPuO8hzJpRiapPu?=
 =?us-ascii?Q?2r0pt33eMqHzoktt3FekbuysjzG0uPkpyq4ewF7yVendU9lht9WmpiFz3n7z?=
 =?us-ascii?Q?9EDT6NsxDKv2+VnH7yvTk68c/9PPLpSs2Ysej02B+/Y6+w5Bhiw5VZ5cPJFW?=
 =?us-ascii?Q?U/pq4l/cFSJGJNpeEzVb7OMnev024XqNHBk+oK2B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154a4494-7a47-485f-42ba-08dbf184a2d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:13:37.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIdQ0hj4mFTT2c17r1/jthdmZXAaEsZHgoRgqjHpSd465wJLdwCAOrApak3MTuJNGrCNqatsKfo64YKOJrYrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary code logic.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/compress.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 36e5dab6baae..de55c266509a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1170,7 +1170,9 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
 	pgoff_t start_idx = from >> (PAGE_SHIFT + log_cluster_size) <<
 							log_cluster_size;
-	int err;
+	struct page **rpages = fsdata;
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int err, i;
 
 	err = f2fs_is_compressed_cluster(inode, start_idx);
 	if (err < 0)
@@ -1190,25 +1192,19 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	if (err <= 0)
 		return err;
 
-	if (err > 0) {
-		struct page **rpages = fsdata;
-		int cluster_size = F2FS_I(inode)->i_cluster_size;
-		int i;
-
-		for (i = cluster_size - 1; i >= 0; i--) {
-			loff_t start = rpages[i]->index << PAGE_SHIFT;
+	for (i = cluster_size - 1; i >= 0; i--) {
+		loff_t start = rpages[i]->index << PAGE_SHIFT;
 
-			if (from <= start) {
-				zero_user_segment(rpages[i], 0, PAGE_SIZE);
-			} else {
-				zero_user_segment(rpages[i], from - start,
-								PAGE_SIZE);
-				break;
-			}
+		if (from <= start) {
+			zero_user_segment(rpages[i], 0, PAGE_SIZE);
+		} else {
+			zero_user_segment(rpages[i], from - start,
+							PAGE_SIZE);
+			break;
 		}
-
-		f2fs_compress_write_end(inode, fsdata, start_idx, true);
 	}
+
+	f2fs_compress_write_end(inode, fsdata, start_idx, true);
 	return 0;
 }
 
-- 
2.39.0

