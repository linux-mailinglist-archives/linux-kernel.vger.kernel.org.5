Return-Path: <linux-kernel+bounces-98772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FA877F28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAAF2844A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FE3BB36;
	Mon, 11 Mar 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIXUJ69w"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D83BBD6;
	Mon, 11 Mar 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157081; cv=none; b=osOmgv5f2L2vcBHeZ3gEaMQjWFjHRw4xxk/OGQNAvKIzc/4mwGD1jOyR/eYN5PsvCuFf/MJHrppdbEZyddZf4s8WSeT8Zj3rpnpn3YlTiaIv7mj3Z1GxL3vpPKVWKAltPzsgo7HdASCnD1EqyXJt4byPZFD0rg8sRwsp5uMHwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157081; c=relaxed/simple;
	bh=Xww2rG6IPqeBhdEBP4tj86oP6xhbOOQM6z+2Z8fryGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lMjDmaZeBVNuI6rhR/KoAYFaqvgTG8g5NwK84jmtD++34Pl2z1Ok4aBw47XDlLIHD3LR1JUySxDBdDpyZi8U7UfMZU3XkI2h3sM1zD4ZQwlw3zAEmip2qNPS4vhQFzcao0jM3g18C40Kq8RIcVtFoQxoprb1EqGp5/30lPwW9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIXUJ69w; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e70d71756so2106252f8f.1;
        Mon, 11 Mar 2024 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710157078; x=1710761878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNidjb7UaHC40jeV6l+KqsqSEZYYut5toBjevl2L6WA=;
        b=KIXUJ69wYjAin6U0fUPNLGOsTITi3zuMiEIL0yI5rB2uFTHC0lTSeW54c7tb9rpKxd
         Xm+ZCk8fzXtBfuD9lE50BINvjATDdpJd0c13FfAR03TzFLAtYO3LbCceCmSnPORm7e2N
         bQy4Qf4EkB3zncZwgglHmU9qk5G8F4iJjwNrGSHZJlrnTI/jGyMO/jybNG1omLjs3lNe
         J7oLLQj1h926APPSHE7Cm3YDu2yGTM/UxR+jvxx59Y2/LGdtiu3oYEhgtpQnq2+PGty0
         SLcYrRCy2BWTMKi9MwrJJ9bx9LecYaJpmu02qOud8Cn9XxVM2Qj95ydSZ3QT7M/+KN7x
         0U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710157078; x=1710761878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNidjb7UaHC40jeV6l+KqsqSEZYYut5toBjevl2L6WA=;
        b=nab/wU0jr4ok5IDwm/WvXdzRA8vMWNIoD4lsajCxzm10vaRH0mKvmDn4cz1V+G7dux
         V3Ovzp9QdMkAgbE6KMK7FLDDDPqu/tvoTNyVZkB3G6rMboGvnQurYxJb2v4ODLcfN6AW
         buDPudFh+dhWlDDmBNPV6nzVsiA6hY93MboO5vlGicIvcCwjzUHNFAms+dWoBH7oA6lx
         03x6OsqbEffD7rH6SG+k5loHj2Qohui329nawlaHSzBZCS5lPUbtfiDzJN3qDKQkVrrz
         /o2n3bsR8i8VISQqkOmKzTYubYvLtqvw/prD1z+z5ZMiNf19GXjTp/E4l2CMXosUcMTW
         mgQw==
X-Forwarded-Encrypted: i=1; AJvYcCXAMqWHLwlNjeVb779tkZYEwBySi8xXpc9LZGJE8zBKDPW3IPJlNCKnT9RG/F3qIthmRSP5yKJK01R14czsnKijfnaC/Dm7NSLR3KvVmeUxfBLRO01mbxWyIv89JLSsL3uUuINDmoVa5EL9Dy5A3DZOFWrkVNONdyjsiIs+KTMSxZuBaYrwfHaOkr2t6ikOX5u9j88gBWgy
X-Gm-Message-State: AOJu0YyH8Gh9Qm/JBy6REsUbzw/lmdAtqtGmVXqdIO14dzbV83Ffl8TK
	09PckZzMunl8HDgcfJ7xwn79+yDAaR8t0rsgIZkvTXa+YdbhmitnwPj/fiZVJ4g=
