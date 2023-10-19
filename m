Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823EA7CEFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjJSGHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjJSGHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:07:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863612F;
        Wed, 18 Oct 2023 23:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHUuv0Kx1e6X3xdkyrMF56/hnPYE5ZBINKeCsd+N6iMlw3EFFXKPTl8ofcizsW3W7HxHFfwzH5aNptB/G/qQ5SpEcmppELlMHNFXUNPBLIJboUekaYkqDUqRQrRmLrVa8vCQ5KHPtkoJvjcwbuqmRbSpmYX4LacdDGi5L2mSQOoTUnxEM9A1dM90EPJV39JyJJK9tt7vp5OnxbJtH3OHIgNHi0bzmBu9F33uPaNbZaaF3UVbmkYx7Maq9zrccnP1jJad78/FKVsq7UHcGtAHJmUgydXBJ8kQe6amdxNkAEhDyKCZz3qx2Xb/rQAbLEIofqUDmWCKtkZ1cBD1ZzRj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sasqC5F3n24UWPne3LcQUDbYxohSknvTxX8edcy5lAY=;
 b=S9s2DurD90XLoKTNrvCg9hhWYBBU7yDtM2EILje6WkNESJ46f5D+RE0fCGItOADue7uQvdqLd2vpcmsYXH5MSBo6Hjux5GUbTXOUr8kYNVue1X0FpIKdOmBrKx9epyyr0SqX1Xni6GYlQsdDXUpIo7yqJixv+wZD5W24A8w4I5hFoc8Eg3lzXupmnzCChu+cireSy++yWfRJ35Jgfur7jOKxBrtVizrMtXXsAKVZda4DHsHAUBaqRY3DO1aidWT6EMxo1RhjZ9iPd7AKdy0C+MwnxvxYJbldbzpNjobAOv0wXShk/N/Z+qMmRJESWuvGdWMr0JkE4YEu4xpNjKYpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sasqC5F3n24UWPne3LcQUDbYxohSknvTxX8edcy5lAY=;
 b=rzlfhvkXuDWF0f1vG/TP9LF7QGfjCIZGxkFsnklW+AFXO5VWQuA8h5lzweZiDCwpg+ISfdxTx8ltcXIg1dPAcmfX6Ig8/VmqdarRR7NGb2tA+OMM4HHvV43M2TFdGSlIO3OxNGhSjfeiXLyag6zpfNDfnMQfeFv11gl5FqXgNJo=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 19 Oct
 2023 06:07:31 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::38) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 06:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 06:07:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:29 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:07:27 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <praveent@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/5] nvmem: zynqmp_nvmem: Add support to access efuse
