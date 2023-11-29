Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578C57FD5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjK2L3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjK2L3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:29:31 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BC95;
        Wed, 29 Nov 2023 03:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzz/Q23GlPN1Qk46nyTgRkmgLQevUBkEduJAovBfqUm9UHtyL2XDFngqwNLV6j3eciRh9aCrwVGy9sXTxwgKkEUiZ5/5E4ZcuUeiPwEVmlPZ2INesk1vOzTR9m93qJHohKKPv39jfijS7ScBXgoPz7XeCHIWmv8N5y/BSjPIcLGWmDhaYl0aMwGLLBZW+4jiFlAteiDmpJX+Gp5abVIQN8BibklmKigdWkbpXjgIG6hV7A8hIHvQWwFuss3dwxkAn2pbyVr6XVB9bv5jEtwtYLjS9r2W25lxNPsIuk5L2TA0T0nOlIPSHSXQQUUC0L0MRgFYNG7GVC9FwALikuxc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0si0XF/0Y7YucdFXCNg3Xr799yC2PhchuwuP9wxUP8=;
 b=oNvyxSYhWMMTWUgWnMc3uQCRa+44vva3X3jYoxSUFoPknBykc/DVjpfbtovnF1jaqvakIPOwdjha7oymTRpas4FXqDtxNQ/eMRnZHaM3bij5ttTjnP6WfGQuH0s6XysmbrxBlWxBvmVfpFw3aaRgZ5mBRHYzKTgP+AwRY8rXpvwmWU3+yee0Avq4cpn6OZeaEIIeT/J2ko/q39A3kbHHxcSFZPN/cBNcXemSHE9Nx+NztWWN9wtA1+zXCUj/8OoYbCCAmXKv9CERdL6VvjIq/qFUJJ1OmhOX2rWEPXgIQFiGGqPVvnBpNs2XVtQK/zaKubjXq40oItysOpiygsRQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0si0XF/0Y7YucdFXCNg3Xr799yC2PhchuwuP9wxUP8=;
 b=M/qlEzecSe1jV5jQPl5TLsIQMmvJ3hpOI2A41cISufdlwdNDESanNsDu9fJnUTDeP/Bbz2VJESMc/vGUuz28WBVJ3p51J8mmv7NpLrSynyKef6ob2F//QI56x8euWD1dtECxM3Ode5vIFoKIpkn5S1eMiTn5B56uD2j3wP3NmGM=
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 11:29:35 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::90) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 11:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:29:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:29:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 29 Nov
 2023 03:29:34 -0800
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:29:33 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND v2 1/2] drivers: clk: zynqmp: calculate closest mux rate
Date:   Wed, 29 Nov 2023 03:29:15 -0800
Message-ID: <20231129112916.23125-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112916.23125-1-jay.buddhabhatti@amd.com>
References: <20231129112916.23125-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 075c65b6-6cbf-486d-2730-08dbf0ce7702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSIGPEHTgTOicO0Nu5z7PiMnieHpy6ngIQfarbpBMqlTAtllLEfyHqUD9NU+Q8l7aTWKVp5YQfzs5OWsOQrLXHh1BGb8rlnARwRlRjjSoeCZDkrRfcFJ7UxBEBSV9kxKy1eDtp8vmlD7zxxDtX+NUuyZ6ink1n/zeOAQsHlR/7BraItwjv39hvAfJhXhSfYYCfuQeluz5ESMlYN6awkNUC0kr7gBZzr0kZWOXbIdAHYahBzqRyC3+MTtApYG51Tml04r9QNPQkBdq+MTEhR/wlrwAnJNNJSsimwI4h/LIaaYirWg4s/LwuMrxhHPacJU9Wjv6Y+rzubB0NCU06+5tNtS23w8UmMb8ktRrzGz64al+PT1pmqVQ/LSkRExnA4hRA+lqntwPpLPajnF39ZVltdhc0kDJ5gayQZqjpgnem5sec9nIVK++g90ufZsa1OtSLLKT1gGZblslnjaq7Yx7E8/WtgMN/Dn6nETF/h7a6z8GG7KCVQxIZu8bQHzES4sFBoeKranD9ca9muCEg89Vgspwh/ANCRXC6gSkgvXVFjrnhNbqVGgxNs3UdhlcxcwnX9u51hJK3nv4Djpj5XrHf+hfXsgU5glCaqUDz8y14XqC5IpUprV3dYSVkKTKys06r8MzhJqHZ+pdBh7w/fYF/FzrpisiJWQ+Dc8N82FNmPz4RCFl/Mly2xSLrqEqTUx+VOxww+AJcibtE63eHJcXjeQvLRrNv2YlYbgZ6y32kTcvnVBPLQXNR2sAe5//JQHo2Y9k3psp7d88nSz1U6/Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(356005)(82740400003)(336012)(478600001)(4326008)(8676002)(2616005)(36756003)(8936002)(86362001)(110136005)(316002)(54906003)(70206006)(41300700001)(1076003)(26005)(70586007)(47076005)(426003)(83380400001)(6666004)(36860700001)(44832011)(2906002)(5660300002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:29:35.3147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075c65b6-6cbf-486d-2730-08dbf0ce7702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

