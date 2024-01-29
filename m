Return-Path: <linux-kernel+bounces-42206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D8383FDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E801F220BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043714CB55;
	Mon, 29 Jan 2024 05:53:33 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73D4CB3D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507611; cv=none; b=gL2HppnpWgJ6bEoBg1F2JH6lJYsQMQaHvVZ1ocNpx8X5XRejnh0TaSwEx3fdkQCj7u3MwV4PF+OSJZEA9Nw52yBifbP4TAZnFsO8R5xWziltUyH9BEgCn5eBMqDSgTsOEmjnfOVqs7/qzJKWxXvxLA4ywwfO65/g1hogyes0mpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507611; c=relaxed/simple;
	bh=Zq8dje60apkizNP7D8NSgOhKVDsGAskUrrmUMmRVzjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g98FdWnqFydpyHldFp+cD516vk2YakiG6CkZIc/J4caZIDGYyWGBkFwdVSEX9THhYtTkmw2KB08B6DhPeSRb+3BAFJpG7+FiDnnYaOnhzEq7XTtFG+0ufJFnWSvTQIi80hOPd3Nk3tGFKnr66PHmCo0DCDzvDUfWTF43S6B0VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40T5rR3I094104;
	Mon, 29 Jan 2024 14:53:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 29 Jan 2024 14:53:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40T5rMZw094055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Jan 2024 14:53:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4c59b146-df67-48d8-9378-3948dd6fb427@I-love.SAKURA.ne.jp>
Date: Mon, 29 Jan 2024 14:53:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: eadavis@qq.com, Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com>
 <20240129044824.1218-1-hdanton@sina.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240129044824.1218-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/29 13:48, Hillf Danton wrote:
>> 3 locks held by kworker/1:2/779:
>>  #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
>>  #1: ffffc900038c7d80 ((work_completion)(&aux->work)#2){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>>  #2: ffff888052984c80 (&aux->poke_mutex){+.+.}-{3:3}, at: __fd_array_map_delete_elem+0x125/0x2f0 kernel/bpf/arraymap.c:884
> 
> Could locking people shed any light on the failure of detecting the
> poke_mutex with rq lock held?
> 

Showing held locks (lockdep_print_held_locks()) is not a snapshot.
Synchronous printk() can make #0 already released by the moment #2 is taken.

Please consult printk() people for possibility of making printk() from
lockdep reports (and/or hung task reports) asynchronous.


