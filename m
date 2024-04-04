Return-Path: <linux-kernel+bounces-131342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17289867E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E905E2850CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A53129A9A;
	Thu,  4 Apr 2024 11:50:07 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA744129A7B;
	Thu,  4 Apr 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231407; cv=none; b=s8c4EYx0x+KkjCk5McXUu/TMcTMukNeMZWvBQP4Hahx4b2d4qP4EQaDvwNbZtJSIPY9uIFTZH7YSdCaH2iTqoO6OAQv5doKPdO1DG6XGYGXtRrfNghXyw7Tqf2AJB0h8y39weBibVtmWJDF/UOBrmZRbsFXNOKGdSL9HBpwfH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231407; c=relaxed/simple;
	bh=MB8+/MFHOEltGh7GM7e6UBLJe+yCPGpUyEgMI44tcDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnNE6C5NViLpZfySoHBE3rEWMlP/CsObuJOaIcJqd9QOY7XPRi+eQH5zAV9F+ikdE/CVrYXKFyGiMmM4bl2q4uOQbUZvXoYZICcXATx6brPbDxojUesuR+WZXFpmz4FnZFCO+jAtp7Q+6/LEd4kqj8nyavP2zP9JpnMZGK7dfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51969e780eso12638866b.3;
        Thu, 04 Apr 2024 04:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231404; x=1712836204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsBGQlMm+F00sLCL/qlkhF4TnT6nst/CdHn7pOQlov8=;
        b=B+Ry2y2op9wHN00RRb98zMBE6n04YSGm8YHLlPZLyrLv03R+1UPyi6N9eYisbJJqD2
         CmtKoFmS4cNJdLZvDDVTK1VRFjUeoTqZcufX48fQs0MkD420Sx/hCq/7qkvvI6ZT2i7B
         +/kNdfGwITBKO/mvAQSicD2hMr7kElLt+OoIfg6pVqJyzWLNcnIqYtCL8RAHp87owyOi
         Ogai7layC1a867SnlVOzVBNiAW1O8oMX2MvosACZhimAH1SXg8waJ+jKHe0rI9W8pklI
         5EMAyUHjXcc4px46nVkZvxHtshd/C9hYC5/iJusSbqfD6OLJIYdlohZI5JDuFtITfUvB
         4gsw==
X-Forwarded-Encrypted: i=1; AJvYcCWnBHazubSU8uxPP6sf/C6cl+FNf6IcwukPGrsgusv5XFQfvkGWASN0S4A9XYbRMjUS9ed3plqpT/X/ThV4aCo5v7fafpVIz+X3CH4Qb+om/gus7Kz8sF0x2V9m6FiMXn8qnoVy+d9aAwnDebnk1aNa4It+GnF3WOUe
X-Gm-Message-State: AOJu0Yx2r+FMGpScVACfPZeSHTdGL0U1MtpJvGt2y1zAkJcVnDFOsDNW
	lXKhrdhziilROPRBsFuH0+uhxBY4bh35J16B88HT17N0LzMlyHQY
X-Google-Smtp-Source: AGHT+IHFg0zyk2NS23/A1etHV8JcM7ibRi4errBqUEIZrG9N7OZjtPtXrBCEmEH5SFyOsilQGUWU4Q==
X-Received: by 2002:a17:906:22d6:b0:a51:9449:6fa1 with SMTP id q22-20020a17090622d600b00a5194496fa1mr328854eja.15.1712231404025;
        Thu, 04 Apr 2024 04:50:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id wz5-20020a170906fe4500b00a4e7a0a1c04sm4030319ejb.110.2024.04.04.04.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:50:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next v3 5/5] net: ibm/emac: allocate dummy net_device dynamically
Date: Thu,  4 Apr 2024 04:48:45 -0700
Message-ID: <20240404114854.2498663-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404114854.2498663-1-leitao@debian.org>
References: <20240404114854.2498663-1-leitao@debian.org>
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
 drivers/net/ethernet/ibm/emac/mal.c | 14 +++++++++++---
 drivers/net/ethernet/ibm/emac/mal.h |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 2439f7e96e05..d92dd9c83031 100644
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
+	free_netdev(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
  fail:
@@ -734,6 +740,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	mal_reset(mal);
 
+	free_netdev(mal->dummy_dev);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 			  (NUM_TX_BUFF * mal->num_tx_chans +
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


