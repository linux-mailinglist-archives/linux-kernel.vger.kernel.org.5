Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ACB7CE4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJRRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJRRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:31:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3730C4;
        Wed, 18 Oct 2023 10:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbIm2tHtuuDjbRgy3ZAaPdo5Oye261ziciy0OoyGRrA8uVpNBaTfDMp8iGho0sePZBaQZHFCV7O1r9sUGE3HPSXDYDBjG5f467zc7psjyz5mkuqMygzHcYb3PD7DAy8mV8wR30J3uWWuiSJ2dQDTs8Cq0TOnZMCVwNA3WHRMN6ECHOdiNSkwIWPmAPcOo94FjOke83u99G4HpJCwvXG/5cRZRUrOo16j0Lg6XFHcVbr153jICdDJHL5w+3ooYXc8vGYQ/NAE8ECu9wsNrYV1YKxOcOjuSjtJWQStFHvI1TdCbE/C6vxF+p+4EuHV75TM3Z/z3q3KXjs2GANX2E1Few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfsvuKuyDi/tXql6AZNMGDRoa5dOzFIVFGCOqCrVrFQ=;
 b=oGg7O5FLgMH1ByEpYgamUpP++7Y3rdJ9oA2+FXfaS1WP21mzCTdQL3jvYFqfYMEDlSv4MfYJCya/rVXG8BktYyGAprm4ZLmEAGn732OHWlPUZD1vWqUvJPSgQWG2CaVpWBKknw+txFHzDUjJ1LGAP6MEGA95IVXGs/BPPxrs8ASTFx3bzhoKhHr6Csu2D38ewgIXOm4gUmUq6QTUfaJgPpROQ30vn3idmR0X9rIEN+DOoS9Ca1zkn3O8wNPCvgl77xjFNwOUNOC33yZ2jFn/xHMK8yj+UBoPueOdbXpZGnp9wl3+xvlbYtwAjQgeZWJNntSFx8KoFjeRIhEhwMQRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfsvuKuyDi/tXql6AZNMGDRoa5dOzFIVFGCOqCrVrFQ=;
 b=j8r4D3/UDHVLkzZuSnP61Xm0Y+GcgYMsC2mAH7wAXA0WwZQFBDCQNPs33nNwF8ni+TOACGJMaczGokDwPveXveRzroFDPBybFsqgoRyM8OOo2krqA8UoVY7GU8C/1Rrh7JLeT4pas3UCnK2yzVx7sr+ahufj9T13T+PoB3vX46g=
Received: from SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) by MN2PR12MB4440.namprd12.prod.outlook.com
 (2603:10b6:208:26e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:18:08 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::44) by SN6PR2101CA0025.outlook.office365.com
 (2603:10b6:805:106::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 17:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:18:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:18:04 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 01/20] cxl/port: Fix release of RCD endpoints
Date:   Wed, 18 Oct 2023 19:16:54 +0200
Message-ID: <20231018171713.1883517-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ef10a5-9709-44a6-5c8e-08dbcffe3286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foIJOp8RvBUdJbZnpX4/T8J1HFQ3RGrFuQ2hCHOGyWvgUtlR8ujjgDXHX14Be+ZoC79TevXE41v6rCmFCWkMuEGR2chGECvePAnKqbux635lzaAFjSYM12FO0ezyD+bm4JwNdOHvKn1td3j8gwzfYJzw3x5nrxx54EoU3F5XU3eDNb1NHMBp86ntypdj5F3GxEkAD+uECmVEJMOMGuON1u9V5EUWHvgXyioty6KGEbzm1lYK+QIeVFf2Jqwxoev8YEfVC9m6HP9c6yAFkht9fsrFjOC3A9fkBy+M3UzHf+kioN6vyHn131F3Wzkd8Hpy4a5fm0dbr5A9g5xG1FI4JAMTertdDu4QIiM4UGECkn1+RWfZSIDg75/I1GHzzACPIIzJswNWZ3ZUV8GJnLgKhbDdo5FWLU65XIv/CwpaDFwCAe7is6NbTybkWvsoQGR0oKYz9jaHkM4z45rSkUpOfS515hD7bW7BOw1VhhNGt4qnKeYSCOot20nh/TrHOO3JQQ3m4j0zqgr3vOJzBhOHlvBK3Qwbl75/VYLPrpmLw0ll3ScuEgQxYR25gxkJiv/GC00uAoiJNfWxInJn4N7f1pALw6WVWFdZffiNqOFsRaWM4j5WcOW0GtDG3WWuCV6S7oordQc+apue2MSVWAGcrnGseaoUG7EfPqxfsyoH4OqmE6rwQoZjNx/hnBX3WlCtAUQTAeXPEs9TAV0mICNNOZV56OFypT5JhRDF+mFtflMFkyYUBKQb2c6mQVSr+/CTxeSeDlK596uEguQEiD2eIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(7049001)(426003)(336012)(26005)(16526019)(82740400003)(356005)(47076005)(40460700003)(83380400001)(7416002)(41300700001)(54906003)(8936002)(110136005)(70586007)(8676002)(4326008)(5660300002)(1076003)(70206006)(316002)(2906002)(478600001)(6666004)(40480700001)(81166007)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:18:07.8584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ef10a5-9709-44a6-5c8e-08dbcffe3286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

Fixes: 0a19bfc8de93 ("cxl/port: Add RCD endpoint port enumeration")
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

