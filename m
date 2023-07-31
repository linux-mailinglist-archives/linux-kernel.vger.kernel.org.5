Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4EC7695A8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGaMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjGaMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:09:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3810DF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaTQKByOCoTQNXQKyuhQQkCHHgJkfAUgz9fCm1lDUxi5xVnQRIw52MlpIsFVWSJFXDlnk76WGbX2MuYQ/003rB6PdZproJ/WoRh13nXeRqKINTqBH1heC/bXHeTmzwZcA9cVhJ/+a4vMH38id4+d/jYNkVXRsQSN7fa4awaIbAoqyuArJRIHwQkKJvmHLU9sfI057tgcTz86Hldd8Xz8qJUmFMc8L3OUjzJ9YmmjpkTjHs+eKo43LVo+7mQ/cW/HGuKYKVpctElZGZeeunHnR8itjQ+Se1akydiCJVmZhMEHRJEcInChk9lrzXX2eGJPMTZTCUE1h6UH6VPOmZzksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmH86kURiAr73ayzl6xvzV7Foce/Dj8VeQupccytOfs=;
 b=dlpQctIoMJu+f/NXOGdP0kE70ETgB5fVzXgc9XTacxjF5nJPIfDvJd5HdtRV+eGIxDCoIAGLzI9qG+i6r/9hFgIU9AAMWp0SEtB5Lw5QCSwr0Pm4D/Wv51pglEiHEusbRypE6XuGZLeEqjHwHevWN8tnsoa0xWoJsBxChTAsH+BHiW0xJrRrTbgla2wUiQMPHeVqrGfefBotNcdZ9tEAbtXLOIbyw/kogIkUoVitMVln2mlLyq/KzQP3BC5AtAti6HATfHgIYtYq4VOTnj9ZoQHEgAHHy9AOkEnBSdSzwtzRBONYIreD/ez5Uq5ZOH1/vk2W24NeZpCDMXgoj4NfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmH86kURiAr73ayzl6xvzV7Foce/Dj8VeQupccytOfs=;
 b=HPfRjBZtpo36Kbq1xnRHjt9npem6Blmwx5Y3H8FAJ8+AqXyw7EXmDbbcvDDcFa9sk8RBD8NSHvk5Fop6Ap92IeJSyotUdW0OPVziT8ruDviwBxUeULUP196zKOF+jYSJ71wL7HGcv+SR0N0a0wMjESU2ajfmEhJS6k2vSWK5Fk4=
Received: from BY3PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:39a::24)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 12:09:48 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ec) by BY3PR03CA0019.outlook.office365.com
 (2603:10b6:a03:39a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 12:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:09:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:09:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 05:09:45 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 31 Jul 2023 07:09:43 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <michal.simek@amd.com>, <git@amd.com>, <nikhil.agarwal@amd.com>,
        <Nipun.Gupta@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v2 1/4] cdx: Introduce lock to protect controller ops and controller list
