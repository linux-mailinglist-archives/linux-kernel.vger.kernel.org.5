Return-Path: <linux-kernel+bounces-131339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E5898675
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62123287889
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14F128368;
	Thu,  4 Apr 2024 11:49:58 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA598565A;
	Thu,  4 Apr 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231398; cv=none; b=KOfj6HqhlgvzEwYUzkZV50FH8dYiV4p5rnvDJin5mgP8nkAc0PGZxoP+H7puYHYjsCeM5oi6Egb9jhKUWE7SPO8YAy2XN+bnD489gczLlYFLZb0a+1Y1GeTKKdzL6kgd48E7gHhBO1vAH0fwY/fTjnkUXTMm0rAnrBlYdD86Pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231398; c=relaxed/simple;
	bh=zohjpcY74WPo+SNhHkiaJnrWE/IKyRf3YCyljkMNEM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFElTdAPPPhv4ssKUanrRUuFOefZKf8t07vqf9bLMvfgAsbwWbaQafkQYYUSfhYoK86IJYhNf+wiAtldKpg+xZreHvhOmMCC+0O/6ge94i34G+slCr5vphvSTbM6ar4T5DKdlXXbK2mwYFKIaStBvBdKWsSBFwVNIemdQRWlBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e5ee91879so118619066b.3;
        Thu, 04 Apr 2024 04:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231395; x=1712836195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rK4LbBslMJoYxe1V0vNkJlOAiQK9SERrvEQRmx4wfo=;
        b=OuVgYYV14zDQM3EQNLeYbPbgrylIU2xXe/b2YMbWw/sDD5H4tXkSrbqyc5gGaHpABh
         Yv1UoDrzV3r7dKXZ7Nj7dYUXp7S78IQ+UsrWGwtitW1fd6gvk8IZ1ow9Mt/zPi6lXxJ8
         gulYiltbi70cngaK04B4zSFhN+ta/r/+ocOrDSoo65TY8oO8M+4S91yUPOpnW5cSx6RF
         C6h8h0Xg9luRRKusFn+Cvr5R+1LrMBohNDGGhQBSgRMTD6V7H5vp+rUWP7WHDef+cPAg
         yzCL2494IANjE+U6Lz1Yyn0Sy6G7z+j+OC/M+kdEOOrQz3UYLi6VYmioUmknoIz9+r+d
         yLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW27POyFVFjhIs0zJJ+QcjUSjEpxlhDIpxrOLyOz4fY1sh746+VGDDcW5ZGJu+S2NZwjcpbVL4Mmhw+rMWoCVJAd97NspqZSrgfGvHn+jph+QaLZQIWy+6494h1VPYBrhMKibOnNA5OkWX3r+NffLTLdMBqOtSVt3KX
X-Gm-Message-State: AOJu0YxDRl99SzIprOCSPA6e2kil10RanfRILjzGTqa0rZKWnVXpIXCY
	rOwd1ZX27POqubhFsoCqIYR/he3S3EuTY4jm62fWk9E0bntoMdJs
X-Google-Smtp-Source: AGHT+IFiS9SjmfSMSBb39k+37Klq9CVWs+kxx7A6ljynarXFtE2kNTHt2mNLj4dlY5GiGWVD+iOD9w==
X-Received: by 2002:a17:906:f859:b0:a4e:8a80:92ed with SMTP id ks25-20020a170906f85900b00a4e8a8092edmr1450248ejb.39.1712231394724;
        Thu, 04 Apr 2024 04:49:54 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id wg8-20020a17090705c800b00a4722439646sm8893849ejb.117.2024.04.04.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:49:54 -0700 (PDT)
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
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 2/5] net: marvell: prestera: allocate dummy net_device dynamically
Date: Thu,  4 Apr 2024 04:48:42 -0700
Message-ID: <20240404114854.2498663-3-leitao@debian.org>
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
 .../net/ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
index cc2a9ae794be..39d9bf82c115 100644
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
+		err = -ENOMEM;
+		goto err_alloc_dummy;
+	}
 
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
@@ -677,6 +685,7 @@ static void prestera_sdma_switch_fini(struct prestera_switch *sw)
 
 	napi_disable(&sdma->rx_napi);
 	netif_napi_del(&sdma->rx_napi);
+	free_netdev(sdma->napi_dev);
 	prestera_hw_event_handler_unregister(sw, PRESTERA_EVENT_TYPE_RXTX,
 					     prestera_rxtx_handle_event);
 	prestera_sdma_tx_fini(sdma);
-- 
2.43.0


