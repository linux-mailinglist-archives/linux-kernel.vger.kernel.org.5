Return-Path: <linux-kernel+bounces-89855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4676786F68E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCC4281DE3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B73768EA;
	Sun,  3 Mar 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5fir6AY"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172476411
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709490159; cv=none; b=GDGtLw7TmyHfBoX0LT/3iNc5BSaYVicz8CH3EKBQPmSIhVfogim6HdtLCQAhTDCBK4pHyznrXJXMfeyYlrExPPSZUCQWbXDBEXN6o039xT2pAYZoB3DdQ/78n0RytQ66HZvxBbeIGjbAQug8oopzPdDV7TCauchiwVdpB3Jw+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709490159; c=relaxed/simple;
	bh=A/n6Qg5kmB+4QNpRzKobke/SPRzbPPLafdoueWLfHzk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Fh6LGhcWYDqqWrxP0fPO3OOI3BiRveHA5bZLfXHH0cBKwEdOiwBtG7rpvVGQZUrw/QGqk9/GDDKda0BZva7q4+Dah2LbjcKFVybN2RWDBj6FuBA+jREe41SiQhyJyC7p2pa6e7aiEjpP1wH1AaKBXxoQB457ZSVbpTsTDJsg230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5fir6AY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ee7fa077bso4016201cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709490157; x=1710094957; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2lcjIwJ/1bzVoEzBZ4aJp8qKBUdiptHhCsOh5JOUCi8=;
        b=a5fir6AYZizGM6DXqovWVfdvVxUA3ENGLSayY3+iXx0H7VqLdlFHY1YTTC+1cDvpWe
         9kydF8RxN3pBaOA79Z+OaeTl2PCjxUHocieU1/dY6aT0ERA3cPcZd743vVP6kUL2sR0F
         CFbrcbNOhDlK2mbNh36UFJhGIyOi4ibYfTEy0qUTgZXZupKwbvoiK48Vci5Rov5/IzG+
         TgcT/R0Kn8Sp5uoSFH0le7wuVEJDYT0j6O0aXR96fKN6uTMdrRAcFug9VSW7weUjAuo/
         /rKUuz8vzvDHIDnrupv5C1O7YImXDYf9WVfZsHK5kGc/5Hki545tHPL7dhlqmjqf2w3q
         1B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709490157; x=1710094957;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lcjIwJ/1bzVoEzBZ4aJp8qKBUdiptHhCsOh5JOUCi8=;
        b=I+NzAzQ+ZTqRuqh83oisy354zBpGmFHjnxjx9qySPvECIHmJTSQozyz3CNagkDHN9z
         J46Wz5A3DIA7n4RaTulUMT9wmZpEHfL5znBlQBYfTgXNSFvhoQhRA1uE5S5LFIrgwglp
         ImQpsgZcLCKby8xS9lpnDbTe4l/G+AKtBBJWAlsrE0ElgVg2Sxjv7+xPbGjQHXKxK0pr
         bD2jHzQeulM8MQst/B1kgxKfAWN72qmDNw6tNdcckKV5sjDgHYKW/nNJ4Rvho+E+eCR+
         MH7oZX6gNCkPcyR4oCpv/TT24HvItbhZ6KpiGYlvmofMHM7n+Kj6wFAFHcpe/kldyw/n
         u8/A==
X-Forwarded-Encrypted: i=1; AJvYcCUruGi7wFNZpZ4yPHGDe0kH5DFwB0baVaNbOareoiKOUScT3VXxqqwC4w6Sle/bY2/jhPjyplTyuFhUtAxMhL2tugIHWCAefnKlGrJo
X-Gm-Message-State: AOJu0YyP8/Wa0TKJJJe59pRaCMQT41gdNlyWa4cx+xYt8dsSWklcGzMG
	zSiA/9SDtPrUdSS4W4YeCqAZMkL2Wqu/ZQVVUEMXe8XTYnVdw+uhGtAwAfOxo7BRFs6Ev/8HZrG
	SBgOwj0HvRS/bLG4yaelBzHWbqMo=
