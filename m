Return-Path: <linux-kernel+bounces-52522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A684993E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1481F21594
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E81946B;
	Mon,  5 Feb 2024 11:52:47 +0000 (UTC)
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F218EB2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133966; cv=none; b=eqP/ooutg7ky25lFh/9McCsOHbAOyRDEpaXgCNQJdvumVfM67d+OCET/zrKen6RzEiGshHv11TFgppnfzpVtzPk9T9pvWwCfjxdroxqid6KUYCksjjH+OBvGj5BVBTTlNAUCz9QxD1bbsYGzHOF9bXMAemekUBiXX/uxqTzPGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133966; c=relaxed/simple;
	bh=5BvnaK+Q3e30bHwbnZ/Zuza3SgyqFfcHiBGD0cfTfMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRfPy+StFX8L96KhD6NmQJZwnF+seZZ76Lkl1Qo6FCkDJAIbSAUB4+xW+CDrMbpuu0GNBiC2hYOhx+hTZnJuj5hBilLI6Vvcwq1kvi9bMnR1RrETX8GONmPliT/PEJfOAi4ROkoCoG9/sjF0DWhH+KwMMbENfXbzurKFzrLSteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WNt.Hm5_1707133638;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WNt.Hm5_1707133638)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 19:47:19 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 3/6] um: Remove unused functions
Date: Mon, 05 Feb 2024 19:47:05 +0800
Message-Id: <20240205114708.25235-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205114708.25235-1-tiwei.btw@antgroup.com>
References: <20240205114708.25235-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These functions are not used anymore. Removing them will also address
below -Wmissing-prototypes warnings:

arch/um/kernel/process.c:51:5: warning: no previous prototype for ‘pid_to_processor_id’ [-Wmissing-prototypes]
arch/um/kernel/process.c:253:5: warning: no previous prototype for ‘copy_to_user_proc’ [-Wmissing-prototypes]
arch/um/kernel/process.c:263:5: warning: no previous prototype for ‘clear_user_proc’ [-Wmissing-prototypes]
arch/um/kernel/tlb.c:579:6: warning: no previous prototype for ‘flush_tlb_mm_range’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 21 ---------------------
 arch/um/kernel/tlb.c     |  6 ------
 2 files changed, 27 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 20f3813143d8..292c8014aaa6 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -48,17 +48,6 @@ static inline int external_pid(void)
 	return userspace_pid[0];
 }
 
-int pid_to_processor_id(int pid)
-{
-	int i;
-
-	for (i = 0; i < ncpus; i++) {
-		if (cpu_tasks[i].pid == pid)
-			return i;
-	}
-	return -1;
-}
-
 void free_stack(unsigned long stack, int order)
 {
 	free_pages(stack, order);
@@ -250,21 +239,11 @@ char *uml_strdup(const char *string)
 }
 EXPORT_SYMBOL(uml_strdup);
 
-int copy_to_user_proc(void __user *to, void *from, int size)
-{
-	return copy_to_user(to, from, size);
-}
-
 int copy_from_user_proc(void *to, void __user *from, int size)
 {
 	return copy_from_user(to, from, size);
 }
 
-int clear_user_proc(void __user *buf, int size)
-{
-	return clear_user(buf, size);
-}
-
 static atomic_t using_sysemu = ATOMIC_INIT(0);
 int sysemu_supported;
 
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 7d050ab0f78a..70b5e47e9761 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -576,12 +576,6 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
-void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
-{
-	fix_range(mm, start, end, 0);
-}
-
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-- 
2.34.1


