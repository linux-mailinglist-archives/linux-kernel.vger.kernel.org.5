Return-Path: <linux-kernel+bounces-109789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3368855BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0721F21CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D9F512;
	Thu, 21 Mar 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuEpXaT+"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE10C2E3;
	Thu, 21 Mar 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009943; cv=none; b=r/GLxQe2MYMzlL2V3EN/t+QB8f54h3feG7g+W1z/9iIfNjrPR1ezSSjPGUiUBL7nqFaEu8RY7eTmjiqHy18vCUygVN2v7IZMqyKdaniA0AudpRZqpjVg4XWOxsx/gT22xKv+2mjZI+nLDye5t7Y+mXBBkBiFKt6/4xJsUVpFgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009943; c=relaxed/simple;
	bh=/75sLSq3ymADFv5voMxvOExCCsdXQVH4ejT3gnAQAT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+6KqrAZ2Ztd9ZSc8T/cDZRedZu7S3ojZiEiZU/MHpMT+o1oCXCeqmV3AIabQf73vRXW1IFDMk097DM49yf10a8gy3rkIV8iVwGxCTNc0CtyR/Fm7Krp/1uThzP2TtYzy/NAu6eaE9S6Ok1A6SBnULrK8kGaf2YEXsj9sjJbjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuEpXaT+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e8f765146fso634867b3a.0;
        Thu, 21 Mar 2024 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711009941; x=1711614741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tU1MSjZ1WPm6ZTqLXV+eSRd2GPu6O3eDIXnpJtIk7Sc=;
        b=KuEpXaT+C+ngZPp10Et+/GZC9W4P0KQdcBKP04f4qlrUW1srypvOTMMhtt1FzTKPCJ
         lXPdnab5l/FugFsh9PDG56Q0DNdfuqtDlfEFvGMWlR1qJAOzdbPsWPUnguKJkppu5Y1T
         QZHWCHtxpDIjeUUD92T06sIi7dlHmBasR2BHvlEZmhO1rToYlAP/nS/bdRTfg7juHwER
         XjFNZ8ViH86U6MRfI97m4Z8xBO/Xnht5VajyC8o/9utN+3du7/NPfnwxaXcPSV0/VV8f
         KfyWSHFr8q1o7IslE8iJX2j6ucLogdfH0kWTSnDAFKFL1km/BCXgiAPeACLZRqxsB66U
         wtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009941; x=1711614741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU1MSjZ1WPm6ZTqLXV+eSRd2GPu6O3eDIXnpJtIk7Sc=;
        b=YhNd02txaG5oxpPthIDxvAZNKYuUlzuEB1LI+dPea05U/keF9IIR/KELmKXXNIHH9L
         GlEUS3bq7DUnAZX6UlEvhB4u9fN976nP/quynqcRQwRTA1lrsP3ecKI5YHFnK8XCJa9c
         qiavU6tzISyuaLru3eXX/Sec4KC5ph7CgP2yxf677k+irZWj4GgapBsBV1Y6BaRk7qXY
         7R/r6l/Fn13AFpuTYfzJz/yeOwmjmDGQHMZ3NzeuhD9vGhTtyp6ldj0j7bFYf0V8LQeg
         C2VJsuPd7OIbLvHWZ6B6l+7J3NOM2ihBE5/qXlrs2shoG2mzmcHpUQIeAb9pKJITt+gI
         h84w==
X-Forwarded-Encrypted: i=1; AJvYcCW1/HHqBUHPMbUD72eDHGXsBYJ1I2JOKCG9eI19RT017pzKG5Glekx9WXFM7+blY9LYcK2UDEyMOmuhaPh+X5qS4eGpNV3KYN+MX2fD
X-Gm-Message-State: AOJu0YzDIvMEJ5M5nchTfCPa31P1Xm1jHTB6K9zDcQSnHzhz90mwgK3/
	wRamua6XrtFGJTKSsA5xt2H7N3Lpk4ulyLA6h6W1BddhTnQ29+c0pOQtSkkKrY/KAbOsIAbZoPa
	wgX3qwjznDPyhE2Ho8qPHN9ci2Sr1dSyG5bc=
X-Google-Smtp-Source: AGHT+IF9930JVjpWoordCj7OCpvansCCSj8YlReuSEroY+AIc6H4qyyEUoDq1Yh+uEM1N+Ajff/6s1tKs9mwAeXg4TI=
X-Received: by 2002:a17:90a:d18e:b0:29c:289b:1eb3 with SMTP id
 fu14-20020a17090ad18e00b0029c289b1eb3mr18801041pjb.6.1711009940902; Thu, 21
 Mar 2024 01:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321082850.1756-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20240321082850.1756-1-qiang.zhang1211@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 21 Mar 2024 16:32:09 +0800
