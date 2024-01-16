Return-Path: <linux-kernel+bounces-28242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3582FC12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31F428DDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC3321A09;
	Tue, 16 Jan 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Ih7FRr"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0CC21A0C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436542; cv=none; b=D+tnjr18YcQtDx0QCtLTr8hBOeSDUkvqLNQfdsCKQ+UTotAz3BclJ/Zj+J9cwsT7MF8BEE73Or22dvcKqpv+K9cToZ18zPw5WeIkzyYhF9ZRz8H5mT3zLLs3maJN4lgv+AQLicxfE2SXAJaFfiAXU+P7hgdxScrq9TA7pU68enY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436542; c=relaxed/simple;
	bh=PDlCMkySKSqlMrUAKkLEPXEa+/c9FL0n20oIgi/0208=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwnOYr5+3vqOKk/CutMo7uZV8/gT4eGZTxIhXzJA4wHjUG5MHGZqkSnxk8sdCzsoCJJ/d6EGT++WKbbqGa1zTPRHdF0D0aPxHns/OvLcYul6MGqoLEqJraqALxZkl/MxtF4N5/NwfR9BSs7Hs7AcO7MwUTfpqNzv2y48mx0OJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4Ih7FRr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3aa0321b5so83555055ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705436540; x=1706041340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDts5Pg1XuReiTUxMdh2QMyR26X8UbRMvyurONetzxM=;
        b=e4Ih7FRr07PC4pUf/z0shWwPHsTrlADm7Qbu7KMko4cvHhcvgWNPrnE6K6mJgjMzN2
         7utGyLd7DK5/Mq+l8E5CarV2bXB5eUW+oRACy/hsbSOrG5f1J7LVLTjTzJnLvMt1svMu
         8BHjf1F5q1C27ObO8Dgjqu5lBskW8pvxZHEOaWHVOn7ByKIupd0jRwV4bngvOo8wW3pj
         60mwrJw5tT4i9RzcgT0VuAQ5DDsF0r4wfUVwvrI9bZMbWpFK5JB3A8ePqxMfZSdsDCir
         FR8fQBnvlQNouN6bKKS6DDXd5MSimQudk46F6Y+BHfDzXdB0uCT14DO10aFV6aMMAIRK
         kbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705436540; x=1706041340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDts5Pg1XuReiTUxMdh2QMyR26X8UbRMvyurONetzxM=;
        b=Hs3t8jtLaYlHSylgCu4mCMR0uyQs0KD9Unkq2mJz3/cT8ldEGtkfF51i5PN2kegBTG
         cFac/8zDyFFHkuTKhwkbpMx+QnL295Hgzrv/eQAgJ+VTDKvE/9F2AjF8RaBYQNdRAqHk
         NhuBWux6Ni5YuCkhNp9CQnC5y7w/vjuhcjs6GdHDgettBiFLBumtOqMXeIGsPcCM+dd6
         X/6p8RCYaF4U88vxl01vzul4d10TDuCoe3cATNwWVnFDJCKOKMLdoCSraHhFC44lrSaX
         5BxBnJIK0XEIdqrEYGSA9PBUPb7+zHr7XTx465OZfrkNGimBc3grKSDSO4KneSA1K9PC
         /VuA==
X-Gm-Message-State: AOJu0YzG6k+5YHM2Gh/DMT20DvTlH5mamxT67EG9/O9jHtAKGEyvS8lP
	kUiK/mAKJ3a99ZgTz0bkQ6M=
X-Google-Smtp-Source: AGHT+IGzNXoAAKOQfId8nt+KdKiU+yd4cXQIR6hCVmNbJQO1RlGaDkjoJQmAyHPL+77DdSaQbMu5iw==
X-Received: by 2002:a17:903:24d:b0:1d5:4e03:4732 with SMTP id j13-20020a170903024d00b001d54e034732mr8864176plh.4.1705436540553;
        Tue, 16 Jan 2024 12:22:20 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id bb7-20020a170902bc8700b001d4e765f5efsm9589301plb.110.2024.01.16.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:22:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jan 2024 10:22:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: longman@redhat.com, jiangshanlai@gmail.com, ke.wang@unisoc.com,
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Add rcu lock check after work execute end
Message-ID: <ZablegoZ25QAHRTU@slm.duckdns.org>
References: <9bed61e4-7c08-4c61-a7e4-bdd39335cec1@redhat.com>
 <20240110032724.3339-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110032724.3339-1-xuewen.yan@unisoc.com>

Hello,

I massaged the description for clarity and applied to wq/for-6.9.

Thanks.

From 1a65a6d17cbc58e1aeffb2be962acce49efbef9c Mon Sep 17 00:00:00 2001
From: Xuewen Yan <xuewen.yan@unisoc.com>
Date: Wed, 10 Jan 2024 11:27:24 +0800
Subject: [PATCH] workqueue: Add rcu lock check at the end of work item
 execution

Currently the workqueue just checks the atomic and locking states after work
execution ends. However, sometimes, a work item may not unlock rcu after
acquiring rcu_read_lock(). And as a result, it would cause rcu stall, but
the rcu stall warning can not dump the work func, because the work has
finished.

In order to quickly discover those works that do not call rcu_read_unlock()
after rcu_read_lock(), add the rcu lock check.

Use rcu_preempt_depth() to check the work's rcu status. Normally, this value
is 0. If this value is bigger than 0, it means the work are still holding
rcu lock. If so, print err info and the work func.

tj: Reworded the description for clarity. Minor formatting tweak.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ed442cefea7c..aec3efbaaf93 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2640,11 +2640,12 @@ __acquires(&pool->lock)
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
-	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
-		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
+	if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
+		     rcu_preempt_depth() > 0)) {
+		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
 		       "     last function: %ps\n",
-		       current->comm, preempt_count(), task_pid_nr(current),
-		       worker->current_func);
+		       current->comm, preempt_count(), rcu_preempt_depth(),
+		       task_pid_nr(current), worker->current_func);
 		debug_show_held_locks(current);
 		dump_stack();
 	}
-- 
2.43.0


