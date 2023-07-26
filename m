Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB706763655
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjGZMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZMb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:31:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF712C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwSApJLHy8sGQeLtY+7dtZYNXHL5V8TZLShxj99nVjDZrIZGuUCEmTioZdPDwUjHGUn7SqwWnLqhnh8yiVdZgo7ngzMJAsUblYxnyn/4yFvND2VaeKIpeR4GRZO7pwGWpxdgCSjVMr5dOHBwDxtQjUse+wtx5/RztJu6aOgZOIexYkbs9rGO2kot2yO9Lbzd1HLy4/4SryJ3O98+mz+hpvPOjSr6erJC099xzN3BEQ3McWkJBuD4KVr9GRG7R6S+pJDhqiSO33GoigvIBH17832JzLA/uB5ECP1icwGDXXutGhGOHQjVA5q1QSCbPSstefF1HgtChaQjFuMQOH0FMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdKN3G4Eyx4BNhMGcV7GsY4sUIJh/03DmKruvVfV7Oc=;
 b=nAzsfybKH2oZtsGsgCLU/I/pJ+SyBQrBzF8GrpPGz4sIY3BXd/yKdSWvN6EKm5uQazV/O3fZVovTBPQn7ozK/j4GSl3WiyXI6OUucMvhOe9TfGLkoeEbA284pojBg63Kgj8yvPasmX4wPIehGdjOeOHUGyhppWtGGE2RM1Xmejkevk/FeY0bOuZNg45VxppAE9isxAnosS4hv9Sfzewb9RzueYcrdKfIiXO9gpQx4OU+xCxI7fgyBjdHhKiz2SguZALLAx8KLIBxrVSu1sQOCrPF6erHu/gaMtMAsOi5KDidv3jLFD//KkXKy9At6xhZyB/JUWKlKh+xhDjKM9Mqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdKN3G4Eyx4BNhMGcV7GsY4sUIJh/03DmKruvVfV7Oc=;
 b=ldxX02ywju8szQFGCEVdv7DqyydNkaEGZCXsBRetI2nMQq6N9R6TbCvNVdZD9Q5eFmmrRZBh5zgvwMbTTxVcYfKdekcFn7ADkbHzguR+Njv9NkmjqF7Mv75ZYa1a3ofJFZVqseKUmYuXmU/92jAHFNPJMURr7J42pO0WdwJs4D2px9JVOPcFNdiR0ftqEUsKXhh19WpDGEwvi2I0QvNrXQbp8TgT8KD6wPe9PGX0bvNsWzegwMAz4iUfhGnZV4X7cLxYAyq0kqlXyF4axOKL/AZU0ZSW+dD+LrKGZNbm8aKvkghBqaUpQswXCZKDyXleuLEdfqtVXvn8rngYDyM5Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR06MB6590.apcprd06.prod.outlook.com (2603:1096:820:f1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Wed, 26 Jul 2023 12:31:21 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:31:21 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, Wang Ming <machel@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] hsi: controllers: Remove error checking for debugfs_create_dir()
