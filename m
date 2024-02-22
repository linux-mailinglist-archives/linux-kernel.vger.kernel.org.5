Return-Path: <linux-kernel+bounces-76471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA485F7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F59A1C222BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2A41212;
	Thu, 22 Feb 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5q72ypm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83A47A7C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603170; cv=none; b=OfNDg2Zczn4xAQ2nYIjsyl4zOjBBt2xpGsvyYDr9b3V/vAYQyu4eqM5tMeboiMJDUOn19fWYxZpX62JV7KWh7OD1utHXkrQX9TYTijrApQ4hk4nviqljddEjRpWR5s+kckmRCAjp+aRt43W0nrUcGQvO0Qn7JJ2b+ppAYvLNatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603170; c=relaxed/simple;
	bh=s6uS81BKcn410gJJLynJWXdxgoYovtnYCK1m5F/ZfUo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QFvcSl8IYejh+Bg4Clh6tJvtdAwgETVaedydMV/I63FiriHGq5XbWfQq0UxRt9fLjO3ShfhcOj8ZUqL8qLDSs5LrWm1ClEtrEEcGWvtVsh5pZ9ljTH/gyb/UeiECh83PT/DuDHsGdCaP/p6qB/QG83Jq5YVu41S88uP0/jgp7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5q72ypm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f4464c48dso205832066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708603166; x=1709207966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7/cnbvlEcwWTBe4LoJGyStLYyF6E6WNFNeEMOHPaOQ=;
        b=T5q72ypmNfLUJTkLhrTEamxEohYlTZ7fnbLoyh31nwQrMlbawJ0yUM8pUZ+Muht0uI
         MBX/5ML+3O3Qx2iQ7ZZh0jbObMiAhjXca/iP0sLtDOoqIh0Uuj8fvA/XqukOSH0oZVDW
         wYpkhYnln0CMhtE4g4Hcn5OFqKR9oN0BBp3W5TlsxBJYf5hV9BaFpAXBjcGcHDNvSFEh
         kGft3nNu3BDPtEfJi8zitaaKF6+skVpBc0dDrDMLHwlYcFdGvP/CUNH7xHLZVit8KB9Y
         JR27R2UBFps1/0eSFYRk5w33wjRs+SLiM4PgcNOfd73G39BP0qBsjSw86lvOSi15AZ3e
         +qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708603166; x=1709207966;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7/cnbvlEcwWTBe4LoJGyStLYyF6E6WNFNeEMOHPaOQ=;
        b=Xn4M4TgSXH8eCmTOmZ8Y8p11brCrV5Zto6cbRESfr4YBPSnPJR/jGiAw0dl7/kHxff
         30iSzI6cUdBA96UwZuBGsN/WwHesOZyfQ/TdoNZjbXcOaaR03br38WAmLb4Pl42ADKUo
         LvAAm7hEiDyIy0wR8H6MseQg0DnNN3Que89uxIOdKwFyKslvJQpd6qhooIVPKwBNY8C1
         e9cwXg2RBAYZzE+LIobTVwZyqLeWBRJtFYaac5pJcIHMmTbJmjnKsVuAqL4EWVsO7idt
         bfIE46X3S/QITj6TssrCrR3zH3rgO2FQiFiIgMDDmbHEjiE/xQZ27JJ0R8tUTwlItLCn
         ihZg==
X-Gm-Message-State: AOJu0Yw+yq/HblyO4ikoAtm3S8+PSU/4MExlHQdUNwgxnFfES8gKjtke
	eKPa+wEw0S3NCCdkiIaYW/CSfBeUSb9uugGNQo90Y31VDlEEEIjprKYqJ+dgsSrotcBDHljwwwp
	90hjsB9PHwcxCMuU2THfx/YcXvCLpm7fWZu0=
X-Google-Smtp-Source: AGHT+IGvjY69T1wPRDss1Sq6OM88vhddDkoomVy0za7oQluxsXN4wA5m8yHkniiRxtX4aH/3jiNaqwb47MkHt2dpMJ4=
X-Received: by 2002:a17:906:b0d9:b0:a3d:6eb4:9769 with SMTP id
 bk25-20020a170906b0d900b00a3d6eb49769mr19514936ejb.15.1708603165421; Thu, 22
 Feb 2024 03:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 22 Feb 2024 12:59:14 +0100
Message-ID: <CAKXUXMxoT4fiFApuyVRgXtva0m2aOk3WO0mJAK71tMZdF+ekyQ@mail.gmail.com>
Subject: Some null-pointer dereference being introduced in v6.0 with squashfs
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Philip,


