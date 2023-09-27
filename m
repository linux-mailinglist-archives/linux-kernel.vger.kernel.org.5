Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F167B0930
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjI0PrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjI0Pqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA3272BE;
        Wed, 27 Sep 2023 08:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncIe9euQiZiw6n+Y5N2ySuYLQDfPEw5uzVIiVK2Eu2WfjKGv2Now35fu8iTu9VNHCTTPsX0GGY1uds7gwYKdFeRqofIB9GZ5lPcE9JiK4LWEx236vJbxnDl2d1xdu19R6bH7opg12XuBB7bc3KHkDraCKFvZfHKGH/JA5bpSICCn+DmUz3r7nsRzyDe5JSuI+Hx6rE5C324+7TaUCPG/gMZ8V6vY5jVDAura0s6M+TEo7r04D3I6dxCMntlrzc4zMlt3+drpVZ0ax1RuKvaAg1BCocxR3PAypMR4NRhGOO6OMHCYOFWelgj/buYjlGTeXLGhywvg4ayW2+gx0/B8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa13YugWBoCwNnyBndxliXsrb/rMcaG5sf03Z8lk4y4=;
 b=e2e6gE0A88EWwwIPyjlzgLiWY4eAz2wIP9paHEe/Cw8BO8m2largb7QdV3JlOkTpv6/gwL6rH80Y9Wjq5WQOOhgxwRWwUlrMjz41kRUXiWxoZKzMMEu9K7lg/i/oF8HRolWvAd+iapN05P+fxbB636sKoO163al5TWPD4nu8/KYvAMTgbEnNr25hWcA0OupAy53+pJkYY4rwYyA60w9DX4t2WQFLxZyKO+RufaKSsKkT3nkBK06tl6Co+Y3rO4r5Lp7HroFCnbxOAj5+OcXk49QChYfhJVn36+buQFj74ZKxthdfkhGZg7dXox9q3+5L3poIapN8MruZS28rsE99Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa13YugWBoCwNnyBndxliXsrb/rMcaG5sf03Z8lk4y4=;
 b=4M+r+cJYD068c3js0SeR4yOa3c4z7Ky1mcnXGTpBzY2KLW9n+QKUleet5gUFInZNcOKWByqpJYv0IQ2bDVIxkgTt6TXIAYDMumq+7zQSchnZnzTsRC+P08XdujJZ4cg4f3j6Di5UagmIw6MR6rH+tA8em3RmqIDXR1LaSVhRw0M=
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 15:46:33 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::b0) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:33 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:28 -0500
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
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 09/20] cxl/port: Remove Component Register base address from struct cxl_port
Date:   Wed, 27 Sep 2023 17:43:28 +0200
Message-ID: <20230927154339.1600738-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e8cd52-c7ed-4b0e-755f-08dbbf70ed04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykRsyUNjp9Jj9Oyd/l5VCg7WZ4W4y7x2Yywf7LFk6S52enQlpdrKcMNIfMY1lRRNqT1mwuHhXKih7cCQ+r0W1ln8q1WOkok8HYE6RTh8bgsvfDWuhbPWWpBRG1DW6YL4O0PORlCQpjPFmJ+PrFFYKKgZEzMLUHcNynxW9OystFbQXLeDPDm7YqfRX1+vrhpr1VkyKAb3WcQSSx40RNWOKhjSW4FGrr3lEwpNa0onX7WBYe8l5akdu/I/s9mKSRYtBj/D2NP+oLSaOfvamgi8/TPfREeI/24mno+SJp7JSNTFxf0MugqyCot8cn6+vpZYFG09OF2Wxvp1w+ZlCO2y22BiuoUSGbjAVjrTBxTY4spaFyC5SDFikthuK/QgAMC9YCOZgR6vAyzyr4+jt5lJwlwjvy180eyNrx0vsq3uWYv1YgGdA+Bg56GcYwhkLHntUuKqp77VG2AyCAQwiEXbNzPbRn2ai9H9nnu0p+emOd//oVql1BoamTOuTQXZG+IOafx0YU/5F5lXTIs9dcHwTqFC9gn/kVDUD+PT9pzBYRsTvwni5LRdLdyflhP2Nm88HMAnb8Xltwn8B881cMBiO6MH5vewYdHYDS/UaPclo6Ix8Y/zVosEDn7bCChCnYoY2jRVerLkctrZkzQGdmxAVaBnMAx6RHfvuS6uSXV3WnHDoVxxVtHzzzAt2J5p66hpRpzj4v4CWrzrvDXz4vBGO+gDmTFp56zudm9w40fH+eT0wglG0OKjnz/BQodkskkkujg1UpLZB3SAM6aFb9vDvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(81166007)(478600001)(336012)(426003)(36860700001)(2616005)(16526019)(26005)(82740400003)(356005)(40480700001)(8676002)(70586007)(41300700001)(8936002)(110136005)(5660300002)(2906002)(7416002)(4326008)(1076003)(70206006)(316002)(54906003)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:33.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8cd52-c7ed-4b0e-755f-08dbbf70ed04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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

