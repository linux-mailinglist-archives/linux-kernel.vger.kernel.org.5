Return-Path: <linux-kernel+bounces-23794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901DE82B1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43141C21DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A694EB45;
	Thu, 11 Jan 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="fn6fZr8q"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2137.outbound.protection.outlook.com [40.107.105.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD064EB21
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpcDlKqQlXWkMfXqge34gOF5vyg3C7iasijHkodLgzAljpihTHgcXE7O/n1LIqUiIOf2qb2i1IJmzru8XxWiCyKizgVPMYcqWpa+u2X44SWdm5nvHIPRggR7cAb2zIZtsZzLSjT4FwI9pqYf5QZhsr1QL90jnJVX4R1LAkXDpf6k9SgR/W7eTDfCIfseMZfOMS3dyj8puoecqH37Rgqeq/PzHUhtpDdJ4agoGPR6K6DKa5g9dWkz0eYoQx9CiOD7mjIvjdytxSEKqxaNwMnHOs0pzjChtesRiDD2ioa30cC3Bc3Oj3tiqdWsfmA/IKeIsvjf3MS3vMWQxdh1fB5qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8jsp3SYztN1vWNwFiabAnRYvtCVSABqpxAqCQFQcRI=;
 b=IXd3IVbh6iQRszQcwqvmynAQnOo51v4sFE4TY+PbxADPgg10GN7WwhnHfCPGYsoJOO0dEoVKcObciz7X8Cf3kY5LzPZiFLMEtwV9dmOdKNPfTyVbZYFP7SOPY/Jq8osRaBMy4Zh5mJ8m4BI5qfRVxJW7atuEEzMJdKWw3ojWOuFc7WAO4cs6P7wkq4RW2I36ASy5/gDK82LnS5vZ1a5/uIcAiEY69aUj3rnRT+r+zz3gfU+0UjbrFcvM3s7gA4JGz8cRY0hwRtwukwmReGwQGdfN5uR7DgGnqJ6jPELaHZDoWtrCR8TdRxUTN1m3zij/FdZ0T8biYwHjmZwP42+paA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8jsp3SYztN1vWNwFiabAnRYvtCVSABqpxAqCQFQcRI=;
 b=fn6fZr8qsNutYAn/1XAng/K805YfhepO7Wbt02eoUPsJ+TBCu2vsyF974dxAymij8c35rSpYuDjk24ci3H4EaUqH+2CulhWPj3zSkhETcXzhWNT+m9ULVoNjjvwjO8Ny1nN42rPBCv+CSsJfpORdBkeSNLB0src3DdHy34rkK4A=
Received: from DU2P251CA0016.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::18)
 by VI1PR06MB6381.eurprd06.prod.outlook.com (2603:10a6:800:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 15:29:03 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::4) by DU2P251CA0016.outlook.office365.com
 (2603:10a6:10:230::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 15:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 15:29:03 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 11 Jan 2024 16:29:02 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: srinivas.kandagatla@linaro.org,
	miquel.raynal@bootlin.com
Cc: michael@walle.cc,
	rafal@milecki.pl,
	robh@kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH] nvmem: core: add fixed-layout declaration
Date: Thu, 11 Jan 2024 16:28:49 +0100
Message-Id: <20240111152849.3649549-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jan 2024 15:29:02.0886 (UTC) FILETIME=[E804A460:01DA44A2]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|VI1PR06MB6381:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f8ec542-2ef9-454c-a5d9-08dc12ba0ab7
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ebr9OtAmAqhK9Epztwa4TxOOnUVZ6tkhwO0WIyTR+pnju5Clut8bFHvHb9172v36W/NDDbMzULbJOmJtvhLbh3NOZMXj1R9KkbF6e4MG2JqS1Ql1eNYpsonGKBhP2/KZpNA1Lc8E6GEFYqwMzWAZQRIf5IQ8sxTPTb3Z8s+2sWJB5aXucwB96OYlLNKVMH/EVccS7y1vC2J2uAbkvq6TimJ6TBDZpSdmH5iwCnuZTKh0Ttq2z2/l0FR1zikVjj2JXpm1HSS6KEL7IfPDBXm98pijkTv6NpAy7NdF9ldBhqtVCJvRGHe7tTYfg2oUYJ1Ajo2sUf28Fn9tAwLZsZuHCjY6N5f9RN1qxjhHBRHNauoO4DkxSi6Mlpq28UT4bVgVGAb3ulc4A6S92zrXRm5DpI1j7uoJ5aQ7CGTyHV8wuVqL8jr5hPwwD3NLlwpZCTGrKag8YfICdjgoW0nl4NNP3z/mN/EF/VJDmQG+EavZkc4cXPQA0azyJQh1FQfcshKxQRAtqElej+uf7TJfNKWH4Eho3mEvkjkwDsd/9BX5Ztitcyeh9g8gd/KZVfGuz40zom6mItkVdQO4f9ra1LOA6LYSY4fH0bm/S9AZPHeOTuQyk586Af0wCoTsNuigRJzEzTX20XOHGc97zZHWOBxm1qOx9RhDgLhAYflnld1IKq1p+9Yf1nx8w0hVaR4isd4du1x5FeF5ZQos92Ipgk4WtDe0UqHbSqf6ghORxnZWScs8xbUgZkfrvbnvQxg/nb1T
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(41300700001)(83380400001)(82740400003)(70206006)(356005)(70586007)(81166007)(86362001)(36756003)(316002)(36860700001)(47076005)(1076003)(336012)(2616005)(107886003)(26005)(6666004)(2906002)(8676002)(5660300002)(4326008)(8936002)(478600001)(44832011);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:29:03.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8ec542-2ef9-454c-a5d9-08dc12ba0ab7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6381

Declare fixed-layout as a supported layout and use add_cells
callback to parse the cells. This adds consistency over layouts
parsing as fixed-layout parsing is now handled in the same way
than others nvmem layouts.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/nvmem/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 608b352a7d91..d7f34cbea34b 100644
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
 
@@ -1009,10 +1010,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_remove_cells;
 	}
 
-	rval = nvmem_add_cells_from_fixed_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	rval = nvmem_add_cells_from_layout(nvmem);
 	if (rval)
 		goto err_remove_cells;
@@ -2132,6 +2129,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
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