Date:   Thu, 19 Oct 2023 11:36:50 +0530
Message-ID: <20231019060651.23341-5-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f76ae6e-c629-4ea1-1625-08dbd069adf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soelFM+XG3D1fIe++r3eWVTlakSORIiqhB2n/hezVIZ1muxoGkkbHW5iPgfDlBhuV4ERNMobBjcP7w1rbdEQmXzH4O1RXrcmlfUrmaM2bC3G/mtv1SyD5hL8yoJ0DXviUS2mGy835oSovQBkhI8VNmjxFGrYFnjU9vveXhUqpQ0eXlALy0lsx2AOEth2f4QvPvQXGJoOQ6Hgr/Gxd/leVc51s8vd0rLymtFvjE6eU6yWdPsEWd2YCVDjbVEtPT28Y7kTeeHO5Icl0JzzXlG623Lj9crEbpaHwfsWormfIUQaPivh7L1r/9RgOSdAWJmtmSjQbEVy1iUPf3M52emQiABIHOxPD+TWGW1FLZif9zpOdgu+DVvsHEpcVBTHC+5LjC7hwxTf5QjnTFcxsGOHpw8BYOrj2A4/LCLB1eA63ZaeU07AZsSnFO49eIGTXhpS2fldPE040DAVyaa4MWpH0AzMO49YYb3bShagQAUNCxbObVN56OU8IzqaHCWevp93dpy+cFl8QXFVN7d8hrWeV+9GT93Ws5SUunoPwrGxhViT74DWyUmOgDHA6w/VjvIAwnF76hYV06dKMgU5VYM6XKc1vgxi8QN1+GhJ3P4Z4GiRFBi8K1eOcHieaeYWzzBIi97f6KW4BjMn+OYbkVsXGrGI4e3fmRoxCIPc7YwQmOq+nbZQrheS1kCQwmYTdVqTYgDBrovKgHNK9V6Faa4CCOEd7UaK/98ZRcK/zdRNROWw9nYrEs+EbzqHgA9h+d9PKCmaBasy2mZdHMkdGNWwOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(2906002)(6666004)(86362001)(103116003)(36756003)(336012)(426003)(41300700001)(47076005)(5660300002)(81166007)(478600001)(2616005)(26005)(40460700003)(316002)(70206006)(36860700001)(8936002)(356005)(4326008)(40480700001)(8676002)(82740400003)(110136005)(1076003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:07:31.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f76ae6e-c629-4ea1-1625-08dbd069adf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read/write efuse memory map of ZynqMP
Below are the offsets of ZynqMP efuse memory map
	0 - SOC version(read only)
	0xC - 0xFC -ZynqMP specific purpose efuses
	0x100 - 0x17F - Physical Unclonable Function(PUF)
                efuses repurposed as user efuses

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 drivers/nvmem/zynqmp_nvmem.c | 218 ++++++++++++++++++++++++++++++-----
 1 file changed, 186 insertions(+), 32 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 7f15aa89a9d0..a3bb8c3a831b 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2019 Xilinx, Inc.
+ * Copyright (C), 2022 - 2023 Advanced Micro Devices, Inc.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -10,36 +12,190 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 
 #define SILICON_REVISION_MASK 0xF
+#define P_USER_0_64_UPPER_MASK	GENMASK(31, 16)
+#define P_USER_127_LOWER_4_BIT_MASK GENMASK(3, 0)
+#define WORD_INBYTES		4
+#define SOC_VER_SIZE		0x4
+#define EFUSE_MEMORY_SIZE	0x177
+#define UNUSED_SPACE		0x8
+#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
+				 EFUSE_MEMORY_SIZE)
+#define SOC_VERSION_OFFSET	0x0
+#define EFUSE_START_OFFSET	0xC
+#define EFUSE_END_OFFSET	0xFC
+#define EFUSE_PUF_START_OFFSET	0x100
+#define EFUSE_PUF_MID_OFFSET	0x140
+#define EFUSE_PUF_END_OFFSET	0x17F
+#define EFUSE_NOT_ENABLED	29
 
