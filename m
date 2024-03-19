Return-Path: <linux-kernel+bounces-107414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78A87FC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC16D28767F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AE5810A;
	Tue, 19 Mar 2024 10:48:45 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334545940;
	Tue, 19 Mar 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845325; cv=none; b=oX0Q4GCeOhZBuYw8dA5Wn0mEdUFpr+kRzXd7iCmEetJ4MzzNYyifiTkVg1vvJgmYkq/cCHBX7ZhR2hlSz09Uo6/v0MGq983jFWhZloV9wtBLPf9Rl+6T23ddTMnKooG8yhSH4iGBWLXr+V35SbzwpSItZg5Sd3CNWuG/jtzecGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845325; c=relaxed/simple;
	bh=AmY0S/XSTPSR4wg0dM/MbqWU3msGu1Ikv7x99ngue4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/hAlYCWolimWn/XBmIfED9GAT59wO2q1fb753LxzCd30fVqeuzVlkMhwNd5Cu0RTOxw2m+gCiMkDyf8XoaSweGGisZGtpmmmnqq3UYSgR5ijLyMYs2kPPu/HwUCU5r/LsBB69sap1VUo5ysX8Co+dYrGN4pzG7v8CePlppgRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46cf8f649dso196717866b.3;
        Tue, 19 Mar 2024 03:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845321; x=1711450121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Pf9ToHTFBlUcNvi0ccDec6bsbZdFOYxpbDdlfC2TV8=;
        b=Ph6KgNnMhIDOwadnVXSMOABLgwMmZJznDWHDLC36J30dUeHRAp2ffvNjZhEiOUM4Ip
         CjkuoZp3UF7e/yCwPEKvwMsysi9vzTl7mG7Ce4EW6cPZQbYLG4ZSB8rcthxIWDrxMyhV
         KT5gIpJEk4ta1pC/gWqlXxzVmOLETadImkfXWbPy7/VruXR8ew5+HDdS5eGcUtxMmp1D
         +KbXWqpzgAXNHxxbKa45Y4JKa3845uK/NmV9IdtbEwxXsc+sldd2XjITfN28Di6FK/oQ
         zPaaacREPQ2aQTeUoBnmAZ9J0f5BGV2riGj68fKD8J4VWmSaW7BuH/WzkNKpzQYAfg/y
         bZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVkCRZWbGgaE/eF1gDKDyeCervssK5inoGL/Eu4dnku/ezoj94iJFg4QEDaJU2Nj78x3RBiJp3U9Sl+ds47v/rhbOj/uPXyXwz9J8y+e/cEcXmp3KfdQL6rn9mv121O4uNo29JjlSd73yl1af0=
X-Gm-Message-State: AOJu0YwA5lU2pbKhck0fQefZV8XHNUUkTQLVdQ95bP6Js7YRxGnNtRRA
	XF95pQ5n7HBzVg4wwuh0k8XitW93Lc2PR82xi9diTdr18QGGy50w
X-Google-Smtp-Source: AGHT+IGuKBcD2QQQjVeFlvXngOSVaEvkMXfwiDGw4QgZ/UrAY/EfPNIFca1MM4+xo+QpvUeaIEoosw==
X-Received: by 2002:a17:906:3e47:b0:a46:a71d:323a with SMTP id t7-20020a1709063e4700b00a46a71d323amr1396399eji.72.1710845321329;
        Tue, 19 Mar 2024 03:48:41 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709067d5600b00a469e550472sm4108087ejp.60.2024.03.19.03.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:48:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ath10k: allocate dummy net_device dynamically
Date: Tue, 19 Mar 2024 03:47:52 -0700
Message-ID: <20240319104754.2535294-1-leitao@debian.org>
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

Un-embed the net_device from struct ath10k by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at ath10k_core_create(). The free of the device occurs
at ath10k_core_destroy().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 10 ++++++++--
 drivers/net/wireless/ath/ath10k/core.h |  2 +-
 drivers/net/wireless/ath/ath10k/pci.c  |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c |  4 ++--
 drivers/net/wireless/ath/ath10k/usb.c  |  2 +-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 9ce6f49ab261..3736517002f6 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3673,11 +3673,14 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 	INIT_WORK(&ar->set_coverage_class_work,
 		  ath10k_core_set_coverage_class_work);
 
-	init_dummy_netdev(&ar->napi_dev);
+	ar->napi_dev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
+				    init_dummy_netdev);
+	if (!ar->napi_dev)
+		goto err_free_tx_complete;
 
 	ret = ath10k_coredump_create(ar);
 	if (ret)
-		goto err_free_tx_complete;
+		goto err_free_netdev;
 
 	ret = ath10k_debug_create(ar);
 	if (ret)
@@ -3687,6 +3690,8 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 
 err_free_coredump:
 	ath10k_coredump_destroy(ar);
+err_free_netdev:
+	free_netdev(ar->napi_dev);
 err_free_tx_complete:
 	destroy_workqueue(ar->workqueue_tx_complete);
 err_free_aux_wq:
@@ -3708,6 +3713,7 @@ void ath10k_core_destroy(struct ath10k *ar)
 
 	destroy_workqueue(ar->workqueue_tx_complete);
 
+	free_netdev(ar->napi_dev);
 	ath10k_debug_destroy(ar);
 	ath10k_coredump_destroy(ar);
 	ath10k_htt_tx_destroy(&ar->htt);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index c110d15528bd..26003b519574 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1269,7 +1269,7 @@ struct ath10k {
 	struct ath10k_per_peer_tx_stats peer_tx_stats;
 
 	/* NAPI */
-	struct net_device napi_dev;
+	struct net_device *napi_dev;
 	struct napi_struct napi;
 
 	struct work_struct set_coverage_class_work;
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 5c34b156b4ff..558bec96ae40 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3217,7 +3217,7 @@ static void ath10k_pci_free_irq(struct ath10k *ar)
 
 void ath10k_pci_init_napi(struct ath10k *ar)
 {
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_pci_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_pci_napi_poll);
 }
 
 static int ath10k_pci_init_irq(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 0ab5433f6cf6..e28f2fe1101b 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2532,7 +2532,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		return -ENOMEM;
 	}
 
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll);
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 2c39bad7ebfb..0449b9ffc32d 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -935,7 +935,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(&ar->napi_dev, true);
+	dev_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
@@ -1253,7 +1253,7 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 
 static void ath10k_snoc_init_napi(struct ath10k *ar)
 {
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_snoc_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_snoc_napi_poll);
 }
 
 static int ath10k_snoc_request_irq(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 3c482baacec1..3b51b7f52130 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1014,7 +1014,7 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 		return -ENOMEM;
 	}
 
-	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_usb_napi_poll);
+	netif_napi_add(ar->napi_dev, &ar->napi, ath10k_usb_napi_poll);
 
 	usb_get_dev(dev);
 	vendor_id = le16_to_cpu(dev->descriptor.idVendor);
-- 
2.43.0