X-Google-Smtp-Source: AGHT+IFaZeZI9coYELsKZB6YDfuuggtgGgHG+oKE6T4kaODAwSVzhJPIwD7dwOSwz6CY+YQX9U37AWZklrcb7Za6cPc=
X-Received: by 2002:a05:622a:8:b0:42e:e949:7a40 with SMTP id
 x8-20020a05622a000800b0042ee9497a40mr4176304qtw.52.1709490156754; Sun, 03 Mar
 2024 10:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Mon, 4 Mar 2024 02:22:26 +0800
Message-ID: <CALf2hKupR6mV4vUW8tWEJY_1CqaLLrqx5q2667XGEzEGnAtuQw@mail.gmail.com>
Subject: [Linux LTS Kernel Bug] [v5.15] KASAN-stack-out-of-bounds-Read-in-gfs2_file_buffered_write
To: rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com, 
	linux-kernel@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com, 
	Red Hat Product Security <secalert@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linux Developers and Maintainers,

We found a bug "KASAN-stack-out-of-bounds-Read-in-gfs2_file_buffered_write"
 while fuzzing Linux LTS Kernel 5.15.140 with our modified fuzzer
based on Syzkaller. We have analyzed the root cause and possible
impacts of the bug. And the bug can be steadily reproduced on the
latest LTS kernel 5.15.149. The kernel configs with/without
sanitizers, reports and poc are packed and shared through google
drive:
https://drive.google.com/drive/folders/1OdsYV_-9UMJ_ibwK8zeBSTus7j3lwIVU?usp=sharing

===================  Crash Reproduction  ===================
1. Compiled the latest LTS linux-5.15.149 with provided config
(with/without sanitizers)
2. Create an brand new image through syzkaller's create-image.sh and
boot it with the kernel.
3. Copy the repro.c to the vm though scp and compile it with gcc in the vm.
4. Execute the binary of repro and observe the kernel panic.

===================  Cause Analysis  ===================
The kernel panic happens in the vulnerable function
fs/gfs2/file.c:784:should_fault_in_pages. The function call stack is:
get_signal->do_coredump->elf_core_dump->dump_emit->__dump_emit->__kernel_write->gfs_file_write_iter->gfs2_file_buffered_write->should_fault_in_pages.

The out-of-bound read occurs at fs/gfs2/file.c:784 "char __user *p =
i->iov[0].iov_base + i->iov_offset;", where i->iov is actually NULL.
We can verify this through debugging with gdb:

    pwndbg > p from->iov[0]
    $16 = {
      iov_base = 0xffffffff8165b44a <exit_to_user_mode_prepare+426>,
      iov_len = 18446744071722249801
    }

The value of from->iov[0]->iov_len is a meaningless value, indicating
that iov is uninitialized. The from is actually introduced by "if
(should_fault_in_pages(ret, from, &prev_count, &window_size)) {" at
fs/gfs2/file.c:1069:gfs2_file_buffered_write with a blank member iov.

===================  Impact Analysis  ===================
In "char __user *p = i->iov[0].iov_base + i->iov_offset;", p oob read
8 bytes through i->iov[0].iov_base with an offset. According to
"*window_size = (size_t)PAGE_SIZE * pages - offset_in_page(p);", the
infomation may be leaked to user space through parameter window_size
if offset_in_page(p) is computable. The implementation of
offset_in_pages is:

    #define PAGE_SIZE       (__IA64_UL_CONST(1) << PAGE_SHIFT)
    #define PAGE_MASK       (~(PAGE_SIZE - 1))
    #define offset_in_page(p) ((unsigned long)(p) & ~PAGE_MASK)

Macro PAGE_SHIFT is decided by the architecture, take IA64 as an
example, it can be 12, 13, 14, 16. Therefore, offset_in_page may leak
the lower 12-16 bits of p information. Since the repro can steadily
crash the kernel, the recommended scores of CIA impact matrics are
High, None, High.

===================  Patch recommendation  ===================
Adding checks before usage is one of the solution. Blocking r/w to
mounted block devices may be another solution, like
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f861765464f43a71462d52026fbddfc858239a5.
This commit has been merged to linux-6.8-rc6 and can avoid the crash.
However, the linux-5.15.y are still vulnerable to this flaw.


Hope this would be of help to improve the security of Linux kernel.
And if needed, I am happy to provide further assistance.

Best,
Zhiyu Zhang