-struct zynqmp_nvmem_data {
-	struct device *dev;
-	struct nvmem_device *nvmem;
+/*
+ * efuse access type
+ */
+enum efuse_access {
+	EFUSE_READ = 0,
+	EFUSE_WRITE
+};
+
+/**
+ * struct xilinx_efuse - the basic structure
+ * @src:	address of the buffer to store the data to be write/read
+ * @size:	read/write word count
+ * @offset:	read/write offset
+ * @flag:	0 - represents efuse read and 1- represents efuse write
+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
+ *		1 - represents puf user fuse row number.
+ *
+ * this structure stores all the required details to
+ * read/write efuse memory.
+ */
+struct xilinx_efuse {
+	u64 src;
+	u32 size;
+	u32 offset;
+	enum efuse_access flag;
+	u32 pufuserfuse;
 };
 
-static int zynqmp_nvmem_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static int zynqmp_efuse_access(void *context, unsigned int offset,
+			       void *val, size_t bytes, enum efuse_access flag,
+			       unsigned int pufflag)
 {
+	struct device *dev = context;
+	struct xilinx_efuse *efuse;
+	dma_addr_t dma_addr;
+	dma_addr_t dma_buf;
+	size_t words = bytes / WORD_INBYTES;
 	int ret;
-	int idcode, version;
-	struct zynqmp_nvmem_data *priv = context;
-
-	ret = zynqmp_pm_get_chipid(&idcode, &version);
-	if (ret < 0)
-		return ret;
+	int value;
+	char *data;
+
+	if (bytes % WORD_INBYTES != 0) {
+		dev_err(dev, "Bytes requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 0 && offset % WORD_INBYTES) {
+		dev_err(dev, "Offset requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 1 && flag == EFUSE_WRITE) {
+		memcpy(&value, val, bytes);
+		if ((offset == EFUSE_PUF_START_OFFSET ||
+		     offset == EFUSE_PUF_MID_OFFSET) &&
+		    value & P_USER_0_64_UPPER_MASK) {
+			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (offset == EFUSE_PUF_END_OFFSET &&
+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
+			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	efuse = dma_alloc_coherent(dev, sizeof(struct xilinx_efuse),
+				   &dma_addr, GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
 
-	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
-	*(int *)val = version & SILICON_REVISION_MASK;
+	data = dma_alloc_coherent(dev, sizeof(bytes),
+				  &dma_buf, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto efuse_data_fail;
+	}
+
+	if (flag == EFUSE_WRITE) {
+		memcpy(data, val, bytes);
+		efuse->flag = EFUSE_WRITE;
+	} else {
+		efuse->flag = EFUSE_READ;
+	}
+
+	efuse->src = dma_buf;
+	efuse->size = words;
+	efuse->offset = offset;
+	efuse->pufuserfuse = pufflag;
+
+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
+	if (ret != 0) {
+		if (ret == EFUSE_NOT_ENABLED) {
+			dev_err(dev, "efuse access is not enabled\n");
+			ret = -EOPNOTSUPP;
+		} else {
+			dev_err(dev, "Error in efuse read %x\n", ret);
+			ret = -EPERM;
+		}
+		goto efuse_access_err;
+	}
+
+	if (flag == EFUSE_READ)
+		memcpy(val, data, bytes);
+efuse_access_err:
+	dma_free_coherent(dev, sizeof(bytes),
+			  data, dma_buf);
+efuse_data_fail:
+	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
+			  efuse, dma_addr);
+
+	return ret;
+}
 
-	return 0;
+static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct device *dev = context;
+	int ret;
+	int pufflag = 0;
+	int idcode;
+	int version;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	switch (offset) {
+	/* Soc version offset is zero */
+	case SOC_VERSION_OFFSET:
+		if (bytes != SOC_VER_SIZE)
+			return -EOPNOTSUPP;
+
+		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
+		*(int *)val = version & SILICON_REVISION_MASK;
+		break;
+	/* Efuse offset starts from 0xc */
+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
+		ret = zynqmp_efuse_access(context, offset, val,
+					  bytes, EFUSE_READ, pufflag);
+		break;
+	default:
+		*(u32 *)val = 0xDEADBEEF;
+		ret = 0;
+		break;
+	}
+
+	return ret;
 }
 
-static struct nvmem_config econfig = {
-	.name = "zynqmp-nvmem",
-	.owner = THIS_MODULE,
-	.word_size = 1,
-	.size = 1,
-	.read_only = true,
-};
+static int zynqmp_nvmem_write(void *context,
+			      unsigned int offset, void *val, size_t bytes)
+{
+	int pufflag = 0;
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	return zynqmp_efuse_access(context, offset,
+				   val, bytes, EFUSE_WRITE, pufflag);
+}
 
 static const struct of_device_id zynqmp_nvmem_match[] = {
 	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
@@ -50,21 +206,19 @@ MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
 static int zynqmp_nvmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct zynqmp_nvmem_data *priv;
-
-	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	struct nvmem_config econfig = {};
 
-	priv->dev = dev;
+	econfig.name = "zynqmp-nvmem";
+	econfig.owner = THIS_MODULE;
+	econfig.word_size = 1;
+	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
 	econfig.add_legacy_fixed_of_cells = true;
+	econfig.priv = dev;
 	econfig.reg_read = zynqmp_nvmem_read;
-	econfig.priv = priv;
-
-	priv->nvmem = devm_nvmem_register(dev, &econfig);
+	econfig.reg_write = zynqmp_nvmem_write;
 
-	return PTR_ERR_OR_ZERO(priv->nvmem);
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
 }
 
 static struct platform_driver zynqmp_nvmem_driver = {
@@ -77,6 +231,6 @@ static struct platform_driver zynqmp_nvmem_driver = {
 
 module_platform_driver(zynqmp_nvmem_driver);
 
-MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>, Nava kishore Manne <nava.kishore.manne@amd.com>");
+MODULE_AUTHOR("Kalyani Akula <kalyani.akula@amd.com>, Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>");
 MODULE_DESCRIPTION("ZynqMP NVMEM driver");
 MODULE_LICENSE("GPL");
-- 
2.36.1

