Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6847FF582
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjK3Q3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjK3Q3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:29:20 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2120.outbound.protection.outlook.com [40.107.20.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C191DD50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFuC7xuIghOxB8zZ0hdbO5vA5pOYt2BnCAe9uEIFh6NJ/mDT8DnwlfMNqXabz+TaM8figbjMH1rWuIPQl9/I8kVUx199TbHtxUEGQTD4RsvdtXp5bazcK/kQtNW9NRnzV/LphVg1/eF1c5l6ToeN322DxJFs7fD1kLB58LmILgbjohgpmqYM2cWekg0opq7Oa4c0E/23zHYcHo8OAQNtDkiGiqKFHDg1tr0wBPC1/MQSeSeUEag5y4fG4DG/f69vrLWeGeGDALYJ28uQBJzQjZLf/FdsespwwGT3U/YcM1565r0zVfjc2NzxD/dDEnr07ql3E4uficPl8OJ7LvCidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhSABlOIftp6Bnq+wufsXxzLVNBkRoAzQ74WaxpezPw=;
 b=GOYF715PjWtDm4iAoKDZiBgxLKYIESlgW0Kv/78JQkBzcXEUQqXoinh2scoeXDrRtEIAek4PGY1Snlla+ZJlYG6z00xqeyoAfZwdyU/13mQsy0TujB7WL7JSOpG8VSTFL1RNfhqKcIZFwMx/4irTY3uNrOczhf2WRHL2zwGzh0OGkpwz7sz608+g0k1bF8ZA2HXt6YKmiGwF4BZsFhew9FyfcFuZcqUNZHapuCnQlu7H5dk5CRgAbYYQFFYslnr82qME+TslYMBWqEFQEdCI2gx844meFidk7K/GLebYLoyZCO+oaqnJzo4CO07RDQR4En9K62kRLJq4XsXYJz5yBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhSABlOIftp6Bnq+wufsXxzLVNBkRoAzQ74WaxpezPw=;
 b=D09/kbycGnA7GdTHUjd0x96WcHbvi2KEG467f95OG/PTrHVoKQfbmMjW9wy9u+S0NGc7dhMC43UQrU08CS+ZDw7O6p7Xrn1StvkgX3UeEB2493zFD9LeDSrDUc0I4NPel8bDuFN0QXTydtAYl8b2qnsEUN+hjBheh/bgS+KCD+w=
Received: from AS4P190CA0055.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::19)
 by DB9PR06MB7244.eurprd06.prod.outlook.com (2603:10a6:10:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 16:29:24 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:656:cafe::31) by AS4P190CA0055.outlook.office365.com
 (2603:10a6:20b:656::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 16:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.1 via Frontend Transport; Thu, 30 Nov 2023 16:29:24 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Thu, 30 Nov 2023 17:29:24 +0100
From:   Catalin Popescu <catalin.popescu@leica-geosystems.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH] nvmem: fix issue within nvmem_register with fixed-layout.
Date:   Thu, 30 Nov 2023 17:29:22 +0100
Message-Id: <20231130162922.2989774-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Nov 2023 16:29:24.0452 (UTC) FILETIME=[614A4240:01DA23AA]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|DB9PR06MB7244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db4c28da-8969-4612-2600-08dbf1c183e7
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OVPo28SUdOe8epASPRxcnumeyC3bWihrtt7LN9Weyl9YQ0OVAJ0mMdL3xKmh56kgV/uP3OVA8gZCmPZhEg6dDdrcDU7UgsarNA4g58kYGn4pIwR0/F+AAek7YMCda4bzTOsVN/i09RlIp3gSvY6KtiDrMesDF86obDNiGcYew35DX4fHT81whPSU0m1khH0MhqewnuDbQlGL6P4OwsPB+FCFBwUbJZFBnkpAXxhPsyzCPjg5EVpK7xBzoeIg/YDulXpEwE5flIN3phq26ktfH2Od038QS/BOYyo9iDDGdiLZZHGbubvC3z84wOJR4hc90rYZRu/g4o4U+ujhu+rF7vzxtCqKxZfz8ll6OhVcsQo0w+kpVYcHlKXpcI6QmXULpsVzclTFPMzCsY8dhqDX1JvDaL0/tSdjprKabF3AlbWBYsg33oy0MeCyqCsc0fNCViJiPaPb0d5gAAA3rbqnOkZifSiMRjmR2bjdpF6gBnwICrDGiYx7c8BlHl4NFhb2UT2Vk5hDldG5TNj/Gbx7/zbFMho6acm7r7n/9KyvoZH38qudkHSaiqHYUvQSS8HgaxzzVWp/ChEl4zTxcNM1FIKhwdBMK2bbcEdwY8+MBgscH6VvmFJjh9TLfGq6NWA1ijaE+E0lHJoewQPD3Y+QT71W6qcXbgaCLuUALvJgLt77EyIcspOIGafc9E6RRtLruq7ALSRafC1e7Vd2mDZD5XhhsPxVkP+puOu5S2HUg2Gd7/w1WSKGWS+XPfX7Yl/
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(2616005)(478600001)(107886003)(1076003)(336012)(26005)(47076005)(81166007)(356005)(36860700001)(82740400003)(36756003)(86362001)(70586007)(44832011)(70206006)(5660300002)(2906002)(41300700001)(83380400001)(4326008)(34206002)(8936002)(316002)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:29:24.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4c28da-8969-4612-2600-08dbf1c183e7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed-layout is natively supported by NVMEM framework.
Yet, it's not been declared as a supported layout. As a
result, nvmem_register always returns -EPROBE_DEFER if
configuration has no layout and the NVMEM provider DT
uses a fixed layout.

As a fix, declare fixed-layout as a supported layout
and use add_cells callback to parse the cells. This adds
consistency over layouts parsing as fixed-layout parsing
is handled in the same way than others nvmem layouts.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/nvmem/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bf42b7e826db..3467c94207e8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -746,7 +746,9 @@ static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
 	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
 }
 
-static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
+static int nvmem_add_cells_from_fixed_layout(struct device *dev,
+					     struct nvmem_device *nvmem,
+					     struct nvmem_layout *layout)
 {
 	struct device_node *layout_np;
 	int err = 0;
@@ -755,8 +757,7 @@ static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
 	if (!layout_np)
 		return 0;
 
-	if (of_device_is_compatible(layout_np, "fixed-layout"))
-		err = nvmem_add_cells_from_dt(nvmem, layout_np);
+	err = nvmem_add_cells_from_dt(nvmem, layout_np);
 
 	of_node_put(layout_np);
 
@@ -1003,10 +1004,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_remove_cells;
 	}
 
-	rval = nvmem_add_cells_from_fixed_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	rval = nvmem_add_cells_from_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
@@ -2126,6 +2123,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+static const struct of_device_id fixed_layout_of_match_table[] = {
+	{ .compatible = "fixed-layout", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fixed_layout_of_match_table);
+
+static struct nvmem_layout fixed_layout = {
+	.name = "NVMEM fixed layout",
+	.of_match_table = fixed_layout_of_match_table,
+	.add_cells = nvmem_add_cells_from_fixed_layout,
+};
+module_nvmem_layout_driver(fixed_layout);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
-- 
2.34.1

