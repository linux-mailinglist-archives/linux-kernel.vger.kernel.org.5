Return-Path: <linux-kernel+bounces-79572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90169862456
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E6284790
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CF241E0;
	Sat, 24 Feb 2024 10:47:44 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F2260B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708771664; cv=none; b=h7j7+iTuRPPqbFlfK2mkfLXfLRJf4IJWgN01/IOyZi5tKXzDJK2MDq+IGcBftAsqmF62PDJwpAKEbr+XOS4x9GMLLVYMlLDkr7EcHp9Nkw7vwO+Efg//qEBKtuQDx78A+kJGNCwoFJRKnlRWWFywObiVfwYs77DOFSta+sg48xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708771664; c=relaxed/simple;
	bh=dvEbx0Z33d2jDzKx3kAWpiJpk8zWg6aIgMEPDWz0db0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KM7lfqJLNtLrBDoQQYpVs7AWyXSv6mSz0ReobGFc7t5YKmX/UD51ybMOQWUo9l2Y0OdlN6qWEr6zNa4UygzCKDH4pVXlYWV/pH8Rh08QaYZtt59MxSL2K6EMKgRvWjCZQ2u6dfOt3Z9o+DOmqZ3nlhyggk/CgUNRmjpwpWyZ1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41OAlZib055623;
	Sat, 24 Feb 2024 19:47:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sat, 24 Feb 2024 19:47:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41OAlZ0D055620
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 24 Feb 2024 19:47:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e34d2e40-de98-4736-bae9-7271fe9cf242@I-love.SAKURA.ne.jp>
Date: Sat, 24 Feb 2024 19:47:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc: linux-kernel@vger.kernel.org
References: <000000000000fd588e060de27ef4@google.com>
 <be634ab4-58aa-40e4-8ab0-0e2685537525@I-love.SAKURA.ne.jp>
In-Reply-To: <be634ab4-58aa-40e4-8ab0-0e2685537525@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..f13bba3a9dab 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -58,7 +58,16 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+#ifdef CONFIG_KMSAN
+/* Use of non-instrumented assembly version confuses KMSAN. */
+void *memcpy(void *to, const void *from, __kernel_size_t len);
+static inline void copy_page(void *to, void *from)
+{
+	memcpy(to, from, PAGE_SIZE);
+}
+#else
 void copy_page(void *to, void *from);
+#endif
 
 #ifdef CONFIG_X86_5LEVEL
 /*
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5caa1f566553..48277029c282 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -592,22 +592,27 @@ static inline struct stack_record *find_stack(struct list_head *bucket,
 
 		/*
 		 * This may race with depot_free_stack() accessing the freelist
-		 * management state unioned with @entries. The refcount is zero
-		 * in that case and the below refcount_inc_not_zero() will fail.
+		 * management state unioned with @entries.
 		 */
 		if (data_race(stackdepot_memcmp(entries, stack->entries, size)))
 			continue;
 
 		/*
-		 * Try to increment refcount. If this succeeds, the stack record
-		 * is valid and has not yet been freed.
+		 * Check if an invalid record had the same {hash, size, entries}
+		 * by testing whether the refcount is already 0.
+		 * Also, try to increment refcount if STACK_DEPOT_FLAG_GET is used.
 		 *
 		 * If STACK_DEPOT_FLAG_GET is not used, it is undefined behavior
 		 * to then call stack_depot_put() later, and we can assume that
 		 * a stack record is never placed back on the freelist.
 		 */
-		if ((flags & STACK_DEPOT_FLAG_GET) && !refcount_inc_not_zero(&stack->count))
-			continue;
+		if (flags & STACK_DEPOT_FLAG_GET) {
+			if (!refcount_inc_not_zero(&stack->count))
+				continue;
+		} else {
+			if (!refcount_read(&stack->count))
+				continue;
+		}
 
 		ret = stack;
 		break;



