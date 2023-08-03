Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2142576E6CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjHCL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHCL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:27:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7001981
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfScUSISJJrFTas41txtIbh+6sB2afJBpzwx0YIzgThrAGfqeR4bOHeIp3JKgwKHTb7fJnH2uRb1jRzhXhfXU5T6qztI3xAFYxghK3rXILlWuhmCdIzIVh+tvUkdvZ0oIEHTEsEyq3zTXgO9bzhixyuritHd4jDxMJZW9wbeal5ZDz+GJCwh8koPNkVvFtObzE3n86JLAXvPJrl/B1e08Y9YmXL5g3mngVFKidjI5rl5yedVSeds+x/Gp8JyaPJA6Hog8XzuMEhtZwi68TvsR2jM3g1cdxlaElvnOo5OaQG46oURC8wtUFeMmOjOC2CqUUWpyVjXAAyHgk4phjwPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB8mxzSIng9vu3IrJyaBj1eMhvqRf3yUTI3No1TS9VM=;
 b=Ea7GtiWlf84X8OWbWrUZurHTGYib2RYsoNpo941546596hT4vEfaLhEy4gzOFaCewu6wI4vzcu6gC7WpkOhreKq+/no+c5HSf8mUvYixHx01/mvVrEqDt8t9Fen1EYhSXQuaioQAkw9wcmTUyBeGg0SwPOZMCZ3kB944YEGkYoCRmCi9UjsZDtt8+MDAeafxkXNL4sbFqeI9UgpCpVN5hPlWyGiA26TQSKKKgqUMStCn1Kqv+lPq9HmDcg93qw1UVRqrnUBnG5pORJTj27dX6mjIHhCicLSd6ezkfyghFdk5K0MGVvCbQppBuLg2wnglLhMdDFpsHLSSHb3WFCKdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB8mxzSIng9vu3IrJyaBj1eMhvqRf3yUTI3No1TS9VM=;
 b=igr/vHzBqx+s6Re2EcJiJPE04dGXpaY4XnK4EmZ8dmAwLxHB23ZjZk+kHebBbrlKd0DPW7vQj4wIlLA5CYzfIVxWRMZa8nKYLi7sRdSnNwzlc+noeKm8xi6UzRiy6KiqnluI7YOZDJO9U+XXD8riDbR7aF06wuUqNpY3MKJ91h9gm/OgfsYsSiFyNohjhjbaF5141KlvtIwVA2HlGD4mWKDYqWVQbkxDbidNgqws2f8R1A2JlXcZTkcFWuDsQIXskLj84IQes0/RuWEWHix7LJF+lzj1Zt7SiBoAbfVaRsNRF5cR2c0/ZiPmKQaQyx0hvysks1mMa4aemmPybVrzbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:27:17 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::aac8:f9d0:77a2:9ed1]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::aac8:f9d0:77a2:9ed1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:27:17 +0000
