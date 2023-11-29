Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF797FD5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjK2L3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjK2L3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:29:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C284;
        Wed, 29 Nov 2023 03:29:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTrCGRKBSHgk1+XJP2snEUQtsB00Xuc16Nmb3q8nW3yonyKhI8bbLseQhX8abzFW9KgL1jsg3RyP/LbsMtt/x3NDiZsaLbMNaTplped0bKohR6AGQSn0SyMvu4DzvtE+n+4IumZkaGbXKUuEmpFBCfD6q9V1hjuV7vN3SZxESXNBw5d4ToXp+0wBzlKWAH37qxZru0bB9YURY43DeuyFP5aOhzYtCk8FKMe/QFLmp+UseoIW3PY/ij4js9+QLoagajL9ZrDeSwbx72l8qKTwX4lw8hT34V2WLOCToBMJ72NnwOe1+pDD7eLDUI8it2BR9vMWknDd7bj+9gmWkfzrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlRqJg2qMSFYAUx4SKubFDFhDCiP2ETTgr8I2+g+9bI=;
 b=LiMeIydAZWjMOYRQMnRLvB/I2FBIXY/V9PuhIY0IAKeMUnN+hFDCwKhMXxJ2/sghT+V8riofWykHz0scejf3SvOMcG14seQusPe4dfuAktJJr7RcsEu/jNA49C1NhcPCTvpdmmvB7bnUr2b2BD1YMvMjryC0Spaf4wJzz+g42FyQKNRn/p9850lDalpg/Il35OqC8hGuOrY2yRYgrTcKbBTYjMGjseCIcJcyJsXrHWnPP1c241AeTRDqZBcuYZR1rdUq7ptl5P50WpFxygZWdsVu519b6y/M+UBjJ6vymF4EWNGVT9jQ+Rk06unAkE4BxZG07lE48PiW5VUoMeTbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlRqJg2qMSFYAUx4SKubFDFhDCiP2ETTgr8I2+g+9bI=;
 b=jgpDcQUeq52oriP3W9SW2Zx1lh8CZZhgXoPmicA1b5ZKmvuuf9h9q5U+a46H6ldTL/z0q6nKsT3sYYl1s9MO3KbaHRQniIebaIYOzwvyc4h66Jgb8RBRNv0YeV2fS/464Z4noTJ06PfI7pRQ9M3nHs9i4DZFT4qnvxXkg5jnqQg=
Received: from BLAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:36e::17)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:29:36 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::69) by BLAPR05CA0021.outlook.office365.com
 (2603:10b6:208:36e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8 via Frontend
 Transport; Wed, 29 Nov 2023 11:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:29:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:29:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 29 Nov
 2023 03:29:35 -0800
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:29:34 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND v2 2/2] drivers: clk: zynqmp: update divider round rate logic
Date:   Wed, 29 Nov 2023 03:29:16 -0800
Message-ID: <20231129112916.23125-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112916.23125-1-jay.buddhabhatti@amd.com>
References: <20231129112916.23125-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: a921c8ee-9181-4c7f-70bf-08dbf0ce774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdGbi4LrfsobwDAL0yOjjRnfnsZBMNVRbWv5BXI2Q7CnZ/8Ua6mky705RfWsgGAVZdzWuhZdNX0B4/oaeWsOTam8B9qLPzsjJQpovxqAm2aU6ckP0N+Z6oRl8+E89LA9Uc0C1rSqY6CsGWcP9tRnjVMwefeSxeLuGJAOcLAyOVKaSEMrANQZyN4UD/pBPlSiktChUir4YqN4PqfjW/0NFXv7GPhMuJFrrfHpFKbDENkoTTr/seSbHIdr0Oq83ZtDWZopEPuZoz3jyjg6AqHO0i/sCAWv6HlyjwcBbaMEpY/KiQfQWB0HI4wSe8SGpMivvIrAk6f0oj7/sEGudOAnQjnhCxUi+OjPYzWwj1jRAyIuXwiRI1ehvIuz5+c3J8WCgxwrLSLKCL6U2zR/Ukc+YZITkss25Pw6XBHEUqv7QL3OCCLo6JBox3xhR6Gl4rsQvr4sApv3/sqUe8aws3osEqWEW1oAsa/VSO6Z+RPYv0KIhfd3n9tf4SgOUOPNxbmmX5rOqXg3NhloRLuxlQJ17Yw5h6bFWkVxiqK/54wegIV7Sa8HmAFW0Q/BSXKgn9U7fAWlFiCJX6erguqyDvMAHn1Lf3Gmn1Ed0XFafqDj8+38X45WydUIVH5OjN46U45m0GmDvra6PaxIlphJ5eU2SroDHsSrHO1zVbiAUstJ5DWQJx+YFmzHAh78ho2d1WL8TUAgMGv3v1JrT9diKfrhjIZXV93dG/ausLKIDDRLSW5EUyHI9CgqgD5/p2TASCsvIkh34E2CIO8d/d2rJ8O5zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(47076005)(356005)(41300700001)(44832011)(2616005)(86362001)(1076003)(8676002)(6666004)(8936002)(5660300002)(4326008)(40480700001)(2906002)(26005)(110136005)(81166007)(478600001)(316002)(70206006)(70586007)(40460700003)(426003)(54906003)(336012)(36860700001)(83380400001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:29:35.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a921c8ee-9181-4c7f-70bf-08dbf0ce774d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

