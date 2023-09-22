Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1564D7AAF53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjIVKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIVKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:19:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E3FCE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpJc/cs/yt1nKBP+ASqPFXllAwd4yqwHS3PmFOZjddKgQl+Tl+l6sQoz1ccOB/57+G19k9RBMkcpPJxRQ80CiUHEF09nLOY37MltKmWbwmrLAe2U1wQitlqjFJ2AVV+Esqmjt8kHmlsyBTyZbVuJ7aCC+0g2uk/i9Id7JCyCIkrI4fhXcpCpPCsyrJaZlPakfkirLiJcJPj2Y2U5APx6Oh4k1+KVJ3mLQbcWaeO4P3Cyia2CVWf4LfiDhACafffE4aWVrMOtkERJGRly1Zt+AfMicMcMObC2xfs9+FdW46nFTaIxm4RAzVsXoDAAa4s/595Q9VDPu4HaOl0x2XGqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q/D77p0kW3SSDSblvUbq2OHyAFy2bw5w4VcmUPnsqc=;
 b=DoyNTjdno8U7T+f84aG6gDvtszyL1Ti5blfyop4DEvp6itPp/mWIzxZZ/CqvdEvJWBfDoDppZEQI+eUTDg9E+oPM1USWZHeoZCqu+uh0kjZq6HZSg/5zv8+Li8YghML1wB1NQQ/AMfiOO7Gvxp5bgS2mrZq8wKz4JtnY9D8rp86uvFlg2sWzd9r8dGuQQGJuVX13OKEAYEVSnmXIg3DdMiejMwT6tijTh+1iMR/Td1tPtaWQvpGCH27J4iRojHr1pmXtrWJjaLdlm/GVeOQ4rFxd4sLY9tPhNbopf9ze/75CMrdubMfa55q/oMjxufz6v5xXrhmwc/A4eHc3sSyTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q/D77p0kW3SSDSblvUbq2OHyAFy2bw5w4VcmUPnsqc=;
 b=GjfQfRo4gvZ+YCOSZof9uULOWr7XPFZacgOpyZgcAMVnYI4GCT3nXfF2iMZO95sKpaUVUJBj6l6+TZxyLy+9mYvIX+edvKPAuXWTPelVCbfEE20WcpxnKy/uUYIW+QaEgF2LxZw6WU32HU4HAd7St9JEaHnDmF3uehP/sqYKnNw=
Received: from CYXPR02CA0066.namprd02.prod.outlook.com (2603:10b6:930:cd::12)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 10:19:42 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::fd) by CYXPR02CA0066.outlook.office365.com
 (2603:10b6:930:cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:19:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:19:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:19:22 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 22 Sep 2023 05:19:20 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v5 2/5] cdx: Introduce lock to protect controller ops
Date:   Fri, 22 Sep 2023 15:48:25 +0530
Message-ID: <20230922101828.33456-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922101828.33456-1-abhijit.gangurde@amd.com>
References: <20230922101828.33456-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CO6PR12MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f9d21a-2b1a-44f0-6658-08dbbb556fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYV3Ot2bWAf/T0w02S97ayZPJQKEK/syAyN91JdL1XMBTeeaz6rdwf6JG2hp5rlkC1+Yp4Jo4m8eR5yTNzf7FR7LkZbYOftCaD7SFZEBD7cavHRXrGSWIGNMcnp4IpddDUqvWFqTvP0VapS/vkNaUHPUHPmvjYZoAv5y7hmEdkkkRjAemd0Git/r5gVgoMaDsFyTkvgKbLj7gSHrKJT7PGsDganimdrfYF2UaAx9VpWKsBeaVdQt0qDdltjs0hUFv6wYNXUBkKY7qH1touP8z88VZB9MoXTiqO/vohzjbiEefuXTgVOPnNaXE+GvZ84DCi5QezZuO4FkWM437bXKXVP/BYEyQE+EWe4JpNDaAo6gXy1+ZklTENHNwDCT2jIZNC5di5h6CSTGRVKIcN8R+CJ/5bF8VJo/D/+kcyWw/80jzwO+mGj9i8XAeIjg2E8D9p+Bnd9MaLk//X1Cx0lm3bq9uykWDhQMxqL0EtaU3iZ87AFpDHHBJUbAT6SFafYt0GStJbJ99CqzIJFW1lozXWMyCZPFUA+eKCepFrcbn+4YHXE8PW7tTWuAZTBvIRMvZa/4ns0AfS+KzrY1Tm/waILp60fRVvyT42d6wQpJJkv4+GJW0WVdXn3y4oAU2sXOhauCdIB8gP1547WIoiJ1EdI57eOrmIH5QBPTPaAsZn6ZJHiG8ljaUZqPwAMvPOOQUFPSzYGG8gOU9CHLNSleiVJHgtrjBptw9xsrH505EZW4q+WPO2WlEYQh9Fjmb7TSTue3jQQhK0dkGRAwgpZCVXsRh7m97fkgoPp1czQBMf1dmJRu4hhXmHEWo3EvomlT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(230921699003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(336012)(81166007)(36756003)(82740400003)(83380400001)(356005)(86362001)(47076005)(36860700001)(2616005)(426003)(26005)(40480700001)(1076003)(110136005)(54906003)(70586007)(316002)(41300700001)(70206006)(2906002)(44832011)(5660300002)(8936002)(4326008)(8676002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:19:42.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f9d21a-2b1a-44f0-6658-08dbbb556fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mutex lock to prevent race between controller ops initiated by
the bus subsystem and the controller registration/unregistration.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v5:
 - None

 Changes in v4:
 - None

 Changes in v3:
 - None

 Changes in v2:
 - New patch in the series
 - Introduce new lock

 drivers/cdx/cdx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 600482694161..cbfe9a2f3646 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -72,6 +72,8 @@
 
 /* IDA for CDX controllers registered with the CDX bus */
 static DEFINE_IDA(cdx_controller_ida);
+/* Lock to protect controller ops */
+static DEFINE_MUTEX(cdx_controller_lock);
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
@@ -396,6 +398,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	if (!val)
 		return -EINVAL;
 
+	mutex_lock(&cdx_controller_lock);
+
 	/* Unregister all the devices on the bus */
 	cdx_unregister_devices(&cdx_bus_type);
 
@@ -415,6 +419,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 		put_device(&pd->dev);
 	}
 
+	mutex_unlock(&cdx_controller_lock);
+
 	return count;
 }
 static BUS_ATTR_WO(rescan);
@@ -538,11 +544,13 @@ int cdx_register_controller(struct cdx_controller *cdx)
 		return ret;
 	}
 
+	mutex_lock(&cdx_controller_lock);
 	cdx->id = ret;
 
 	/* Scan all the devices */
 	cdx->ops->scan(cdx);
 	cdx->controller_registered = true;
+	mutex_unlock(&cdx_controller_lock);
 
 	return 0;
 }
@@ -553,9 +561,13 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 	if (cdx->id >= MAX_CDX_CONTROLLERS)
 		return;
 
+	mutex_lock(&cdx_controller_lock);
+
 	cdx->controller_registered = false;
 	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
 	ida_free(&cdx_controller_ida, cdx->id);
+
+	mutex_unlock(&cdx_controller_lock);
 }
 EXPORT_SYMBOL_GPL(cdx_unregister_controller);
 
-- 
2.25.1

