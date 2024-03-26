Return-Path: <linux-kernel+bounces-118975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D117988C220
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F85B21C06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058C76401;
	Tue, 26 Mar 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fYwzi8qg"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43C75806;
	Tue, 26 Mar 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456071; cv=none; b=rnXlNp5M4VkQLffSVs4gyGuEauct18A8Tl31bCzHTdEBEci4ShcAMF5HgZeK24hD9pTfSQxUludMmxvGbCQN5Ihrx8LQDmtL2f9wqmUTciRAYbPoyUzQ+ZSbIMmiRU51OmeYOrGscLu0bschKh7FrM6vnIOLeXPdTm5LrACWFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456071; c=relaxed/simple;
	bh=zzOEjUVQkWqnS4hwzn6x2JGH4Xxki8samoobK81+3iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LcJnsV6w+0XyMoxHopwqptN1+Yzqs3br3+2Ay2fRxjPQ4ObEIEstxY02Nenp/7ULQ91U55RfvuRBoDsht1WjNLl+sRfCa1ldHghwLkppm7gBY7FMd4fGD7BktreRIX3/WXtnLzONgUxthdiQliNIOBJv1pbEQsySSLqhtmkAJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fYwzi8qg; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=KDIyZTlIle3JKNVn0YJbDqyvuC6ORc4/Rs9FG3+7Uiw=; b=fYwzi8qgs+EMhEPLUJk3bSuLI9
	W4ITKhwVKPEBpcmYoJbIPCzT68ej2ldjp4s1qFKehqHzAlwyUKQJWn6neWKXcuvg2efN3ftxj0nT6
	50XmEjnb7SKxdDKyHgkUfl+q73MhE5m0MzqlZxoDcxONNPBBqL9UGB3ibx/wLmxI1JxqVOASUpi+v
	T/yExL4ekbfn8SlOHzTm74ysh06ILXCYh9k0f/nL1XGNEoLC03z8UM+VQoIUEfFb/naU3GiVHtjPo
	Dg6pZnf5LOTXMvBBFENbWviT4wnwFh+Cj9WNh1zddw0Bq/cvpGn+TUKDSzbzBX3cJhENVjN3PPx1m
	afCSvjQA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1rp5u4-000J3B-LB; Tue, 26 Mar 2024 13:27:44 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1rp5u3-000P6m-2s;
	Tue, 26 Mar 2024 13:27:43 +0100
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: m_can: don't enable transceiver when probing
Date: Tue, 26 Mar 2024 13:26:38 +0100
Message-ID: <20240326122640.706041-1-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27226/Tue Mar 26 09:37:28 2024)

The m_can driver sets and clears the CCCR.INIT bit during probe (both
when testing the NON-ISO bit, and when configuring the chip). After
clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
the m_can node is only used for monitoring the bus, as one cannot setup
listen-only mode before the device is probed.

Rework the probe flow, so that the CCCR.INIT bit is only cleared when
upping the device. First, the tcan4x5x driver is changed to stay in
standby mode during/after probe. This in turn requires changes when
setting bits in the CCCR register, as its CSR and CSA bits are always
high in standby mode.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/net/can/m_can/m_can.c         | 129 ++++++++++++++------------
 drivers/net/can/m_can/tcan4x5x-core.c |  14 ++-
 2 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 14b231c4d7ec..1ca245846fcd 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -379,38 +379,60 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
 	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
 }
 
-static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
+static bool m_can_cccr_wait_bits(struct m_can_classdev *cdev, u32 mask, u32 val)
 {
-	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
-	u32 timeout = 10;
-	u32 val = 0;
-
-	/* Clear the Clock stop request if it was set */
-	if (cccr & CCCR_CSR)
-		cccr &= ~CCCR_CSR;
-
-	if (enable) {
-		/* enable m_can configuration */
-		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
-		udelay(5);
-		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
-		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
-	} else {
-		m_can_write(cdev, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
-	}
+	u32 val_before = m_can_read(cdev, M_CAN_CCCR);
+	u32 val_after = (val_before & ~mask) | val;
+	size_t tries = 5;
+
+	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT))
+		dev_warn(cdev->dev,
+			 "trying to configure device when in normal mode. Expect failures\n");
+
+	/* The chip should be in standby mode when changing the CCCR register,
+	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
+	 * the CSR and CSA bits should be written as zeros, even when they read
+	 * ones.
+	 */
+	val_after &= ~(CCCR_CSR | CCCR_CSA);
+
+	while (tries--) {
+		u32 val_read;
+
+		/* Write the desired value in each try, as setting some bits in
+		 * the CCCR register require other bits to be set first. E.g.
+		 * setting the NISO bit requires setting the CCE bit first.
+		 */
+		m_can_write(cdev, M_CAN_CCCR, val_after);
+
+		val_read = m_can_read(cdev, M_CAN_CCCR) & ~(CCCR_CSR | CCCR_CSA);
 
-	/* there's a delay for module initialization */
-	if (enable)
-		val = CCCR_INIT | CCCR_CCE;
-
-	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
-		if (timeout == 0) {
-			netdev_warn(cdev->net, "Failed to init module\n");
-			return;
-		}
-		timeout--;
-		udelay(1);
+		if (val_read == val_after)
+			return true;
+
+		usleep_range(1, 5);
 	}
