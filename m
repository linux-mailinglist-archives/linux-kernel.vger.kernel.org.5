Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA477CEFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJSGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSGHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:07:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE23F19E;
        Wed, 18 Oct 2023 23:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbUrfb/+UTIUq68gWJkGm8kA1bxaOCq76s7AV8P4OXRbBhapzhZJo8oyNT0DDNEnBelomplY4pf/gOvm9hR05X7OlFXr/NdukiLtb4tblquU8nOvlMPNcNsQOpVkwX+16esfsU82KOchJftB7zQj0KjdqZszZSYTNgf/jszK7NLXVqgCmHOtbQ+xhot53ognv/aMeUnYxON9XYY9eGZZrbG4aTXilVPCJiuiAH2gP9kCDCx16Njdaw6vDWV+YpKV9Gvn8yognscb1xcCYgeFDIleEpyS2EHVmkw7mhvAdBr6xC6QdhJSxLxHUVYOwY65rfNYvX4wpJV5NXPVbPDgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN86kemZZhr5+jJZSILS4xn8mKmE10N+gyBJS7TIt/s=;
 b=ehKrdrBu5uUW/1aCZ1e8SKt1WViJ9hBiwnMDaz7smuyd2JjksrxGv8Bss2/UcoLex9S8dFRXtNG4r8DgLhYiUlVxtXl8WJKUkBIDazo2HciqEnrdCpbij7ddB7fdIffCjJsUJyAYLw+9D+B6v6wH1nTsFIv3B/h7GC+t33ANj3k/F8FTRVn+jwP0EBwek+d097q+3WdrfF6GiUTYDotI9p6AZg2II8gYWtTVppbgQRhaEjVp708Lyh00Tf/+TeGW69XzPTi5m6dF5rMfy4y3YrNjbcVTMbGe/yB8CEVqQZGLcnL+eQB9Z62p/kw+VWKvHp6XhlNvQQ5Ih4pE4ah8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN86kemZZhr5+jJZSILS4xn8mKmE10N+gyBJS7TIt/s=;
 b=Ceem4DDHKgC4cZhSHzgw7P+AKbaIyriBlz3b/4ULYqOzYwmgJ+dXFSj4TXFOruqYWGD9SmJyZqXZNSbQQjYM9L1e0NngDpMtC1KChirMa4biBssy+uHLT3GTwUXuMLBMZJR73AVf5Va3Vx2XWHpaJBMVwM+w/HDTDaIxc7Nm+JE=
Received: from CH2PR19CA0006.namprd19.prod.outlook.com (2603:10b6:610:4d::16)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 19 Oct
 2023 06:07:35 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::a) by CH2PR19CA0006.outlook.office365.com
 (2603:10b6:610:4d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 06:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 06:07:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:20 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:07:18 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <praveent@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/5] firmware: xilinx: Add ZynqMP efuse access API
Date:   Thu, 19 Oct 2023 11:36:47 +0530
Message-ID: <20231019060651.23341-2-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ad36e-31a0-46f2-c1a5-08dbd069b00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEt9LkYcywg+S7HB5T5EkmZam8OvHlZkDHeoTO2RXs0lIRh739cGHkm37aiAo1zK27o4bwmOEoFUp7Ffff9WgJD2PTVN79LK1EGGWMQyMtLk3cB+5TDHl5Wy73knChMOptWElvnBJnOP8kceFS72v5F+Z07UL5Q539kEXDxhhnYoGVDcIHSgm9EC9N39wCXIgs+GBBgXuSZ3zcPJsrnfFFJbOdiA3rrsXPLL19I54eDjpNbNjkhJUx9Rr3PQkx13ietqWkoa+a3k0lnJvKLaP8pzyvAl33W1Z3dlIG/0K8Gy/LqJwGdKvw8lU849IhvBqS+iYucxoOptqoQgHsWmpN1bEKV2NpYDYbERRdoZbKdeK8JsmeE1ukPwckDjhDKwBzLSco4LkF4cnbZSN1c1mobxnPlaLe+TqKX5tyVimOoutWcLkEpEV3XsPVLFepQlkPdtXFVlMZMyrjLsBzuKtFVqBSbhCte6IiXGGU+wEJaLWyAlrB7BIWKkKAnAHWPvapd4/j7HVrSkzKrduMuMJgfkgBAgHA3FjzviWXLaO30H9LrhR/kvkT1lwk2OBjGntt/msf1AxDx1+GF5D94C+5/ajmLz5c7nEB7hE/IF7zUuV9Ak5K/A49gB8iktHbI7FeWiS+aSZYO7LqmMAFcIAWk16HHP8zl3zSlxwzR06YqlQbfIIXITzdjB6Fhs3FZnqL20l9Y08loOk06XXMn/gOpEMlRhUdgnPYmAF1nM3eN/lbOq4taBdPAQpWT4IOpLx3/0l2nif9HVWOlXu4jvvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(82740400003)(8676002)(356005)(81166007)(4326008)(8936002)(41300700001)(40460700003)(103116003)(86362001)(2906002)(40480700001)(1076003)(36860700001)(336012)(2616005)(47076005)(6666004)(36756003)(26005)(426003)(478600001)(70206006)(110136005)(70586007)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:07:34.5954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ad36e-31a0-46f2-c1a5-08dbd069b00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 4cc1ac7f76ed..5a4f7256b9e7 100644
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
@@ -1435,6 +1436,30 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
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
index e8b12ec8b060..4f574fab74eb 100644
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
@@ -143,6 +144,7 @@ enum pm_api_id {
 	PM_CLOCK_GETPARENT = 44,
 	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
+	PM_EFUSE_ACCESS = 53,
 	PM_FEATURE_CHECK = 63,
 };
 
@@ -534,6 +536,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_efuse_access(const u64 address, u32 *out);
 int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
@@ -727,6 +730,11 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
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

