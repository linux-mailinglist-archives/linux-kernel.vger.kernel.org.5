Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2A7FC23A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjK1Q2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjK1Q2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:28:16 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F075AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:28:22 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35c9cba4fa6so1276215ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701188902; x=1701793702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJcqMaNZ4kGwfkygX0kTi1O0uMXaX1+JuUKO3fztVuk=;
        b=tnoue/verJ6ZqDipsLMxintkXWySJXKov8gH1lv8b0e9pdY1CRR7okCJjPN1t8Nqrc
         HKVpqWKczA+4tEhXmphBBsp2ALkEtc1UgNAHKgzM3b7lVU6ZxcjYuy2RKaWiO2fFPN1s
         Cs3JvwWoh+kIHO9w17DPVymN+9j/ETmx/mcNSUPaqx7lnCMQ6SkRUP+bbiHnti3n+45r
         LHjuJQpdK+wF8D5PhQDhZ7gERONBz2kFq8VsM3POyTBTNNxE9YVqdtfX/F5j/SkGgUIc
         DBkckwX631NXWqXXMb8er+XjG5HwFdrYyFfehbQNycN0ink9M7Sx8gDs4pY39HajqgwX
         9rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701188902; x=1701793702;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJcqMaNZ4kGwfkygX0kTi1O0uMXaX1+JuUKO3fztVuk=;
        b=d0ZkluWI2oU+RJ9is+LzPAhXjpDxgvSafYgwGs033QSC2+mat1Lj4cajE+oVAGp6Qn
         BcLQuPi9WJRcFelQcSGzbr4w02ftK1U7wDZWx/G4He3dzLJlTlfv6Ni51OiXoM8kmvVY
         jPclKSYgeYoh9Y6AkedYFYNZapn9mIflxQPCTYMF91gn/3UNvbSRaS74S72dPNr4zYvb
         +PzZiJIT24rNogtdcKfKRQpJQmpl3R4zoaCnLy3LMMa5aCV4RaDiE6d+ekMUH3Q7XEY8
         o1i2dsgJbyR/tsz6gYC2UZASYYhVmfv7jLwyHPmRwFvkxWDJoVoSfouQVnWdqqhx1Xno
         K7eQ==
X-Gm-Message-State: AOJu0Yx6ANZmBT/xS16m5szoS29OVvX14H+ksDWf3tUzxjocTrRRi6sX
        C75Y50XiSsTLX5KasR9s6BqP+Q==
X-Google-Smtp-Source: AGHT+IHf6yERY3CBW5Hq+QfVKl9Jg+8uqJZOwGkf3VyjkKuaLEQ3dfz6cuwoZBP6rMNe+YyWqTD2Gg==
X-Received: by 2002:a92:dcc8:0:b0:35c:ac42:f9a4 with SMTP id b8-20020a92dcc8000000b0035cac42f9a4mr8314218ilr.1.1701188901696;
        Tue, 28 Nov 2023 08:28:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q6-20020a056e0220e600b0035c9c51e105sm2133589ilv.74.2023.11.28.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 08:28:21 -0800 (PST)
Message-ID: <4824710a-2a14-4541-bdb5-9023568380bf@kernel.dk>
Date:   Tue, 28 Nov 2023 09:28:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: io_uring: risky use of task work, especially wrt fdget()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez1htVSO3TqmrF8QcX2WFuYTRM-VZ_N10i-VZgbtg=NNqw@mail.gmail.com>
 <fadbb6b5-a288-40e2-9bb8-7299ea14f0a7@kernel.dk>
 <af45ad55-c002-4bbd-9226-88439bbd4916@kernel.dk>
In-Reply-To: <af45ad55-c002-4bbd-9226-88439bbd4916@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 9:19 AM, Jens Axboe wrote:
> On 11/28/23 8:58 AM, Jens Axboe wrote:
>> On 11/27/23 2:53 PM, Jann Horn wrote:
>>> Hi!
>>>
>>> I noticed something that I think does not currently cause any
>>> significant security issues, but could be problematic in the future:
>>>
>>> io_uring sometimes processes task work in the middle of syscalls,
>>> including between fdget() and fdput(). My understanding of task work
>>> is that it is expected to run in a context similar to directly at
>>> syscall entry/exit: task context, no locks held, sleeping is okay, and
>>> it doesn't execute in the middle of some syscall that expects private
>>> state of the task_struct to stay the same.
>>>
>>> An example of another user of task work is the keyring subsystem,
>>> which does task_work_add() in keyctl_session_to_parent() to change the
>>> cred pointers of another task.
>>>
>>> Several places in io_uring process task work while holding an fdget()
>>> reference to some file descriptor. For example, the io_uring_enter
>>> syscall handler calls io_iopoll_check() while the io_ring_ctx is only
>>> referenced via fdget(). This means that if there were another kernel
>>> subsystem that uses task work to close file descriptors, io_uring
>>> would become unsafe. And io_uring does _almost_ that itself, I think:
>>> io_queue_worker_create() can be run on a workqueue, and uses task work
>>> to launch a worker thread from the context of a userspace thread; and
>>> this worker thread can then accept commands to close file descriptors.
>>> Except it doesn't accept commands to close io_uring file descriptors.
>>>
>>> A closer miss might be io_sync_cancel(), which holds a reference to
>>> some normal file with fdget()/fdput() while calling into
>>> io_run_task_work_sig(). However, from what I can tell, the only things
>>> that are actually done with this file pointer are pointer comparisons,
>>> so this also shouldn't have significant security impact.
>>>
>>> Would it make sense to use fget()/fput() instead of fdget()/fdput() in
>>> io_sync_cancel(), io_uring_enter and io_uring_register? These
>>> functions probably usually run in multithreaded environments anyway
>>> (thanks to the io_uring worker threads), so I would think fdget()
>>> shouldn't bring significant performance savings here?
>>
>> Let me run some testing on that. It's a mistake to think that it's
>> usually multithreaded, generally if you end up using io-wq then it's not
>> a fast path. A fast networked setup, for example, would never touch the
>> threads and hence no threading would be implied by using io_uring. Ditto
>> on the storage front, if you're just reading/writing or eg doing polled
>> IO. That said, those workloads are generally threaded _anyway_ - not
>> because of io_uring, but because that's how these kinds of workloads are
>> written to begin with.
>>
>> So probably won't be much of a concern to do the swap. The only
>> "interesting" part of the above mix of cancel/register/enter is
>> obviously the enter part. The rest are not really fast path.
> 
> Did all three and ran the usual testing, which just so happens to be
> multithreaded to begin with anyway. No discernable change from using
> fget/fput over fdget/fdput.
> 
> IOW, we may as well do this. Do you want to send a patch? Or I can send
> out mine, up to you.

