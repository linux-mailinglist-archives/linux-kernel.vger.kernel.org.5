Return-Path: <linux-kernel+bounces-16055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC9823789
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5156283596
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA671DDF8;
	Wed,  3 Jan 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ng9RTSSa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347C1DA50;
	Wed,  3 Jan 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYX+sA6ayJyaAmJ4pNsWdN/wwq5ubnFfzhysCwFXG9X5JAE+1NNXMdrdOZsmtPngQ8e3CcDzPRDZWgrz1kG5loSFUXezSFQg4b+KjDQbWzGf2G2vK7VGSJCUQ58OxcC1ETCFrxiFq8PdAx/v22TnajwXqnT0bRv/qpvbZird9zpww8wAcH5tcV5lCD2UnVwngHj3uw6Kg+oXGRR6Oly8xaxJiTBT+r5TGOB/6BdZT4lwAv22KanUdPyW45aR3XiJYUAU2U5YGQNiz61z2DpMW3fyAgiVbxJyws9zwP/HRthBKjiijiQaOyVrSDVcM16Yn2V36VrCWylkvjGRSNB66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGxXhB8s+bvmGmwWjhm2W1CYGwPntTioRlHxDDfvlY8=;
 b=ZuWrNeVXCjbRlsQkG6QxeQfWA0APMUDvjayVvsV6mOzcKGtTpxFnuRSImyIYJy4N8YK3KE+EwmUGcTW1yZKo1kaOi6jRP7Vykn4g3MwzGxZpPSWUiau7dsF9RCVpmcIZ1Kx/9thncyGZzr9nGL3xZoaBnddL8vwDNbHm7wPjmsSUtHYw4HHYEEzTAMEesSAiW+7/eQ3FxVqc3rnv4fTQgK1JjRs26f1zMQN0o46BVL6ZbYZn3/GuPXGjAsX6F7qpahwSZDBv4LKNfVZNVBCL6/JugwseRhBlj5eOaLe89xWfsXdz+GLj2ukYyM/bqeV9KYDZz0x9stx+l4QQ67u88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGxXhB8s+bvmGmwWjhm2W1CYGwPntTioRlHxDDfvlY8=;
 b=Ng9RTSSal+TSDYTmQrExu2VcnAbOTbhgoUEYH7OiqQH08RzAvMHU6H0uhi8Fy3YdUcCqZlVI+6UxkUN4txhDLO70RzYFRzxgEd0C6RdwyFDL4qUUI96OwSV55JyEMaV2NwbcdAVwv6+m5Z/UAUvdQJgB5vrOXkjdBiwPLw5WiZQ=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Wed, 3 Jan
 2024 22:12:06 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::24) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Wed, 3 Jan 2024 22:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 22:12:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 16:12:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 3 Jan
 2024 14:12:00 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 16:12:00 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ben
 Levinsky" <ben.levinsky@xilinx.com>
Subject: [PATCH v4 1/2] remoteproc: Make rproc_get_by_phandle() work for clusters
Date: Wed, 3 Jan 2024 14:11:24 -0800
Message-ID: <20240103221124.3063683-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103221124.3063683-1-tanmay.shah@amd.com>
References: <20240103221124.3063683-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afc6893-2d31-4e14-5d67-08dc0ca90562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	77Ok6I9dVUfnTXvnkUVx+dNuT/DlF8IYHQ/JopBstVrQcJSYz4vXRkRaPbxBoLV9omGOoeF7oYeKlKkHXz40YYHoNtvk7c/5vBRh0C1EfMcx8iqfkOg3/dluyc0P+gSkm9SqllLWVYWTS0y1y3udwm0b7b5CfEkGtCo0xLfhtqvjOcRlccuCvVjljSl4kC3sVdOr//i1JbmZke8zs5OKDdUXtRKuZ5pY1SwhJ+f0x4ShdKctInGh/xigO3Xp1eZoU2jlAm7G7mul+KMpLN1wZ2r7Nc0qCzW2BfwfORhghaxKsI/vfmANcmFsJy2dWSRKHuIDkFe24jK7EtIWKXnTijScmDneLXrgfkN6beIL/J0Mq0/VQ1d++bc+pzUG0OBGSUZCIhBWlf+6nNYIrLG3Cf5GBGD257JS9ogND2bbMC10ql4ENFqPJpU1RNyRzgaJCEaOjKG2YrfYXUzm+difLTImMGg+D7iUriVBPzvMXiJt2OOLE5mX6KlcwL9q1cw1e1hT2APAZneFdUUw/MwJ5RkXSkfrcJnvrnqJnTnqsWwzBtMgawZC0oQNfI92hjhf2r8ZjhLpamZlXcjqmku0zKOIjDRh0I8lZ3WxyhYaZt4ToeE6YrjSPEQZYDEqYhHzNnuJw0eJ6tbr0m8D/mLiEvo+/RtCQm7k2oVxMtzDnvULv9K5Z+k1zbSUQZm6AoeAF43jaXN3F6xnea/2OjlKpKSnCwmeZeyqrqAnjsqZ+ZJ6U8sJndPPTH20U4oaEZl/alU1e7V8Isd2W5r2waWE/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(426003)(1076003)(336012)(26005)(83380400001)(86362001)(36756003)(81166007)(356005)(6666004)(82740400003)(41300700001)(70586007)(4326008)(5660300002)(316002)(54906003)(70206006)(36860700001)(47076005)(110136005)(2906002)(8936002)(8676002)(44832011)(478600001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:12:05.7075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afc6893-2d31-4e14-5d67-08dc0ca90562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Multi-cluster remoteproc designs typically have the following DT
declaration:

	remoteproc_cluster {
		compatible = "soc,remoteproc-cluster";

                core0: core0 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                };

                core1: core1 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                }
        };

A driver exists for the cluster rather than the individual cores
themselves so that operation mode and HW specific configurations
applicable to the cluster can be made.

Because the driver exists at the cluster level and not the individual
core level, function rproc_get_by_phandle() fails to return the
remoteproc associated with the phandled it is called for.

This patch enhances rproc_get_by_phandle() by looking for the cluster's
driver when the driver for the immediate remoteproc's parent is not
found.

Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 695cce218e8c..0b3b34085e2f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
+#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
@@ -2112,6 +2113,7 @@ EXPORT_SYMBOL(rproc_detach);
 struct rproc *rproc_get_by_phandle(phandle phandle)
 {
 	struct rproc *rproc = NULL, *r;
+	struct device_driver *driver;
 	struct device_node *np;
 
 	np = of_find_node_by_phandle(phandle);
@@ -2122,7 +2124,26 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 	list_for_each_entry_rcu(r, &rproc_list, node) {
 		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
 			/* prevent underlying implementation from being removed */
-			if (!try_module_get(r->dev.parent->driver->owner)) {
+
+			/*
+			 * If the remoteproc's parent has a driver, the
+			 * remoteproc is not part of a cluster and we can use
+			 * that driver.
+			 */
+			driver = r->dev.parent->driver;
+
+			/*
+			 * If the remoteproc's parent does not have a driver,
+			 * look for the driver associated with the cluster.
+			 */
+			if (!driver) {
+				if (r->dev.parent->parent)
+					driver = r->dev.parent->parent->driver;
+				if (!driver)
+					break;
+			}
+
+			if (!try_module_get(driver->owner)) {
 				dev_err(&r->dev, "can't get owner\n");
 				break;
 			}
-- 
2.25.1


