Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C47AF87D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjI0DMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0DKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:10:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CFB1BD5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6eAQ1Z/ixam54+Y1/iE1l+lL6vqZEi0dBPsBKaGpQCMab8NMpgz5nbv2y8g1YnOVeX+LPqFo/CzD5OvaIlNA7+pYZfYjdnDRkZSoc3xd5cd4iY1c7rTGbBUye8lztlumXE9jPvFFKSjJeH1cIwF0SQ7Ubgpbr8me8ugsJ3AMqCnBns2SsduVvc8xWtoyOd4L11SJ/M1nStZ6zCWhVrG4Q+ycaN8PC+px6+yXRWCxLZ3bgk6GTUPpR7FWnWcUME2CsjPDx5toNefKF0KCESOvz/bHsmRFGDxuqJ1ZddI5xaxRi3ra1s6yRyxUIHunCwaN8+i7/4mcsZwgxyY+Aq1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUvL5jcsfzwInhJtVr5jtE2zuo/PEZsv/fjwHAq8/sQ=;
 b=CAQ8Qs7jZk7e325u0/JKOB5DHsN3zP8zEazH/a5UX8HZgzPnPmx9wA5jjrKt1kdUoNsS54Qt7x48IeiQEIy/lsTey8r/yLH4aK9zPaD0uHdAMEr45ykL724ZdV0MX/cBJJNzUqhn8bDhBfZqhxy67xCPn3g3EamFEdlgj7gLZjwglu4VMO/jMc4SfTk+QOjpQecxfNjKpKsMgtQXt9EwQhE9Hf1nY4WKfy/C5SRJ1UxPzxoy/ZZBEIvmyGwQcId0HsJOQMJoNYBZ8dd2YLxInk7Rz6ku/YJ9l13ZnCghvnedxsBJXiZs7o8ycANLvG9MsynhqwqjzuIjhBC1OWMY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUvL5jcsfzwInhJtVr5jtE2zuo/PEZsv/fjwHAq8/sQ=;
 b=M13LobT6IPL2gQg83vfAxcu05YM29nmDT59xsdDR0h0DWBzPtFU2tubMDQQ3mnpHjvUmYKWVlFqIUc9VPjLV1rkWmaAuHZf3GCRzMra/UGYEHhqseudxghwZtiTEckZ2T0fdj2BrKpHr3UYiGgTdKOI2mMomJNr9BUgVsIX5+5bWk7B2WGDXTYd5ct/COnWp2Yu7pnUCy5KuF/FaJSJ48anQ5OYiNJqR0UJ1K0GSKekX9FyrOSMzS26uScT3k1plaN5vVPHA5Ji1hHLl7+xbtA5dv/XBRVap+nCL4/ZY0xF+ctwhvkUD/yDtDBWP1dwJcMmlxu9tiXcT2UksGFEkqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by TYZPR06MB6620.apcprd06.prod.outlook.com (2603:1096:400:44d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 02:29:39 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::e5ee:587c:9e8e:1dbd]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::e5ee:587c:9e8e:1dbd%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 02:29:38 +0000
