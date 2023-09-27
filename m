Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD27B0925
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjI0PqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjI0PqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0F272AD;
        Wed, 27 Sep 2023 08:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcrTrp6zDURMpMXtlm7Q0UcgXeYIVWIV+aViBCV1ov1CoRUWbSo0XUr4cAi8iSu7vHpYfXsVrXrMb5gz4/RWvD/s7Zb50oN8qazHkNyUl5m7rA/IhZd8zItTpQCI+nazhxLSZwiE9RDVSZlbYLr/W6Ha3xjxk7nryphuctEA1IquB89uhcuBOCOispTIEcYoSnhB8PypwUdfAzEqogn/EPAS5AjTS91AjjOYgut3UfqeEfOQ7B/xdMvuChmqE7RRv3ksQRCUp+wAyfKXQPBM9xm3asXen7Vl8arIvrHTbazwQBhtE0/vemDnSoN/xPb66M0LYHdFLTQ64XotABiwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBMceFec8YZBJHLPsV6Q3KcXAOfrDOdWTEGL1vH5YQI=;
 b=TYzYTuMbTbB/Mqd7sDh9+XAZCr8+Lvcq6doAObEaymM5iLmdhT1j8Xi2RhOgCnuTFPj8lN8ICrl320f+F2Kmu8cFdey5S/r9wRyysYkAvkjG/ZYYZ2Vsyt+lUTIJ/0cVDOfgYxwlL5TQN7mAHmP1hYNNhK/K8UOQwZh66IYYlp6VoQzxyoiSrA7NYr4rpowcyunTizJlw8+J2WaPwwu5e30HF8z+EAs548PVv4zTub68uKfYvgYs1xEyQhS/HGSMTmg4chvQVG/gd+2pao31SP3OPWxszOKIECegAJjsnYKCPSEEayxf2Xu9xMojKS1ZrblNnFV08DXX/cQjZD44sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBMceFec8YZBJHLPsV6Q3KcXAOfrDOdWTEGL1vH5YQI=;
 b=0HHOO7v6/owj56G+4L2V7qH9ftOwRSUbCW0yTWdXpKziMLp6lcxWz0EzBFtfAORRVLRtjoSCc7/tbDoifWN5XEIE1yIQD7bht8E1sDJqrni97GgAGU5mmZacThmmVjj3i9wXpMZY3VwqBljPA1q0Iqr7r8GknjMkU3sdLW0nZ6g=
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 15:46:05 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::d5) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:02 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:45:09 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v11 01/20] cxl/port: Fix release of RCD endpoints
Date:   Wed, 27 Sep 2023 17:43:20 +0200
Message-ID: <20230927154339.1600738-2-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230927154339.1600738-1-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb872f0-0be9-43c8-8b02-08dbbf70daaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vuG9X0nOKJ/s3BfHSatb9De0FM1ktSA32/QiFZ3hZ/ovtnVUMqDsGcxwankl2Kn2fQ1B+d6HL9vnJZKAonRf14KzthhtZGGbTViCqtqGviru7dZHSjjuGq2TCKZjxmYSOFXehc7faXze51gSEiPgSRZfzH6QhfJeQdutAd268jq+3ugpfwtKfnkOLijiMsnJo03TYANuQl02pE9a6uAOrC5FoX1NM8pDMniByCw63I5ZxhGe8wkjyzdlYVIOm88cEnWEUwQ44j7m2uryXgL5UuFm4t6+D/u+oZPEd8omuuA/upPNisKmTEZDp+bu8jPMoPiCPqvG/A0Z5Ie3ZwGYt8GZZgUuehwrxNIKqjCQ5itrAWIL+KhR4sCeMlOhuVIK9w9bmA5ySIvohTOqJHFnDn7jTFwAXwiJ5A0gycPsNkEBS6Gu9Rxb0Ze4tE6Nd0sPX8NOKeb9DpmU8oqO0JoOXaYJ7dWznAH49aLxLNXVN3r5pR+o7ZHoxYr5Lo2o5TYOREYt+iM8HuF6P9jgV4qGYm6RgD8JxcuGCSU0eeGGJKducOD2rkxk+pVgnFZMLxs2dSCG/6EJ3qXLa/I3BgrE4OdoZswMEgas2eJeacV3F5FcTpT1aFnIZIh08ZvrqvL1BFYUB5ZEyE+Hopnca9bn/hCScwgygqSJopIjJJWcqLgJxgMosJ/uFcVYXOR/TsGCxxBIvHHKhv6sf2YvTjdcmDQAw+3McLLNck17p1aZQ6QeG3EmBdu7fnVBdAQND02JEfqoiSamNsCN8KXoBkEcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(356005)(82740400003)(81166007)(36756003)(478600001)(2906002)(5660300002)(110136005)(4326008)(70586007)(8676002)(8936002)(6666004)(41300700001)(70206006)(40480700001)(2616005)(426003)(83380400001)(40460700003)(16526019)(36860700001)(47076005)(316002)(54906003)(7416002)(336012)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:02.8768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb872f0-0be9-43c8-8b02-08dbbf70daaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding and unbindind RCD endpoints (e.g. mem0 device) caused the
corresponding endpoint not being released. Reason for that is the
wrong port discovered for RCD endpoints. See cxl_mem_probe() for
proper endpoint parent detection. Fix delete_endpoint() respectively.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7ca01a834e18..d4572a02989a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1222,12 +1222,17 @@ static void delete_endpoint(void *data)
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct cxl_port *parent_port;
+	struct cxl_dport *dport;
 	struct device *parent;
 
-	parent_port = cxl_mem_find_port(cxlmd, NULL);
+	parent_port = cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port)
 		goto out;
-	parent = &parent_port->dev;
+
+	if (dport->rch)
+		parent = parent_port->uport_dev;
+	else
+		parent = &parent_port->dev;
 
 	device_lock(parent);
 	if (parent->driver && !endpoint->dead) {
-- 
2.30.2

