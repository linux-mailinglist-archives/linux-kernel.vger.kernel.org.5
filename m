Return-Path: <linux-kernel+bounces-3266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A95816A18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3287C1F24DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CC513AD3;
	Mon, 18 Dec 2023 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pEoALyrk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915C125AD;
	Mon, 18 Dec 2023 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVESFAjoeGwJuDdZM6ZSLp/kl+eCb6SL8tZXaAE42rKqjwS+Mknz7NtDZ5itK0v9dmoChyg8ZZMobt8doHuyE/iaQwQ14eRDnUMxnWm9RyutM9AY2EwPVVE/rzqONJkjo79P/8X276HJ58mqRSIt1YhPvUKbMT8/wV1r6YmH5jbN+A1LMMZmHoaY8TnA40agAOjxD7279F4DuRm5r+e0vqUPDzSHangSGg6ggQGwnupVidLoblL1lMvzRh+mNy8xK+BPVI4myLGVkIvpKOyaV0au8skfHFbBvnTL5zkR1UiFVwNJKj048cR0Rnhy8RzEZ3A/gQUBdvV+WI1oFQFTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDpFdlDo6QU4GK83BVBhq6ads/H/v+mnlTmia3x1EL0=;
 b=gq+qLVffJatW0qpeizkTJxTju6mgx3uSNSglAmkgg1aG3bwKqz+Ev48pO+0gfcP4nBTiCpr+Xk2zJG70kSKgzl49jl55U7yIeyW7coCCFt45NtFigGurRBf1nJMgU5f6oi/YjSC2Iqx+YIB3cB0Dq9ThqiUwA/GxJy0eLwS1ijkmUkIxjb9KAtLFar120yPVsLclzvAnHi+UqfuQV6l3qd7EDh5bcDH3QAoc/ovokr8jtS869D0A/9tNNteSrVhIe4K7Pz3y+zhmSqB9YUDlDBqPM94CWP7KeJw0PcyszvU09WVy26jFof3R1UVGCo389KzTLypbGRITxWmonUAb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDpFdlDo6QU4GK83BVBhq6ads/H/v+mnlTmia3x1EL0=;
 b=pEoALyrkqj6xrtU962UQ08FvH2SyfoiQPuXMEu8P+HPvcKsdAOR19Z5pPIGsQJRzckvPlqviSqZt991vhSY2JrX8uf2fzhAZ1avesF4t+oA1tsXQLAm03yZWICVwO4K/khuohcDc6mTBaChrDgtkPfAG63lG7NrQhgdLIA8rEyQ=
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 09:44:40 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::9b) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 09:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:44:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:44:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 18 Dec
 2023 01:44:38 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 03:44:35 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V7 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date: Mon, 18 Dec 2023 15:14:15 +0530
