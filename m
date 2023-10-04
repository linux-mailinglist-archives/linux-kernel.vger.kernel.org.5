Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD07B7C78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbjJDJnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbjJDJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:43:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C629E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq+YGqOiXWKZR7qmK9CukXsGBTGNXIupqvx2Zp8wbHkTMM2HeLHwCIGiLoJCRQS4Jem4+pQmFNLH+NlW5Kr8kFcntYnavtyi/DgLF9ATvXbJYIYESa1WDQ/xYg0eoSQguCCUl8oKFr78Og8QFC1d2/KYhMkfADYq1ovdpnfvoGHLmev2vI84X5KtpA8bK8POSZUU+oFByL1P4eFPUoUqOV6S2mmCZPfBha5RtsiEF3KC3VdGF0JIi6VevXwDTJYB87PDS5IPhApn8weIzQ5BMqGr8u/Icp9E/uhaYhc9Xa2DfVGc2dtzvW2FT8HT1ubzTeaGTXmePsdtEzHxE1SNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvntDf7ACdTzxu4p0nJOztW/Udflc7A3Rx7vNR5xHlQ=;
 b=E+pap3F+zMpwff/90H+Q3uQcEvFzIGZcOX459Ke4SkM3zbxKUjfX41L+eA0khSLgvHeZfrL0aYdFMwUS9ZLcJwpNqq68jOIODPDdUaC9Rmcw6Mbf6YhuQJ2R+uzsWilbGUft3OZaEmecP3UMmde7MoNRSbDGHwv14t2cG/PgS7uUmM0U9omHTcc+aheyguxb6z9Dmy6KUrz4uIAyYg9cORuFKoR7+HXQQZ+rKEhEDQSHiInk10DyVUtISCBAbUBjvscLttTlNIfIgHEU0Frsb2uV3Y6qn+cM0XW2wuEDc1Wip9HYKoGulBrrZwiXIQ1JxhW0qk/eODGuRn3V9599ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvntDf7ACdTzxu4p0nJOztW/Udflc7A3Rx7vNR5xHlQ=;
 b=aGhmW3zKbQP0N1hfTJJxj0X72ufyJzWgdfflLC21aPI4fJR4knjGxfTmcafOEoUwPXIrGihL2NUsGAeXYluGNxEVJs5EASTvEnUh4XYEegEK9OJ1bLTXYEv4AwVYfYu6d2wS1hCpi0Otqr4mZbetX6AOlJYYOI5P+uCnhrRLSA8=
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 4 Oct
 2023 09:42:59 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::95) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 09:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 09:42:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:58 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:42:57 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 4/6] drivers: soc: xilinx: Fix error message on SGI registration failure
Date:   Wed, 4 Oct 2023 02:41:14 -0700
Message-ID: <20231004094116.27128-5-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2790bb-fdcc-4013-a721-08dbc4be4b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+4/w/S9BlDuwn18vPvoryOm83bWuWJ5fNxxKnONzoQ0Y+Vj8ybmIUtVjDvize6INoDB282J4sadpIXTpfTK2JUA3se/0BBiHYOhK3K65SDgnYWkQj4jbNtqD8qq/EmBMH+Aw5Fe9a91NEFhdqLKtUJ2BkfnVtO0rHani0e+11qgL7bzRPGlPPHyMsT0bphxGYIZKcX2xnOj7xegSFqoTeN9oCut5YewwW9qwDznE7WtKf5eo2AxBmwg+ELjPuHhab40B3F16fv/1Ne4qa8LADk5LDT+myg/djmEJQmwVSZkYJ2jOGRreQzb7OYpwmOmu8al3JBjBMJxKfGHGuR4vmSPnv2qTLuTzpYpLN2oFUlR4YecU8F78Rn5vWwOersVPHx1vDWFWkLF1rGTk0eTx/rxk4x4Qm0i6bUB5Da2tiuTbE2LTw17fzVGLrt/06+MvCNLNeEGtmXIOj/aKRbAmLHBkKCxz+nNQnkFLlsF3hAdYf2UWafzgxmNVdji7SQGm6LQj0eQUw94zpcMB6LrXiS2WlttGj499cuIKp6nVqaVuhEEJm6CDi2h96+JwH/P7chdzTEM3lJ89WnRjNv3JSjFmkp0/xOpAGlP+8XKHN9+tWbjYDK6S1NWitaLpz3ZMYwTcdJL+Bnp2HLam3kxLbiJRDaGqC+sUQYw3IdcQnJn7x8i6mDAwcl+g6kkHK/UMX/JjGufd+5eiK6cwwDXnMVFCWU8DASU3yGXw1B4CMUMc19WQfEHuTlkxYPr1sjvZimMVMltpUqpDfvLkRUqHkLJwrBnrdm+K8ej4LmNysE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(356005)(82740400003)(86362001)(921005)(36756003)(70586007)(81166007)(41300700001)(70206006)(40460700003)(8676002)(2906002)(40480700001)(8936002)(5660300002)(1076003)(110136005)(478600001)(83380400001)(44832011)(426003)(336012)(6666004)(316002)(15650500001)(4326008)(36860700001)(2616005)(54906003)(47076005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:42:58.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2790bb-fdcc-4013-a721-08dbc4be4b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure to register SGI for firmware event notification is non-fatal error
when feature is not supported by other modules such as Xen and TF-A. Add
_info level log message for such special case.

Also add XST_PM_INVALID_VERSION error code and map it to -EOPNOSUPP Linux
kernel error code. If feature is not supported or EEMI API version is
mismatch, firmware can return XST_PM_INVALID_VERSION = 4 or
XST_PM_NO_FEATURE = 19 error code.

Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 4 +++-
 drivers/soc/xilinx/xlnx_event_manager.c | 7 ++++++-
 include/linux/firmware/xlnx-zynqmp.h    | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 00ea2508f692..de09d77cf1e4 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -92,6 +92,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 		return 0;
 	case XST_PM_NO_FEATURE:
 		return -ENOTSUPP;
+	case XST_PM_INVALID_VERSION:
+		return -EOPNOTSUPP;
 	case XST_PM_NO_ACCESS:
 		return -EACCES;
 	case XST_PM_ABORT_SUSPEND:
@@ -379,7 +381,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 
 	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
 				  0, NULL);
-	if (!ret)
+	if (ret != -EOPNOTSUPP && !ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 38cfc161a713..bfa5cf4a0cab 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -653,7 +653,12 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 
 	ret = zynqmp_pm_register_sgi(sgi_num, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
+		if (ret == -EOPNOTSUPP)
+			dev_info(&pdev->dev, "PM firmware event notification not supported\n");
+		else
+			dev_err(&pdev->dev, "SGI %d registration failed, err %d\n",
+				sgi_num, ret);
+
 		xlnx_event_cleanup_sgi(pdev);
 		return ret;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 86fb73269d95..4afd5d63177e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -160,6 +160,7 @@ enum pm_api_id {
 /* PMU-FW return status codes */
 enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
+	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
-- 
2.25.1

