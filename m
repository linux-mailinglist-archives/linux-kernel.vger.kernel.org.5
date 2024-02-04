Return-Path: <linux-kernel+bounces-51906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EE1849098
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09341F21582
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4528DB7;
	Sun,  4 Feb 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7XWj9Sn"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B62556E;
	Sun,  4 Feb 2024 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081265; cv=none; b=lIHGUn8UGzQrjY8BYEJteHh6jN73w5dJVq+Z3HmCXQfUfOdCtt/47UjcjXrcqgMJEShUxyi/AOQ6LPWdZnf6iGkBsxjNVZj8p4NsW9SUWZX93lheCB5VY8t68TgTQ0BCdKCskH55LAMU4o8eYk/69gx4aTfR2Chfqa384+WT78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081265; c=relaxed/simple;
	bh=nDRSwWjiurLq688508mdp6fBlHDdaVsyZGnjnjY3Hxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVe5tbFcmarXGOxspCmJW9sFXdxhdaPlXx6zNqg72ipJseXpIPYdchY9kkdI1VpTB2eFpnDAPMZ+QoDKB0SaaZTdTkhJG9JqEh3Vt7Zm27bKHEWjMF6z1G26bZPVHDRK8U3yJI/jL8Mf1P08HTYLBZbUOAtDIAMLhPHejMVjCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7XWj9Sn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2929810a12.3;
        Sun, 04 Feb 2024 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707081263; x=1707686063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlMROPYiqbdd9NKGh0wea7FTnlpIWxLsmTfTz5ljzLU=;
        b=f7XWj9Snk+ebfcKGLOa8zpLP5YhHbxvtzhzdfmdg6R24fZRY7Z5UV0Nl1cnNMOLXMJ
         zBIfQ8goyWeuNP6iG5k9lDG8hzsL/79cflSL/XYDcpCj85V9MrI7/nxokT4BmSMLf1QZ
         NnWO6Bvha8l50yHS8uTmI6MrRRNOZzkWkmw+HSKdwFp8zpLNHVmSzsYXrYnQCKcxC5eE
         h/viwqozX3gR2iePKedYg5+cyGJpBY93lqtW5V5t6ciSCE4VhViTMwIqpO6OllCqACyw
         cTT2CXdaZAJl/XqhX26u68hYlM+vCsOvNapqkZAiHqMe5cQpc6CbpzjMetE3XXnIsCeX
         Qesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707081263; x=1707686063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlMROPYiqbdd9NKGh0wea7FTnlpIWxLsmTfTz5ljzLU=;
        b=i8+V+DOqYs7pGAmci128pcbIwsbnu/bDprxAonH9qEGtEC0BBmojJ+8qCnYLlWHH0L
         jr6nfeSC3vKKVO6LEI4a4/R4iWW1yA1EiW8YWnagxdTArNki/4cJdklMcXxypXdJ1Tq/
         w9gRB9Yl4wjXSHiRlmKDVxn8GsXKt1zccsWaYYfr1KCP8Ss2vP5ksM6ZtmJo5qj3kwFt
         kyVabJ3WjIVgXzP9Bd38vs81v8gs+TWymxyUqlfPAKf9hqaYa6Evm/KYNO9CncfADolO
         AYjv5uO/Ri07xRwEYLunDrdtxcV0fMEMrxr/O6f85Qh/n32W7deUyHJ6ZmZ9G32nBe+w
         I4vA==
X-Gm-Message-State: AOJu0YxrKGgk7nXxUNeLUawhIgaO5Tg1du+3Yy7q+3LrZmrk57vVtWxS
	hq6M4bycqPIWz0SOQFIvmBIH8lahAtv42qkbA1YExCId1ukJnrG3