Message-ID: <20231218094415.2503672-4-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: bd468f04-baf9-4c3b-d96e-08dbffadf4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SAGE5fyvZH4W/6UPRs/cFh1N5ei3YTF++Ly1omunqAZzoiPyjkgfFddwLoh4lBxIqGwxXQRiLfj7G8WiFS+V9+K7V/tBYfDPkkG71N55sQEk44GlG8ZaXDLtWmQwNwOmYzshYK3AXD4rSUj6rZ8KHcnwEGvyDCzWwMSsFenSIQOgV8qW6E4iC3yX8Xt1+oOsCYXD3Hb6bj7v+Dvtehp5fFQQTQW9YpxRNXOEhkuRlH+IqS0NNNyVP/xPzxts/Jr+62HJnQQNofNx+/oPMNI+u+4PdUnAipaDuSSeb53eT9i9Guf9LA3jjpb7heGqujqu1K/K1oafs/iXR0enCgUZ3uytsxfC8fefzzLJWChM54IPMtczbbdL3WICgINL45qSGV2WNjm6l5auguVnTIAQ+fDzGav8Jg9AbkZ43sVPq1wwp+XCFK5ljTtgDjRyzsdlS0Ec/p26TeHBbgU6tmuOTFWp/rOYXiCco+367uDGNx84tF5Q+XlIjkbza7lnQIO71c5pO7qbrveYefsecVXjCSrQ5ZoKoWFxprrEhMccXkZmOK9tmGmM1Z4AtKhTFnuogOHhIJPVK6j36/hFlKMxcoAcVPj8g8O2oJ+msnUv7zh0HVg6whnki8vpRVfuP/kA5A2KHSMXeFP5CydHLZrE3t1Cmx9cPMmkjl/AiiYvIeB6Tv7g0P6T5ESF3z/9iK40c+t8h31wM+cj+ghsq3XgIt5T7Pf/apj94xcVdq0gYi11+4BFvLXPjVUZHkKSa6p7B5KOlyKJ0iH02IiilZd7t3bD1Po+c23OpkFoSuZqFM8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(36756003)(921008)(316002)(83380400001)(426003)(336012)(70586007)(70206006)(30864003)(54906003)(110136005)(7416002)(40480700001)(2906002)(47076005)(8676002)(8936002)(4326008)(5660300002)(44832011)(36860700001)(6666004)(26005)(1076003)(478600001)(2616005)(86362001)(41300700001)(40460700003)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:44:40.2304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd468f04-baf9-4c3b-d96e-08dbffadf4c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483

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
---
 drivers/tty/serial/xilinx_uartps.c | 222 +++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index aafcc2179e0e..04cc23deebdf 100644
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
+ * @timer:		Timer for tx and rx
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
+	struct timer_list	timer;
+	struct timer_list	stop_tx_timer;
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
+	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND)
+		cdns_rts_gpio_enable(cdns_uart, 1);
+	else
+		cdns_rts_gpio_enable(cdns_uart, 0);
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
+	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		cdns_rts_gpio_enable(cdns_uart, 1);
+	else
+		cdns_rts_gpio_enable(cdns_uart, 0);
+
+	cdns_uart->rs485_tx_started = false;
+}
+
 /**
  * cdns_uart_tx_empty -  Check whether TX is empty
  * @port: Handle to the uart port structure
@@ -579,6 +646,44 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 }
 #endif
 
+/**
+ * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static void cdns_rs485_rx_callback(struct timer_list *t)
+{
+	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, timer);
+
+	/*
+	 * Default Rx should be setup, because Rx signaling path
+	 * need to enable to receive data.
+	 */
+	cdns_rs485_rx_setup(cdns_uart);
+}
+
+/**
+ * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static void cdns_rs485_tx_callback(struct timer_list *t)
+{
+	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, timer);
+
+	uart_port_lock(cdns_uart->port);
+	cdns_uart_handle_tx(cdns_uart->port);
+
+	/* Enable the TX Empty interrupt */
+	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
+	uart_port_unlock(cdns_uart->port);
+
+	if (uart_circ_empty(&cdns_uart->port->state->xmit) ||
+	    uart_tx_stopped(cdns_uart->port)) {
+		timer_setup(&cdns_uart->timer, cdns_rs485_rx_callback, 0);
+		mod_timer(&cdns_uart->timer, jiffies +
+			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
+	}
+}
+
 /**
  * cdns_uart_start_tx -  Start transmitting bytes
  * @port: Handle to the uart port structure
@@ -586,6 +691,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -604,10 +710,40 @@ static void cdns_uart_start_tx(struct uart_port *port)
 
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 
-	cdns_uart_handle_tx(port);
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		if (!cdns_uart->rs485_tx_started) {
+			timer_setup(&cdns_uart->timer,
+				    cdns_rs485_tx_callback, 0);
+			cdns_rs485_tx_setup(cdns_uart);
+			mod_timer(&cdns_uart->timer, jiffies +
+				  msecs_to_jiffies(port->rs485.delay_rts_before_send));
+		} else {
+			if (!timer_pending(&cdns_uart->timer))
+				mod_timer(&cdns_uart->timer, jiffies);
+		}
+	} else {
+		cdns_uart_handle_tx(port);
 
-	/* Enable the TX Empty interrupt */
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
+		/* Enable the TX Empty interrupt */
+		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
+	}
+}
+
+/**
+ * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for rs485.
+ * @t: Handle to the timer list structure
+ */
+static void cdns_rs485_stop_tx_callback(struct timer_list *t)
+{
+	unsigned int regval;
+	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, stop_tx_timer);
+
+	cdns_rs485_rx_setup(cdns_uart);
+
+	regval = readl(cdns_uart->port->membase + CDNS_UART_CR);
+	regval |= CDNS_UART_CR_TX_DIS;
+	/* Disable the transmitter */
+	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
 }
 
 /**
@@ -617,11 +753,19 @@ static void cdns_uart_start_tx(struct uart_port *port)
 static void cdns_uart_stop_tx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
 
-	regval = readl(port->membase + CDNS_UART_CR);
-	regval |= CDNS_UART_CR_TX_DIS;
-	/* Disable the transmitter */
-	writel(regval, port->membase + CDNS_UART_CR);
+	if ((cdns_uart->port->rs485.flags & SER_RS485_ENABLED) &&
+	    !timer_pending(&cdns_uart->stop_tx_timer) &&
+	    cdns_uart->rs485_tx_started) {
+		mod_timer(&cdns_uart->stop_tx_timer, jiffies +
+			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
+	} else {
+		regval = readl(port->membase + CDNS_UART_CR);
+		regval |= CDNS_UART_CR_TX_DIS;
+		/* Disable the transmitter */
+		writel(regval, port->membase + CDNS_UART_CR);
+	}
 }
 
 /**
@@ -829,6 +973,12 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		timer_setup(&cdns_uart->stop_tx_timer,
+			    cdns_rs485_stop_tx_callback, 0);
+		cdns_rs485_rx_setup(cdns_uart);
+	}
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -888,6 +1038,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
 	unsigned long flags;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -903,6 +1054,11 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
+
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		del_timer_sync(&cdns_uart->timer);
+		del_timer_sync(&cdns_uart->stop_tx_timer);
+	}
 }
 
 /**
@@ -1032,7 +1188,7 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
 	if (mctrl & TIOCM_RTS)
-		val |= CDNS_UART_MODEMCR_RTS;
+		cdns_rts_gpio_enable(cdns_uart_data, 1);
 	if (mctrl & TIOCM_DTR)
 		val |= CDNS_UART_MODEMCR_DTR;
 	if (mctrl & TIOCM_LOOP)
@@ -1455,6 +1611,37 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
+	unsigned int ctrl_reg;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+		/* Make sure auto RTS is disabled */
+		val = readl(port->membase + CDNS_UART_MODEMCR);
+		val &= ~CDNS_UART_MODEMCR_FCM;
+		writel(val, port->membase + CDNS_UART_MODEMCR);
+		/* Disable transmitter and make Rx setup*/
+		cdns_uart_stop_tx(port);
+	} else {
+		/* Disable the TX and RX */
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
+		ctrl_reg |= CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS;
+		writel(ctrl_reg, port->membase + CDNS_UART_CR);
+	}
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1597,9 +1784,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
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
@@ -1618,6 +1819,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = port;
 	}
 #endif
+	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart_data);
 
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
@@ -1646,6 +1849,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1


