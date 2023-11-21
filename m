Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A27F3534
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjKURrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjKURrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:47:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B2126;
        Tue, 21 Nov 2023 09:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecDXRpzi36DfOxG5/+8QZzGT+BQk6q27GfChNYYU5AlFgQXYOgQ9UJ0s9XdG/5GD69t7X9/gHMo0NJNThnyIptW2IQw3KFKxHiENOOBnoeXEvp/HSP11N9Q50n42suboXhjfF0/R0qLit4xqpkv9UZ/0bILHxoJzuqags/y+BGZ1jtdf/wxyFxpG2/JIDEVF661FMuPXJzRHTE3mqLy5f5HV1BTqGBZQOnJQMeIkKNQY8rE+w4u9/iJFKUhgiQGtynTqVspj1YjiCdgh2KQ2i2fYt0VUbVnuPKwj7VqgJBwSs4uUD6VrNetrkjr6SWV9Z4t6vMj+6z9dluw+pN4zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnw88ls0XwClQvrk0m083TJmhFBLgZCCm2lsDem2SIk=;
 b=GJXQh2F0kUob3/fYPjCh1m7GkBBItrrKLF+WrbO6oovJe0eszNnjVtT3sFDWYbHBrFr6lZeDf7TaIbtJyVcYjHMlbjRacXMD1hG2tWoe6eUqCXgi1nQs647fcLfL0EJ4mkSmnmzf5kiPpjyMrBqSsZ75TnroTzUsSaKAvDpmDd/BSxmEZz6QB5pWnUiN5QhR1+mOzo3ZqbuuqxUo63k22W9h6F9fsrpIUYV2Mc7mHlzrWo53eRimoYwRDG8Nr0isBOHHMzrYxyHOE+B+xt0P3aiCwwQzPUDqj/XgnHg8G4pxkm/ehoyXAOhbaK04FjPrKY5KduIV5bWX3A2/ho99Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnw88ls0XwClQvrk0m083TJmhFBLgZCCm2lsDem2SIk=;
 b=jXAi0HdFcLm86Hv1w7x625jT7cZrfNMaXio4d2h5aYdP80YRjt6f7kf1C1FMyzBn23hZYxUfX23fIMcE8oLTjt3um3tzVJwUOxkbtsUYi9w7QFKaYNYSB1BUKYxPHB6iOvB/cdnLtF84/lQGJn09JjdezMaY3aLcvzxQ8trjW7I=
Received: from CYXPR02CA0037.namprd02.prod.outlook.com (2603:10b6:930:cc::15)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 17:47:34 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::e0) by CYXPR02CA0037.outlook.office365.com
 (2603:10b6:930:cc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Tue, 21 Nov 2023 17:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 17:47:34 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 11:47:31 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [Patch] thunderbolt: Add quirk to reset downstream port
Date:   Tue, 21 Nov 2023 23:17:01 +0530
Message-ID: <20231121174701.3922587-1-Sanath.S@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: c6894e3f-5ad2-4095-6898-08dbeab9f192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3R7hXoBBopW1ZD8lTbqlOQVJKV7J3NCfQrI17LQLUv0WP87yabDjLFk65fzeiKY76C0Hcbp7pqZmHIzjzx1+ashgFqB1PGzHoLqK515pX2fa/+0HX4J/SPZhMns03Zf6E3FaQ6xAl4dy4PME0zYzx7ogje1+m9JMSxwRi/KPNtF+nXf/U3cfEyAMpoiC1kQexpQRU6f+OGyGv1S9q/6ZI7GYPzXG5vWHVVAVboTgtb6zm1zdBrLfxqeLu8FiSTaTB6SuK04YOURxD6+KQn2yo8MmGjKqRu1kHo7v9ABKXxUqQif7UOakmygiKtNqIhOAYIuU/SQ7l1E3ZZEbpjeiNV8UQQ6ofRV6f9Oq44Qw+MvWS6n49udUerFrQzTYWSO9zNPTZiW9o9i2+zIMqLLxfQ43ytP29uHqAy8qYhU2hSr4KFXBQ4BKSvz+NkICXf60VbwN21PYHZFCECp7M04K4lAzlWywyXultUiLRp5qPtV14Ui/W1TUzfZMuafzHMjezSarHxHSxYFJYIlno5ZZCO/e769Qo68TFs/j2P4HBf0o4p+iCvXbFaH77iL2sC8PgDgJv5UbMpdD8Y2Sx9Ebtj9rFFHVd2ECb9M6561C6PyPo4IZeHb3ODtFKJqc9v56XR+AgFNF3Zmd+/fwi8RjqN6nZPZcOqhLpZzVvvZRZzJ5LBbAj8qops+xdm2PrstP+hutvLYqxYAufzJNFb1mGAu/T4sdQ7LVYDXEuwpB/ctw7tTD094PQ8kxFfcjBV+jIGN+MgYjcagM6i5Hrwtg2jS6rfj7MkTAAEmdCFefyc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(5660300002)(4326008)(8676002)(41300700001)(8936002)(2906002)(70586007)(70206006)(316002)(54906003)(110136005)(40460700003)(47076005)(86362001)(478600001)(26005)(1076003)(16526019)(6666004)(36756003)(7696005)(2616005)(336012)(426003)(356005)(81166007)(36860700001)(83380400001)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 17:47:34.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6894e3f-5ad2-4095-6898-08dbeab9f192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Cc: <stable@vger.kernel.org>
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
index 1e15ffa79295..75780c6feea3 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 	       regs->__unknown1, regs->__unknown4);
 }
 
+static int tb_switch_reset_downstream_port(struct tb_switch *sw)
+{
+	struct tb_port *port;
+	uint32_t val = 0;
+	int ret;
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

