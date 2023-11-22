Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D77F3D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKVFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVFHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:07:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323391;
        Tue, 21 Nov 2023 21:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUc7DmBTRFe4MdEY17FdfVgvjpnVqJnoYSuLe7XN91FrAId+h8OzOcFAKnMnFeioBRuk7HzsBgz/3j/+GmNhWWU0lNvPaEDPfuIGHjAriDqa3JX24L8x6FTzpxwmntFe/GkELaUQu33UWJVN7DCAcPCmkn96vd/r0ITaYfmILNlVb/huwtizkmlQ5yRKPxHHG+9/Xz2467LSgkiuX3rbK6myBdS60CSuvD4xDK56TfKiF8IChTYasZrPalfltsOINvgxJeGlBKyp6Rj6ibOVH0xZEAvRHIVB3SdgzHI2UHbYyjZDQewO4l1vaPTMCnvEWuCTei+x9Xzmsy93X8uIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGFtnFzd1OHA/jU5BUepy/G9KXsMzLkfz8uecCs0eMI=;
 b=VsPiJIwGA+/LbmPLmfzJfiQhllVDVaK0+Bpov5m5tk0doLJwRo6t+TY7loqeSFxVYicjzk+04Rwi+diqs8BLpF5k85NnqGVk4YpmY7zoVTAOob/G6DNPLOZohiANiiupxt0q4hdrd+Qfj5seV+z+kkj0IXFVjFR6CNUc0r/lq02HRtAwIIGwP+sc7k9sbB7EPR1ub7qVhbrlssD4vnoV8Vs19PunKIa3Kx4A18BvWIFjsnl45Y6jioaAzxHpdVdkGYvbAb5UBKXjnHv/M5QiTOW/zNPO6OJjNPi+fO6BdofiNPFjcBJ0WulyeJBHCrV5WgsDmGCyGK0WaxFEu8Sglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGFtnFzd1OHA/jU5BUepy/G9KXsMzLkfz8uecCs0eMI=;
 b=SeWOhVHDuOuy7pk99edjMf/yHN8j46i0yQwfgF67CJqEyG/q7/4biirNe7ra0RKoJsBobRXK9dnXs6BJXfE7CGN76hBb/1/Af0j+uRMRWCRJfm4npUZAX2qVnZKjx5MARIGtMVtIdVjZG86HJJNILc32P7NbRk0P7X+72FLGfhE=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Wed, 22 Nov
 2023 05:06:58 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::7a) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 05:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 05:06:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 23:06:53 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [Patch v2] thunderbolt: Add quirk to reset downstream port
