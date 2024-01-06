Return-Path: <linux-kernel+bounces-18667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E68260C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A290D28337D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94904D279;
	Sat,  6 Jan 2024 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lyklm5yU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40541C8DE;
	Sat,  6 Jan 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxzMOo1oqKVlm06O1gy3pBVhALNXeMQRTWhf2Q0TRHC8TfN4tLzp+HuDAREsXcMgSacBeuYnNQG/xdmt8dAVMxwVEIiJucc2W63Fv/qJ++suBdtberqhttwFv1em2nyDx6lDl46aCjTrKIV1KW1D0PlWk6yYea2wiZsnlfhtRDwOy8g+qSIlnSBN9iYq/FvbiAZKaqi1N06zT4ZtXyC7HY+ZSmRYTy9wLMJEZTYsChGqam+B0PshBC8Wy13ed1UQHGDCUbw+NKTFz7UaZXyKi97qhmTGEAeIOrAI1cH5hq3Tlj9MlmWIFdvCwrf7kCWlzd683T+KhxsUnJkyzdHOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfh9ob/z5vqjvnLxOgqLYAO6jdZbzXPECleNRaQFyS4=;
 b=hcvMjeh8HspGuNL8U5fBDLvPrJsVr3p1hi0IIzSHKz7pZvaQs+NRdUlvzi5fHFv7Fu5qu0R83IUBan7J9FetD5b9gK+8D9zGT0Yztpl0OaHPjkxOxZRkSD1aL6aOvQZUsBxqNK4ngdgHupULDwiFQU6cmpel6TD/mDxtJtplsqBIhSP6aN/mjLIkLeDLkGlmAS8Mxe/+oKOpYiYiUn9M+1O+Z56Hzozu6muEXMi4xElqkeP6DIYuhwP8SQr1R2qlpb+0iJxBtvikr2lOo3H/DFatUERY1c7GGnuTaDMEBJmjIFZeMi9uoqmyFj/878ee/2Tk24Z/3Ahk6KjRgPMxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfh9ob/z5vqjvnLxOgqLYAO6jdZbzXPECleNRaQFyS4=;
 b=lyklm5yUpDHumYzKFivplk6dhYtHMlRnWQzrAyMfohRzTLc7a9+nN+rdpe55MMBqMbvNePA+/mRvc0/cA4jIMffqfBRpFst8feduPAiz1BHQm7P8uYRtLkaKYb5UQlGxbkqy9hcm9bVhIOSMuiTKrtlxU9dhm43gr/C+y2cfews=
Received: from MW4PR04CA0236.namprd04.prod.outlook.com (2603:10b6:303:87::31)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 16:58:01 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::e1) by MW4PR04CA0236.outlook.office365.com
 (2603:10b6:303:87::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20 via Frontend
 Transport; Sat, 6 Jan 2024 16:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.3 via Frontend Transport; Sat, 6 Jan 2024 16:58:01 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 6 Jan
 2024 10:57:58 -0600
From: Sanath S <Sanath.S@amd.com>
To: <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
	<michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sanath S <Sanath.S@amd.com>
Subject: [Patch v3 1/4] thunderbolt: Introduce usb4_port_reset() and tb_lc_reset_port()
Date: Sat, 6 Jan 2024 22:27:20 +0530
Message-ID: <20240106165723.3377789-2-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240106165723.3377789-1-Sanath.S@amd.com>
References: <20240106165723.3377789-1-Sanath.S@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab1b7ce-e8df-4526-31ed-08dc0ed8a48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G+gTu1EpQRUlPtCvgy51jN3CeEgCRYSmMdBh1DlLatF/uaFMs+lC247x9YUQbw742dsn4HUbmMT/HwlmcdfQvUyhAbYUd4h/S8LBA5K5EsHacd34YukiniS2B9A0rT7CMCV83vD1wmF4jTh1l5E7LO9LJdDPAAF75fDn7Mb23dPq3drnq0gE81c3rG6hJNh6oz/dyAg0IPh36heXWym5TfHRuICPWWRZJlFHDlushH98RcdRAFZ3yFhg9LOm3LNrWwdp9I8/M6TSPLQbpkteeVMiHQ4RYyBZ3Pv6/PGBpXy2FEahQICZxN/gdjciKurAw46DLNzM1Ujlc+aCWzCpM61pnTyHjQoBn3BJjNBBudy2M9uPvd/g6mSACH+lDZZiQHRYy0QVyK1ERdGedtWpke1PTCBqjD2i+PgAg2DQxbwFsV9GANRGH8d0WNl/A2U/oIsN5TwGbNiHk42D/c0Bu3eDcigTQJTZcVVypCXg+B0MNgxuT4xKHHVqTa4O5Z2wacCDTZ7ObR7+Ble+fn8Mukv5EZ14IMH0ZF8iJUzHjuD0sW8lY0ed9zcfTQq1hFMJ+eAM0DSh3ChKILqiMFFLq+MTWNDTaxZEBGGXdaq2qr3R7mnlZzNRQJG9JVG9u6hbokshiijbqULFOTsXn3IepJzAxbj1QgP+MlkEhFtsVotU5rcFMm6Ex63BS+OnmPiEIourKYmTqB76VdY0S7GkmmfDtC9pmV49bxGu1OuDceOlTUX2ddpBh40N3zKECeSl1hO7rz3UBJ2Xdmljb494DrhEHaiYsDBNWsuqrDpRCZk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(1076003)(426003)(26005)(336012)(2616005)(478600001)(6666004)(7696005)(47076005)(16526019)(36860700001)(2906002)(5660300002)(41300700001)(4326008)(70206006)(316002)(110136005)(8936002)(8676002)(70586007)(82740400003)(86362001)(36756003)(356005)(81166007)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:58:01.4712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab1b7ce-e8df-4526-31ed-08dc0ed8a48e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046

Introduce the usb4_port_reset() function that performs the DPR
of a given port. This function follows the CM guide specification 7.3

Introduce tb_lc_reset_port() function that performs the DPR through
link control registers. Supports non-USB4 routers like TBT2 and TBT3.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/lc.c      | 44 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb_regs.h |  4 ++++
 drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index 633970fbe9b0..de7276909a42 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019, Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
+#include <linux/delay.h>
 
 #include "tb.h"
 
@@ -45,6 +46,49 @@ static int find_port_lc_cap(struct tb_port *port)
 	return sw->cap_lc + start + phys * size;
 }
 