X-Google-Smtp-Source: AGHT+IEIsQ6yMMM4IwsxEM3/4H66Xu2AGlncrFEnzBj5tNJTfxJSRuQi3ZDMKFXTcMcwoBI8gKnocg==
X-Received: by 2002:adf:a15a:0:b0:33e:9ce8:407a with SMTP id r26-20020adfa15a000000b0033e9ce8407amr966868wrr.13.1710157077815;
        Mon, 11 Mar 2024 04:37:57 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e60f:3100:f272:bc42:d450:41d1])
        by smtp.gmail.com with ESMTPSA id y3-20020adff143000000b0033dc3f3d689sm6213976wro.93.2024.03.11.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:37:57 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: mkl@pengutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails
Date: Mon, 11 Mar 2024 11:37:48 +0000
Message-Id: <20240311113748.302566-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

When the mcp251xfd_start_xmit() function fails, the driver stops
processing messages, and the interrupt routine does not return,
running indefinitely even after killing the running application.

Error messages:
[  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
[  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empty. (seq=0x000017c7, tef_tail=0x000017cf, tef_head=0x000017d0, tx_head=0x000017d3).
.. and repeat forever.

The issue can be triggered when multiple devices share the same
SPI interface. And there is concurrent access to the bus.

The problem occurs because tx_ring->head increments even if
mcp251xfd_start_xmit() fails. Consequently, the driver skips one
TX package while still expecting a response in
mcp251xfd_handle_tefif_one().

This patch resolves the issue by decreasing tx_ring->head if
mcp251xfd_start_xmit() fails. With the fix, if we trigger the issue and
the err = -EBUSY, the driver returns NETDEV_TX_BUSY. The network stack
retries to transmit the message.
Otherwise, it prints an error and discards the message.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---

V2->V3:
  - Add tx_dropped stats.
  - netdev_sent_queue() only if can_put_echo_skb() succeed.

V1->V2:
  - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() == -EBUSY.
  - Rework the commit message to address the change above.
  - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_write() succeed.
    Otherwise, we get Kernel NULL pointer dereference error.

 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 34 ++++++++++++--------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..146c44e47c60 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -166,6 +166,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
 	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct mcp251xfd_tx_obj *tx_obj;
 	unsigned int frame_len;
@@ -181,25 +182,32 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	tx_obj = mcp251xfd_get_tx_obj_next(tx_ring);
 	mcp251xfd_tx_obj_from_skb(priv, tx_obj, skb, tx_ring->head);
 
-	/* Stop queue if we occupy the complete TX FIFO */
 	tx_head = mcp251xfd_get_tx_head(tx_ring);
-	tx_ring->head++;
-	if (mcp251xfd_get_tx_free(tx_ring) == 0)
-		netif_stop_queue(ndev);
-
 	frame_len = can_skb_get_frame_len(skb);
-	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
-		netdev_sent_queue(priv->ndev, frame_len);
+
+	tx_ring->head++;
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
+	if (err) {
+		tx_ring->head--;
 
-	return NETDEV_TX_OK;
+		if (err == -EBUSY)
+			return NETDEV_TX_BUSY;
 
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+		stats->tx_dropped++;
+
+		if (net_ratelimit())
+			netdev_err(priv->ndev,
+				   "ERROR in %s: %d\n", __func__, err);
+	} else {
+		err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+		if (!err)
+			netdev_sent_queue(priv->ndev, frame_len);
+
+		/* Stop queue if we occupy the complete TX FIFO */
+		if (mcp251xfd_get_tx_free(tx_ring) == 0)
+			netif_stop_queue(ndev);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


