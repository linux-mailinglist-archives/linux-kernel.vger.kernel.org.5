Return-Path: <linux-kernel+bounces-21972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8E82975C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAFA28C9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0A3F8E3;
	Wed, 10 Jan 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKhdoES9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58B405E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33674f60184so3942624f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882072; x=1705486872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfuH3wSlm6aDB+5MQe7gxyw0I5hRCPtFyKG+AY6rcK0=;
        b=bKhdoES9+F2y3TxMRg2fmdjlR7vKrmFmAItlg/a5/LR9I/kNGMpXkkV2YL/qiNW2V1
         XfgWab3hof4XzpG+ujafoNtB7pOnxcwl4Z+xqjkFerEH891zhOugxKfLjdpovol4As6F
         7w2TrTNkTnE4ls35kdgm1XRekzRQpdds08nIPXH3aX9TMkLh4pC2FIK2PTqKbzHjnWFt
         CrDGykSrRl/Pqgf1lXcBdZh+3QxOu7iOSDLSFqAsVtIbiHbIdfuk4pOLoQ7r2G4nC6Q9
         t+Resins4erU5SW3ewqG9/o6NEPi0mkjANZKlc4xfhXnMEQsr2Yb9RrzHYVEWk1ZO/+e
         E+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882072; x=1705486872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfuH3wSlm6aDB+5MQe7gxyw0I5hRCPtFyKG+AY6rcK0=;
        b=biaK8Z5uspLAx6jgiqoogCaRiKdtYILrDl4ymQNY2IVCvsz6TK8DFFn8G/AEgDf3LL
         C0XdRyPCbpS45juX60fAzovQeuxP45OQ9s3YmcmdHalWRm6Gbwcn+FW+K9DqJ+FSbJZL
         lXlNFET9ucr3u1wBD7KKyitNrUb/JFLifJLLonz1YaGR63DXr+9WwMNefyc+mKzmRAZX
         //j62MUfzRgfqSadTObuglpI/K0+dRUmz99LcFauOAUNkdIauEl2AvYDXZLAPZtty6Lg
         sfV5JxqVsHRkLFVis9RNfPzzeBDcFKKTk3giBd3Jl+tQuYU2EubwIqw9VR1mOUT6LEwv
         6vjQ==
X-Gm-Message-State: AOJu0YxtvGVGTaWHT/wCFFc5BvT5MJHAlietZ3z/CUlQKT0IqIjWzyAy
	PkZJSVhSBQBAcsz4KGgFYxIrkHmJ/yWLqdgsMvwm2xL62/2b/w==
X-Google-Smtp-Source: AGHT+IHxCH+x8Bd49h96aENkSSiu3NcMtRR69yY6qu1FUYAozJ3aiG1NexaAB58eotSyJt97Xv++1Q==
X-Received: by 2002:a05:600c:5390:b0:40e:3f37:d893 with SMTP id hg16-20020a05600c539000b0040e3f37d893mr457342wmb.17.1704882072241;
        Wed, 10 Jan 2024 02:21:12 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:11 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 06/18] tty: serial: samsung: use u32 for register interactions
Date: Wed, 10 Jan 2024 10:20:50 +0000
Message-ID: <20240110102102.61587-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All registers of the IP have 32 bits. Use u32 variables when reading
or writing from/to the registers. The purpose of those variables becomes
clearer.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 79 ++++++++++++++++----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b8b71a0109ea..d5f9bec24b8e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -199,7 +199,7 @@ static void wr_reg(const struct uart_port *port, u32 reg, u32 val)
 /* Byte-order aware bit setting/clearing functions. */
 
 static inline void s3c24xx_set_bit(const struct uart_port *port, int idx,
-				   unsigned int reg)
+				   u32 reg)
 {
 	unsigned long flags;
 	u32 val;
@@ -212,7 +212,7 @@ static inline void s3c24xx_set_bit(const struct uart_port *port, int idx,
 }
 
 static inline void s3c24xx_clear_bit(const struct uart_port *port, int idx,
-				     unsigned int reg)
+				     u32 reg)
 {
 	unsigned long flags;
 	u32 val;
@@ -245,8 +245,8 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ucon, ufcon;
 	int count = 10000;
+	u32 ucon, ufcon;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -269,7 +269,7 @@ static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ucon;
+	u32 ucon;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -591,7 +591,7 @@ static inline const struct s3c2410_uartcfg
 }
 
 static int s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *ourport,
