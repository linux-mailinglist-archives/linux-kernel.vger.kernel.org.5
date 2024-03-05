Return-Path: <linux-kernel+bounces-92484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC16872111
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5151F219D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830018613B;
	Tue,  5 Mar 2024 14:05:25 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892C5676A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647525; cv=none; b=ngm9D8C1NPzs9PliPEuArZ70sKtYKxeodnRrFNKl6+erwJtjbz6wvd6EjYB+jNbC0nwjmp1Vv4ZkDTieJBoqm2HAY2+oT+ysQwCJ/JBE7RDlCQeK8vMoqAKDO5h6+6wdAyhkQ7Kw5pgJHUByUxcBKzhYH8mwNHYzAOUslP2VzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647525; c=relaxed/simple;
	bh=selOP6Eh1dbyuzKrL0+1OBzxGL/v1u/kfeUne/J67qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tU8UDTsO4fLmpXtgjNN/CeC0jDCwEkNSnd7u0EliKNrnM6P5erXTI5VWpvGFAKaTPb2Z4tTz9K6Xqbdj4bAf+xH25WVdkVFj0pFYdJg3BfiUZn84qnYXFTw0ZuwWXTrlXs8xaLbulCo+M/Ptn7fR0A1gvtOeAojiMO6cjFtGm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 425E5GrL038688;
	Tue, 5 Mar 2024 23:05:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 05 Mar 2024 23:05:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 425E5GOm038685
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 Mar 2024 23:05:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2963e725-588c-4390-9bc1-525414bb101c@I-love.SAKURA.ne.jp>
Date: Tue, 5 Mar 2024 23:05:16 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Content-Language: en-US
To: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e40a2906072e9567@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000e40a2906072e9567@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..237bcab72004 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -48,6 +48,7 @@
 #include <linux/mutex_api.h>
 #include <linux/plist.h>
 #include <linux/poll.h>
+#include <linux/printk.h>
 #include <linux/proc_fs.h>
 #include <linux/profile.h>
 #include <linux/psi.h>
@@ -1680,6 +1681,7 @@ static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
+	printk_deferred_enter();
 	raw_spin_rq_lock_irqsave(rq, rf->flags);
 	rq_pin_lock(rq, rf);
 }
@@ -1688,6 +1690,7 @@ static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
+	printk_deferred_enter();
 	raw_spin_rq_lock_irq(rq);
 	rq_pin_lock(rq, rf);
 }
@@ -1696,6 +1699,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
+	printk_deferred_enter();
 	raw_spin_rq_lock(rq);
 	rq_pin_lock(rq, rf);
 }
@@ -1706,6 +1710,7 @@ rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock_irqrestore(rq, rf->flags);
+	printk_deferred_exit();
 }
 
 static inline void
@@ -1714,6 +1719,7 @@ rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock_irq(rq);
+	printk_deferred_exit();
 }
 
 static inline void
@@ -1722,6 +1728,7 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
+	printk_deferred_exit();
 }
 
 DEFINE_LOCK_GUARD_1(rq_lock, struct rq,


