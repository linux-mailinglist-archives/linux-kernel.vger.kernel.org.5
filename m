Return-Path: <linux-kernel+bounces-92221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B6871D08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538F91C233BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540F5A4E0;
	Tue,  5 Mar 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lUN91jsa"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC857326
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636914; cv=none; b=cProNRUVyn6UF4JkHjB7IaD5wAwpO/B+avN3ZB+T2epjZRLBtffHcPr5rp199VZoY8aJtsHikFjvRVTxIM1zyN6CqR0UGlS0FbaraYgszRlaolwlviwi+s600RHopd2A2ax8zl/jaG8ya28uppcUfX5kAJgfL8F9vQjM6Adx+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636914; c=relaxed/simple;
	bh=Y46qZiPIxVqm/+2ngjD2p6sQy4AqjAerfnqGZzoaKmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4llhZgdifkbymkszRMeb5kR+dUXxjJy5gVp/sajMy3+A5ac2Rdhp/6tcp5c8eJGUL9G2S4pnctVHQhS/DN8BYOry2MXPRjcvVb/vr4yEOMJx3lawouNkZ2t/cpjf9FMc9wR8ohYvp4+FQEvNen/W23nU+aqyPHqegZ84DUkC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lUN91jsa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33de4d3483eso3427158f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709636909; x=1710241709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=canlvOloh4zEnLanokN/WjQ62JpW1VdMiHVT6vaC3r4=;
        b=lUN91jsalj0pDb7wppcsa+SqD6U4OvMl5kIBO/OzFExwgfh/rETtWhQc6lUjEApgR2
         2HALN1xoYkeCAW4dog18K1JEVM+apeZKEQgUpsPjJjyplN+tYJYFowdev2vfvxQHfGf2
         TnMn7k3XPEsKe0gKId1pD8rdeWB7WphI2QYyxxAIhyKf8tYPHYE+Y4asoROkEDIMAmW6
         mP8C6XJ0wOvJa9FIl8bLqUXIj5V4pGSBmpfTz3162wgLKP0z1+r6yZP2vC1RE/xtajTp
         ACGGlQaSS8ms+RCzfbGcBwvGfo9bB8oYVR1ARHCpbZy+oN5qf9wlKKqVz66Debbq8UxH
         fnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636909; x=1710241709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=canlvOloh4zEnLanokN/WjQ62JpW1VdMiHVT6vaC3r4=;
        b=pBV7q36nFPh0seTlUW6lPJ1qWWJAbQTnKV6xTBZNNzHQgWSGxBbX2XBzj+mjgT7Fa6
         4NCtkMhbgE4DhIQbeVLZ1Lgko9uEq4G+x1AJyQbrOAWxmgZLSeuVNOom7jLpL+89ThG+
         CqEUDiu35kiNrnAuMMcPzpuMr1iV43wn3G+8bZSfITEEdZaRrk8s9Dz4fbL2pO61ERNn
         5OJCpN/Z6arO7xfy+J0k72wj+vtmj3oxc38bCLyukwymZ/wYCAhbat9ltSZXSzdm5OJg
         l+EwBFkIBonD2DaE/CO8bQVBaA2TAPqSGtuOyFAgFnZMKz80iuOVtChSAjemRJE9gGfH
         s0pg==
X-Forwarded-Encrypted: i=1; AJvYcCVfc7YYBHka9stxZgCdLz3zftf2Y498zx/yEXiZvF03ChSrggUP3yxaTw+N+49gTPo2B3IBQM01+MwFNy+KgaPV4qZzUWlSCtIfKCEj
X-Gm-Message-State: AOJu0Yz+U9yW2pCLvI2nLwBqZ6TjPKBb1qXYL9U9/AGYN2c5QNcOXOFs
	wV7OlckJKNM/beY09BEzNZ5JprYalhlDEnSkqvOstR6zR6afH4c8I9+h6sTEjTs=
X-Google-Smtp-Source: AGHT+IG4PwmV/7gHNDxTSEU+h6KoMa85YHeJ7lcV8oM/YV1RHnHQxziz9Qc7eYQjwiG+ORSZYNEgFg==
X-Received: by 2002:a05:6000:90e:b0:33d:d15b:9789 with SMTP id cw14-20020a056000090e00b0033dd15b9789mr9030292wrb.65.1709636909620;
        Tue, 05 Mar 2024 03:08:29 -0800 (PST)
Received: from [127.0.1.1] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm2190993wry.66.2024.03.05.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:08:29 -0800 (PST)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 05 Mar 2024 12:08:19 +0100
Subject: [PATCH v3 2/3] net: ethernet: ti: Add desc_infos member to struct
 k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v3-2-5d944a9d84a0@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709636903; l=3220;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=Y46qZiPIxVqm/+2ngjD2p6sQy4AqjAerfnqGZzoaKmI=;
 b=1yAwaCWRpRqqD4MFtQLKotubUsbSp2bN12toZ5YOy+ngtI0PYQvbpboRO+BB7Ck7zHb88wasq
 KqmnfqeQQLZCod3pIdhHWyV6JNiRkDVWUNC4LB0oaiSqSPlqUv8gTHW
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


