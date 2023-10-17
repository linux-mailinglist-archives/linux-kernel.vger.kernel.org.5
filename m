Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4B7CC85E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbjJQQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjJQQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:06:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC20C95
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSa+eLnIMBvlYV//8oH0I4yI2wj8Stwcxunj8S6s+16p8zG1ZBjbT6y2JbSS6x/CBOp5USavdvS4ypIOX/lXQxMciwUoK6a4FW+PA3ytKgK06fKxlsmOxqDnJcxB7RwxZeF4MNLHX1Nzjf9PflGO+VAHS8FuQoMBT8AZPcBPUDaFT5CyPMYwaw1inQmD18+tNteaRTXmCsfCH5jKazJJiNpGYyY1qt/XAQ0Oan5u6Hnt/ICt4J9orxEaH0H48Mp4dTK3Fcc5AeEXi9j6a0Hqwk6fiu7bNJNuT/aDg7RS4RbkMKi6p/l9Nhmtnh4mEtBSF015rDWUF8A1xKg6i64vlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAbWS9qA4FErXhjbxf98yqdO1dKDkrqB/x9z3awYiGI=;
 b=Qc1h7zuOKDL3+3AN9wjfcvXok+/E6f6xeevnhsWID6pniA4NKtLl7xYZ26UW438DralXylMB6zpdxdRYEsurvBWKWZV0zFFHlCbhmXTt4ttHPw18VeCcTPcu6eWDLGbl9aEl7a9/YeccmMvRVxYXEn+YWVWCs6njhyc11/mP0hwZO3fzhxkd5iwBYY9imW0+TKkeFbfMr3Yyo+kavogA0NZgYcFEHWG9AbTT+j5FNnEiHSyQlKJLf7fCA4lOvgbwh6HaPpecUcNdCLL1ADpcVwrSEpFt0bFSMlMsDbiU+5+edJ9U8v8C2fqF5Q3/3QujAXzCjb7h+9k4TcJ8/Go9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAbWS9qA4FErXhjbxf98yqdO1dKDkrqB/x9z3awYiGI=;
 b=o1oIxokPSUy0JyL3Z0HVIhrgdq3YuV9BZmOLlNuO8l6J4ohWONxg5Zx8IdCMe4aw3vOrgLdsudwwt4+sTLJL8sl4kL8gty/h5oc5HdELdYxOAN3Be7iUP/oXPKVnKEx3iCRPWhlwWsyNNLizVoygWi0B+sGAUpzupkS4pPw6JCg=
Received: from CY5PR22CA0085.namprd22.prod.outlook.com (2603:10b6:930:65::10)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:06:46 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::f9) by CY5PR22CA0085.outlook.office365.com
 (2603:10b6:930:65::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 16:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 16:06:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:06:34 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:06:10 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v7 3/7] cdx: Create symbol namespaces for cdx subsystem