+/**
+ * tb_lc_reset_port() - Trigger downstream port reset through LC
+ * @port: Port that is reset
+ *
+ * Triggers downstream port reset through link controller registers.
+ * Returns %0 in case of success negative errno otherwise. Only supports
+ * non-USB4 routers with link controller (that's Thunderbolt 2 and
+ * Thunderbolt 3).
+ */
+int tb_lc_reset_port(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+	int cap, ret;
+	u32 mode;
+
+	if (sw->generation < 2)
+		return -EINVAL;
+
+	cap = find_port_lc_cap(port);
+	if (cap < 0)
+		return cap;
+
+	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	mode |= TB_LC_PORT_MODE_DPR;
+
+	ret = tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+	if (ret)
+		return ret;
+
+	mode &= ~TB_LC_PORT_MODE_DPR;
+
+	return tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
+}
+
 static int tb_lc_set_port_configured(struct tb_port *port, bool configured)
 {
 	bool upstream = tb_is_upstream_port(port);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 87e4795275fe..efcae298b370 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -389,6 +389,7 @@ struct tb_regs_port_header {
 #define PORT_CS_18_CSA				BIT(22)
 #define PORT_CS_18_TIP				BIT(24)
 #define PORT_CS_19				0x13
+#define PORT_CS_19_DPR				BIT(0)
 #define PORT_CS_19_PC				BIT(3)
 #define PORT_CS_19_PID				BIT(4)
 #define PORT_CS_19_WOC				BIT(16)
@@ -584,6 +585,9 @@ struct tb_regs_hop {
 #define TB_LC_POWER				0x740
 
 /* Link controller registers */
+#define TB_LC_PORT_MODE				0x26
+#define TB_LC_PORT_MODE_DPR			BIT(0)
+
 #define TB_LC_CS_42				0x2a
 #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
 
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index f8f0d24ff6e4..4b35898aa216 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1113,6 +1113,45 @@ int usb4_port_hotplug_enable(struct tb_port *port)
 	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
 }
 
+/**
+ * usb4_port_reset() - Issue downstream port reset
+ * @port: USB4 port to reset
+ *
+ * Issues downstream port reset to @port.
+ */
+int usb4_port_reset(struct tb_port *port)
+{
+	int ret;
+	u32 val;
+
+	if (!port->cap_usb4)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val |= PORT_CS_19_DPR;
+
+	ret = tb_port_write(port, &val, TB_CFG_PORT,
+			    port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val &= ~PORT_CS_19_DPR;
+
+	return tb_port_write(port, &val, TB_CFG_PORT,
+			     port->cap_usb4 + PORT_CS_19, 1);
+}
+
 static int usb4_port_set_configured(struct tb_port *port, bool configured)
 {
 	int ret;
-- 
2.34.1