Message-ID: <CALm+0cXceF+-FR2oDu9YWrKrtRjwyomH7_rk=XdUJxQJFj4gaw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Make stall-tasks directly exit when
 rcutorture tests end
To: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> When the rcutorture tests start to exit, the rcu_torture_cleanup() is
> invoked to stop kthreads and release resources, if the stall-task
> kthreads exist, cpu-stall has started and the rcutorture.stall_cpu
> is set to a larger value, the rcu_torture_cleanup() will be blocked
> for a long time and the hung-task may occur, this commit therefore
> add kthread_should_stop() to the loop of cpu-stall operation, when
> rcutorture tests ends, no need to wait for cpu-stall to end, exit
> directly.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---


Use the following command to test:

insmod rcutorture.ko torture_type=srcu fwd_progress=0 stat_interval=4
stall_cpu_block=1 stall_cpu=200 stall_cpu_holdoff=10 read_exit_burst=0
object_debug=1
rmmod rcutorture

[15361.918610] INFO: task rmmod:878 blocked for more than 122 seconds.
[15361.918613]       Tainted: G        W
6.8.0-rc2-yoctodev-standard+ #25
[15361.918615] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[15361.918616] task:rmmod           state:D stack:0     pid:878
tgid:878   ppid:773    flags:0x00004002
[15361.918621] Call Trace:
[15361.918623]  <TASK>
[15361.918626]  __schedule+0xc0d/0x28f0
[15361.918631]  ? __pfx___schedule+0x10/0x10
[15361.918635]  ? rcu_is_watching+0x19/0xb0
[15361.918638]  ? schedule+0x1f6/0x290
[15361.918642]  ? __pfx_lock_release+0x10/0x10
[15361.918645]  ? schedule+0xc9/0x290
[15361.918648]  ? schedule+0xc9/0x290
[15361.918653]  ? trace_preempt_off+0x54/0x100
[15361.918657]  ? schedule+0xc9/0x290
[15361.918661]  schedule+0xd0/0x290
[15361.918665]  schedule_timeout+0x56d/0x7d0
[15361.918669]  ? debug_smp_processor_id+0x1b/0x30
[15361.918672]  ? rcu_is_watching+0x19/0xb0
[15361.918676]  ? __pfx_schedule_timeout+0x10/0x10
[15361.918679]  ? debug_smp_processor_id+0x1b/0x30
[15361.918683]  ? rcu_is_watching+0x19/0xb0
[15361.918686]  ? wait_for_completion+0x179/0x4c0
[15361.918690]  ? __pfx_lock_release+0x10/0x10
[15361.918693]  ? __kasan_check_write+0x18/0x20
[15361.918696]  ? wait_for_completion+0x9d/0x4c0
[15361.918700]  ? _raw_spin_unlock_irq+0x36/0x50
[15361.918703]  ? wait_for_completion+0x179/0x4c0
[15361.918707]  ? _raw_spin_unlock_irq+0x36/0x50
[15361.918710]  ? wait_for_completion+0x179/0x4c0
[15361.918714]  ? trace_preempt_on+0x54/0x100
[15361.918718]  ? wait_for_completion+0x179/0x4c0
[15361.918723]  wait_for_completion+0x181/0x4c0
[15361.918728]  ? __pfx_wait_for_completion+0x10/0x10
[15361.918738]  kthread_stop+0x152/0x470
[15361.918742]  _torture_stop_kthread+0x44/0xc0 [torture
7af7f9cbba28271a10503b653f9e05d518fbc8c3]
[15361.918752]  rcu_torture_cleanup+0x2ac/0xe90 [rcutorture
f2cb1f556ee7956270927183c4c2c7749a336529]
[15361.918766]  ? __pfx_rcu_torture_cleanup+0x10/0x10 [rcutorture
f2cb1f556ee7956270927183c4c2c7749a336529]
[15361.918777]  ? __kasan_check_write+0x18/0x20
[15361.918781]  ? __mutex_unlock_slowpath+0x17c/0x670
[15361.918789]  ? __might_fault+0xcd/0x180
[15361.918793]  ? find_module_all+0x104/0x1d0
[15361.918799]  __x64_sys_delete_module+0x2a4/0x3f0
[15361.918803]  ? __pfx___x64_sys_delete_module+0x10/0x10
[15361.918807]  ? syscall_exit_to_user_mode+0x149/0x280

Thanks
Zqiang


>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 3f9c3766f52b..6a3cd6ed8b25 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2490,7 +2490,7 @@ static int rcu_torture_stall(void *args)
>                 pr_alert("%s start on CPU %d.\n",
>                           __func__, raw_smp_processor_id());
>                 while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
> -                                   stop_at))
> +                                   stop_at) && !kthread_should_stop())
>                         if (stall_cpu_block) {
>  #ifdef CONFIG_PREEMPTION
>                                 preempt_schedule();
> --
> 2.17.1
>

