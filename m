Return-Path: <linux-kernel+bounces-109802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2918855E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C1B1F21BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3620326;
	Thu, 21 Mar 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/ULsCER"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF247C8FF;
	Thu, 21 Mar 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010552; cv=none; b=lJYVSn4fYV5cOU/SXkbtLoYX1ADwVYzqLQxwoyfI/8j74E9Nmw2LW4MnG4LoSVDmSVdp1f8a/PVMlnuHNUERRV3/Y2ZCCpR7c71WNMDzV0T7WNs09hM77Oup/88+uRaZzp9WSqig3D7OF4AcJP9asUGNiDat4O0Svfm6Tw9kByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010552; c=relaxed/simple;
	bh=DBX0CWxZIXdrLX3AuJX0v/FdA1vH6tSKuX9dbRQoH+s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qHnFwHd3e5P93s1qv6/WvwBIw+Z9PxN7RnizGtfb4YXmJKHFVj4ul7OhQf6pwGuVezlf34XWpmPFwGIUFHB5Yz2K4eDlF66kCfI+a4VuLcueQi4N3m2QcGmlK6N5b7PaY1M87Kqp5pqr809iRgzDOwGrDOwJe9/phki4E0QpNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/ULsCER; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d4226edea8so265536e0c.1;
        Thu, 21 Mar 2024 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711010549; x=1711615349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DBX0CWxZIXdrLX3AuJX0v/FdA1vH6tSKuX9dbRQoH+s=;
        b=c/ULsCERC2mbfp20jNd1WqSRAFe6LQ+Jsxq0Rl/R8eksja5W5TSVqKFjAD5W0+bK2k
         Bet1kTkRKbmgehTQ0zX2EhwcILUbd6k/xq9MqZTDrXuUGmMS1d3ZkAQnmONLCF44SdUi
         4LSIXYVuMg8gKHWy/bf1qKNH5hiw7c3osncLCvWbB/95I8oyxMfz3WwlP9EgxZ820K5Q
         mDqZRA0xtpdgA+aBSMKJXlLaozrfGq8MjY0jVNNMnYnM6UJrA/BO4Qp+AQ3UsJUQ/x3b
         np9iM4b0jy/tMxKUXLVc4/Ar647ua9CNWxdM6ZFKZ+195GbQIfH8jm9FPIjSfvZT5HGt
         On5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711010549; x=1711615349;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBX0CWxZIXdrLX3AuJX0v/FdA1vH6tSKuX9dbRQoH+s=;
        b=ZjZt31t6V140o/xZYZQYBpanl3layGI0my3oFTi+NH/UsTmjen8TqK37lwNj9YakMp
         P8EAGUK0O0sjQdzB9Y2puqFmgED8kUWXLq4IXaamL1gmfiy9nxHxN2z+d9SrJOOKS5HG
         vIoRyt324DOqCTdIJxfD3sYK6ZlhMj0eTv03EmszzOTv4t3kov3i4EtcfF1fn7IWNB8c
         fmtpsa1XNwP7YvclRc+MNmh5XHi0M2n+3WF6yMUc1EWAkq3NS5IdZ74RklMvlx4HMwW3
         NVIMf1UR3M+N9T6/rmGslIjc9HIJEXPZWfZBh+kThRizrHjhGEXfF0+9exYKMR8W+b84
         DKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7t6C1p9nVxJEzXcI1CtoIWJCm+UnUdpWKUEJpFP2e0+43P6kzRoEXyKzAcRthDkjhg0/14JfrkH8wU9rmOBMR/X1DhjatH3ENMAIFgWFmDauSWOXaEf1kTCrEC4+egpZLLB/AcD0YKnDAygpr4pioJs2R577WJzAN
X-Gm-Message-State: AOJu0YykBMl5hBVM7SqwRxsFvTJ9z8oA57A7omlrqdvlfJyDhMNg5U5H
	uyO9abEMRo4Vb1McUcwbQbXu0nV96u47BnUi727WpgdazdWdPi3oKHZh8Etw4GKtukVIsqo2e7z
	FKRT3oBOABPQcfhZoyx64IlRLm40=