From:   liming.wu@jaguarmicro.com
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH] sched: remove redundant check in __schedule_bug
Date:   Thu,  3 Aug 2023 19:26:28 +0800
Message-Id: <20230803112629.1139-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.34.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|TYZPR06MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 2723f303-b042-4fe2-31f0-08db94149799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOo7oszS86BWweI6NtExAtbaxULL+ti05dvhr7d9kUm9RnJ1e1JF7eQZyOtM9UHtkx17LgdXmPjDr8Bpmhjm1X7erDsmdfyBZHOolT4nREy7liEpU6CbI9JyS41jiHuZ1lAjTNHcIqEcLxqj/+30SqQF2t3X6BoDaFRZgjbEfYsajvyPhcMN3h/rLKYmcHj9LLivVnFzl5z0hbfgKmV6tQX91eLuHLlInY8XxdejSAwf+RUqj0n0a9fQ24KxVdKbrWt/S5ckS/IGDU0VdWhYKBBA8Vo38cnEqHH5AaBpqP0Ay8MRzyLt1WPBOOYmQJC9HN0GEKFQav3kmCZVVlzqG6hYRvFmBTOYrfDEX3Z6Q5l2aFJ2omv4yqjt1GJ3mGZ0e+pFZZ0ZvUAzfxnBbZVZZFVHn1IOrrX5v20xuW+AJ7C4gM5BGex5S0kMe9xoNOFSCQy3RBUiyvc/Bd/4DCD0GPCpZe5b+VTDzPwtn9DhGwAlHx1I9yNDHIwlY0+KNIn0wx6iB2YzOaCX4JVe0GDDNuJdAKv5+qPGMVzowTX7F1C8xLgVTZOr6FexLC6AoUD8043bsPuzR0nDoSiK6PtWfbnk6PyshQakm1BenZdlIlbxk/5mX35D3XktJKFyEeXo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(376002)(346002)(136003)(366004)(451199021)(4744005)(41300700001)(66556008)(316002)(2906002)(4326008)(6916009)(66946007)(66476007)(8936002)(8676002)(5660300002)(38350700002)(38100700002)(26005)(1076003)(36756003)(186003)(6506007)(86362001)(83380400001)(2616005)(9686003)(6512007)(478600001)(52116002)(6486002)(6666004)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FOpiW+0qUCeKYBOEikeuO4x+xZ4utlvJ0YXEh4G5JNYNRF6SjMJb5ew3HYvu?=
 =?us-ascii?Q?u8o4aWS0SmqQrLqj6+DHX06NlNKRsH/3j9bHVtR8CG7X4lojofCR9beKhf+e?=
 =?us-ascii?Q?BSCnvyu9rxGSip/TJGbCVLJafK/CwVeN1bRUbEP+pVwkjM45KvRnDE9Csuwr?=
 =?us-ascii?Q?GUyFgMwpq5v5vOAjuzMaT8B7IW53hSqNrhts0Cg71HMYgFujojXRE1lFeYgY?=
 =?us-ascii?Q?jzwvqsyqzocqTnTx1HO690DHU07Jz71nqPz9j3RPyAn9e1aFs+rpubJeZbi5?=
 =?us-ascii?Q?tsv8pxEe9noaY+amh19MGBxVqSICdDP+UsWvw47vMi9rJgff73YiO4WoAdXC?=
 =?us-ascii?Q?tYxFbU8BsgF80rAA9lHSEmOCp6o4L7zeQipfk2xF0nye3XtK9hHIxiKvq7iU?=
 =?us-ascii?Q?WEsNbmYk8OVhCcWAfPLIHP4JNy+pcxEP9lv3qlPYV3kGckeeUWUDfIwVENw9?=
 =?us-ascii?Q?kmLdZkc9fJGBF7bNJ6uFpfmFnTg4urFD1825DjsoBRhOCDj8Pa/DANzEjJmT?=
 =?us-ascii?Q?gi9x2ERxRvs+cmucljocy/GjaKPCujjrER2QfuhyauwfjBLtZHg3Lchp8xKG?=
 =?us-ascii?Q?myBvr7ntgGk2Ow/hrjG0Q2h+FEAtBWVJyg9o6bPxSBD0JLOS81hnE52DXPFG?=
 =?us-ascii?Q?Y1xNtgjWjfmVhOelnuq0yJpaGs7PIbA8YiVQUJT6ONavGibzeIiVHJ05xENT?=
 =?us-ascii?Q?ZRauV/s1UBBxfbjCv6qjV/bYQl93PSN93GGwL4gShoMdSZq7KQbqSVn7gpMO?=
 =?us-ascii?Q?O3OW7GMpZioV0ijlyliktAn65CKxJgl+hfBkGWj2Vp0JtgfyKDY+koIHqhkU?=
 =?us-ascii?Q?11cJkpcr9TWIPDvhPhAZdmvU52yk/tOeBwPMaeoY2dE0YNtfOtHiCE7LXY/5?=
 =?us-ascii?Q?2SdCx3z/bbvLyQlb6hK0XB8nVNWqSxrl/SN1y57QJzUoVGnymneWiSt6Rcnz?=
 =?us-ascii?Q?caIGYxrPjcccaoc1Y3wEBbanAE/ttfzGkC1omGteu8k/Yu+5zeyr3ywtOGRc?=
 =?us-ascii?Q?NA0ZdQIv7CTgslbnH9B8cbpI5jhoI6Y/wNPFTl1C55YWQXIoLGYTJgY96ITm?=
 =?us-ascii?Q?CevYdRNu2ogQ7EziDTDK6JbBwfyJNWTxLf+T2LjTHIci+MZdJg3bPfRg7Io3?=
 =?us-ascii?Q?cjTUrSE+sEPFVnLBYU/5kXIUkAmpdiRKpCiNSyRxl2n7MVXbAnlGAi4LdMsX?=
 =?us-ascii?Q?mWhkHCi2LNatgksS0xB84eOZIaRj34EQIuMkDfZrUwSsBAIvCtBT1FHz9+Qg?=
 =?us-ascii?Q?jvDKFG2z+4uTUqyKFbbEF/vNsK8d/+1PlD9/sRluQf5xJkoHiEfpho4u1QV6?=
 =?us-ascii?Q?EUnGUff+Wpy5jYnd/x8EZrkiev/Ka4qzgjE3YUOgXGbmvVNbBKyd3qmdm7OL?=
 =?us-ascii?Q?fpavF6u+I8jLmkNnwT8RsZMEIYZhEP9lyXhiUtMx1cSOmagZOZ/spg6LAZgW?=
 =?us-ascii?Q?Xm7tah8J0q7CrmEeJUrT0GHDNua3EImloMqkeMysEbqXwTd57Ot359bc0jod?=
 =?us-ascii?Q?mMXiMe3Tu9A48AubCaNqAMDzImc7Sv91Rkx4XbV6QpaBeuHdBdmNWVQBoJAO?=
 =?us-ascii?Q?t96l18s2AvHPidAQ0Eddr1srBL/xFSgCse8OIKc/H8+Qb3TrdUIAkBX5T71w?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2723f303-b042-4fe2-31f0-08db94149799
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:27:16.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdXfle994RdCtxpCNIOvZttf1r2CpLsuKqgrNpeVByFKpk+QJeDUsRrvG1g32rwfVGvCB/vnrq4DWDX5hyW5ZRvlO7scGtrtA9PM/37BKdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liming Wu <liming.wu@jaguarmicro.com>

in_atomic_preempt_off is checked twice in schedule_debug, and
__schedule_bug only called in schedule_debug. remove the redundant
in_atomic_preempt_off check in __schedule_bug.

Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..ae44958b3851
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5884,8 +5884,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 	print_modules();
 	if (irqs_disabled())
 		print_irqtrace_events(prev);
-	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
-	    && in_atomic_preempt_off()) {
+	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
 		pr_err("Preemption disabled at:");
 		print_ip_sym(KERN_ERR, preempt_disable_ip);
 	}
-- 
2.25.1