For reference, this is what I ran my testing with:

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 3c19cccb1aec..8a8b07dfc444 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -273,7 +273,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	};
 	ktime_t timeout = KTIME_MAX;
 	struct io_uring_sync_cancel_reg sc;
-	struct fd f = { };
+	struct file *file = NULL;
 	DEFINE_WAIT(wait);
 	int ret, i;
 
@@ -295,10 +295,10 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	/* we can grab a normal file descriptor upfront */
 	if ((cd.flags & IORING_ASYNC_CANCEL_FD) &&
 	   !(cd.flags & IORING_ASYNC_CANCEL_FD_FIXED)) {
-		f = fdget(sc.fd);
-		if (!f.file)
+		file = fget(sc.fd);
+		if (!file)
 			return -EBADF;
-		cd.file = f.file;
+		cd.file = file;
 	}
 
 	ret = __io_sync_cancel(current->io_uring, &cd, sc.fd);
@@ -348,6 +348,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	if (ret == -ENOENT || ret > 0)
 		ret = 0;
 out:
-	fdput(f);
+	if (file)
+		fput(file);
 	return ret;
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 05f933dddfde..aba5657d287e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3652,7 +3652,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		size_t, argsz)
 {
 	struct io_ring_ctx *ctx;
-	struct fd f;
+	struct file *file;
 	long ret;
 
 	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
@@ -3670,20 +3670,19 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
-		f.file = tctx->registered_rings[fd];
-		f.flags = 0;
-		if (unlikely(!f.file))
+		file = tctx->registered_rings[fd];
+		if (unlikely(!file))
 			return -EBADF;
 	} else {
-		f = fdget(fd);
-		if (unlikely(!f.file))
+		file = fget(fd);
+		if (unlikely(!file))
 			return -EBADF;
 		ret = -EOPNOTSUPP;
-		if (unlikely(!io_is_uring_fops(f.file)))
+		if (unlikely(!io_is_uring_fops(file)))
 			goto out;
 	}
 
-	ctx = f.file->private_data;
+	ctx = file->private_data;
 	ret = -EBADFD;
 	if (unlikely(ctx->flags & IORING_SETUP_R_DISABLED))
 		goto out;
@@ -3777,7 +3776,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		}
 	}
 out:
-	fdput(f);
+	if (!(flags & IORING_ENTER_REGISTERED_RING))
+		fput(file);
 	return ret;
 }
 
@@ -4618,7 +4618,7 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 {
 	struct io_ring_ctx *ctx;
 	long ret = -EBADF;
-	struct fd f;
+	struct file *file;
 	bool use_registered_ring;
 
 	use_registered_ring = !!(opcode & IORING_REGISTER_USE_REGISTERED_RING);
@@ -4637,27 +4637,27 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 		if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
-		f.file = tctx->registered_rings[fd];
-		f.flags = 0;
-		if (unlikely(!f.file))
+		file = tctx->registered_rings[fd];
+		if (unlikely(!file))
 			return -EBADF;
 	} else {
-		f = fdget(fd);
-		if (unlikely(!f.file))
+		file = fget(fd);
+		if (unlikely(!file))
 			return -EBADF;
 		ret = -EOPNOTSUPP;
-		if (!io_is_uring_fops(f.file))
+		if (!io_is_uring_fops(file))
 			goto out_fput;
 	}
 
-	ctx = f.file->private_data;
+	ctx = file->private_data;
 
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_uring_register(ctx, opcode, arg, nr_args);
 	mutex_unlock(&ctx->uring_lock);
 	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs, ret);
 out_fput:
-	fdput(f);
+	if (!use_registered_ring)
+		fput(file);
 	return ret;
 }
 

-- 
Jens Axboe

