Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BB678F02D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbjHaPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbjHaPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:22:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286CE79;
        Thu, 31 Aug 2023 08:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxwY8Z4SPoBvgKg1LNqJUW1d12DHoq0n1Nr4HMZUzLo8aTmnsrfJpivGxpanVY7EN5kDGzywocUaMPlbyUkg4FcjyF+DPfvp6aHIVsis3ugOBihgJu5/JBM/jo0w5CzUf87fboKM+GtE4peP3ekiT9C0sJvHEP1KD4Aah3byqDMEeZWeHHfsr8qpjq5U8/xblKXcdTbP0AutpfCCO1I5iSW1TecqjEV7/tP19SOSFW0P6mQtuRFTWHaiqaFJN26lkgWYA+w4BCUalUoFqgxeucwPdoHpD3+opYvIG1EI3S2WJ8AChluZq3jS6iY9T/7j9X5QgvEtmNcEbmtbHeKlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QcZ53O3679akSY/4aegxTJ4ylAgFghUHLuI0medMLA=;
 b=hvQ2Q445WYkDbRnr+0bH8br9/4FYnlyg6h/GvFrjE47jhOAN/MISJoGoBSw+LRC2AJ3zAN6yNku46WvDonDVQYcDbvdgnYPu3Fpl5wPEcj7vOTFm+N/myKgxfNY7VSybMaNrlDFIhMUtnQOLDbOi7nO4XWrSpNKPjuARYBSImk3r0GMERrvdU40eTJ7sY7WAq9gEg3mXaMR5AAy9HjM+bYqmxgL0uqAunWMICfPWadVBpi+WZ4R3VaZfysQA24fL90xoEKd8oBWgIh/xgSlDpUv/ZEre/K0nRT0e8ngWEOF64ULzMMnnPra4heueiPSzLALrRpp65QI8H6oZ9Qr8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QcZ53O3679akSY/4aegxTJ4ylAgFghUHLuI0medMLA=;
 b=Buw7gO0bZJf6zuoUo8cljudLf53B4kPcsXVMAa+zbypabTQDH0Q/eaU0ZPLlifDGXGFv+3EsIievWeLFSwp2weKygQ+DubjenET7dhdD7JTzwZWw/LFQ2vIvvgI+HGH0v405RG/GUHulF/Wm2SgmgPZhzZybPOTuJzYwo9YrnLo=
Received: from MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46) by
 PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:22:04 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::b3) by MW2PR16CA0033.outlook.office365.com
 (2603:10b6:907::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 15:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 15:22:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 10:22:02 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v10 06/15] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Thu, 31 Aug 2023 10:20:22 -0500
Message-ID: <20230831152031.184295-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831152031.184295-1-terry.bowman@amd.com>
References: <20230831152031.184295-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 019c68a5-45a3-4c9c-54c7-08dbaa3607b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmN/+ZEyH0SqSfGH65qEs3sT/tXzC+xm6BlqlBIBLt8pYqfTEPBxc2kV21HjVPNTIxGM4gwwFK+J+Vbe8PC/YKRQ7ulpCyzB0Zg9ThmJrjVlwfaU0cmL20tOMEPXX9+aGY1a2faZlmy97PjTtcaNjo6Xb+LUFF8YZNsuBPBNE7UVmlFrkfjKZy+bLKQxKt4ni5Bly4WSpD7Yc+9v+dPPCuu0Cx31syD4C5TmMjS52EjKYopZvwIJc6sOP1TwX8Qb/1dRUXpFtGO/93OlNtPz4Pg8F+9j2aedc59UI6mDjR3u4h3mwnz3NKnca4KF1pSAihmuALXUJTnyYa2EHHSUgdvUS21TZ3eZXFL0wfWa9H6ysbMyYt0sXPA1YY3GO2g/pFqKaG2fah4mDLsks9mADYQkC6qJ6JX24BqS/HYEqeZWkqU/5BOzi5Gzg+2P5Oh/bwBT5hup9OE/KRXYdyyeoVUu7ayrpxWh35fOKs+FckZ/BepD6d1Y4pUf5Pm3UGdvobWaCcLpaXWA/uAvKim4751tF5XZQUklcsRI+1Hay+zdyXziGL6MJlOczmDC//2kSoTKRTNupd2EqTYuCpqtUzybMhn1msgS0ebKvg2nzGUoTQijbGtL2B9QkRDFgmGiiGMij6X75wJQDVhk6P9ZFPMt/GvAuv9OojsSGBQ2Ir8ZVjD/ByZuc3uhseL8EUXbftl2rDmhmqP8/G+8glubs9hGtZ23/nuUectdxNaMXn/cUIw4Ga59vFvyr+0/vFn4hc5XYSSztoKFLma17wxaQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(356005)(82740400003)(110136005)(54906003)(70586007)(70206006)(7416002)(426003)(6666004)(336012)(1076003)(83380400001)(81166007)(316002)(86362001)(7696005)(2616005)(2906002)(41300700001)(478600001)(4326008)(36756003)(8936002)(8676002)(47076005)(44832011)(16526019)(26005)(36860700001)(40460700003)(5660300002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:22:03.5865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019c68a5-45a3-4c9c-54c7-08dbaa3607b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 4 +---
 drivers/cxl/cxl.h       | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6c06c36f8c7b..9151ec5b879b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -618,7 +618,6 @@ static int devm_cxl_link_parent_dport(struct device *host,
 static struct lock_class_key cxl_port_key;
 
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
-				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -669,7 +668,6 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	} else
 		dev->parent = uport_dev;
 
-	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
@@ -731,7 +729,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ec8ba9ebcf64..b4383697180f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -578,7 +578,6 @@ struct cxl_dax_region {
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
- * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
@@ -598,7 +597,6 @@ struct cxl_port {
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
 	struct cxl_cdat {
-- 
2.34.1

