Return-Path: <linux-kernel+bounces-29777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C8831344
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68BFB2487F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A613FE7;
	Thu, 18 Jan 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t/SGTNGG"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257B13AE2;
	Thu, 18 Jan 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563699; cv=fail; b=HYsVLHMt+RuvA8TBXSwd/2phqTw6+BJMoloXQFQOOyPUPaeeoufhrxQ3f1p+xb0iMXAHCwAHOXAd/vza5WPQ3IaMjuf2P55FPsy3wogcP/o/460W6GPyU9BVOpBgVsWppVUWxXcAJFwmeRuzLIgVt+NfoLLmVG4s7OMJDxv2r0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563699; c=relaxed/simple;
	bh=Jfk82G5jZVIsRBzCI9kWbEMHoWsswkAeeCpKlC9tKA4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=bozxohc7uBLc0VFfdRmKHWteuHiwgYyDYal2cla4W+cpUf3aMz7DKtErKJPxIW0l2eI9GthT6noTKMHGG4z1nRsUmyvHbeH4cvysQQZbb2Cj7aC+p67fDawFs4jARGzrbPoF6281aOZD/2B5tGqIDPMxIrJ030ywb5VLy/Acc8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t/SGTNGG; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AskNJ7P2LVeEjJyKjrRYpdQw7Ov84RFOrlp8QBzQm3WNbVACCxjHmnV141XkSvKNX9QbZ2Ty4L+ceDkWlZ06sfRR6vstGT4LVfAYdXTWvBHGCD+gH3eCbpRd0vdu05FLHhstXHIpiQBq8eMmx52GGBmv1kmfE8aDGdMzYosUIH3t4gJYYY2BibT17KryCCL8GdVlD0MaTUhwagDKzomAjw/8SHPvfbWm/mGuezNiW4reuBWbLS/v9gu4Tg5LR82OdiRRJc+c2uWKVRBJ9RVVmuWQhYOqz/iRrdR0OMe+AV9Qf0HCo4pLEse9ictTKi+TvM2NsPNtzBcwpGf1PuuNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhsPzBh3pi+yhDM1qCxOiNj//mN2kx6/5lR6T77hW5M=;
 b=hN4Mr0UojFEGuKqFagfpoIEtcfrn5QsoXUOgW9QDxyPBzSNIw3Mza1arfebs27QkdMoWPtG4ORRyCKuMBb1jHkyPbAfLM51XQhdHd5Y7exJMrFJN0f2WUlol4bX2eYbnhGBCWBV5SrFiJn1J3zxslntHktEES8sxDP/KYxrn517KelMN8ew0QNfNzXtzF/1xg+3Rb6xokfutXL2zGD+arTL0TvRVKSX8cTQHWZamTdgvVYD/Ei3bDAPTuDD+F/BerYhkp+FowussUx+rEvy68pcc0kehHgR6X/5mEz3Tms0UHVTTHas89EVBwcPvj61vP7B7ComGEQw8GnKATSVyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhsPzBh3pi+yhDM1qCxOiNj//mN2kx6/5lR6T77hW5M=;
 b=t/SGTNGG9rPMDgAYZ/NvARbXiitkbfFLrL0/V1Jtb+A0ho7QIWKJTI0ENRfBPdSnPQoPZClCeS43RsLbs+nYRwCvWbcvPmVrIDnAXbcz+1FIBLfFqZ2MkLiV1rR+UIWjvqnBYPQI7c3yfwJIpsST92WRPhdvVjEMGP1vJFvOi4c=
Received: from CH0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:610:e7::32)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:41:34 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::a4) by CH0PR03CA0237.outlook.office365.com
 (2603:10b6:610:e7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:41:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:41:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 17 Jan
 2024 23:41:07 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 01:41:03 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V9 2/3] tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
Date: Thu, 18 Jan 2024 13:10:02 +0530
Message-ID: <20240118074003.2334348-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118074003.2334348-1-manikanta.guntupalli@amd.com>
References: <20240118074003.2334348-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MN2PR12MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: ff127777-244c-4dc0-5d9b-08dc17f8e4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QOspj1Gbap2zxN38s/gpTk2yMIKO7Rzqg+PuTwRCyZjrGS6wTiH9HjW7rECtiMRs1LY0XDXTZQ7Wqryt+GsnitIroynKg73xiZ6NJ6+8ec5ICfj3ZA6R79EXXIjZAGMPPu09Q2u4f8Kb6cT4H3uXS8UGqE409HRk65GTIJMXDd/U7JE8FXdII4EEDy3wUf1eEPmcR3mQkiskM8g2o5nAE+G6C6YfMw4v+2dBhUVX2b/lIKqW8dyD3JIwLxV8wAu/Mvl2pJuaUwLteJRhBxvl65Zr7ke/8hyIOTFXSpqZBtX1YY0aBcuOzH1yoixRsilnUamEnMwX8YHf8CYh23cBMtWCpZdx19UnFBI1BM5X8PXWlReeVxQ0q2gOEa1Fp1RtozqSO7tIb9qcL8KBcCfhDPXhFhrw/OAB9eBZVIPmzhQaqMHl7+BKkAi+swLlPShi7wkHZNa87XYmV7jN1trvhFjFIELZWCqzlm5jn9liZV98d7vThhQ89dafzFlYa02KSFqyYwzPLFFK7/pX72rD2CIxHs/NwFbwqz8rIJCN9gCKWhtp9WiDFS7hxCIoZQ6fclhZf0vLbvAJqowczCnmU7llTXjwgOn3xdnAW00ohIUb8HABxOfFWrp9eyorkPWI7pXWqMtgRgndXUkPYOO6vq+/TSf4JjqmQ035m/K+X9bMcIRtrmOCQgvHWAEPcqjStk7eHA02/9kJVX86G1/QxxVcLl1rRZy5mg9jIal/BSxzwfS7oAGzMiIcTYNUOCzivSgCs/4cXo4S7Vr8BXAXhvPA9HwKpkTbd8AJkmPbE84=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(26005)(86362001)(356005)(81166007)(478600001)(40460700003)(2616005)(316002)(41300700001)(336012)(426003)(40480700001)(2906002)(1076003)(70206006)(5660300002)(70586007)(54906003)(83380400001)(110136005)(82740400003)(921011)(47076005)(8676002)(4326008)(8936002)(36860700001)(7416002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:41:33.7241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff127777-244c-4dc0-5d9b-08dc17f8e4d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501

Relocate cdns_uart_tx_empty function to avoid prototype statement in
rs485 changes.
Update return check with uart_tx_stopped() in cdns_uart_handle_tx().

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

Changes for V9:
Update return check with uart_tx_stopped() in cdns_uart_handle_tx().
Update description of cdns_uart_handle_tx() and add clear TX Empty interrupt
comment cdns_uart_start_tx().
---
 drivers/tty/serial/xilinx_uartps.c | 35 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 920762d7b4a4..787c7cbc6600 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -306,7 +306,22 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 }
 
 /**
- * cdns_uart_handle_tx - Handle the bytes to be Txed.
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
+/**
+ * cdns_uart_handle_tx - Handle the bytes to be transmitted.
  * @dev_id: Id of the UART port
  * Return: None
  */
@@ -316,7 +331,7 @@ static void cdns_uart_handle_tx(void *dev_id)
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
 		return;
 	}
@@ -587,6 +602,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	if (uart_circ_empty(&port->state->xmit))
 		return;
 
+	/* Clear the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
 	cdns_uart_handle_tx(port);
@@ -626,21 +642,6 @@ static void cdns_uart_stop_rx(struct uart_port *port)
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


