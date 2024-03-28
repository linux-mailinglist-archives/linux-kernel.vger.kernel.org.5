Return-Path: <linux-kernel+bounces-123843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A9890EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EB7291570
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740813BC2E;
	Thu, 28 Mar 2024 23:52:46 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977141327EF;
	Thu, 28 Mar 2024 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669966; cv=none; b=MmkuDbPn7pCNmbIaHD8I3KJqEdQwXZ7F0dsjgJhzzPcxwUK7mB+8RJsdTQDISFTrbXUDrIQGUMo3Lm5M54oB/NltLFQleZ5nn30+0USVHXQfXPLm5afvgqw2aZCd/ekWkHgrLbnL2SNC6piNJrXYfBUf25bJbUYiPVbW4BsWAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669966; c=relaxed/simple;
	bh=nJNrA6Ss+TdHirJr8L1VBMtdb04kLKQRK8dvoLFdiXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIDwlp94XEXkWUlbGJPpuHkEr8jq4qHOEjzUiz4UOhDMrNc6539POdFTxNd/L5pA7eOw5FiVnKsn3T1qxD3Sa6nEE0QJOTx6KMP9R5/uNN9h9Ds/2PZa0Y0M2TdGp1os8F/YCv61fP1kQ8J67NXaYvL2X026A7FW6m/yi5loN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513e6777af4so2416670e87.2;
        Thu, 28 Mar 2024 16:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669963; x=1712274763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCPEnJesebPiik0OuG6+mv52qM3xCQ4S6Bts2WLFRHk=;
        b=MWFMReJhtmkIfuqofWTTphKr3JOcI2Pqk7yMiqU1qx/VyZJzRoHTGiZvGSgofzruzw
         0KfKRR1dP7CkqhVo4QYbwfTaT61eroYgDqmcLEU3jGfDMihGHYA8XaJq5FUwq7RiE9Wb
         dsw/MiCYsQsb3+oxR1xX6NSLbQx7qTHavagtNd4Qunp0NYnHtMHA9zFKIAThOnebYzy0
         C7uPH8y037kmz869YejuIxwlxpScnkd1RTxmXwvBAiXxrrpX3R41UWFg47sbXXtohtVs
         4MGGoMiLpohVHlBOOGXMM9cNRZUbO8aj4Bl3A3tZPIJtOoskAHpJkyM4+QVlqX7sd/Gb
         sa8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWve0ihG4PGtQl60lX/tj6d0qjhM/OejRPE0e9AVjb3ZiHgaiTzOhZ1kO1Fvl50PyKS9933tRJ9HfyPdls+NUX2T9Ote/3V+3s+tkxZ5cj5krC0QIJnNQp7DSK0tG5tsN9dGs33
X-Gm-Message-State: AOJu0YwV3qwc6HdZ0HYDHrZDM4FCVELFMS13hAonuDsiqtqxU5M39a74
	a7ZI+0UdxtLYyAzB3hHY89VJyjDuoDHBio3wX8nQ/myoelj4Wkwp
X-Google-Smtp-Source: AGHT+IE+lYitg/pFUlju14GRtcgc4gAZQxVlZsd63rvAxefRPGnR/XT2/PmcnVkwyFbKRVdamf0JdQ==
X-Received: by 2002:ac2:4add:0:b0:513:d5ec:afb with SMTP id m29-20020ac24add000000b00513d5ec0afbmr664855lfp.40.1711669962875;
        Thu, 28 Mar 2024 16:52:42 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b00a466af74ef2sm1276154ejp.2.2024.03.28.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:52:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v2 5/5] net: ibm/emac: allocate dummy net_device dynamically
Date: Thu, 28 Mar 2024 16:52:05 -0700
Message-ID: <20240328235214.4079063-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328235214.4079063-1-leitao@debian.org>
References: <20240328235214.4079063-1-leitao@debian.org>
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
 drivers/net/ethernet/ibm/emac/mal.c | 13 ++++++++++---
 drivers/net/ethernet/ibm/emac/mal.h |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 2439f7e96e05..ae2b5a2993d1 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -605,9 +605,13 @@ static int mal_probe(struct platform_device *ofdev)
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
 
-	init_dummy_netdev(&mal->dummy_dev);
+	mal->dummy_dev = alloc_netdev_dummy(0);
+	if (!mal->dummy_dev) {
+		err = -ENOMEM;
+		goto fail_unmap;
+	}
 
-	netif_napi_add_weight(&mal->dummy_dev, &mal->napi, mal_poll,
+	netif_napi_add_weight(mal->dummy_dev, &mal->napi, mal_poll,
 			      CONFIG_IBM_EMAC_POLL_WEIGHT);
 
 	/* Load power-on reset defaults */
@@ -637,7 +641,7 @@ static int mal_probe(struct platform_device *ofdev)
 					  GFP_KERNEL);
 	if (mal->bd_virt == NULL) {
 		err = -ENOMEM;
-		goto fail_unmap;
+		goto fail_dummy;
 	}
 
 	for (i = 0; i < mal->num_tx_chans; ++i)
@@ -703,6 +707,8 @@ static int mal_probe(struct platform_device *ofdev)
 	free_irq(mal->serr_irq, mal);
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
+ fail_dummy:
+	kfree(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
  fail:
@@ -739,6 +745,7 @@ static void mal_remove(struct platform_device *ofdev)
 			  (NUM_TX_BUFF * mal->num_tx_chans +
 			   NUM_RX_BUFF * mal->num_rx_chans), mal->bd_virt,
 			  mal->bd_dma);
+	kfree(mal->dummy_dev);
 	kfree(mal);
 }
 
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index d212373a72e7..e0ddc41186a2 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -205,7 +205,7 @@ struct mal_instance {
 	int			index;
 	spinlock_t		lock;
 
-	struct net_device	dummy_dev;
+	struct net_device	*dummy_dev;
 
 	unsigned int features;
 };
-- 
2.43.0


