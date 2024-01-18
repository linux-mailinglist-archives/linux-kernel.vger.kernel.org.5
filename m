Return-Path: <linux-kernel+bounces-29775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91C83133E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D441A286504
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E2BE7F;
	Thu, 18 Jan 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OLsaaRpl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77DBA3F;
	Thu, 18 Jan 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563690; cv=fail; b=ip2Jhi5xpq9N9JfPRWGze9HRjRXyxPENCWlmDyJhnoGxHLpVbjhOBbTxPr3do73bDyvuLZXc8G73WlEGB8jrcq8gc+kJOSQ6ku1G0ye9oBz9iTlzXxlLV+rHpYNoRXj7xMWQoyonjog0L3VG2mh+059/Fv+5QQPOHdKkxLRcR6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563690; c=relaxed/simple;
	bh=wFCrcFQndFaM0uwDAAVR7sNNv7beh4vFm28mu4apZy4=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=h2DL0FxOvbJrQM2yHEHi1I+cupBxqcLDCXoFaejyF5ReucD7CE4bOiCrPXzDXJvaBaWkBkJAdY6r3g5pWJp4O39ZdNLkZhd9JUpj5NH6e/zOe8pTmWl9cRjepC6hybXBOL1K2u7T5w1D2ipFF1ViBWtufY4d2x/gTH0WLBqU3OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OLsaaRpl; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5yMuH+WfWmmijOm+v0WOp1z7TGitYvjhCoBp/IPVu9dhMOhFQTFLpxQ+ry25odiXd1D625KsMdGAV6JJQFD5FdcBLbQEXqPaK43KUdpb9QmbhFA0GQyauA1vkNruGsOKftDYYPkfpLRcy0OgcarNs/6bN1puNoK3sjI41MhwhAe5knTX/Xa2ViJZgcx7brO2oaM/vKtTBj/Wk4S2jUVc3RFhD4gYADQT8YWFhBA2VYdiFqe7c9InQDutKlYQLWFQP6glweMlkHc+zgoE2rZA3xMubTmVhNY35ITw3GHRAWylgD6mgrS9tDNOZwS6Yx1L8xt/1uIDiOz1TcmFqtz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0R0b/68K3XuEVfQBiOCyt/q5AqIzJhnRyV8cytIM0A=;
 b=jjQvJAK8qjtfq+DGRJ9OZHjjhGlez5h62uW4xBHFHG+f6UODJ5DLsmRlA0+Bpf7MEma4vrAdo0sn2pOTKqpV7HBcQpk6VbXUELByTOQt4UO3CSTbmNMjx647YlSoE9/GarrYGEHIA4umJx3ZYRaSDZ6/oWSK4b/PNvm6ED3Fb4bb4Wc56j6hyzhQ7z8D8zE/J140/wpSRbUJwNv9wTf4H9Cq7A1pKkDVC0aOffeQqdNfLtE+pQBUsKwFC2Dduxi2XLa2LEUM7Og5wmUMF+J4fCS0uVqHfRvJrXWmgGdDGiYkF+j7ZWb44pcnFOORHtRrbPGrWvcjA62pHNGirghDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0R0b/68K3XuEVfQBiOCyt/q5AqIzJhnRyV8cytIM0A=;
 b=OLsaaRplKVpvbLaY/4SsRDPpbTcw2HT//V3ewJqTbPsnlRBsBGcPZRQRnkVm1D0Zxsu3qM/1QC6kuH/vGGlZpUCUaHETwKiZZybemXKW1DkWZl97PqHX/pPxwEWltkQ2QLrAAU7sGi/EBbNRw3pW1XIM731WCKbyjk7FUA4BjqE=
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 07:41:15 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9e) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 07:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:41:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:41:14 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 01:41:10 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V9 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date: Thu, 18 Jan 2024 13:10:03 +0530
Message-ID: <20240118074003.2334348-4-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ff1455-7ea0-49e0-aa57-08dc17f8d9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zJ4zpVnwhrNNBP4lSkDBO6KxfhSrnQjdrMm3wGKPhuqY9gBbLcKHwi+JElDEb6Xo7smOeP9mZFJsahJeTINpD2KC8g4x+kCcoXgOYwQR1klYVowVDC+fRsFN7pWSGcP+G1gVcqkNWaKuKgeMt7Y3O5SEzP3Tule2iGaBceY1oAnx7AoqOzM0ZmBLZWTdbUwVF0ez78G8bZI4Y+DuN9AfszhJQ5BfvuRS72V/JjSwQbbXtj2QdEtI4rzObWz74hEVKk0kKJKafAPEuXgRgcrKzGGApfYXxt3GzSmEsvXmlvstt/7jKoYc48Agoph0jT3wfhU221d9zUwPZMd1YPYsqTHWO0NWtMRYPrJNLrmA3EXoCP8X9qkj/HwnZjh3EU4iB8USNQkYTLhrVTcZbBHHYj/kKZbvizAP//IQIpEnhktOJVpj42KTY75UfFX+sdWv2j6s8oFkbzsCeMCs7PsrqWwgB+jzS1GMUK6AoHuyRIkV/qzRfj0Sn4MC+Y4qRaZxCwJWkzEHBLlgi92GYGlpq4RMjgsmHuTf1KEpmoOcRXtNGeXdds8dchOk/SoBXFO3Yn7XStGbiHRNLXPXR/RrDXwzgs3Y1565uMRsM5of6lxUervjg5K+pgsuY6HiXX2YTgDied7m9USGo4MqALQHqn+42bf/AsUl3yWWs2ZKfzpep8Zp21SuFSCMvDi94CqM2nV0dKMHFWPh9MeMAfzO6s4uQwqLU86OV3MgeeQu1UV+3rBe0xrx2I5RsZigNtzZcyia+sMPForBrNfyZwojVkGp91ZydE68OJBJ/FT5P7c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(82740400003)(30864003)(41300700001)(86362001)(36860700001)(356005)(5660300002)(2906002)(36756003)(7416002)(81166007)(316002)(2616005)(6666004)(70206006)(110136005)(70586007)(54906003)(478600001)(83380400001)(47076005)(44832011)(4326008)(426003)(8936002)(8676002)(336012)(1076003)(26005)(921011)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:41:15.3724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ff1455-7ea0-49e0-aa57-08dc17f8d9ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

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

