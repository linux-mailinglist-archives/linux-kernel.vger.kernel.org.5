Return-Path: <linux-kernel+bounces-100286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD787950B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09A81C21889
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05467A154;
	Tue, 12 Mar 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OuydTOmX"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8067A146
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249778; cv=none; b=jHLVwhhFev5QQR6m/WTnjUJ28eAJBDVWt1bVuh5016pE8avf7iRxkphaVXAIinDFHSvsZbMgaeOQ2tL6gz+r5ztieLQ9H8rZtE+/PUuxdsNdLOrIIvREuzTPUejqCWWE6qTSIpVWAyuXClUYv39r7EIl4HVBQRwXKZcLFcHDH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249778; c=relaxed/simple;
	bh=Y46qZiPIxVqm/+2ngjD2p6sQy4AqjAerfnqGZzoaKmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9qnUzmWMsssmr3Rwt8YjGrlhF1aov70l/AP4SK+dmul5yP0jinu81aof9MlM8IERzC1DfGsLC3AIV3no86BosAMdwMVyq9elcMNSaeaTnxqgEmVJ2324rzADr0VPB5jvrVcltxuw1kKgain2UONJscwO5pSQ7YSzEt5Ni9rWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OuydTOmX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4132fc7dea7so9036245e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710249775; x=1710854575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=canlvOloh4zEnLanokN/WjQ62JpW1VdMiHVT6vaC3r4=;
        b=OuydTOmXjAgBW/KtkDX66JejwhUpiqvW2Wa3rCu4zj77hM5SnyEy+WDp6kH3GTbxMO
         aKx8zqQ180glogzfE2DJ8r22Dhug1PbheI9jHzBeF6i+dZjnfsiA4uyScw4J6iGT14EH
         4PoK3CvcLBxFQNNnND4EAQIFlgoYG16veJZgsQd/H1LKRs0vrt+y93NWn8MZ/RY6qQXk
         SaxUZfedevPu7R20/qogKIr5DZXTG6MW6q5MXj+Uz9jfnRUE/HcqfAJ1YUMF7oE7F7n1
         BQoWGKc8R+/0TmQhk8zZjjpYBoI9cUf+XztTwFiPUm2o8UU1Ma263DzBaQRuvhohIH5d
         DGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249775; x=1710854575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=canlvOloh4zEnLanokN/WjQ62JpW1VdMiHVT6vaC3r4=;
        b=pDiH1xqgKLqyIPpD6O2KJle+A7Ydmlmpaing0N3dEmADqPm5MDVWLFhCZeIcnX5tuF
         cLwJYzeIGtgLlUgcPllBeXgCfd5ChTPeDQvskgxRlWxsDRh6UHMst53Vu3Tsd5nt41k2
         nPOLNHA+/waxfHo3EZz6UFNGK6hbwtB2BrN5LYtQhMTb1AFhZ/Wd7wyObciV5ev0nuMx
         T4q7E5IlFmIvlEG/QAsaM7ZJLGo8udog+2T408IaWu4/ejyuFrOELiNDwInRfxcHS2UY
         0U/Ur4cPYo8FXt2kPor0MuqsKszIg552KIenHNapYldziRA+w4/JeIkYBYzUEBKAhrF4
         OGuA==
X-Forwarded-Encrypted: i=1; AJvYcCXsLBqvgzDsDZu6Atzh74h55vit8QkBrxWGahfM5Fy45UbCN7BLYF0GpJwhM2wDgHyCsWW8DMTobOUWpiluqVxMBw+o5H6pXFuPUPuP
X-Gm-Message-State: AOJu0YwprIGUJubKWllIGIxeUYlS+mfDvVdmBqXeiN6ub1syGO7iSYhw
	3owj2OXhB9+jVzpv/tqF3FEeyyFNyQBUx/mABfu5LwwgRtsRGh6fUD8rAVbzFZDrYzj7t6sZ0Vl
	Z
X-Google-Smtp-Source: AGHT+IFB0ECK9R9PpvX4t1CVc6wINiFA/rI7RL51IJ/fzCd5UeeMXekEG9GQ6+KP3AGo/ZIj9mi0Xw==
X-Received: by 2002:a05:600c:5386:b0:413:2a5e:e41a with SMTP id hg6-20020a05600c538600b004132a5ee41amr142273wmb.16.1710249775339;
        Tue, 12 Mar 2024 06:22:55 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b0033b278cf5fesm8980167wro.102.2024.03.12.06.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 06:22:54 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 12 Mar 2024 14:22:41 +0100
Subject: [PATCH v4 2/3] net: ethernet: ti: Add desc_infos member to struct
 k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v4-2-38361a63a48b@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710249771; l=3220;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=Y46qZiPIxVqm/+2ngjD2p6sQy4AqjAerfnqGZzoaKmI=;
 b=g1nyAYAcdeU1+dv3h4OJB8y6oIMZ3uYJvNtapYLWKSdX0MixO9UdSg1Ux9oGUZW3LIPaZ70SO
 724XsCr2ir/D8zM56jb3JLtke/6IV/gwfg62/RJ8Jb7XRxjNuq+hEsu
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


