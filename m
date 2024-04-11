Return-Path: <linux-kernel+bounces-141528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E0D8A1F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0421F1C23703
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC92941C;
	Thu, 11 Apr 2024 19:23:31 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B724A0D;
	Thu, 11 Apr 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863410; cv=none; b=jvzQ9ZZ9B0XtjyxWM4IAGFVOdSpL8v2NVpfaHJx+XbTHxgrjJWVohokhOEPvPDU8xvyteYoF1IGFd9FeSWdPCXripIwYR6TJquDlnBH+ejgthPE26I9MzSX1x4Y0vDB8qTBf1eZgKkGheX9f7USTeS5jystTHVT/nU2w6n6J4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863410; c=relaxed/simple;
	bh=R0Unvm4NPmW3WkpDmOtgB6W1uSHwGQG46cIqieQoOnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW11vScbUdHF9VtkodiMSlV3LtnKnHEk5X3gqs6JQ2TDmWWTKy5dixW8LmyPStmJ6sOWE/d658eNbPRGsSzcRSrPnD5WDnER4orqrlhhv+/3KUiJXruWvmMV4L1yy4fhYK6cKm22ZfjZNx9yxq08DPjk9SOn1/3c0kpdWSQHM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44ad785a44so15245766b.3;
        Thu, 11 Apr 2024 12:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863407; x=1713468207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE/a2AjBDEZ+YFbJt7MyFbW2ZbrRq3LCz8VwZ+JVQuI=;
        b=wFhT+wputGSxMgB0XveUlnPj4COIbrE8v0Lsu+6/H1oR+vC2cZPL6tHt50y5BOD/dU
         9DyLjzJaLws3LDqP4mCaG2fkeVBYoyWZcp+A69G8D94YzMnJkEC3HXpVIVdMdsG40atE
         2eqtLk82tssPd9vhXoE2cVrCguURnctr5aUECZgzfC8Cz+Ia+mKc06x2LaixcJ3ap2u2
         x9OV95ogrZb9XkljclfWyOpB6oKyr4ZYGGRxGWYCG2US9hJyC/nN3C0Dor0VuARdJxVw
         Am1LaK/sMJvlYd+8odCYhRnizHJBwFSfD/rTozj1/WJ/HTDwIg0lKwuo9gkXaiMVmXsL
         iT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFN7Z+MJGMUg8vrOoL95crew4RI2DMBqyxlkig88hvYkUbsz/CHEiKiKU0wCvWJhFvkLNw2TA2YefHcSSY32gtJ3q7VAMQ
X-Gm-Message-State: AOJu0Ywb38YXUnM9wFTj8slLOFIYjF2+Aii/V7rgYoisXsU+yHY13wnE
	QLHpHFwLp2opn25rCbLDHj4wMNb1LjRIWvIcsyLo02gYut5UA0J+
X-Google-Smtp-Source: AGHT+IFgf7RWrgPJwWaUWZVy2wh7tEVoEbXLg0EZq7L4ZAEv3VrmCaSKE/4E7N5zG4BW50T6UGrH0g==
X-Received: by 2002:a17:906:d20d:b0:a51:ad60:ea32 with SMTP id w13-20020a170906d20d00b00a51ad60ea32mr391686ejz.27.1712863407391;
        Thu, 11 Apr 2024 12:23:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id gb25-20020a170907961900b00a522d34fee8sm339842ejc.114.2024.04.11.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: dqs: make struct dql more cache efficient
Date: Thu, 11 Apr 2024 12:22:32 -0700
Message-ID: <20240411192241.2498631-5-leitao@debian.org>
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

With the previous change, struct dqs->stall_thrs will be in the hot path
(at queue side), even if DQS is disabled.

The other fields accessed in this function (last_obj_cnt and num_queued)
are in the first cache line, let's move this field  (stall_thrs) to the
very first cache line, since there is a hole there.

This does not change the structure size, since it moves an short (2
bytes) to 4-bytes whole in the first cache line.

This is the new structure format now:

struct dql {
	unsigned int    num_queued;
	unsigned int    last_obj_cnt;
..
	short unsigned int    stall_thrs;
	/* XXX 2 bytes hole, try to pack */
..
	/* --- cacheline 1 boundary (64 bytes) --- */
..
 	/* Longest stall detected, reported to user */
	short unsigned int         stall_max;
	/* XXX 2 bytes hole, try to pack */
};

Also, read the stall_thrs (now in the very first cache line) earlier,
together with dql->num_queued (also in the first cache line).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/dynamic_queue_limits.h |  5 +++--
 lib/dynamic_queue_limits.c           | 13 +++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 869afb800ea1..281298e77a15 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -50,6 +50,9 @@ struct dql {
 	unsigned int	adj_limit;		/* limit + num_completed */
 	unsigned int	last_obj_cnt;		/* Count at last queuing */
 
+	/* Stall threshold (in jiffies), defined by user */
+	unsigned short	stall_thrs;
+
 	unsigned long	history_head;		/* top 58 bits of jiffies */
 	/* stall entries, a bit per entry */
 	unsigned long	history[DQL_HIST_LEN];
@@ -71,8 +74,6 @@ struct dql {
 	unsigned int	min_limit;		/* Minimum limit */
 	unsigned int	slack_hold_time;	/* Time to measure slack */
 
-	/* Stall threshold (in jiffies), defined by user */
-	unsigned short	stall_thrs;
 	/* Longest stall detected, reported to user */
 	unsigned short	stall_max;
 	unsigned long	last_reap;		/* Last reap (in jiffies) */
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index a1389db1c30a..e49deddd3de9 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -15,12 +15,10 @@
 #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
 #define AFTER_EQ(A, B) ((int)((A) - (B)) >= 0)
 
-static void dql_check_stall(struct dql *dql)
+static void dql_check_stall(struct dql *dql, unsigned short stall_thrs)
 {
-	unsigned short stall_thrs;
 	unsigned long now;
 
-	stall_thrs = READ_ONCE(dql->stall_thrs);
 	if (!stall_thrs)
 		return;
 
@@ -86,9 +84,16 @@ void dql_completed(struct dql *dql, unsigned int count)
 {
 	unsigned int inprogress, prev_inprogress, limit;
 	unsigned int ovlimit, completed, num_queued;
+	unsigned short stall_thrs;
 	bool all_prev_completed;
 
 	num_queued = READ_ONCE(dql->num_queued);
+	/* Read stall_thrs in advance since it belongs to the same (first)
+	 * cache line as ->num_queued. This way, dql_check_stall() does not
+	 * need to touch the first cache line again later, reducing the window
+	 * of possible false sharing.
+	 */
+	stall_thrs = READ_ONCE(dql->stall_thrs);
 
 	/* Can't complete more than what's in queue */
 	BUG_ON(count > num_queued - dql->num_completed);
@@ -178,7 +183,7 @@ void dql_completed(struct dql *dql, unsigned int count)
 	dql->num_completed = completed;
 	dql->prev_num_queued = num_queued;
 
-	dql_check_stall(dql);
+	dql_check_stall(dql, stall_thrs);
 }
 EXPORT_SYMBOL(dql_completed);
 
-- 
2.43.0


