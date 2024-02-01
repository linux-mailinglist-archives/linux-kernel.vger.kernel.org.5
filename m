Return-Path: <linux-kernel+bounces-47513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F199844ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C318B1F2E3E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361843A1BD;
	Thu,  1 Feb 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOhSsOqo"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D793A1A2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751756; cv=none; b=b4ESgn0rMr7p+ypYNu4BoSyTKPZZKjEqdZw/3qxAAoQthLSaI/fKXjhJYVCvv5Jk76qDLDNYej8wZGwq3X8nHYPHKBQghzexuTv/qYATnbEvUThOe7rvE5uukbj9VWfU4BUJg78ZLD+O1hW402MPh95SpdxAS/ZYNxxVPLOcKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751756; c=relaxed/simple;
	bh=hHS7K9jd1Ar2zK8gbkXO7ymeRa0EUnCLE3JMNQcT+lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fu6iIthf16inCaolia9hH0cDEEMj9EG0Ppo9N0mfQCzB4yJBIJuOHR9d9Htv0pLJPUOtJHL2LWZRhFSW3xZi9bV4J2zlHrdoaek8GkTU3fcCRbvXiKeU6LLKOPi1joQk8LnpfyjPDqdgGVvaN3IObKc30decfx6if3Hz5NGt5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOhSsOqo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so263652a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751754; x=1707356554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxrvsxjGLflaggur+73WfV09BCRMmIX9yGv56ImWnQI=;
        b=cOhSsOqottHTIyiV5kUHobzJRqAjhVRZCmLaXmlXdzYvpMebGI183JBDg7uZZWP2of
         QY8FPZMgJhy2VqW3aRaHeVFEuVgWN1M3Nx/Agwwk2vc65FiTzcP0+jniMG9UknaW35vK
         7oM1hRPQ7xUw3Sy6ptmt/ELyEuNWXID7WcMVoAbFgb3usEopbOHKuqg9KrkOE3lqozOZ
         dGYrQgOsr+HdggxA2w/GHMpFG5GmV0GoK7SDk6l4/PqctPguYhc5AfRj+lxN+uBGImgt
         gknHMWEnuSBJjUwS/nYkWtBKI5SNAaOZ+K2tsGVfgdLeMnmAIJ7PH6afsE0HJYgz7LGx
         1fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751754; x=1707356554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxrvsxjGLflaggur+73WfV09BCRMmIX9yGv56ImWnQI=;
        b=k2+UGnIr/z1/PsRL24nlm6Xreeq6nMASxkYTMiMwNzHc0ozVWNMVpMRKIWP4HH1KVY
         TdU1H9WZENwPUlgv631diNxs43gCW2qjWglaFtq3FqD6Zi+vM5ayfMVep7IxuzVbCIZV
         Ozm6OJRgGYdNhc1uXZDXgO9EQWfarZO0sCHUthdYW96a1QKfMaDg/c3/WzU7cHcOLBNb
         luyNjxGxqXkUeJUMwHHYfeJpTGjbshP3rgUEDb1fqPLmiVEDcC6byu4s8cRFiqoWswdC
         ExCibhXTAn9o7EAGLpqzZCmIOJ1ZfwiNX5ASk1L3zAJckWoBxwRlX/ae+JCAJmFl9nm0
         dcag==
X-Gm-Message-State: AOJu0Yyl+wyzGXIxCJfUvvLArJOjfhWgiJ7sdzuYOY8bcNdInVSbRyJg
	eyYzhrqY6n+ByM/r7R/7Xbp+fkpd01edepHINVjHQ26rx4B2yQwrVgFWqiwxAPqrJY1gAcLum1c
	+JS7n1uJLlqtIWS5i8rbyqzMseOBN78w=
