Return-Path: <linux-kernel+bounces-141526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A88A1F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05403282A11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22C1863B;
	Thu, 11 Apr 2024 19:23:24 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921C182DF;
	Thu, 11 Apr 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863403; cv=none; b=ngxa7tGfYr09zKAzLEibCpoWpmhzqztuk/Ojqv9Aja4o1agjzfMrwtFHhle7H+fBf0N/ZaBeaIcKEnvp+uL++/DnQWsDwFuiRzWMcMypqnRJIf2PML5GwlYTaZZK/j1aAW5/LeEknUaEELdRFZDioNjlNb0pnOW9JCioaADP//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863403; c=relaxed/simple;
	bh=QPTI0Nkyu1TM5zoNdUKd64u7ifIX9UASRm9jdOshan0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKiq/DtR0msyrX7XR83sIzOI8PzYWpLZ+Twgj3MVeMOB2vmrDeLsPBEZZ/bqy69h4T9WSKB483Fgdhrp0ZDC6zlj4kCmJynqgrEb9zn5ATEHVvLlTXESx0eRiJGrFmkCxRHhUPqS5uqevS+HQBSkN4BHVw7QG1PgImE2QeiU+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51d3193e54so16730966b.2;
        Thu, 11 Apr 2024 12:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863400; x=1713468200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEv54p1vC2qDsADoejwxZbGsBSC01L0fD1We714EtHU=;
        b=mvwjQDiV2ilTtthar2q9rShEn5RXw6SHo8nzIV/cvzmkZs+zBQyRh2Lf8I3Jhzd8wP
         2kLAkTspGrOgxyr892XI9gVQlnloGBaINQy12axGvD+UXKMl+L4ZwZIFjSa4UvYBIKiU
         wRp0jNLgg4mDGLq/F9/O4WuPApAYvgk9p6rof4ulDNcJz5uOtDwo5xvlq3ktorfEtYns
         x+jg6LMY5LW4YcKZb3QdXjCz6HBBvuJ+SSWhowpdsiZJIcMhUJuCcbqri4qpXtMxbuq7
         BfJ/MtIoD3n2C5BIf80clneW9jeFzxJccZvofQfkw70KTCd2OSSi4fku8pfn4LrPEvma
         xPZg==
X-Forwarded-Encrypted: i=1; AJvYcCUUORls+rur0uODHrJD51HQ087U0U5cFFJ2Dv8yiHcChHjAdXbhJus2mdE6XI6jrftAlbwijdfySSS/CvAW0gi6gDLAAG86
X-Gm-Message-State: AOJu0Yxp6wenxq4XBGQBQHQSVpf+ZlgN5FlRRytjDzP2LbI5MxgwD/9M
	VP8lWfyDbQwsYFarHwsPplki8Alr3D64S1BenhwATaDTpFbZbJ/N
X-Google-Smtp-Source: AGHT+IGdgNwyIFMyr6Rhok3HHtgo78XoHXVjVQjg56eVusm0XtiU7uKa947mvkVX/faDh3ZwiiKdKw==
X-Received: by 2002:a17:906:6a01:b0:a4e:a7a:84e0 with SMTP id qw1-20020a1709066a0100b00a4e0a7a84e0mr480350ejc.34.1712863400319;
        Thu, 11 Apr 2024 12:23:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090681cb00b00a46af0fbf5dsm1007595ejx.103.2024.04.11.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/4] net: dql: Separate queue function responsibilities
Date: Thu, 11 Apr 2024 12:22:30 -0700
Message-ID: <20240411192241.2498631-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411192241.2498631-1-leitao@debian.org>
References: <20240411192241.2498631-1-leitao@debian.org>
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