X-Google-Smtp-Source: AGHT+IFhnzBp/8J7mRTuP8T2MWY3Bfs2ij5VZkE9Z3Y8C647KfDy98PrIh4rHXdRcqvV0nqpTgnqkGQFFNWBM3XwFHY=
X-Received: by 2002:a05:6122:3659:b0:4c0:2d32:612f with SMTP id
 dv25-20020a056122365900b004c02d32612fmr5454535vkb.15.1711010549378; Thu, 21
 Mar 2024 01:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Thu, 21 Mar 2024 16:42:17 +0800
Message-ID: <CABOYnLzaRiZ+M1v7dPaeObnj_=S4JYmWbgrXaYsyBbWh=553vQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_hash_delete_elem (2)
To: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug and comfired in the latest net/bpf tree.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

BTW, in the reproducing prograss, other crash titles may aslo related
to this issue:
WARNING in sock_hash_delete_elem
possible deadlock in hrtimer_start_range_ns
possible deadlock in hrtimer_start_range_ns
WARNING in hrtimer_interrupt
kernel BUG in irq_work_run_list
invalid opcode in irq_work_run_list
..

kernel version: bpf tree 114b5b3b4bde7358624437be2f12cde1b265224e
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=5c1d7ee7e74661a8
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

WARNING: possible circular locking dependency detected
6.8.0 #1 Not tainted
------------------------------------------------------
80aaaa/8172 is trying to acquire lock:
ffff88814e959c20 (&htab->buckets[i].lock
){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
){+...}-{2:2}, at: sock_hash_delete_elem+0xb5/0x320 net/core/sock_map.c:939
but task is already holding lock:
ffff8880b952c8d8 (
hrtimer_bases.lock
){-.-.}-{2:2}
, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
, at: hrtimer_start_range_ns+0xea/0xc90 kernel/time/hrtimer.c:1303
which lock already depends on the new lock.
the existing dependency chain (in reverse order) is:
-> #2 (
hrtimer_bases.lock
){-.-.}-{2:2}
:
lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
__raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
_raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
hrtimer_start_range_ns+0xea/0xc90 kernel/time/hrtimer.c:1303
hrtimer_start include/linux/hrtimer.h:275 [inline]
run_page_cache_worker kernel/rcu/tree.c:3341 [inline]
kvfree_call_rcu+0x5e6/0x790 kernel/rcu/tree.c:3446
rtnl_register_internal+0x4ad/0x5d0 net/core/rtnetlink.c:265
rtnl_register+0x3b/0x80 net/core/rtnetlink.c:315
ip_rt_init+0x302/0x3b0 net/ipv4/route.c:3719
ip_init+0x13/0x20 net/ipv4/ip_output.c:1664
inet_init+0x3f1/0x5a0 net/ipv4/af_inet.c:2022
do_one_initcall+0x250/0x880 init/main.c:1241
do_initcall_level+0x164/0x220 init/main.c:1303
do_initcalls+0x48/0x90 init/main.c:1319
kernel_init_freeable+0x455/0x5f0 init/main.c:1557
kernel_init+0x22/0x2c0 init/main.c:1446
ret_from_fork+0x52/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
-> #1
(
krc.lock
){..-.}-{2:2}
:
lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
__raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
_raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
krc_this_cpu_lock kernel/rcu/tree.c:2960 [inline]
add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3359 [inline]
kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3444
sock_hash_free_elem net/core/sock_map.c:900 [inline]
sock_hash_delete_from_link net/core/sock_map.c:923 [inline]
sock_map_unlink net/core/sock_map.c:1566 [inline]
sock_map_remove_links+0x497/0x580 net/core/sock_map.c:1578
sock_map_close+0x12b/0x2f0 net/core/sock_map.c:1643
inet_release+0x191/0x210 net/ipv4/af_inet.c:437
__sock_release net/socket.c:659 [inline]
sock_close+0xc3/0x250 net/socket.c:1421
__fput+0x442/0x8d0 fs/file_table.c:423
task_work_run+0x25c/0x320 kernel/task_work.c:180
exit_task_work include/linux/task_work.h:38 [inline]
do_exit+0xa46/0x28a0 kernel/exit.c:878
do_group_exit+0x20b/0x2c0 kernel/exit.c:1027
get_signal+0x17ef/0x18d0 kernel/signal.c:2907
arch_do_signal_or_restart+0x9b/0x890 arch/x86/kernel/signal.c:310
exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
__syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:212
do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x6d/0x75
-> #0