I have been running some fuzzing campaigns on some kernels with
squashfs support and I noticed some null-pointer dereference being
introduced in v6.0

I started bisecting to find the specific commit and I could bisect
down to this range:

ee56c3e8eec1 (HEAD, refs/bisect/bad) Merge branch 'master' into mm-nonmm-stable
00c9d5632277 (refs/bisect/skip-00c9d5632277b21ba8802e26c27254cd9d0dfa13)
lib/error-inject: convert to DEFINE_SEQ_ATTRIBUTE
f858e23a2974 (refs/bisect/skip-f858e23a29740757fe1ca602cb1f57845034b1c5)
checkpatch: fix incorrect camelcase detection on numeric constant
dd7c9be330d8 (refs/bisect/skip-dd7c9be330d87732766a95cfd7a6de38bf7a39c3)
selftests/filesystems: add a vfat RENAME_EXCHANGE test
da87e1725ae2 (refs/bisect/skip-da87e1725ae2136baeb9aac04c572c283afc917f)
fat: add renameat2 RENAME_EXCHANGE flag support
204d03203a14 (refs/bisect/skip-204d03203a145b443cd8676dc12dbb47e1a3751f)
fat: factor out reusable code in vfat_rename() as helper functions
019a0c9e377c (refs/bisect/skip-019a0c9e377c9f7bd477a0742706d93cdddaee4d)
fat: add a vfat_rename2() and make existing .rename callback a helper
1bb1a07afad9 (refs/bisect/skip-1bb1a07afad97303f14b8d1b319b03f1f01a0091)
squashfs: don't use intermediate buffer if pages missing
f268eedddf35 (refs/bisect/skip-f268eedddf3595e85f8883dc50aed29654785696)
squashfs: extend "page actor" to handle missing pages
0aed4724a839 (refs/bisect/skip-0aed4724a8392f2567f83c9c4b9decf447d752a2)
delayacct: remove some unused variables
f4da7afe0752 (refs/bisect/skip-f4da7afe07523ff8930c4466b09a15db18508cd4)
kexec_file: increase maximum file size to 4G
dabba8722941 (refs/bisect/skip-dabba87229411a5e9d20ac03ffc36463c53ae672)
fs/kernel_read_file: allow to read files up-to ssize_t
d30dfd490f7d (refs/bisect/skip-d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7)
include/uapi/linux/swab.h: move explicit cast outside ternary
c0af32fdc625 (refs/bisect/skip-c0af32fdc625c0e7f03465a813b04cbfb5419a1e)
lib/btree: simplify btree_{lookup|update}
9776e3861e0e (refs/bisect/skip-9776e3861e0e30330f6c8ca9c30348f336d24b1c)
ia64: fix sparse warnings with cmpxchg() & xchg()
4815a3600904 (refs/bisect/skip-4815a36009044ba69a9b8d781943ec6505c451a2)
include/linux/rbtree.h: replace kernel.h with the necessary inclusions
a91befde3503 (refs/bisect/skip-a91befde350375b1ff954635acdde14dc92cd9a8)
lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()
0cc011c576aa (refs/bisect/skip-0cc011c576aaa4de505046f7a6c90933d7c749a9)
lib/list_debug.c: Detect uninitialized lists
53fd5ffbb519 (refs/bisect/skip-53fd5ffbb5197b8cc2d73d2bbc0f688afd45736c)
ocfs2: kill EBUSY from dlmfs_evict_inode
0fe6ee8f123a (refs/bisect/skip-0fe6ee8f123a4dfb529a5aff07536bb481f34043)
profiling: fix shift too large makes kernel panic
dcea7964764a (refs/bisect/skip-dcea7964764aad41c2994084a4c0292371b14e36)
checkpatch: add XA_STATE and XA_STATE_ORDER to the macro declaration
list

My current test setup uses devtmpfs and unfortunately, there are a few
commits, which fail to boot with devtmpfs (just as reference: see
below). I assume the bug is actually introduced with one of two
squashfs commits above.

Some more details:

In v5.19, the C reproducer (see below) does this, which I considered
good in my bisection:

[  106.703144][  T821] loop0: detected capacity change from 0 to 8
[  106.708465][  T821] SQUASHFS error: Failed to read block 0x99: -5
[  106.709027][  T821] SQUASHFS error: Failed to read block 0x99: -5