X-Google-Smtp-Source: AGHT+IG2BiiMuOaru9edA5rfTEoLyjyj5BDSQaHcthhmWHn9iqWL+gTeP64hpl1M1CQC55u7m0vQiQ==
X-Received: by 2002:a17:902:654b:b0:1d9:40f3:ada8 with SMTP id d11-20020a170902654b00b001d940f3ada8mr9317476pln.3.1707081262605;
        Sun, 04 Feb 2024 13:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXok8bKHNe5PByrhpn7cw7isMSves1hUfeCvwMRKswiYRlOL/8s1SNdKhPZGPbnjEm37nBLrUOixbDnrAA7wD73NyW769TDo2XN8eFWPG6/SEBHR/J62ugjht2s5HYLOi17f0VTnZBWzgdYOXR2E5YwQvLBKLcVGspv
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm4867600pls.206.2024.02.04.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:14:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Feb 2024 11:14:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH wq/for-6.9] workqueue: Fix pwq->nr_in_flight corruption in
 try_to_grab_pending()
Message-ID: <Zb_-LQLY7eRuakfe@slm.duckdns.org>
References: <87o7cxeehy.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7cxeehy.fsf@debian-BULLSEYE-live-builder-AMD64>

dd6c3c544126 ("workqueue: Move pwq_dec_nr_in_flight() to the end of work
item handling") relocated pwq_dec_nr_in_flight() after
set_work_pool_and_keep_pending(). However, the latter destroys information
contained in work->data that's needed by pwq_dec_nr_in_flight() including
the flush color. With flush color destroyed, flush_workqueue() can stall
easily when mixed with cancel_work*() usages.

This is easily triggered by running xfstests generic/001 test on xfs:

     INFO: task umount:6305 blocked for more than 122 seconds.
     ...
     task:umount          state:D stack:13008 pid:6305  tgid:6305  ppid:6301   flags:0x00004000
     Call Trace:
      <TASK>
      __schedule+0x2f6/0xa20
      schedule+0x36/0xb0
      schedule_timeout+0x20b/0x280
      wait_for_completion+0x8a/0x140
      __flush_workqueue+0x11a/0x3b0
      xfs_inodegc_flush+0x24/0xf0
      xfs_unmountfs+0x14/0x180
      xfs_fs_put_super+0x3d/0x90
      generic_shutdown_super+0x7c/0x160
      kill_block_super+0x1b/0x40
      xfs_kill_sb+0x12/0x30
      deactivate_locked_super+0x35/0x90
      deactivate_super+0x42/0x50
      cleanup_mnt+0x109/0x170
      __cleanup_mnt+0x12/0x20
      task_work_run+0x60/0x90
      syscall_exit_to_user_mode+0x146/0x150
      do_syscall_64+0x5d/0x110
      entry_SYSCALL_64_after_hwframe+0x6c/0x74

Fix it by stashing work_data before calling set_work_pool_and_keep_pending()
and using the stashed value for pwq_dec_nr_in_flight().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Link: http://lkml.kernel.org/r/87o7cxeehy.fsf@debian-BULLSEYE-live-builder-AMD64
Fixes: dd6c3c544126 ("workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling")
---
Hello, Chandan.

Thanks a lot for the report. I could reproduce the problem and verified that
this patch fixes the issue. I'm applying this to wq/for-6.9 but would really
appreciate if you could confirm the fix.

Thanks.

 kernel/workqueue.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ffb625db9771..55c9816506b0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1999,6 +1999,8 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	 */
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
+		unsigned long work_data;
+
 		debug_work_deactivate(work);
 
 		/*
@@ -2016,11 +2018,15 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 
 		list_del_init(&work->entry);
 
-		/* work->data points to pwq iff queued, point to pool */
+		/*
+		 * work->data points to pwq iff queued. Let's point to pool. As
+		 * this destroys work->data needed by the next step, stash it.
+		 */
+		work_data = *work_data_bits(work);
 		set_work_pool_and_keep_pending(work, pool->id);
 
 		/* must be the last step, see the function comment */
-		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
+		pwq_dec_nr_in_flight(pwq, work_data);
 
 		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();


