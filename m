Return-Path: <linux-kernel+bounces-167500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC908BAA78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB52C1C219FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22C150993;
	Fri,  3 May 2024 10:04:54 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCBE14F9E8;
	Fri,  3 May 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730693; cv=none; b=Eo4AddBY1VHJP8HPNfl9ThcGI+Ab68Lh5FBdzf1kgNkzVB5nCb8j6YFSP+Plyp9rlsO9mRgCxVrWsmsLTbqU7O+rf3HnefSMT/TznSPkWP9XTz3E6y/X1sTpKiFpTSsK4K/ClnwKDi6F9JMCCwwc1ILNiX9PWDTTOMQtw93xyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730693; c=relaxed/simple;
	bh=qACal944bQbWQEFiDpgDFJ/ewySer9S+1JK+mVUz6TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUZsDhIlM9GUDTUzpmmsVpuQYdxyxt1vILKzLAgYjUdIFVkYwzSTQ3yAB+eEjMkcFYffCkO3PhRWhVjgCttcO6RiCg2lmy+adRc9hg6CyFLY9tkPP/UFAvniER+S1TpuI5+ZviVVuXScD5LEofXE0ZPY/6nSeRR4dChAZkqjFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso24911a12.0;
        Fri, 03 May 2024 03:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730690; x=1715335490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8adb3W1BmkNUKKb1fEwqwjiASLtL+TBOu09daXzuP4=;
        b=aiReQ8vB5dA/mUd5aKxEchvFSsVandyEDL8E/HdxlhIfEMS9oHwh+fwY3V0c9b6ScX
         ZGPQNVpHzwsLy7dK+UTkS7gACCUd8Xj78WxOGoq87b1greYZp9FtKvZOuHnW21kKIZmb
         doDa9yHZdPglgnaE/vOCSXk5QvzL5XZdbq/vNoiDp129HE1IxJbRRK+IQVe2kpF5zNar
         787LKQWgFgKYDmIkQjwI6PgoPcX1oR8yxinmA88VkQjZ6pX6KxrbNqU5pXd4kNjZhYlF
         8Ne+c9+Kep0cqsejhm1Kk2JOns1n+F7wreRzDPGOwHnoTzB4oVYCzmH+mK8VC3S2klYd
         Ag5g==
X-Forwarded-Encrypted: i=1; AJvYcCUnX33j7ThMgixgvsZk3ADrrsui7mSK68L961w1/dCKvdx5/a3xPn5Dp6sdq5p2kXHG8M4PWXpuBx/IcU/BJtLBCMEQkXLD1V6pb5D/BLutZ6knxXQNoFsnNkfDVylUDpRIQzmppsJv3vpJ1RY=
X-Gm-Message-State: AOJu0YzI9sPFKpfp0yNxFiicIgMoesI3ewqTqEnr7pEApOeWu1oRJY4L
	T2TEeMrtVDzsVehNEQ72n/w6Bn6QA0QEPH8QXK9qFyVLS8Te20z/EU1flQ==
X-Google-Smtp-Source: AGHT+IFPf0CsqCaKdeCEgTGaKjbBlZc73fEjsXVrU0FhdVphBZ6Wbe4pceZhVttNvEkA48TuIAipCg==
X-Received: by 2002:a50:9fa8:0:b0:56e:60d:9b16 with SMTP id c37-20020a509fa8000000b0056e060d9b16mr1350536edf.6.1714730689864;
        Fri, 03 May 2024 03:04:49 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b00572469a7948sm1559882edc.45.2024.05.03.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:04:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: ath12k: allocate dummy net_device dynamically
Date: Fri,  3 May 2024 03:04:39 -0700
Message-ID: <20240503100440.6066-1-leitao@debian.org>
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

Un-embed the net_device from struct ath12k_ext_irq_grp by converting it
into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
the net_device object at ath12k_pci_ext_irq_config().

The free of the device occurs at ath12k_pci_free_ext_irq().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

This is *very* similar to the same changes in ath11k commit
bca592ead82528b ("wifi: ath11k: allocate dummy net_device dynamically")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c  | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..71c67f47d0ad 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -144,7 +144,7 @@ struct ath12k_ext_irq_grp {
 	u32 grp_id;
 	u64 timestamp;
 	struct napi_struct napi;
-	struct net_device napi_ndev;
+	struct net_device *napi_ndev;
 };
 
 struct ath12k_smbios_bdf {
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 14954bc05144..322f0ad1b12d 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -350,6 +350,7 @@ static void ath12k_pci_free_ext_irq(struct ath12k_base *ab)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
 
 		netif_napi_del(&irq_grp->napi);
+		free_netdev(irq_grp->napi_ndev);
 	}
 }
 
@@ -560,7 +561,7 @@ static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
 static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 {
 	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
-	int i, j, ret, num_vectors = 0;
+	int i, j, n, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0, base_idx;
 
 	base_idx = ATH12K_PCI_IRQ_CE0_OFFSET + CE_COUNT_MAX;
@@ -577,8 +578,11 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 
 		irq_grp->ab = ab;
 		irq_grp->grp_id = i;
-		init_dummy_netdev(&irq_grp->napi_ndev);
-		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
+		irq_grp->napi_ndev = alloc_netdev_dummy(0);
+		if (!irq_grp->napi_ndev)
+			return -ENOMEM;
+
+		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
 			       ath12k_pci_ext_grp_napi_poll);
 
 		if (ab->hw_params->ring_mask->tx[i] ||
@@ -611,6 +615,10 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 			if (ret) {
 				ath12k_err(ab, "failed request irq %d: %d\n",
 					   vector, ret);
+				for (n = 0; n <= i; n++) {
+					irq_grp = &ab->ext_irq_grp[n];
+					free_netdev(irq_grp->napi_ndev);
+				}
 				return ret;
 			}
 		}
-- 
2.43.0


