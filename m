Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A334F7534E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjGNIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjGNIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:16:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7135A1;
        Fri, 14 Jul 2023 01:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwIWDDxIJedqzNANI4wUffRXzAflYSauAu+tRhmLMFORhJjsLWsHeZqd+/R1qSqbgKma4L7aGhyKFAHBIoJcrGb8RuHxq/cgFj4kofMcWNoF4797PDUAa2AR715DmfJymIPhv6SZ2+scMjLXEjz0YsyUA37kGPMKQmqZlwkOoKWq/FsY6wvVgU2Hod/QPqT8tfRfgtF9FpiJPLF+SiX9PK5GmrlABCwYycnkQBG44O8OFtNDI3fuZg52+zo1JfLnA6768s0RZ1dt9D/Z/x9nQs01e0RuxPQ7+Eparj5+/ToQX/BaD8v6S6L7KSFvNtzJRuZMFDfIdMXpwecNoWQo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ28dVNSLKbW9CjeAivZPqbE9OhktYJMFusMoWkmXDs=;
 b=LIfUKQ8zfgffWyDgbQb888O/A6vPJHsWGzoXy0/V06l9+SCxFhMgl9rDc/3I3UPXqg3BWC3CVxLK8eGZDyud3cGYkoI0DKFIqUZDMlV/TJTFe+j22frWt4Yd+fY12bSyFhIfeHZ5Xev0CIjzXoEludsbl6yHV+7+H8vLcGqDXV2UrWUe7wqwwAMKE9Xh2DW4Y3FylrD9hqtZjrAoN/4+sFdDEe7+bK+NYKP82aaGi4RL7wzVMrGPo/pA5+vbMrIYxoonFgj1RBnWFrZftivXTXSY7HIE55fH9nS4yeIzLHXfHnncZuuyG9Dw4NL+OdkfibzNLy2lLATWsdU802U97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ28dVNSLKbW9CjeAivZPqbE9OhktYJMFusMoWkmXDs=;
 b=oIcVK/0snu+bzL889CpZG95LuCLSGxvMC5YIM/hklXfik2aWc3tYK6t8oKK8a4nCtAbSzB6Kv19ZB9ypzxIs7PDFLefk1IPtwymEc29dunsjtBqFJ8mpLhc4xeWX7rOJhfOWisgFAExrCeo6J4vlx8R7D6+LcpdNCk8M39Z2fR1QHaND3nP6SmNeoyJyrgcuhO4WRfu96+3n2DVNZhhkOc1IzFezenz0qVAgRz2inepVlmPZ3sJvFnWH8d9TVTkoBS82nvWdAnqNtertLbReJFH1IUo6cWm5Cmx8T+x9eHwqTNRKME+LvvxHmMKczcvfWLmgsDNiSk3nJgbRkHg8gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB5340.apcprd06.prod.outlook.com (2603:1096:4:1ec::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 08:16:28 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 08:16:28 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v6] wifi: ath5k: remove phydir check from ath5k_debug_init_device()