X-Google-Smtp-Source: AGHT+IHhUF5Fa//zSjPaaE1z39Uh3wUONBpiYn84dsQLYLcy4oPpShw8iUXeaNfHURGQwZUVKQL9DI2syvlSjuP8eiQ=
X-Received: by 2002:a17:90a:9206:b0:294:bb78:3972 with SMTP id
 m6-20020a17090a920600b00294bb783972mr3225091pjo.14.1706751754258; Wed, 31 Jan
 2024 17:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALGdzupf2Eh-_E-0ZyHa23sHKqo7-e==A9DR9FDsiMNPjtpbEg@mail.gmail.com>
In-Reply-To: <CALGdzupf2Eh-_E-0ZyHa23sHKqo7-e==A9DR9FDsiMNPjtpbEg@mail.gmail.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 31 Jan 2024 19:42:23 -0600
Message-ID: <CALGdzuptUXhRxft9oz9RX-FBP0iwRTWFxsb4KtQjX79_ASSRow@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] memory leak in posix_clock_open
To: davem@davemloft.net, reibax@gmail.com, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Developers,

I am reaching out to kindly inquire whether there have been any recent
updates or progress regarding the memory leak issue.
If you have any questions about the reproducer or config, please let me kno=
w.

Best,
Chenyuan


On Wed, Jan 24, 2024 at 10:22=E2=80=AFAM Chenyuan Yang <chenyuan0y@gmail.co=
m> wrote:
>
> Dear Linux Developers for Posix Timer,
>
> We encountered "memory leak in posix_clock_open" when testing the
> posix timer with
> Syzkaller and our generated specifications.
>
> ```
> BUG: memory leak
> unreferenced object 0xffff888000f66fa0 (size 16):
>   comm "syz-executor.0", pid 21073, jiffies 4295079945 (age 8.800s)
>   hex dump (first 16 bytes):
>     00 b8 d6 0d 80 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8162788a>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>     [<ffffffff8162788a>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff8162788a>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff8162788a>] __kmem_cache_alloc_node+0x2fa/0x3e0 mm/slub.c:35=
17
>     [<ffffffff81572354>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1098
>     [<ffffffff81388b0e>] kmalloc include/linux/slab.h:600 [inline]
>     [<ffffffff81388b0e>] kzalloc include/linux/slab.h:721 [inline]
>     [<ffffffff81388b0e>] posix_clock_open+0x5e/0xe0
> kernel/time/posix-clock.c:126
>     [<ffffffff81692d69>] chrdev_open+0x119/0x340 fs/char_dev.c:414
>     [<ffffffff81680706>] do_dentry_open+0x336/0x9e0 fs/open.c:948
>     [<ffffffff816a9659>] do_open fs/namei.c:3622 [inline]
>     [<ffffffff816a9659>] path_openat+0x1799/0x1b00 fs/namei.c:3779
>     [<ffffffff816aa5ce>] do_filp_open+0xce/0x1b0 fs/namei.c:3809
>     [<ffffffff816843ed>] do_sys_openat2+0xdd/0x130 fs/open.c:1440
>     [<ffffffff81684d53>] do_sys_open fs/open.c:1455 [inline]
>     [<ffffffff81684d53>] __do_sys_openat fs/open.c:1471 [inline]
>     [<ffffffff81684d53>] __se_sys_openat fs/open.c:1466 [inline]
>     [<ffffffff81684d53>] __x64_sys_openat+0x83/0xe0 fs/open.c:1466
>     [<ffffffff84ae676f>] do_syscall_x64 arch/x86/entry/common.c:51 [inlin=
e]
>     [<ffffffff84ae676f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c=
:82
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> BUG: leak checking failed
> ```
> I have attached the reproducible C program and its configuration for
> this crash. Please note that the C program has not been minimized
> because there were issues with syz-repro.
>
> For this memory leak, it seems that the `pccontext` allocated by
> kzalloc (https://elixir.bootlin.com/linux/v6.7/source/kernel/time/posix-c=
lock.c#L126)
> is not released correctly.
>
> If you have any questions or require more information, please feel
> free to contact us.
>
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
>
> Best,
> Chenyuan