Date:   Wed, 22 Nov 2023 10:36:39 +0530
Message-ID: <20231122050639.19651-1-Sanath.S@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4690be-eed0-490e-6d89-08dbeb18da3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /z/lwQW3gMWtCh5FeKrxXu+NzgA6Wog83ihmnBxKT8ZJm/cZIJzxlVRUcW7TQwnpBpKVT2D39wuG4I9wY59uU+W0F/gqbaL7xv8VU4GN+pxMCZFcda6i5deS+Cm1ZA5ERFZlsfWJn554oiIouLXwp2eI3uYfoJCG1M1wd9n2jkyWb67w6+mugdg8qm8ddkg6GH6ydVv7thVh0a0Eoc4kNHdV+Sp8F9CC/8oq3TRIDfMZ8rwGx4fYSK1clG/sUAp+liMSx7FjV+/KoaM3pFJJDzS44T5usL0BGwntv8EiXFKtYkAUuTC+8oXa8EBhh4TIztZM/T7pvsrcdOmFMe266KB9OqmxQ/SAw/RtB++sKzR3qKD2mEb2Qd79s1tBgraQkqWGzcxTfLvCNO0DP4iVmr0i5jSGp71fojA/1aYplPHGvWlO5lGBrOZAqG5vVh7MVc9coPmCm23eY2I8qLdnUp7pXhykgegzprb6MLwIuKGHnNZeTRqg7Na+s+HX5DacG3A0mCBSbbqs683SYlsSX+StgaVAva8PIHpFb36iqgBK60SDOS7w4E5DWsX6KpOamLh3rIQPoVD6DLoQtGYFnWGl4KwlOEol3te+I0HkOsnPy3/CgWN+AFkGdEfM3lbFrFW11WLEcbaOZjukn41oBo832/PqZAxmHfV+VaTP++9qEDCRIg72DdNMkGwH2z+i/R8mt8C0xT5EV49/1cHF77Q/KSgIMEmuq5RfNLKB+WmcCm6+O8dxRrtOJrQTMZ6ANo4qgQZeAWUxZ6UQ6EVjH6H/bWKAIl7M0P1js5/bE83LcN/Ns0nNvccKBQPP74Jwi3LbBRQf6ZVdipqpvPPwEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230173577357003)(230922051799003)(230273577357003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(36756003)(41300700001)(86362001)(5660300002)(2906002)(40460700003)(40480700001)(36860700001)(7696005)(83380400001)(356005)(478600001)(81166007)(2616005)(6666004)(4326008)(336012)(426003)(47076005)(26005)(8676002)(16526019)(316002)(82740400003)(8936002)(1076003)(110136005)(70586007)(70206006)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 05:06:57.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4690be-eed0-490e-6d89-08dbeb18da3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
very minimal buses for PCIe downstream ports. This results in
failure to extend the daisy chain.

Add quirk to reset the downstream port to help reset the topology
created by boot firmware.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Fixes: e390909ac763 ("thunderbolt: Add vendor specific NHI quirk for auto-clearing interrupt status")
Cc: <stable@vger.kernel.org>
---
Changes since v1:
 - Initialize ret variable to avoid compiler warning.
 - Add Fixes tag with commit id. 
---

 drivers/thunderbolt/quirks.c  | 14 ++++++++++++++
 drivers/thunderbolt/switch.c  | 28 ++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/tb_regs.h |  1 +
 4 files changed, 45 insertions(+)

diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index e6bfa63b40ae..45e9d6c43e4a 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -27,6 +27,12 @@ static void quirk_clx_disable(struct tb_switch *sw)
 	tb_sw_dbg(sw, "disabling CL states\n");
 }
 
+static void quirk_amd_downstream_port_reset(struct tb_switch *sw)
+{
+	sw->quirks |= QUIRK_DPR;
+	tb_sw_dbg(sw, "Resetting Down Stream Port\n");
+}
+
 static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
 {
 	struct tb_port *port;
@@ -93,6 +99,14 @@ static const struct tb_quirk tb_quirks[] = {
 	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
 	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
 	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
+	/*
+	 * Reset Down Stream Ports on AMD USB4 Yellow Carp and
+	 * Pink Sardine platforms.
+	 */
+	{ 0x0438, 0x0208, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
+	{ 0x0438, 0x0209, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
+	{ 0x0438, 0x020a, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
+	{ 0x0438, 0x020b, 0x0000, 0x0000, quirk_amd_downstream_port_reset },
 };
 
 /**
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 1e15ffa79295..1c4b1dd5f472 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 	       regs->__unknown1, regs->__unknown4);
 }
 
+static int tb_switch_reset_downstream_port(struct tb_switch *sw)
+{
+	struct tb_port *port;
+	uint32_t val = 0;
+	int ret = -1;
+
+	tb_switch_for_each_port(sw, port) {
+		if (port->config.type == TB_TYPE_PORT) {
+			val = val | PORT_CS_19_DPR;
+			ret = tb_port_write(port, &val, TB_CFG_PORT,
+					port->cap_usb4 + PORT_CS_19, 1);
+			break;
+		}
+	}
+	return ret;
+}
+
 /**
  * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
  * @sw: Switch to reset
@@ -3201,6 +3218,17 @@ int tb_switch_add(struct tb_switch *sw)
 			return ret;
 	}
 
+	/*
+	 * PCIe resource allocated by boot firmware is not utilizing all the
+	 * available buses, So perform reset of topology to avoid failure in
+	 * extending daisy chain.
+	 */
+	if (sw->quirks & QUIRK_DPR) {
+		ret = tb_switch_reset_downstream_port(sw);
+		if (ret)
+			return ret;
+	}
+
 	ret = tb_switch_port_hotplug_enable(sw);
 	if (ret)
 		return ret;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e299e53473ae..7a9ff53be67a 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -23,6 +23,8 @@
 #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
 /* Disable CLx if not supported */
 #define QUIRK_NO_CLX					BIT(1)
+/* Reset Down Stream Port */
+#define QUIRK_DPR					BIT(2)
 
 /**
  * struct tb_nvm - Structure holding NVM information
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
-- 
2.34.1

