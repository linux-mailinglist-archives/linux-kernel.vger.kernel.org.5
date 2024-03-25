Return-Path: <linux-kernel+bounces-117427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B988AB46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7CA2C69D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9086140;
	Mon, 25 Mar 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tAK4T/XA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B881535AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382452; cv=none; b=CUMGq+lUODcpZpp4en+oweF8IJml2vmDa5x1/uDWuXxoYCGyOEQokC1iD1SSlC5WR3Dg+yCHkdONwZYVaXMTgrMAtspOuwEgo9owdmBmjgZs5fj3NDwWf1qelg/oWqt06jfCSA1Gqb5oAYjMkajYotF1K+l+zb5h8G7Y+Erodm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382452; c=relaxed/simple;
	bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQtiKvlF5wngxmdLwVovyUJfI9xatuoYbP2po+XAw1wHTrfUAJYJBLTkoarzsjieDJYGYLQqBlUIZjPBptuTBWKwz5R2fVp1rM/vm6ehp3o341G2CXTmUG5K4c0zXUGlbwaKQYybVI0kTmIbfSWU+hA0w7Q7OxoyZcMislCItDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tAK4T/XA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148c73255eso1466495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711382448; x=1711987248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=tAK4T/XAYg4KKEs4TbeAuEuwzm4FP/TzqbKshsyTfWHAXGgT1EeuYYKVRRwmne6uc7
         36mVMBvxx7109Vbk9rHHoaccO+Q637gYua5POUWpaTUJ1LLUtYOr7MwqnI+J2bbuJedY
         2km4SDP3KaKCmmMQmqG19Kz9Q4zxpDcENtYbqUgRbvwk/WNUv673J0s2JA64Jft6q83l
         H6Gc4GsY7dNoQkjJ1Kxg5ARt2iP/YX2OJEppnICYpMfRzfLzJ78lMQqyrDVg5UpWzLd3
         ew5JGgsnhLpQsMSJdKFL5BZHedxdCXMFy1jYISCruMd+/hRLlEtreXxpm11nL6Q9epBT
         gMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382448; x=1711987248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=p73QTRVzwkBXDqOD81nSf75n2hNkgjfeOMCnPcocEWV6hFXAfY97atlwXprlXHUdJj
         tl8cE2fqwjfNT5vOKGGqmmHv2pyOp/iCsS14yA6+NDpxt4mzeRm6Dx7z1TOUQNY6layb
         rkNy2bfCX+P9WWN0cpMnxKNRWSMOJWLSwTZSeIk+3yqaBUYg0fTjwtJHHRzqLzu1N8Lv
         Tv1G84BjsqhAzdITAswuXlyRCXLJy6GnrE96Nt37lAmBRIeCzQsDdeCZqELoOZpEleuX
         /tMC+RPhvkRWOwfZsOWX5+nxhhvx+riJ3Xd05lqghKCtYjD9teNo3dMRiG8k/NhSDGFo
         Ehhw==
X-Forwarded-Encrypted: i=1; AJvYcCV0hAo8kuG1liVPaVRPBT3QViKFxedyUK0DFqfwuDn0IdtCXfCMJePZRr3WIKJBIkSp2mU9jTdGiNh50iUYoVcdINqJ0b34KCbQJuve
X-Gm-Message-State: AOJu0YydWjZZMQNcMf2ql4M+6UL7LvSa1nJ51sGYBuzy4GlXg1yyqNka
	TSAdJdeIej7IqqufS9dAfVXJmU7GqB97pjRlTaqUMy+Vhhs4kY31AbbFcZVnBDE=
X-Google-Smtp-Source: AGHT+IHCN+EUC5Ixkwt4KEbNvTXzChsqVSlHeysS1I9s3THmhKymtJhoWpKoPj2lxZQDIDpdjgl1zQ==
X-Received: by 2002:a05:6000:a85:b0:33e:cbec:b2bd with SMTP id dh5-20020a0560000a8500b0033ecbecb2bdmr4808890wrb.9.1711382448665;
        Mon, 25 Mar 2024 09:00:48 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r17-20020adff711000000b0033b6e26f0f9sm9839361wrp.42.2024.03.25.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:00:47 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 25 Mar 2024 17:00:35 +0100
Subject: [PATCH net-next v4 1/3] net: ethernet: ti: Add accessors for
 struct k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v4-1-2e45e5dec048@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711382445; l=1852;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
 b=aymDZ233B8w10bVhhQpTuMZOAhH2dz2fHG9HbLabwWA7o+g60okp+Zk4el2Yy3QIHto1OT8y5
 JlL8nNPV0CTDZEiTJL+HQuyBPyLbN4xLZFvaPfW3jH6TAEgAr48tp04
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