Changes for V4:
Create separate patch for cdns_uart_tx_empty relocation.
Call cdns_rs485_rx_setup() before uart_add_one_port() in probe.
Update gpio descriptor name to gpiod_rts.
Instead of cdns_rs485_config_gpio_rts_high() and
cdns_rs485_config_gpio_rts_low() functions for RTS/GPIO value
configuration implement cdns_rts_gpio_enable().
Disable auto rts and call cdns_uart_stop_tx() from cdns_rs485_config.
Use timer instead of mdelay for delay_rts_before_send and delay_rts_after_send.
Update cdns_uart_set_mctrl to support GPIO/RTS.

Changes for V5:
None.

Changes for V6:
Disable the TX and RX in cdns_rs485_config() when rs485 disabled.
Hold lock for cdns_uart_handle_tx() in cdns_rs485_tx_callback().

Changes for V7:
None.

Changes for V8:
Use hrtimer instead of timer list.
Simplify cdns_rs485_tx_setup() and cdns_rs485_rx_setup().
Update argument of cdns_rts_gpio_enable() in cdns_uart_set_mctrl().
Add cdns_calc_after_tx_delay() to calculate required delay after tx.
Add hrtimer setup in cdns_rs485_config().
Move enable TX Empty interrupt and rs485 rx callback scheduling part to
cdns_uart_handle_tx().

Changes for V9:
Remove stop tx timer.
Remove hrtimer_cancel() call from cdns_uart_start_tx().
Handle gpio case separately in cdns_uart_set_mctrl().
Move hrtimer_cancel() call from below to above in cdns_uart_shutdown().
---
 drivers/tty/serial/xilinx_uartps.c | 200 ++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 787c7cbc6600..c44c77b3e54f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -22,7 +22,9 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
-#include <linux/iopoll.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -193,6 +195,9 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod_rts:		Pointer to the gpio descriptor
+ * @rs485_tx_started:	RS485 tx state
+ * @tx_timer:		Timer for tx
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +208,21 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod_rts;
+	bool			rs485_tx_started;
+	struct hrtimer		tx_timer;
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
 
