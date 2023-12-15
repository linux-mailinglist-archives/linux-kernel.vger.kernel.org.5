Return-Path: <linux-kernel+bounces-520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61515814267
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9591F23370
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B2D515;
	Fri, 15 Dec 2023 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oK+WEWb7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCADD2F0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso40383466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702625500; x=1703230300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3LpvrqPMHTpFgWHeM6VHdWnvBHwIABqDsat0ivEWK0=;
        b=oK+WEWb7yYhqHH8CkLL+1rpsbBvE7Yb3cM6grtxi48LC4dU+4d3vkV7lPITOdxLW1O
         bWqNbvd2+PwtJh11J49SeLZpApDLR55cY0ylzey7fWFrWBmKLyvNu10OtxVqEYsH7VvO
         XudGHcALJ5OmSKcZdW0m/ndVQRzU3n+HnjBxVMJExnpVVW3znzKv76iBPd9UyTtQUonr
         9BGRyTGD2LozK1/keBUvFwiIjOMt8VHkY52+jGfTVufJXoxhjiXxwUXzyqgC42gC9tvy
         LzghMz4wvuMaaMZBOPm5WGnvmUcUcvBGCVv48TZhpFOO4iOJlHMKtdqo8cnS9JKfhTTS
         bXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625500; x=1703230300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3LpvrqPMHTpFgWHeM6VHdWnvBHwIABqDsat0ivEWK0=;
        b=DPVZmIQaTSEpY9kVPoaGrSk69yaZQ3aTO7cOfhij0zxkf7OLkD1S8pxZUUOuvhSoFg
         A1ScfHnQQXgbG/AjFhmSd9OmuTrWVmpfWvrP+IE42Cn2oZbzJNEymrtxLldwUC4etrno
         3ln56F4R4GGGB+LRQdvcfFlxQK5BvAYd+4KYmQw3Qr5PnukcmWCsAVgr4vos83FRvZGr
         Z0ziV6fgFazMyYEEVXORRBdrx54r+YHzajQaaYHmpdga7laCg7rxsfI28BAs30bX1YGi
         Y0vt4Mz399UN13i2lZv57ZJQLDEI2N/+4Vd+hSetxciw1AIXMIEGjV0MD+D4GVQZJhQQ
         VM1w==
X-Gm-Message-State: AOJu0YxhPigklyDQ3XwoG03xsQ/k3g76dSPjt/hLRphvpjjA5QW81sXP
	MyKOLz/lklt+fshJF4gYEGt2hQ==
X-Google-Smtp-Source: AGHT+IGO7w//caAA7TomUzAlqUgucQ9162u3tLyJp8FS6A+kc3XcLFur1cXBsGDvXqWVUE90DLu5bA==
X-Received: by 2002:a17:907:7677:b0:a09:589f:8853 with SMTP id kk23-20020a170907767700b00a09589f8853mr5786522ejc.66.1702625499973;
        Thu, 14 Dec 2023 23:31:39 -0800 (PST)
Received: from hades.. (ppp089210121239.access.hol.gr. [89.210.121.239])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1ce58e9fc7sm10372337ejc.64.2023.12.14.23.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 23:31:39 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: netdev@vger.kernel.org
Cc: linyunsheng@huawei.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
Date: Fri, 15 Dec 2023 09:31:19 +0200
Message-Id: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [0] got merged, it's clear that 'pp_ref_count' is used to track
the number of users for each page. On struct_page though we have
a member called 'frag_users'. Despite of what the name suggests this is
not the number of users. It instead represents the number of fragments of
the current page. When we have a single page this is set to one. When we
split the page this is set to the actual number of frags and later used
in page_pool_drain_frag() to infer the real number of users.

So let's rename it to something that matches the description above

[0]
Link: https://lore.kernel.org/netdev/20231212044614.42733-2-liangchen.linux@gmail.com/
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/net/page_pool.h | 2 +-
 net/core/page_pool.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 813c93499f20..957cd84bb3f4 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -158,7 +158,7 @@ struct page_pool {
 	u32 pages_state_hold_cnt;
 	unsigned int frag_offset;
 	struct page *frag_page;
-	long frag_users;
+	long frag_cnt;

 #ifdef CONFIG_PAGE_POOL_STATS
 	/* these stats are incremented while in softirq context */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9b203d8660e4..19a56a52ac8f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
 static struct page *page_pool_drain_frag(struct page_pool *pool,
 					 struct page *page)
 {
-	long drain_count = BIAS_MAX - pool->frag_users;
+	long drain_count = BIAS_MAX - pool->frag_cnt;

 	/* Some user is still using the page frag */
 	if (likely(page_pool_defrag_page(page, drain_count)))
@@ -678,7 +678,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,

 static void page_pool_free_frag(struct page_pool *pool)
 {
-	long drain_count = BIAS_MAX - pool->frag_users;
+	long drain_count = BIAS_MAX - pool->frag_cnt;
 	struct page *page = pool->frag_page;

 	pool->frag_page = NULL;
@@ -721,14 +721,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 		pool->frag_page = page;

 frag_reset:
-		pool->frag_users = 1;
+		pool->frag_cnt = 1;
 		*offset = 0;
 		pool->frag_offset = size;
 		page_pool_fragment_page(page, BIAS_MAX);
 		return page;
 	}

-	pool->frag_users++;
+	pool->frag_cnt++;
 	pool->frag_offset = *offset + size;
 	alloc_stat_inc(pool, fast);
 	return page;
--
2.37.2


