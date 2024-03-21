Return-Path: <linux-kernel+bounces-110184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E83885B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4D2B24A09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ABB85C76;
	Thu, 21 Mar 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLffW4Y"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0E84A5A;
	Thu, 21 Mar 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033061; cv=none; b=L/fHaGI0uH4J3K7MZFHIK2ass6/GAlGDZEqSG+fudVGFRGyHpKjzwHgDk5yjifOXWGAFWchgPyrVjawkCU/X5ea4BTEirIb4TvoFqr5IvvdQXM6OzvNOo9Ki3D+yLFr2bAXAcIBuhHfmQZgjp1H2RUwEx1n/Br8Lqz583eg4frE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033061; c=relaxed/simple;
	bh=OP5rImtzJo8ufuiNRhbyyhSsEnw8dl1VEzRpPhWVrTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOikl5PJxRoqeRTTLEU8PVCGcDdOa2wLmA9EzNakwsDUKGJ6Vrn7mCQlnjOculhXXN+FJ3rJZhSPlUnz/HghfyeHcwWrOapE+qW3z5Sb9VQCs4o7PYI4UzVkNJJ/xpZLPYY+FB1QEpXQn5rowBWxPfzf/cCW8EhqmNs4mjZXcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLffW4Y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so149327866b.0;
        Thu, 21 Mar 2024 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711033057; x=1711637857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPAsjljvq9spN9J6oarTkPbOp/uQy9Vt5YZP8TNCUI4=;
        b=KWLffW4Y0k8TAYZLhfd3ckpCmSf4dq6adWwlGES2BIvnsVHp/rP+Yrl+jEJvv0wgv/
         s0zpqPbTTYlo8oWvmEHeUdNcDqDKfJ0E2xk1oKhrcISTK8O3MKCIneilfpvcWUxNnP8W
         fUUZ05aUWGehnbWVuKVbYgwZpzL/YzrIsehqYhAz447LFtQ9qNXgBg/O5bPqmWHdUUkI
         tgXMLs3Bf+IBZASrihwPp3bHpawhhqRcaRXbyEEItAqGBbb3xVIUPWGJsmNsiE0bbrCG
         aQOWO897OzhxL2JiKRcIiYasQhbaZFOYKELzscLWLLnSOlXPITNbKKjNjfpm+hNYANhk
         e7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033057; x=1711637857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPAsjljvq9spN9J6oarTkPbOp/uQy9Vt5YZP8TNCUI4=;
        b=r7FA0CFQ5bzO9twkeUTwwHwwdMh8RpgyV0p8yjuCgVykQrAM9unuJtrIQD2tjGAf+I
         9lWf2qCwCkzkwAcmeYWSseau2uTomTMBtEEdFpEtjJ8kEjEtlx695ZgSLufnSkEjnmwt
         tA2W7EBShXJa9pALZWUFGKNlkHVyDiQZF3QB1he6pw/5q+4mzJwt7tc2GCRdZ73Kr/Nd
         US57+iRJconO3WiroJMfQ8RR9q7gqrIrR15Kb+X46af4SalV2ianHbSMjGMdB6vpwigN
         ZdaSpdebInlSjvDzTRAyofsj+iP3VDNKjFooDOfktx2jpW1mk0PdrcNGKC8Q38hwgymS
         VFbg==
X-Forwarded-Encrypted: i=1; AJvYcCWlsZM2+8foCDQf5msT5KgjwNdoTEVK6ZAJ7CIg35jvOwBcHMt0AD3ZE7y7FjxMEoqBevahE0sCemHG4p6Ht0X5uzuM/AbQR+F44KeLMPbFHhD0H38Qi2fE0BwHe5F5dIBIx8y6SilW9fcKcb6FwENiF5pTX0hkv6XwfsI8gSDRM77kYA==
X-Gm-Message-State: AOJu0YxgwN3ZqXfd3D/zO5rKiqh1SGNciZ2xGYLN6QsIXSK6/07fK54w
	zs+cuc4Uls3iDN0IuT7Z/1Ew6ZfY4bKX6BNu9J8Aeij8u42J5Ae0l0i6+0ewbNGyEw==
X-Google-Smtp-Source: AGHT+IFSqXkh2+8koR7VIEtj/qcJxmLHIngN30f6gr+BZ7rBiR3MmUYzBMVJ2N8B2BhwCtIBXUJa3w==
X-Received: by 2002:a17:907:86a4:b0:a47:1d3f:b321 with SMTP id qa36-20020a17090786a400b00a471d3fb321mr650778ejc.8.1711033057333;
        Thu, 21 Mar 2024 07:57:37 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id bm19-20020a170906c05300b00a44180ab871sm5831ejb.50.2024.03.21.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:57:36 -0700 (PDT)
From: Jonathan Haslam <jonathan.haslam@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: jonathan.haslam@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] uprobes: reduce contention on uprobes_tree access
Date: Thu, 21 Mar 2024 07:57:35 -0700
Message-ID: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Active uprobes are stored in an RB tree and accesses to this tree are
dominated by read operations. Currently these accesses are serialized by
a spinlock but this leads to enormous contention when large numbers of
threads are executing active probes.

This patch converts the spinlock used to serialize access to the
uprobes_tree RB tree into a reader-writer spinlock. This lock type
aligns naturally with the overwhelmingly read-only nature of the tree
usage here. Although the addition of reader-writer spinlocks are
discouraged [0], this fix is proposed as an interim solution while an
RCU based approach is implemented (that work is in a nascent form). This
fix also has the benefit of being trivial, self contained and therefore
simple to backport.

This change has been tested against production workloads that exhibit
significant contention on the spinlock and an almost order of magnitude
reduction for mean uprobe execution time is observed (28 -> 3.5 microsecs).

[0] https://docs.kernel.org/locking/spinlocks.html

Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
---
 kernel/events/uprobes.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 929e98c62965..42bf9b6e8bc0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
  */
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
-static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
+static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
 	struct uprobe *uprobe;
 
-	spin_lock(&uprobes_treelock);
+	read_lock(&uprobes_treelock);
 	uprobe = __find_uprobe(inode, offset);
-	spin_unlock(&uprobes_treelock);
+	read_unlock(&uprobes_treelock);
 
 	return uprobe;
 }
@@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 {
 	struct uprobe *u;
 
-	spin_lock(&uprobes_treelock);
+	write_lock(&uprobes_treelock);
 	u = __insert_uprobe(uprobe);
-	spin_unlock(&uprobes_treelock);
+	write_unlock(&uprobes_treelock);
 
 	return u;
 }
@@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
 	if (WARN_ON(!uprobe_is_active(uprobe)))
 		return;
 
-	spin_lock(&uprobes_treelock);
+	write_lock(&uprobes_treelock);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
-	spin_unlock(&uprobes_treelock);
+	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);
 }
@@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	spin_lock(&uprobes_treelock);
+	read_lock(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
 	if (n) {
 		for (t = n; t; t = rb_prev(t)) {
@@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
 			get_uprobe(u);
 		}
 	}
-	spin_unlock(&uprobes_treelock);
+	read_unlock(&uprobes_treelock);
 }
 
 /* @vma contains reference counter, not the probed instruction. */
@@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
-	spin_lock(&uprobes_treelock);
+	read_lock(&uprobes_treelock);
 	n = find_node_in_range(inode, min, max);
-	spin_unlock(&uprobes_treelock);
+	read_unlock(&uprobes_treelock);
 
 	return !!n;
 }
-- 
2.43.0


