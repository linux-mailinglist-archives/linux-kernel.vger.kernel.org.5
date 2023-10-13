Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA17C82D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjJMKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJMKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:15:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D47BB;
        Fri, 13 Oct 2023 03:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DViq1alVTxNkvoWNLBD+OEYBIDwGTo8T/TP9XVENZ+wXLRhnWtjeL1q7PwoDZ2kszVAUqcwj0KzlbbOtGaWkiPSOOF1s9/gMYn5aBskbzhOXD4wzR6i9mtZBqh5ZYy8UuSgw2kbC/PRVCU2XKuAtFMoYGXphmmmYULISt9Wfo46w6FTIhd+UoKJlvF2Rma7pSnr3FcJFl+Ja4UC8rt7J00e8yXxMgAlMp8qJBewohETGnVW/a5exvHaZCfjMP89XMyhQ337lSuR75o1UpHkXnahk7UGC5HcnvfpYlI2Aexgc2Vh5xF9Zsw/3m1Lfvann/Jh5JGqE5nsBQmJ28rL3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sboTPLMsvuXH+DRirYYy6pBrX+DY9o8mpm7Qul25hFY=;
 b=EpTtOKNP+LFrGoO5uHLZX91YTzRi2BDitq9WiuvAC9xDfbMggKo8+cT1SLfyCUa4WZei5z6uhmySho1gXxzYLTB7cDvOOpPF5YfjDvqmP8COvvlhLJ/TSvdWoEmE68I7vld1JUmnacnlxSA/FuUIOTwpYpGffFjGs8+tefrwptT8O9z0myxhDX3MB+pVF8Nh4sQ1MCliefKet6dVMB6N4dYzYbCfPY/wBUaQ9h3ECXDkOwvcOVXHDEWsbaq8R7CVZxINls4WzCDUHZPwEqDAhk07xmonCKGqNisRqsvXr5mbf3AkzUu649K3CeTrremi1z9tVdNZo2yJ8zRs875tNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sboTPLMsvuXH+DRirYYy6pBrX+DY9o8mpm7Qul25hFY=;
 b=RYIIwgd8IHFPqQXFaopHCZTInMAbREvFST5uU/0TBOCePsAUaEko7WnJgKZKWa+ffUfpA++GsHosk6VdHneWCIlYV2fdVxWM/d4xRP5CqmzbQhm3J4KQ4RLmfz1F3o2Bj+rM7Gp8+M/djTxm44shKHhtFcH0XqqtewDMDCaXe6c=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 10:15:18 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::60) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 10:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 10:15:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 05:15:15 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 05:15:13 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] firmware: xilinx: Add ZynqMP efuse access API
Date:   Fri, 13 Oct 2023 15:44:46 +0530
Message-ID: <20231013101450.573-2-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a0d7cd-a37f-443e-6603-08dbcbd54cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4Pd2evyjJaCZp1FHojbRclJnQQvyiWeFpM/Y3aTIoccgb7PDrIFEnmUKlq9tjuzJ6abg920zN5wYbve4jypdP3alv3VIEeJVsayhyWn4QkzGpA6F7qS4I1incVzdwdivY8xeDWkrHwDBN+brmxfax2Uz2C0vLiPJxQESPkN5dgc5//ibQEc6GaBkkybvq1LAq2w9TmnMNGM+rD1RI6HjUVZSFExmjKMNZpPb3Xio6OfDMqFy9vRo8E7O0J/5UJLvPMvGsiBX9nBNSU1Q4l3HcU1ERjXm7mweZ9eY3T/uQy2LcadFCUH7juDEOUba63zSVGSe3XMLJkeVv6Z0HSGryZ1RuzfPFdAEtiW9QXeRjsXpkTSUqHxRXbtpYUghuT203ogRCKdYHyqcwPG0wDfFh2LkMIznQpU0Thk9SJm5FBUi2suluefybIre7VX9cOgtwikPlNIRacKQrQrQUx1GIG7h/1EoSRnqvmWLeQPDnlYe+nGFQ0ilyleTdZC1A/jm4XjJJJkELyvpuiisSz0tL+6TSuidROpDPX5TzyQNFzNWc52FxOiP4W8iSfvsSCkvL5fdaucXTF2DgTWGirp2YgOUqQM058Neqfdla7mJP40qY3HbKdOnWfaDtO9N7EB1uhEkagd5abvrM22hYIiIMCI3bVIpG19HBYr5wiw1VozndwHzUZiJXGC2ONYhsm5IOUQUrtBARXiN+6JUpdr6iVkIZd5vyM6HJcioaAm7KJ+KXS5mXLDvfr2nNHmvoJgtMlOqb/7ctA/3MbS5pJlJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(110136005)(8936002)(70586007)(4326008)(5660300002)(8676002)(70206006)(316002)(41300700001)(40460700003)(2906002)(336012)(26005)(83380400001)(356005)(81166007)(82740400003)(47076005)(36860700001)(2616005)(40480700001)(86362001)(1076003)(103116003)(426003)(36756003)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:15:18.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a0d7cd-a37f-443e-6603-08dbcbd54cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add zynqmp_pm_efuse_access API in the ZynqMP
firmware for read/write access of efuse memory.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 25 +++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f8c4eb2b43f8..b0f6272e0844 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2022 Xilinx, Inc.
+ *  Copyright (C), 2022 - 2023 Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -1390,6 +1391,30 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
+/**
+ * zynqmp_pm_efuse_access - Provides access to efuse memory.
+ * @address:	Address of the efuse params structure
+ * @out:		Returned output value
+ *
+ * Return:	Returns status, either success or error code.
+ */
+int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!out)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_EFUSE_ACCESS, upper_32_bits(address),
+				  lower_32_bits(address), 0, 0,
+				  ret_payload);
+	*out = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_efuse_access);
+
 /**
  * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
  * @address:	Address of the data/ Address of output buffer where
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9dda7d9898ff..721cebae3f14 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2021 Xilinx
+ *  Copyright (C), 2022 - 2023 Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -130,6 +131,7 @@ enum pm_api_id {
 	PM_CLOCK_GETPARENT = 44,
 	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
+	PM_EFUSE_ACCESS = 53,
 	PM_FEATURE_CHECK = 63,
 };
 
@@ -521,6 +523,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_efuse_access(const u64 address, u32 *out);
 int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
@@ -714,6 +717,11 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_efuse_access(const u64 address, u32 *out)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
 				     const u32 flags)
 {
-- 
2.36.1

