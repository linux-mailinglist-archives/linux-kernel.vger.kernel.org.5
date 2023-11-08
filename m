Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4C7E4FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKHEfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHEfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:35:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1110D8;
        Tue,  7 Nov 2023 20:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+VoTy/eswgjAOf9XtPKWarZfm7BE/rbLYm08STDk3nQTLBsZITOLFYSnAcwC8OHztJBudZsM3AvPw6RtN1yxKsqeshTdLFNsmvNcZVtCVETVx3KJmURZetfIH2Vv39CXXxoOhxvYRtcWggBBUhVaw8PLbWJ1YevRC/xQe4SceUvxGJ8FL9lqCcdJTWSA1y0pCeM0NzUFkkYNeJbIVqUtOrBIZn9c+5uh4DQkazQexo0/fxSXHw7GTCi+EStmiZwzlN5vOsK+EUA+fdr2mWAtZkB8/sCc+cqS8fJhd4GF5++O81s2e0sYar5iSrYZ7t5s2ySfDH2V5Xc0hqkd4jiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/xgjunXoef3pOTDdh0n7n9K8gNec+bTVTVpxN72K54=;
 b=DqUUwPBPaOZiuVoFszBoLOYbg002sHiW9cJG6Tgl0dR66NbOIS4M54XF8zHiAG9gbjYtWIYtnVnrXASNjlpjnIZ2X298Bii/+Cl59wI3yjK4xIJlveTv49Q+k4GHMlvLdb2d0CG2iLT2+VGQgTvpdxayaJpGzSAAelERUi1Hz5G4heb4GBBd4CAk/av4oZf2JhPV7+xtaU51yZUqCf0FpSdxwjYHvEoBS+7N1vE1fJUX0++QjUq5zjc/qg7Jof9sU+8SgQSeUF8SQPpgEMlZajsqaBsRuyqXlRYkL3YS5m5wYCLe9dMFO/QDXfOC/bMn689BuxH4iJIiE6xyAJZuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/xgjunXoef3pOTDdh0n7n9K8gNec+bTVTVpxN72K54=;
 b=NB0jke29wpSBaWkkF6b5TeS76JfB4VAogHZuKFyAudtrgmV9MYn42zOTxG/Xrctxgp9J2GC/Nt3pl8SO7aINAiGqf8o+gI2FwIDb0LDZY1mt7n63dghrGIwlKd+fypXn9CBrgi4lIZFoqqVMA2n34Ynokwe8PFSaebh9M30bVhA=
Received: from DM5PR07CA0086.namprd07.prod.outlook.com (2603:10b6:4:ae::15) by
 CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 04:35:05 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::8c) by DM5PR07CA0086.outlook.office365.com
 (2603:10b6:4:ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 04:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:35:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:35:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:35:04 -0600
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 7 Nov 2023 22:35:02 -0600
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Date:   Wed, 8 Nov 2023 10:04:41 +0530
Message-ID: <20231108043441.2103940-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca68a76-203e-4d81-9c6d-08dbe01414b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk6l+vUdh5vGiekLHnQWfK1VaCPJW+KQpvUMB8GcQeuNi1GBKFRoCcgcmWll2mMOK7n4+5hmvbHjTEEeS4S3/37SxnO9jW85dKq13dgtMnaWIQOmasDbJeCCvWgVQeuSWRiGCQ3CKnTV90INiJ/TA+lH6b6JX2qc66JcwiY5HwhVqFMFi+XPucuzVzpqCLErZ+Mc2id3W5DJCvcDJxNVpf40BmAWRahmNq2MUv5HMrE583up6j4HYLvtf0X/ESpbx4iUtdd8JtQfBe2pvqaJfPkLoEnZ/e2iA5fiUynFg0kOZH3FNkiXQ2jiyoG4+K2PZeCwIdtUYja6oVKSAo/VNR0TNuh+MrwEF1pNSt0LzcYuMftcOql2xQmVFgIhtWdcI4On44qT58a8AiDeK7gIGHmQQ2dJQi7bveIW/ffNA5dexbI4So8fULuLcRck+o1nCrlN2zpP+aXpYWEbNoKunNpnBHuWqcHOEOGReZBC+2kmkRKlhEXTwY6u7Ag801Oub5a3jmF2tZIKS9klJWPHhGk9k6dYVIS3nNm6lYgmMwsaKVD9c7K2tHT/e6tERqpmvyVjl6LGJUcmfnnz1pKfFLDV4HP4MGzJvUoC4Nud6XJK7QrRorq9imZ3ZPqaCIrGnpcw/gE+TkfJ5L4w5tGM7tUR6ec2j79ZhZ7QTd0E4brGuguLImuXS9+jfdwqA1Ot6efyoaZZ5WGC9RMJAmDklUaXgsR3Hkknyvzc0mbc1qA6Jo8bq+s4Ksm5Uq0Dy0wXy45Zx3PIA2rPKeP6UhrrrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(336012)(2906002)(426003)(40460700003)(83380400001)(86362001)(36756003)(82740400003)(26005)(81166007)(356005)(40480700001)(36860700001)(6666004)(41300700001)(110136005)(8936002)(8676002)(4326008)(44832011)(478600001)(70586007)(70206006)(54906003)(316002)(1076003)(5660300002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:35:05.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca68a76-203e-4d81-9c6d-08dbe01414b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error handling for PM APIs in the dwc3_xlnx_probe function by
introducing devm_pm_runtime_enable and error label. Removed unnecessary
API pm_runtime_disable call in dwc3_xlnx_remove.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 5b7e92f476de..9cf26e9a1c3d 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -294,10 +294,15 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		goto err_pm_set_suspended;
+
 	pm_suspend_ignore_children(dev, false);
-	pm_runtime_get_sync(dev);
+	return pm_runtime_resume_and_get(dev);
 
-	return 0;
+err_pm_set_suspended:
+	pm_runtime_set_suspended(dev);
 
 err_clk_put:
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
@@ -315,7 +320,6 @@ static void dwc3_xlnx_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 	priv_data->num_clocks = 0;
 
-	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 }
-- 
2.25.1