Date:   Wed, 26 Jul 2023 20:30:46 +0800
Message-Id: <20230726123059.7196-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR06MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: a31be27c-e2f1-411a-4e06-08db8dd437c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR76/rAlCjR3sUWPRl+TYKOz80Znq1SHy2MA1nWg+UFd54v3dn+xLUw/cDJGIOkF7toFKhKp6UzW6Fj0tx5/6uvH9giibWiOp9En9QUOyxNGQhlqOOHr2Te3yCasdziSyS4bSIaxe/8rAL4rynvroedE0tJNQkBPpguq/J5eYFiGMgw6xRmbQLYfayvyVwkrhfX21wnJpbJuh7B+wbkcNHH6oc+FN0JdQwkOFS0KJlCkWaQkLiZvVSRdm3HIhjvLMZ2Njdgll6obr0jHBElcuCWiyQ407+ma9TzewNCehTmPQYVtUf2s2yOuZDtAVGt5yC0SzQ/WRZoNfY3YpJXqpW2bE4vouYnicJ2t7BrFKoGhY4uG7qp8eLKudHKTHXc6Ryrk+WZ+TNKpNl7xbkK9CWQ3AsBl/Qns9OdqQLPRluuFul8m+GPBkFPxaY3bxHv++6n0wCdXEyB1T/LcSEpDkTt0g7JnyVz7NjP8zghMznJOENThsf1wu4lbofjQa6wYc3Z+2B9PLPwb1mYzuFoVmULfYx7RP2HHWUhKf2g27kaTg23qJUfkp/LD7tQTprPzmzBD2EOQ4OHXpeHucgG34wqwE/2TU4WQE/NfLDx7IyYbuA/4AfOghY4SxidcY/7X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(6486002)(52116002)(6512007)(478600001)(6666004)(110136005)(6506007)(2616005)(186003)(26005)(1076003)(107886003)(8936002)(41300700001)(66946007)(66476007)(8676002)(38100700002)(38350700002)(5660300002)(66556008)(4326008)(316002)(2906002)(4744005)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lfg3oQD8AQknWq/Wy0njkyhajjGkObGg/AS0Ll9aR/+8lCxazyHdcjYIrNwe?=
 =?us-ascii?Q?9lAJ76T04Gi8EdOivVwwbujXFUWrdhi57eS/+Ao+DEwKQelqDqY/0othfaLV?=
 =?us-ascii?Q?P+yQ1x5gTBB2XSDR5OmlgzPZK948tIJaKflwMN7PCsJE/1WwCJc5/UK9Wfq8?=
 =?us-ascii?Q?MVYKonRst6pKXR77lso/qO0cTmt4aj0t78W2/KsxetEvwqsU5aJQtLu14p7+?=
 =?us-ascii?Q?ufOzPl2MN/36aCktNoy3KIXQMu0mMjONKwO6a/yiPX/hV/7N4gJVM3dRmdr4?=
 =?us-ascii?Q?G4besJBhpge+QkCKFyDRpTJI5HPD85iqgULeTvzScuoz7Oq6DhAbeYgaYCJI?=
 =?us-ascii?Q?j5+H9IcPL/AJvd7u0DxkonzRw2tFLfx3ze8PssaRsU6ahPSMbcSaE6uJzXXg?=
 =?us-ascii?Q?2RyoV2pHVa0p2WhR6NPAItvyX1uHwtvEC6wCRz+39emouBo4/CRvNJfljzDO?=
 =?us-ascii?Q?IouraBGMEOWO9AVfjSX8Y7hjJlElLxxg+ookrayPwCypEqjnVOkedxtEtlZm?=
 =?us-ascii?Q?W2SlKlMZczcGOvgGMOH9RCA8qk2hQGARD2CFNvPfs/JPb6tFj0Rl7gJYB4eQ?=
 =?us-ascii?Q?KS9r8rnRFFC5QAU5KJSgq3vwXB7Oo5N8m6PNZQcSgzU48D49nbExQdIj6H7a?=
 =?us-ascii?Q?z8fSrwWWi47sKkpLzpU/p2zXbAWrphC6Vrx8Jd9iHAnRlTufDSpPiG/xXsRJ?=
 =?us-ascii?Q?hvflqcbLTa5h+nx+7keL40qEwzc9cWzvUjWpGbNXwHxJmZPqIL5+aGoBKwgv?=
 =?us-ascii?Q?qLoaGz9Shfba1oezOxoY0S/Lml/jojaVa+0J7hTGlfBn7boMlBX56qjEtfiB?=
 =?us-ascii?Q?cb3u3YUhpbmWsAaIjD9KHUd+D9BGpl7K3/UWc8gzVI17SdmyFqpYNMB4s4Sm?=
 =?us-ascii?Q?+o8uF8kZorJwf/i0/KMEyorRUrC8Nf3/nPZQ9ETy+2PnogBSTy9mAByXQGxN?=
 =?us-ascii?Q?gIMEHoqhdLX5v3btY5px1xr8/XDZ5UDmeCh1QqXYNgOY1g8+0pgyrAE397h1?=
 =?us-ascii?Q?mimCPia3ZPHKbbJ9uq2KfAR2uKd37p79sDe7PQIt70cC4sBNiWB/azsQOvEM?=
 =?us-ascii?Q?uewGWp8P39JwdSzZJjcYBDMdSlrbpXuEM7K2oO6Dpz3sBoU3ulmekGf/EY/m?=
 =?us-ascii?Q?ByJ7QIez6t+RvKFgNcx7ZyzhbUpqshEFGOJorVaZrdFjUiHfa8V3LToSw+OV?=
 =?us-ascii?Q?lExX63+gzdrKo9PBtmHdU3gAqx31DLLcyG8holnVWuawNVOvJiqKKv+EDfKe?=
 =?us-ascii?Q?jkOtKATTRoD1lTreuilL7xkBsaXHeOz1+LawLoIV+clYpbY/F+IohSjU0LhM?=
 =?us-ascii?Q?nN0JviW7IjQYrD/K7/0lP4ELOVONr+KAa1gCgVX/GhzHMhqP1M1P9z6IECza?=
 =?us-ascii?Q?rRGVTs3pn3t8U5QQ0xwN6xeniPmYF6gDCN3Q0D+0ZpZAK83NPhjPZWANXVoT?=
 =?us-ascii?Q?UXiLEmswN2rFV/SpIrkDw0bv/6VBJAhNU0ros2l6/llZLP17OgFHCIJFmFgV?=
 =?us-ascii?Q?HRNAlDId6atvc//lJr6xdMIIzs8eH9wYaThtVsf4k6FocV5Lurj2G+kyRGHY?=
 =?us-ascii?Q?PWZQVpNiUxrwWSOPbQiq0o/KVu+sepFALrn3SqQA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31be27c-e2f1-411a-4e06-08db8dd437c9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:31:21.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdJRhe4pnSplYwafbTfoyqWADjObWxafbHTR6rWINB+uPatUCdR+cIk7Bo0fJ2fwTmQssFh4KvG/o3zBbeRRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in bond_debug_reregister().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 84ba8b875..57c63053f 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -115,8 +115,6 @@ static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 
 	/* SSI controller */
 	omap_ssi->dir = debugfs_create_dir(dev_name(&ssi->device), NULL);
-	if (!omap_ssi->dir)
-		return -ENOMEM;
 
 	debugfs_create_file("regs", S_IRUGO, omap_ssi->dir, ssi,
 								&ssi_regs_fops);
-- 
2.25.1

