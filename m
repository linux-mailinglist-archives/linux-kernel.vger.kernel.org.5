Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4782B7CE4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjJRRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJRRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:31:29 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77611FE6;
        Wed, 18 Oct 2023 10:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+JhyaXQbYqS+ke5wx8R3mb45OPa5WK4daEU5zhcObQEumP1EwvVRuu3TXs+qXv6s/3rkQiaMtGwAvy9aDBRaZSjYpP7YaryJRSiTIXEmdOvadHRjmLbRbhJrg6EeOh/7AZM7CjtV7aY0yGmo2pK7kXRv58nft/pNXuD30HIYDBlQFqaYQC0O0TNGqy5CHCrzllsqUQ7VGbGuDVS+v5unVZjQfA1RhQHM8zH9AIgV+DRW0p3OFlVTsvghevhHk4pQlr8Gkmay/+QVk49NfCK53A6YuADkQRmRHBBCmjHlg59zic/4PxQMFcHPDU7UhzxkKMApCOp0ltLaXwOBZkCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa13YugWBoCwNnyBndxliXsrb/rMcaG5sf03Z8lk4y4=;
 b=gsL/geyGpbbUVyO4z5QIEhQY8Iu5ZFYvSt7RZ0WHpRMyVFif+vGMwoTIgyihL2Mr9EbBSzPjAQclYj76dpkfoxPzyUDWm3+4T01CgQKXIpeYMMyt22rP+DstT7cjp4VKQYV718ZC03na7oL9TB3J6+i6yTDleR9d7rLmbxPxTDwZMMiiiMaCfP72/Rek06z1Lgsh3FMambjVYBvxB2eeMKiLf0Tu/SplcIanTHYFyo8/D2pdzHeJtQ6h0r4TqZsZd5st5rK77P5mdgp3IdX3UCvdFBZloH19wD+c7QfBQqEdghg35/NnX9NavDmF2V4+unKhSq5y8vtHS4q0CnxEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa13YugWBoCwNnyBndxliXsrb/rMcaG5sf03Z8lk4y4=;
 b=UOZ+m7i9XJHLKSQvvqEh+kMDLJuvxpc+osVqOhR8SGxX6S4TTkc5iDx5Yc5BHTO4mPpNrZ9VuM1UZAW1GX/LmRWv9pzhlPPSfx+ZyQThwMqSHFTN1JiLaJHzPX8hizg/APDhgnxdzzcmdCw4aQCYQfLXZO3lGxu9aSYtrKxNwHo=
Received: from PR1P264CA0046.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cb::17)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:19:08 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cb:cafe::e2) by PR1P264CA0046.outlook.office365.com
 (2603:10a6:102:2cb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:19:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:19:03 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 09/20] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Wed, 18 Oct 2023 19:17:02 +0200
Message-ID: <20231018171713.1883517-10-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018171713.1883517-1-rrichter@amd.com>
References: <20231018171713.1883517-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 859b486f-15b4-4659-7caa-08dbcffe563a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FaeXWIaIzlkFiIqzpVhrBcTCn+fUtaSRGley421dKFIE0BTvL/roDZ2y67Ww0vz2tSPIDyP/5JVB+als4MX34zpeV5VpV0pR1nPNZJn+m4UfRkO1GM4T6sIbnxSx/ksRjg1iDqyIin6VOzfdB4zDpW3+yv7daqyGlpwknWP+re3yLev5LhALQERRne55YJkSCMfxu1PUZgl+dpv7JO2d/jHy3+W/NG6Lpl486vYdvzhm6L5aoj2x2QKKZfB3lYv//6vPUuJ+IqP1GHtD9+EEMusup50gIFK9Hvka49Eb35uOGIuWUMlFBBDsbQKnEoysI1tIuKDDds5Vcg3oNFKccV4Q9vVbF/ePjnpfwI/OIKCKW7KDEVL4BHKybSrED/NTuQpHJtF3rtHubDl9PTcCvXZRUOIzfjUUc0+WKFQuQIw8ygH2AtwdWDewSx2/iTeyf/HyZ8WdN2UbrW9A0QhEA60flcjeE9D59PG8pxAiCI6ng+mxy7cYPpWloJbcyWVP8E6Q/P1e3K4hSdSwukdlv6NZGr792jOYPud5MTmybCMS/GtcknAxEv1rD8z+7jEus9F7ORsvhd9AH3W3BRsyPb2GcoLVwEsTdYKS1HD+k2iK7gYLsxYIKeFiq1TRaqcMOYtb8HCCqCneCrJkl6VVlpR34T5iBnLoKMrCke6nZyyylRCF5YvzKqkrSSYT+XhjZqG2uN2OEtlBMSfa7MKDPj9bTpxaNhG+wI0UUB2818NUb9Tq8UyUTRXBEPOeGG3R1Cge/ufTMsYPkKy1G7hJjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(26005)(1076003)(426003)(16526019)(83380400001)(336012)(47076005)(8936002)(2616005)(41300700001)(5660300002)(8676002)(4326008)(7416002)(2906002)(478600001)(316002)(70206006)(110136005)(81166007)(356005)(54906003)(82740400003)(70586007)(36860700001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:19:07.7748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859b486f-15b4-4659-7caa-08dbcffe563a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @reg_map instead. Remove the base address.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f69484d3c93c..41a8aa56cffd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -619,7 +619,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -670,7 +669,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	} else
 		dev->parent = uport_dev;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -746,7 +744,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3a51b58a66d0..c07064e0c136 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -576,7 +576,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -596,7 +595,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.30.2