=* repro.c =*
#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static void sleep_ms(uint64_t ms) {
usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts))
exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg) {
pthread_t th;
pthread_attr_t attr;
pthread_attr_init(&attr);
pthread_attr_setstacksize(&attr, 128 << 10);
int i = 0;
for (; i < 100; i++) {
if (pthread_create(&th, &attr, fn, arg) == 0) {
pthread_attr_destroy(&attr);
return;
}
if (errno == EAGAIN) {
usleep(50);
continue;
}
break;
}
exit(1);
}

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len) \
*(type*)(addr) = \
htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
(((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

typedef struct {
int state;
} event_t;

static void event_init(event_t* ev) {
ev->state = 0;
}

static void event_reset(event_t* ev) {
ev->state = 0;
}

static void event_set(event_t* ev) {
if (ev->state)
exit(1);
__atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
uint64_t start = current_time_ms();
uint64_t now = start;
for (;;) {
uint64_t remain = timeout - (now - start);
struct timespec ts;
ts.tv_sec = remain / 1000;
ts.tv_nsec = (remain % 1000) * 1000 * 1000;
syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
return 1;
now = current_time_ms();
if (now - start > timeout)
return 0;
}
}

struct thread_t {
int created, call;
event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
struct thread_t* th = (struct thread_t*)arg;
for (;;) {
event_wait(&th->ready);
event_reset(&th->ready);
execute_call(th->call);
__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
event_set(&th->done);
}
return 0;
}

static void loop(void) {
int i, call, thread;
for (call = 0; call < 11; call++) {
for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
thread++) {
struct thread_t* th = &threads[thread];
if (!th->created) {
th->created = 1;
event_init(&th->ready);
event_init(&th->done);
event_set(&th->done);
thread_start(thr, th);
}
if (!event_isset(&th->done))
continue;
event_reset(&th->done);
th->call = call;
__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
event_set(&th->ready);
event_timedwait(&th->done, 50 + (call == 0 ? 500 : 0) +
(call == 5 ? 500 : 0) +
(call == 10 ? 500 : 0));
break;
}
}
for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
sleep_ms(1);
}

uint64_t r[5] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff,
0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call) {
intptr_t res = 0;
switch (call) {
case 0:
*(uint32_t*)0x20002c80 = 3;
*(uint32_t*)0x20002c84 = 5;
*(uint64_t*)0x20002c88 = 0x20000340;
sprintf((char*)0x20000340, "%020llu", (long long)0);
*(uint64_t*)0x20002c90 = 0x20000080;
memcpy((void*)0x20000080, "GPL\000", 4);
*(uint32_t*)0x20002c98 = 4;
*(uint32_t*)0x20002c9c = 0;
*(uint64_t*)0x20002ca0 = 0;
*(uint32_t*)0x20002ca8 = 0;
*(uint32_t*)0x20002cac = 0;
memset((void*)0x20002cb0, 0, 16);
*(uint32_t*)0x20002cc0 = 0;
*(uint32_t*)0x20002cc4 = 0;
*(uint32_t*)0x20002cc8 = -1;
*(uint32_t*)0x20002ccc = 8;
*(uint64_t*)0x20002cd0 = 0;
*(uint32_t*)0x20002cd8 = 0;
*(uint32_t*)0x20002cdc = 0x10;
*(uint64_t*)0x20002ce0 = 0;
*(uint32_t*)0x20002ce8 = 0;
*(uint32_t*)0x20002cec = 0;
*(uint32_t*)0x20002cf0 = 0;
*(uint32_t*)0x20002cf4 = 0;
*(uint64_t*)0x20002cf8 = 0;
*(uint64_t*)0x20002d00 = 0;
*(uint32_t*)0x20002d08 = 0x10;
*(uint32_t*)0x20002d0c = 0;
res =
syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20002c80ul, /*size=*/0x90ul);
if (res != -1)
r[0] = res;
break;
case 1:
*(uint32_t*)0x200009c0 = 0x12;
*(uint32_t*)0x200009c4 = 4;
*(uint32_t*)0x200009c8 = 8;
*(uint32_t*)0x200009cc = 8;
*(uint32_t*)0x200009d0 = 0;
*(uint32_t*)0x200009d4 = -1;
*(uint32_t*)0x200009d8 = 0;
memset((void*)0x200009dc, 0, 16);
*(uint32_t*)0x200009ec = 0;
*(uint32_t*)0x200009f0 = -1;
*(uint32_t*)0x200009f4 = 0;
*(uint32_t*)0x200009f8 = 0;
*(uint32_t*)0x200009fc = 0;
*(uint64_t*)0x20000a00 = 0;
res =
syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0x200009c0ul, /*size=*/0x48ul);
if (res != -1)
r[1] = res;
break;
case 2:
res = syscall(__NR_socket, /*domain=*/0xaul, /*type=*/2ul, /*proto=*/0);
if (res != -1)
r[2] = res;
break;
case 3:
*(uint32_t*)0x20000080 = r[1];
*(uint64_t*)0x20000088 = 0x20000a40;
memcpy((void*)0x20000a40, "\x90\xb4", 2);
*(uint64_t*)0x20000090 = 0x20000040;
*(uint32_t*)0x20000040 = r[2];
*(uint64_t*)0x20000098 = 0;
syscall(__NR_bpf, /*cmd=*/2ul, /*arg=*/0x20000080ul, /*size=*/0x20ul);
break;
case 4:
*(uint32_t*)0x200000c0 = 0x11;
*(uint32_t*)0x200000c4 = 0xc;
*(uint64_t*)0x200000c8 = 0x20000440;
*(uint8_t*)0x20000440 = 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000441, 0, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000441, 0, 4, 4);
*(uint16_t*)0x20000442 = 0;
*(uint32_t*)0x20000444 = 0;
*(uint8_t*)0x20000448 = 0;
*(uint8_t*)0x20000449 = 0;
*(uint16_t*)0x2000044a = 0;
*(uint32_t*)0x2000044c = 0;
*(uint8_t*)0x20000450 = 0x18;
STORE_BY_BITMASK(uint8_t, , 0x20000451, 1, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000451, 1, 4, 4);
*(uint16_t*)0x20000452 = 0;
*(uint32_t*)0x20000454 = r[1];
*(uint8_t*)0x20000458 = 0;
*(uint8_t*)0x20000459 = 0;
*(uint16_t*)0x2000045a = 0;
*(uint32_t*)0x2000045c = 0;
STORE_BY_BITMASK(uint8_t, , 0x20000460, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000460, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000460, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000461, 8, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000461, 0, 4, 4);
*(uint16_t*)0x20000462 = 0;
*(uint32_t*)0x20000464 = 0;
STORE_BY_BITMASK(uint8_t, , 0x20000468, 3, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000468, 3, 3, 2);
STORE_BY_BITMASK(uint8_t, , 0x20000468, 3, 5, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000469, 0xa, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000469, 8, 4, 4);
*(uint16_t*)0x2000046a = 0xfff8;
*(uint32_t*)0x2000046c = 0;
STORE_BY_BITMASK(uint8_t, , 0x20000470, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000470, 1, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000470, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000471, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000471, 0xa, 4, 4);
*(uint16_t*)0x20000472 = 0;
*(uint32_t*)0x20000474 = 0;
STORE_BY_BITMASK(uint8_t, , 0x20000478, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000478, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000478, 0, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000479, 2, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000479, 0, 4, 4);
*(uint16_t*)0x2000047a = 0;
*(uint32_t*)0x2000047c = 0xfffffff8;
STORE_BY_BITMASK(uint8_t, , 0x20000480, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000480, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000480, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000481, 3, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000481, 0, 4, 4);
*(uint16_t*)0x20000482 = 0;
*(uint32_t*)0x20000484 = 8;
STORE_BY_BITMASK(uint8_t, , 0x20000488, 7, 0, 3);
STORE_BY_BITMASK(uint8_t, , 0x20000488, 0, 3, 1);
STORE_BY_BITMASK(uint8_t, , 0x20000488, 0xb, 4, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000489, 4, 0, 4);
STORE_BY_BITMASK(uint8_t, , 0x20000489, 0, 4, 4);
*(uint16_t*)0x2000048a = 0;
*(uint32_t*)0x2000048c = 0;
*(uint8_t*)0x20000490 = 0x85;
*(uint8_t*)0x20000491 = 0;
*(uint16_t*)0x20000492 = 0;
*(uint32_t*)0x20000494 = 3;
*(uint8_t*)0x20000498 = 0x95;
*(uint8_t*)0x20000499 = 0;
*(uint16_t*)0x2000049a = 0;
*(uint32_t*)0x2000049c = 0;
*(uint64_t*)0x200000d0 = 0x20000240;
memcpy((void*)0x20000240, "GPL\000", 4);
*(uint32_t*)0x200000d8 = 0;
*(uint32_t*)0x200000dc = 0;
*(uint64_t*)0x200000e0 = 0;
*(uint32_t*)0x200000e8 = 0;
*(uint32_t*)0x200000ec = 0;
memset((void*)0x200000f0, 0, 16);
*(uint32_t*)0x20000100 = 0;
*(uint32_t*)0x20000104 = 0;
*(uint32_t*)0x20000108 = -1;
*(uint32_t*)0x2000010c = 0;
*(uint64_t*)0x20000110 = 0;
*(uint32_t*)0x20000118 = 0;
*(uint32_t*)0x2000011c = 0;
*(uint64_t*)0x20000120 = 0;
*(uint32_t*)0x20000128 = 0;
*(uint32_t*)0x2000012c = 0;
*(uint32_t*)0x20000130 = 0;
*(uint32_t*)0x20000134 = 0;
*(uint64_t*)0x20000138 = 0;
*(uint64_t*)0x20000140 = 0;
*(uint32_t*)0x20000148 = 0;
*(uint32_t*)0x2000014c = 0;
res =
syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200000c0ul, /*size=*/0x90ul);
if (res != -1)
r[3] = res;
break;
case 5:
*(uint64_t*)0x20000000 = 0x20000640;
memcpy((void*)0x20000640, "ext4_es_find_extent_range_enter\000", 32);
*(uint32_t*)0x20000008 = r[3];
syscall(__NR_bpf, /*cmd=*/0x11ul, /*arg=*/0x20000000ul, /*size=*/0x10ul);
break;
case 6:
*(uint32_t*)0x20000a80 = r[0];
*(uint32_t*)0x20000a84 = 0xe0;
*(uint64_t*)0x20000a88 = 0x200008c0;
*(uint32_t*)0x200008f4 = 8;
*(uint64_t*)0x200008f8 = 0x20000680;
*(uint32_t*)0x20000928 = 9;
*(uint32_t*)0x2000092c = 1;
*(uint64_t*)0x20000930 = 0x200006c0;
*(uint64_t*)0x20000938 = 0x20000740;
*(uint32_t*)0x20000944 = 0x8b;
*(uint64_t*)0x20000948 = 0x20000780;
*(uint32_t*)0x20000950 = 0x48;
*(uint32_t*)0x20000954 = 0x10;
*(uint64_t*)0x20000958 = 0x20000800;
*(uint64_t*)0x20000960 = 0x20000840;
*(uint32_t*)0x20000968 = 8;
*(uint32_t*)0x2000096c = 0xc7;
*(uint32_t*)0x20000970 = 8;
*(uint32_t*)0x20000974 = 8;
*(uint64_t*)0x20000978 = 0x20000880;
syscall(__NR_bpf, /*cmd=*/0xful, /*arg=*/0x20000a80ul, /*size=*/0x10ul);
break;
case 7:
res = syscall(__NR_pipe, /*pipefd=*/0x20000000ul);
if (res != -1)
r[4] = *(uint32_t*)0x20000004;
break;
case 8:
*(uint64_t*)0x20000100 = 0x20000580;
memset((void*)0x20000580, 128, 1);
*(uint64_t*)0x20000108 = 1;
syscall(__NR_vmsplice, /*fd=*/r[4], /*vec=*/0x20000100ul, /*vlen=*/1ul,
/*f=*/0ul);
break;
case 9:
*(uint32_t*)0x20000040 = r[4];
*(uint16_t*)0x20000044 = 0;
*(uint16_t*)0x20000046 = 0;
syscall(__NR_poll, /*fds=*/0x20000040ul, /*nfds=*/1ul,
/*timeout=*/0x8001);
break;
case 10:
*(uint64_t*)0x20000280 = 0x20000240;
memcpy((void*)0x20000240, "hrtimer_start\000", 14);
*(uint32_t*)0x20000288 = r[3];
syscall(__NR_bpf, /*cmd=*/0x11ul, /*arg=*/0x20000280ul, /*size=*/0x10ul);
break;
}
}
int main(void) {
syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
/*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
/*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
/*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
/*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
/*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
/*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
/*offset=*/0ul);
loop();
return 0;
}

