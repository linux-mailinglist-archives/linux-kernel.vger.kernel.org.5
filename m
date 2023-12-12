Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF04E80EE41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376423AbjLLOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbjLLOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:01:53 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDCF3;
        Tue, 12 Dec 2023 06:01:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V72v3pIdPoHo8y0RGnzRmrwPJGd2+MNLoE4GMokcVXBSopHco312Ed2Wv6yxShu16VW05/DWm3wWqgvE3nLXVXtsoDDczvxTEUtECvBKwpR/Mx3i18WCwOAuU4oumPei78rZm83pLqysdLs1+v/eff/PqZbE4GxPv6CfnAlJ2LgoUmjB2DsDQ/dGwgSywDgHfeueG4Rj/wSZDPDXCT/ijG3ZFG6S7xXPyG2M/o/RYksf79cM9uggkyKM42oVAtYqOYVx4C19LMoQ39QHhn46QQmSNcq5ZIDixVXJM0HmDoBbkRemZY7ns+hD/NvIooTi5zQDeSK9dKyn6NaZGnHlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfcQUXvVw0p9oOtumuPAfOaWMEsChYFgXhfRAz0rlJk=;
 b=mK/1YJn862Um9MPMQgBT7ORBy6d7AOpVkS3mcNFkfEJ0A3k2Nz1OO+FBoEgOaP1gCJzhnJjqguCERQ/dOBt1RJH9/SOgODwqqRnUJcq7sRnqVOzr5q1y+xhuc5r12/Z0GgSrdPsO0C5NndBNuQmr+Q7cih00b/vLNflo8S9LsBT5WJBkRNLS12ZUxdIaPkG9qqkgCSnbpBx4aro0hI7oTCVvrF+IbSgNQb6KNiYKZLpWBOQ4vor5NB+F9bqLR4PFmAjrF3SZ2wulBSHH169ltDjWjhai5IdCRHkAiA3url5A6bMr76dJq28MMkBhVsmY24l1EGO65grm2PN9FK7tZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfcQUXvVw0p9oOtumuPAfOaWMEsChYFgXhfRAz0rlJk=;
 b=GtnKma2z9Z/lr0IDMxrC8dqe7C/yEDBNlgojrCyFgGnMRDcG34xD0DRkn9MpXSi6pLCwAaCrsgEgubWF7PpaUf2+OEr/JVu/is/lZ9VBntGfRM7nYvlgb6i4wWJy3JfigRM8Z+kg5vJZeHaK/o3VaI7k1djCPIvOT1r87NtZa0I=
Received: from BN1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:408:e2::19)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 14:01:56 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::36) by BN1PR13CA0014.outlook.office365.com
 (2603:10b6:408:e2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Tue, 12 Dec 2023 14:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 14:01:53 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 08:01:19 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>
Subject: [PATCH 1/2] thunderbolt: Introduce tb_switch_reset_ports(), tb_port_reset() and usb4_port_reset()
Date:   Tue, 12 Dec 2023 19:30:46 +0530
Message-ID: <20231212140047.2021496-2-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212140047.2021496-1-Sanath.S@amd.com>
References: <20231212140047.2021496-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e2dd1f-9f39-43af-12a3-08dbfb1ae5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsI++7bIt/zWCOx0venzJPGyD/xH5ZL/G5Jjhxa+uCT4yZnRObW5eSquCS2oyo25X6W+offz00DBU6N1aztatXXajNba7gNjyFyG2K/JP+5YrB20iCqNw8Cv6Ev+MqfOs6x3DZEwcuO1AfLAR31MCGsmlDtmrFUsLRW5AX3k7mJoCeCJ+PUMnp/rYu51GmokuSap8cCaDNnN84JbE4XzYGo0Pl1y3/zS8hHygBXasIQVdOsPnAtYA9uGmfMI3VzI/0h0bsDwhzyOHU4Z3r+3av79VBPz11kfW4IGYAS/IQvF1BCQS3d3UoDUY71kKH9rbeFQBQ28FaJ7BtzM0eqn22dIWvk+c/gwfNy3V1u7OMBSUiGlmUd/95Mx5/xIjOGDktFsGc+u8HP/NhrK6fGMEw8TG7liosIjLfbQMJQOjfWaHvrM3m6R8Kr3WigKTZyWcaVs/xRww5Sytg/z0cLTL9NhFq4Yj86ikEGIog06h1Uom7zbcU8FQEbQ1SGOKPIM2+JBTOCQ/bbLd2QhRDp09v4sqA5eJAujstx/zhALYtY7+uZyagmOU+nfvh+XzEXTc6TSK7u/L2+qhZLpZMJjb1qlxri/DGEyZB4z64H+kal4nXiqRzj98CJOaT5ev75b2uxwb1xUlw/c/vpX2bOn8uPbSc2lMmiICNZHtsxfqRm5Ul3LG7K+VAW/VV8twRwge043fs9kUdvQKSvRwJZZkNv/+GVWtJTLhpfXLc5swqVqWFRL4+FmI4BNKB3Is0iSzGOD/3rp/6URSSSCwkUQhUL5plwpLbuHK/k6eUaVBvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(110136005)(70586007)(82740400003)(81166007)(356005)(86362001)(36756003)(70206006)(36860700001)(47076005)(83380400001)(26005)(16526019)(426003)(336012)(1076003)(2616005)(7696005)(2906002)(316002)(6666004)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:01:53.7743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e2dd1f-9f39-43af-12a3-08dbfb1ae5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the tb_switch_reset_ports() function that resets the
downstream ports of a given switch. This helps us reset the USB4
links created by boot firmware during the init sequence.

Introduce the tb_port_reset() helper function that resets the
given port.

Introduce the usb4_port_reset() function that performs the DPR
of a given port. This function follows the CM guide specification 7.3

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/switch.c  | 31 ++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/tb_regs.h |  1 +
 drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 44e9b09de47a..26ad6cc1ee91 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -626,6 +626,19 @@ int tb_port_unlock(struct tb_port *port)
 	return 0;
 }
 
