Return-Path: <linux-kernel+bounces-117428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFBA88AB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501911C3ADDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A058AA4;
	Mon, 25 Mar 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0lVUmor7"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AD58109
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382453; cv=none; b=N9wWligz3zTpUPBA3+bohkcOs7PWnWl3XKEefpCNXjp9nNB7kWCWZXFgzud6woHYs6TEW1VHCvn77OLbz7b/+AoY5OARtsWAq/Q0m1Dn8CBsdXHA+L03BXhRNriZojOjSQz10NPJaYqGvVzIyd7wz4SDAhjCIATIdBoh545IvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382453; c=relaxed/simple;
	bh=Y46qZiPIxVqm/+2ngjD2p6sQy4AqjAerfnqGZzoaKmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NI/8asnhdKAqJ53zRbVyPNTXMN8lop6/2K8xFG5vl7ZnFeEWlr7cCo4jfOkuV3M6R/ERZw6Etzx0+TMoAJmiqblLQKlImVhAkcpQ6wjvMl7s+NAQRapqSj9Z5U6lqM97qjaNKHLnY6KV2mJhynNt5dG7XzLkOCKviLVG+kZRjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0lVUmor7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e285a33bdso2485112f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711382450; x=1711987250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=canlvOloh4zEnLanokN/WjQ62JpW1VdMiHVT6vaC3r4=;
        b=0lVUmor7lpoyjkBZ2yBChYcLpUBKOKjAz0ZwDZIoq1qNjoyyHpnSIrHPlx/1dkFb/z
         JyEitDXut0wTjHcEIOM/3dCUe9mTfpGKjcEp1bN/U8AoiHrcolwZmR7Pez/Vi+bhnIJh
         i49KqCf3fOprK16qBkG5ZatcNPBtXsWGgqYnkI8RBHju5HPWYnuWyxBTFCOHOh2ZVLQl
         0M8Q6vjiHFBVqKa/aVRZYntjCgsfEIKoffj3eGqQLlG7y0u7hX6Sk8EY2qQj8lORnCfn
         4999uYlXvywC0d9zRrcWl3vo/E4+2Lccee09UEU+/OSJ8hqbwZbE64CNgEDWlT4Xc0lK
         Krjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382450; x=1711987250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=canlvOloh4zEnLanokN/WjQ62JpW1VdMiHVT6vaC3r4=;
        b=FgZVK0iWgtNmYYfBry0hRyAwzoaVK68f2rgapAzNW228+n8HtmGYjFvde/TISLZsFL
         TVmUwrZoy3k+dl3QDV/jTkiOh6M8dUuWZQ/GFWHJpGyS/b7ZJhKa01Vd0BqNvi9pp2oQ
         +4d9Brnso2AmHsST83D0JXddU3cuPhovTosHALckfHGMkHSI0K2PASBEPrBeNcz3wobr
         4BjVBkO3MS4Wzf0SEkuYQHexy8qNZkH88qpEjOzu3Kr+/SA2nKH77MNzMOa+Bl5LbsjM
         mKA6kNAjtLoM0ffq7ki1kJa8zf5nIGSiFJP84O8gPFQK90HVcy01wI04WjIVnA+23BtJ
         /Zcw==
X-Forwarded-Encrypted: i=1; AJvYcCXRObQfxPBSTYFEQktg2xrFOUpkhsYa+bKBOyhMYGdWfaAuPVqgePafBarqZ69Lbn9sB8auxu8K+HcZgks0PG04mDBVguO+iWbFnXWn
X-Gm-Message-State: AOJu0YyyNIv3buvSIi9yYudYAOy4eOHEaDnYq36m3PcaEarBAtOpOlAu
	7s0IZR4xoOmwVRfY1abgtBO5FQQNHJQ0Z77wtLEimuWiPGaTdK//0k8VxmElFfk=
X-Google-Smtp-Source: AGHT+IHSytMnpxNaEiziU/ORo0KmKW28ariRT1MML39MUcPWdgIVh1QjgdSOCBzmnu72Uz2Ka5H2rA==
X-Received: by 2002:a5d:4805:0:b0:33e:7650:24c8 with SMTP id l5-20020a5d4805000000b0033e765024c8mr4591997wrq.12.1711382450053;
        Mon, 25 Mar 2024 09:00:50 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r17-20020adff711000000b0033b6e26f0f9sm9839361wrp.42.2024.03.25.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:00:49 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 25 Mar 2024 17:00:36 +0100
Subject: [PATCH net-next v4 2/3] net: ethernet: ti: Add desc_infos member
 to struct k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v4-2-2e45e5dec048@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711382445; l=3220;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=Y46qZiPIxVqm/+2ngjD2p6sQy4AqjAerfnqGZzoaKmI=;
 b=qgazWBkM+DqOQxUttA89E8Lub9bkZLXTiY4gGfQc3DvbXI8gj4y8pwiS7olUpwYThyrJuXab2
 kv8gwXF15yTDDMhye3q/9gIuwf+Zc95Nt7V5oTSnSiqrGzXU1KyR1xv
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch introduces a member and the related accessors which can be
used to store descriptor specific additional information. This member
can store, for instance, an ID to differentiate a skb TX buffer type
from a xdpf TX buffer type.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 24 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index fe8203c05731..d0c68d722ef2 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -22,6 +22,7 @@ struct k3_cppi_desc_pool {
 	size_t			mem_size;
 	size_t			num_desc;
 	struct gen_pool		*gen_pool;
+	void			**desc_infos;
 };
 
 void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
@@ -72,6 +73,15 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 		goto gen_pool_create_fail;
 	}
 
+	pool->desc_infos = devm_kcalloc(dev, pool->num_desc,
+					sizeof(*pool->desc_infos), GFP_KERNEL);
+	if (!pool->desc_infos) {
+		ret = -ENOMEM;
+		dev_err(pool->dev, "pool descriptor infos alloc failed %d\n", ret);
+		kfree_const(pool_name);
+		goto gen_pool_desc_infos_alloc_fail;
+	}
+
 	pool->gen_pool->name = pool_name;
 
 	pool->cpumem = dma_alloc_coherent(pool->dev, pool->mem_size,
@@ -94,6 +104,8 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 			  pool->dma_addr);
 dma_alloc_fail:
+	devm_kfree(pool->dev, pool->desc_infos);
+gen_pool_desc_infos_alloc_fail:
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 gen_pool_create_fail:
 	devm_kfree(pool->dev, pool);
@@ -144,5 +156,17 @@ void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
 
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool, int desc_idx, void *info)
+{
+	pool->desc_infos[desc_idx] = info;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info_set);
+
+void *k3_cppi_desc_pool_desc_info(struct k3_cppi_desc_pool *pool, int desc_idx)
+{
+	return pool->desc_infos[desc_idx];
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index 149d5579a5e2..0076596307e7 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -28,5 +28,7 @@ void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
 size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool);
 void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool);
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool, int desc_idx, void *info);
+void *k3_cppi_desc_pool_desc_info(struct k3_cppi_desc_pool *pool, int desc_idx);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


