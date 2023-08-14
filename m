Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDCF77B695
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjHNKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjHNKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:23:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18194
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh7aZT+NDAawa+quIUXGBHGTdW6dBpLUk6LlkV4aDS5Qub8d0GKrZbJeLhy2WjqNUlPluVqtxHuAYHiguki5C6iMdOhtuo/2B3SMOnfkPn2Ky+8snUjF37xlHf58e9IOc6auFr0fkl635f7K+q6u/HWg3HlOIDHV/L164GPg16ubDHQ9obRTfJp3+PEDasA8PAB2DHw2jxEizQ2jnVoS9SFunAWcB5lU04o6DbAHbopRUEwLiiL9mrmSZKQUTgRUpAcBSRMqa2Q+ha8qJP+hPlVMHQJdOxIEOhfWEI8EnYEDU1jeOQ1Lj6gtN91kNRuR1uAnVJ+5JKf5+4V+l7sh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlP9OlLsHCBCeyweJPg5LQk9F5b0AuE5VrX/1zL3Kzc=;
 b=mr0VkMRbdU4zYvU0wx0gU6sWzYCNlIbxG86XXwiXrCmo96uPVAAx2YssZ8m/qVJyzFSZyJU7jC9zYZXNx4N+Lm+QZ7nktdIlULItoMrGJ9BWr3LyeGtA4LgNbcER01KjLXwWBqRWSDlRcz+xiJMy+fv2aZySAJKhDiyBAe4q80dO0xZEFHlbZv90HzwMfJOG4AvVy1S821bEsZHdDW1yjLLR6X4vA9dQZc3duFC/m93GvskqHqB5qq993qG4ypxTUgaQSdpG4fInaIEulbuO63uiGZDugxBPeOfuesod/vEn+3uzU19xksSBTXrOiOQtW7CC9z5yAno+sA9MMmfNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlP9OlLsHCBCeyweJPg5LQk9F5b0AuE5VrX/1zL3Kzc=;
 b=egHbsYA2LbyFsumZ1yh5qUHyEBW4dkMzbATE76wgXF5tqI5OckomgT4fpXKRKDiF5azQxxyGpUxjSFsZMZWfccBRJy5SSWARdF1XrExwH38Vfhsxc3Oomek8x2OMh3ye1rnyoRHH/DSRRu/l0TigLIONtCot2el+EIE6A5IPyPY=
Received: from SA9PR13CA0122.namprd13.prod.outlook.com (2603:10b6:806:27::7)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 10:23:44 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::7d) by SA9PR13CA0122.outlook.office365.com
 (2603:10b6:806:27::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Mon, 14 Aug 2023 10:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 10:23:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:23:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 05:23:07 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 05:23:05 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v3 2/5] cdx: Introduce lock to protect controller ops
Date:   Mon, 14 Aug 2023 15:52:20 +0530
Message-ID: <20230814102223.418046-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814102223.418046-1-abhijit.gangurde@amd.com>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dd624e-37b8-49f2-b977-08db9cb089cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pQE2N2Bu3JGZGI59u6Bwa21zY+uPNrA/OXfwQGBmWaln3ja4HOcjoujKn3K5NBzLSMfLWx9799CgKo4AXgCSAm+H5cxFk6A8hOHvsYExYZdMRYikF8zfMH0i5OvZgpHaAR34Z3UlIV1wSLZNWAfI2gTmv1W/JGpsuqTWsKt/jO+N62AU+TchjYlUr3QvkYE2kOQjoT2T5hTBAtNO6o/8ONpmC3QJutZJm8xrGORGx2iPnE8NcYuZUoVT3HK2j1/uEMA+A86EK15bGJ+VPEPqw0dxzTJzsQrsj6qti+ap/BltIR9Ask5FY77g0JKFNshTgKsYDmECXGjCBTsDVd7tMu/PfcBD6NzcQG31ysqbkfiG6vwFNAmVBRfBP2/Tq/XmiNxvhSQHVTStl4W9tXUXJAaYnCPZPTi9i7qhgBnAcxObZSxG0NeT5V0uLDwX6xRg6mKDoAfDkhd0JCCOvhoqegLn0Z4BXyP7KY6yTlBaENT31Z235agKq3kPAnvE5fibejPY5wqsYnalLmUNU3UEaX9brawVdNzYCjwo01LE+2UNIDJdA4Zn0EI3ClYZ33OmF/8p+wXLip43nDQafLbKP3UAiV4W0Iw6ThZGNG2ucjc3xnrhukCgkTiYWeAnYCJgMfHamJFnSGSPWXho0SVQRNo8i6yRacy58sBJFGCcDDWIk+kSlMS690h+vq0phMyXxHQNdxzR84X0xEaog+hvXlLrOyEUDwSIKaYHkaGEcn4c5+Ise2sN+ZRaKQ5u88W6VU15u88KocnXJl3Id4mHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(186006)(451199021)(1800799006)(82310400008)(40470700004)(46966006)(36840700001)(70206006)(70586007)(316002)(41300700001)(110136005)(54906003)(8936002)(8676002)(5660300002)(478600001)(6666004)(2906002)(44832011)(1076003)(336012)(83380400001)(426003)(26005)(2616005)(36860700001)(47076005)(4326008)(356005)(81166007)(40480700001)(82740400003)(86362001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:23:44.2570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dd624e-37b8-49f2-b977-08db9cb089cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mutex lock to prevent race between controller ops initiated by
the bus subsystem and the controller registration/unregistration.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/cdx/cdx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 1c0f76cf4f15..50df061f4537 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -72,6 +72,8 @@
 
 /* IDA for CDX controllers registered with the CDX bus */
 DEFINE_IDA(cdx_controller_ida);
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