Since commit ee56c3e8eec1 ("Merge branch 'master' into
mm-nonmm-stable"), I encountered this kernel crash:

[   27.714971][  T829] loop0: detected capacity change from 0 to 8
[   27.718592][  T829] SQUASHFS error: Failed to read block 0x99: -5
[   27.719287][  T829] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000010
[   27.720158][  T829] Mem abort info:
[   27.720501][  T829]   ESR = 0x0000000096000006
[   27.720966][  T829]   EC = 0x25: DABT (current EL), IL = 32 bits
[   27.721531][  T829]   SET = 0, FnV = 0
[   27.721895][  T829]   EA = 0, S1PTW = 0
[   27.722268][  T829]   FSC = 0x06: level 2 translation fault
[   27.722790][  T829] Data abort info:
[   27.723137][  T829]   ISV = 0, ISS = 0x00000006
[   27.723568][  T829]   CM = 0, WnR = 0
[   27.723922][  T829] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000105099000
[   27.724581][  T829] [0000000000000010] pgd=0800000105d2c003,
p4d=0800000105d2c003, pud=0800000106515003, pmd=0000000000000000
[   27.725678][  T829] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[   27.726217][  T829] CPU: 0 PID: 829 Comm: a.out Not tainted
6.0.0-eb-corbos-standard #1
[   27.727660][  T829] Hardware name: linux,dummy-virt (DT)
[   27.728217][  T829] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[   27.728909][  T829] pc : squashfs_page_actor_init_special+0x8c/0x150
[   27.729674][  T829] lr : squashfs_page_actor_init_special+0x88/0x150
[   27.730418][  T829] sp : ffff8000098fb770
[   27.730954][  T829] x29: ffff8000098fb770 x28: ffff0000c0ec3fc0
x27: ffff0000c5e8a000
[   27.731929][  T829] x26: 0000000000000001 x25: ffff800008dde268
x24: ffff800008c420d0
[   27.733066][  T829] x23: 0000000000000000 x22: 0000000000000010
x21: ffff0000c5171b00
[   27.734040][  T829] x20: 0000000000001000 x19: ffff0000c3cbbf80
x18: 0000000000000000
[   27.735045][  T829] x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000002
[   27.735954][  T829] x14: 0000000000000000 x13: 205d393238542020
x12: 5b5d323935383137
[   27.736763][  T829] x11: 616572206f742064 x10: 656c696146203a72 x9
: 0000000000000000
[   27.737566][  T829] x8 : ffff0000c1c74130 x7 : 0000000000000000 x6
: 0000000000000000
[   27.738364][  T829] x5 : ffff0000c0ec3fc0 x4 : ffff8000083ad228 x3
: 0000000000000000
[   27.739161][  T829] x2 : 0000000000000000 x1 : ffff0000c0ec3fc0 x0
: 0000000000000000
[   27.739943][  T829] Call trace:
[   27.740281][  T829]  squashfs_page_actor_init_special+0x8c/0x150
[   27.740929][  T829]  squashfs_readpage_block+0x220/0x6a0
[   27.741478][  T829]  squashfs_read_folio+0x28c/0x45c
[   27.741997][  T829]  filemap_read_folio+0x44/0x130
[   27.742504][  T829]  filemap_get_pages+0x93c/0xa54
[   27.742999][  T829]  filemap_read+0x120/0x52c
[   27.743449][  T829]  generic_file_read_iter+0x1a0/0x280
[   27.743981][  T829]  generic_file_splice_read+0x88/0x1d4
[   27.744538][  T829]  do_splice_to+0xcc/0x124
[   27.745085][  T829]  splice_direct_to_actor+0xdc/0x330
[   27.745610][  T829]  do_splice_direct+0xd8/0x150
[   27.746060][  T829]  do_sendfile+0x4d8/0x5d0
[   27.746479][  T829]  __arm64_sys_sendfile64+0x200/0x254
[   27.746982][  T829]  invoke_syscall.constprop.0+0x6c/0x134
[   27.747503][  T829]  do_el0_svc+0x9c/0x27c
[   27.747903][  T829]  el0_svc+0x38/0xf0
[   27.748282][  T829]  el0t_64_sync_handler+0xf4/0x120
[   27.748796][  T829]  el0t_64_sync+0x190/0x194
[   27.749217][  T829] Code: 97f6c1fd 34000474 97f6c177 f9000276 (f94002c3)
[   27.749860][  T829] ---[ end trace 0000000000000000 ]---
[   27.750359][  T829] Kernel panic - not syncing: Oops: Fatal exception
[   27.750953][  T829] SMP: stopping secondary CPUs
[   27.751425][  T829] Kernel Offset: disabled
[   27.751815][  T829] CPU features: 0x0000,0001c021,19801c82
[   27.752319][  T829] Memory Limit: none
[   27.752672][  T829] Rebooting in 86400 seconds..


Here is the C reproducer:

>>>>
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <setjmp.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 279
#endif
#ifndef __NR_mmap
#define __NR_mmap 222
#endif
#ifndef __NR_openat
#define __NR_openat 56
#endif
#ifndef __NR_sendfile
#define __NR_sendfile 71
#endif
#ifndef __NR_socket
#define __NR_socket 198
#endif

static unsigned long long procid;

//% This code is derived from puff.{c,h}, found in the zlib development. The
//% original files come with the following copyright notice:

//% Copyright (C) 2002-2013 Mark Adler, all rights reserved
//% version 2.3, 21 Jan 2013
//% This software is provided 'as-is', without any express or implied
//% warranty.  In no event will the author be held liable for any damages
//% arising from the use of this software.
//% Permission is granted to anyone to use this software for any purpose,
//% including commercial applications, and to alter it and redistribute it
//% freely, subject to the following restrictions:
//% 1. The origin of this software must not be misrepresented; you must not
//%    claim that you wrote the original software. If you use this software
//%    in a product, an acknowledgment in the product documentation would be
//%    appreciated but is not required.
//% 2. Altered source versions must be plainly marked as such, and must not be
//%    misrepresented as being the original software.
//% 3. This notice may not be removed or altered from any source distribution.
//% Mark Adler    madler@alumni.caltech.edu

//% BEGIN CODE DERIVED FROM puff.{c,h}

#define MAXBITS 15
#define MAXLCODES 286
#define MAXDCODES 30
#define MAXCODES (MAXLCODES + MAXDCODES)
#define FIXLCODES 288

struct puff_state {
  unsigned char* out;
  unsigned long outlen;
  unsigned long outcnt;
  const unsigned char* in;
  unsigned long inlen;
  unsigned long incnt;
  int bitbuf;
  int bitcnt;
  jmp_buf env;
};
static int puff_bits(struct puff_state* s, int need)
{
  long val = s->bitbuf;
  while (s->bitcnt < need) {
    if (s->incnt == s->inlen)
      longjmp(s->env, 1);
    val |= (long)(s->in[s->incnt++]) << s->bitcnt;
    s->bitcnt += 8;
  }
  s->bitbuf = (int)(val >> need);
  s->bitcnt -= need;
  return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state* s)
{
  s->bitbuf = 0;
  s->bitcnt = 0;
  if (s->incnt + 4 > s->inlen)
    return 2;
  unsigned len = s->in[s->incnt++];
  len |= s->in[s->incnt++] << 8;
  if (s->in[s->incnt++] != (~len & 0xff) ||
      s->in[s->incnt++] != ((~len >> 8) & 0xff))
    return -2;
  if (s->incnt + len > s->inlen)
    return 2;
  if (s->outcnt + len > s->outlen)
    return 1;
  for (; len--; s->outcnt++, s->incnt++) {
    if (s->in[s->incnt])
      s->out[s->outcnt] = s->in[s->incnt];
  }
  return 0;
}
struct puff_huffman {
  short* count;
  short* symbol;
};
static int puff_decode(struct puff_state* s, const struct puff_huffman* h)
{
  int first = 0;
  int index = 0;
  int bitbuf = s->bitbuf;
  int left = s->bitcnt;
  int code = first = index = 0;
  int len = 1;
  short* next = h->count + 1;
  while (1) {
    while (left--) {
      code |= bitbuf & 1;
      bitbuf >>= 1;
      int count = *next++;
      if (code - count < first) {
        s->bitbuf = bitbuf;
        s->bitcnt = (s->bitcnt - len) & 7;
        return h->symbol[index + (code - first)];
      }
      index += count;
      first += count;
      first <<= 1;
      code <<= 1;
      len++;
    }
    left = (MAXBITS + 1) - len;
    if (left == 0)
      break;
    if (s->incnt == s->inlen)
      longjmp(s->env, 1);
    bitbuf = s->in[s->incnt++];
    if (left > 8)
      left = 8;
  }
  return -10;
}
static int puff_construct(struct puff_huffman* h, const short* length, int n)
{
  int len;
  for (len = 0; len <= MAXBITS; len++)
    h->count[len] = 0;
  int symbol;
  for (symbol = 0; symbol < n; symbol++)
    (h->count[length[symbol]])++;
  if (h->count[0] == n)
    return 0;
  int left = 1;
  for (len = 1; len <= MAXBITS; len++) {
    left <<= 1;
    left -= h->count[len];
    if (left < 0)
      return left;
  }
  short offs[MAXBITS + 1];
  offs[1] = 0;
  for (len = 1; len < MAXBITS; len++)
    offs[len + 1] = offs[len] + h->count[len];
  for (symbol = 0; symbol < n; symbol++)
    if (length[symbol] != 0)
      h->symbol[offs[length[symbol]]++] = symbol;
  return left;
}
static int puff_codes(struct puff_state* s, const struct puff_huffman* lencode,
                      const struct puff_huffman* distcode)
{
  static const short lens[29] = {3,  4,  5,  6,   7,   8,   9,   10,  11, 13,
                                 15, 17, 19, 23,  27,  31,  35,  43,  51, 59,
                                 67, 83, 99, 115, 131, 163, 195, 227, 258};
  static const short lext[29] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2,
                                 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
  static const short dists[30] = {
      1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
      33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
      1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
  static const short dext[30] = {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
                                 4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
                                 9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
  int symbol;
  do {
    symbol = puff_decode(s, lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 256) {
      if (s->outcnt == s->outlen)
        return 1;
      if (symbol)
        s->out[s->outcnt] = symbol;
      s->outcnt++;
    } else if (symbol > 256) {
      symbol -= 257;
      if (symbol >= 29)
        return -10;
      int len = lens[symbol] + puff_bits(s, lext[symbol]);
      symbol = puff_decode(s, distcode);
      if (symbol < 0)
        return symbol;
      unsigned dist = dists[symbol] + puff_bits(s, dext[symbol]);
      if (dist > s->outcnt)
        return -11;
      if (s->outcnt + len > s->outlen)
        return 1;
      while (len--) {
        if (dist <= s->outcnt && s->out[s->outcnt - dist])
          s->out[s->outcnt] = s->out[s->outcnt - dist];
        s->outcnt++;
      }
    }
  } while (symbol != 256);
  return 0;
}
static int puff_fixed(struct puff_state* s)
{
  static int virgin = 1;
  static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
  static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  static struct puff_huffman lencode, distcode;
  if (virgin) {
    lencode.count = lencnt;
    lencode.symbol = lensym;
    distcode.count = distcnt;
    distcode.symbol = distsym;
    short lengths[FIXLCODES];
    int symbol;
    for (symbol = 0; symbol < 144; symbol++)
      lengths[symbol] = 8;
    for (; symbol < 256; symbol++)
      lengths[symbol] = 9;
    for (; symbol < 280; symbol++)
      lengths[symbol] = 7;
    for (; symbol < FIXLCODES; symbol++)
      lengths[symbol] = 8;
    puff_construct(&lencode, lengths, FIXLCODES);
    for (symbol = 0; symbol < MAXDCODES; symbol++)
      lengths[symbol] = 5;
    puff_construct(&distcode, lengths, MAXDCODES);
    virgin = 0;
  }
  return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state* s)
{
  static const short order[19] = {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
                                  11, 4,  12, 3, 13, 2, 14, 1, 15};
  int nlen = puff_bits(s, 5) + 257;
  int ndist = puff_bits(s, 5) + 1;
  int ncode = puff_bits(s, 4) + 4;
  if (nlen > MAXLCODES || ndist > MAXDCODES)
    return -3;
  short lengths[MAXCODES];
  int index;
  for (index = 0; index < ncode; index++)
    lengths[order[index]] = puff_bits(s, 3);
  for (; index < 19; index++)
    lengths[order[index]] = 0;
  short lencnt[MAXBITS + 1], lensym[MAXLCODES];
  struct puff_huffman lencode = {lencnt, lensym};
  int err = puff_construct(&lencode, lengths, 19);
  if (err != 0)
    return -4;
  index = 0;
  while (index < nlen + ndist) {
    int symbol;
    int len;
    symbol = puff_decode(s, &lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 16)
      lengths[index++] = symbol;
    else {
      len = 0;
      if (symbol == 16) {
        if (index == 0)
          return -5;
        len = lengths[index - 1];
        symbol = 3 + puff_bits(s, 2);
      } else if (symbol == 17)
        symbol = 3 + puff_bits(s, 3);
      else
        symbol = 11 + puff_bits(s, 7);
      if (index + symbol > nlen + ndist)
        return -6;
      while (symbol--)
        lengths[index++] = len;
    }
  }
  if (lengths[256] == 0)
    return -9;
  err = puff_construct(&lencode, lengths, nlen);
  if (err && (err < 0 || nlen != lencode.count[0] + lencode.count[1]))
    return -7;
  short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  struct puff_huffman distcode = {distcnt, distsym};
  err = puff_construct(&distcode, lengths + nlen, ndist);
  if (err && (err < 0 || ndist != distcode.count[0] + distcode.count[1]))
    return -8;
  return puff_codes(s, &lencode, &distcode);
}
static int puff(unsigned char* dest, unsigned long* destlen,
                const unsigned char* source, unsigned long sourcelen)
{
  struct puff_state s = {
      .out = dest,
      .outlen = *destlen,
      .outcnt = 0,
      .in = source,
      .inlen = sourcelen,
      .incnt = 0,
      .bitbuf = 0,
      .bitcnt = 0,
  };
  int err;
  if (setjmp(s.env) != 0)
    err = 2;
  else {
    int last;
    do {
      last = puff_bits(&s, 1);
      int type = puff_bits(&s, 2);
      err = type == 0 ? puff_stored(&s)
                      : (type == 1 ? puff_fixed(&s)
                                   : (type == 2 ? puff_dynamic(&s) : -1));
      if (err != 0)
        break;
    } while (!last);
  }
  *destlen = s.outcnt;
  return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char* source,
                             unsigned long sourcelen, int dest_fd)
{
  if (sourcelen < ZLIB_HEADER_WIDTH)
    return 0;
  source += ZLIB_HEADER_WIDTH;
  sourcelen -= ZLIB_HEADER_WIDTH;
  const unsigned long max_destlen = 132 << 20;
  void* ret = mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                   MAP_PRIVATE | MAP_ANON, -1, 0);
  if (ret == MAP_FAILED)
    return -1;
  unsigned char* dest = (unsigned char*)ret;
  unsigned long destlen = max_destlen;
  int err = puff(dest, &destlen, source, sourcelen);
  if (err) {
    munmap(dest, max_destlen);
    errno = -err;
    return -1;
  }
  if (write(dest_fd, dest, destlen) != (ssize_t)destlen) {
    munmap(dest, max_destlen);
    return -1;
  }
  return munmap(dest, max_destlen);
}

static int setup_loop_device(unsigned char* data, unsigned long size,
                             const char* loopname, int* loopfd_p)
{
  int err = 0, loopfd = -1;
  int memfd = syscall(__NR_memfd_create, "syzkaller", 0);
  if (memfd == -1) {
    err = errno;
    goto error;
  }
  if (puff_zlib_to_file(data, size, memfd)) {
    err = errno;
    goto error_close_memfd;
  }
  loopfd = open(loopname, O_RDWR);
  if (loopfd == -1) {
    err = errno;
    goto error_close_memfd;
  }
  if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
    if (errno != EBUSY) {
      err = errno;
      goto error_close_loop;
    }
    ioctl(loopfd, LOOP_CLR_FD, 0);
    usleep(1000);
    if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
      err = errno;
      goto error_close_loop;
    }
  }
  close(memfd);
  *loopfd_p = loopfd;
  return 0;

error_close_loop:
  close(loopfd);
error_close_memfd:
  close(memfd);
error:
  errno = err;
  return -1;
}

