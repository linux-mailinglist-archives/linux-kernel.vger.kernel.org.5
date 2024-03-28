Return-Path: <linux-kernel+bounces-123840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D78890EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0278928FFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58613B591;
	Thu, 28 Mar 2024 23:52:37 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242313A86A;
	Thu, 28 Mar 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669956; cv=none; b=hWdj1U/eKxm0GRkotdSazYZozJUWeg4ZGgjEeE76E2Gk9ERHqqYSUCyEzoHOJwezY3HPJVK3QCou6RiRrFgP/1fzsKkrIg/VP6F4Y7HOhNzgozT5n6G/7DBZLZEDVNP/R6S1maCMQcvyOWTDpsmrqsQ3iMeT7DiibyHv2PTv22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669956; c=relaxed/simple;
	bh=lEOMxZ/9USL/bF4CR/PU3diXagyoXi+ob1llO7AMJkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPR9Tkhu1tYHniw5xoAbN8TICAf2pC8dvrgSmopANjTFgObIvkK8O1xGzOFZ4ISBxcgp6aNwljGB5fyWd41kun1Uptoml0bf66ZKATBgDl/qA7/uHNILdOvYpO3m+mNB/Q+w3M2rn6EgE5g9vKXyr3Sc3LPNd8rzw4aqK+TrfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a470d7f77eeso195855266b.3;
        Thu, 28 Mar 2024 16:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669953; x=1712274753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLgcG4xlKLqW91Fj9Sd1H21KnmDeT1FLqNKCBfAA7qQ=;
        b=C9LgObxmq4+qzKtWiBFy0cfPu2XMo8awjwbwF0OJA8HNkAJ0873dfel3ojzBv195RH
         g2kl9J8YiXhAGk6mP8cTpzNfAqtfvIB69HdgCyFl1LrsSBKoimUc4IhMhVZTemJKTDJr
         /pqkOq9APqwr/HElGL7m+S7NboYQsL+xE0Zj6CJAFx+H5sxQ6to6hLpev6K6ipQOqzHR
         Nutot5PzBapIwmNdCFkHWYcIA5BbigTz5bdeSVTRix3O1fZDJz/gmZmRL747DLg/kozu
         5ndYy56l69jcSOzZfPeydL52jwcYszjAq17719w5lIwA6Gth4dyPBRVP5ajlkHhtrrOq
         V2tg==
X-Forwarded-Encrypted: i=1; AJvYcCVuoSjq96A1sBJKHh/UDHxzPKyflygv+g8LVb6kS59+PaYTSHKMESM/kmZYYdufBmRn33tA/Vv6Jdi0OQWOMyV4oGUwuKs6FAw+P43TW0xgdscGKlAj1MQT9i55vZptJJU1TOip
X-Gm-Message-State: AOJu0YwzMvEi1JulG1XLFLOGCND2wk+W58F582XEx3p+SHXmy7WE9l8V
	EB19geUeONBrS2il3vJl2M4WTrc6kKgR+MMitWVfjR0ZgazN5yYP
X-Google-Smtp-Source: AGHT+IGs+I8aHeMSf4hUAtaLtlj9Qa7htFrtgKIQimGQwZMB/D/iBzhuJ0wgV6vx9e5ABuhS40Rs6g==
X-Received: by 2002:a17:906:3ce:b0:a46:bfe2:521f with SMTP id c14-20020a17090603ce00b00a46bfe2521fmr467514eja.24.1711669953298;
        Thu, 28 Mar 2024 16:52:33 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id o25-20020a17090611d900b00a4735fc654fsm1265004eja.205.2024.03.28.16.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:52:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Taras Chornyi <taras.chornyi@plvision.eu>
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/5] net: marvell: prestera: allocate dummy net_device dynamically
Date: Thu, 28 Mar 2024 16:52:02 -0700
Message-ID: <20240328235214.4079063-3-leitao@debian.org>
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
 .../net/ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
index cc2a9ae794be..ed33a201a0f5 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
@@ -96,7 +96,7 @@ struct prestera_sdma {
 	struct dma_pool *desc_pool;
 	struct work_struct tx_work;
 	struct napi_struct rx_napi;
-	struct net_device napi_dev;
+	struct net_device *napi_dev;
 	u32 map_addr;
 	u64 dma_mask;
 	/* protect SDMA with concurrent access from multiple CPUs */
@@ -654,13 +654,21 @@ static int prestera_sdma_switch_init(struct prestera_switch *sw)
 	if (err)
 		goto err_evt_register;
 
-	init_dummy_netdev(&sdma->napi_dev);
+	sdma->napi_dev = alloc_netdev_dummy(0);
+	if (!sdma->napi_dev) {
+		dev_err(dev, "not able to initialize dummy device\n");
+		goto err_alloc_dummy;
+	}
+
 
-	netif_napi_add(&sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
+	netif_napi_add(sdma->napi_dev, &sdma->rx_napi, prestera_sdma_rx_poll);
 	napi_enable(&sdma->rx_napi);
 
 	return 0;
 
+err_alloc_dummy:
+	prestera_hw_event_handler_unregister(sw, PRESTERA_EVENT_TYPE_RXTX,
+					     prestera_rxtx_handle_event);
 err_evt_register:
 err_tx_init:
 	prestera_sdma_tx_fini(sdma);
@@ -682,6 +690,7 @@ static void prestera_sdma_switch_fini(struct prestera_switch *sw)
 	prestera_sdma_tx_fini(sdma);
 	prestera_sdma_rx_fini(sdma);
 	dma_pool_destroy(sdma->desc_pool);
+	kfree(sdma->napi_dev);
 }
 
 static bool prestera_sdma_is_ready(struct prestera_sdma *sdma)
-- 
2.43.0


