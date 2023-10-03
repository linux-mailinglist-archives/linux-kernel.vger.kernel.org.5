Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C77B60B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbjJCGWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjJCGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:22:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE20BD;
        Mon,  2 Oct 2023 23:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWMN//X/w4qU5JPG0xbyxDrfYMJqvyk/UK7BdZpsiRAjjQMy43qMkfY1ohJZ3G5HxGdeuFx3oJtzoS8invQMZuD3/OTYKGNJ81kNyKb4Xm+BZ4KeMRMq5Rbn6taEwPDK/14YvCzesH+IWVPFjBEfqJcYiG7l1j6xENMxYkQUxaq0aPO7jrjNzW01Yp0cAAjz5+4SAuQag9bzDYOK80HmcBKO/ky33oyr9waZVsOO1Ovfun9CgmCDrs7YH8zoe/+B+hQy6h03vDFkg2o5ZD8ksVTWhl2Y8wTUtArlEaRABrRZw31btUI/4v2MHQpZ5w2HZnTwDG3Zqb+MYNhZng7p6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX/ewiwVvxectQk+ywRB3ivU2XZjRqHGNqzA3sRY6ZM=;
 b=B7V5ujDKHjCcJpnr8gpzcuWhvG0sLfDHcezPJVl2cX+zpvL76djE6kju2edbMrd2niBuirfRe99yhogVvSltmhQN+hkDFV2vZPj9WGHwaSIOzYO1hNEd2DuPYqUdMAlsNt8BYHuabjL+HLnIRIYl1+TKbn059EyMOveX7mGaycCEPoa/ovu6ciWJPossYdCcUo6FZapPIXZkg9CuH0VKFfsQJuxsNNrJTTAsMYRMIldwgqZ7ccReKB4i6TDBBfwuwiKODcuGaXQo3CXeZIHhgQU2Lto0qvUqNuc0RYjPoQUCjtc5RLDtZ+swrts7oRYCyo/zEVGcZcYffKMeIU6hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX/ewiwVvxectQk+ywRB3ivU2XZjRqHGNqzA3sRY6ZM=;
 b=B/9X3C8PpZq85/ti85JEIUWu962TVKtTfeSYf0LSCMYv0ekpSIUctKSAIjGXRsqOT6LjQRW/fxaOvrk0qMD9QLYCGUNuBS/sxxgSbWuBJ07xgZTe5m7fj7mbsM2fI5ZblJ5Tgfx+7ZUscIlTgkcP/AnHnxGBt0os1wflfwVW2kY=
