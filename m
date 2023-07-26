Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3376367D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjGZMkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGZMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:40:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B5E1FC4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6uTYm8OtKFc5hGNnCwHSF5jtvo8rxjB/5kFgSv+kdsHBHSJAYfBxZb8J+pPc/YjNumvhhs45AP+Fqg8vR1t505az34FW1K31j5VWRimJ1ST2tby5iYwvoXcCJcaHGzVF9hNFpTTKLPps7kqpKVrbwiOYLHrNSjwdOpCj9MSbcYNacKV0/F31qXiFXZFaIVxydOxbyWJGObmW0o7eAqRPlA7KuJSz7rE5fQIeGDIXkuHqvS9EEnCi4I+A3mbkHz1hR2dc0EsBREhux0ySIH3zvpn6rjCcU3KG0E41kwDDFfMtzthaNlvJnXgJOnR2LV60wdBfzJ19/aX94XoW6VfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N8HjKK0y8u881uxZ/oB1l5f5XebEVGw3UdFckxorAI=;
 b=ntM9x+Mmn7gwdtavv/zzVktIx2gcg70ju1rjRpMa0bTPlTjKsKFgq24AXrFE5gG4i4KwEMAvzFqZFXkd2WISN/04ZTKmxo5mXTmqMWO3ViGIA49hemAv4ook/NEZfuje1qHCvFbs7jDzhLasvQCuV5CcUGVoSRuNIAYEL6EydwUTSHG9qUl0RFtbOYPVKX68FH3roxGcPpOzNgzUGJavIluAelPyEbwvLDi5JF9v7MtnmpUMqzavo22FgJxh34+XxrJbBuQ9mkay4MMkoAKsKyo1mTYlua5IdkFvN+XhIhtTKC75ADytLPjit77Nh4OGv0SXDpJP+2gYBL0vn4KDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N8HjKK0y8u881uxZ/oB1l5f5XebEVGw3UdFckxorAI=;
 b=lX4cpNun/FAQUf1OslXDlW7IxScQ9qLbLoDlRyVMVPeVftatjtFtp8+u8EA9TPRKXOT96y7g+gZzkmT4+4s6S7rEE0WBBiGNDBOqnlFHDAB0FLBKzwgViAau3SMBUYvRpQpcKt3MNt2e8Rdi6ROu4A/nqP/6DI3PsHrntMp8udybbidjvteEyH1iMNumcbNg2U9RG2RPbM2yYiUu2qjDn/WokG4GpYoVxqGF2ZbMCTQudxi295S+Q8SrNIh4SnPYm0d0yJSsu0LxxR3zYzqxVT/j89CoK6uYsqc48QAtdJVeXozRglZrE4m+PD12odVmqk1UJJcKLJL+LxulSJkZ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TY0PR06MB5471.apcprd06.prod.outlook.com (2603:1096:400:265::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 12:40:06 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:40:04 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] mailbox: Remove error checking for debugfs_create_dir()
