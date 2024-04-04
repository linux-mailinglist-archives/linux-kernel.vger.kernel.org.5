Return-Path: <linux-kernel+bounces-131340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA96898678
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9481C21226
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B6128816;
	Thu,  4 Apr 2024 11:50:00 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2A127B72;
	Thu,  4 Apr 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231400; cv=none; b=aoBhNA9PoYOxnPecrfWN9/k6TPWgA1xJEFV3y+Y3J3SfXrIX/M2eFwk6QJnN9qXPjTYMPmutnXepwCkyk4P9s8G98h+PLFVXi7up/2zbb9zkTpaMpDBlbpGE2rA7b1Iru3d3OSlr2rHXQ7bXGJN5MLzbloEvBZVShyWBpMDu/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231400; c=relaxed/simple;
	bh=thNNGA+Buyv1A48P5cMpc4XXfCvRQSFmpwoRUX9PFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVTpi/k2eCN+f6iEbStCQOKN5McW9coZoBy6WDfiZh3L/V48TY1wtv8EFJt9ztr4gGAWrL+/8p3i5shhW8UvGOv+UNYTSxxFMHQD7qjG5hnnGPRpwrDOtxAS4vKCJtog2l4/z9N1ZCSyCYt5z8NY7vnPL4EW+h+63Pz0zuQA8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4715991c32so135007566b.1;
        Thu, 04 Apr 2024 04:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231396; x=1712836196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGHHnAjzHXOHKZAHNwNt7Xm//rgfn0lSUB+nM5VysgU=;
        b=YcxmQ4reZp7jXwxXR1PkRPCErNlfxUlWIoxseoAr2aTBpDtQ8yNdqu3lRE6qSNUyZ3
         s2gcZpg06vVIO7hpgtMNAvGb4RYTYNuRafodvzRXaCOWVGVuOg+2XSXyp0QTfCG9Q/Xe
         TwEUcImsJ63AWp5Gv1+jN3KOfXH2C/AS2FwKef3R6kbkMSl1eGC8yo2WbdmlBxW9L65y
         wF681lOkA6ddQf/f7Fcsv6Xx3dLSI75VtF1qK8znjWqHYvtlVVliGDgi7TPZvtcEztf+
         wYm6ldUn3zTDxEpG5f6cUcrQNAmNkLVhGfnm9205Iq1DfegGoeGFbfAMg736rSUIH1xA
         BM9A==
X-Forwarded-Encrypted: i=1; AJvYcCXm8r+URvSOLe9J78oeIT/YERlI8mBOLTI008KnwMQR1KebsfhMPoBAocc2LUdqCNG3tb5Pb4c8UdUYBAIaS3+EzwYhJWdV3q5Us3q1haPJEtnXkuwTxfGcnRpY46m4vHSRfw42Lfe0xStSrXVtc3ZRcEY6Lv0Ax0Vt
X-Gm-Message-State: AOJu0Yw8jUigYHiGyKjiua2zg1cjU12Q0fxiN/EiRDtR0aZCQARiiPz4
	shHTxC87cpT606DXt+aOVRchSFlIABuhRvYbVtNWQl06B7w028KB
X-Google-Smtp-Source: AGHT+IE3t+BLSiVw4qYEsUV6AW+ru3gx9jWHG3rLtC0+vGDymiwEFCGXCLHQkfj2msACqNOeoyP0iw==
X-Received: by 2002:a17:906:268b:b0:a4e:6414:5afd with SMTP id t11-20020a170906268b00b00a4e64145afdmr1390682ejc.52.1712231396634;
        Thu, 04 Apr 2024 04:49:56 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id wy11-20020a170906fe0b00b00a4e4a3e69acsm6635185ejb.71.2024.04.04.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:49:56 -0700 (PDT)
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
	taras.chornyi@plvision.eu,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 3/5] net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
Date: Thu,  4 Apr 2024 04:48:43 -0700
Message-ID: <20240404114854.2498663-4-leitao@debian.org>
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
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 17 +++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index caa13b9cedff..d7a96dc11c07 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1710,7 +1710,7 @@ static struct page_pool *mtk_create_page_pool(struct mtk_eth *eth,
 	if (IS_ERR(pp))
 		return pp;
 
-	err = __xdp_rxq_info_reg(xdp_q, &eth->dummy_dev, id,
+	err = __xdp_rxq_info_reg(xdp_q, eth->dummy_dev, id,
 				 eth->rx_napi.napi_id, PAGE_SIZE);
 	if (err < 0)
 		goto err_free_pp;
@@ -4188,6 +4188,8 @@ static int mtk_free_dev(struct mtk_eth *eth)
 		metadata_dst_free(eth->dsa_meta[i]);
 	}
 
+	free_netdev(eth->dummy_dev);
+
 	return 0;
 }
 
@@ -4983,9 +4985,14 @@ static int mtk_probe(struct platform_device *pdev)
 	/* we run 2 devices on the same DMA ring so we need a dummy device
 	 * for NAPI to work
 	 */
-	init_dummy_netdev(&eth->dummy_dev);
-	netif_napi_add(&eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
-	netif_napi_add(&eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
+	eth->dummy_dev = alloc_netdev_dummy(0);
+	if (!eth->dummy_dev) {
+		err = -ENOMEM;
+		dev_err(eth->dev, "failed to allocated dummy device\n");
+		goto err_unreg_netdev;
+	}
+	netif_napi_add(eth->dummy_dev, &eth->tx_napi, mtk_napi_tx);
+	netif_napi_add(eth->dummy_dev, &eth->rx_napi, mtk_napi_rx);
 
 	platform_set_drvdata(pdev, eth);
 	schedule_delayed_work(&eth->reset.monitor_work,
@@ -4993,6 +5000,8 @@ static int mtk_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_unreg_netdev:
+	mtk_unreg_dev(eth);
 err_deinit_ppe:
 	mtk_ppe_deinit(eth);
 	mtk_mdio_cleanup(eth);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9ae3b8a71d0e..723fc637027c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1242,7 +1242,7 @@ struct mtk_eth {
 	spinlock_t			page_lock;
 	spinlock_t			tx_irq_lock;
 	spinlock_t			rx_irq_lock;
-	struct net_device		dummy_dev;
+	struct net_device		*dummy_dev;
 	struct net_device		*netdev[MTK_MAX_DEVS];
 	struct mtk_mac			*mac[MTK_MAX_DEVS];
 	int				irq[3];
-- 
2.43.0