Date:   Tue, 17 Oct 2023 21:35:01 +0530
Message-ID: <20231017160505.10640-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017160505.10640-1-abhijit.gangurde@amd.com>
References: <20231017160505.10640-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efea302-b537-4a2d-6840-08dbcf2b0fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WwhRMGEp26Opt463j8m8yOfHnt5ayB/KQsn/yRqAgMxKUZOqlgpTVis8Ty/PPvxj49zCLjKkfVZ5n+VYum+kC2awvYZIAZtCiH9sf66cINplD+GqyEhZwTjW3IJDLdOhNyRMdIuyeT+XskeLQD5chxvWx9cILyDtWSQoCxgEmSVVuxSeCkYy2GY855BLAIld1UbmGCOdDf5nBr3oZ/Jp8W+LXYMOaHBfPjnkgmjtdTlTB3sUrgutpKRrd7HjsrpUZZ1Grrlr6NUUgEFgeMElyNI0T1fYr5JcYfDRmhIIPS/uJs9z1fxeelFW6sUtqRALy8zN3jF+dmLpwP3rrDKMG72baurzLrdCk+2YuGT2z5MKhUeoP+fEnOLE/6mwQkFEOwr2NJ7/NWQNX44/zfvUw3WIrWgpZzG6Bu285meygleT0FvtTWn0o9J+avbYovIZloe0BTsnHUZCSoatinWJ8RxhxS3E2obvo7e7TBTaI6/adsdNZbK2ugVolsBstUHqu3YAwd624G8peg2Ftg4awD28Y9/YP2Sxa3d9c4JHjjtNTH3ZUlBTm3jugsLJ/Y3xmy6l0TUA0EV0ByAqo3pZ1D86cQvfUkYsMZL8eXsuZd2UL2eSTC6Q+gvMXIt67cE//9qRXCj3+QpjpTobeXLeIsj+8lF93gnPM9OVJssVjFhw9ejrwShMQG61Bb6egSNW7Ty+LWhYTTri35VJ53l1jkKuFgpNVmxzotkhsfLhQ5+k1rQtYOzL4iKEqqm1JdDpnyLqM5QTrhA0wUh1q9DKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(316002)(40460700003)(70586007)(70206006)(54906003)(110136005)(2616005)(1076003)(426003)(336012)(26005)(47076005)(40480700001)(83380400001)(82740400003)(81166007)(356005)(86362001)(36860700001)(36756003)(478600001)(6666004)(2906002)(41300700001)(5660300002)(44832011)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:06:45.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efea302-b537-4a2d-6840-08dbcf2b0fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create CDX_BUS and CDX_BUS_CONTROLLER symbol namespace for cdx bus
subsystem. CDX controller modules are required to import symbols from
CDX_BUS_CONTROLLER namespace and other than controller modules to
import from CDX_BUS namespace.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v7:
 - New patch the the series

 drivers/cdx/Makefile                    | 2 ++
 drivers/cdx/cdx.c                       | 6 +++---
 drivers/cdx/controller/cdx_controller.c | 1 +
 drivers/vfio/cdx/main.c                 | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
index 0324e4914f6e..5d1ea482419f 100644
--- a/drivers/cdx/Makefile
+++ b/drivers/cdx/Makefile
@@ -5,4 +5,6 @@
 # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
 #
 
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CDX_BUS
+
 obj-$(CONFIG_CDX_BUS) += cdx.o controller/
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 75760388f5e7..ee0913f04758 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -530,7 +530,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cdx_device_add);
+EXPORT_SYMBOL_NS_GPL(cdx_device_add, CDX_BUS_CONTROLLER);
 
 int cdx_register_controller(struct cdx_controller *cdx)
 {
@@ -555,7 +555,7 @@ int cdx_register_controller(struct cdx_controller *cdx)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdx_register_controller);
+EXPORT_SYMBOL_NS_GPL(cdx_register_controller, CDX_BUS_CONTROLLER);
 
 void cdx_unregister_controller(struct cdx_controller *cdx)
 {
@@ -570,7 +570,7 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 
 	mutex_unlock(&cdx_controller_lock);
 }
-EXPORT_SYMBOL_GPL(cdx_unregister_controller);
+EXPORT_SYMBOL_NS_GPL(cdx_unregister_controller, CDX_BUS_CONTROLLER);
 
 static int __init cdx_bus_init(void)
 {
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index bb4ae7970e21..3f86663fbacf 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -229,3 +229,4 @@ module_exit(cdx_controller_exit);
 MODULE_AUTHOR("AMD Inc.");
 MODULE_DESCRIPTION("CDX controller for AMD devices");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CDX_BUS_CONTROLLER);
diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index de56686581ae..b3e482fa717b 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -231,3 +231,4 @@ module_driver(vfio_cdx_driver, cdx_driver_register, cdx_driver_unregister);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("VFIO for CDX devices - User Level meta-driver");
+MODULE_IMPORT_NS(CDX_BUS);
-- 
2.34.1

