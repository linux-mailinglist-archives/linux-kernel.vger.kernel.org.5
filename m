Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B37E6A56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKIMHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKIMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:07:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8818E1BDA;
        Thu,  9 Nov 2023 04:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4zOFQdK3jeTf4gyxnBrzZEhUrbQL3Omu0tfb2bo8zU5wiukGdx5Ql63m702z7gFa/l1P8+xuZzvyCDWmkG15A3BSF0y0XZT2qHoVzzDI+Y0me0uZfy7dfTUjlrgbhbep0EKraWj0nJ9rGtMhz1v0C30WNJ6YjqJqwpF8d3V5v2rvOfOiZDk/A8KD8LDrCHZNoY4D78617eiOq3qoqbREtiVc/hkqHnpjwAOXxulMznTt0PDj+zTMEsDvmUmkBZzO9Rb/sBLO9gc040PZDLq3ASLfyK4+p++cjC/wINEaPhTe1H7O5/ISgZDWACHwaplafXSNCsFJuB/0Kswti+WbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlRqJg2qMSFYAUx4SKubFDFhDCiP2ETTgr8I2+g+9bI=;
 b=NLJ7+06Vfr1Y0WGbVcCfUTvZnYN2zgDHjqnOU4FJKliAKxaETXc3Eth1B9EduDPjzHwBIx5GVWbVc2MXxakXwSKGkgQmzC/bAsLaKYrGZAt//3RIw8JDH+QIYl7PhpMM63MKMl78Py3NWNaVFkXHeJVKGTGN0m5WKC8Q/5gmW3lShfr1g6J4XP1rYsp3SNzpADQ3hz0YpGmNFyq437FfllJ73ir6ZRfyHL8uKLR2Eo1bldVTWmyPPC1bmoprPPizDyBM1Szw6gMs05+gGazsBsYrL9Dp0a1RdFl3A1uFgaBHYnyjoVqI1pi6CfTY/QsjRoRcyrR/PwEF2ik9CS25Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlRqJg2qMSFYAUx4SKubFDFhDCiP2ETTgr8I2+g+9bI=;
 b=yHuJv4Y/y0003V+itlbvU8afYHXrjvS2Fj/BEil6T5LuzwD4Y/rE/lWZOrtWJlc6+rX5h5oSuMDq+zlmQkPmVWluQPBPJblNVgsKFpb91iLEyXNtQIV0cvAo3GgueszyFB1mA8P703aDvVCVYUE4agir7kKO7tso/cWZxs99sQ0=
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19; Thu, 9 Nov 2023 12:07:11 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::4a) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Thu, 9 Nov 2023 12:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 12:07:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 06:07:09 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 06:07:08 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <olof@lixom.net>,
        <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND v2 2/2] drivers: clk: zynqmp: update divider round rate logic
Date:   Thu, 9 Nov 2023 04:05:56 -0800
Message-ID: <20231109120556.29348-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109120556.29348-1-jay.buddhabhatti@amd.com>
References: <20231109120556.29348-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ca8644-89fa-4c82-7ac0-08dbe11c672e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAsjE944wgYw0LT9wLbLX8XoMFjutCYk0HRuFMbsHz+eLKSRMOGFtD6y80xueUkiKn5WZsJlIep8m/8Z5wTrS9u1Sf9U4Gd0P1cRrHP8LiZIegtRlCw423fqFAuKG5i6UBGmfnhcrzI3BXBUuXdNuWLipT99TcJd/gDRZ0ZLpEOXjx3qkPUeXcRZiL4pq4t9LZP4H2PiWGjAbDcLmY1F9QeRKrFO/+gwHRHMnIbzKkNEF65aYA96lfrmwMGaDNF+cjmf4V8mxl0iUpIp/m1jZxt2fjVuSnPyWydilRPFqCUm2NSNk2aHRdDJenzaricOByXo+FyRinhpYclTtjUy/SzZP3ZfNFmNAtGv9r1yytoB5hAvk4swsZvwmWQlcU6BaYC4ATpV6rKW1WTo6+dg3mOC5kHJqW4hYhTcRoOY06LlELsx1qK2/h/YzXMlYmntLotd+iRCOLNEgkIWEE7J/fAMVZEDOYVmQncxr20cpPKjKlrnpYhKpeNjEiGvTeb3ybphoPYjnE/qeQID+XM5HofQmE5X1LaFQ4k0ClAGTnXZlsC2DpXhA0KarQH+KIuLX0VJFlyRjqV51Qk+SE1KoXh5JnBROlkj8M2Xr2kHv2ajE3B0DJOhdhbO/6nIdSjhKAJH8aoRJlGgbzuoa3jqBYm/UUnPR+WCshWYk2gQAcxRSKkpVDA4ESD5YUdQDkT5wc0tiJlUgqJfllAqslUny+wIsWkSdTpntc2mhBl1aG3m0O9F+lGb/j309/H8q6XH1B/D2+Bq3HynFW8qQTrV2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(8676002)(4326008)(41300700001)(5660300002)(82740400003)(44832011)(40460700003)(81166007)(356005)(2906002)(36756003)(86362001)(26005)(6666004)(47076005)(36860700001)(478600001)(1076003)(2616005)(83380400001)(54906003)(426003)(336012)(110136005)(40480700001)(70586007)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:07:10.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ca8644-89fa-4c82-7ac0-08dbe11c672e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently zynqmp divider round rate is considering single parent and
calculating rate and parent rate accordingly. But if divider clock flag
is set to SET_RATE_PARENT then its not trying to traverse through all
parent rate and not selecting best parent rate from that. So use common
divider_round_rate() which is traversing through all clock parents and
its rate and calculating proper parent rate.

Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/clk/zynqmp/divider.c | 66 +++---------------------------------
 1 file changed, 5 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 33a3b2a22659..5a00487ae408 100644
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
@@ -174,6 +128,7 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 bestdiv;
 	int ret;
+	u8 width;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
@@ -193,23 +148,12 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
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
-	}
+	width = fls(divider->max_div);
 
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

