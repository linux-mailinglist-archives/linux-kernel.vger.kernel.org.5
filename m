Return-Path: <linux-kernel+bounces-95001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A88747F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184361F2584D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7D1BF38;
	Thu,  7 Mar 2024 06:20:11 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A4DF55;
	Thu,  7 Mar 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792411; cv=none; b=BZWejaFx5AjoqhJJhNEFCMHmcW+zhQhbigUYnv2cFMR/qF05hciHEwQxEtcboapeWEnQvQCl9c4cqmCgWOU/9TDNkXyBBYk5p0ztkrIxv7wDyjftVPse1Pp01IYbG5i3SUAOztB4pij4RVLAwlc3xZutTo6BZr/ZPDzpcpwJaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792411; c=relaxed/simple;
	bh=j3yWuejBZBKKlxe3rNUKzA09kOU9/6mpjPimlFDFC5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+KWAeasaikzF7H9R74BqSx3ffS26gREnuho6/XwkUwoz0OGJkC8XHXPZfGm6k5+rZvA8DL5g4Sukepwdn3gZZaS5Ca5Sfx9nwAHkn01j9YcLvR/zeHUenQzN4MAEZGOuHxRiqp/V710Jt0jHmj+j2KdimEirG6lp87O+ZdEI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp89t1709792319t5ocxlui
X-QQ-Originating-IP: u3EQS7kP8U3VDMCXVn7nsuBT8nJ4UIZUTBPGzRxAsQc=
Received: from winn-pc ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 14:18:38 +0800 (CST)
X-QQ-SSF: 01400000000000I0I000000A0000000
X-QQ-FEAT: 5q30pvLz2if4oetgJCutpIv/qq/dnVqK4xyUbWJFUwvV8Cf8vAh+aMwKSMdQ4
	teTUb4wiFyu8Rzhn/1BfxkvIMD+o6bLVbyyj71OGDR4gM/ohmZHrc8/LsJuhhlIE9QQPgDh
	U3XIHaKYj5m+yaCBlfSUC9QbaNtTSwHEk+lKGyrh35mAC274FVs27opvAwNadWByaaJnDm+
	Q8OzEPn+HgyokixphNjKC4+rrzlD4CvDIar64tJCnGn6SavsBfZv3iNClpu0z+UrGC6EQub
	C++GEBNX2+uPjKOAArZKJbFNenmN2VBbZwk5whT6qs8JVotkxpQLi03Jst6NVWqBkoG4Gm7
	zSksAHez1GuA4q5ZKBXvjnBGC/zkgyjKJPJExgdd7XFGjpG0GsZYQfWCuSpB4lR9SAeM/RK
	Tsv3JlIRBTQ=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6209662112908991544
Date: Thu, 7 Mar 2024 14:18:37 +0800
From: Winston Wen <wentao@uniontech.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jan Kara <jack@suse.cz>, Peter
 Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ext3 tree
Message-ID: <BB8327439DE51911+20240307141837.3c067e2b@winn-pc>
In-Reply-To: <20240307110717.50b64fe9@canb.auug.org.au>
References: <20240307110717.50b64fe9@canb.auug.org.au>
Organization: Uniontech
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/EEmQMRzKmMSEPIz7proBNED"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1

--MP_/EEmQMRzKmMSEPIz7proBNED
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 7 Mar 2024 11:07:17 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the ext3 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/sysctl.h:27,
>                  from include/linux/fanotify.h:5,
>                  from fs/notify/fanotify/fanotify.c:2:
> fs/notify/fanotify/fanotify.c: In function 'fanotify_get_response':
> fs/notify/fanotify/fanotify.c:233:48: error: suggest parentheses
> around arithmetic in operand of '|' [-Werror=parentheses] 233 |
>                             TASK_KILLABLE|TASK_FREEZABLE); |
>                                       ^ include/linux/wait.h:283:11:
> note: in definition of macro '___wait_is_interruptible' 283 |
>  (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL))) |           ^~~~~
> include/linux/wait.h:935:9: note: in expansion of macro
> '___wait_event' 935 |         ___wait_event(wq, condition, state, 0,
> 0, schedule()) |         ^~~~~~~~~~~~~
> include/linux/wait.h:958:25: note: in expansion of macro
> '__wait_event_state' 958 |                 __ret =
> __wait_event_state(wq_head, condition, state);          \ |
>               ^~~~~~~~~~~~~~~~~~
> fs/notify/fanotify/fanotify.c:231:15: note: in expansion of macro
> 'wait_event_state' 231 |         ret =
> wait_event_state(group->fanotify_data.access_waitq, |
> ^~~~~~~~~~~~~~~~ cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   3440e7e55ced ("fanotify: allow freeze when waiting response for
> permission events")
> 
> Though, I guess, you could argue that the ___wait_is_interruptible
> macro should parenthesise the use of its "state" argument.
> 
> I have used the ext3 tree from next-20240306 for today.
> 

Sorry I missed this warning. And agreed! I can add parentheses on the
call side, but it may be more reasonable to add them in the macro.


Hey Peter,

Could you please take a look at the patch attached at your convenience?
Thanks!

-- 
Thanks,
Winston

--MP_/EEmQMRzKmMSEPIz7proBNED
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-wait-add-parentheses-to-state-argument-in-macro.patch

From 17bdb67492823e90e77f4e3159d631efc4cdd865 Mon Sep 17 00:00:00 2001
From: Winston Wen <wentao@uniontech.com>
Date: Thu, 7 Mar 2024 10:59:59 +0800
Subject: [PATCH 1/2] wait: add parentheses to "state" argument in macro

Now if we use macro wait_event_state() like this:

        wait_event_state(waitq, condition,
                        TASK_KILLABLE|TASK_FREEZABLE);

we'll get a build warning in __wait_is_interruptible because of:

        ((state) & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))

Parenthesise the use of "state" argument to avoid this warning as
it's very common to use "TASK_*|TASK_*" as function parameter in kernel.

Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..a4e57865aded 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -280,7 +280,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 
 #define ___wait_is_interruptible(state)						\
 	(!__builtin_constant_p(state) ||					\
-	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
+	 ((state) & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 
 extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 
-- 
2.43.0


--MP_/EEmQMRzKmMSEPIz7proBNED--