Date:   Mon, 31 Jul 2023 17:38:10 +0530
Message-ID: <20230731120813.123247-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731120813.123247-1-abhijit.gangurde@amd.com>
References: <20230731120813.123247-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d123fe-46d8-4961-bfeb-08db91bf0894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aiy8/Bs7MSXcugfgSks90kNl/IgYYItOVoE2mei3k91s4wtbNeMR+2q6rUzjK751C3qdewrpb2ey+M0J6S3g0D+x4gk1Kd1ukt+TB+miVC+KJNm6EUMn9Khdt7pbWt0jYCN60nlcPS2YaUPWDZV75A0w8NFabzKe6Z85zO2kNC3AAp6ifJtfkLcjQu7CD572DqD/VyuOVIY6slFLqiLjGSDGcRwEonE+Utd8I19kbpjbvAIMJq7wP0QrVXlxUBKeAaBY3Ersd6OJ9xvM3XplOVHm0fu8MW7ZiHupHG9ZwMpGEH3UqElRIQcpNZ3rGsqZDmaZ2gKooSw84rmikdcNDmpRQhKaWrept195JwiFwMUIsiqig1lYz+HNu1KeOBQ5qLTYIxK3MFXwo//Gf8sSgIyou5+5VcRnG9t6DZZOdgj/DYNPGIcRjdfAupn4RPSu2fU0raYqCclkK0Bq4Oxuv5H5tdwnVHAzf0sgMYf6uQhHs42DRbzbkKHofVR1ImudK9Y8E4Rse+2Wg0sRB14JGPRdTHrsApsJZ2eTu70MKV6J980mC7xXcD3C17qyA3uXOpUnlxGsuqBnZkGEq7z9zQp2yhEToL5ZB6sJVQQ608hx1fgMo24Y6VIo3ahiwt64E8ryFfZ1/CercnXgcdxa2kh/laZS4n8HWvgIJIlqI53Vbl02Z65iVe5j+18mo+9oete81WPhb/k771Kf1JNBu9Z9z78d/foZzSpcGPpIoy3yfIjNxahE9oQn5XRK5Rau371wxpqX9Cm9gAjufpMlnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(5660300002)(2616005)(426003)(8936002)(1076003)(8676002)(186003)(336012)(36860700001)(26005)(44832011)(47076005)(83380400001)(316002)(478600001)(70586007)(70206006)(4326008)(54906003)(110136005)(6666004)(41300700001)(86362001)(40480700001)(40460700003)(36756003)(2906002)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:09:47.0085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d123fe-46d8-4961-bfeb-08db91bf0894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mutex lock to prevent race between controller ops initiated by
the bus subsystem and the controller registration/unregistration.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/cdx/cdx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d2cad4c670a0..66797c8fe400 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -72,6 +72,8 @@
 
 /* CDX controllers registered with the CDX bus */
 static DEFINE_XARRAY_ALLOC(cdx_controllers);
+/* Lock to protect controller ops and controller list */
+static DEFINE_MUTEX(cdx_controller_lock);
 
 /**
  * cdx_dev_reset - Reset a CDX device
@@ -393,6 +395,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	if (!val)
 		return -EINVAL;
 
+	mutex_lock(&cdx_controller_lock);
+
 	/* Unregister all the devices on the bus */
 	cdx_unregister_devices(&cdx_bus_type);
 
@@ -405,6 +409,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 			dev_err(cdx->dev, "cdx bus scanning failed\n");
 	}
 
+	mutex_unlock(&cdx_controller_lock);
+
 	return count;
 }
 static BUS_ATTR_WO(rescan);
@@ -520,9 +526,12 @@ int cdx_register_controller(struct cdx_controller *cdx)
 {
 	int ret;
 
+	mutex_lock(&cdx_controller_lock);
+
 	ret = xa_alloc(&cdx_controllers, &cdx->id, cdx,
 		       XA_LIMIT(0, MAX_CDX_CONTROLLERS - 1), GFP_KERNEL);
 	if (ret) {
+		mutex_unlock(&cdx_controller_lock);
 		dev_err(cdx->dev,
 			"No free index available. Maximum controllers already registered\n");
 		cdx->id = (u8)MAX_CDX_CONTROLLERS;
@@ -531,6 +540,7 @@ int cdx_register_controller(struct cdx_controller *cdx)
 
 	/* Scan all the devices */
 	cdx->ops->scan(cdx);
+	mutex_unlock(&cdx_controller_lock);
 
 	return 0;
 }
@@ -541,8 +551,12 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 	if (cdx->id >= MAX_CDX_CONTROLLERS)
 		return;
 
+	mutex_lock(&cdx_controller_lock);
+
 	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
 	xa_erase(&cdx_controllers, cdx->id);
+
+	mutex_unlock(&cdx_controller_lock);
 }
 EXPORT_SYMBOL_GPL(cdx_unregister_controller);
 
-- 
2.25.1

