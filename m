Return-Path: <linux-kernel+bounces-135747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA289CABE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DBF1F2776D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D38144D03;
	Mon,  8 Apr 2024 17:26:23 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A861448E6;
	Mon,  8 Apr 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597182; cv=none; b=YT6OyXmzqSky/Qv1dfBz2dG/5SfwX26AVavlKX3MSjtBPgcd9knAsO+SgRXMm5KfDvLtWBiqg4diTQFaoFl0srYrl0BeQurQm9u65mKiv4LuHAIMSPDKIqIuqDqeQOhX7eH1caOUlr6EwjKb90BdUqyddFI4LT16t8+Q5AcM5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597182; c=relaxed/simple;
	bh=QPTI0Nkyu1TM5zoNdUKd64u7ifIX9UASRm9jdOshan0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V82wDhZT/+pQl4Yr+Q772hktDTT3VNJByg/0r+fgf9EtBbKToGlgkLkoJ3GhTvXzbgDNvzuhZzyrQqeixqzSvaq0Ju/tm2quFNJxhMFw28a1ujC0hi1qB82wdV3PH8hET5QSBhgd86Jr+kHxt52JxnFxcPAJebuEX1pej7B5j8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so806103a12.1;
        Mon, 08 Apr 2024 10:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597179; x=1713201979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEv54p1vC2qDsADoejwxZbGsBSC01L0fD1We714EtHU=;
        b=hNrhqdkvNKGu9tFxLaQ29uzV1fW/3AecZIEz33KGMPQjf8YG8Vy7K4ApTFn5fzz9/5
         3IkhGyackK2ymlS3gRWe8BpkIHzr9jO6hOqIAX3DKPlIF87wUuubhKH4JDwkVaCIeVPi
         CSRcToYt+g1+MF3+bXS33HU1/rv14ZizO88NECnvLYIv8JWDd63ABmdgM6k3ufAyquYv
         iVL+1IKQhJtJ7L/HUe3ZImK1FHHo2MUm3d1CpFyctlgUylmANccmy/R6byer0maL5Zp8
         rnznq/XfCV8GTFCvgS4lZvjFSW4enCdNUq4YtRDo/kO0YefBxBM9KoHcCYqnKjOviojv
         JC8A==
X-Forwarded-Encrypted: i=1; AJvYcCWQKdKYXwLJbkEj8w4gy7YhuLCQK/RZrLBiYxWnB4AqrpsbfPTO6bP6gpKhU51RNz1iGhRpDR+tj5IWHpNafyiaIYMBzaZa
X-Gm-Message-State: AOJu0YyOTi6w0/WfO94JxCjZG8qJnG5Z0LKVA54MEmoqif32cEg/I/PN
	Rh3X/4mL7qhX7iHH7h/0LYj/OzA9ZLPaFENkpzhtolk5HfAiQds2
X-Google-Smtp-Source: AGHT+IGucU9e6u2LQ+HBNngAU6cRcqKv1d01Xd4CYYi7t3yLVz54NP4Y42MX5JIm78r3DlxX0ikk4w==
X-Received: by 2002:a17:907:7248:b0:a51:abb0:a8a2 with SMTP id ds8-20020a170907724800b00a51abb0a8a2mr8381554ejc.42.1712597179141;
        Mon, 08 Apr 2024 10:26:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a51cfd5c6ddsm2101455ejc.9.2024.04.08.10.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:26:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: dql: Separate queue function responsibilities
Date: Mon,  8 Apr 2024 10:25:54 -0700
Message-ID: <20240408172605.635508-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408172605.635508-1-leitao@debian.org>
References: <20240408172605.635508-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dql_queued() function currently handles both queuing object counts
and populating bitmaps for reporting stalls.

This commit splits the bitmap population into a separate function,
allowing for conditional invocation in scenarios where the feature is
disabled.

This refactor maintains functionality while improving code
organization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/dynamic_queue_limits.h | 44 ++++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index ff9c65841ae8..9980df0b7247 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -83,28 +83,11 @@ struct dql {
 #define DQL_MAX_OBJECT (UINT_MAX / 16)
 #define DQL_MAX_LIMIT ((UINT_MAX / 2) - DQL_MAX_OBJECT)
 
-/*
- * Record number of objects queued. Assumes that caller has already checked
- * availability in the queue with dql_avail.
- */
-static inline void dql_queued(struct dql *dql, unsigned int count)
+/* Populate the bitmap to be processed later in dql_check_stall() */
+static inline void dql_queue_stall(struct dql *dql)
 {
 	unsigned long map, now, now_hi, i;
 
-	if (WARN_ON_ONCE(count > DQL_MAX_OBJECT))
-		return;
-
-	dql->last_obj_cnt = count;
-
-	/* We want to force a write first, so that cpu do not attempt
-	 * to get cache line containing last_obj_cnt, num_queued, adj_limit
-	 * in Shared state, but directly does a Request For Ownership
-	 * It is only a hint, we use barrier() only.
-	 */
-	barrier();
-
-	dql->num_queued += count;
-
 	now = jiffies;
 	now_hi = now / BITS_PER_LONG;
 
@@ -134,6 +117,29 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
 		WRITE_ONCE(DQL_HIST_ENT(dql, now_hi), map | BIT_MASK(now));
 }
 
+/*
+ * Record number of objects queued. Assumes that caller has already checked
+ * availability in the queue with dql_avail.
+ */
+static inline void dql_queued(struct dql *dql, unsigned int count)
+{
+	if (WARN_ON_ONCE(count > DQL_MAX_OBJECT))
+		return;
+
+	dql->last_obj_cnt = count;
+
+	/* We want to force a write first, so that cpu do not attempt
+	 * to get cache line containing last_obj_cnt, num_queued, adj_limit
+	 * in Shared state, but directly does a Request For Ownership
+	 * It is only a hint, we use barrier() only.
+	 */
+	barrier();
+
+	dql->num_queued += count;
+
+	dql_queue_stall(dql);
+}
+
 /* Returns how many objects can be queued, < 0 indicates over limit. */
 static inline int dql_avail(const struct dql *dql)
 {
-- 
2.43.0


