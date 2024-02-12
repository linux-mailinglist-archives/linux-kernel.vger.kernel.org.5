Return-Path: <linux-kernel+bounces-62183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E957F851CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1C7280F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3245405DF;
	Mon, 12 Feb 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0/hwuBum";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+U6b+pW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0/hwuBum";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+U6b+pW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C54C99
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762639; cv=none; b=n4Ys9bhIVEPTzlIIygMJppU7YrQVX/yjTwY3xgRDzon5hFJGFrxy/FtkzFO8VPZYNdX5DF7DWY8bcApLtUqiM5QpcZKNDNTNTbuDnYM2IdEbFayk6EYdYxOT06ZDj9eNAvhq/dyRUmet04A+8Soe1JUOwEp7XVJbBxsSRQUIw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762639; c=relaxed/simple;
	bh=z7Y7dcNtFW7dfLyXzQkjcb3bowGb9h7Q40AVimHs/Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvCCX4YFUWeb65nRHjYThg2PWT8hGJMxW9OzBJ/YwiRFUHOEOAegjWq/DXdYg3/QUvjJ8S6YaPzjUfy8Kr79zsUe2YOu+W0UCHluklrXhXBl/tDyZD9t/ibWBgO9sv9VmLjTwNyQojsfi1SEfIWCoqh5Eemea2h9BGIC/0ov2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0/hwuBum; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+U6b+pW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0/hwuBum; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+U6b+pW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7FBF1FD57;
	Mon, 12 Feb 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707762635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v5G/99tmVUbOuo9NvYuOOZiHrh75CYs7vqqYAovtwVs=;
	b=0/hwuBumPqPbbsn4MvvwMY1ZlKEg9xSDTK7FjHXithOGgkM8TiaufL5j/Q2ergik+52SEG
	Ke+dope4YqdlhE9nXDp2nLRzCUeLF7EcSgrTcFfeMFdapAtutX6GQirvFNwLXN4/Jmcw2a
	92lNWtuY8v15+LfeAaMdyEHyjfjRfLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707762635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v5G/99tmVUbOuo9NvYuOOZiHrh75CYs7vqqYAovtwVs=;
	b=b+U6b+pWz9q/ylIZfDXNiGN6Rv2EiarrxhbA26DI9vfzWtHN828IZZC1zQGa8LOwCp8i/Q
	wenw/aGqo09BQ9AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707762635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v5G/99tmVUbOuo9NvYuOOZiHrh75CYs7vqqYAovtwVs=;
	b=0/hwuBumPqPbbsn4MvvwMY1ZlKEg9xSDTK7FjHXithOGgkM8TiaufL5j/Q2ergik+52SEG
	Ke+dope4YqdlhE9nXDp2nLRzCUeLF7EcSgrTcFfeMFdapAtutX6GQirvFNwLXN4/Jmcw2a
	92lNWtuY8v15+LfeAaMdyEHyjfjRfLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707762635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v5G/99tmVUbOuo9NvYuOOZiHrh75CYs7vqqYAovtwVs=;
	b=b+U6b+pWz9q/ylIZfDXNiGN6Rv2EiarrxhbA26DI9vfzWtHN828IZZC1zQGa8LOwCp8i/Q
	wenw/aGqo09BQ9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F8213404;
	Mon, 12 Feb 2024 18:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dVXOLstjymVWEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Feb 2024 18:30:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm: document memalloc_noreclaim_save() and memalloc_pin_save()
Date: Mon, 12 Feb 2024 19:29:51 +0100
Message-ID: <20240212182950.32730-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,kernel.org,techsingularity.net,infradead.org,gmail.com,soleen.com,linux.ibm.com,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: ***
X-Spam-Score: 3.40
X-Spam-Flag: NO

The memalloc_noreclaim_save() function currently has no documentation
comment, so the implications of its usage are not obvious. Namely that
it not only prevents entering reclaim (as the name suggests), but also
allows using all memory reserves and thus should be only used in
contexts that are allocating memory to free memory. This may lead to new
improper usages being added.