-				     unsigned long ufstat)
+				     u32 ufstat)
 {
 	const struct s3c24xx_uart_info *info = ourport->info;
 
@@ -663,7 +663,7 @@ static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
 static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ucon;
+	u32 ucon;
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -686,7 +686,7 @@ static void enable_rx_dma(struct s3c24xx_uart_port *ourport)
 static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ucon;
+	u32 ucon;
 
 	/* set Rx mode to DMA mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -711,13 +711,14 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
 
 static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 {
-	unsigned int utrstat, received;
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
 	struct tty_port *t = &port->state->port;
 	struct dma_tx_state state;
+	unsigned int received;
+	u32 utrstat;
 
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
 	rd_regl(port, S3C2410_UFSTAT);
@@ -759,9 +760,9 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 {
 	struct uart_port *port = &ourport->port;
-	unsigned int ufcon, ufstat, uerstat;
 	unsigned int fifocnt = 0;
 	int max_count = port->fifosize;
+	u32 ufcon, ufstat, uerstat;
 	u8 ch, flag;
 
 	while (max_count-- > 0) {
@@ -945,7 +946,7 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 {
 	const struct s3c24xx_uart_port *ourport = id;
 	const struct uart_port *port = &ourport->port;
-	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
+	u32 pend = rd_regl(port, S3C64XX_UINTP);
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
@@ -964,7 +965,7 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 {
 	const struct s3c24xx_uart_port *ourport = id;
 	const struct uart_port *port = &ourport->port;
-	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
+	u32 pend = rd_regl(port, S3C2410_UTRSTAT);
 	irqreturn_t ret = IRQ_NONE;
 
 	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
@@ -983,8 +984,8 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned long ufstat = rd_regl(port, S3C2410_UFSTAT);
-	unsigned long ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ufstat = rd_regl(port, S3C2410_UFSTAT);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
 		if ((ufstat & info->tx_fifomask) != 0 ||
@@ -1000,7 +1001,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 /* no modem control lines */
 static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 {
-	unsigned int umstat = rd_reg(port, S3C2410_UMSTAT);
+	u32 umstat = rd_reg(port, S3C2410_UMSTAT);
 
 	if (umstat & S3C2410_UMSTAT_CTS)
 		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -1010,8 +1011,8 @@ static unsigned int s3c24xx_serial_get_mctrl(struct uart_port *port)
 
 static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	unsigned int umcon = rd_regl(port, S3C2410_UMCON);
-	unsigned int ucon = rd_regl(port, S3C2410_UCON);
+	u32 umcon = rd_regl(port, S3C2410_UMCON);
+	u32 ucon = rd_regl(port, S3C2410_UCON);
 
 	if (mctrl & TIOCM_RTS)
 		umcon |= S3C2410_UMCOM_RTS_LOW;
@@ -1031,7 +1032,7 @@ static void s3c24xx_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
-	unsigned int ucon;
+	u32 ucon;
 
 	uart_port_lock_irqsave(port, &flags);
 
@@ -1189,7 +1190,7 @@ static void apple_s5l_serial_shutdown(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	unsigned int ucon;
+	u32 ucon;
 
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
@@ -1215,7 +1216,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ufcon;
+	u32 ufcon;
 	int ret;
 
 	wr_regl(port, S3C64XX_UINTM, 0xf);
@@ -1260,7 +1261,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	unsigned long flags;
-	unsigned int ufcon;
+	u32 ufcon;
 	int ret;
 
 	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
@@ -1345,7 +1346,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 static inline int s3c24xx_serial_getsource(struct uart_port *port)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned int ucon;
+	u32 ucon;
 
 	if (info->num_clks == 1)
 		return 0;
@@ -1359,7 +1360,7 @@ static void s3c24xx_serial_setsource(struct uart_port *port,
 			unsigned int clk_sel)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned int ucon;
+	u32 ucon;
 
 	if (info->num_clks == 1)
 		return;
@@ -1476,9 +1477,8 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	struct clk *clk = ERR_PTR(-EINVAL);
 	unsigned long flags;
 	unsigned int baud, quot, clk_sel = 0;
-	unsigned int ulcon;
-	unsigned int umcon;
 	unsigned int udivslot = 0;
+	u32 ulcon, umcon;
 
 	/*
 	 * We don't support modem control lines.
@@ -1760,7 +1760,7 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
 				     const struct s3c2410_uartcfg *cfg)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+	u32 ucon = rd_regl(port, S3C2410_UCON);
 
 	ucon &= (info->clksel_mask | info->ucon_mask);
 	wr_regl(port, S3C2410_UCON, ucon | cfg->ucon);
@@ -1906,7 +1906,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
 		break;
 	case TYPE_APPLE_S5L: {
-		unsigned int ucon;
+		u32 ucon;
 
 		ucon = rd_regl(port, S3C2410_UCON);
 		ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
@@ -2110,7 +2110,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 		/* restore IRQ mask */
 		switch (ourport->info->type) {
 		case TYPE_S3C6400: {
-			unsigned int uintm = 0xf;
+			u32 uintm = 0xf;
 
 			if (ourport->tx_enabled)
 				uintm &= ~S3C64XX_UINTM_TXD_MSK;
@@ -2126,7 +2126,7 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 			break;
 		}
 		case TYPE_APPLE_S5L: {
-			unsigned int ucon;
+			u32 ucon;
 			int ret;
 
 			ret = clk_prepare_enable(ourport->clk);
@@ -2188,10 +2188,10 @@ static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
 static struct uart_port *cons_uart;
 
 static int
-s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
+s3c24xx_serial_console_txrdy(struct uart_port *port, u32 ufcon)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
-	unsigned long ufstat, utrstat;
+	u32 ufstat, utrstat;
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
 		/* fifo mode - check amount of data in fifo registers... */
@@ -2207,7 +2207,7 @@ s3c24xx_serial_console_txrdy(struct uart_port *port, unsigned int ufcon)
 }
 
 static bool
-s3c24xx_port_configured(unsigned int ucon)
+s3c24xx_port_configured(u32 ucon)
 {
 	/* consider the serial port configured if the tx/rx mode set */
 	return (ucon & 0xf) != 0;
@@ -2222,7 +2222,7 @@ s3c24xx_port_configured(unsigned int ucon)
 static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 {
 	const struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned int ufstat;
+	u32 ufstat;
 
 	ufstat = rd_regl(port, S3C2410_UFSTAT);
 	if (s3c24xx_serial_rx_fifocnt(ourport, ufstat) == 0)
@@ -2234,8 +2234,8 @@ static int s3c24xx_serial_get_poll_char(struct uart_port *port)
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 		unsigned char c)
 {
-	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
-	unsigned int ucon = rd_regl(port, S3C2410_UCON);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ucon = rd_regl(port, S3C2410_UCON);
 
 	/* not possible to xmit on unconfigured port */
 	if (!s3c24xx_port_configured(ucon))
@@ -2251,7 +2251,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 static void
 s3c24xx_serial_console_putchar(struct uart_port *port, unsigned char ch)
 {
-	unsigned int ufcon = rd_regl(port, S3C2410_UFCON);
+	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	while (!s3c24xx_serial_console_txrdy(port, ufcon))
 		cpu_relax();
@@ -2262,7 +2262,7 @@ static void
 s3c24xx_serial_console_write(struct console *co, const char *s,
 			     unsigned int count)
 {
-	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
+	u32 ucon = rd_regl(cons_uart, S3C2410_UCON);
 	unsigned long flags;
 	bool locked = true;
 
@@ -2289,11 +2289,9 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 			   int *parity, int *bits)
 {
 	struct clk *clk;
-	unsigned int ulcon;
-	unsigned int ucon;
-	unsigned int ubrdiv;
 	unsigned long rate;
 	unsigned int clk_sel;
+	u32 ulcon, ucon, ubrdiv;
 	char clk_name[MAX_CLK_NAME_LENGTH];
 
 	ulcon  = rd_regl(port, S3C2410_ULCON);
@@ -2743,7 +2741,8 @@ static int samsung_early_read(struct console *con, char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 	const struct samsung_early_console_data *data = dev->port.private_data;
-	int ch, ufstat, num_read = 0;
+	int num_read = 0;
+	u32 ch, ufstat;
 
 	while (num_read < n) {
 		ufstat = rd_regl(&dev->port, S3C2410_UFSTAT);
-- 
2.43.0.472.g3155946c3a-goog


