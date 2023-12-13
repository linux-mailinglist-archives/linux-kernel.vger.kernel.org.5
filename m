Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108B0811245
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379085AbjLMNA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379080AbjLMNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F1136;
        Wed, 13 Dec 2023 05:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW3UNcJqMIds5RaynhI1QJrhH5bVed+hlPVfkG7U/GX6Ztq4dUU/LP0/xIFtmqmyGcTd/gHLSluln1vF5kH36iHqPu13AA4IMdpFEFmgUuL77JIwIiPr8GD+SG31PSK1dzthx9kmtvPbuf9TJZyzooW/q0xSxyyWm/j0r0Q0seJanDR98DA6vr0O0nlFzuid88RT+w1c9HB6NE33ZVkkyN7SSqzenrZfjFmrGA/GHDcxolHyvSwyuZYSF/mX1k+QfDMyCGV8uX/l8AzoXLQoYn6J0nVT29RpTGG4lzSOenRRFczn/xnfv6DnzLPusYIJ18OOWO5RZTst6ipaEYXeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JvHfbXpkN5D+JpsL3NdBblQK/7zQGW+RUOvBT5szgE=;
 b=aZLJ9OucOxqioTH2mWnNSHGwxjF/v8wUtSVyUOYcuI4zgU3ClAQ+37JY/r3QLJlZJ9GzAe/Y93v33S5JlvmiNCK3IHwXL1tRudJcppfI/PL7JV6rWwiy6F8fHqNct/LQpKvVBFqAThxWf/0PckFNoLBhlOZah/+Kd1YDnAtC4er1SRawdKoqQfKzVpnfo2PDg+Ls2xBQ5kY1SMoDiCD2WL6AoApNTxykKlgVcj25/OGcRpUpqnv8cN1ZfqW2iPcQcS6CdNHutqDT05Odur2Uv3pIqBYcnwHoHYVrf16EALYxpoxHhY5tC0PDVnFy6p4EsFg/4sgMMGxOMF5rp4cumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JvHfbXpkN5D+JpsL3NdBblQK/7zQGW+RUOvBT5szgE=;
 b=IPtTA5j9qmL5S+gIosxtIg3rUvobHnZZwAPdeUGvDqxDtvNhbE/n5OpHzn9l+rGhohiwlfkrlQLzOKlfyMth/PPPnGK0eUWTrYl9tCXwymdKotHwNAhLNUP1w0OIQKGJJRlLZPp0VigOeYbvcEq+4lMe8fLIQDFo95nLYdQMAKU=
Received: from MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 13:00:43 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::b8) by MW2PR16CA0058.outlook.office365.com
 (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 13:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 13:00:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:00:41 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 07:00:37 -0600
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <git@amd.com>, <michal.simek@amd.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V5 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date:   Wed, 13 Dec 2023 18:30:22 +0530
Message-ID: <20231213130023.606486-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
References: <20231213130023.606486-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6d640a-6fba-457c-441e-08dbfbdb83c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sp3V3PpfyBNviPXCU9+Zg+fpIjAidXFe/RVuVsZjg/FLU6VQio3o7QHEmPnOGH2prvimvlZb+mcf3ExQgalLv2dz3giq9vNKE5BcuHDYiQQCbF11kcg5yep6BmfW/cr2bRs5pRVCWsMXqZ+cFrrWiD7a8UO2pElROs5SQ4f0Yi6j35R7m52LH34S6i1v5JC9ewBHH0CaodXZZyc/ezCJD4YO7RnvnIcYi/SOkybU6OeCBMKpAa9Seu2tbkH6d6vL2C0tNC0JIPIRJET/bfkhH8g7sjy30qXRF5fnuL+dErJyvNGAtZ9E5yxr9Zpfkiu15TxOZ1pXNs89QqplJFkCZMS2ohfxqg1l3lUfWnn+NgWr3EDibbE0pEB9k1AjC5TuvB3Q/EhWUyu5DRgHAXb/Csncg7fMuFylFGOOD//o+qe3MfKq6Pqgk+za7HSVjK3TkvUQZkpIHFYNVsSKIquaBU3FlJpdwBbPHfTK6+g77ky6rhQ1d2DoI8f34fmPZRPDeNy5TjfzBS+G0aWhVgZ+pwJgCIINTcHt8/1SxTPRA5Thde12yLfYH67csSKGerPxqsAUKztXB5kAZwugJt/qeU8raBzM9S1Fb6APd9cmXuHq1+De1/T2ZNjQxzYhhXc8S9YwoAlUmC2HvL6E5XdZ3NL+kEVWrnwqvx+tqyKPvxGBEZqV+uenHUCC5Z1/wiNkIQm6B0d0VvpbqTBlfGXkUTe7lxJgzXkCt1TkiGcSbR5nl3JqIl1DxydebHdJU8UzPaoYBRkISHdX7VuEQWGaAE3tDsyAnkBQknOzhcV6e1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(1076003)(2616005)(26005)(6666004)(36860700001)(5660300002)(70586007)(44832011)(4326008)(478600001)(2906002)(41300700001)(54906003)(8936002)(110136005)(70206006)(316002)(8676002)(83380400001)(47076005)(356005)(82740400003)(81166007)(36756003)(7416002)(86362001)(921008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:00:42.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6d640a-6fba-457c-441e-08dbfbdb83c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate cdns_uart_tx_empty function to avoid prototype statement in
rs485 changes.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes since V4:
This patch introduced in V4.

Changes for V5:
None.
---
 drivers/tty/serial/xilinx_uartps.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 920762d7b4a4..aafcc2179e0e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -305,6 +305,21 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_uart_tx_empty -  Check whether TX is empty
+ * @port: Handle to the uart port structure
+ *
+ * Return: TIOCSER_TEMT on success, 0 otherwise
+ */
+static unsigned int cdns_uart_tx_empty(struct uart_port *port)
+{
+	unsigned int status;
+
+	status = readl(port->membase + CDNS_UART_SR);
+	status &= (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
+	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
+}
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
@@ -626,21 +641,6 @@ static void cdns_uart_stop_rx(struct uart_port *port)
 	writel(regval, port->membase + CDNS_UART_CR);
 }
 
-/**
- * cdns_uart_tx_empty -  Check whether TX is empty
- * @port: Handle to the uart port structure
- *
- * Return: TIOCSER_TEMT on success, 0 otherwise
- */
-static unsigned int cdns_uart_tx_empty(struct uart_port *port)
-{
-	unsigned int status;
-
-	status = readl(port->membase + CDNS_UART_SR) &
-		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
-	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
-}
-
 /**
  * cdns_uart_break_ctl - Based on the input ctl we have to start or stop
  *			transmitting char breaks
-- 
2.25.1

