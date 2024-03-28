Return-Path: <linux-kernel+bounces-122684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030088FB66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6D5B249C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E77C0A3;
	Thu, 28 Mar 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aaU0zX3J"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4456B77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618014; cv=none; b=TDoZXydKNYcEqk2SanyWIfQZkgE18Ty4HN4HY2I7sehh/sDsXBfgsLG0TBqzJ/QUFqCbow0tW0tDsaimMB77+bA417PJrGnTWZawPVuD7CZAez2HySro/4qkFe9Zvkj4boanVL7e9pKYLw7PrAE2OBRVi2eBVbWlKTgQxF47ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618014; c=relaxed/simple;
	bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AiBo6qSJnkd6W4F70EKXFlmJSxOBoyAQERk+x/D+g5b73ZapfffNBC7ff6HX/rDJswJsnGXNDd196F9IFgnjLKugciX2LdNicmy3Y833vwhtjkvFGHXUZd2UXV4kRE4KK6m1d3C8OVCDhRgqm4kx+UmrtS/pXP2SVsRESO8Mjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aaU0zX3J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4154471fb59so2925495e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711618010; x=1712222810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=aaU0zX3JWGUS1Az17VyjnGrFVQn3u4TEqx/hkcCRa0+x5Sb8+EehhQbM+rrJ2ZN7lf
         cYCvP5b7yn7SC+u1ub4ZqkvgquvpfRYY7YcSjK4YpMA2DMOmAi1o2wHmpIlt56w2SmIF
         0N2lbqlTadx0xGhUlC2dPzu1ZE5u2VTz5XpyfkqaTzD2yMhDLKNatVFBHNQ7EHrgLDFN
         NjPN4Ix3xChlpf517rhauIPjJw7dknJ1pTsIZiG47BowpdzTb8WQRAFIbZoSZZekkqYb
         EVftbEB1FlH1H9VdcPuc+IZU+f7gLaFC+YVv6vRXp09khB58aczMRFhdtzYxNZdIjw6D
         kPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618010; x=1712222810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=k9NPniDMKzbP0Xmd4mUwIpLbCd2vyRrCZqtDVAY78wfu/9xi7JNtXgKt5gp/JW5dGY
         gZ8+b3oU/ovPY0pij5CtAIQV/mX2gHfKQyUzeYNi+m8T0nfZywvl66gsEUvxs67WzdoK
         5Y49kNVHALioMXAMfmpOOPtKvhOti7DDG5g+GHWCCJ1YHCpQKqYCsDyX4TTUVPw48K3R
         V+8SV/PMxEsjNJaZunjr+hFQFV/nwLGW/Z5k7TBDMKOxvep5LtHHLtl29qza5Og4T5Zy
         oDcc1pMH1Nv+Jg9m2TRMo7ACnmelTr1bJBwyz5cP2fWXLHMHy9FdjVgryelMe9v93VY0
         fQEw==
X-Forwarded-Encrypted: i=1; AJvYcCWRQLwwUeaA2BXvDPZWO7Kaq80Q5MpurL2xFb8o+bsmy6ZJhyjPoV6R+RtDGzwefMbzPwjHF0HZluFjAnN91nWh3M6/iQacMSOH5xAk
X-Gm-Message-State: AOJu0YxMbVIWt0dEOYAshvXoHivHdNJ+35V4uTGYPvENANYR/8Ie7kIA
	ncXm9qJHJeUsl+ZfFM3bCOKeGJtkSWQYWjBPTFxmeZ8FxDgjYcSjjxI+DzKHDwQ=
X-Google-Smtp-Source: AGHT+IECjUgDa2k5UJylRjoSYSZ/eL8Rc0qvDSUr6znA15Wk0chOgtuTksxOram+qKPcSmAtYopzIw==
X-Received: by 2002:a05:600c:1c22:b0:415:456c:a17f with SMTP id j34-20020a05600c1c2200b00415456ca17fmr740302wms.25.1711618010528;
        Thu, 28 Mar 2024 02:26:50 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b0041493615585sm1673414wmb.39.2024.03.28.02.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:26:49 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Thu, 28 Mar 2024 10:26:40 +0100
Subject: [PATCH net-next v5 1/3] net: ethernet: ti: Add accessors for
 struct k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v5-1-bc1739170bc6@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711618007; l=1852;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
 b=4EO5M/QaSlfy71TX2T3KVkjA4QfRBdI4jxi2392RsNefCveULSjjFyy1hcKDNfud58SeMzlmm
 4oAew9FdeG+ATsP7Gv8bowf1UYRB0QwYtNNMn1BRDMYC17kQteIfwZ0
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds accessors for desc_size and cpumem members. They may be
used, for instance, to compute a descriptor index.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 12 ++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 05cc7aab1ec8..fe8203c05731 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
 
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool)
+{
+	return pool->desc_size;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_size);
+
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool)
+{
+	return pool->cpumem;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index a7e3fa5e7b62..149d5579a5e2 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -26,5 +26,7 @@ k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma);
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool);
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool);
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