@@ -305,6 +321,55 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_rts_gpio_enable - Configure RTS/GPIO to high/low
+ * @cdns_uart: Handle to the cdns_uart
+ * @enable: Value to be set to RTS/GPIO
+ */
+static void cdns_rts_gpio_enable(struct cdns_uart *cdns_uart, bool enable)
+{
+	u32 val;
+
+	if (cdns_uart->gpiod_rts) {
+		gpiod_set_value(cdns_uart->gpiod_rts, enable);
+	} else {
+		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
+		if (enable)
+			val |= CDNS_UART_MODEMCR_RTS;
+		else
+			val &= ~CDNS_UART_MODEMCR_RTS;
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
+	bool enable;
+
+	enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND;
+	cdns_rts_gpio_enable(cdns_uart, enable);
+
+	cdns_uart->rs485_tx_started = true;
+}
+
+/**
+ * cdns_rs485_rx_setup - Rx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
+{
+	bool enable;
+
+	enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND;
+	cdns_rts_gpio_enable(cdns_uart, enable);
+
+	cdns_uart->rs485_tx_started = false;
+}
+
 /**
  * cdns_uart_tx_empty -  Check whether TX is empty
  * @port: Handle to the uart port structure
@@ -320,6 +385,37 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
 }
 
+/**
+ * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
+ * @t: Handle to the hrtimer structure
+ */
+static enum hrtimer_restart cdns_rs485_rx_callback(struct hrtimer *t)
+{
+	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, tx_timer);
+
+	/*
+	 * Default Rx should be setup, because Rx signaling path
+	 * need to enable to receive data.
+	 */
+	cdns_rs485_rx_setup(cdns_uart);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * cdns_calc_after_tx_delay - calculate delay required for after tx.
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static u64 cdns_calc_after_tx_delay(struct cdns_uart *cdns_uart)
+{
+	/*
+	 * Frame time + stop bit time + rs485.delay_rts_after_send
+	 */
+	return cdns_uart->port->frame_time
+	       + DIV_ROUND_UP(cdns_uart->port->frame_time, 7)
+	       + (u64)cdns_uart->port->rs485.delay_rts_after_send * NSEC_PER_MSEC;
+}
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be transmitted.
  * @dev_id: Id of the UART port
@@ -328,6 +424,7 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct cdns_uart *cdns_uart = port->private_data;
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
@@ -347,6 +444,16 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+	/* Enable the TX Empty interrupt */
+	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
+	    (uart_circ_empty(xmit) || uart_tx_stopped(port))) {
+		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
+		hrtimer_start(&cdns_uart->tx_timer,
+			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
+	}
 }
 
 /**
@@ -579,6 +686,21 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 }
 #endif
 
+/**
+ * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
+ * @t: Handle to the hrtimer structure
+ */
+static enum hrtimer_restart cdns_rs485_tx_callback(struct hrtimer *t)
+{
+	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, tx_timer);
+
+	uart_port_lock(cdns_uart->port);
+	cdns_uart_handle_tx(cdns_uart->port);
+	uart_port_unlock(cdns_uart->port);
+
+	return HRTIMER_NORESTART;
+}
+
 /**
  * cdns_uart_start_tx -  Start transmitting bytes
  * @port: Handle to the uart port structure
@@ -586,6 +708,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -605,10 +728,16 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	/* Clear the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (!cdns_uart->rs485_tx_started) {
+			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+			cdns_rs485_tx_setup(cdns_uart);
+			return hrtimer_start(&cdns_uart->tx_timer,
+					     ms_to_ktime(port->rs485.delay_rts_before_send),
+					     HRTIMER_MODE_REL);
+		}
+	}
 	cdns_uart_handle_tx(port);
-
-	/* Enable the TX Empty interrupt */
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
 }
 
 /**
@@ -618,6 +747,10 @@ static void cdns_uart_start_tx(struct uart_port *port)
 static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
 
 	regval = readl(port->membase + CDNS_UART_CR);
 	regval |= CDNS_UART_CR_TX_DIS;
@@ -830,6 +963,9 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -889,6 +1025,10 @@ static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
 	unsigned long flags;
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		hrtimer_cancel(&cdns_uart->tx_timer);
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -1034,6 +1174,8 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	if (mctrl & TIOCM_RTS)
 		val |= CDNS_UART_MODEMCR_RTS;
+	if (cdns_uart_data->gpiod_rts)
+		gpiod_set_value(cdns_uart_data->gpiod_rts, !(mctrl & TIOCM_RTS));
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
 	if (mctrl & TIOCM_LOOP)
@@ -1456,6 +1598,39 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
+	u32 val;
+	struct cdns_uart *cdns_uart = port->private_data;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+		/* Make sure auto RTS is disabled */
+		val = readl(port->membase + CDNS_UART_MODEMCR);
+		val &= ~CDNS_UART_MODEMCR_FCM;
+		writel(val, port->membase + CDNS_UART_MODEMCR);
+
+		/* Timer setup */
+		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+
+		/* Disable transmitter and make Rx setup*/
+		cdns_uart_stop_tx(port);
+	} else {
+		hrtimer_cancel(&cdns_uart->tx_timer);
+	}
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1598,9 +1773,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
+	cdns_uart_data->gpiod_rts = devm_gpiod_get_optional(&pdev->dev, "rts",
+							    GPIOD_OUT_LOW);
+	if (IS_ERR(cdns_uart_data->gpiod_rts)) {
+		rc = PTR_ERR(cdns_uart_data->gpiod_rts);
+		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
+		goto err_out_clk_notifier;
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
@@ -1619,6 +1808,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 	}
 #endif
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart_data);
 
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
@@ -1647,6 +1838,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1