From:   liming.wu@jaguarmicro.com
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH] genirq/debugfs: Fix a typo of irq debugfs
Date:   Wed, 27 Sep 2023 10:29:25 +0800
Message-Id: <20230927022925.751-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.34.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|TYZPR06MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbc6996-73e5-4774-31e8-08dbbf0198dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNtNWBbAJ31V2bvCr+BOotr+VO9AIzhUeCjSAJR2dibcS+4aIraFTlicLQpY9ikZvJh/zqGs4EnDb/cpZ0L5xnx6zBAPiAmR9RwNsPXSnUnTR91xSD56G5EySAEXJicHP7rPfjhEhi3mwK1k0W9647ScytIoOKhoMwzZQyPPlG5FPSdI1x4HDVyh1K+HjOOqnGVo2brUr84xIBuqoFna2DSGj88+HsOa4HGra30/AzzVcXiHAZxlnBykrr+4G3wocnPnEoWU+fbHYQk/SS9cK4JpC3i8fzxoadqkY7l5NM4T48bIt5bbHgchFlaBTS1d7R4o+4iaIuLNGPADVMDTRMcF8x5Sp4QKoF7UB1feZCaYZ3EtMXetOahZ6Dr/fy+2Sf75zdKGeDUD1KetCYEdgFb+c6zkS4WNYeyDk1PyPO8JI15oKVBg7ERBtYB0+jzlSyVB5R60QkWKjH/CNQXvkyFV9h8MIsr1f68Qy1AD/qAktOJCkJSxzeEk6X0eUJWBOSClefg0TySKFlYkrJEhsCEkjm+fpJd158OVHk+RKtAclUgO7slWozwtEXMEsnQcsOXl+EVpWOhMNEl9WQzjWyqsBLocr17paH7Cg8j3CN8Kv6/lfuNSuLvu9BZL2nMV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(396003)(136003)(346002)(366004)(230922051799003)(186009)(1800799009)(451199024)(26005)(8936002)(4326008)(8676002)(66946007)(83380400001)(5660300002)(107886003)(1076003)(2906002)(2616005)(38100700002)(6506007)(6486002)(52116002)(6512007)(478600001)(9686003)(38350700002)(66476007)(66556008)(316002)(41300700001)(4744005)(86362001)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LFoMNvTSwCe8HbC251eKKNHutFYT11HacCpJJZml+jZr1oW0SXSYXt7FpaA?=
 =?us-ascii?Q?DdYhS+bCzlXbigKI1NDwXQAzGe+OFK1vktZ3fr+4oy813iAieaBhYxw+TFWy?=
 =?us-ascii?Q?+CjDmyChvglcqbzHYwg3qCelgPjTBGbgg74r5A/2VuKyoDuBP00+ahOrtnnT?=
 =?us-ascii?Q?f8IMGUBP6XiyGbuz2vWcU0fSElv1dhM+H+BmGJoYa6CozG55EuVvOOP7vlfW?=
 =?us-ascii?Q?yd7PPRrRsWpL1wCKFEJDacvxSc42EtWTcl3V32UdYz88XWW8O2Ri9WxwgX6t?=
 =?us-ascii?Q?hLI6vasni7i9EKd2vOBJf1AUYoTLbmIrBpjC15EfP48O4nk1f5HBsMKUZyj1?=
 =?us-ascii?Q?gJUBPxnE5oD+zthK0ERQkhRfAf8LIT+dB+yJL4PJR+uy3z1m7dKL+zN1ME2G?=
 =?us-ascii?Q?NwEnmVWH4mxbErhD+PTCSRwK/78Bs0a2xtev+PF4XxiVi6YxYO5DTRd7dB/p?=
 =?us-ascii?Q?ymKGtF6RLZz7bHlNEphel38Xm7KLNtbsp4khLLiHx2RKMRpkVlpvRWOG7hlt?=
 =?us-ascii?Q?s2mXSpw/v8oho9QbAp4oFBg4VSJMUQweb5mffyazQ0Oai3ABVupSLOPtTgsB?=
 =?us-ascii?Q?2lrEtNzR/Mubjy5ZSYbKGcj1xMY2Z1gDBD7uxdr9zPyb/PzM7VewcTO21fmX?=
 =?us-ascii?Q?x28kzy32ups/g/Jl+JKj8VuNn2T4SfCYPtf61uSc2dFRJMbMbqYeApfr4KAH?=
 =?us-ascii?Q?W9Q9xl5PubQOQus9SvhgTE5idoVNthfW3ZAI0aY1t1y1BNxFbGhXb/3Dive5?=
 =?us-ascii?Q?XJaytKkdfWQxriXhj3GnWgyuXU+0veehvSnWt/EX8UsI49BM6YuvAjxXYMP4?=
 =?us-ascii?Q?piQ8U3a3Zy6zQiALosaQytRK4WGcnXjYb2fxt/m+TmxK9Ckjs0PQ4qYpIYew?=
 =?us-ascii?Q?hkL74ys+Vi/rQT+5wgJcMhddSyDzGVdnaL31zNZvBmVKvHkjj+P726ATkzA7?=
 =?us-ascii?Q?TM0WEy/3NcBo1gN7ZwdwtGy7xjfmQ4bDgwanqbE+Ew9xkVk83/EJ0ihNBISf?=
 =?us-ascii?Q?/qNCQIkmbRGbhO1W8zUjhhUrVmkOE32QezwQLeMo3CoL75kPCPBlItFTmH80?=
 =?us-ascii?Q?BmhPA9PbH2uUAXEmFAvQSqbbkdrmrWgejUcM+9zsyDPRFqpITniCvAe+qKkv?=
 =?us-ascii?Q?s9JD3jf0wQjfeZkut8qU5NqPbtv/YgfpjUb1NUDqCM4TtZj0kXVVGxWPamuM?=
 =?us-ascii?Q?P8sQ5TxYFB57/jevWliadzc/PtKP34L+HB69yOJ/IaIvnmOOLNn+UjRA+sky?=
 =?us-ascii?Q?yB+LyniOgW2HyX6Yo2VJrEzbmGGkqX5l4gRtmRnNk1jn6YvF4VI/WB9KIhrE?=
 =?us-ascii?Q?rK0U5Y70ts5FRc2y+VSakBqx8+XSYlrqeefMb6C3NGn/mgxc+Dlk2YkUVzhm?=
 =?us-ascii?Q?FemvQUI+y51Qjdeo35vDya8iFm1G8+nA9TjCeGZGR+tUXTc6Svg9fVjJuLO9?=
 =?us-ascii?Q?1bkiLKuE9bW3PD2WXhcqiHDDoB9jha4BHM7g4sKeVQ1Xkwalq5jJAnJHwU/T?=
 =?us-ascii?Q?EUZx6TO55AcomUBnivhPBdFL0UfXKm2r337TxWDI7lWw0bwdeWRAlOAFaqiW?=
 =?us-ascii?Q?FV8R707e81NVFJhfS+vtsYtuTuXmMp1xFMKtWLATqEhjz/285HZHIixXflYQ?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbc6996-73e5-4774-31e8-08dbbf0198dd
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 02:29:38.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tzIJ+mReYXLgx+GAMYL3HdmoHTVDGToaVyxVSrOWyAe4a5CjeICUAFof+8tjku86kYhKouz48gMukXJbSv5Xs0wQXaBRpnupbg0RfccfVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6620
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liming Wu <liming.wu@jaguarmicro.com>

Correct the spelling of effective.

Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 kernel/irq/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 5971a66be034..f7235285cc41 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -36,7 +36,7 @@ static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc)
 	seq_printf(m, "affinity: %*pbl\n", cpumask_pr_args(msk));
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	msk = irq_data_get_effective_affinity_mask(data);
-	seq_printf(m, "effectiv: %*pbl\n", cpumask_pr_args(msk));
+	seq_printf(m, "effective: %*pbl\n", cpumask_pr_args(msk));
 #endif
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	msk = desc->pending_mask;
-- 
2.34.1