=* repro.txt =*
r0 = bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000002c80)={0x3,
0x5, &(0x7f0000000340)=ANY=[@ANYRESDEC=0x0],
&(0x7f0000000080)='GPL\x00', 0x4}, 0x90)
r1 = bpf$MAP_CREATE(0x0, &(0x7f00000009c0)=@base={0x12, 0x4, 0x8, 0x8}, 0x48)
r2 = socket$inet6_udp(0xa, 0x2, 0x0)
bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000080)={r1,
&(0x7f0000000a40)="90b4", &(0x7f0000000040)=@udp6=r2}, 0x20)
r3 = bpf$PROG_LOAD(0x5, &(0x7f00000000c0)={0x11, 0xc,
&(0x7f0000000440)=@framed={{}, [@ringbuf_output={{0x18, 0x1, 0x1, 0x0,
r1}, {}, {}, {}, {}, {}, {}, {0x85, 0x0, 0x0, 0x3}}]},
&(0x7f0000000240)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
0x0, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0}, 0x90)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f0000000000)={&(0x7f0000000640)='ext4_es_find_extent_range_enter\x00',
r3}, 0x10)
bpf$BPF_GET_PROG_INFO(0xf, &(0x7f0000000a80)={r0, 0xe0,
&(0x7f00000008c0)={0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x8,
&(0x7f0000000680)=[0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0], ""/16,
0x0, 0x0, 0x0, 0x0, 0x9, 0x1, &(0x7f00000006c0)=[0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0], &(0x7f0000000740)=[0x0], 0x0, 0x8b,
&(0x7f0000000780)=[{}, {}, {}, {}, {}, {}, {}, {}, {}], 0x48, 0x10,
&(0x7f0000000800), &(0x7f0000000840), 0x8, 0xc7, 0x8, 0x8,
&(0x7f0000000880)}}, 0x10)
pipe(&(0x7f0000000000)={0xffffffffffffffff, <r4=>0xffffffffffffffff})
vmsplice(r4, &(0x7f0000000100)=[{&(0x7f0000000580)="80", 0x1}], 0x1, 0x0)
poll(&(0x7f0000000040)=[{r4}], 0x1, 0x8001)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f0000000280)={&(0x7f0000000240)='hrtimer_start\x00', r3}, 0x10)

and see also in
https://gist.github.com/xrivendell7/f829da1471add4307c9a435d88de5ecc

I hope it helps.
Best regards
xingwei Lee

