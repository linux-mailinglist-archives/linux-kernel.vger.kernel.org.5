Return-Path: <linux-kernel+bounces-131663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BF898A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2457B1C28419
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CF12AAEC;
	Thu,  4 Apr 2024 15:00:25 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE312AAD9;
	Thu,  4 Apr 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242824; cv=none; b=FZjXuTef7qgolFGA7i7S7R3M/yxkIVVLdlF1M3qr9rCsTF2Y6s7PRhqx3ZYuf5fNk6JgFpKnJYUVDiWepDvbpxD6rN0wS/z/aCyaqn8clPnFX54D/tUXYbCqUzZXkZ68sIr9aJXIjtrYM+GDSu7Gh9xQLefiXBNZmtlrTS4OTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242824; c=relaxed/simple;
	bh=QPTI0Nkyu1TM5zoNdUKd64u7ifIX9UASRm9jdOshan0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3tBTKWWcgmencDmj3NtxQJjMPSUMCk7m5LQ8smJabSdMDiiDUxqR00P9l3yxhr0820dgzdSWkf3nxpAcAovFbAAVzw0SwEtBwyyQyiNpe05WvnTG+iVdTsFk6wnf9W+gazPbaWpWwN9zbO3EhEVLwnQPrxXNE079gDq+/3qoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4644bde1d4so157826066b.3;
        Thu, 04 Apr 2024 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242821; x=1712847621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEv54p1vC2qDsADoejwxZbGsBSC01L0fD1We714EtHU=;
        b=guMeSEBdN0MpQtzWfNcRHHABwfxiYsuV1TkR/xRBzVfzF5j5QzgjtdVS3Q6bGvKHP2
         HobNsFTYxW/ib6eNBiiOsSdP87HbOpFZuRk/buLvbYdlSVNpOaKkT/V5MchEEX7KB594
         FVGPqchHEKiGWT1dirFOEWuG+Nc0/8o0qXGG7+D9XcWoF00HEWpQqxlAfqZdC+qcUn0h
         ul66cuswlrgRb5wojBT4aLTiJ9cuaBkAbwoc7kEn8J/X+CkYlvQgs6mDNWnGTN7SkqxK
         Y6FcUHuadLuWaNCNdeYU/sheP9G618beoDe/kyd98UzKLiYbvduoBHi/KIGdEr1EqzBQ
         3lkA==
X-Forwarded-Encrypted: i=1; AJvYcCWa99kotzwU6s+Et61DQrfOJMoQ70ZfhiLM7cTUofEbgAJugRjK8YWOJvkdPv5VM0xeJO1FpPE57i8LrF2Yfq2gLZKZR4Ii
X-Gm-Message-State: AOJu0YyCt7iQ08S+c4nGpo87x5nWtwAu6HTAis+Fhc9kvCYBHmzNpM2d
	hQt3G8DH4tBla6+ixInt1bMc4d5w/eXBxki8EsvDzEwxdUoWft+Q
X-Google-Smtp-Source: AGHT+IGSm1ig6tfkkFYUdM4RDmL18XO0ChJzMqtLdAYzUkO2iv4ZY48462pkyJtczW9Dmnz1a3r3fw==
X-Received: by 2002:a17:906:4f13:b0:a4a:3557:6be8 with SMTP id t19-20020a1709064f1300b00a4a35576be8mr1840073eju.53.1712242821210;
        Thu, 04 Apr 2024 08:00:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b00a47459e7371sm9137157ejc.79.2024.04.04.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:00:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dql: Separate queue function responsibilities
Date: Thu,  4 Apr 2024 07:59:31 -0700
Message-ID: <20240404145939.3601097-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404145939.3601097-1-leitao@debian.org>
References: <20240404145939.3601097-1-leitao@debian.org>
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


