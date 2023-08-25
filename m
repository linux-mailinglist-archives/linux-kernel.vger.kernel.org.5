Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0444D789275
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHYXgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHYXgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:36:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4D62D48;
        Fri, 25 Aug 2023 16:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwAZYPWE4JIxjOTnVacvIep08QzFryLWTu+z/3zxpJ85jZ+tIg/9trkfl53AwQpeeRL88puxL4jKHuV2x/5XO4ns424/uI1o9gu8mmgTUXqIkqxvyOR/e+Yrmplims5cg4205C71ZvusNAFuw2pTkgMzTsqNt4MQcw5aaGpZZKvvVyvzBPDroEMUqM0c4XjMCjjgB/rRPOoy6eewr0b1GlZ0qZrYmgu936uhC2brgLEfUB0N7C1bQqccXnlOaEb3aCH66UlcMWAYbor7ui+AgiSfsfplx904JNiYmBLcnfQpOiVTaI8Q9LUWst3W+r5Yuni1PHIqs19TWdpaZ4UpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HowVnlzW4JC8ruauWc5sqF4TOOU9RUL7T65pRePyA2I=;
 b=YdNd87bDTTCWcf0IrA1zCBJzBk3LKWrJGGLlMDIbfrasxyx16/YUaXVHyKJxIKUXCpZmB/eNFlMdsGLpnr+BODc3lMGFiKA6fklVdye84nKF5D6N2I8P7NCzfdxCFuU2un2+lsxaZS5IJIqGTJ5wEEgOyRI55oC5BJb4p3kCwhUQDbG6CvaHeSanya8dWixFrBpVgG0Z38rVzaShaPC9OReBN3ATO5vU6FS6NDPZ1fPZUo4rMRl1aLxVVns2Z4Yj+xOcwWSF54R/jpH5INR14diSqUdYCHemE4Q5TW1KvwvLFb9tyaDMb+D1TxP437Qd8h1rrKN+U0bW2zlZJbIcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HowVnlzW4JC8ruauWc5sqF4TOOU9RUL7T65pRePyA2I=;
 b=zOWLBmw3tz0SSnALM7sQCGG43P+ez7YBV0zKYiuJliTwjeP/RT4Qw8/In/f4xTZ0uX+sE37gd8l6k8XbAZzawtc+A8RUFnPC+JnB0fZw0bgVSchpB1vUx5T8nH/PQbGBoGvPkwfZ8FtQAKR0qIv4u1mcU75e8g6RgowaZidCrog=
Received: from SA1P222CA0152.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::20)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 23:35:18 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::8) by SA1P222CA0152.outlook.office365.com
 (2603:10b6:806:3c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Fri, 25 Aug 2023 23:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 23:35:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:35:16 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 15/15] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Fri, 25 Aug 2023 18:32:11 -0500
Message-ID: <20230825233211.3029825-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825233211.3029825-1-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 635bc7e7-47a0-4fb4-b2db-08dba5c3f0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCeTfC1ymYbtPu9w4ocEdu7OD+LZ0kdHIvL5pt0elYZ4rscDVJmkMTj4HOR4mxXHgIIEwRzLW/dgdu3jCvTFqGtyRozR3WOun8/6GeqI4poV7b5t+xt3iiyjnEDNmVoH9q33OILDTqYcJbTG4eqaMquhCPLlyFzPRMofM5+CxT4cAgW1rRipzj0NqnyiZcP6MmxMNJnV4TgyvJc3SLumxqrdLcV1rhY+gIlMAKJoAnpb6pCqUTbgcpW0BVbX3s+EX0VNy2FX358Ei5uTbNUVk6Tt+/d91VUpNZnfX/BE2VFmtuA0XA7EEZKrE0YTrOmO2nYNaRIy4lYpUeigtl2L8yrQe4Rh0iVy8755YX0NAX8DGAHDLuOcag9N0xs9ufp7TElDmUOMBXOmx0+0OJBWoSwPSHREf9ofaOREBlE42mi352Ye0XOtJn6LSXKVtpOnl+pP1vkP75hs6FJXBUC8QC8xL/9o/u7TUVwdvqxXWNa8MCaWFvrI4Uq8wlHQow5tDfYq5J5V6K/2mLxMPg2IR68Lw3QO6JcwQ3C3A3AfnD8kqlZoMDDku+DDeRfHm/2BHv+fNLcRKXjEGoTHIYLaZFMv+5smXlP/mXngfXXVg5dn7m03Dh3CLXtMSAB3Pji3a2ephVYzSy4YhPZvRCXU3TdvvBTcJS7dtZL7gEl7+wABNEYje2Us4BWS5Sgdw/Krvuoh1K9G7EAViYFI/UjeXcIrE0WlR6suTA3I8smqtU+GJlf7d+uoYViyqC3ujd3kQ4t0UKnH0T69WW8t9b8Ruw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(6666004)(336012)(83380400001)(426003)(82740400003)(356005)(81166007)(86362001)(36860700001)(47076005)(36756003)(40480700001)(16526019)(26005)(2616005)(316002)(54906003)(2906002)(110136005)(70206006)(70586007)(41300700001)(8936002)(4326008)(8676002)(5660300002)(7416002)(44832011)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:35:18.0174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 635bc7e7-47a0-4fb4-b2db-08dba5c3f0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Trivial change that renames variable phys_addr in
cxl_map_component_regs() to shorten its length to keep the 80 char
size limit for the line and also for consistency between the different
paths.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5cb78b76c757..f8f26fe80489 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -217,16 +217,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 
 	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
 		struct mapinfo *mi = &mapinfo[i];
-		resource_size_t phys_addr;
+		resource_size_t addr;
 		resource_size_t length;
 
 		if (!mi->rmap->valid)
 			continue;
 		if (!test_bit(mi->rmap->id, &map_mask))
 			continue;
-		phys_addr = map->resource + mi->rmap->offset;
+		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
-- 
2.34.1

