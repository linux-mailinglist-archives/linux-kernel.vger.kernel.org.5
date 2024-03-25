Return-Path: <linux-kernel+bounces-118128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C70988B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF591FA00F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F98127B7B;
	Mon, 25 Mar 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHGxpk2C"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969A80612;
	Mon, 25 Mar 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406035; cv=none; b=L+CY12xfy/VK1soy3YID48bKv4Qp9HQuyk93CS08QqvVRiuS09OpGzx86pYAD6yAGLx7oqqRwwOMqVsJZzPbBjGxpcuoPgrkKTS/1jPGssa9cDk31oACjZZSBCw9roBL7KS04usnbRITsq4JM+pV7csLanPFbgL33I4Ic3xdWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406035; c=relaxed/simple;
	bh=hR5gPGyRksPDZ4TslRTW+UsNvNtCATeSuNhxpv3PE88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ODTsu8OdhuyXKIaMrMR4A64oUjA7khiC+MIWlMaRqnHh9aXlC4Cqyo0PLRU63SQNBSdKl2K5E4ZDt0jIDUMyd2eErMtPK57P94n4sU5fqNiFnOPpfqOplff0DuA+9sx392jU8FVD7k9fa5/Eiv3YYlSFn6VabzKlDS/Lhx/l4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHGxpk2C; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-515a81928a1so2954423e87.3;
        Mon, 25 Mar 2024 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406031; x=1712010831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj0lKCneUUNFpuWmlMG2eg6t5bdla+97utz0tzfjT9c=;
        b=QHGxpk2COqVL+nu5pCLA1RwpJHl7etQEm0ZnRsDjf6aLRfGD0yjS7dVmdie9RaeNJG
         sgsQqvxrHSOKkaf2sSKuziOx5z1dyIzJPjJngLH2dvrnJDJ8THvRuvIRKwR25IrLxpXg
         4kG+WWqAlnpvVayW9oE6XMzzx7LqoSRNOlbe85Kckf/xGKQ6mM6ykAjiu5zUrVpI7D1F
         06zx/wylgsHSoMu3wjAup5kwp7N3LpBrvjrnBA+1mrCXLdilcY4DG0tmzOBKNRvQVN8H
         lRHcUGZnWi+ZgQj8MI0+woR35I+At+HkxFsptBi5dIZpcY3Lmwthlp2JZbu9qUNOu/bI
         xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406031; x=1712010831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj0lKCneUUNFpuWmlMG2eg6t5bdla+97utz0tzfjT9c=;
        b=GA3yWbDzAk8xL3I/Y8jqerTlYov+I/BejRSC+3VPE1nw/6CMJ/B2J2CgSo3MT03emT
         O1jZqCMX5wh7GojDu/hOzfakNUggwJHsJdMP0d23qTRJ/Ij86dXoUR6uEn1sK5NG2bPC
         MDK0oJzG9C7nphYf+e4eapOt1ugEobsDGPScLITmef8AQGYeaK1ndEVfWQK22GogHrXZ
         h2kctcRCvw1kDYnkdTJOXWiNBadM11y+jyIh8kURJyjABQLyIeo+Kv1YUr5J0ZlJTaD9
         iLqmhEV1cADzGFOcSTn3HZD89DHgOLbXSBYx8ofondrBS4w1QaeL8qnPCkg6U75NDexh
         YS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOTMbQGNma81i1Jjt2Ovz+racZz3KCjwKKkAEOuODzyveP36+XnHXkzhvMgp3kZLEot+cP0r4gvWbcYx3AJHQZQp1zLV0bCThVOgzr/2nnekpjZ6dgRkgVStddczttxDYRP1oBENO2JfcqpDc=
X-Gm-Message-State: AOJu0YwZS24lyzM8gcqU1Z+1q7R5yRkESU9ipr1OA+dz2oX2D/QEi4n2
	HDDGfCx47Ezd7XWIdJFQZLW5XO3LQaalH9Em808vuc5YmLIZS9+p
X-Google-Smtp-Source: AGHT+IFEdSvP4N4t9jGkeQXZI3vk9OxPvkV4RxMgtnTvFQKLCtONSH/wLY9I5+xWuiI6522NGNrFLA==
X-Received: by 2002:a05:6512:b8a:b0:515:b0be:3a42 with SMTP id b10-20020a0565120b8a00b00515b0be3a42mr2443071lfv.33.1711406031115;
        Mon, 25 Mar 2024 15:33:51 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906081500b00a4df251a601sm89295ejd.77.2024.03.25.15.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:50 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	openwrt-devel@lists.openwrt.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] wifi: mt76: mt7603: add debugfs attr for disabling frames buffering
Date: Mon, 25 Mar 2024 23:33:19 +0100
Message-Id: <20240325223319.30125-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7603EN and MT7628AN were reported by multiple users to be unstable
under high traffic. Transmission of packets could stop for seconds often
leading to disconnections.

Long research & debugging revelaed a close relation between MCU
interrupts of type PKT_TYPE_TXS and slowdowns / stalls. That led to
questioning frames buffering feature.

It turns out that disabling SKBs loopback code makes mt7603 devices much
more stable under load. There are still some traffic hiccups but those
happen like once every an hour and end up in recovery in most cases.

Add a debugfs option for disabling frames buffering so users can give it
a try. If this solution yields a success we can make this feature
disabled by default.

This change was successfully tested using 2 GHz AP interface on:
1. Netgear R6220 - MT7621ST (SoC) + MT7603EN (WiFi) + MT7612EN (WiFi)
2. Xiaomi Mi Router 4C - MT7628AN (Wi-Fi SoC)

Link: https://lore.kernel.org/linux-wireless/7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com/
Closes: https://github.com/openwrt/mt76/issues/865
Fixes: c8846e101502 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 3967f2f05774..c80baba7a402 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -115,4 +115,6 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 			    &dev->sensitivity_limit);
 	debugfs_create_bool("dynamic_sensitivity", 0600, dir,
 			    &dev->dynamic_sensitivity);
+	debugfs_create_bool("frames_buffering", 0600, dir,
+			    &dev->frames_buffering);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 7a2f5d38562b..f5ab729dec31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -27,6 +27,9 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	u32 val;
 	u8 tid = 0;
 
+	if (!dev->frames_buffering)
+		goto free;
+
 	if (skb->len < MT_TXD_SIZE + sizeof(struct ieee80211_hdr))
 		goto free;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 6c55c72f28a2..5abc2618ec8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -515,6 +515,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	dev->slottime = 9;
 	dev->sensitivity_limit = 28;
 	dev->dynamic_sensitivity = true;
+	dev->frames_buffering = true;
 
 	ret = mt7603_init_hardware(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 9e58df7042ad..02c88334cdc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -155,6 +155,8 @@ struct mt7603_dev {
 	u32 reset_test;
 
 	unsigned int reset_cause[__RESET_CAUSE_MAX];
+
+	bool frames_buffering;
 };
 
 extern const struct mt76_driver_ops mt7603_drv_ops;
-- 
2.35.3


