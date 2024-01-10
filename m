Return-Path: <linux-kernel+bounces-22053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A282987C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D821C24767
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488574778E;
	Wed, 10 Jan 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x/W0YWJm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07377481D8;
	Wed, 10 Jan 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFgA1JzCxeL4z7IXP3njwFnGcw5OnDDpN3/qxK4dilvJN9rh8/cshnY/TWz9q0ViX22adB+dCULcPnuplX9ApxPLvRTh7NP8e9GRdJGkQdhSRauNByP4CfQFcER/6bR+eaiStfGjYdt10Uai/bNxiBjrtt48KrUIKMwkxglvUoJKCTUD1OHxgVaE7CfPsNqiyfBVHcvFkkBKfBssZR1VfKG54gVlGlp9rXoj9RwMMWE33TRh4JMlHQW3Inawu9k28lEpNhnbSXj8Av0M4gZkVS9RmAqsKNZOsJ8fCltyW+9/pJ3kwhlILqIeOoS6vzBAXDA3ZRmp4frES2y1tr+SVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGuopZAN+nviV6zohQFz7G1AMxus+RySCPj1jrLficU=;
 b=Qg6Gzeb6iFeAAdJlNgM+NXv6X9NWFmrOVOzgPNGB4tbEaPUvXMikYM6tGIcUtnMU1hUmofzcMvrM/QHO4cOBTClf6GbwEXHv+ML+ZpuE2JIdUKD/ble2rKSjcN9csnFC8TiQo8XYukTJBKgsRxIE7wK48qa376N1qH5dqPKNAkcj1uqfBmEku223EziWdm4NSXIGWm3f6xCcp6v7hKudfdNk3+XL2Q0eq4PQC2YKRWGsKlYjKDZ1zw7937fgvL75E1kyQYdFhNWhvON/xQ9Dz2D3kLeUhTJlNuFM5eSr+8ETaT40N6ttkQKZmryMgCDfuLpmuJhalR1hP9Lcazvwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGuopZAN+nviV6zohQFz7G1AMxus+RySCPj1jrLficU=;
 b=x/W0YWJmZ/+0pm8kmtGsbPzUcmPpsoeczqZy7UBOigUC2m+rmveG8/TAWcN6RhKnl9J02x+f/K7Xszw/ayo7aG1Nch+CVwVBYAzimZ6PD2WfdqdLXXJZ/CpeK6pCwqZVuGDep85yDpDvkCzS3xjwniXKfpC/YTu+LpRtKk3Tb5M=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 10 Jan 2024 11:12:04 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::47) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 11:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:12:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:12:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 10 Jan
 2024 03:12:01 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 05:11:58 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V8 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date: Wed, 10 Jan 2024 16:41:07 +0530
Message-ID: <20240110111107.3645284-4-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 388df47e-3ecc-4d51-1228-08dc11ccf995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FWakF7xyGGQZpvt41vH6XzjAnGCYWl27PYAXNM18mQ5ynxlwwUMNbHFhk3oLI2z9qhFbqdAkH97PtNek1hB+S8sxwHF4nMR/EUGb176b2MPSqjhGLanx3y058EGO01g1kezRWf0kb4u/FsRKaEdVvPBCoULU2GwhPIQHlXtXmiiBu+RUHfAcbbKGxG//PYGbmF54jHTYB/VSPiq11l8b8B8wVfGRhcY3uOkjXUUo5eA3328tBLHSPkPKzraUgv0B1+LiTJBRmAXiwyAuZ9lDsAseZZ6fyiRTHNDvnX6hlfHfwVUx7wun2wxUmgaYODn1ng2bEYvolqfhT8pgjycx6BYHRxGHU3wErEf/k0D8CTKKTsTZ5VjIl+kEg+I08S1/XgFb5JVPjnITptcjtf05LWYBfK6nr0SEZLyNgF47mnYSYiWFh1S9K+jz8q6jFnMuLwZ+dG21teiEYTSdP3yXR9qUfg/Ni3qIjxyWVHV20g+b98Cmx15OJY16LcnRjkY7UfZ6fdh/uE9eTxWUbGM3xA5J5aVYIEw4y2U9IACVdC6V+fEfn5i3JrOEry1gOlxtbFb49uP9ITr8iJLApVRHzcBQtPxmHop/EQMmU3kMi8W6aU9M/f1hM91rKAi86Q3pZ6FETpDuFiOzRjNUj1qcoNqWfdUr5a041IwXD1H1Sd+1m5Bd8Q1UOrfIVxvZEvfWJCTEik3UpPg1sY1UVYc7HiNljosTC5OnTTJM4ErqdNzy4WFqlnPJjgor3pQxpeni538u+yr9HfEIAng/VfAEaZd8Z/tZ8AV+1I+7Hmpkvz8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(478600001)(30864003)(7416002)(83380400001)(2906002)(5660300002)(316002)(2616005)(1076003)(26005)(4326008)(44832011)(426003)(336012)(47076005)(40480700001)(36860700001)(8676002)(8936002)(86362001)(41300700001)(82740400003)(356005)(40460700003)(6666004)(110136005)(54906003)(70586007)(70206006)(81166007)(921011)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:12:03.6970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388df47e-3ecc-4d51-1228-08dc11ccf995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

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
---
 drivers/tty/serial/xilinx_uartps.c | 241 ++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index aafcc2179e0e..3247fd3e91fd 100644
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
@@ -193,6 +195,10 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod_rts:		Pointer to the gpio descriptor
+ * @rs485_tx_started:	RS485 tx state
+ * @tx_timer:		Timer for tx
+ * @stop_tx_timer:	Timer for stop tx
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +209,22 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod_rts;
+	bool			rs485_tx_started;
+	struct hrtimer		tx_timer;
+	struct hrtimer		stop_tx_timer;
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
 
