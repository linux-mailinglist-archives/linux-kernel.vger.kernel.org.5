Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1E7893E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjHZEwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjHZEwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:52:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6022137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyYK8dbXzbn1elcAs27XaXhlJWd2nPB/Bjt6SLeCo4ZkOuWD/f7HOBtx1tO/wBVUm2AMFnl0yU5IJ/ZOSlgjpXk6ATUiKbv6KppBuIVwPTa6XkXIYCgxrRtHnWzNB5300CcV2+D3DnMniBjDJN5Fh1H3RvwyDTE+xynLVzWlzniCo2TTx03WtUnCgZnXNtH/gLOakUi2RTM5EYf9zNIBCZ6+uUdRS3D6h5kxpsH9ltSL9W+5fe7OhfixeIYimli/yUyDmXQRzSJI5/lzhMAN/wx5Jq3UlMiUISNsW/DXejSt+JkWwNqIRW3OiLNQ0NN3OW4rLQ3q3xwoETe9r3UlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muSDNwkSAxPapbs3pBN3Ph6h07k35IArMK2169xjOPg=;
 b=XARQcyDHUYDqqYEe5j0hT1+OPY5bb6jeOnjMmjrsY29Lv92+PA3HZ9SZc5jmN/6rpa+y5Ce8daIpJMZQpmlAsFRGoYrTjNTdjwoR0DFXvYe73P7dhRqAF1cZxWemo9EDwOx50iU2gmb1bNT5Q73TH/pjwLqxwuT1A8+D0/SlhzlzXoWfArx8ug10Dgg03WSV9IxrqFbrMXyaWDFvIFbjDphLiRKaYprlbR9UbItGxKWCxtsWZqXzqw1bOWhAO0ntcTy08mDZAnp9q2ODyc2XZAKSGwpFXYbWUGRMWvHJ4FcjR6nw9J/ZRJ7Lie4cg2WHBB5eqxViandIZi28BD5I6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muSDNwkSAxPapbs3pBN3Ph6h07k35IArMK2169xjOPg=;
 b=imYYOXW/bR5HNgQbLrvHF32Tj185oBc9WU8bS9BWD5inxzqPmzdgVPfbeiqP9X1FQlwIHbgRiTIurE/nE7quZC391RjxyZwHOKSrvJAN8wKRWgCcrCtvtLqlx6N9IX5ZthJ/ShunyxU128PTvI71HKgKS8z9fyHcSbb7Wc2A6/k=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 04:52:09 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::39) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Sat, 26 Aug 2023 04:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Sat, 26 Aug 2023 04:52:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:52:07 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:52:05 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v4 2/5] cdx: Introduce lock to protect controller ops
Date:   Sat, 26 Aug 2023 10:19:41 +0530
Message-ID: <20230826044944.4161017-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
References: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c217d9-0d97-4d53-85ad-08dba5f03434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmmcdJACqhM+chJItBQJdYcdpf+7g6+75hTgsmgzYDwesqlKUXClGakKvziK/bDPBivBmmhkp782mcrxeGPdlkERSYI1V9ec6/IDqfav5Shn97BYi8qzDCqPm7pDLo3fkbPO4Jd8/Qtasoc1025RkEjEL/1iiW2d3tFfjwZZ7oNNcHc+OzETlAzaTco1XME87sj/ThfhF15dFv3W4s+uZnyo0tDkzwueu0/AlybUm4o5gzkI4Uq6Q0cAar//Fg5ZsKNL0GA5XqmTPT5oO6d4f/NsfylAG6Qqrjh76mKV6J/gdnLnZq0nqypFYveQqiWMJA4Sq82eVlAbTfTnh/9Xuh14nY/2Jazs96rVBD2NG1B5DcGQYn3eps1EDSFDpbk31gLZmxcODM8r8GW02xUMel5FMjsqOlNTJNgzdaaZovtY5c/u6+5/wBNzKnDJauLNoNSn1zuLxZbnvhrOOysSwccBtDrs1vapYESsJDzSnw9kGn472N92FsYYJaQSh+ivajUyYxCXeUwIkgAbXoT0MdjUL0hqnvXLK7FGX50tp3BkEHRFvnC86fkH8xco8qGnALT3q/DJN/mGESb8OjHwP2Cr0ZbMBqyvbHsU6xV3j42Yk+5daNg4N3JUPmnmIRnPQxL8myUiZHvK1uVwfTqL+sGP+fedt8J+/wqsE43w06gzpb8gdc2AFazQZgJIZwP2K+uHm0aQoaTNiMWh+P6yj2kxO3bTTrmcuDqa2mS4hj+4dEE/y7Osv90v8BYdecd4Y+aOtQp4l1vwGQrGsIyH2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(40480700001)(2616005)(1076003)(40460700003)(44832011)(5660300002)(86362001)(2906002)(4326008)(110136005)(36756003)(41300700001)(8676002)(8936002)(54906003)(70206006)(70586007)(316002)(82740400003)(81166007)(356005)(478600001)(83380400001)(36860700001)(47076005)(26005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:52:08.8554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c217d9-0d97-4d53-85ad-08dba5f03434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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

