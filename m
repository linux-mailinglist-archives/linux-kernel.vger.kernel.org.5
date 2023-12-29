Return-Path: <linux-kernel+bounces-13069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4903281FF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71EB283807
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0179911193;
	Fri, 29 Dec 2023 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="NBYxZdpL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAA10A3F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so7880870a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1703850205; x=1704455005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNs7772lqUS8xDTIVejwuJ7wzqGXZerLZe5E07k6z8E=;
        b=NBYxZdpLgZclBUlX3TqRzj3qdgdXShZ7GMCwUEoQzQBybj3pQTj53aRex9YvNKZNon
         xPXc6rts4kkjGArmr2vYoelWtXk2qy0zGtNBBKMelcc30Vq+RaAfi8+JtQ9K3mtWyEQq
         M6pYqDL2qwbRmO8QDLmbQ9WvUbLpdeSv0BN9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703850205; x=1704455005;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNs7772lqUS8xDTIVejwuJ7wzqGXZerLZe5E07k6z8E=;
        b=TKlvYd4sKjAimCTgMB6FY5EHBPXRH5vUjr+xxX2lKhVxRIaJ7LlCAkSSjci/XLCIlm
         0zEbLjp9qhMVICRuwFLtsNtO+W4d3O0TwsJN4qTUcoJBvFshTa4ZhtPNiA/vjRUmvulS
         H7Mjyn5e+UtWRM2HgoKeCIdxx9xW4dZ++oupM61sjSPg9tu2KPDNDdWY6Od8NlVIZSZN
         2rAMwsiuhMLdrTKcGL5XkMTF54VaW8VRKZTJCXHDyXFATfLaPYnSthsAclnS/U64mpN/
         b1Ic/qCA4tG8jNJoOHvFnMQA4V2Es0cd3W/2h//a89YXXgOpp9i9UBPyOXL/WaDTrDbm
         zTMg==
X-Gm-Message-State: AOJu0YwFS6ecp0/90hEPiweNbsk6lwsCJLozF1JFgBM9bKWY/hC2TU3A
	gF4xlOe+Mk996FPJZ+YiWskH5OojwJqOjxUG96HhNadYVIrLUMyPNwHiYXe8tNw=
X-Google-Smtp-Source: AGHT+IHSxM3nb1gS1SDglHvB7hbvGkazTjcMwr6Oj4IdUsH05+fwwpSW325TXT/RU7M1sn3MMgkVp6R2OzQkYqGjW0U=
X-Received: by 2002:a17:906:109c:b0:a27:4674:1947 with SMTP id
 u28-20020a170906109c00b00a2746741947mr987644eju.214.1703850204665; Fri, 29
 Dec 2023 03:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel J Blueman <daniel@quora.org>
Date: Fri, 29 Dec 2023 19:43:13 +0800
Message-ID: <CAMVG2su=Kt5mkyEHGh5D4YH+1xTUFX3BhOjf-D0bcRTntav3ng@mail.gmail.com>
Subject: Stack corruption in bch2_nocow_write
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Kent et al,

On Linux 6.7-rc7 from bcachefs master SHA f3608cbdfd built with UBSAN
[1], with a crafted workload [2] I'm able to trigger stack corruption
in bch2_nocow_write [3].

Let me know if you can't reproduce it and I'll check reproducibility
on another platform, and let me know for any patch testing.

Reported-by: Daniel J Blueman <daniel@quora.org>

Thanks,
  Daniel

-- [1] https://pastebin.com/WrhtGzck

-- [2]

modprobe brd rd_size=536870912 rd_nr=7
bcachefs format -f --nocow --foreground_target=/dev/ram4
--promote_target=/dev/ram5 /dev/ram1 /dev/ram2 /dev/ram5 /dev/ram0
/dev/ram4 /dev/ram6 /dev/ram3
mount -t bcachefs
/dev/ram1:/dev/ram2:/dev/ram5:/dev/ram0:/dev/ram4:/dev/ram6:/dev/ram3
/mnt
fio --group_reporting --ioengine=io_uring --directory=/mnt --size=16m
--time_based --runtime=60s --iodepth=256 --verify_async=8 --bs=4k-64k
--norandommap --random_distribution=zipf:0.5 --numjobs=16 --rw=randrw
--name=A --direct=1 --name=B --direct=0 >/dev/null &
sleep 10
bcachefs device offline /dev/ram5

