Return-Path: <linux-kernel+bounces-69681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED3858D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CCE1C21294
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924771CD2F;
	Sat, 17 Feb 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+pVfu5D"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C1D1CD0B;
	Sat, 17 Feb 2024 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145496; cv=none; b=Q9w/gnEr3yPcTwxio7VtV+PYZ1CNUHhdPPWf7TT8JwpOtQDMhXA9VHy7/Ih1527DKJd4aMS8ld705cf5pR3Rh1JAJc9NqKrEiNcR+WJ6HK6F+tW/SQ/QC+OsJqbx9q+8Ap6MzXh7JZmVhw3CSUU9m9VtI7nKqV0n1ZitKjgv2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145496; c=relaxed/simple;
	bh=RaujQfpbxxDx841ddUw9WtlW0oC4ty8/luxjiNzGCf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8P2GRzR02SQ9VH4MMYdLC2qHnB1C6QkpWl6fEGZNQxxboJCfGhcQZet49Jb+D9aTrPJWoPgebAPs7YDOSBNCDRfaJgzV4MC/4w5xY/iHDMrPk9M+w/Qwmk4UHAkg718piHYuD4UReEbBrKxfBEIF5CgPE3I5+7CHaQseeKAgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+pVfu5D; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-598699c0f1eso980948eaf.2;
        Fri, 16 Feb 2024 20:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708145494; x=1708750294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evwrpqE1Hiz2u5sFXh0svc6RdlbtMXnztqrxU8YZhPQ=;
        b=E+pVfu5D0HJFR4naP45XBuYDA2xqPtKQiR7CktDgUyEkEpy9oLTOtxJM+47IdknSlT
         JFKPd7r74MEXUB9KrNtg+I2nL/V0BesK//sW9dpBWWsD6RCKi6qAeIIkTrM0hZJp/vlx
         FLQ3dO86wGDeIzVgyaGIzgcofUwY3+sVAh9LJupuM9Uj/0eR+o4t7d72Oa10TZRPTl07
         Kfxd081WMU8xw8A65AVUknUWMxxG5KUv04s1/wgm53wp0YRKVLOnl00k6W0e6xLUHBAu
         /a5O1FASb8zDyGw04j4VSgPX1Pnnjh5rpLLBonDbgI1IZ6t/QKfUllp4ihtRJAqlHagT
         d9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145494; x=1708750294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evwrpqE1Hiz2u5sFXh0svc6RdlbtMXnztqrxU8YZhPQ=;
        b=sF2AIadDbPibjy8j5RphFzOPoAZfOdbEc4pakgWhC1d8LvrUY/O45F83c5qeeBfeWo
         LUizVVSpd8lmc01/FnNms+EH+HbNrIuFoF8+Hx61Uj1v96AaB3/1UaacNOXtWBf3r0d4
         XzfZ6UQubYJ8rnsU7C6aw2VfiDN4dSJ774JVsfk4GN8HsYzI/ao7v7U7SvQsJjCc22/B
         Frui2R9BYrWeB0zBP1tiQ5BQgxRaVE3B1IjEUCJ34LxgHqpGewIqn29o16de55fOq/Ma
         F/FwDLNvXQPGMymfbqpnNskamocIZOY2GDySytYIIOUEn+tp0x4CSLtLC5AZfdz6TPrP
         x41A==
X-Forwarded-Encrypted: i=1; AJvYcCUNhLY7e0lu85wdyLpebscElEzq1selaBC5UeIpPMNaUtrwpkS/+SoKIgChPkzKi6StUzS0cTFFHzVY7INKQC4ZgGxmhdYre/3Y+6223SM2XSKGWIbZMWpoznE9Zak6+RIvAa3p1uBkcFT1
X-Gm-Message-State: AOJu0Yy/Kf5VoWP4fij/grGw9EJUT/vTc4TsCzGRJCnRxYqsXag3ox7i
	Dp+BL1p/1yziSvfXsXCNKeDf/whN5OAkmPyleVTbWuZY1q2MH9tt
X-Google-Smtp-Source: AGHT+IGXBcB2jEgts68yjl1/2gfApQFlQtEQ7ti8tGvcpljUmlNkpP8SfC6UTw1pnxGbgjKEotNTBA==
X-Received: by 2002:a05:6358:3a04:b0:178:f895:5978 with SMTP id g4-20020a0563583a0400b00178f8955978mr9891587rwe.10.1708145494362;
        Fri, 16 Feb 2024 20:51:34 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e82e:22f2:1bdb:989f])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm610703pgm.10.2024.02.16.20.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:51:34 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v3 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
Date: Sat, 17 Feb 2024 17:51:01 +1300
Message-Id: <20240217045102.55339-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217045102.55339-1-21cnbao@gmail.com>
References: <20240217045102.55339-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Most compressors are actually CPU-based and won't sleep during
compression and decompression. We should remove the redundant
memcpy for them.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 350dd2fc8159..6319d2281020 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
 	struct crypto_wait wait;
 	u8 *buffer;
 	struct mutex mutex;
+	bool is_sleepable;
 };
 
 /*
@@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_sleepable(acomp);
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
 	if (!req) {
@@ -1368,7 +1370,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
+	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1382,7 +1384,7 @@ static void __zswap_load(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(zpool))
+	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


