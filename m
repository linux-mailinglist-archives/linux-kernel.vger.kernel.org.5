Return-Path: <linux-kernel+bounces-70904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94865859DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74AE1C21F34
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8121353;
	Mon, 19 Feb 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o7TGhRmT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F8C8D6;
	Mon, 19 Feb 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329668; cv=none; b=T9USjC//3nIGyYSFgi2nT0nfdQHzQRWA7byPRKVohtjsQOiOgOi9jRV05Fvo04fG3NckBvgvrHx6IRTU9KhravczRJlBuNy1+6uAJ4yUX2PmHqoD57l0NCsflEmNY6ntQSrGP90RwcJJbIsjlGI08/vGD6EOMfWjcBxTZpXOvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329668; c=relaxed/simple;
	bh=rfQkQXfU5XnbLWnwEW1iiJydHy5t2btASLhVXbbDWdw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCL5e4k/PDndPrrVCxwiGZ8nOxS8qneEgJA1VWAmcWhkLGGiIpJ37hv0m4Aq01ZzwI2aIcgHMr4Fx3qSWFdyEYbTL6xWIEJhLK76wutWob4NEcST9zzGVqJGd+7oTJZuz1iVrgCwVum+q0qweDOnc3KuVk8k+WeF2JHD6mwni3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o7TGhRmT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708329666; x=1739865666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rfQkQXfU5XnbLWnwEW1iiJydHy5t2btASLhVXbbDWdw=;
  b=o7TGhRmTYZF2XT1nrisU4e5Mrtwp+eCJl3uSf27mDp0B+DXo12k7bQBo
   0UUcOevK6kjH8VSh31DX3wSjto74g3mtMw0Znh/WLtnykZ9DCD4ua1Q9P
   PUxiiNyp80FxdgkQkrql+kkpmOCE6NVwXdS/SVp5t8BDs6yh5MhC6mF8S
   r1oT4DGxDOvWwGQ634iojxBSWu9Vu+PTLru0TzakKc2H7GaJ1754q0ef8
   FnkCr9Umkj1QG79So2lVMTAQnEvC+B83uA1kP4OXuDpxc1caKc89KAJJz
   cYsg/mgY772jWw0ROygPPaQvvyGKwJSlOCsS0DwgInpOcfTDQXBPShzRc
   Q==;
X-CSE-ConnectionGUID: 0bIe6Jl+SMycL+aUC1NHPA==
X-CSE-MsgGUID: XC9el0JIT7ONn6Wduk/pEg==
X-IronPort-AV: E=Sophos;i="6.06,170,1705388400"; 
   d="scan'208";a="247196761"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2024 01:00:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 01:00:49 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 01:00:46 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>
CC: <rmk+kernel@armlinux.org.uk>, <u.kleine-koenig@pengutronix.de>,
	<yuehaibing@huawei.com>, <vladimir.oltean@nxp.com>,
	<bjarni.jonasson@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net v3] net: sparx5: Add spinlock for frame transmission from CPU
Date: Mon, 19 Feb 2024 09:00:43 +0100
Message-ID: <20240219080043.1561014-1-horatiu.vultur@microchip.com>
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
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
---
v2->v3:
- add missing fix tag as it is targeting net
v1->v2:
- target net instead of net-next
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


