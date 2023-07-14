Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F9E753299
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjGNHK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGNHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:10:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622EF11D;
        Fri, 14 Jul 2023 00:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa2Hen+JQgO+HrSYdGaxLRhhRtMEiiKZdMEBYTiHJCMGbVGXHiq11J6Enml5VZxTlgF/4zPqOqVicQVHpbSZJaKTA2/N00zWWPiyt1jTdo9KFQBzCR1uxJ1r6xNNDrYt3XatKXLXoBPBxhfixsJWObIlA1Jm2kksMKYdRzOk+ZvISOzHwb4vmEabzkloHC1OUFUvSIb+ou0EQmCivBpwFqdohLmy+iAs4PISsSAQ6HSFIqPaMDXi23WHcoWsaor4oYdqYVG26tcrxl6k9tc+Gtj+gbWeVFyHnBPYHba8ya5/8A+6epnDEOPeRNadbLz7LKV2rpwfMtgYTvp8RlnphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGQxDPUtDKdVkLim/GVM13LTydbEKNqoXzUq7oC0MIg=;
 b=Ph7R6SI3aqBk+S+Yng5EjgZA5lt9iIpqkSpUkKT3OavbNKlKXbkYIFrE3H3yWIY8L6UyfkWw4DGxNqAVoA0BjcwL5LsJG1NJF/dCOVdyfyc13+bszfHZtbgbB8Ghfz/0UAsq36175sfwsHRisfQ+wiPJe7Ruvb/mkoBs2cqFTw7yzVc6eWJEl5ZNUp1agdReWieMMnwRjnV8v0MW5oZm0iRyNeDDbIKt3bo5nEyA56okwg9an1z1g/UArHa1+H7NICYfgPuwbbzAxbp6L0czhkcieMY02eKGN8qFO1qsbPF+5/kmW0yRuTDkgWDsXoARvwfJzc4iaXglOpLsmZYkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGQxDPUtDKdVkLim/GVM13LTydbEKNqoXzUq7oC0MIg=;
 b=iNniAxVZYgvk9IGXfEUAzNQXYbPFMUziNeL7jFStxiBDurreZm63MM7H1cjqaP2HbeLfQVTKSZ5xC23iAFEuNRx+mS2qbUcU5WXF5UEMYYm3aUliCnF78dPFVXCcU7A6V/E49Rlg8tzzzm9voMX2cC6ONITRawFpu1Nzq9iE8K1PV5RNqAz3rCIbBbcKXrhM7GhVcOXM9LHJuBmjbIRBX7eF97BRhcXZXHSDXvFfzqZ7hLsnEzjjXxfQHxD5anPc3cCWA7yvs6YNKn566P0pfzcIo2gI4iPhsSxEaG6weXOO/f2AmljdiufUQa8NvIFXFZmxCvgRkAHoICuc0Quz6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TY0PR06MB5282.apcprd06.prod.outlook.com (2603:1096:400:207::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 07:10:18 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 07:10:18 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v5] wifi: ath5k: remove phydir check from ath5k_debug_init_device()
