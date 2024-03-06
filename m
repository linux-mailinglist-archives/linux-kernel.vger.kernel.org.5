Return-Path: <linux-kernel+bounces-93550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F0873163
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D399B29DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493E5F561;
	Wed,  6 Mar 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gM8Wsnz9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254565DF06;
	Wed,  6 Mar 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715157; cv=none; b=GXEZ7CSaapXMFdV5QkiEUV4OTCbfG4AceC++qtnYpZFLY3AB57lbIZeKqB12Rx7RcKQlxjFEVA2HFHfqlsU+BeGEldV0G7pPy5hx7fOOIWK7KFetuUeC1LEH0+1YGm1hhTUQcToqwFK/s05Ui56PIlSTa7T8On/oYJo8EIJVMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715157; c=relaxed/simple;
	bh=u8RNfQJSfBD4CTcSoHRc57cRo+AIbvV0rFYkwscolfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMjhI7oCQ7EdvY6AiX23BUrokq8oOdDeBrB7DwHe5dd9TJLmAiCyc+LMEahqV5w+lKrH0eSFmyb71HX9F/MZrCTk1omYYud/BTICjSqN+zw6e+/CnfMfC30iW0eABAFJ88Ef1vdAk5t9AbJVsrcJNA1Q+dKRp9oS4CmKJue3ToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gM8Wsnz9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709715156; x=1741251156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u8RNfQJSfBD4CTcSoHRc57cRo+AIbvV0rFYkwscolfE=;
  b=gM8Wsnz9RAbFLt+8fmkL19ZYgMJujmOS7lWma4tNQTgTT+OfQdi2mzbY
   bQ2/NhEEtD8bSP3eHKmYXaIo2/2NnUhssR4Ek1bDkyeLuRL2H0s73lPia
   9Vr6nbPcEuuXDMnhBcasCKygJ6KSc/x1Ax1Yt0OgCiINpuwoDFu/Q4VuB
   aXFFpoOaahTaVn083kjTLZe6iqgbGZt1icS8SiRJRdZ0FQzEAoBNX0b+a
   ACx/l6ItTt+Hc0Jc4dZU/DC1W/ujd9cS4c1Yt7AoiH0MZXYQRFDdS9mTm
   sNFn7f2pLt01JxqEBpGHY5xIFvNSGXqcrFejwLHJVbLMaL+y/Lg6lZg9l
   g==;
X-CSE-ConnectionGUID: XrZwrAXjR6uEKFj3VAoGjA==
X-CSE-MsgGUID: y7hBojv4Q6KY7bpIS5iDzA==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="17813767"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 01:52:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:52:09 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 01:52:00 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v3 10/12] net: ethernet: oa_tc6: implement mac-phy interrupt
Date: Wed, 6 Mar 2024 14:20:15 +0530
Message-ID: <20240306085017.21731-11-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MAC-PHY interrupt is asserted when the following conditions are met.

Receive chunks available - This interrupt is asserted when the previous
data footer had no receive data chunks available and once the receive
data chunks become available for reading. On reception of the first data
header this interrupt will be deasserted.

Transmit chunk credits available - This interrupt is asserted when the
previous data footer indicated no transmit credits available and once the
transmit credits become available for transmitting transmit data chunks.
On reception of the first data header this interrupt will be deasserted.

Extended status event - This interrupt is asserted when the previous data
footer indicated no extended status and once the extended event become
available. In this case the host should read status #0 register to know
the corresponding error/event. On reception of the first data header this
interrupt will be deasserted.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 44 +++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 93b9afafdf9c..e8c1bd7ba3a5 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -118,6 +118,7 @@ struct oa_tc6 {
 	u16 tx_credits;
 	u8 rx_chunks_available;
 	bool rx_buf_overflow;
+	bool int_flag;
 };
 
 enum oa_tc6_header_type {
@@ -981,6 +982,14 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
 		if (tc6->rx_chunks_available)
 			spi_length = oa_tc6_prepare_spi_tx_buf_for_rx_chunks(tc6, spi_length);
 
+		if (tc6->int_flag) {
+			tc6->int_flag = false;
+			if (spi_length == 0) {
+				oa_tc6_add_empty_chunks_to_spi_buf(tc6, 1);
+				spi_length = OA_TC6_CHUNK_SIZE;
+			}
+		}
+
 		if (spi_length == 0)
 			break;
 
@@ -1018,8 +1027,10 @@ static int oa_tc6_spi_thread_handler(void *data)
 	int ret;
 
 	while (likely(!kthread_should_stop())) {
-		/* This kthread will be waken up if there is a tx skb */
-		wait_event_interruptible(tc6->spi_wq,
+		/* This kthread will be waken up if there is a tx skb or mac-phy
+		 * interrupt to perform spi transfer with tx chunks.
+		 */
+		wait_event_interruptible(tc6->spi_wq, tc6->int_flag ||
 					 !skb_queue_empty(&tc6->tx_skb_q) ||
 					 kthread_should_stop());
 		ret = oa_tc6_try_spi_transfer(tc6);
@@ -1050,6 +1061,24 @@ static int oa_tc6_update_buffer_status_from_register(struct oa_tc6 *tc6)
 	return 0;
 }
 
+static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
+{
+	struct oa_tc6 *tc6 = data;
+
+	/* MAC-PHY interrupt can occur for the following reasons.
+	 * - availability of tx credits if it was 0 before and not reported in
+	 *   the previous rx footer.
+	 * - availability of rx chunks if it was 0 before and not reported in
+	 *   the previous rx footer.
+	 * - extended status event not reported in the previous rx footer.
+	 */
+	tc6->int_flag = true;
+	/* Wake spi kthread to perform spi transfer */
+	wake_up_interruptible(&tc6->spi_wq);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * oa_tc6_start_xmit - function for sending the tx skb which consists ethernet
  * frame.
@@ -1168,8 +1197,19 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 
 	sched_set_fifo(tc6->spi_thread);
 
+	ret = devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macphy_isr,
+			       IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->dev),
+			       tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "Failed to request macphy isr %d\n",
+			ret);
+		goto kthread_stop;
+	}
+
 	return tc6;
 
+kthread_stop:
+	kthread_stop(tc6->spi_thread);
 phy_exit:
 	oa_tc6_phy_exit(tc6);
 	return NULL;
-- 
2.34.1