@@ -305,6 +323,55 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
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
+			val &= ~CDNS_UART_MODEMCR_RTS;
+		else
+			val |= CDNS_UART_MODEMCR_RTS;
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
@@ -320,6 +387,37 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
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
  * cdns_uart_handle_tx - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
@@ -328,6 +426,7 @@ static unsigned int cdns_uart_tx_empty(struct uart_port *port)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct cdns_uart *cdns_uart = port->private_data;
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
@@ -347,6 +446,16 @@ static void cdns_uart_handle_tx(void *dev_id)
 
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
@@ -579,6 +688,21 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
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
@@ -586,6 +710,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -604,10 +729,38 @@ static void cdns_uart_start_tx(struct uart_port *port)
 
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (!cdns_uart->rs485_tx_started) {
+			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+			cdns_rs485_tx_setup(cdns_uart);
+			return hrtimer_start(&cdns_uart->tx_timer,
+					     ms_to_ktime(port->rs485.delay_rts_before_send),
+					     HRTIMER_MODE_REL);
+		} else {
+			if (hrtimer_get_remaining(&cdns_uart->tx_timer))
+				hrtimer_cancel(&cdns_uart->tx_timer);
+		}
+	}
 	cdns_uart_handle_tx(port);
+}
 
-	/* Enable the TX Empty interrupt */
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
+/**
+ * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static enum hrtimer_restart cdns_rs485_stop_tx_callback(struct hrtimer *t)
+{
+	unsigned int regval;
+	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, stop_tx_timer);
+
+	cdns_rs485_rx_setup(cdns_uart);
+
+	regval = readl(cdns_uart->port->membase + CDNS_UART_CR);
+	regval |= CDNS_UART_CR_TX_DIS;
+	/* Disable the transmitter */
+	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
+
+	return HRTIMER_NORESTART;
 }
 
 /**
@@ -617,11 +770,21 @@ static void cdns_uart_start_tx(struct uart_port *port)
 static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
 
-	regval = readl(port->membase + CDNS_UART_CR);
-	regval |= CDNS_UART_CR_TX_DIS;
-	/* Disable the transmitter */
-	writel(regval, port->membase + CDNS_UART_CR);
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (cdns_uart->rs485_tx_started)
+			hrtimer_start(&cdns_uart->stop_tx_timer,
+				      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)),
+				      HRTIMER_MODE_REL);
+		else
+			cdns_rs485_stop_tx_callback(&cdns_uart->stop_tx_timer);
+	} else {
+		regval = readl(port->membase + CDNS_UART_CR);
+		regval |= CDNS_UART_CR_TX_DIS;
+		/* Disable the transmitter */
+		writel(regval, port->membase + CDNS_UART_CR);
+	}
 }
 
 /**
@@ -829,6 +992,9 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -888,6 +1054,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
 	unsigned long flags;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -903,6 +1070,11 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		hrtimer_cancel(&cdns_uart->tx_timer);
+		hrtimer_cancel(&cdns_uart->stop_tx_timer);
+	}
 }
 
 /**
@@ -1032,7 +1204,7 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
 	if (mctrl & TIOCM_RTS)
-		val |= CDNS_UART_MODEMCR_RTS;
+		cdns_rts_gpio_enable(cdns_uart_data, mctrl & TIOCM_RTS);
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
 	if (mctrl & TIOCM_LOOP)
@@ -1455,6 +1627,42 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
+		hrtimer_init(&cdns_uart->stop_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+		cdns_uart->stop_tx_timer.function = &cdns_rs485_stop_tx_callback;
+
+		/* Disable transmitter and make Rx setup*/
+		cdns_uart_stop_tx(port);
+	} else {
+		hrtimer_cancel(&cdns_uart->tx_timer);
+		hrtimer_cancel(&cdns_uart->stop_tx_timer);
+	}
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1597,9 +1805,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1618,6 +1840,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 	}
 #endif
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart_data);
 
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
@@ -1646,6 +1870,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1


