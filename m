Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C37D5450
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbjJXOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjJXOtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:49:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62311EA;
        Tue, 24 Oct 2023 07:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUHvSrkzMveQ98inc/DKPGJv4sUGeCJOi39J53IVPNBBIBg5fHFsJ6Dq30xWQRxPHZpt/hvp1vnX9L2c7rmvacaCg86saOJhYOJHnHiiDL0y1eepn0Vx67AXi6El3OR5fSaFFeUhlkl7FKG6TbHXtVodZo73aa9K4acMVgV3m2WmI4HyLcAHNLWBTIllz7aIEr/mjvfWohtxsfyFul7t7U8s1615r0WBd9k30378AvrbvIBIUtxMIqP48XDxz+XroUt7+PVXxirChHXg17X85QRMaahhX2nxJUElmJX+1WmZ6lZhUXLvvQPoZtsRPAmyInR4HH8d6BZ/z662azJ9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5mxZsl5nBupaT0BEqINEAw8IzFWjrHW1gL5vZTnYD8=;
 b=a4p8DRNU3iq4lzyoPt+1+wqd9SXcBaUgLkUqJsCJudgZ/z4KzOqkah9LQgVlVmBQYVTyKt3Z7jdFnJ6a8Q5KwM4DVnRzLjihyvx90npP4/Id87gKDLhpWNuOskPs7fZ6UPiCGty40yZUQY0vXOuBf11+BVCQ2buptgNLAJZ4ovFUeLFKgdRg53a51HeCEVOJhLw6i3pko0YCSr8AZSfsSwh443sYfjYbNzGCk7uwUkbzQ9F+SJs0m6Utm0rYSfVuS5NEyarbQo+mZjN4a2eJxSrVqrB8xVX5sfL9da67JTq0gKW18ozDiIHCvz5bQDn6BHn/KjJGQJnT0ShvjP4N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5mxZsl5nBupaT0BEqINEAw8IzFWjrHW1gL5vZTnYD8=;
 b=iJ0yByExoR08trykP23UQAcatShGHmPMZQBa95soyEt08D6DN0kd6q1fdeqcoi2eQrubeqD3s6JAk7r0Jv1UYP7hk7WsG2Ps7Mm7U03Av7wxpDoBPZ/0uhp3PE8WKcD1uqcHkSDS5XnnFYgarVQILwFgOSjYiR2UKmbAVN/8Zbg=
