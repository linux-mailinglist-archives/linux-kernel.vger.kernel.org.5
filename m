Return-Path: <linux-kernel+bounces-167522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51948BAACA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FF12824DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B01514E2;
	Fri,  3 May 2024 10:33:14 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDC2AD02;
	Fri,  3 May 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732393; cv=none; b=cHa57YqB7kTv0XpYrhhD9GxvKdwKE96op3ywF1ZhivTL2TkFIW3toP4obZjzk9hp2W+48WDKNlj3s0PECfq/ntsnTKDnKuJjl5YaQVeCrrZeFuwJHAoWBKaFFUXKLS5/7KwK4d37SwcZp+07KN2na4JL2sYuZGzNNqiNqvA7W6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732393; c=relaxed/simple;
	bh=D3Cw4suYroYl98b3vp5VtitkIuzrHVZxnYf7fg0aZBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhfCPd4LwT7Kx6RYRdpMsTMXs6pxBL0gujfYkWLtlrnkr5fhAK1zZegqwtKiXeCqaXHJKfMEP5s8TSp+JOaDj3uuBa3+cmp/gpyOgA+emS7tHl5GzlOHhbAnRQmbT4JIINiB6IG789+vEylTL7HI9zs+w1LBLWlFK8gq/mqCXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572adaa172cso1984789a12.1;
        Fri, 03 May 2024 03:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714732390; x=1715337190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgIjSrOlC3C/zBBqHXfIEusT04PNgKfH3QfkG1QY7fw=;
        b=nVDg+ouDSdoMbKKbX8Fot2yWcIzy83RJNczpf0QjbFAOm/876ml9KmMXPjOYYK1krk
         HJf6wey+yonNjiSlfm0fIYxKiWxMmHv0Pc5HOxN4B0k/dpcwJlsCV/gEdWDhNFzZFHy3
         mT0M6f4SFSOdj/aKw66U+Hh/y90ctvnC0hOnPt1P15qguiPyrKxgge6ubpUXIq67kh/T
         UgD2SwXbmkECB9zah42kaFl07Vaiwl0M/DeqId2Iz1npEkyECkEAXyAn+0ioRQopINqt
         pFRK+WW4BgNfBzu4GjSF7GD3oYl5Q3G8HvYCh/z8M9AezbJtjyJVppJ6/JRnFSk+ZL+x
         y1kg==
X-Forwarded-Encrypted: i=1; AJvYcCUErnQoyVSap3aieRCHyLacCi+u4lx9vvV2+AMK1JkPYpAIvvbS7Vl6Zw69HSX300JywknjkQFr8rbwh7E1XGWcelzY7F9Jyxsvpu/N0gHfvWe6ALrZatef+Ci8GiBQb5CUbBO56v0ZbDaayM0=
X-Gm-Message-State: AOJu0Yw4zIsNGREH4LjV6KI49l4pwwDqtcyfa0OwhCr3tYiX7VEeoOi3
	ZV9e5I2N9Nfq//ivOMZS27XQCZQurDG+jSkjjzrS+ZoGW2Um5xg+rUK0Wg==
X-Google-Smtp-Source: AGHT+IE2ovpCIqF0zkwlKiDewRBWkfw2u8G1Wk5Xben92RkTReA6tRvk/tZgw/bSnkfjM0lFumWr/A==
X-Received: by 2002:a50:9e46:0:b0:572:aaaf:c349 with SMTP id z64-20020a509e46000000b00572aaafc349mr5243701ede.11.1714732390353;
        Fri, 03 May 2024 03:33:10 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id t17-20020a05640203d100b00572c15aba54sm1520276edw.17.2024.05.03.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:33:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org,
	merez@codeaurora.org,
	quic_ailizaro@quicinc.com,
	linux-wireless@vger.kernel.org (open list:WILOCITY WIL6210 WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wil6210: Do not use embedded netdev in wil6210_priv
Date: Fri,  3 May 2024 03:32:56 -0700
Message-ID: <20240503103304.339489-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from struct wil6210_priv by converting it
into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
the net_device object at wil_if_add(). The free of the device
occurs at wil_if_remove().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/wil6210/netdev.c  | 21 +++++++++++++++------
 drivers/net/wireless/ath/wil6210/wil6210.h |  2 +-
 2 files changed, 16 insertions(+), 7 deletions(-)

PS: I only compile-tested this patch due to lack of hardware.

diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index ee7d7e9c2718..d5d364683c0e 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -453,16 +453,21 @@ int wil_if_add(struct wil6210_priv *wil)
 		return rc;
 	}
 
-	init_dummy_netdev(&wil->napi_ndev);
+	wil->napi_ndev = alloc_netdev_dummy(0);
+	if (!wil->napi_ndev) {
+		wil_err(wil, "failed to allocate dummy netdev");
+		rc = -ENOMEM;
+		goto out_wiphy;
+	}
 	if (wil->use_enhanced_dma_hw) {
-		netif_napi_add(&wil->napi_ndev, &wil->napi_rx,
+		netif_napi_add(wil->napi_ndev, &wil->napi_rx,
 			       wil6210_netdev_poll_rx_edma);
-		netif_napi_add_tx(&wil->napi_ndev,
+		netif_napi_add_tx(wil->napi_ndev,
 				  &wil->napi_tx, wil6210_netdev_poll_tx_edma);
 	} else {
-		netif_napi_add(&wil->napi_ndev, &wil->napi_rx,
+		netif_napi_add(wil->napi_ndev, &wil->napi_rx,
 			       wil6210_netdev_poll_rx);
-		netif_napi_add_tx(&wil->napi_ndev,
+		netif_napi_add_tx(wil->napi_ndev,
 				  &wil->napi_tx, wil6210_netdev_poll_tx);
 	}
 
@@ -474,10 +479,12 @@ int wil_if_add(struct wil6210_priv *wil)
 	wiphy_unlock(wiphy);
 	rtnl_unlock();
 	if (rc < 0)
-		goto out_wiphy;
+		goto free_dummy;
 
 	return 0;
 
+free_dummy:
+	free_netdev(wil->napi_ndev);
 out_wiphy:
 	wiphy_unregister(wiphy);
 	return rc;
@@ -554,5 +561,7 @@ void wil_if_remove(struct wil6210_priv *wil)
 	netif_napi_del(&wil->napi_tx);
 	netif_napi_del(&wil->napi_rx);
 
+	free_netdev(wil->napi_ndev);
+
 	wiphy_unregister(wiphy);
 }
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 22a6eb3e12b7..9bd1286d2857 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -983,7 +983,7 @@ struct wil6210_priv {
 	spinlock_t eap_lock; /* guarding access to eap rekey fields */
 	struct napi_struct napi_rx;
 	struct napi_struct napi_tx;
-	struct net_device napi_ndev; /* dummy net_device serving all VIFs */
+	struct net_device *napi_ndev; /* dummy net_device serving all VIFs */
 
 	/* DMA related */
 	struct wil_ring ring_rx;
-- 
2.43.0