Date:   Wed, 26 Jul 2023 20:39:03 +0800
Message-Id: <20230726123917.7438-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TY0PR06MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5f92b8-1d28-460c-c6f0-08db8dd56fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyGFHPprWqS9wGzm5u5uj/E0hEEJgQ8NggIEx8wcOC4p99DxIZkTBDq0JtJUGmDRQu6HP8n1t2oSu+hS+ohmuLEWgWZ13TebiYvvyLikG/BorFdTzJda0nCz4NmHgOiEY+z9LidFeFU9gTr/wpgYpWM2fExoKS6gBxtC97fDZ0hIDi0FygV0rELuFuB9h28oB6vocBQt7ARt7JU0JjA0AsmL6it4SyeWk4W+cLC9fDiJLcLaMY3HeDv99RdV5RONbWn1JLJdHX3mQfRpi+EDA6UUJhm6dcXwSgLbt0fpdPyaHkklywceDojLuE8eV1hmrcPH3O/QFsGURgllNGDw53kX/IYapoxwYKMVvc/Y+vwfisbdSi3PBKjEs0HYS2A7D5bCQ4crbEyGWcqNh+2aDYt8+8XiDGrTUmjudc5AflW5iuTLYopxOjlKnuC12nlThvzQCxOOh+0vhlL8twZBh+v740Kr5wdGCA82fmPiG4QEsqozhFA2JjuHztYRSJ5qmAMBH7KJb3bKESIygVwvMthUoXLszLI8wC3nLpegVuytNffiOVYA6o0G2A1RMbWWgQ4X1p8XiZo1ErTv6Cq31ju3GkHbARa0IQysKcNjhIDn+wTSwmcJPN9UVpaR+8kd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(107886003)(186003)(26005)(2616005)(1076003)(6506007)(4326008)(83380400001)(66476007)(8676002)(316002)(15650500001)(8936002)(41300700001)(66556008)(66946007)(5660300002)(6512007)(6486002)(52116002)(2906002)(478600001)(4744005)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSh6FdnhVw5tODiPJ58BP/pUcXgozysvjdI655EhUrpJTiPR5LJx8MWHn3mQ?=
 =?us-ascii?Q?6qWgeAQ3+3eJ1kS4ukuj4MIB+3s3oYCpQmF6Eodc11JPHT3r8cmawlg+5sM3?=
 =?us-ascii?Q?C1SSldXKZ6Ea9AWzSvHTpd9va9a90lgEm9Tfr5cApoxt0wrZrMddloWMgyfL?=
 =?us-ascii?Q?eOe/xQp9JeGmWkdo8oY5SYtbYMwawoM2qQwVomjDfyc1zA8tNSQ7m0CjzJUm?=
 =?us-ascii?Q?etHTiSpq0RxP1QCykH3RxuEMf3ydP1Q5ET56/Ij/yJ6rX6Ef2PW0mg1japU1?=
 =?us-ascii?Q?7K0q1m/YjPVts5h3DHWbcajhv25JiYyIcqsy9dCfYGerwVEjE3GXajnima0d?=
 =?us-ascii?Q?U6jcqTQB0DIO0ziVPCYfqiXfopUArYNDZzdK+7JklEE6iOY1Zlasvs65JjIg?=
 =?us-ascii?Q?c/vjn6I81+5BkB+nZu5WEVlLfr+acQzmNxuQyHyBLHv5hm7/Kyqo6cSJ9BL4?=
 =?us-ascii?Q?dTtNF/WYywdIhwPg/Z8+QG/WURCe6kPj1qooKTOkuOPfsIFPVGxKcC8TkD/T?=
 =?us-ascii?Q?Sjq5B7GK527/T6oUBj8JDU+bmW6qO3gjjYhS++KUcd6LUeAijUBXoZ3I2/lv?=
 =?us-ascii?Q?SPT11gp/7hVHA3yvtIBqno9J6nNcoRWC5jZhYxA40tsDiU17rS5qB803HpZd?=
 =?us-ascii?Q?uN8B9j6BcqIUZboSIK/B/i8lHtfFrg0los6fiyRNBOeGQytdBzBcSa1uO0Ne?=
 =?us-ascii?Q?iqHKLVfmPc0abWxt8ZYsnMwFw1zsAgU+/JCRMdOxgSXgU9ocdqMhITi9OJnS?=
 =?us-ascii?Q?G84YulBknaZi/ntjlU0iE3PpbA8PYE0GpJhHVZy2wsFp1/r5cgprE1E4gsgH?=
 =?us-ascii?Q?jUTu5MBDRmM1jXXleVr4hUJV+5o4T5XjVxZXXyRNRO0onPdgs1gnLcoepy5U?=
 =?us-ascii?Q?sHmZ9xuuoCbpiYenzOapUSDv95NGYErxW85/dWhGrbZ/XbsrOrSvNWlYbPjx?=
 =?us-ascii?Q?Jnuc3Bmx9quNyWz5QPuKU4KX5J1RUc7k15yUeFtcfpgaZCg8i8nmmuDxpzQK?=
 =?us-ascii?Q?u+OcZned99e+8VG2so6DQWGIfBhbIAFCTgXhHc7VIb4ndk1aIWqiIhZ35Hdz?=
 =?us-ascii?Q?gcytZqws4Z1NTG+yJ0XG9zhtWPUMn6mLnYD+OQs8eSBSrKPgBw4BoonAP9yV?=
 =?us-ascii?Q?zlQme1dd5bpXuv8BVU+fJhG3QOT83YLFl8Qnh8hEYk9MkoMigwD5KcLDvyc+?=
 =?us-ascii?Q?r4h+kFy6Eyk2NL2be4MErFY2nA7Ekj55eWgg7meICC3rCa45zhIrh77j6gp2?=
 =?us-ascii?Q?a769ADXuy/6bCYc7HHDFDL99ccWAAmEcnsIQHaP53wkZrNnltqnwLyAoYOE5?=
 =?us-ascii?Q?oEBfIvOn4nWjo3jKlNdgAqsicwQtDcVY6cSu6EbcK8CNns46OouO19d9/Xbi?=
 =?us-ascii?Q?dfHjcgjPjC6qhBVz8kxbzsaotA0BS4h3+GwRW7GTwCvWD4/WqfQrEtRkxong?=
 =?us-ascii?Q?P/zk0Lggy176mA302VIk+2pY3v7AvrP4UzMT+0G6W644UbTDoNeT0ElwhOVF?=
 =?us-ascii?Q?bOizxISeXagu6K+ofxRTUjK57DFDQ7UN8Hf8P6J/Cpiu8BqA7nyodt3gAnAd?=
 =?us-ascii?Q?DEowBA9HAuhtDHtBflG2Fa/xxCOUHuRFLOl0vpZC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5f92b8-1d28-460c-c6f0-08db8dd56fba
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:40:04.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni7mvGQLEq3YQgpGITlvckbTFQU3NFhCKlYE2OGXS6LqB+4MvUAYVCaubu1/NvOgffzF2w8ufFqbfGw8x4Q8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors return by
debugfs_create_dir() in mbox_test_add_debugfs().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/mailbox/mailbox-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index fc6a12a51..54d11c025 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -268,10 +268,6 @@ static int mbox_test_add_debugfs(struct platform_device *pdev,
 		return 0;
 
 	tdev->root_debugfs_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
-	if (!tdev->root_debugfs_dir) {
-		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
-		return -EINVAL;
-	}
 
 	debugfs_create_file("message", 0600, tdev->root_debugfs_dir,
 			    tdev, &mbox_test_message_ops);
-- 
2.25.1