static long syz_mount_image(volatile long fsarg, volatile long dir,
                            volatile long flags, volatile long optsarg,
                            volatile long change_dir,
                            volatile unsigned long size, volatile long image)
{
  unsigned char* data = (unsigned char*)image;
  int res = -1, err = 0, loopfd = -1, need_loop_device = !!size;
  char* mount_opts = (char*)optsarg;
  char* target = (char*)dir;
  char* fs = (char*)fsarg;
  char* source = NULL;
  char loopname[64];
  if (need_loop_device) {
    memset(loopname, 0, sizeof(loopname));
    snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
    if (setup_loop_device(data, size, loopname, &loopfd) == -1)
      return -1;
    source = loopname;
  }
  mkdir(target, 0777);
  char opts[256];
  memset(opts, 0, sizeof(opts));
  if (strlen(mount_opts) > (sizeof(opts) - 32)) {
  }
  strncpy(opts, mount_opts, sizeof(opts) - 32);
  if (strcmp(fs, "iso9660") == 0) {
    flags |= MS_RDONLY;
  } else if (strncmp(fs, "ext", 3) == 0) {
    bool has_remount_ro = false;
    char* remount_ro_start = strstr(opts, "errors=remount-ro");
    if (remount_ro_start != NULL) {
      char after = *(remount_ro_start + strlen("errors=remount-ro"));
      char before = remount_ro_start == opts ? '\0' : *(remount_ro_start - 1);
      has_remount_ro = ((before == '\0' || before == ',') &&
                        (after == '\0' || after == ','));
    }
    if (strstr(opts, "errors=panic") || !has_remount_ro)
      strcat(opts, ",errors=continue");
  } else if (strcmp(fs, "xfs") == 0) {
    strcat(opts, ",nouuid");
  }
  res = mount(source, target, fs, flags, opts);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  res = open(target, O_RDONLY | O_DIRECTORY);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  if (change_dir) {
    res = chdir(target);
    if (res == -1) {
      err = errno;
    }
  }

error_clear_loop:
  if (need_loop_device) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
  }
  errno = err;
  return res;
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  intptr_t res = 0;
  memcpy((void*)0x200001c0, "squashfs\000", 9);
  memcpy((void*)0x20000200, "./file0\000", 8);
  memset((void*)0x20000240, 0, 1);
  memcpy(
      (void*)0x20000480,
      "\x78\x9c\xec\x92\x3d\x4f\xdb\x50\x14\x86\xdf\x6b\x3b\x1f\xad\x32\x64\xe8"
      "\xd0\x0f\xb5\x1d\x1a\x35\x69\xa3\x34\x8e\xd3\x56\xdd\xca\x04\xc9\xc2\x04"
      "\x13\x0b\x51\x62\x42\x84\xc3\x47\x6c\x89\x24\xca\x60\x06\x94\x05\x89\x89"
      "\x81\x81\x85\x48\x64\x00\xf1\x1b\x18\x58\x40\x2c\x0c\x08\x89\x91\x0c\x4c"
      "\x0c\xfc\x02\xa3\x6b\x9f\x58\x37\xfc\x05\xee\x33\xf8\xbd\xf7\xbd\xe7\x9e"
      "\x7b\xce\x91\x97\xed\x0d\x3b\x06\x20\x82\x5e\x15\x49\xf8\x30\x24\x70\xcd"
      "\x18\x34\x00\x69\x16\x78\x9e\x12\xe8\x80\xf4\x81\x74\x3f\x10\xdc\x53\xdc"
      "\x02\xf9\x7b\xa4\xed\xbb\xec\xe9\xc9\xe5\xec\xd5\x45\x39\xf7\xf3\xe8\xb3"
      "\x8a\xed\x72\xf6\xab\xe8\x7d\x31\x77\x8c\xe9\x0f\x83\xc4\x7b\x15\xf3\xe6"
      "\xf9\xa1\xdd\xe9\xae\x54\x2c\xcb\x6c\xd9\x33\x5b\x0a\x1e\xfd\xa4\xb7\x4f"
      "\xbd\x2a\x5f\x2c\xf2\x32\x3c\xcf\xe3\x5e\x0d\xc0\x3b\x00\x62\x8c\x0a\xc0"
      "\x11\x62\x3e\x6a\xc0\x27\x00\x2a\xbc\x30\x46\xf3\xdb\x03\xd2\x00\xf2\x4e"
      "\x73\x3d\x6f\x77\xba\xb9\x46\xb3\x52\x37\xeb\xe6\xaa\x61\x14\xff\xea\xbf"
      "\x75\xfd\x8f\x91\x5f\x6a\x58\xa6\x1e\x7c\x99\xf0\x04\x35\x05\xae\x3f\x00"
      "\xf0\xc9\xbd\x11\xce\x23\x00\x76\x29\xe6\x2d\xff\x4c\x21\x84\x09\xa5\xd1"
      "\x39\x13\xef\x46\x85\x69\x66\xbe\x61\x02\x65\x7c\xf7\x7f\xb0\x10\xcf\x18"
      "\xce\xc2\x1c\x31\xf2\xf8\x28\xe6\xf0\x1d\x71\x00\x9b\x2e\x13\xdc\x94\x9f"
      "\x4d\x83\xdf\x5a\x09\x0c\x2a\x6d\x0a\x9a\x50\x67\xf0\x66\xdc\x3f\xf8\x55"
      "\x5d\xb3\x6a\x7d\x30\xb0\xf1\xb5\x21\xb4\x30\x47\x61\x84\x48\xb8\x31\xc4"
      "\x4d\xf1\x9f\x3b\x2e\xb1\x4f\x9a\x22\x2d\x91\x0e\x49\x47\xa4\xe9\x17\x3f"
      "\x91\xe6\x67\x38\xa0\x5d\xc6\x05\xa2\x68\x57\x1c\xa7\x55\xe0\xc3\x0a\x56"
      "\xa1\x67\x84\x9e\x91\x74\xc5\xc1\xf1\x57\x8f\x95\xc9\xe6\x6e\x14\x48\x24"
      "\x12\x89\x44\x22\x91\x48\x24\x12\xc9\xeb\xe2\x39\x00\x00\xff\xff\x7b\x70"
      "\x81\xf0",
      416);
  syz_mount_image(/*fs=*/0x200001c0, /*dir=*/0x20000200, /*flags=*/0x3000000,
                  /*opts=*/0x20000240, /*chdir=*/1, /*size=*/0x1a0,
                  /*img=*/0x20000480);
  memcpy((void*)0x20000040, "./file1\000", 8);
  res = syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/0x20000040ul,
                /*flags=*/0ul, /*mode=*/0ul);
  if (res != -1)
    r[0] = res;
  res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
  if (res != -1)
    r[1] = res;
  syscall(__NR_sendfile, /*fdout=*/r[1], /*fdin=*/r[0], /*off=*/0ul,
          /*count=*/0x80000004ul);
  return 0;
}
<<<<