-- [3]

================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1258:11
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1259:11
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1262:30
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1260:11
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1264:4
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1284:55
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1285:41
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1289:29
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1293:67
index 4 is out of range for type '<unknown> [4]'
================================================================================
================================================================================
UBSAN: array-index-out-of-bounds in fs/bcachefs/io_write.c:1293:45
index 4 is out of range for type '<unknown> [4]'
================================================================================
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
in: bch2_nocow_write (fs/bcachefs/io_write.c:1284)
CPU: 29 PID: 4362 Comm: iou-wrk-3332 Not tainted 6.7.0-rc7+ #25
Hardware name: Supermicro AS -3014TS-i/H12SSL-i, BIOS 2.5 09/08/2022
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:107)
dump_stack (lib/dump_stack.c:114)
panic (kernel/panic.c:344)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? bch2_nocow_write (fs/bcachefs/io_write.c:1284)
__stack_chk_fail (??:?)
bch2_nocow_write (fs/bcachefs/io_write.c:1284)
? __lock_acquire (kernel/locking/lockdep.c:4599 (discriminator 1)
kernel/locking/lockdep.c:5091 (discriminator 1))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? lock_release (kernel/locking/lockdep.c:5430 kernel/locking/lockdep.c:5774)
? bch2_nocow_write (fs/bcachefs/bcachefs.h:1220 (discriminator 3)
fs/bcachefs/btree_iter.h:441 (discriminator 3)
fs/bcachefs/btree_iter.h:485 (discriminator 3)
fs/bcachefs/io_write.c:1231 (discriminator 3))
__bch2_write (fs/bcachefs/io_write.c:1393)
? __bch2_write (fs/bcachefs/io_write.c:1393)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
? __bch2_increment_clock (fs/bcachefs/clock.c:153)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? lock_release (kernel/locking/lockdep.c:5430 kernel/locking/lockdep.c:5774)
? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
bch2_write (fs/bcachefs/io_write.c:1613)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? bch2_write (fs/bcachefs/io_write.c:1613)
bch2_direct_write (fs/bcachefs/fs-io-direct.c:528
fs/bcachefs/fs-io-direct.c:644)
? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4)
kernel/locking/lockdep.c:5756 (discriminator 4)
kernel/locking/lockdep.c:5719 (discriminator 4))
? __entry_text_end (??:?)
bch2_write_iter (fs/bcachefs/fs-io-buffered.c:1055)
? bch2_read_iter (fs/bcachefs/errcode.h:266 (discriminator 1)
fs/bcachefs/fs-io-direct.c:206 (discriminator 1))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4)
kernel/locking/lockdep.c:5756 (discriminator 4)
kernel/locking/lockdep.c:5719 (discriminator 4))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? lock_release (kernel/locking/lockdep.c:5430 kernel/locking/lockdep.c:5774)
io_write (./include/linux/fs.h:2020 io_uring/rw.c:1029)
io_issue_sqe (io_uring/io_uring.c:1888)
io_wq_submit_work (io_uring/io_uring.c:1969)
io_worker_handle_work (io_uring/io-wq.c:540 io_uring/io-wq.c:597)
io_wq_worker (io_uring/io-wq.c:258 io_uring/io-wq.c:648)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? lock_release (kernel/locking/lockdep.c:5430 kernel/locking/lockdep.c:5774)
? __pfx_io_wq_worker (io_uring/io-wq.c:627)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:181)
? __pfx_io_wq_worker (io_uring/io-wq.c:627)
ret_from_fork (arch/x86/kernel/process.c:153)
? __pfx_io_wq_worker (io_uring/io-wq.c:627)
ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
RSP: 002b:0000000000000000 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000564239f39ea3
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1b2dfd25c0
R13: 0000000000000002 R14: 0000000000000002 R15: 000056423a4e7b20
</TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: stack-protector: Kernel stack is
corrupted in: bch2_nocow_write+0x13e9/0x1770 ]---
-- 
Daniel J Blueman

