Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E58B751699
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGMDFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGMDFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:05:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E411D171D;
        Wed, 12 Jul 2023 20:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsA3jhyM4cV+59Oc4JzJn5YJvJRnZ/NvsIrhIr7W8afgqs2RlAMZgkGKD/Ofr/7uCgMSHiPOU8QDqQT0qv1mQXacBVYH1CQ25ji/nUdJxm4B8oK8gnpQ1m7labhbqxZQHY9lnAybSaOgv/EliOlpQA+OQGVnaS6FYbNSj260Dtg6mHBSY1YZ0BFil2fKUpLroygLMR3/dNra6oyUXhL1ZreXpz6uYIg+WTZy80Zza74oipG4AHmaLa7M36iKyrTwjfr5V63ECOwRqI6emq2s9FRsjPBVcVLzcIQ8z6XqaL11kLL4zmcgCsUVK0RkVznbgcsU4bh5fuu7M4Sr5eAMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cc2kQ8xlJzjPhnsPQCfbputRxbQYtEUoP55dgs33Lo=;
 b=TGFRpfkv1LXI7HWHo0UwK+dV0gl9Zr4gEPNpnGtFTRI78GC57qhlKdOY/MRH0i8UaHIw84HTHvJ3dXmpy5OmCNnyHkPYkNR3n7Mr1QS8+zbHddZrnZw1B1ki0PHMeCg0zftvFOHjSTXvY+4q2f5SaoY1rmY+lV/O9lvY1h+E+ZzO+Y6lBXUwKYLkBuDlf0sVO3nL5RLXaVXAgh/U25zsjWG8bCgtkfLekr6DAMDYFpjxzrN9nyoC60k409CIvh3d9iI91YRoZYdjRpzpqf+m97V4xrT50ak6r9xl0SwZrjKJhV/3HD9DuROq5ZneRjpK4N0KJbeceD/DSwKtcX2ebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cc2kQ8xlJzjPhnsPQCfbputRxbQYtEUoP55dgs33Lo=;
 b=PiHPOs4QLRu2zXwIM25Q8OAvJNsdjnpfL98uG1pLUzE9CzTvanhKT2qaHMjnhS9lvKWQ+AGfiMXUlxR8EkMTU6RxCEzRcm6XWBJGcdZqcayPGTU5VqqBPsO5Mi21b19Oha7Wfp3J8zWi+E+SlmsCW5F/iaATj0tnpDyJuYhtuYoNxXek6e99tyxgK7wkvtZH0BNoH/s1XKFYtOpjtCW4kKgoEwI3ntGke63N+KeAYQUNWSvCscDFrX5g7p7Q/7Zs3EaoKT9oMLNRZVR1Hed3QmizYjjfB5cn7NASIXUm0hCjLeEZA/Mq+NBacVYJbui6hP08Y1AFKfPHzSSRwWaCdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYUPR06MB5928.apcprd06.prod.outlook.com (2603:1096:400:35f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 03:04:56 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 03:04:56 +0000
From:   Wang Ming <machel@vivo.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Rajkumar Manoharan <rmanoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Sujith Manoharan <Sujith.Manoharan@atheros.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v1] net:wireless:Fix an NULL vs IS_ERR() bug for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 11:03:44 +0800
Message-Id: <20230713030358.12379-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::24) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYUPR06MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b56668-e8ea-427e-d78f-08db834deffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzWiAkeqUc9DkXPVhnJtePu2VTOF4cVMthainQKjkP5ysHeu1v/RKrDvqqvAfMvkj8vvEbxEdyYf4mn32r1YkPhN7Bz2ZzH0MH65bEzPQv3MlSBYI0gk/SZgS7CbA2o7eUQN7MF/xtxk4PgUh7/QMa+i1Xjx9BuC9mcSaDhBxG+rX0BxgmASf5zgGQwrN5Q+G417EEHKSBMwJlGw+2w0bUK1lYoLRJJskoT7wrbWXMEf7XKpGR6qI4WTXOwM5399hFZsdrLkQydRkHlmgp7zUGcj6HaXZJzAI6FjjZL1pulgd0Ohe8MJTqekjRracjqtUIn+TEg1weVWMBmBeKgwOgliDgn4C2kKRcWEGy2gcNeTQJqmK9auAL6Ndyk0WRjVLW3nDYC2zQRoCqgQqU7qOGSiP7dkQZl8m7zTBA4h9eJFK6EjJt5OOrT5fpwMsydcjGp1sT3SvJC5tc59wx0Ea0YIz71ACIYuhu/73k4zBQf2lSas3PicV93KtDT/ojr3S3LdV2prz9sfoZaJSekeB1K7+vTtRfbV0aVht6IVC/7QXogv+gRs9k5Rwkk4voclFhEjWz8JQGhtZpKGSIeXwFazBfUK4e+HyvmC/UMJuO2jjI4ko7uZBbcrg4GUHcpu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(38100700002)(38350700002)(478600001)(4326008)(86362001)(6666004)(52116002)(110136005)(6486002)(66476007)(66556008)(66946007)(6512007)(316002)(83380400001)(41300700001)(2906002)(4744005)(36756003)(2616005)(8676002)(8936002)(107886003)(26005)(6506007)(1076003)(5660300002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhMKmVBWuRHPm6o+AZ85Nzkcls7ti/pO2z9FsIV9y1mMd1nI1ZenPIM2IuQF?=
 =?us-ascii?Q?HLLzWh3l9bVT6mk4hyx9aNziajm0Nfv9sqms+QzeDhhSDcENoWlg0WLpBL8K?=
 =?us-ascii?Q?VHwWtydUZEuQDSJzGNsPvIBduor1U36NHALKXRW3c6Qhx7umkq0LVLcWQ4N3?=
 =?us-ascii?Q?CnUAtMKwxS0vNmQjzYiI7BVqYnwZO2g8tw0OEEpZpAJCdMBOMPhY01ifXhab?=
 =?us-ascii?Q?dF/b0HwkoxZRcGHlo3WjoN1oOA3EiIuDpqR/Cp+Yq4rlHQtH5d+I00detVx8?=
 =?us-ascii?Q?j5Da8YZALSSv3ZpAxS3dc7HAj6EgaWYwEcKXpwmiWzmZr8yYUlCye8j5wn7b?=
 =?us-ascii?Q?7gbwXmfhCjoHftVz2aONeZsExjtnBg1LFJivCiUI/3Vvj3mfId6Bjv8dNeJg?=
 =?us-ascii?Q?ZwA+tbSc6t/6Tz5Sn155SP5Ue7NeICGkFdyoCob+1HAJr/4j1keXhos8UOwG?=
 =?us-ascii?Q?zzRXmgzhLDuMTmKAMv4pkGR7hq9cNFkoDPQ2hKWXg4Ak0cQcvHo7154A3bZx?=
 =?us-ascii?Q?s1NVqqMfr+PBKB5uRh2VyheYeRqQIaOnsVzD2SmOtlxC1Mg3WMUN0wqJQDJI?=
 =?us-ascii?Q?bzfWtbRcF0YiedoIqJq4ghzO2jpGq184qXoB4DHBA6eXwlY4s4MkR4xgrZia?=
 =?us-ascii?Q?EaZtuAXrUeLOgkPUnulqiTr2LLxAs86eZlIHmcZauoDulQrt9Ul3mtrNKUYL?=
 =?us-ascii?Q?rPyrcmiWF17dvBSq3R1UIh0XsFvU2FO0wHZqwGiZG7WpY7DOLb+0FGA/tAtB?=
 =?us-ascii?Q?nZsnXtW8/BHGoRTOMkr3RBNY2s9YK0otHlL8J0deq2uPA8j0xebezRcHcL5I?=
 =?us-ascii?Q?U1aCnikiS5LBEuHG5DpADPDOi4tHAcB/BroaxkAEOqLtqDqzI/gOo1koGLRL?=
 =?us-ascii?Q?o7dSmeY/nT9gg6ouCP1/aEuadLqNw8Fpx7ru/iHczIRAGTTnjoH5zwUWPsYt?=
 =?us-ascii?Q?E39pSNe4T2j0lxzmDj0dNEPElVjOVjs445yEloJidqkPzSehWmc3fNqXxQ4i?=
 =?us-ascii?Q?Bwz7sG8zL9A4tes4Rj0KBpVkt6CzNem/InqxE8R/u5l+qVD7IOXbxZioss38?=
 =?us-ascii?Q?FCuSOQVDtXkZxB2kSgNKRUFTEHFxr7TQyiX4FBc5BBy8dhAXxkzlxjULzXMX?=
 =?us-ascii?Q?z3Fz65N0wjtlUTr9GmXjYevnCAzPsRc5g4KDEBIC2ChzqmjgIAi014TH8+yD?=
 =?us-ascii?Q?aI1TjolOIt60jQlgsaG1lsfmLPpMXhaBj1W0KAnHU1QDVr6SUYeDiMi29i0t?=
 =?us-ascii?Q?17HY6vrSXfLKa0alB/dmxWDM6IZU/PLbfYTHAwaap+Q8vbESf9p+zp/ET7W+?=
 =?us-ascii?Q?gG1zKOvFAtAMiKhF5AraAeAcSR4ePgFO/7xnwYtf0wPEp6mNNKbAfMeb5uKI?=
 =?us-ascii?Q?jc6hTH/VDYyAM/yMNOhOY53hVk591P/cQGuKV5MfOSRtSw2JLMbgC/KRTkjB?=
 =?us-ascii?Q?DmjC65CFeCnYCYYpYTWYKCi2mQC16VCTrL7oetUIz5oIOLtJFOfkDZOtNvge?=
 =?us-ascii?Q?g2Vy7YBpCas+Ul0rPFiKkNrS1/5ksXLGO+vjALZYyJ0uEUuYC5s2+MLNSGww?=
 =?us-ascii?Q?Elp9cZy31kATkqWWDE14Cs6T4eFwHG9moD0hFbW3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b56668-e8ea-427e-d78f-08db834deffa
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 03:04:56.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YBt/QjlLQaJOuIjBtSARYNxlzopPZKKcCsycM31y3jCEB6ewAhxSyqoLQs1VZC0UhEXvEsKjXAprNmEMAFqJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in ath9k_htc_init_debug() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: e5facc75fa91 ("ath9k_htc: Cleanup HTC debugfs")
---
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da..c55aab01fff5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -491,7 +491,7 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (!priv->debug.debugfs_phy)
+	if (IS_ERR(priv->debug.debugfs_phy))
 		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
-- 
2.25.1

