Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668897B60B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbjJCGWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjJCGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:22:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A3C4;
        Mon,  2 Oct 2023 23:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0ZtMetMc2N5XXJecM6uFulfN/h5NKB7wA59CusQZ82Nx++DRLiayzrK9uzstdeWsva59MYz35v4ovSZxMx8hL/HelK7JLFuSd/74jM4dVx1t1eYIMd1w9DrEfOkkb61J2S+dm/X+fbtslU8inWs3AutUHNaWgGWAC4Mb4D2kl9vLYZFIt6qbo0YFnlQXVqAf/uWT5CTb+/uiBMz5zjwkKa5utiIc+9Yy5Hw2aPmk3d9RvFMF3jVnbHvfVbZzO4Cy6lsH7Mnd/geHazI8E+M8DRV/cuCmEYExscWcZkPt0VPWswrbpe7JdBMO1JILZLB+o+xAZ5VEdNZ3WKnNbUEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN4yVn9esUyFcQcbMxFoKgdLb/vw51euHpR+9+X+buo=;
 b=kJsG4KXoghbtyIp22AadyTRI3UGgEg0DOk8xpO9TFH5B43qJTTcOknEMpbKvmWFvna03ihoioPaE7Wud26CBDLxZ/pEEVSCYHhCMfg/MgUgD2DXTFRBX2XAnxbwzqUB9uH8/C7wy3IIcKSe+hcFQKfr2iFhkomQcojZ1LQ4tAqew1afcgqyK7YCq9Gq7jWhJxuyER47Gp/blSxoZpFnahe406bbVzvN3hQE+P7LFYzscazJYBPN8GS6KfmiDtbUQDJCwGv0buLfRXB4+f+zkkUxjM+B6dsmos9sBdN6Xx4/koIaXCzjXgmudZ2wY5CqAzekA/HGhnrPof1my4ElY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN4yVn9esUyFcQcbMxFoKgdLb/vw51euHpR+9+X+buo=;
 b=AHqHdmNdt63BujmmTXqKVnHyF9OLBeFde5rOZPfj3F1CXLgaIFqjbdVwF21LPjtmDQBPgzHKV9SBXZ/bHHfhzg6DFKzMUNJtHI4gafL94kHJCzvTp2SaYXWUFNB4vAIrLNCApt2QejtTsvc4pWq65F/FX6+MWYVP8ARKTV6R5cU=
Received: from CYZPR11CA0014.namprd11.prod.outlook.com (2603:10b6:930:8d::24)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26; Tue, 3 Oct 2023 06:22:33 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::17) by CYZPR11CA0014.outlook.office365.com
 (2603:10b6:930:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 06:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 06:22:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 01:22:31 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 01:22:30 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 1/2] drivers: clk: zynqmp: calculate closest mux rate
Date:   Mon, 2 Oct 2023 23:21:52 -0700
Message-ID: <20231003062153.12215-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003062153.12215-1-jay.buddhabhatti@amd.com>
References: <20231003062153.12215-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf720ad-4a4c-47d0-bc5b-08dbc3d92124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtfyiLDbamowImTNj8Y2C6AmtPLAdar3dEBSMxF6EdMRTdu5DllSIr/Ij3rIAF97m+QeIZrE8kh89gRHHBO2vG8INGsc1L/nV3bOB4XCDdT6TIrmxp6i6QnLwNUjSJXTCanwYFixCCr0r3lsU6aqy4YflZ5Fr0Dw4Drdcay1zpWyPemCH90pHymTiTmQynx3gcd6rSB+PBNCvBXMgDU6xirm1luqIQUyJIkfYnzOARMvUYH9f8RI4oF5tIgVYUHmsc5qjOukhdsQ7TxTJVmnij//QinQ3E4sStUBV6EjRaCvVsXfKlnj1NlDafukPNqotXIwyHt6ll8AXLmjitB6PQsan0NZ9c+IQRy84+4qxONXYck/J+lQNWObiryjm//8Y5wRoZ72sX2uSczDmhv7p/2Ouxtbf51Ba9/rWV7vhkctJI3bqP/V/leH6v6xM7bM8XsuCbfvYQX3zt4MDdCvVfh6OdDWNQP4VZMrZth3jj/LJuKEnFE/02FDjImzjRBZGc4FMWdws2RhKIoOLRY4dRq2h5LaYufjTL1jqyYsUHdbvJ+lXXcl0BVPy8FGyJGnb5f9q4mjwMXjgH89Sh9yDwgnQ5QUUcUh0X024pwXTyi5nUPkLxHjXOfAGDqd4bjYRG5/MxhttMcNKmWGZWF9H8aoNn2b+SXZS+HpmdnDprT+H4lYvpCyocbVKoGgznX6ZIW+vM5wAHMoPi3hBBz4ZrqFxAFY7ovOASrO4llhcD4RSkSqo19jwt4LLc6dVQBGIA9S7dqqjCiSbVsx2ofdYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(478600001)(2616005)(336012)(2906002)(83380400001)(26005)(47076005)(1076003)(110136005)(316002)(44832011)(70206006)(6636002)(5660300002)(41300700001)(8936002)(426003)(70586007)(54906003)(4326008)(8676002)(40460700003)(36860700001)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:22:33.3494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf720ad-4a4c-47d0-bc5b-08dbc3d92124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