Date:   Fri, 14 Jul 2023 16:16:19 +0800
Message-Id: <20230714081619.2032-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f4a85e-70a3-4ed4-bed5-08db84429f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VjbX2EJlj5Saq3oQc6knI1FD26pXzTJptoDwB6LwI3CEIJ+FXHO9TUEDBTrarJvwcx+FZzrA2u8z75dbP8qNxrlya7ahtzdPnlcO47Bh/w7vY2pYdqCSeP/5FVqw49YTfpKrXpoMtV4l2fkZOS7e3ukbhkkveL6l1m5a4782OMjNTh4iJrBSae5wcohgKXv+Pb78ESrvXj1ers8HXxVhmJh9iIWDHrmEAjgOkGH+M05Holizb9b6PDE8GLD6bxsC66TlF2BsNqJ80P8JAL5DGRu99pY54ReMbz8J5TeACB1W2C/5Ahmw2D2RjaoKzGOPxALV2GtjVjk5Xo5XXeQoRbl83BSYcUc8SD31pZKLnMHC1S7relp7khax1m9oAXd1gVea9b2Fb2kZ6JvtJyVi9fb8brDlwIRJjoeOaD7L/Hi3XwdW0uK8jTSmFRfyIoMN4KMrF+dZtfUhlWIJiEEooMninemY4fWNFqhYquKKLqsO2u8bgb3IxnNT+cbPB6JwJAdPqA2VkyVzZLg7TGTNESYiMueq2r2b+C12BOIaGCCJ8TE/+C+vB4xEbXHwBsQlO7NG1e7VE5wZ03Vj4vWkSc9D9v3JuItomp166rudiMq1aDlMxqZHS0mYW1g/8ixwSvKOaAtyuYGS9xmEizf7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(52116002)(6486002)(110136005)(6666004)(478600001)(2616005)(83380400001)(36756003)(86362001)(2906002)(1076003)(186003)(26005)(6506007)(107886003)(6512007)(316002)(38100700002)(38350700002)(66556008)(66476007)(4326008)(66946007)(41300700001)(8936002)(8676002)(5660300002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2xb7U0cMwyS1gz2cIxA+eXbkNbxh97kHhA0hj9dckMgntwVGZo9+PyP1QZPx?=
 =?us-ascii?Q?FesuvQN1yDpO46iUvfSHCZmL4qRNTgG1Bku4oG4CYHFNjtL4+ZnBl3eZCDgI?=
 =?us-ascii?Q?meFqOjp26E1xeDo2HS9CN1qSqRSGGmkpiI/5/r+TBe/NlQuO7nSSnBXi91ng?=
 =?us-ascii?Q?hHTuTCy7ebihFLvSj6u/u2grgRYwUHF8W3Y1v7ovszJj5dyd+cy5F7ceF9Uc?=
 =?us-ascii?Q?rrW02v5M2b+1vW6DhBzAvE7lh0BI+YnyCJ7u3kQu0IF7rUkFolfp6zxn05nX?=
 =?us-ascii?Q?GytgcvlR3Rdh4zrQ51k1WP3ycVMdn8Qu7j28J3dPwzW/MSXraIxUSVrFdVzP?=
 =?us-ascii?Q?yGxKPmgNuMTAdUqgkCO++nLJyJoEt0pHRCLK42OdNHRj3WgbuqAOowDmlyBd?=
 =?us-ascii?Q?1iSzhQ+MOKHs3yxiJh13vZ7g17x1c+Q+QWKYHZpxdGAiVitlwpKz+CRd2rpd?=
 =?us-ascii?Q?toUNTfWu5ngCZiCv1b7u3jIKFHAaLWx0goiYb8dM20/2tFuHKRC2gdz8K/TW?=
 =?us-ascii?Q?y1IHqFq1ox7jmr8XF/Am+n/fg/EvtzuSiMaVco5DiLaIuLnRTlr+FIuRQ7ex?=
 =?us-ascii?Q?tqvMLQB+C21nckceQ2XPFWw9sDYPdU1dWbSCmpWoVfpq7KqMy4ukiWNIVqz/?=
 =?us-ascii?Q?zRCB0EZVflPQQiVlRfe3ob1lLisc40d3VrS+1bBJv4l5d6sHsvyGHUYk2fHd?=
 =?us-ascii?Q?Kr3D1HPv57BSzZqUdPN96iheO+6o3HfdSbQEYo/yvd3xLHTAGgqbYHI1sgnT?=
 =?us-ascii?Q?8Zy1JSbXG2lZz8taDVnogjsTlVWFHMi7JEzK9gszqskW8LX7e/rDZS5dUziX?=
 =?us-ascii?Q?/OZZoF8aspBuoL2TerpmywFH6bXC/cvxj4bYNGsnbdfCrEhe0ETgfW9sk3i+?=
 =?us-ascii?Q?WWNW3lQtzYvzPzMB89M7BCMK8fKmipsu4b+1AS+5qfr+YfKkmVh9QH0a0kn+?=
 =?us-ascii?Q?nsv+Eyy229xVDeGvY/ePxWNZgG8CoZqeoNRdrVaUuAA/I2FzDZfcphXxrvmS?=
 =?us-ascii?Q?+lVbrFV+ZU0ARXe0AR8BK45tSkc8cFPGZNwciG9WZfD9fN/o1GGS7ETT18zx?=
 =?us-ascii?Q?ouihH9JfzcQRGsGl1f2TD4Qguv4MOBmp8m+I5cjx4KOzOdB/lK3pCDVcbn77?=
 =?us-ascii?Q?d3fs/IbQDW5zKf8xBh4tjD4ZFXkAmfUgPpeq89/h/rXh7Z9s1nPG5o7Mt4j0?=
 =?us-ascii?Q?Wa9q0MjwbylKcXY8CGgvtKCBU4T3Sm7LP3Gg++d2ZsGkuPCWdtZFFoCdG+DW?=
 =?us-ascii?Q?Yhx6hqOXHtRfqRqZKfzKP8Az44GSgwhXK8UgGw0DDVPgVx840AMhI4UPKUzE?=
 =?us-ascii?Q?zDY8w1XWM69d9R49ppsvytCmpYPPYtIzr1zxkp79futHTwn/kN9180fELaBs?=
 =?us-ascii?Q?fc2Tf4DBoSY8v5O6Bbm4MCYn/Q2AtvQFPFM6EmqcL5Giq3InseYIVM7kQRhX?=
 =?us-ascii?Q?aDoil/2w3J8BAncfr6N8eBH1PzUVVjpnCUVU92cDAxsftCIhFEBCiOHxz75g?=
 =?us-ascii?Q?X8H0ms0GPw/HsWNrUBI4gfuuE1zv2v406UuIS78MEonVZ1ECvFRtxRILOTbd?=
 =?us-ascii?Q?2uH23COyQQScWzpn/f+ZbkxnsLK/DtqRaQ5Qnfgk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f4a85e-70a3-4ed4-bed5-08db84429f67
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:16:28.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57a/P/M1V9nkXkSxEUbYHmmC3kAT1VHo8babj4RIBVqEjAX6WnPvhGfNlvDfaoaLODKb1Xgi+ONfYoMdPm7qsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5340
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
V5 -> V6: add 'Reviewed-by:' tag.
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

