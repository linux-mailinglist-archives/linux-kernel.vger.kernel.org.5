Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6307D7DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjJZHmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJZHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:42:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526F186;
        Thu, 26 Oct 2023 00:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaIycbKwN4hxKzrFOVc0SXDZHQ8V3YInJO9uA5xcdt3GOXZzEt/xto0mANE4HY8UMUvDt5Wfc7MSQQ+ikIqxhSOEwXpz84B4VnojrgFzrcLrVkIGtd9sH+BM+1gQhf8AIG91vhUZjiEVKun2FJO2ClTPctRWExIgi9qyjqzM468InHdCUDyJaECESUEKrzl7+ipVBIxZe9aFk2wJlWKquWg9ACnZ+RnqYbMiqKPJu9EhcvvUVA/lJhqA4PHNRv/mF6b1ovK7gGAWGeceOnx1XSgDJM1eY6RWiSdKCn5vVvLVcLGyQLrbe1JKXG/10/JwCU1CuiVHU0lhL6mjInn8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlRqJg2qMSFYAUx4SKubFDFhDCiP2ETTgr8I2+g+9bI=;
 b=MsbzGIUfKAhEGjjC5180X6nY2NDl+jBuXY37uVY33cX/tkULrlCSg5Zkitdwf7C2z6m3DLwerUceftOSj0g5S6A9GhYyN6Y7fxoeJH03+1UHZQNtHWfEzjVJOcajZ8byT49Bsn8PcaPDhZitJixrPfZHCKpBxFfVsG/sTZQSYi845o3Uo68zbSZtJ8/dD0ZlvLHpNJxQsKilqLengGt8Jui75oZjZU6DXGqEc/raqpNCIlHTFbkKxedtiLvVDfNVblGcIPLnoouY/QaAwMqgLLE4fJHVIGZTotkMnwAUvFjIbeBk7L2RBvFgsaU3nmqz1ZAp7guotEBfCPsj1thAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlRqJg2qMSFYAUx4SKubFDFhDCiP2ETTgr8I2+g+9bI=;
 b=C2vyqDu97VhBA6J8YwcuPL6Cl4hqLiHaKz65dCbS7DbBz/Q9nmE3/flFRhnIxOygtsIjLIQbD01ntYMbA69qE8+Y3qWA1v3l522IbUiCCO+8DBvg8/kDV2BS5W6Vm6aOmgwpELIJgJ1yMB87m2dahMG3JFTLwUUHcNOloNtIg7U=
Received: from DM6PR08CA0057.namprd08.prod.outlook.com (2603:10b6:5:1e0::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 07:41:53 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::91) by DM6PR08CA0057.outlook.office365.com
 (2603:10b6:5:1e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 07:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Thu, 26 Oct 2023 07:41:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 02:41:52 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 02:41:52 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 2/2] drivers: clk: zynqmp: update divider round rate logic
Date:   Thu, 26 Oct 2023 00:41:48 -0700
Message-ID: <20231026074148.7927-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231026074148.7927-1-jay.buddhabhatti@amd.com>
References: <20231026074148.7927-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f345716-9c1e-4a4b-f50c-08dbd5f705bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZTJtkLIYw64W395kilzcaXyxXN1Kv4+Aft63HZB7i9v2/0A9WAeuBuhTH/QaTUEFEp0KSzPKcc9l6gQnXaBvYC/jY08vpXO6buC1dcHPYB8Z8DBrqcNuwSTBpoMCHDzUWnrPt34aKlvbFNJvcIXq+RfjB5OdzUmQGQPfR8FM/yo6ldf/PJkUz6ALIAhWdR7r4qkbg+4ML17yw95ZxZy4PCXaMTcbxWRSh9tGO3pm/PM8LyoQGdUuaL/j8gBVw1rnsSdNMoWvKTrh7CAaEW6f5MoYSzGQnmxEFxnHDSfYQ6vHTE2Ku/9saYVs8v/BgaaepiOIZqxHJkKPhICLOuKxcOcpxx92VNdHBmei3PY2D4Nv7srJYRE03SAVO5yFIDZMAcE/XWmThYZztYJkja3Ukx0yhZcAu8iTFP6dgZW7QdSqsefd/YM1TZkeUrUVXJckTY0s/yCQORX43nWRhEwPzGXDwLyn+oiG+rvejWZaE41TfIDdiaReKRG1sebtmulQmc1ryYwoYeJtTRhjbqZ7W0uhqy1G+ZotPD/oZ6xx8nv0uGVPC4t05eXzg1nU8XkXoGgMSuwyVsaWVGWVxR6W/HY8r4BBCKj23X9lejxMlASYufTqEmLzZ517DUaUcMC+S58QiDYNHEdJ7rBVXjKuiVXpcbBZ7/O9lLM9y9Dof5xcA5E99Y8Y8yhZmdrbp3e8YcfysdJBruEj4qCzWOuHrbz3Czva85jmZiAkSCyybMhWtDD2s8PRN1p91jZdvaty6h2PkWP5H89r6SQ1mN81w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(4326008)(36860700001)(2906002)(26005)(8676002)(36756003)(82740400003)(47076005)(81166007)(426003)(336012)(44832011)(1076003)(2616005)(356005)(86362001)(8936002)(478600001)(316002)(6666004)(5660300002)(110136005)(41300700001)(70206006)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:41:53.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f345716-9c1e-4a4b-f50c-08dbd5f705bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

