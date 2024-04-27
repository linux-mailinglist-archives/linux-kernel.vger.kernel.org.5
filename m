Return-Path: <linux-kernel+bounces-160918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896B8B4487
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C41C1C224F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2314086F;
	Sat, 27 Apr 2024 06:28:04 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB440855
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714199284; cv=none; b=Aj9Gzgyqy/kVoOhLQEVxsIhfJcpljiOdlR5tbw+OY4L4BNuI1qTInp+ACMqkxxDp22tO/UW1dcxo7GuMCe/qIJjzumL5iyLX8FLBcKg2iwtC1lQVyqmu9mFP9NsZ2KymJv5GLG21YuCE17anD3Gl1vVjAS4Wr3OMYfad4kq3JNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714199284; c=relaxed/simple;
	bh=74zgsD+K4hbxZJfPiMlMmjIhlv6PEV2ZQUe9KNJk/MM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JWreOgsQcXzvIiGJJc9SeJ5vMLNFy71QL2ukD8TSn3lqJcoI2MMTzFady+haTNVSfYfhxuTYCErsSY/fBmsy4zIkDn/bezV0IRB5NtnloemASsd0sx/bWQYL9jQb+qDnyYdTVzc6S8mfjBcNl8mg15nRS1GAeY1EguMTQT03X1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43R6RwIU096705;
	Sat, 27 Apr 2024 15:27:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sat, 27 Apr 2024 15:27:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43R6RwO9096702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Apr 2024 15:27:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0be742a5-bfe5-489b-8ceb-efd99306bdcd@I-love.SAKURA.ne.jp>
Date: Sat, 27 Apr 2024 15:27:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH ORPHANED] profiling: Remove create_prof_cpu_mask().
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

create_prof_cpu_mask() is no longer used after commit 1f44a225777e ("s390:
convert interrupt handling to use generic hardirq").

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since nobody can respond, sending to Linus, as per "THE REST" rule
in MAINTAINERS file.

 include/linux/profile.h |  5 -----
 kernel/profile.c        | 43 -----------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/include/linux/profile.h b/include/linux/profile.h
index 11db1ec516e2..04ae5ebcb637 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -18,13 +18,8 @@ struct proc_dir_entry;
 struct notifier_block;
 
 #if defined(CONFIG_PROFILING) && defined(CONFIG_PROC_FS)
-void create_prof_cpu_mask(void);
 int create_proc_profile(void);
 #else
-static inline void create_prof_cpu_mask(void)
-{
-}
-
 static inline int create_proc_profile(void)
 {
 	return 0;
diff --git a/kernel/profile.c b/kernel/profile.c
index 7575747e2ac6..1a6c1cf98485 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -342,49 +342,6 @@ void profile_tick(int type)
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
-static int prof_cpu_mask_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%*pb\n", cpumask_pr_args(prof_cpu_mask));
-	return 0;
-}
-
-static int prof_cpu_mask_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prof_cpu_mask_proc_show, NULL);
-}
-
-static ssize_t prof_cpu_mask_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
-{
-	cpumask_var_t new_value;
-	int err;
-
-	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
-		return -ENOMEM;
-
-	err = cpumask_parse_user(buffer, count, new_value);
-	if (!err) {
-		cpumask_copy(prof_cpu_mask, new_value);
-		err = count;
-	}
-	free_cpumask_var(new_value);
-	return err;
-}
-
-static const struct proc_ops prof_cpu_mask_proc_ops = {
-	.proc_open	= prof_cpu_mask_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	.proc_write	= prof_cpu_mask_proc_write,
-};
-
-void create_prof_cpu_mask(void)
-{
-	/* create /proc/irq/prof_cpu_mask */
-	proc_create("irq/prof_cpu_mask", 0600, NULL, &prof_cpu_mask_proc_ops);
-}
-
 /*
  * This function accesses profiling information. The returned data is
  * binary: the sampling step and the actual contents of the profile
-- 
2.18.4


