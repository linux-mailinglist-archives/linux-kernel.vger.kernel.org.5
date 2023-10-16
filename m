Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C307C9EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjJPFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjJPFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:35:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE6F3;
        Sun, 15 Oct 2023 22:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWsxpi+L6fM1FbZu8BuPfEAdaJT7lalkZesQrm5Ve0AlHeDK/rBHTulTTkWtfVKxX5x7kFB2dk7JwF2bqXIRGOTYN2zo+jdgGBznk1ka4bl4wAoAaAgJCUA0ZxLBLlzR/a/8wLq9MNR0nvigOcKEMahRAVpAeppTZLg/Yaa4/FP/etTI5vR87PKAg7GqovhWDGuUEps49nc1j/oK4hvMg4a1sULx5xHXJdDqyMNIzChQQzDa86J8jUf+dp29hdoMN+AhWR9der37B4W606lkb7kPX+7CWqR364WT/yz6Y2Mp1iBjtt1lv7pzdC3qBcHpASIMTMhTqKT9OHzWV8anew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsfBJldkiMPpKKWg3UTuMtU4ygnaQjwm8g1iBXNqTyI=;
 b=lPcHjyrvaPj4EAm+bAfwTYNpa1SHkKIbZ7ye1trdZrsoS07x7l+ubeETm9VPEMyZ0BYOt57ItiDQ17Cw83kmno6dby7GuBkoix/Oe88lavZ2+rHdm9oC0xBky55+8lELAR1/52hyJS+KcK1tUTHb8CBiYFPc6TyZY6uAOiB5vDRYmRkgqC9u3pqF0d+U5t++x5NXfk5tErDehbjnAduoGl7P4KMixKxfxnEffMVlyt0U4FEOV7a3TofsZ6Yl04Agu8Eb2bl7pD9C2taX88y16y/vtT/90cvG+GI3LOEePx5PqovpnI5fzhuL2b7kNHtQZa8lwAg0JdZNdJkTov9/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsfBJldkiMPpKKWg3UTuMtU4ygnaQjwm8g1iBXNqTyI=;
 b=M35ECHo5BsLaPKiLYXEhPVhd3DykHxx/XlsIWgWDRhRo32jTvCZfE5B+ZVok3DrhvNE1WtVTmQ/fFbJtajT2sZHg2qdwzzMRa6gwutmaI0KckERN5RDdf1qdSC6FN5hay1ufSlZHcAHPOBWh8z4OxMRGOl/chPuxDpTt/3mfDJTJQ/7OI0IgQIUDSbPIRDmg+nPYFqSUy1m6n0GvpuMGN2ljxlCbhNWhqgqeBwN52APsUvuNrjKQnUzzEYF3IDXVGIdK7poyVy1ORtOc3LiqDZxm+z75MHXLTXPt5g9UaQ+KB7drcW32qpV2zXIcIjX2UcLtqGBKXdnSOU699NYz5g==
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 16 Oct
 2023 05:34:58 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::2e) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 16 Oct 2023 05:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:34:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:48 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:44 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v5 5/8] soc/tegra: fuse: Add function to add lookups
Date:   Mon, 16 Oct 2023 11:04:08 +0530
Message-ID: <20231016053411.3380-6-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9333ef9a-438c-4f6f-391e-08dbce09a291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RS2xRLxxam8cUnx23c4byl61r3KgNJzpK7ipFt0obcH8YopY6l0EMfyfrsN/K/OZZrdwOxm/bXCD+Qyz0g981dXRVr9pa6iF6c8ojhVR4J9t1vdZqAAhH5H5BMsBaL8jHkukenbbiptHPkymeYYyspiikjZz5NezIJhjzFCP3oH+eY+k/FxSMD1/vrMt7FgrVcH2FJitWSNNYXy65sKvvXk27no2v6K9vzO4rdHnttWA5VLdGU4StuIB1poT1h+66adyp/HbNP1jPbAXyu2vL9e9t1DEFF4cqWYa03WHKJK/Gr7zV9cOvVKnQHc+685p93u1+ohnfGjVe0NotG3EsZ76iK/XD5uRcGkRKjAhLmH4v9sTX2J5DVA6NK1cSRwiO7pV1i8cqBSEVsh0aU1+RMNSKuLDvwjaWSIUFUFKU5QxgZGCsmoSeWHvHbg0ymjW3P8EAIf1TDpr7edGVNH4SmVPSuVkvNwx/SgS6fs/yF0pcpcZ1FHg9Dah69wr86AKhmXIaERiJ6liqfFJ+LNJi6XcdbMqZHkBMphLsNBmVNsMbaaDYBvX0trSiOm/2eWDaKpAsQX9P8Qa3lgd9UC9fCck8CdEArj7yHH8ttWaHOzV3mPHVKf50UATsxXPQUrcipEpMF26AOiVh1NDPXL5ukIwtemlOQvQaeGzVY3sPLqjQoP8nxc2k9EnzfRmDBq0rcUokS9tZ0folMcoNJm1uPIkKfbSrH9GGY54LD4KIaNejV/lKdA4g1ELBR8Eq3PA1okRFdLGtIJ6gVWpCdnBW3+4tPU5CMpNsnGyEh3zTfQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(46966006)(36840700001)(478600001)(1076003)(7636003)(2616005)(83380400001)(82740400003)(86362001)(356005)(36756003)(6666004)(921005)(36860700001)(7416002)(2906002)(41300700001)(426003)(316002)(40480700001)(336012)(8676002)(5660300002)(26005)(47076005)(70586007)(8936002)(70206006)(110136005)(334744004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:34:57.9260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9333ef9a-438c-4f6f-391e-08dbce09a291
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_add_lookups() to register Tegra fuse
nvmem lookups. So, this can be shared between tegra_fuse_init() and
ACPI probe, which is to be introduced later.

Use kmemdup_array to duplicate fuse->soc->lookups.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v3 -> v4:
	* Use kmemdup_array to duplicate fuse->soc->lookups.
	* Return err at the end of tegra_fuse_probe to remove
	  redundant code.
v1 -> v2:
	* Use size_mul to calculate lookups array size.
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 98805885158e..c91194612a9a 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,6 +113,18 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
+{
+	fuse->lookups = kmemdup_array(fuse->soc->lookups, sizeof(*fuse->lookups),
+				      fuse->soc->num_lookups, GFP_KERNEL);
+	if (!fuse->lookups)
+		return -ENOMEM;
+
+	nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
+
+	return 0;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
@@ -398,6 +410,7 @@ static int __init tegra_init_fuse(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	int err;
 
 	tegra_init_apbmisc();
 
@@ -495,15 +508,11 @@ static int __init tegra_init_fuse(void)
 	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
 		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
-	if (fuse->soc->lookups) {
-		size_t size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
+	err = tegra_fuse_add_lookups(fuse);
+	if (err)
+		pr_err("failed to add FUSE lookups\n");
 
-		fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
-		if (fuse->lookups)
-			nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
-	}
-
-	return 0;
+	return err;
 }
 early_initcall(tegra_init_fuse);
 
-- 
2.34.1