Date:   Fri, 14 Jul 2023 15:10:02 +0800
Message-Id: <20230714071002.1264-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:404:a::31) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TY0PR06MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a572ca-c6f6-464a-6446-08db84396143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqFiX/wGj2A1sGtlxgRnf8HF3klLCmJ/8y0RlohQoxG55ULVoQ/tbYdReQL/00hrfwaPTyJGSL0uUuYxH8c19UIPeZViGNnfBLIaczjRRBYV4q9d+NmHUewc6qNciKqj2spts14k8gkY1HHzaxdL0/PwJsVhMk1lPabT5F4nFIjqFY/U1Vg/8L06Qf868StqgZw/3q99GK6LqZ61F7hMQXnkwOu8r2RcwMxI5Q5Y/gaz1AI7IkGakRzlo3XvmCHnQIfhTH3nWn5MUZ7D1yROwMeSCdCtgDQFOQOpuxFjVjU+SBfX70PXwxgKuPQ6/NTwj/eP6sLayi5FZclS8pTwbWoffQjb8C+LsDkLwt6tqZXN5reP8uUMjjN9NrM7JGRRQnz7ybbyHkGkGAunbcI4D9YefMJoDIFGvh5VRD6w9DUnl7pr2I6d/liNxKcDIDAHZ61Kqgo3upJvzCUITSiZNff+UapXDDWf9SBUcH5ge877o7obLl9MnKF38fxIUBFiruju/ZyVrCgawQVHGJO94VRBY3Vzzq3/0Mgv6QRhTBV99WLysUI1yxwUWLyT2JG/MSsqS5SZUzOUutf2i4Z1fkABUEDslW6Jawm5u/q/qruhxZRYCxCIL+f2hZFcKsCrObBYxvVHZ3yllfV/t94LaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(4326008)(66476007)(66946007)(66556008)(316002)(41300700001)(2906002)(478600001)(8676002)(8936002)(5660300002)(110136005)(6666004)(6486002)(52116002)(6512007)(26005)(107886003)(186003)(36756003)(6506007)(83380400001)(2616005)(1076003)(38100700002)(38350700002)(86362001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0s76GbI0LaIJf/KLEmAqEpk227In59RyE80P8/wEk6uLGc3VNUnuF8FLqAEG?=
 =?us-ascii?Q?V72hRPfnJ540xpzzOEoL1cAbZr/fIn7/B0x0zlaDBzG0uu8BRptWvUBnoA7U?=
 =?us-ascii?Q?UPIhYqtqC5FvpMXi4utj+PMcVoQPFtlYx06eDfOhFAFQptQmG8YB3JOPICtq?=
 =?us-ascii?Q?o/v5A4+bia16h8jINMJRJH2YH/6m8K57Mqt28WemMbM3rQQPNIxPxcJIQMHC?=
 =?us-ascii?Q?ZevnsJuAqB3r/ohfg8Jd/kBY8XaHaQYFko3OFxDNBay4b1+TNh4+h17W2glI?=
 =?us-ascii?Q?OIzK12WYRmap/3c73TC/vcvthg7iTpX8iheDUxY5cQVPjc4JRXGxo2dZWKYT?=
 =?us-ascii?Q?gUkwRuLy8AETgH/oE6S5fPU5UqjfGjsbCmSgde7NAKCY28uE4EgNl4Zyl/qg?=
 =?us-ascii?Q?7tR9rKZb8JEwyPPy1i2g1gPvTJoLMmsfoXmsr5+QWPI0VhoaD3T9/YzHqtt1?=
 =?us-ascii?Q?tGyBGTFYPIm/28pCSwGO0hueYH0rPbcMSCbEcey/SAs1rlFjce1CQvR2krNz?=
 =?us-ascii?Q?kGxONyq/j8VyLtAt3AaCSDy5Q+0GtVmhValySJyX+AL/CmSH0LbJP15zNfcP?=
 =?us-ascii?Q?lG4CBEdEL64rX1Bbn7SO8ZsZ/1VBItnYISlbxJ9KuzTOmBw5vcvHpj9W22be?=
 =?us-ascii?Q?enx7G9etYch+NlG96YwvyyfjeBju2wxF/7SCH283QI6FF1miyqDJ7EOQ6EKd?=
 =?us-ascii?Q?jsnCfuWHWhDAKtOAGSOJjhn0eOmJoRq7jLNmAirdzZ8mJ9hezJ71L+uAYudD?=
 =?us-ascii?Q?Jbujpq6n4+9UBN+9Amz/WUVFy7e5vefTKDdFhlX3p+/LlGq0L5mKXTGrnfik?=
 =?us-ascii?Q?0OsY6p1N4Q4yocfBhkYJaoN3MjIIdE7XvpzaC65CuV/00uaEq7tpSuqZ3pm+?=
 =?us-ascii?Q?y3fMdH+HsDMiAoXL5h7NUdoCRB0e/AKHrOn76UqHOaTPpPkhURughPTuuYdv?=
 =?us-ascii?Q?3EKkASF3HUzicv8TLuGjFwmRbYvqaMB66ZwI5nD3EnB+/jtO2iX/q+NZPFWv?=
 =?us-ascii?Q?WirCX6MN5a4UIzXJJ22WgJWv2uU8KfQcWxZJCk+n1g2PWj5Vf7SGNq1yOrN8?=
 =?us-ascii?Q?6bexIV31u3ruXqUg9ummahjLAJ/Isrc/Zr3Dqg1SL/xKTeXrlgZJstRTwAfJ?=
 =?us-ascii?Q?IwsG55CUpufu3qDBpekrxtuzuBGedUynDbg8yHVZpIyCbjhCFFETNLfKrGFE?=
 =?us-ascii?Q?lKXhaKl+BLgS2f4jYzuLz3KZIJFP4lk7LfZFKCjKArYn4dMhuYkYa0Y5vkGt?=
 =?us-ascii?Q?WOqXtVufiZpxrFZGZsXbpazFutLKFBcw5HVigg7d+Q1l+S0/7P+Lgtu5OkGb?=
 =?us-ascii?Q?CRFWcNc5DnKP0YqsIfXHVjJCUYPgXiEuN7JtDjPdQIc+p1kE00+RultNcYoZ?=
 =?us-ascii?Q?r4OUqhb0Qj/Vq1uD8eTpKd5BYd5E4nFinlHpAyaa9UEggMH4ANQv1RcZVs4K?=
 =?us-ascii?Q?JL0/vCs1pmbKPburQg/otBamTUlm5eZIKisB2FTTWHFLBxSLQR9Hqw7vw651?=
 =?us-ascii?Q?wV600QzJgio+qFfow6N+UPtOaClJdIdsZM9MpPrihbdLs9eNQEaC5q5awI9W?=
 =?us-ascii?Q?6zeD9CzJ9HWIt7PholjH03rE56Ssgzwu77B7gHpd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a572ca-c6f6-464a-6446-08db84396143
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:10:18.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKv5+hf6mb3US2YgAKrsE8WcHOUcv3UZwJSSbseXPpck/r7i43BEeoLUaVUXX5An1bI7YYKuVj5meYjF0BbqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'phydir' returned from debugfs_create_dir() is checked against NULL.
As the debugfs API returns an error pointer,
the returned value can never be NULL.

Therefore, as the documentation suggests that the check is unnecessary
and other debugfs calls have no operation in error cases,
it is advisable to completely eliminate the check.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
V4 -> V5: fix expression about patch.
V3 -> V4: fix the patch format.
V2 -> V3: remove the error check.
V1 -> V2: use IS_ERR_OR_NULL() replace IS_ERR() to error check.
V1: use IS_ERR() to error check.
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 4b41160e5..ec130510a 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -982,8 +982,6 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
 	ah->debug.level = ath5k_debug;
 
 	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
-	if (!phydir)
-		return;
 
 	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
 	debugfs_create_file("registers", 0400, phydir, ah, &registers_fops);
-- 
2.39.0