Received: from CYXPR02CA0034.namprd02.prod.outlook.com (2603:10b6:930:cc::22)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 14:49:08 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::86) by CYXPR02CA0034.outlook.office365.com
 (2603:10b6:930:cc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Tue, 24 Oct 2023 14:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:49:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 09:49:07 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 24 Oct 2023 09:49:03 -0500
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
Subject: [PATCH V3 2/2] tty: serial: uartps: Add rs485 support to uartps driver
Date:   Tue, 24 Oct 2023 20:18:47 +0530
Message-ID: <20231024144847.2316941-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e7543d-5ecc-4627-f177-08dbd4a06099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipnS8qWd+XDnjvld3m6uEOZrbjc3UqY1pelJohWRhYYHMVc6yHvGtOJwYJkw/coWykIQmVV+DUulFU8nD8fovTryRaVBKsEcl4xf2RXeWgx16STnRnGYg9RTEoAxRwOkegjg2Il4N5FFRJd9dGeJka0Q70C5qXmc8P43oKXmOjj57F67Aaf6RBrabFkjiZF31BfTo89iM4bEPjGQqsB1KOjhPatlcN3iCgARRB9yv5Q2Ub9fzgWpW2/cRzIu+vrk20KQfGIOvjgzwm9TRbiHdGnywIJdGE7emDTSN+Lxra4XRODkkCS2MjOAfhQnrmTD7LM/RCezgWtxuU9o3aDMmizDLpWyOYWRXsab1BiBtI93XZsZwpTM+qDV8vLlNpLEOj/Ua3tR6Qh4sW+51g/+JptC/3P4zE0H7C4RR0aAX9D/bcVdcEEXUFN7YUZLN+AT+j7RTI5CYtTZqzcb5giCGOKk8EHpyZ+3KmIPIiZrnPGQ1SGsLnQuG0ZlXkaO11u1mWkxWT7js2Ljnzru46t/OmnKXfrIUMjoZInMlyG9jgvlewTKCs1rzFXO2EeWR27HEhMfX7GTw7YZPXtcE73SehAtEUnXzNg2GMpV97juhKhdtyebIYfwK1KlXBh+fGLHTJbnzZTamT1uanfIrNHuuggQEo1ZjCCLL3y1wSzxryh2KG0Wt5qEppS73H4nDHdJ3CwuHTntBFrNlEEEILXiqw/odzk9CbbSZlXm/AhM46NqF+sxfiiKoaOS1df6T1Z8405pltACBZXUGeH0yAr7UjBTedCUh2hshn+Yk3/AnaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(2906002)(7416002)(8676002)(8936002)(4326008)(44832011)(83380400001)(81166007)(356005)(82740400003)(41300700001)(5660300002)(47076005)(6666004)(86362001)(40480700001)(316002)(110136005)(336012)(426003)(1076003)(26005)(478600001)(921008)(2616005)(36756003)(70586007)(70206006)(40460700003)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:49:08.2520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e7543d-5ecc-4627-f177-08dbd4a06099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rs485 support to uartps driver. Use either rts-gpios or RTS
to control RS485 phy as driver or a receiver.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.
Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.
Move cdns_uart_tx_empty function to avoid prototype statement.
Remove assignment of struct serial_rs485 to port->rs485 as
serial core performs that.
Switch to native RTS in non GPIO case.
Handle rs485 during stop tx.
Remove explicit calls to configure gpio direction and value,
as devm_gpiod_get_optional performs that by using GPIOD_OUT_LOW argument.
Update implementation to support configuration of GPIO/RTS value
based on user configuration of SER_RS485_RTS_ON_SEND and
SER_RS485_RTS_AFTER_SEND. Move implementation to start_tx from handle_tx.
---
 drivers/tty/serial/xilinx_uartps.c | 180 ++++++++++++++++++++++++++---
 1 file changed, 165 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9c13dac1d4d1..32229cf5c508 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -23,6 +23,9 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -193,6 +196,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod:		Pointer to the gpio descriptor
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +207,19 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod;
 };
 struct cdns_platform_data {
 	u32 quirks;
 };
+
+struct serial_rs485 cdns_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb)
 
