Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E937D7DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbjJZHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjJZHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:42:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30471192;
        Thu, 26 Oct 2023 00:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uyodx2Ka6B9wm1aj9XGoA0og/xrb+ZN7Wbnm+hkqKYiCJ2Xs7KQed1zv7kceUeX9qQdgPrYj800+HGgyQZgR9IKDbtNjbvCTcpRs8uN6WijTDn+FRvnLictodclTe1ZoV7/bHvZZ/DZyVmKWpEBCNd9iJpAWrGFEr6M7h3Fl7Hr9x8THdib0YzB3t5PVrKuHULPVwDUeKrFK8HaEZgwG9onnhaQ2g90OYjl6q1cXuL6p9d9HtmOS3cnuI1mjnFuisX7hSfhxwLD+FqazKlwN5Sy+6SyPCUQgiHg+/Qfdnl13IsL9JY+InrpX5/E+VX3aIQRKzDIwHaJozzco0HWC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0si0XF/0Y7YucdFXCNg3Xr799yC2PhchuwuP9wxUP8=;
 b=TG3CJO2jWU0Tfc1qEKepTuXy6KV7VEeFm6SKAnyJPtzi+sLUgl1osP8Iw5FGgZcV1IGsohORtqutc35xYEj0XSmvIrkJfJybpZ262yPI1HEgjZcHDfYzQCjAWBwU+QeGKW/rARyNf9CZlQX4nAqf2C6TEwRes5Jwyhx52J6YX/4STgAmkP0vUm8Cig0VWCpZ3j53VJYVFZ3RwWYSPpMda/pdljBroKkPBgO23/K7gzwWTs/cIDIzaTMQlPAO/dvEdde7gl0dkWFHW2U1wNTbTg3vmVnx1ggzum+Cgm5hoABz7/VdJFxpBUh8AKznWrRVOeVpM4G7h0AmrJDsfQQCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0si0XF/0Y7YucdFXCNg3Xr799yC2PhchuwuP9wxUP8=;
 b=3rpfq2EnsIhBjzbfMm019aaQKfG/CRcIGl24gjHFUEmo5u73aa9LA7fHTqGNl55aAkMPvXlJx6tgJdD15+Z4U7HZF/bw1e/j8XoE6ytyqMfewqLSOUje4i2Cs2yYIJGZqwwk0jpWj3JKjPVw1cev/MfD8hK537tgTewgl7ZjDSo=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 07:41:54 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::ea) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 07:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.0 via Frontend Transport; Thu, 26 Oct 2023 07:41:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 02:41:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 02:41:51 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 02:41:51 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 1/2] drivers: clk: zynqmp: calculate closest mux rate
Date:   Thu, 26 Oct 2023 00:41:47 -0700
Message-ID: <20231026074148.7927-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231026074148.7927-1-jay.buddhabhatti@amd.com>
References: <20231026074148.7927-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: eca3618e-1e13-4e17-35da-08dbd5f70604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftSSnLMHHrrmxscUSrikwJCZf/z3MV55MEcjqS8d4OKLJ/2GTOMjCEIDmHWbc+dAsQJcK5BNK4a/0fhV0lhUtJuHAWhu+F2625jB7b031tDfrDKQfe+hidnBtzctqdv45KyH1XLRFAmtjGysPdnokH8kRe8DR4bS5iq8Iu92qCo72DhUqgWkEXOgimFbUwpATj6yZnTZjDhPwLer3pjhUaSOyeuHjY7swPo1o4vUXJUm2pplKuod3rn1/vYctZEoW6ou4zPHZrQ9cJYmljijlkt3zLydrWE8DiAM3Mi1S38iOqnz/0RA/uRROV2vxmlhJjeQ2WM13SM7pQ922ne7c+Bc8gI0vQxm3p1rCR/w26nrr+gNXH39SliZyliICMOHXKnPU5exvvUZnsUlpvepKu5htjZQQ/vYyP9VePBuVioebw9Wc7bJUa5fO5O34buKL3tJIIYZwT184hU0VRLlPCyDzUcI9dsQU9/qDD9m9IBtqQYWm5R0ICkkeh54OvBkjLgVFZJuj3hHILeeQ0f92FRVU3sjd1Im4ERa8DuAb43gTJjl93FxJFUnFzIC+VFIhR+r8cOTO2vGxSs4oY7pAL1zYJT8ext4drEd2gJK7oRT4a5PD7JnVHgk+bLYBKPDgdZ3QIcJvGRZlzmirQDt02cNIe5PIZ7wTaTxYWFYJkphkPy/TT0vQgHnWCoBFmiuX9JgffzumpvhbIu3bEwsnXkbDM6kLv88VB3NBA7h2u+rk47yl+65axHyVevlLNzRQBaqxzCIFSY+3ct6ltQcMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(81166007)(26005)(1076003)(40460700003)(36860700001)(2906002)(41300700001)(86362001)(44832011)(5660300002)(36756003)(8936002)(8676002)(4326008)(54906003)(110136005)(478600001)(82740400003)(70206006)(356005)(316002)(70586007)(40480700001)(2616005)(83380400001)(47076005)(426003)(336012)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:41:53.6072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca3618e-1e13-4e17-35da-08dbd5f70604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently zynqmp clock driver is not calculating closest mux rate and
because of that Linux is not setting proper frequency for CPU and
not able to set given frequency for dynamic frequency scaling.

E.g., In current logic initial acpu clock parent and frequency as below
apll1                  0    0    0  2199999978    0     0  50000      Y
    acpu0_mux          0    0    0  2199999978    0     0  50000      Y
        acpu0_idiv1    0    0    0  2199999978    0     0  50000      Y
            acpu0      0    0    0  2199999978    0     0  50000      Y

After changing acpu frequency to 549999994 Hz using CPU freq scaling its
selecting incorrect parent which is not closest frequency.
rpll_to_xpd            0    0    0  1599999984    0     0  50000      Y
    acpu0_mux          0    0    0  1599999984    0     0  50000      Y
        acpu0_div1     0    0    0   533333328    0     0  50000      Y
            acpu0      0    0    0   533333328    0     0  50000      Y

Parent should remain same since 549999994 = 2199999978 / 4.

So use __clk_mux_determine_rate_closest() generic function to calculate
closest rate for mux clock. After this change its selecting correct
parent and correct clock rate.
apll1                  0    0    0  2199999978    0     0  50000      Y
    acpu0_mux          0    0    0  2199999978    0     0  50000      Y
        acpu0_div1     0    0    0   549999995    0     0  50000      Y
            acpu0      0    0    0   549999995    0     0  50000      Y

Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 60359333f26d..9b5d3050b742 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -89,7 +89,7 @@ static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 static const struct clk_ops zynqmp_clk_mux_ops = {
 	.get_parent = zynqmp_clk_mux_get_parent,
 	.set_parent = zynqmp_clk_mux_set_parent,
-	.determine_rate = __clk_mux_determine_rate,
+	.determine_rate = __clk_mux_determine_rate_closest,
 };
 
 static const struct clk_ops zynqmp_clk_mux_ro_ops = {
-- 
2.17.1

