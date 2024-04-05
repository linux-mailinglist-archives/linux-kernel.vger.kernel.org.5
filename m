Return-Path: <linux-kernel+bounces-132916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0834899C01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4841F2383F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2BB16C69D;
	Fri,  5 Apr 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9iAWFpX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2233993;
	Fri,  5 Apr 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317148; cv=none; b=k4Kg9hinQPwwi4It1rICh1uHxNHThuA84EjGOsW8VQDEYcLTaTR5DfeP83Aori1qPZYcXp0LMGyfJOzqABnVBzbJs+O45TLciAkxmpDuZdAhDGA6Lg5qc9tZCBv2zzEgtstQxKYmEQvxFxDdUF/BDmmvByDWLOBGytUt3FfDPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317148; c=relaxed/simple;
	bh=pgAWf/UK0ViUl4tlABjZek6EdyuooN2XyOdISvJAJEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQ74jE8wyejeERo0ryJoQS7H3fdp2ui/I8L5NQYplH+cL9lK21s+Qryq/QDQfzHLg4jZePjiu+/Hlv/cOKbsnqakd/+Xt9QP3ixwrgkAh4/q0HVUzO/NDlaKG4xs8FqMo3kvjDdi8WABStMlu6p7Iz1eIS3fQZk4A2MhQvKZFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9iAWFpX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d84a5f4a20so4566411fa.1;
        Fri, 05 Apr 2024 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712317144; x=1712921944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0t6RB1T6H6KDkvTfVfey5J6t4MwPgPr68GDvsqnUf0=;
        b=A9iAWFpXuWEGpMdtGSNXtH0QIjd3LKzccax1rMq0HEariwl4xDpWU0qo4/IzvywYpR
         ipyHvwyLa2ovJ+ZhVZ+yb40aRi33ZdWznU+CpUS590mXus6458T7Xc3GvzSmMxNVO/zk
         NPWV3zIBZEuQLi40NNNLzqhxkyvRuSk+J950z11ItGpOUr/TWG7Xw2Y/668miC6IcLNs
         JV13E/T5IaWdtM+DJxtuSHH5RdnGtKc1JYdSQaoWWCdi0wabZzQLo+XfwbZ3G6yTWbbN
         Z7+eZNP0TRhZZeQ1SyQlmTUv+SSxjx6Lw5zBoLGrVjXJXRh0kDgYrOXIb7FKnZHA2OzT
         SV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317144; x=1712921944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0t6RB1T6H6KDkvTfVfey5J6t4MwPgPr68GDvsqnUf0=;
        b=OvVmS5ZXVY6s1BB1E0Vp+zyFc6j6dc5I390qcj7d7JMpQfEA40iHZRazWaVUSKXuxQ
         u2UKsLAza3Tg2qdq067y7s2q7kvSgibhhVUSN3+SUIkxMIPtK88KgrJAeVhaGHppqMqW
         qKYvu7YrKEpNObGBAtGqoGb/kk2+Vaw1zMeAtv1WbslO+J474oggefZOi0jUzgP7PUHL
         ht/tGtJmiktozSXGLlhA5DFLVw7asao+o8OW3bpyzQkbshbJoPo1PwJK8jdO6LGvsGIf
         Th+3liauMAatQa0jqc7+n/WmZodrNnAztYDDCvK5E03d2sAc8pvVBCbZkpTBED5bKBl9
         wlig==
X-Forwarded-Encrypted: i=1; AJvYcCUhTqaF3aomZ1KjgqL2xeR0H7Kh0EAQk3fcwEvOfLX2nYOMroWzIl6p6Vmk1epRF19/X9SzmSc/lB2BiEOzm3cVeeeTOIYjyYCir4Y/w4cmUgmIjJIWkN5slfB34J4a7kcXqafrovLqpGN/zYit
X-Gm-Message-State: AOJu0Yy5NpsGY6MlJn1GY5+IvoGhUeW5EhgrAED2cBl9w+VtZA8z7rkt
	8tz3UcDHiBYODNw4ARhwOl1ZCBFl1kro89ZxidEUsaDpci/NssR35tn8f45Y
X-Google-Smtp-Source: AGHT+IFFvZgEmBvRLdjW9wbUzrUrg/N0Mgs0why89U67SHWeFVH5yrhHYoCV8YkfKJYKGobxVebzzA==
X-Received: by 2002:a2e:3619:0:b0:2d6:93fa:ce20 with SMTP id d25-20020a2e3619000000b002d693face20mr965811lja.0.1712317144349;
        Fri, 05 Apr 2024 04:39:04 -0700 (PDT)
Received: from [10.0.0.4] ([37.174.58.205])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c45ce00b004162ef30447sm2023038wmo.18.2024.04.05.04.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 04:39:03 -0700 (PDT)
Message-ID: <32f25edc-4b4e-49b8-a9a4-50ed9da258bf@gmail.com>
Date: Fri, 5 Apr 2024 13:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/socket: the length value of the input socket option
 parameter is too small
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 syzkaller-bugs@googlegroups.com, edumazet@google.com
References: <000000000000b9b20e061553f06e@google.com>
 <tencent_7A77E9664E3C953694964A37444AF474AF09@qq.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <tencent_7A77E9664E3C953694964A37444AF474AF09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/5/24 12:16, Edward Adam Davis wrote:
> [Syzbot reported]
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
> BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
> BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
> BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
> Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064
>
> CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
>   copy_from_sockptr include/linux/sockptr.h:55 [inline]
>   rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
>   rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
>   do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
>   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
>   __do_sys_setsockopt net/socket.c:2343 [inline]
>   __se_sys_setsockopt net/socket.c:2340 [inline]
>   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f36ff898dc9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe010c2208 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f36ff898dc9
> RDX: 0000000000000003 RSI: 0000000000000012 RDI: 0000000000000006
> RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
> R10: 00000000200000c0 R11: 0000000000000246 R12: 0000555567399338
> R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>
> Allocated by task 5064:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   __do_kmalloc_node mm/slub.c:3966 [inline]
>   __kmalloc+0x233/0x4a0 mm/slub.c:3979
>   kmalloc include/linux/slab.h:632 [inline]
>   __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
>   do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
>   __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
>   __do_sys_setsockopt net/socket.c:2343 [inline]
>   __se_sys_setsockopt net/socket.c:2340 [inline]
>   __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> The buggy address belongs to the object at ffff8880209a8bc0
>   which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 1 bytes to the right of
>   allocated 2-byte region [ffff8880209a8bc0, ffff8880209a8bc2)
> [Fix]
> The optlen value passed by syzbot to _sys_setsockopt() is 2, which results in
> only 2 bytes being allocated when allocating memory to kernel_optval, and the
> optval size passed when calling the function copy_from_sockptr() is 4 bytes.
> Here, optlen is determined uniformly in the entry function __sys_setsockopt().
> If its value is less than 4, the parameter is considered invalid.
>
> Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   net/socket.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/socket.c b/net/socket.c
> index e5f3af49a8b6..ac8fd4f6ebfe 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2327,6 +2327,9 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
>   	int err, fput_needed;
>   	struct socket *sock;
>   
> +	if (optlen < sizeof(int))
> +		return -EINVAL;
> +


Please cc netdev@ for core networking patches.

This patch is not good, please fix net/bluetooth/rfcomm/sock.c instead

I think I did this yesterday already :

https://lore.kernel.org/netdev/20240404124723.2429464-1-edumazet@google.com/T/


>   	sock = sockfd_lookup_light(fd, &err, &fput_needed);
>   	if (!sock)
>   		return err;

