Return-Path: <linux-kernel+bounces-79940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D828628D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D1A1F21849
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00015E89;
	Sun, 25 Feb 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QX5sk03l"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4CE11718
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828728; cv=none; b=fg/YDDzcdYYsdF5kbfWI6qArGtPDTLc8qUXI5dfsM0SFUY1A3tU7mif07/ks4mnGOjkAPwe3z26wKS4mC5uSwih+nFjCplAf2TpvJ/1TFgEcUgKUs9cOs7sULt1sI733+dNNAmtyyTXHVACHdoH33U/8OCqRdRdG5z16Z7Agzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828728; c=relaxed/simple;
	bh=E/Dw+70hY8yzNuYISXbZNy7QhvNTNxoGY+Dru6pQDaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+s0rnO+VUToOx3Fyk9Hwjm24jz+GRD7m5vxaW4MV0AUZiV48PVsytA+ePDGfUQPuZL9vh3W6nleXuCMdotrBobuo+3kV9rl7pUvvgau7/sgXUjV73FoV/6BKaJEz7fYmbehOtxb81jsXyCZ/WQChjXQTuX+iGvxplVL+ZM625Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QX5sk03l; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nYmc8JzzayqwmwTcyeDB+fspGtJHDUPXZk3mSOrddE=;
	b=QX5sk03loVgVOzDEg/keMY5owPiZTJ3+TdpipV+jUiDa++8JEBtz5FnYXvCpNkH5KQT6gy
	bD7x6WgvlMGsCwMbJ5P8aWaS6aqKDIPsAaBUZtNstJtQXdmQtSwXcmktZ7uUjhhkyXIDZS
	q7BL40Ei0WhoEKhdATFkWEamlBHafuM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 11/21] bcachefs: Kill bch2_fs_usage_to_text()
Date: Sat, 24 Feb 2024 21:38:13 -0500
Message-ID: <20240225023826.2413565-12-kent.overstreet@linux.dev>
In-Reply-To: <20240225023826.2413565-1-kent.overstreet@linux.dev>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Dead code.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/buckets.c | 39 ---------------------------------------
 fs/bcachefs/buckets.h |  3 ---
 2 files changed, 42 deletions(-)

diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 8476bd5cb3af..c261fa3a0273 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -32,45 +32,6 @@ void bch2_dev_usage_read_fast(struct bch_dev *ca, struct bch_dev_usage *usage)
 	acc_u64s_percpu((u64 *) usage, (u64 __percpu *) ca->usage, dev_usage_u64s());
 }
 
-void bch2_fs_usage_to_text(struct printbuf *out,
-			   struct bch_fs *c,
-			   struct bch_fs_usage_online *fs_usage)
-{
-	unsigned i;
-
-	prt_printf(out, "capacity:\t\t\t%llu\n", c->capacity);
-
-	prt_printf(out, "hidden:\t\t\t\t%llu\n",
-	       fs_usage->u.b.hidden);
-	prt_printf(out, "data:\t\t\t\t%llu\n",
-	       fs_usage->u.b.data);
-	prt_printf(out, "cached:\t\t\t\t%llu\n",
-	       fs_usage->u.b.cached);
-	prt_printf(out, "reserved:\t\t\t%llu\n",
-	       fs_usage->u.b.reserved);
-	prt_printf(out, "nr_inodes:\t\t\t%llu\n",
-	       fs_usage->u.b.nr_inodes);
-	prt_printf(out, "online reserved:\t\t%llu\n",
-	       fs_usage->online_reserved);
-
-	for (i = 0;
-	     i < ARRAY_SIZE(fs_usage->u.persistent_reserved);
-	     i++) {
-		prt_printf(out, "%u replicas:\n", i + 1);
-		prt_printf(out, "\treserved:\t\t%llu\n",
-		       fs_usage->u.persistent_reserved[i]);
-	}
-
-	for (i = 0; i < c->replicas.nr; i++) {
-		struct bch_replicas_entry_v1 *e =
-			cpu_replicas_entry(&c->replicas, i);
-
-		prt_printf(out, "\t");
-		bch2_replicas_entry_to_text(out, e);
-		prt_printf(out, ":\t%llu\n", fs_usage->u.replicas[i]);
-	}
-}
-
 static u64 reserve_factor(u64 r)
 {
 	return r + (round_up(r, (1 << RESERVE_FACTOR)) >> RESERVE_FACTOR);
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index dfdf1b3ee817..ccf9813c65e7 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -294,9 +294,6 @@ static inline unsigned dev_usage_u64s(void)
 	return sizeof(struct bch_dev_usage) / sizeof(u64);
 }
 
-void bch2_fs_usage_to_text(struct printbuf *,
-			   struct bch_fs *, struct bch_fs_usage_online *);
-
 u64 bch2_fs_sectors_used(struct bch_fs *, struct bch_fs_usage_online *);
 
 struct bch_fs_usage_short
-- 
2.43.0


