Return-Path: <linux-kernel+bounces-22051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28E829876
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E511C25031
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CC47F61;
	Wed, 10 Jan 2024 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zn0iNtWW"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796D47F4C;
	Wed, 10 Jan 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBVGXO3fspjm41Oii85eA7cPCOC5r6Ff6XJz5OVjS9riNHet4MQdGwBp2Ibu8o+AfNHrH/HbJPneVLw9QzK6GUFUIKG2JOyX8Mlxd+inzr8Wy7IDCyurwujyGb0KlpV3qoiY6dOoMmPFoReuhOFDB7dPhFHWwnfiSoUJkvLkICluBPeB4IKYvu5ygwb5eubcki5F/eOqRt7yTWfipQLp+pDcSmoz6FquN+YhOJoDFyZiBwnRonQe5nft5Tuci6fyo5xD7sZYsC59CVTElZ6OTPA+kr9N4k2xBS9vdEMrgGyu0mXKj9EoHz1oJYyJMusOldc/PVb+J8DYoZ73PnSR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PggO/CIE7RzqqtiQPmq1qBWNVywZYffCBedCKdYKkuo=;
 b=AosOeqi0tUc9Z3M41DA7tPLzL6bS4e3tHkQU5vX72u0wA3fTipHxafY4wLd8yEvn8+4hjkCAQc8WNS2Tlt2vq3xplMI7cDo+ZnyUxR/PNFjfjdkAUBeAAS7pzJa+RKonJoJBnloU+sEAqprBuTfSefOAi6na/VO127EXllpGXopFDEAntQb+NIQpOYc9KrLIitfGZzoKC8fV/jsFnAOLufxf/f8JsEJRtl9lCGYmw1hMOXio78HMWXRFmTHPs5oLbZQJZOnZHsP7psqHW+hS0tGeL6jcDR6cF6Tww0FRpLV5HhgolglSh3rJFV1eXVFdVOojZrgyk/dT3EtBIQFmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PggO/CIE7RzqqtiQPmq1qBWNVywZYffCBedCKdYKkuo=;
 b=zn0iNtWWvNehAyirBDRhn2H7E9sQDQZSn9c2UOwpzaGSJ+uM3ctTENATB271DZnqCG2iGDRvsn5M+VEc0rTjzho9lEaX7xs3LP+9xo4F154Otm+xuQysl0e2owohdbAm2NyTZbXMRW4dKS7UXgg2wtYVybECx+1OEo/IjdG73Pc=
Received: from CY5P221CA0125.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::31)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 11:11:58 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::70) by CY5P221CA0125.outlook.office365.com
 (2603:10b6:930:1f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 11:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:11:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:11:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:11:56 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 05:11:52 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V8 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date: Wed, 10 Jan 2024 16:41:06 +0530
Message-ID: <20240110111107.3645284-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
References: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a06ca67-5565-4cde-a2ba-08dc11ccf61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4w9xn4qfVTtmzTmW9iRMuMFZP0dXeiEQlHJ5Yy7+3LXoCUY3VZvlP4Uu6ChK2gPBx8DJ0BQQkUp0Tw4QAGJgkJOL7ztX5vpHRRWyp9WwRogAa4LyNqmyD4IYZpfiMaumA9Vwcml0+GWQ3dkP9K9qX/7MCJnpoUijXporrvXI+zPcYOK+mnZAqrlHTkVHQ/LcKzZE//ee7yYKYT1g37keThXxwtyHBZckXENmVyjXWJYQTyygvIijw5jUK4pnuwVM7MWgbpHNg5QE7cbWiH+/zH/kVXiZ9G/NCB2xyoY55fU0S1U92ctS1e8Qd8ECdTSt9ZFGZcmpfcU/p9kHgwlFzBQf5W4bhV0/WxvMw+b0kWuaDxOS4ak+5IYmpAu7bDAAOa8cX+PjeEBGosIjkxAn+h/G1zG0UwGfV73Xb0jJBCafcz3AgrMXoXSKKGpeJBEVArxhCvOzepCKLf1wzeO+dIMLjAr5+tk6XUN3k5px0RNbAwB434pRS422TB5NofcgeZtiHpYh6Xo4H30MLsAXijFeLkYGE+Q+0UkWXQXW+VTpVi59zsi11eHhvQg06F7yZtN9MbyV98AQ7XoBUfejpA2+AjNSwWCCbuYhle9A01z8XiMkI1zhHfUhB8KJI3He66cInlFkjYSlqIH58rEcO8ZcQpJJxdgb+VV8i0SNWHrGvMAwJsLz83tCWjLVyMKhCnPsvAAMWUsRAq6alY9socreESOga+eOchQGklQPXyyA/YBN3L1Eg2Stc+9HpizJZB107FeKkZiIP/Tq7mZCsOGYNE57H6hkz1ICNGkyEzg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(70206006)(70586007)(54906003)(2616005)(40480700001)(40460700003)(26005)(110136005)(316002)(44832011)(8676002)(8936002)(1076003)(4326008)(83380400001)(336012)(426003)(6666004)(5660300002)(2906002)(47076005)(478600001)(7416002)(36860700001)(82740400003)(921011)(86362001)(41300700001)(356005)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:11:57.8615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a06ca67-5565-4cde-a2ba-08dc11ccf61a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195

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

Changes for V8:
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


