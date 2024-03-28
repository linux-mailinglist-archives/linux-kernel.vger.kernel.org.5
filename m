Return-Path: <linux-kernel+bounces-122685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5DA88FB67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FD1C2DFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4981441C62;
	Thu, 28 Mar 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lZFSGeQP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296655FB84
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618015; cv=none; b=bl8JH4uwOiCgdY8x3KMsiBeZZ95rtrXvRmUgRKeyCJ+kzXkzpVry4eAdTmrxJj/bX9vs8+FBhIM3VstJNeMhsK1grqc08OZkSRy64uY4D+xQ8g3I3ZBNX49i5jdXBd1cEtHHmcndSFZvE7jOYfefeRgghhOtLzodw9wgBnT9miQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618015; c=relaxed/simple;
	bh=lMQ8pA3fxuEkja51W9cCi6a5eswxznP9XZsEaDtG+eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tw2FSR7OQ+G+XlSvqnBawPZoaRQgRodu1Mpm4JDUgtjvfmcfaR2cGQCGNDfysG2iBGr1N6bwY/U+8ZkT8zQD0IkMz+eFIpcYbOzAUlhKc4vUgwSKzbBjegKEy2Oz9gNieAoxEscn4nnAa1QfT1z1F7KWfwqvfSHrrzReZ2OiDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lZFSGeQP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4149749cc36so5378845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711618011; x=1712222811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKRk5m7OhH9/KtmWyiJBEEYBkFQcqTKGy/vJ+JRc7nU=;
        b=lZFSGeQP2Iv1fpE3Y3XmRbn+L4s0YIE2M5X+TuyoZbNgstWBcI8IJAdaMsHye4JspU
         BTCcwfrapnpgRshvA2MVsrKzb5PbBdraDm/OFxopGUPW+Z4VAJDzwxiWctkBbZBz/7Fu
         LuJ+UIwGk/cDTnNd+CPrkQWetUnScb7XWxejEZgne/NvjfJ4+/R2kZuUa1BJUAzlvcKV
         YovMWyEIeZJ/h2fYTEfGb9hlYfISGcA7zYJ7R5H5/NaZU03558u3DLhhgp/TDKWzgTRU
         CFUNk5GjYmAMO/QS7vaml9hx8C4aOspETyRgif4aiTQvyYaiZPcs70rBRZKsI1QNtXlh
         Bf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618011; x=1712222811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKRk5m7OhH9/KtmWyiJBEEYBkFQcqTKGy/vJ+JRc7nU=;
        b=iaAmj2unV1HJDFUenNYbZFurJw+X2LT57joLZTuBpusjB6bNbaGaA+I4lhwIQMhO+5
         26e3N3iaJ6awQpR+syoMNpYPjohALxagpezCVrcz+kyHqwQGd+MMqdPEiDAqEoLbGJHo
         HnFfh4jQ16zKx1NaaqtBPzjnp8LCnfSulz3YpSzyBIorfOWjEVHqN0gnMKUzlvmtqO68
         VqKsPReTfzO1FZP60d+gJFsEP0FodIW1DQhJWSJQkwsVrXZFZgwiOLkZiVgivEVC2JiJ
         NR+mB5ZfeNlfKqNoqN90di8wWLelCnqhe6A/lprXjkXPCY0b8lcb7ScIk71Rt2vgIDzc
         Kttw==
X-Forwarded-Encrypted: i=1; AJvYcCWuwgtBQKM7WlH/cOimmhsWK8kAHtBVDvUsJESU+w13GGsBxAebDC4ygN9Z8CfHxa3OC8Om86ovaO7OQhTBLWFE33Hy2zayxMamWOg5
X-Gm-Message-State: AOJu0Yy/Yv1ZkbPCzLPk2nkGLhFOXzAhVE5dE1GgrgJISxeeCsMwmN7v
	n1CJjC+hy/HQNjPkwROjk7zrhe/Z3Y/4YNNiOkVotyVap1JEhKWUUOEKX0fQNew=
X-Google-Smtp-Source: AGHT+IFvF/soOKX1UFXsXd+ZNDuB+GCdNlZaP/qcn+7zX7JeZmLa6IzBcyJz9xomQtMqZbCoyhJyow==
X-Received: by 2002:a05:600c:468a:b0:414:c42:e114 with SMTP id p10-20020a05600c468a00b004140c42e114mr1833632wmo.39.1711618011535;
        Thu, 28 Mar 2024 02:26:51 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b0041493615585sm1673414wmb.39.2024.03.28.02.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:26:51 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Thu, 28 Mar 2024 10:26:41 +0100
Subject: [PATCH net-next v5 2/3] net: ethernet: ti: Add desc_infos member
 to struct k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v5-2-bc1739170bc6@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711618007; l=3504;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=lMQ8pA3fxuEkja51W9cCi6a5eswxznP9XZsEaDtG+eI=;
 b=XU+OQCK6D3jAL0Gw6r7XOd0wzjY4dYWszKZDVsf+OII0+m1hGaHYxbIXhdZbkLAZ50v6abGZh
 MY5e4w8ZhECDc5TYqX/ZD2MMGUvXisdXK3ITF04z5c6pUJ36/XTYX1G
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch introduces a member and the related accessors which can be
used to store descriptor specific additional information. This member
can store, for instance, an ID to differentiate a skb TX buffer type
from a xdpf TX buffer type.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 25 +++++++++++++++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index fe8203c05731..bb42bdf7c13d 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -22,6 +22,7 @@ struct k3_cppi_desc_pool {
 	size_t			mem_size;
 	size_t			num_desc;
 	struct gen_pool		*gen_pool;
+	void			**desc_infos;
 };
 
 void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
@@ -37,6 +38,8 @@ void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
 		dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 				  pool->dma_addr);
 
+	kfree(pool->desc_infos);
+
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_destroy);
@@ -72,6 +75,14 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 		goto gen_pool_create_fail;
 	}
 
+	pool->desc_infos = kcalloc(pool->num_desc, sizeof(*pool->desc_infos), GFP_KERNEL);
+	if (!pool->desc_infos) {
+		ret = -ENOMEM;
+		dev_err(pool->dev, "pool descriptor infos alloc failed %d\n", ret);
+		kfree_const(pool_name);
+		goto gen_pool_desc_infos_alloc_fail;
+	}
+
 	pool->gen_pool->name = pool_name;
 
 	pool->cpumem = dma_alloc_coherent(pool->dev, pool->mem_size,
@@ -94,6 +105,8 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 			  pool->dma_addr);
 dma_alloc_fail:
+	kfree(pool->desc_infos);
+gen_pool_desc_infos_alloc_fail:
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 gen_pool_create_fail:
 	devm_kfree(pool->dev, pool);
@@ -144,5 +157,17 @@ void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool)
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