@@ -305,6 +318,79 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_rs485_config_gpio_rts_high - Configure GPIO/RTS to high
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_config_gpio_rts_high(struct cdns_uart *cdns_uart)
+{
+	u32 val;
+
+	if (cdns_uart->gpiod) {
+		gpiod_set_value(cdns_uart->gpiod, 1);
+	} else {
+		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
+		val &= ~CDNS_UART_MODEMCR_RTS;
+		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
+	}
+}
+
+/**
+ * cdns_rs485_config_gpio_rts_low - Configure GPIO/RTS to low
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_config_gpio_rts_low(struct cdns_uart *cdns_uart)
+{
+	u32 val;
+
+	if (cdns_uart->gpiod) {
+		gpiod_set_value(cdns_uart->gpiod, 0);
+	} else {
+		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
+		val |= CDNS_UART_MODEMCR_RTS;
+		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
+	}
+}
+
+/**
+ * cdns_rs485_tx_setup - Tx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_tx_setup(struct cdns_uart *cdns_uart)
+{
+	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND)
+		cdns_rs485_config_gpio_rts_high(cdns_uart);
+	else
+		cdns_rs485_config_gpio_rts_low(cdns_uart);
+}
+
+/**
+ * cdns_rs485_rx_setup - Rx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
+{
+	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		cdns_rs485_config_gpio_rts_high(cdns_uart);
+	else
+		cdns_rs485_config_gpio_rts_low(cdns_uart);
+}
+
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
+	status = readl(port->membase + CDNS_UART_SR) &
+		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
+	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
+}
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
@@ -571,6 +657,8 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status;
+	unsigned long time_out;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -589,8 +677,31 @@ static void cdns_uart_start_tx(struct uart_port *port)
 
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		cdns_rs485_tx_setup(cdns_uart);
+		if (cdns_uart->port->rs485.delay_rts_before_send)
+			mdelay(cdns_uart->port->rs485.delay_rts_before_send);
+	}
+
 	cdns_uart_handle_tx(port);
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+		/* Wait for tx completion */
+		while ((cdns_uart_tx_empty(cdns_uart->port) != TIOCSER_TEMT) &&
+		       time_before(jiffies, time_out))
+			cpu_relax();
+
+		if (cdns_uart->port->rs485.delay_rts_after_send)
+			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
+
+		/*
+		 * Default Rx should be setup, because RX signaling path
+		 * need to enable to receive data.
+		 */
+		cdns_rs485_rx_setup(cdns_uart);
+	}
+
 	/* Enable the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
 }
@@ -602,6 +713,14 @@ static void cdns_uart_start_tx(struct uart_port *port)
 static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (cdns_uart->port->rs485.delay_rts_after_send)
+			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
+
+		cdns_rs485_rx_setup(cdns_uart);
+	}
 
 	regval = readl(port->membase + CDNS_UART_CR);
 	regval |= CDNS_UART_CR_TX_DIS;
@@ -626,21 +745,6 @@ static void cdns_uart_stop_rx(struct uart_port *port)
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
@@ -829,6 +933,9 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -1455,6 +1562,23 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 /* Temporary variable for storing number of instances */
 static int instances;
 
+/**
+ * cdns_rs485_config - Called when an application calls TIOCSRS485 ioctl.
+ * @port: Pointer to the uart_port structure
+ * @termios: Pointer to the ktermios structure
+ * @rs485: Pointer to the serial_rs485 structure
+ *
+ * Return: 0
+ */
+static int cdns_rs485_config(struct uart_port *port, struct ktermios *termios,
+			     struct serial_rs485 *rs485)
+{
+	if (rs485->flags & SER_RS485_ENABLED)
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1463,6 +1587,7 @@ static int instances;
  */
 static int cdns_uart_probe(struct platform_device *pdev)
 {
+	u32 val;
 	int rc, id, irq;
 	struct uart_port *port;
 	struct resource *res;
@@ -1597,9 +1722,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->private_data = cdns_uart_data;
 	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
 			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
+	port->rs485_config = cdns_rs485_config;
+	port->rs485_supported = cdns_rs485_supported;
 	cdns_uart_data->port = port;
 	platform_set_drvdata(pdev, port);
 
+	rc = uart_get_rs485_mode(port);
+	if (rc)
+		goto err_out_clk_notifier;
+
+	cdns_uart_data->gpiod = devm_gpiod_get_optional(&pdev->dev, "rts",
+							GPIOD_OUT_LOW);
+	if (IS_ERR(cdns_uart_data->gpiod)) {
+		rc = PTR_ERR(cdns_uart_data->gpiod);
+		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
+		goto err_out_clk_notifier;
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
@@ -1638,6 +1777,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
 							     "cts-override");
 
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED) {
+		if (!cdns_uart_data->gpiod) {
+			val = readl(cdns_uart_data->port->membase
+				    + CDNS_UART_MODEMCR);
+			val |= CDNS_UART_MODEMCR_RTS;
+			writel(val, cdns_uart_data->port->membase
+			       + CDNS_UART_MODEMCR);
+		}
+	}
+
 	instances++;
 
 	return 0;
@@ -1646,6 +1795,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1

