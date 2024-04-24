Return-Path: <linux-kernel+bounces-157527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553808B1261
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1171528F536
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46D3175563;
	Wed, 24 Apr 2024 18:24:06 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A316EBFF;
	Wed, 24 Apr 2024 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983046; cv=none; b=iuRnU3cdtdYbs/aBkFjxWKPOp8waOVenAU6Za3hypb9+zqGCYESQD+gfawb41cXpOf4g27mi9C0OTqQ/Imt8CSLhvqTEzwm7fySfpNgUGOBcV1BHljffDofSyZp2SuwYTqjTAxUVQWdz3fFNsbFseAdjEzCDqPix7IGJUPMHVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983046; c=relaxed/simple;
	bh=Nq2r/xSMTKTi9jtSRejmw3Y+UjmxAmLt/U8EyeA1a8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrAOMoYaMl80KQadMSGNGJk9y1P2WdDMqSFL4ZqVdexjUl0NyKJI/b2FCcwxlNxvZ2Kd5DyqGjvrhVpObzMqrrCUqDk37PQ7jp06pS/Q4j4WQZuqBkIRKuXHpO7wU+KSVR0uzwMTN9+LMNcUwHNlR2/Y7utP84/MMTcKpAJevns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so1437201fa.0;
        Wed, 24 Apr 2024 11:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983043; x=1714587843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBHxa/dhAV/9oWKxfTbAVhvzTVzXkONqk+9xtsxO6s4=;
        b=ZPcDRn50bw8dQWu765xFNTvI0+ICCIUUBp5ItlHsV1DmT43tZ/pQnhXhpDEHQU46Zo
         WptDjmoE3fKq0LLLCBEGcJJFHa/ZljVknmK4swJ6lTJSGHYtUxzLkwydBayT6PqQfxs/
         mC6hS6+yEQNT707NUsyTF2FEo9qGc2gWvpKlEhxx0QKNbt9VMTyE2jvVQPXBGz0cAR0w
         aMTiPs1JSDQBcgaKAUnTo6TLT8Qqqkjzr8B+fNmIbRRlHE5lR1jEEUxRAsm1zEReZFjh
         77xnOpUQm2/8G0H3nKMRReYE7f5NdNb89RVZ50qlx+SjB92esVmKyPRrDL0AgpS0b7wh
         hJTA==
X-Forwarded-Encrypted: i=1; AJvYcCUlnUwlbcgjSsjzti+eBgzZK+dluthwDgSRBO+XiX2j2fj/cIl6locBQ5dky+awUTVgGX1q+fN7FygIuP42EUbmYQ0ZYSS1n5BGYrdAkdiN7uhY3zDPDsss5PCcuM3fL4rqiHhw5s1En1Op1iY=
X-Gm-Message-State: AOJu0YyTDYJYyjt18EBrECornjGD7z5TuDqZsfTlMiWu4v1dnPK9ngSP
	hfTd0d890C25mxFsdXH+3qpQAjDritGdZpsvH8H3ICarO09dO05hSGvdpQ==
X-Google-Smtp-Source: AGHT+IFDIB5hiF3emblc38AiRWGTrPAmQvq/oxLDBOAerlKusVDaocqu4PyucwRkOdRO0cu3Z4IeBQ==
X-Received: by 2002:a2e:838b:0:b0:2de:809c:c670 with SMTP id x11-20020a2e838b000000b002de809cc670mr1567225ljg.49.1713983042412;
        Wed, 24 Apr 2024 11:24:02 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id g22-20020a056402091600b005721f9fbb60sm2259610edz.63.2024.04.24.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:24:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: leit@meta.com,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Date: Wed, 24 Apr 2024 11:23:49 -0700
Message-ID: <20240424182351.3936556-1-leitao@debian.org>
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
 drivers/net/wireless/realtek/rtw89/core.c | 11 ++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++--
 drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

PS: This is compile-tested only due to lack of hardware.

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d474b8d5df3d..ade3e2a953a1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2485,11 +2485,15 @@ void rtw89_core_napi_stop(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_core_napi_stop);
 
-void rtw89_core_napi_init(struct rtw89_dev *rtwdev)
+int rtw89_core_napi_init(struct rtw89_dev *rtwdev)
 {
-	init_dummy_netdev(&rtwdev->netdev);
-	netif_napi_add(&rtwdev->netdev, &rtwdev->napi,
+	rtwdev->netdev = alloc_netdev_dummy(0);
+	if (!rtwdev->netdev)
+		return -ENOMEM;
+
+	netif_napi_add(rtwdev->netdev, &rtwdev->napi,
 		       rtwdev->hci.ops->napi_poll);
+	return 0;
 }
 EXPORT_SYMBOL(rtw89_core_napi_init);
 
@@ -2497,6 +2501,7 @@ void rtw89_core_napi_deinit(struct rtw89_dev *rtwdev)
 {
 	rtw89_core_napi_stop(rtwdev);
 	netif_napi_del(&rtwdev->napi);
+	free_netdev(rtwdev->netdev);
 }
 EXPORT_SYMBOL(rtw89_core_napi_deinit);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fc1ed8612cf1..e206a2186747 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5239,7 +5239,7 @@ struct rtw89_dev {
 	struct rtw89_wow_param wow;
 
 	/* napi structure */
-	struct net_device netdev;
+	struct net_device *netdev;
 	struct napi_struct napi;
 	int napi_budget_countdown;
 
@@ -6211,7 +6211,7 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 				u8 *data, u32 data_offset);
 void rtw89_core_napi_start(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_stop(struct rtw89_dev *rtwdev);
-void rtw89_core_napi_init(struct rtw89_dev *rtwdev);
+int rtw89_core_napi_init(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		       struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 19001130ad94..ef41c3a83b4a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4201,7 +4201,11 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
 
-	rtw89_core_napi_init(rtwdev);
+	ret = rtw89_core_napi_init(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to init napi\n");
+		goto err_clear_resource;
+	}
 
 	ret = rtw89_pci_request_irq(rtwdev, pdev);
 	if (ret) {
-- 
2.43.0