+/**
+ * tb_port_reset() - Reset downstream port
+ * @port: Port to reset
+ *
+ * Helps to reconfigure the USB4 link by resetting the downstream port.
+ *
+ * Return: Returns 0 on success or an error code on failure.
+ */
+static int tb_port_reset(struct tb_port *port)
+{
+	return usb4_port_reset(port);
+}
+
 static int __tb_port_enable(struct tb_port *port, bool enable)
 {
 	int ret;
@@ -1547,6 +1560,24 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 	       regs->__unknown1, regs->__unknown4);
 }
 
+/**
+ * tb_switch_reset_ports() - Reset downstream ports of switch.
+ * @sw: Switch whose ports need to be reset.
+ *
+ * Return: Returns 0 on success or an error code on failure.
+ */
+int tb_switch_reset_ports(struct tb_switch *sw)
+{
+	struct tb_port *port;
+	int ret = -EINVAL;
+
+	tb_switch_for_each_port(sw, port) {
+		if (tb_port_is_null(port) && port->cap_usb4)
+			ret = tb_port_reset(port);
+	}
+	return ret;
+}
+
 /**
  * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
  * @sw: Switch to reset
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e299e53473ae..f2687ec4ac53 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -797,6 +797,7 @@ void tb_switch_remove(struct tb_switch *sw);
 void tb_switch_suspend(struct tb_switch *sw, bool runtime);
 int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb_switch *sw);
+int tb_switch_reset_ports(struct tb_switch *sw);
 int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
 			   u32 value, int timeout_msec);
 void tb_sw_set_unplugged(struct tb_switch *sw);
@@ -1281,6 +1282,7 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
 int usb4_switch_add_ports(struct tb_switch *sw);
 void usb4_switch_remove_ports(struct tb_switch *sw);
 
+int usb4_port_reset(struct tb_port *port);
 int usb4_port_unlock(struct tb_port *port);
 int usb4_port_hotplug_enable(struct tb_port *port);
 int usb4_port_configure(struct tb_port *port);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 87e4795275fe..d49530bc0d53 100644
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
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 4277733d0021..55f7c163bf84 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1073,6 +1073,45 @@ void usb4_switch_remove_ports(struct tb_switch *sw)
 	}
 }
 
+/**
+ * usb4_port_reset() - Reset USB4 downsteam port
+ * @port: USB4 port to reset.
+ *
+ * Helps to reconfigure USB4 link by resetting downstream port.
+ *
+ * Return: Returns 0 on success or an error code on failure.
+ */
+int usb4_port_reset(struct tb_port *port)
+{
+	int ret;
+	u32 val = 0;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val = val | PORT_CS_19_DPR;
+	ret = tb_port_write(port, &val, TB_CFG_PORT,
+			port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	/* Wait for 10ms after requesting downstream port reset */
+	msleep(10);
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	val &= ~PORT_CS_19_DPR;
+	ret = tb_port_write(port, &val, TB_CFG_PORT,
+			port->cap_usb4 + PORT_CS_19, 1);
+
+	return ret;
+}
+
 /**
  * usb4_port_unlock() - Unlock USB4 downstream port
  * @port: USB4 port to unlock
-- 
2.34.1

