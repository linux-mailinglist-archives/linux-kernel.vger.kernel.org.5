Return-Path: <linux-kernel+bounces-158195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE728B1CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE0E1F22E00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529978C66;
	Thu, 25 Apr 2024 08:29:28 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3A6E5FE;
	Thu, 25 Apr 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033768; cv=none; b=j3hKDSjt9PmFiUYsQchR3og7otM1vfdIGIvaRbkJn4lnS+RY6FESQW9CHMzCjfpEvVlGO5qHX67Z0i6kqAr6Azyg1p0Grxt52vwFY3k0K1s6LTy8zsRL3HaUTnxdRoo/boX9zNtctQ9R2vhBMFi/xeYqGsQgH55RF+FWFM5kpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033768; c=relaxed/simple;
	bh=/ZDatUVmmNOdDrKLhq3beVPyjGPY9UgKPG6KHF+s2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fw6JG3mddCqftA2oM1Z5B4r5he2YD8NIdJr4a6zUKw1yJxjyPQOm8LypcKCHFiYH2AUAG3L5cGDWyDHovK447XyHTlURe8D6cXAr0OB3cGYDeYsZbRHOeByTpcaNggaTz7qcckSemiZzZZsjeT8z5gEJgqsF2Zj2iQm+Y6zYdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a556d22fa93so75503166b.3;
        Thu, 25 Apr 2024 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714033764; x=1714638564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1/XovmdTy3VI68h9IXSaCtLx7m6jOBMvbb2UerIghU=;
        b=Jj//RuRsgmq72zZDUJuf0oTZ0SWyRz7oGhr+EJhnXT/W4jZmTJs1HWZrYufBQAZIvc
         9Ix1c+xxWGtLzdrslHjx77qb+dUqJnGTMttBhS2TTrIFPgSvQmyy2WidfWCKQoJnZsCE
         +eh6K2XhhHkYMZJMyJTVInHR5HDdKjt4ITOZkanWiLeCGAXol72DZhAdUReHU42z+CvV
         N0H8cvRB/eFj02biepnM8QAuSyDXXNhEyNrkzA59GMIkeOb3gcoWge1D6lJuLT7/MLes
         khugpBENXyegLB2ctmSmjsmLHuNbuEiflESWxqADAoA6dqJkJbdWd04xlKw3aep1BTTi
         jkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2tz0dirmweHDfp9RhJvruLduHqrVLYDdc9Wpx/Xfvc/SIOF6Avcc/3BNH+hZV+RjaqouZPI4zKklkZ9ow7P2wMVGP8YShhdRoqhd+RNwdoxmaE/qs0sFBMABAQPVdnVwBbiElpjeL/VoYqsY=
X-Gm-Message-State: AOJu0Yz9daj83aXrz3hFksFjD/P2ypHc8vGt9ftwfiTc5bos2WDXdqw9
	tEcaEK/r3GbvRWS93frWhF6diFQ4WXdbERO56PCykC6XxtG7L0VG
X-Google-Smtp-Source: AGHT+IEW9CcgF7YqLEK7bW3ejg1NJU2GzXyM13uyiLbEvob+9GOKkwQHD3THqynRBX/b2miBq0W6pA==
X-Received: by 2002:a17:907:7241:b0:a58:aa82:778d with SMTP id ds1-20020a170907724100b00a58aa82778dmr1285050ejc.63.1714033764017;
        Thu, 25 Apr 2024 01:29:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id og19-20020a1709071dd300b00a58bef9e471sm55766ejc.111.2024.04.25.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 01:29:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: leit@meta.com,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw88)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: rtw88: Un-embed dummy device
Date: Thu, 25 Apr 2024 01:29:09 -0700
Message-ID: <20240425082910.2824393-1-leitao@debian.org>
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

Un-embed the net_device from the private struct by converting it
into a pointer. Then use the leverage the new alloc_netdev_dummy()
helper to allocate and initialize dummy devices.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 17 +++++++++++++----
 drivers/net/wireless/realtek/rtw88/pci.h |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

PS: This is compile-tested only due to lack of hardware to do better
testing.

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 9986a4cb37eb..4ff4f875cefb 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1681,12 +1681,16 @@ static int rtw_pci_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static void rtw_pci_napi_init(struct rtw_dev *rtwdev)
+static int rtw_pci_napi_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 
-	init_dummy_netdev(&rtwpci->netdev);
-	netif_napi_add(&rtwpci->netdev, &rtwpci->napi, rtw_pci_napi_poll);
+	rtwpci->netdev = alloc_netdev_dummy(0);
+	if (!rtwpci->netdev)
+		return -ENOMEM;
+
+	netif_napi_add(rtwpci->netdev, &rtwpci->napi, rtw_pci_napi_poll);
+	return 0;
 }
 
 static void rtw_pci_napi_deinit(struct rtw_dev *rtwdev)
@@ -1695,6 +1699,7 @@ static void rtw_pci_napi_deinit(struct rtw_dev *rtwdev)
 
 	rtw_pci_napi_stop(rtwdev);
 	netif_napi_del(&rtwpci->napi);
+	free_netdev(rtwpci->netdev);
 }
 
 int rtw_pci_probe(struct pci_dev *pdev,
@@ -1744,7 +1749,11 @@ int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_pci_declaim;
 	}
 
-	rtw_pci_napi_init(rtwdev);
+	ret = rtw_pci_napi_init(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to setup NAPI\n");
+		goto err_pci_declaim;
+	}
 
 	ret = rtw_chip_info_setup(rtwdev);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 0c37efd8c66f..13988db1cb4c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -215,7 +215,7 @@ struct rtw_pci {
 	bool running;
 
 	/* napi structure */
-	struct net_device netdev;
+	struct net_device *netdev;
 	struct napi_struct napi;
 
 	u16 rx_tag;
-- 
2.43.0


