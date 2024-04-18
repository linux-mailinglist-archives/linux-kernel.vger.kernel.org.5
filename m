Return-Path: <linux-kernel+bounces-150118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D488A9AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D18B21B43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB616C684;
	Thu, 18 Apr 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q7qy9CjI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5D15FA79;
	Thu, 18 Apr 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445104; cv=none; b=SfPzsd5loijD+qHNRD3xqSPgIbXt+XX0G95LMNGtAI/958uTNW1ZoXVN56hNx+/NOzoNekwfW4NigNwqxuWN3hiT+jyDSLXLwzS/ryDgWPU74Q10iEtXgGEVvVteqwzdlwdaHXQ02Ny5fTMXpkVepFoRWFzdaEV7F28z81cINNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445104; c=relaxed/simple;
	bh=gU4jE9Nrae06Hh6Vsjjs6cjfPnn3F13jrWNplZXRKLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcC7xZLtuKZT5MWt/JpFy5TKEIjEM5+Ta2oYPL/WPUu8PxHf3hjgcoRe3ccSwqvUptvOTUdoeVaqFk6VSm3GQCdgwMcRQ62GsmuPOeUJZWZmmJkvdZYF7Z9GoEk4V2gpMi9+yRT1XnP/F/6pl2QM69X+627dYCjT/MTdSays/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q7qy9CjI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713445103; x=1744981103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gU4jE9Nrae06Hh6Vsjjs6cjfPnn3F13jrWNplZXRKLI=;
  b=Q7qy9CjIjQeWa2XtY0K24q7L1prRIPPLDPKOi8WJyHYm91rOMy1Mkbum
   yN/PESagiZVWSViu0Hw8UWvo+XOKFybdMKFD20eg7sDf4/kN8XQtCj1Z7
   jpDgJ3//mlK25fwyCRpL8KdvTkZAnzh5s9yRqLpZL6XLd8YeA6mxTrq8x
   J8YuyngcbKhhzH7v/OGl6JhHBTvxLEr62RV7Cr6hzQk4uKxZNyFv+2qt9
   xPBY0jNoxbZ6x4x6x8FPOA7E5hh5IcdzhRn1kNvKcqcy+2hVro8rcauci
   u82AE/TyNIxjSWmsjWSws85OXBgINxsPrlqVTE81yOyaNyFljhVRO9/8z
   Q==;
X-CSE-ConnectionGUID: Xcx2pWi4Tle/BYeos1za0g==
X-CSE-MsgGUID: igZxCqx6RQ2MEzd2NulNWg==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="21604098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 05:58:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 05:58:12 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 05:58:04 -0700
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
Subject: [PATCH net-next v4 10/12] net: ethernet: oa_tc6: implement mac-phy interrupt
Date: Thu, 18 Apr 2024 18:26:46 +0530
Message-ID: <20240418125648.372526-11-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
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
 drivers/net/ethernet/oa_tc6.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index fa08956a855f..9f17f3712137 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -127,6 +127,7 @@ struct oa_tc6 {
 	u16 tx_credits;
 	u8 rx_chunks_available;
 	bool rx_buf_overflow;
+	bool int_flag;
 };
 
 enum oa_tc6_header_type {
@@ -1050,6 +1051,14 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
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
 
@@ -1085,8 +1094,10 @@ static int oa_tc6_spi_thread_handler(void *data)
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
 
@@ -1121,6 +1132,24 @@ static int oa_tc6_update_buffer_status_from_register(struct oa_tc6 *tc6)
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
@@ -1245,8 +1274,28 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 
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
+	/* oa_tc6_sw_reset_macphy() function resets and clears the MAC-PHY reset
+	 * complete status. IRQ is also asserted on reset completion and it is
+	 * remain asserted until MAC-PHY receives a data chunk. So performing an
+	 * empty data chunk transmission will deassert the IRQ. Refer section
+	 * 7.7 and 9.2.8.8 in the OPEN Alliance specification for more details.
+	 */
+	tc6->int_flag = true;
+	wake_up_interruptible(&tc6->spi_wq);
+
 	return tc6;
 
+kthread_stop:
+	kthread_stop(tc6->spi_thread);
 phy_exit:
 	oa_tc6_phy_exit(tc6);
 	return NULL;
-- 
2.34.1


