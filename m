Return-Path: <linux-kernel+bounces-63495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21017853062
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D235E283779
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465E2BB0A;
	Tue, 13 Feb 2024 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gihk+qJb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B73D0D4;
	Tue, 13 Feb 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826759; cv=none; b=YRkIX0IaFdHOFMw+Rg/MBdJTRpCrFT+A8EicMmOUUaMfY+zDKjm4hrRYhXR8fdf17UGhJWrXOQOtpcLAo6aYOXns8k1SgJcWu/EZhtWOWJYzBKJiYGz4d2kAlua1QKhot9bd2sehKM56Zr4cfOyzpf8dLZVNukXjZAO/n6VFhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826759; c=relaxed/simple;
	bh=/fjyZrBDLYmTpMFfS2OHSx6WkJIwJVBJ2XSyeuGpNNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lQAsPte/lFsdtxphwfxw3H7m8QtZ+2LhRnvdNMC1WJIBr37vCvICetXbWoTFWO06VPLl9XRCyN6KbtlQnNBZFNI//iY0BGszHzQ9pSlOEZ+LOGtSecyy/wlZixnyqfak6lzGH/loZEtITk9M/jtdNqn9eWtPIaw+Tz0/J1su7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gihk+qJb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707826757; x=1739362757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/fjyZrBDLYmTpMFfS2OHSx6WkJIwJVBJ2XSyeuGpNNs=;
  b=gihk+qJbAMpusLVdgkRl0TTHTxZPxoyVT6D6b6XSlBGBQHiz7AB6rLev
   QGhx3NkjSOfByU7t42tFyAn0dVnbgenU/hDsGwWVQaRU1YeBxTEOT9HdN
   +48MAQCpgIU0I/sFhVeauKjV0hiGS3B+sfwuOgiEP7YQmiMyiUK0mAmyV
   lh4K3G+cY4H1Af1/wHLIGtwaxY6wc8xsTNTMifPRHVZqyGngrgHn6njmy
   O7OZEYFnO6UJfL3L2tgoI0MELMUZ/uQzRlSLsfLA+nHgEgKxVnjpcrD17
   FNMTFFKNRIDdGuMwQragC/RT+bBb2O2EwfMky2Aak7a64WGvtnx/YmmEl
   A==;
X-CSE-ConnectionGUID: wLQvEHzgQYe+b74dcDn/DQ==
X-CSE-MsgGUID: 2q/bPEAUQlSu9JSpAF1pdQ==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="16684392"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 05:19:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 05:18:45 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 05:18:42 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>
CC: <u.kleine-koenig@pengutronix.de>, <rmk+kernel@armlinux.org.uk>,
	<vladimir.oltean@nxp.com>, <jacob.e.keller@intel.com>,
	<yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: sparx5: Add spinlock for frame transmission from CPU
Date: Tue, 13 Feb 2024 13:17:05 +0100
Message-ID: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Both registers used when doing manual injection or fdma injection are
shared between all the net devices of the switch. It was noticed that
when having two process which each of them trying to inject frames on
different ethernet ports, that the HW started to behave strange, by
sending out more frames then expected. When doing fdma injection it is
required to set the frame in the DCB and then make sure that the next
pointer of the last DCB is invalid. But because there is no locks for
this, then easily this pointer between the DCB can be broken and then it
would create a loop of DCBs. And that means that the HW will
continuously transmit these frames in a loop. Until the SW will break
this loop.
Therefore to fix this issue, add a spin lock for when accessing the
registers for manual or fdma injection.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c   | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h   | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index d1f7fc8b1b71a..3c066b62e6894 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -757,6 +757,7 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sparx5);
 	sparx5->pdev = pdev;
 	sparx5->dev = &pdev->dev;
+	spin_lock_init(&sparx5->tx_lock);
 
 	/* Do switch core reset if available */
 	reset = devm_reset_control_get_optional_shared(&pdev->dev, "switch");
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 6f565c0c0c3dc..316fed5f27355 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -280,6 +280,7 @@ struct sparx5 {
 	int xtr_irq;
 	/* Frame DMA */
 	int fdma_irq;
+	spinlock_t tx_lock; /* lock for frame transmission */
 	struct sparx5_rx rx;
 	struct sparx5_tx tx;
 	/* PTP */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index 6db6ac6a3bbc2..ac7e1cffbcecf 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -244,10 +244,12 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb_tx_timestamp(skb);
+	spin_lock(&sparx5->tx_lock);
 	if (sparx5->fdma_irq > 0)
 		ret = sparx5_fdma_xmit(sparx5, ifh, skb);
 	else
 		ret = sparx5_inject(sparx5, ifh, skb, dev);
+	spin_unlock(&sparx5->tx_lock);
 
 	if (ret == -EBUSY)
 		goto busy;
-- 
2.34.1


