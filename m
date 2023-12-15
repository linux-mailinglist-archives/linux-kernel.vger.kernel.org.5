Return-Path: <linux-kernel+bounces-964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657518148A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84D01F24273
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D202D7B3;
	Fri, 15 Dec 2023 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2l9i0X6I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56C2DB6F;
	Fri, 15 Dec 2023 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciHtMz+J+1sX3H7nzpEwrgbDGLczhTvKtpKEA4orvWPwI9KTXZpWFpvs6AhfwLJlbZV3C3bInU2DbZnLe4h9AAahG8WlOqO9o1088IYAYo/voN+LhGH6U/kLe/D0GiAjjR4bCRUi9teeNUfiB9Ge9guDdEFoaBQpnUbmyLJ+Gh8+pJUtL7Hg59di9/Yw0b9/s5jvawma1KQjVTBJvTYkQjg0lv8nbpgVybUCBFurz2EoX8wbRYoiCnHrHYk3sZ34SqMAKX8rbBGiy2lK/YFQXtZ+c92rjocmceJzbockb26SwiatmV0SyTsAayeCEr0D3yCNxYt8BH5J0oHmjbi/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEZyYRkcFpu81Kr49e+lLK+8Va/GRLlXHwoDw6ZNMnc=;
 b=mRgZLJJxI3XrOPMTe0eTaAChI1Wz99uu8lb6zUtnn77yMbKsQBHkR+9XLNqZkshtNMQxNluicJZ9uy9S1MM/8g5EnPWvW5Q3VUqUr6KjXbqIuw1RYwznn6lSf8n0WYPEWkBHjNQVPCjguWnmz7sXC0bGGK2S+lyHUzVZEwTZ8vqxWCDSPqaoiUnVpFYXWMkmufDCP7DMHnjZSmWeVkQICXNBJX65g86RVP50dNDW0+6ihSvQfpj8kP6Jswj9K48+Y6yK7G+sYHwKKhoOJhP/2BSMX541CTz1sKD6radT/4gaT4FVlH3NJxyJk2DyV/DkXitvpp7xOrQkaZJkmX1wXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEZyYRkcFpu81Kr49e+lLK+8Va/GRLlXHwoDw6ZNMnc=;
 b=2l9i0X6Iure2Oa8RZjgwJSdPwOgYo7Wppnc5mJY+PG/Hk0F/YeLjgrslA6TM8/74tFQ+CxvxBOfniHv0Ni8RyH/HKXe2FIH5E9WeBF7B2oDPjnPIp9sp8hph7lnkVx3V4hVFfBxJXxMEl5U6qfeTsmt0Tc04nggrMtnI7oBIhFo=
Received: from CY5PR15CA0205.namprd15.prod.outlook.com (2603:10b6:930:82::23)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 12:57:24 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::d) by CY5PR15CA0205.outlook.office365.com
 (2603:10b6:930:82::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 12:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:57:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 06:56:52 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 06:56:48 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V6 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date: Fri, 15 Dec 2023 18:26:26 +0530
Message-ID: <20231215125627.1691573-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215125627.1691573-1-manikanta.guntupalli@amd.com>
References: <20231215125627.1691573-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ab060a-3dcf-4d21-bfc2-08dbfd6d61da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8lUVB0LX41EZrokY4kKvv7TP/+QctcT9VpnOSGrgjDZNv1nYNZfwgPNZfvK8tcIsqPOTkdgQ2df5hwYMG9o6FF4cEIJAuwIFyu8L5MCWnMrHi/CdXHnnS6+cuxZ7xqLjolgrfJ6FtFqM7+cb+1NmT5ibDAJP/j/VjMHvmMSjHAb/8DVnFQfvm0kOfB2VFCo9xoIpVk6NHgvjVxG7hlyvSrhEzH8Yu2n/TH/Jo4S5tFpHoT7oWq9NH/hripkrhz438GFUYWdNPCgMq+hrX5KppdPu5kQ74ARvZTOd2H6ad5xb+HbsOq6UnntF+Fc86sKBC26IxKc12uwDDpEdSjtsdyL2w1ePt3p+6BKC93qiblaQ3ZsndSCgI8XIkox+8n2jCgAGISVanmVZyOxXUtYIdCjhNx7XfLti/temMkBmo4cxwEXYSia6zkYEZmc0P917+4i2sMT4V095/RDjuu7NjLAL1mqQ/rRi8wXDo5GH2xJvOnGuegJTo5KfTV+18baVr7NAG5SGSsJRA6TB/1rZkIzbqaWzCU8N5V2/oP4dm690JoQHmaMPymLrfOR9cQxdGB0VUxRFBhR+3yDjEtPKPwnbGW3iyYuxkyVlXQQF7lR6AZYS5i0jhflMI3LbhCmHXDNaf4SP5pxJXoFWk4LNUAWMX0cc0UVskpSU1KK0IjozeQj5K/2+zI+AFYGo4QczTxJ49lTtPwFatUIS8A1MeBZmMJQuDpXTYiLLFYxR2cEmFfZXd+plyaU5mmVwBIupRqfzGSoEupT+9nOEy1OSyZ1kzOQiM9h9tjcKj1uCj9k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(7416002)(921008)(36756003)(5660300002)(83380400001)(336012)(6666004)(426003)(1076003)(26005)(2616005)(478600001)(54906003)(70206006)(70586007)(41300700001)(86362001)(110136005)(4326008)(8676002)(8936002)(316002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:57:23.6951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ab060a-3dcf-4d21-bfc2-08dbfd6d61da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801

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