Received: from CYZPR11CA0014.namprd11.prod.outlook.com (2603:10b6:930:8d::24)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 06:22:34 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::17) by CYZPR11CA0014.outlook.office365.com
 (2603:10b6:930:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 06:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 06:22:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 01:22:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 23:22:32 -0700
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 01:22:31 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 2/2] drivers: clk: zynqmp: update divider round rate logic
Date:   Mon, 2 Oct 2023 23:21:53 -0700
Message-ID: <20231003062153.12215-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003062153.12215-1-jay.buddhabhatti@amd.com>
References: <20231003062153.12215-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 95873bb7-6ea9-463a-a3ee-08dbc3d9218d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yr0NCl9SVktay39afOXzB7+hn/+GLu6oD+UjGSWY1sw5j7wjkECRnTM38qmKiX3s7zNSISbdKx8ZNc4loxD0pWBSlgabDd9JJOYRVwnCAOYYe2uCv/5oJBmXQ//g5RLAU8LwRgkeqTsigTL9ZnBKessaOor6eXDEKR3CWZ1o+p6jxn+xC/HlVAjPdCsDBQVfm+X+Uef0YMnNe1V7uWy6wqzOv3pYBU+GRIYpfLdp37opXsZAO3pPlpWVNPGevd8gpBk3PhnvFw4zjJ6+xjbX9DK0JNaDZDH1xp33X55rlL84gJCfELzTGkelcWbWCoVHtAL6UPZX4IgwPxEMGLR8UCUQmEuSKu0oJVv2XMYv1K8G7wny+IuCuXKBNUrAQjWY649/sGM/C7myYsuvgrGc2Z2XBwARcWIb++8LCoo9l7cbuW91QWT7h/cl+Lc+tlwJJ6jEgN7vl3U5MEMaiwtxCD41j/SXVvgq60PoV0rkvV6CgxDtNPCx1DSKPNthFx0m8h/IvwxYGPV0e6SzD2S4fSyeRZcMwh3+mlF0PxGa+8IV/rhlZXljJJaGZWEL1Z9Bltitps3p9drJjLScj2rO2+RQlxFADxhMbaZCvFJWce2u7x0cryih1BjUzqqd1kcLiQy7B88x/vetybeAvkEQSPSM3v0yAG1RsteQDg+R3RiXWpDsNkUXOLT4PBtXJAPvnKkSF0KkFsJ8EEckzKQKQxoiMCW0YWk6ayTsj5eQMENYuRHVZMubRG83Idi/tWG0udbIlurYRxwodF6zocrBtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(110136005)(4326008)(70586007)(41300700001)(70206006)(44832011)(8676002)(8936002)(478600001)(54906003)(426003)(26005)(336012)(1076003)(2616005)(83380400001)(2906002)(47076005)(6666004)(36860700001)(81166007)(356005)(5660300002)(6636002)(86362001)(316002)(82740400003)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:22:34.0369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95873bb7-6ea9-463a-a3ee-08dbc3d9218d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently zynqmp divider round rate is considering single parent and
calculating rate and parent rate accordingly. But if divider clock flag
is set to SET_RATE_PARENT then its not trying to traverse through all
parent rate and not selecting best parent rate from that. So use common
divider_round_rate() which is traversing through all clock parents and
its rate and calculating proper parent rate.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/clk/zynqmp/divider.c | 70 ++++++------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 33a3b2a22659..a42c183d7e5d 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -110,52 +110,6 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate, value);
 }
 
-static void zynqmp_get_divider2_val(struct clk_hw *hw,
-				    unsigned long rate,
-				    struct zynqmp_clk_divider *divider,
-				    u32 *bestdiv)
-{
-	int div1;
-	int div2;
-	long error = LONG_MAX;
-	unsigned long div1_prate;
-	struct clk_hw *div1_parent_hw;
-	struct zynqmp_clk_divider *pdivider;
-	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
-
-	if (!div2_parent_hw)
-		return;
-
-	pdivider = to_zynqmp_clk_divider(div2_parent_hw);
-	if (!pdivider)
-		return;
-
-	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
-	if (!div1_parent_hw)
-		return;
-
-	div1_prate = clk_hw_get_rate(div1_parent_hw);
-	*bestdiv = 1;
-	for (div1 = 1; div1 <= pdivider->max_div;) {
-		for (div2 = 1; div2 <= divider->max_div;) {
-			long new_error = ((div1_prate / div1) / div2) - rate;
-
-			if (abs(new_error) < abs(error)) {
-				*bestdiv = div2;
-				error = new_error;
-			}
-			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
-				div2 = div2 << 1;
-			else
-				div2++;
-		}
-		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
-			div1 = div1 << 1;
-		else
-			div1++;
-	}
-}
-
 /**
  * zynqmp_clk_divider_round_rate() - Round rate of divider clock
  * @hw:			handle between common and hardware-specific interfaces
@@ -174,6 +128,8 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 bestdiv;
 	int ret;
+	u8 width = 0;
+	u16 max;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
@@ -193,23 +149,17 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
-	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
-
-	/*
-	 * In case of two divisors, compute best divider values and return
-	 * divider2 value based on compute value. div1 will  be automatically
-	 * set to optimum based on required total divider value.
-	 */
-	if (div_type == TYPE_DIV2 &&
-	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
-		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
+	max = divider->max_div;
+	while (max != 0) {
+		if ((max & 1) == 1)
+			width++;
+		max = max >> 1;
 	}
 
-	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
-		bestdiv = rate % *prate ? 1 : bestdiv;
+	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
 
-	bestdiv = min_t(u32, bestdiv, divider->max_div);
-	*prate = rate * bestdiv;
+	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
+		*prate = rate;
 
 	return rate;
 }
-- 
2.17.1