+
+	return false;
+}
+
+static void m_can_config_enable(struct m_can_classdev *cdev)
+{
+	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
+	 * configuration registers should only be enabled when in standby mode,
+	 * where CCCR_INIT is always set.
+	 */
+	if (!m_can_cccr_wait_bits(cdev, CCCR_CCE, CCCR_CCE))
+		netdev_err(cdev->net, "failed to enable configuration mode\n");
+}
+
+static void m_can_config_disable(struct m_can_classdev *cdev)
+{
+	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
+	 * standby mode
+	 */
+	if (!m_can_cccr_wait_bits(cdev, CCCR_CCE, 0))
+		netdev_err(cdev->net, "failed to disable configuration registers\n");
 }
 
 static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
@@ -1403,7 +1425,7 @@ static int m_can_chip_config(struct net_device *dev)
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
 			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
 
-	m_can_config_endisable(cdev, true);
+	m_can_config_enable(cdev);
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
 	m_can_write(cdev, M_CAN_RXESC,
@@ -1521,7 +1543,7 @@ static int m_can_chip_config(struct net_device *dev)
 		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
 		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
 
-	m_can_config_endisable(cdev, false);
+	m_can_config_disable(cdev);
 
 	if (cdev->ops->init)
 		cdev->ops->init(cdev);
@@ -1544,12 +1566,15 @@ static int m_can_start(struct net_device *dev)
 
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	m_can_enable_all_interrupts(cdev);
-
 	if (cdev->version > 30)
 		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
 						 m_can_read(cdev, M_CAN_TXFQS));
 
+	m_can_enable_all_interrupts(cdev);
+
+	if (!m_can_cccr_wait_bits(cdev, CCCR_INIT, 0))
+		netdev_err(dev, "failed to enter normal mode\n");
+
 	return 0;
 }
 
@@ -1603,33 +1628,17 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
  */
 static bool m_can_niso_supported(struct m_can_classdev *cdev)
 {
-	u32 cccr_reg, cccr_poll = 0;
-	int niso_timeout = -ETIMEDOUT;
-	int i;
+	bool niso_supported;
 
-	m_can_config_endisable(cdev, true);
-	cccr_reg = m_can_read(cdev, M_CAN_CCCR);
-	cccr_reg |= CCCR_NISO;
-	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
+	/* First try to set the NISO bit (which requires the CCE bit too. */
+	niso_supported = m_can_cccr_wait_bits(cdev, CCCR_NISO | CCCR_CCE,
+					      CCCR_NISO | CCCR_CCE);
 
-	for (i = 0; i <= 10; i++) {
-		cccr_poll = m_can_read(cdev, M_CAN_CCCR);
-		if (cccr_poll == cccr_reg) {
-			niso_timeout = 0;
-			break;
-		}
+	/* Then clear the two bits again. */
+	if (!m_can_cccr_wait_bits(cdev, CCCR_NISO | CCCR_CCE, 0))
+		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
 
-		usleep_range(1, 5);
-	}
-
-	/* Clear NISO */
-	cccr_reg &= ~(CCCR_NISO);
-	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
-
-	m_can_config_endisable(cdev, false);
-
-	/* return false if time out (-ETIMEDOUT), else return true */
-	return !niso_timeout;
+	return niso_supported;
 }
 
 static int m_can_dev_setup(struct m_can_classdev *cdev)
@@ -1694,9 +1703,6 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
-	if (cdev->ops->init)
-		cdev->ops->init(cdev);
-
 	return 0;
 }
 
@@ -1708,7 +1714,8 @@ static void m_can_stop(struct net_device *dev)
 	m_can_disable_all_interrupts(cdev);
 
 	/* Set init mode to disengage from the network */
-	m_can_config_endisable(cdev, true);
+	if (!m_can_cccr_wait_bits(cdev, CCCR_INIT, CCCR_INIT))
+		netdev_err(dev, "failed to enter standby mode\n");
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index a42600dac70d..c9937dc0d700 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -453,10 +453,18 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_power;
 	}
 
-	ret = tcan4x5x_init(mcan_class);
+	tcan4x5x_check_wake(priv);
+
+	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
 	if (ret) {
-		dev_err(&spi->dev, "tcan initialization failed %pe\n",
-			ERR_PTR(ret));
+		dev_err(&spi->dev, "Disabling interrupts failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
+	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_FLAGS,
+				      TCAN4X5X_CLEAR_ALL_INT);
+	if (ret) {
+		dev_err(&spi->dev, "Clearing interrupts failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 
-- 
2.44.0