The devtmpfs boot issue:

[    0.069131][   T30] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    0.069151][   T30] CPU: 1 PID: 30 Comm: kdevtmpfs Not tainted
5.19.0-rc2-eb-corbos-standard-00014-g1bb1a07afad9 #1
[    0.069186][   T30] Hardware name: linux,dummy-virt (DT)
[    0.069198][   T30] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[    0.069237][   T30] pc : locked_inode_to_wb_and_lock_list+0x80/0x1f0
[    0.069276][   T30] lr : locked_inode_to_wb_and_lock_list+0x60/0x1f0
[    0.069308][   T30] sp : ffff80000956bc20
[    0.069318][   T30] x29: ffff80000956bc20 x28: 0000000000000000
x27: 0000000000000002
[    0.069360][   T30] x26: 0000000000000004 x25: ffff0000c0a5e0f8
x24: 0000000000000000
[    0.069401][   T30] x23: ffff0000c0a5e0f8 x22: ffff0000c0872640
x21: 0000000000000000
[    0.069442][   T30] x20: ffff0000c0a5e070 x19: ffff800008f325b0
x18: 0000000000000004
[    0.069484][   T30] x17: 64656c62616e655f x16: 7469647561206465
x15: 0000000000000001
[    0.069527][   T30] x14: ffff8000084244c0 x13: 000000000000005f
x12: ffff800008c3beb0
[    0.069569][   T30] x11: 0000000000000004 x10: ffff0000c0872640 x9
: 0000000000000007
[    0.069610][   T30] x8 : 0000000000000000 x7 : ffff0000c0872640 x6
: ffff80000827d730
[    0.069652][   T30] x5 : 0000000000000000 x4 : 0000000000000000 x3
: ffff0000c0872640
[    0.069693][   T30] x2 : 0000000000000001 x1 : ffff8001f610f000 x0
: ffff8001f610f000
[    0.069735][   T30] Call trace:
[    0.069741][   T30]  locked_inode_to_wb_and_lock_list+0x80/0x1f0
[    0.069776][   T30]  __mark_inode_dirty+0x2b8/0x3e0
[    0.069808][   T30]  simple_setattr+0x8c/0xc0
[    0.069835][   T30]  notify_change+0x7e0/0x8c0
[    0.069862][   T30]  devtmpfs_work_loop+0x1b0/0x354
[    0.069892][   T30]  devtmpfsd+0x4c/0x64
[    0.069925][   T30]  kthread+0x158/0x160
[    0.069957][   T30]  ret_from_fork+0x10/0x20
[    0.069999][   T30] Code: d2800022 aa1503e0 d538d081 8b010000 (f822001f)
[    0.070014][   T30] ---[ end trace 0000000000000000 ]---
[    0.070028][   T30] Kernel panic - not syncing: Oops: Fatal exception
[    0.070038][   T30] SMP: stopping secondary CPUs

I will try in the next few days to:
- figure out how to work around the devtmpfs issue to really get the
bisection to point to one commit and not just this range.
- look if I can rework the C reproducer to be a bit more human-readable.
- and then check if I can come up with a bug fix to address this issue.

If you need any further information concerning this crash I
encountered, just let me know.


Best regards,

Lukas

