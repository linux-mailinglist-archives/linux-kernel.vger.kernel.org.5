Return-Path: <linux-kernel+bounces-3265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB62816A15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EA21F24AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D6134AE;
	Mon, 18 Dec 2023 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnE1HVuh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E6134A9;
	Mon, 18 Dec 2023 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I//G7hyD5rRglomuKRSr4MOuKSXdIMnuZ6cNzwO708mBvP9Z3QM9cphI4paM/zrp93NkNcQOaMcnv9PMff6OsODUO4FyApNvbGHi2QIU/mFfX1fKU8P4zo+2e1qlIljitwVZijxp4vFsatvYZ9HLGw0AEBo/jmBUPSkG+7ldVBBG1j4ZA/maB1VyGFsdZHJZNzgu+W6xVblAPWYmTqJk8uweW2TG1Uys2x2JY7hi9Yz51iL33TuYkORttIqMPITUiLsFD5yFZkjDYGPa2zx7HmnEWaLV84jdi3AfKds8bQzvGiApx+AWZAvP0yx+mzlPGeXV+OJxNwq882oBFZD5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yA8w1IE8qRpYbPMWn888NhB54CMgVSX/1uZ5lq1Y6g=;
 b=eJb3hmx2jmLL0y7puBqul1IvfuLlHCAz96rK2o5BHAcH/se2BpxDX3LHaFzWMoaFUAAq+EjcqgzoQEO+iReShkZl/NaN0z6KUnV1Ff6qYvn7cEn5/quAU/hUcPAVjBa3qwkhZZfJw5fVvX59BTFNXF7j0S6oz4P5OiSM/OEOqBL1y+BXl9n2wTRmJpF1ba8h5CNziKdlzFx+Zu+uX5q0ue5ap2Ztr4Glm6aZWaM2vhZcuYmKBwaptfIwNWR2Mp9iPvOVbgvefh900xibF+q1lLM4Vlb5fvRtO9FpTY/sFuEHu1W1qojCfWXgHvqAFKx2HvUVs1pkm/n4mkgwp0Ig2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yA8w1IE8qRpYbPMWn888NhB54CMgVSX/1uZ5lq1Y6g=;
 b=gnE1HVuhRZed0ApvmIYyYz4YN22Cz2dzdAC1L9wwpDwegVHkm/Zvhg+2aNt+SZGLnjR4KxwRt7/YJ693RnCEa7haYkJEcJrRmi+lm5DnOCKP44fzuXWXFgnRMeK1QM7N+PErzHps5OVvMPBhGQ0OpvBefgOYoYSon09am8VChn8=
Received: from CY5PR15CA0073.namprd15.prod.outlook.com (2603:10b6:930:18::21)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 09:44:34 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::c0) by CY5PR15CA0073.outlook.office365.com
 (2603:10b6:930:18::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Mon, 18 Dec 2023 09:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:44:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:44:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:44:33 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:44:29 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V7 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date: Mon, 18 Dec 2023 15:14:14 +0530
Message-ID: <20231218094415.2503672-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
References: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 044c168e-74c0-43f9-e28a-08dbffadf142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QzH8NacNkFRijCDDA7WSsC5LWgTJwQqEWZ2o8q8C1yS/uWC3PnbXnKWtp1dcXi1MwtdDQ/C1BQQLYYFjy69wpV1ksU2XeXQqGOOiK8N/qlQugDcOKW36cQUtHTp2N1CpsR1v7+4G4VSXqAtU3rCCtMqMfN7fonkqFkwRg8LRmpsKnC45+SvOoYYAUOuzd2DeKPSd0zOVkI8pSmwkIVLClZW6sORV3sU0AMcRSeY/drD55r6VDGUNRU0PhSA2ZVQF2A/qGdV/ylwQR6+7FwFy0ycR0V0xYI4AUJphK1K9nD/t3bbT5yhH5/6zgUbLc/clbfM+rmAFcWUEd69y/sna/Y8Xjm4qRv/8K5zyadV2zkyF9TloeETVHupaGKejcZRnKo96QKhT6cTBwFRcKo058xx6k5JWylIHjuRBy03XlxDoa0U6Xo334emJiFU/GFEN5vICr7RcdSeB6hGioLs/VkE3E3X4liEmG/zdqJoQKK3zkPyU1DkK095z9OBS0o1wYn0nGpNe2JVT+ETrRMLAuCYPMByd6p4SRlp9gCpYqysU0cIX9pjJFjZE5pNyXpJQNcCE1Ci9Y3BXsQSzOaZnjgUbUTS5m8jMKoP+JcS0kzRPU5S3Mjrt0TRLv++LuElLgdXb3d6KuiMMJauLc03qir2MvdV8rTiWvmSwsgYxnHLaC2fWbRsqtWJlOmwU/bojL+gnV5nWDjMwqCzMPcFaGR9xrznBHO1ZKDEgMMu7P+EvvH2xgiD8kI75SuSLEJXkEf++vhEnOEAHVs7SGLikcDbnQw6h3t6s0Rd8XLxw9to=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(921008)(40460700003)(70586007)(110136005)(8936002)(86362001)(81166007)(356005)(82740400003)(36756003)(36860700001)(83380400001)(47076005)(336012)(426003)(26005)(2616005)(1076003)(478600001)(2906002)(54906003)(8676002)(6666004)(70206006)(316002)(4326008)(5660300002)(44832011)(7416002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:44:34.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044c168e-74c0-43f9-e28a-08dbffadf142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

Relocate cdns_uart_tx_empty function to avoid prototype statement in
rs485 changes.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes since V4:
This patch introduced in V4.

Changes for V5:
None.

Changes for V6:
None.

Changes for V7:
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


