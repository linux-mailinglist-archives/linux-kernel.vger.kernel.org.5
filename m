Return-Path: <linux-kernel+bounces-963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2278148A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248951F24273
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222FE2D792;
	Fri, 15 Dec 2023 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFjv3tSX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434532DB67;
	Fri, 15 Dec 2023 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSwRJvqurKHxYIXB/V1avJKejXNWiNYqzOK1fhtnOP5bwNJgBiEmbsNqQh8w58U/UTq3TiQokt4jwT0b4e26hEFVqdSfdD8+NzeTW0eWZfOy/AL2WfAUfigK6Skza8Bb9AG9fXFH3NtEGIykJHEkeJx3x0UZh3N9OdMSdU/NqGDpi4KjJFjTLC6aK8c6imA8clOGFwyrTEfDXaKLuq4NQ75vvqwj7m8oDOp9KfAwi+U6AJhnjxZjT9VIIJvgSQOh8TfDW+crkh+ekYo95kLCqtE+LOwDEyoFZtLYYA3oVnHsOge/59xdJZcAs/UTVVzJKoL9ja0sP3svBndJxF7WYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FbACE4kyCuZp9QvEztIo+ETHnGrgDPbRz5qy3uE/L8=;
 b=Z/CYboYelQWHIm6GUpATR6W7ZIMUzJhyLJiROsihexnPWf2JPx5TMCIsqIiQ8t6eUD9xkVRElMSI23kYShK6Ay5NxaRweIaMKJ5GqTP6ZlppPazvjqzGLtfY72l6rJ5Xg6jDysJNxjOy6wWttd8PzXZajn1aQtEkIwAIyE3ULkCEwyrxKjMeMlcEtB9rQwbTuv4dy+nMM9CWerWeJS50rgpCrourLVe0vCOq4neSghtKvOpw3Ryv7Bfkaofwahmrop/Id24LYmqukwqeL5vt9HAqMGhRmd1Z4Z/xPyNfnYCib9JRXrryaSm5Q+bT2nm4oBw7fvDHfwKYmdCgg29dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FbACE4kyCuZp9QvEztIo+ETHnGrgDPbRz5qy3uE/L8=;
 b=JFjv3tSXEA85rkXQyMK3hb/Or0v5NUvGhlpVkWRyu75eLZONnWzTYZxvV0WaThX3orZKyGcjl7oeZvwdfs6mtJnFIwA9n3ErvtabETn4iYU0/yI1CNfF+KcFVx59uZuywntnZRyiZA6/xa4VdRHTT60rE05YOxEcliX8VTKwJ0c=
Received: from CY5PR15CA0194.namprd15.prod.outlook.com (2603:10b6:930:82::12)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 12:57:25 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::7b) by CY5PR15CA0194.outlook.office365.com
 (2603:10b6:930:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32 via Frontend
 Transport; Fri, 15 Dec 2023 12:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:57:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 06:56:58 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 06:56:54 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V6 3/3] tty: serial: uartps: Add rs485 support to uartps driver
Date: Fri, 15 Dec 2023 18:26:27 +0530
Message-ID: <20231215125627.1691573-4-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: a79ac0a2-162b-4dab-564d-08dbfd6d6273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nWfK+rNaF4Kocp6TeqO2bJ5tjhL4GpksvuyN5JO0epkp+bDuHTuCHjlDluYKFdPbDavLN+pF2TL2FCNrStN/KFcWuq6hW8CKkA5ONzBgxZ/xMPB8DsERe04tah3Npm4T/IEenM8Ph4LUHewVICHWQIsxI9S/3mYaODlY0VarGGxh8leL8Awb6Ajn5+wMsbelz62BcwP8lBc41tJBqr6UAxxOpVBjyrLxD8KU0lGw3n2J/JlWwp4lHM+uuWNWFaiRhxr7cHMwiJzlQbvys7JENk5gc+rbYkkeL9tUnF6mcobzmXLaVaG+fL/XzJenOoviHj1NmK1ioVAKPI8N2pR9r+gZvmu0rXNxeDV9OFMpkB3ANy6oCsnUalxFoKJRxKJf9DlXFxc/VfQOf1lh5O8ohFAa7A9GHWAn2oI6MSuLUth2Qi3rw4uNhMJRAZ7uxLwHvdOf6M+e3dWzwRzLY2Lu6VwjMqS27fnskd8NNEwQ4vVnECcF4vpZOt79DN+zOLjNObWTxgQ5ZtZe85yS6+Te4k5RqOb5ddHxC9m43wjsEx6ptFurMSnOiEB4zPKM/RWhjEJJg4EhTQZqSRoqv2lijH2qFJfR7Qt3dnj4J6+IjJscMQL8i3QbfCNc6hdC3RlPRJ01cD0RBATQFmpL3SSoxSCognGiNRSZjTYH2oKmoWEQ5FcHr7ABWb04sT5PEzgqf7t4sDENjiQIXes3lv3vh1FbdmNe6GFw1UJqZXP0L3BJzOVR8Mwl8H0tkk9r2yXd3lc4uWPkHs/d/kOSHBdgxf6gB5NQx7lSNugDqQv5QJI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(26005)(426003)(336012)(2616005)(1076003)(82740400003)(356005)(36756003)(921008)(86362001)(81166007)(47076005)(83380400001)(4326008)(5660300002)(44832011)(7416002)(36860700001)(6666004)(70586007)(316002)(70206006)(110136005)(8676002)(8936002)(54906003)(2906002)(30864003)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:57:24.6483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79ac0a2-162b-4dab-564d-08dbfd6d6273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

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