Thus add a documenting comment, based on the description of
__GFP_MEMALLOC. While at it, also document memalloc_pin_save() so that
all the memalloc_ scopes are documented. In the comments describing the
relevant PF_MEMALLOC flags, refer to their scope setting functions.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/sched.h    |  9 ++++----
 include/linux/sched/mm.h | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..f2cb479f56a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1623,15 +1623,15 @@ extern struct pid *cad_pid;
 #define PF_SUPERPRIV		0x00000100	/* Used super-user privileges */
 #define PF_DUMPCORE		0x00000200	/* Dumped core */
 #define PF_SIGNALED		0x00000400	/* Killed by a signal */
-#define PF_MEMALLOC		0x00000800	/* Allocating memory */
+#define PF_MEMALLOC		0x00000800	/* Allocating memory to free memory. See memalloc_noreclaim_save() */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
 #define PF__HOLE__00010000	0x00010000
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
-#define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
-#define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
+#define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
+#define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
 #define PF_LOCAL_THROTTLE	0x00100000	/* Throttle writes only against the bdi I write to,
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
@@ -1641,7 +1641,8 @@ extern struct pid *cad_pid;
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
-#define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
+#define PF_MEMALLOC_PIN		0x10000000	/* Allocations constrained to zones which allow long term pinning.
+						 * See memalloc_pin_save() */
 #define PF__HOLE__20000000	0x20000000
 #define PF__HOLE__40000000	0x40000000
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 9a19f1b42f64..eef8fa5ba5de 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -368,6 +368,27 @@ static inline void memalloc_nofs_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC_NOFS) | flags;
 }
 
+/**
+ * memalloc_noreclaim_save - Marks implicit __GFP_MEMALLOC scope.
+ *
+ * This functions marks the beginning of the __GFP_MEMALLOC allocation scope.
+ * All further allocations will implicitly add the __GFP_MEMALLOC flag, which
+ * prevents entering reclaim and allows access to all memory reserves. This
+ * should only be used when the caller guarantees the allocation will allow more
+ * memory to be freed very shortly, i.e. it needs to allocate some memory in
+ * the process of freeing memory, and cannot reclaim due to potential recursion.
+ *
+ * Users of this scope have to be extremely careful to not deplete the reserves
+ * completely and implement a throttling mechanism which controls the
+ * consumption of the reserve based on the amount of freed memory. Usage of a
+ * pre-allocated pool (e.g. mempool) should be always considered before using
+ * this scope.
+ *
+ * Individual allocations under the scope can opt out using __GFP_NOMEMALLOC
+ *
+ * This function should not be used in an interrupt context as that one does not
+ * give PF_MEMALLOC access to reserves, see __gfp_pfmemalloc_flags().
+ */
 static inline unsigned int memalloc_noreclaim_save(void)
 {
 	unsigned int flags = current->flags & PF_MEMALLOC;
@@ -375,11 +396,27 @@ static inline unsigned int memalloc_noreclaim_save(void)
 	return flags;
 }
 
+/**
+ * memalloc_noreclaim_restore - Ends the implicit __GFP_MEMALLOC scope.
+ * @flags: Flags to restore.
+ *
+ * Ends the implicit __GFP_MEMALLOC scope started by memalloc_noreclaim_save
+ * function. Always make sure that the given flags is the return value from the
+ * pairing memalloc_noreclaim_save call.
+ */
 static inline void memalloc_noreclaim_restore(unsigned int flags)
 {
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
+/**
+ * memalloc_pin_save - Marks implicit ~__GFP_MOVABLE scope.
+ *
+ * This functions marks the beginning of the ~__GFP_MOVABLE allocation scope.
+ * All further allocations will implicitly remove the __GFP_MOVABLE flag, which
+ * will constraint the allocations to zones that allow long term pinning, i.e.
+ * not ZONE_MOVABLE zones.
+ */
 static inline unsigned int memalloc_pin_save(void)
 {
 	unsigned int flags = current->flags & PF_MEMALLOC_PIN;
@@ -388,6 +425,14 @@ static inline unsigned int memalloc_pin_save(void)
 	return flags;
 }
 
+/**
+ * memalloc_pin_restore - Ends the implicit ~__GFP_MOVABLE scope.
+ * @flags: Flags to restore.
+ *
+ * Ends the implicit ~__GFP_MOVABLE scope started by memalloc_pin_save function.
+ * Always make sure that the given flags is the return value from the pairing
+ * memalloc_pin_save call.
+ */
 static inline void memalloc_pin_restore(unsigned int flags)
 {
 	current->flags = (current->flags & ~PF_MEMALLOC_PIN) | flags;
-- 
2.43.0


