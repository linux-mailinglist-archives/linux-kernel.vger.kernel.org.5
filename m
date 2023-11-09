Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89637E6A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjKIMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:07:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1262699;
        Thu,  9 Nov 2023 04:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWfEEotU5lNQZ/KrWfi9PPkcvnXqGzvJI4cvVTdxBqIUz9eYJA7KsGTyhkKb9hcupUHJ+3jhharec6q3fS6nUfSf/4FcJ/TlMVD5N8TIR3vW5Qa/OzN0orSU/VrQ36HWn7CDn4Tql+6LENjZTli8kkEfBBz3lszGrRyPapMeMnCnsAlTmDT4jO1FK6W7WXXSveS4gmyQVC4X6bBT9swttYfZylypmuHhJKiS07kCLFb/Df/PVgQD2IYDLzassiM9Bp9FrR8LJ5h/AQceUf08Y3HjvIcl0Rl5P2pGD1hMqcff4SR0lpyGcfMnP+LtFB19OUZdcS9PiQtaOzzqoa0C3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0si0XF/0Y7YucdFXCNg3Xr799yC2PhchuwuP9wxUP8=;
 b=jZdYUpR4T2vGiLFRdE1HSmw9KIlnSF/3zm96AM2DN0xMC9DbNlJMbIGp2tBtDBDuVQN3c4SFNESDTvrY731RizMvPIV8li5na9IAGrug26Htod3soyOMTWUZz71slDewpfzcXlXM8dmaqP9cZbeOePzPGgcfFkOIfh4Yrvr+OPaHiP6FXf93biKSx64XegNUVCKxzkQZW/fnzDLa63hnYQoI6Dc3aMuxNdDL2vUtf7W/AaMakaFweUfg1Gz9ViQ3wLSrqXbx/+oAWJCWst4vctNoLVWfXXhNNJeo73/hgINWSyugvB7McYCphCUBjHl8NmLdB1VjA/aOPDAheLsY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0si0XF/0Y7YucdFXCNg3Xr799yC2PhchuwuP9wxUP8=;
 b=psrVNNaZKn7n+mWXdbo1J74c+yq665drNXIHVk7WUec9IKkLnOem9UUIerSY5+vN1hM8YF4dySbtnff+nZ7iGP3q+MLej6J4lx/r7PMSqGSQCxHsIaRJPFhFI9gmqW525SRxnZ2sEN0gQdoB5H3v+LZdmJXtyCidjBkNtg7bFDo=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 12:07:11 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::a4) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 12:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 12:07:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 06:07:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 06:07:07 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 06:07:07 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>, <olof@lixom.net>,
        <shubhrajyoti.datta@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND v2 1/2] drivers: clk: zynqmp: calculate closest mux rate
Date:   Thu, 9 Nov 2023 04:05:55 -0800
Message-ID: <20231109120556.29348-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109120556.29348-1-jay.buddhabhatti@amd.com>
References: <20231109120556.29348-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 7461615a-baa5-4fba-5095-08dbe11c67a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTkoG8BGzWeEilOOXj9BIouGV3/ZRmJYJXsdqP7vJWzKPkF+ugfI9Igz1W09CpqaOQwkXSAjEZC4WtmPcAynQnq2EYmgkzQoJQ+lQfZoSFDlfodj9E+5UAAeLEpfiP3eSo8X5x+vYUhDYwsRPFvXqDoya1qMCcBi/SQmj1pjn3zCU3jRRupz4yBg8GvJM8JzZEgbjqEv/wtYXsVEmDJvdz0brlekYKsfFteOGWuSywPr4HwGcS/tfvM3U3/GlDFQAlR97jNW+fSPsqtZWPAImd7pg+sv5fkgH1C1+ejp/dBuCExDAUW15AQO5lP23UTsCVl3DrTxVwMMHbMfEHz34c/jyxAE4I6KjLuDiXnAMCHDPdftqD89XDr9sbUqMY+hnk6UAfaVhwAZIWIv4uiUQddIwBtHiNbMf1LQzjg12sy7N1LamjWhS1HyRNUqWaH9lqpyePHgz/HdtL2lZPpwy+/HlMzKkPoci9rvbEOp/Aoxo7MCmuqeBB0oqBxK3BaA3vDJupWsf+2dmUOTSjlgPvgodP/0Uv8HjUrEtk3VtJj7zj4cbu1nRmA6jt0zEHtpdbt9qttR2PWIEbO8QSYDvM43qvwHRoTvIfBe3f357Z0mC70KEjpHkmRZKY/Oi89ugnNtHEQI7ELhJiCuRsyhZiX947oPRkdrSrVs3hPPxWlHUzdScvue203g9hZNFTqhA8DqteeYYTEcdNv98C+YXISV+YjPgZrc5fWuz3O0pUjOXdw5VIxVQYI4AedgqPGih+let8eVhkZPi89rxwKZNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(40480700001)(6666004)(41300700001)(5660300002)(44832011)(4326008)(8676002)(8936002)(36860700001)(70586007)(2906002)(2616005)(426003)(316002)(54906003)(83380400001)(26005)(70206006)(110136005)(1076003)(478600001)(47076005)(86362001)(336012)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:07:11.6431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7461615a-baa5-4fba-5095-08dbe11c67a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

