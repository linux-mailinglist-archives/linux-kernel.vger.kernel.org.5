Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC480F658
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbjLLTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376960AbjLLTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:17:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8B83;
        Tue, 12 Dec 2023 11:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCShfidYyPmiPI5gM0sxf47agveIP5pOR652gG17Ou8gRQUr0EULzwaiG7uFH0at5ZL0i/8Z0AivutOI40UL8v5BowNvi1uVYpJEI5LSiasNuoSFn53XsHdR2X74QxawE9osgoXln2x78V3uwGtmkNsDxYmfHhFbzBLndTiG4HXTsjV+5GTvOcK6Yj+pFW39VgAtoiGtJgyenGvCy0btp/lsdP+4zH0iw+FbzCwPnC7uZBDgSRJcQzvtS8oQjwdsRTa99iYmwEdA0ZWUH3mdMdDwPTyAhmgywHCdNUM0H3ZK+N0TCen/RECCia4xBvBZv+pjUeQRDXQPiWRT5tGZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6eZK4M6pHCFIlxHf8yCTbMhWPuEcXtg5NbAiGDBTMw=;
 b=C4smStsWyBaWTR/qj1ueQTp3sqy3EtamDxE3J9A44vrZTVyXXbNIWQVpgYJ3Wj7XbZCTiXfbzaMFhoOg1a8BbOq53WIB4pfmIPxTPAYATNBMO1zxBLmJenhT9/tq6v3AiRS16MNSC3Hdc8SJJPKdxsXH1e6S939dS+kK34YfI8g+xUOHk3qbFBISApDyuSeHNpAMPhaQdP+eOtPnAyheW6AtXoyocfdatnJ2DEZcIJ5p/M/ZqtfXWa+dt5Sqs6fw4rkJ8MbRQ8itx+SQfZQihB/WnEhXtENvf0zvcHEdLjBSxL24jQigiVbe9z/dsQ3ruiplKXRToYgi+aiprfieew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6eZK4M6pHCFIlxHf8yCTbMhWPuEcXtg5NbAiGDBTMw=;
 b=X89ddZDDme2V9z3dgEohuhQ1z/qU11jyj7vszESurrlYLeI0xMly6YQ54+od8zn4RV1Kc7jqZvuJYYzkvY4Q0zmhoVrvT0mU6stPlj5mgKyTaJBgVRbAwHSJ/960MtfAR8lhDqlt5NC2LiWYpk3vlWJRqQu+lhzLwKpSAd8/buY=
Received: from MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 19:17:04 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::bf) by MW4PR03CA0200.outlook.office365.com
 (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 19:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Tue, 12 Dec 2023 19:17:03 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 13:17:00 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>
Subject: [Patch v2 1/2] thunderbolt: Introduce tb_switch_reset_ports(), tb_port_reset() and usb4_port_reset()
Date:   Wed, 13 Dec 2023 00:46:34 +0530
Message-ID: <20231212191635.2022520-2-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212191635.2022520-1-Sanath.S@amd.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BN9PR12MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: cab96617-95f9-49b6-390d-08dbfb46ec87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33lw69V4X7yhtMBLC1oEiFWQFGqDeS5QonoPSP5069RNhMdn5vwQ9NYEVa4pDBEfPSglpRRlwl5GuLeRvw40KuSsbWg9wAMN5nteuwm24f+LN6D05dyknPGSSEzlyiA60qmyloITr9oOhkzcnZgcEEQxCpcYkCANVd1jhVyWovnvfpUvIanqP3HTKM3PKDLMp/UNsqf592bjyMFKaG/90pbQvEVxJxyowW0Jla26kc0oOyEpuFolA8DVL6EeDm4CPgKbtikDmdHGlMFV/XeKXDqsPvWATLLo8on8B8zbtPG5BBgwDC7rjorExqQIp+CcgPC4sgKAAtEI1VS6aJUEHTPhLx4AJkSHQOLkleBba0DRzl7+T5Tr1zJH22icEnY8uySLfbtwadCfEbuZVuztCA6Y8PTUnE5O1RYYlr8JzEWLzu3EbMxtdXarr3ERMFTRBrfFGYfGBnnEhbNhEf2ohBok1Md/7Fbj5SwkTdZ4IsIXauRhIPbfqSbgx+JDHjBUt8duRZkIB/+SuinTkTuDJAea4/8wzEi4UmtflabHDSFgAOdPQT7VInkumSXTBFebsT4+eWbCUErsow3q1gv6WARk6aVr4taSSUYMzvubv33HFlw4SUiR8DYeuWmQ72ojeQVY9PiBly9KRFQdp/WBwp98CtzAkiwKbA1gUCt6gOsApmL2+MjQbNw6OfMh4CVyrDAeDytvqEW3aXVm02s77sRO1ZTMFoqa5HQKAxK5ZXdlTenWH4ns2ce25PXhr6V7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(41300700001)(81166007)(82740400003)(8676002)(316002)(8936002)(86362001)(36756003)(70206006)(110136005)(70586007)(478600001)(356005)(2906002)(16526019)(426003)(7696005)(40480700001)(336012)(1076003)(26005)(5660300002)(2616005)(83380400001)(40460700003)(47076005)(6666004)(4326008)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:17:03.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab96617-95f9-49b6-390d-08dbfb46ec87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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
 drivers/thunderbolt/switch.c  | 35 +++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/tb_regs.h |  1 +
 drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 44e9b09de47a..ef7ed92fd48e 100644
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
@@ -1547,6 +1560,28 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 	       regs->__unknown1, regs->__unknown4);
 }
 
+/**
+ * tb_switch_reset_ports() - Reset downstream ports of switch.
+ * @sw: Switch whose ports need to be reset.
+ *
+ * This is applicable only for USB4 routers.
+ * tb_switch_is_usb4() needs to be called before calling this
+ * function.
+ *
+ * Return: Returns 0 on success or an error code on failure.
+ */
+int tb_switch_reset_ports(struct tb_switch *sw)
+{
+	struct tb_port *port;
+	int ret = -EOPNOTSUPP;
+
+	tb_switch_for_each_port(sw, port) {
+		if (tb_port_is_null(port) && port->cap_usb4)
+			return tb_port_reset(port);
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
index 4277733d0021..c8a4bf33ed1c 100644
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
+	u32 val = 0;
+	int ret;
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
+	usleep_range(10000, 15000);
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

