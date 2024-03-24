Return-Path: <linux-kernel+bounces-112858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D73887F1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117E61C211AA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEEC1C692;
	Sun, 24 Mar 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCca9VYG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804ADDBC;
	Sun, 24 Mar 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314926; cv=none; b=k1Y2v1CRA4KEonAhOfKvGOerP1DaYeIO4Q4QDQp/mbXiWqf8c2FD3qXlYMokvbmy4DxTxhILE2yr9yfbBiZ2jgIMi217G9Dc7gBBZiztmuy9z2hIJgZ8J8PEpb5oDP/EaS0i7nUxxlVC+vPfzlXOTNFdmocELYBFxxtvqFGbb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314926; c=relaxed/simple;
	bh=Gc+g4bp4nTKPHj0XcB5KJ1uo904HG/rIbwYP2xin/Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i0xXOvQx7CNH/F1lhCo/Nb2RO7KZGOajUCZia2eApAq1lAO0NshwBkkCR5aTReh5CGbPIb24wQlUjMxPgcOTzE2Hfxh34IgW/bhaR7MXvpdiJY1dLxd80NJFX/nFb7Yj0vbTMpZDdjz9vvSDuWkpAVYdYJxuaaApGbOzAIG94FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCca9VYG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341b01dbebbso2595018f8f.0;
        Sun, 24 Mar 2024 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711314923; x=1711919723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJs/8rrZFlSm5BVLSgyDRWbw0+owUKGrLUv/BH3DuaU=;
        b=NCca9VYGGAQ7RCFYxpqOvGY/kFQY6Mo9QaeagX22r+HGYQf4MF9/AcB6LIvRyZaZxW
         aLy7UlvA4sY/l8TtxaMR1q/3vWlQ2SC0/iUCTztcvzb4SJeg3oYDz6MqOPMHGPF3yO4t
         ZWcG3oI+CezrNOT9310EAVKQvFUOhjiF7FXHMRKGiQljCW6GaHN1FQ00OFcYs3M45p/X
         JWAbs9glxv6ZLKcj1ombUDvV9SnTS7yJ47qC0Fyy0mhoIZo1jfhMDdeQqMFZZReO04bT
         cgs997/f9oiRsiZ42RsLIUiJo4FdB4PAWrxjU7KtrTnZmLxCHggv5wv3+UZoTNdk4zfe
         pidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711314923; x=1711919723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJs/8rrZFlSm5BVLSgyDRWbw0+owUKGrLUv/BH3DuaU=;
        b=HKGH40k1C4gWDJqWcIFG53bYE0bKBMiYpHcUiEO9nnhKt596sGv0IvyiGwS/BUPnHl
         hnYR/A7c4nz3ac7rbJoQx+/ASh5OFrED391j2mOd22KDLMPII+jpR4I12PfNLnMhcyIm
         2duv9QU1Udf1Xi2M26k2n7VcjPzX+ys5hw/OtR+h1cHL9KcPsmmA+YHPLLjfbXN9Tr1h
         0dl3862ktJmT42Ker2uoUZjw4sBS2scOR9DcPx45Os63OLOvnm0Y+PCxR2qsYCJkfGdA
         jpwpswspfsZ/zoDoLY9K5py/k+qzCkvE0tFkH4uvV7fjABkgv0Sya2tT1rBNbZ4Q2sfA
         Lksw==
X-Forwarded-Encrypted: i=1; AJvYcCUpGeEvkNzM+yj8dsCJT4pWDPssOUsfN/Hx/xuMDWnF+Z9bqKZAXpa0OvYKpZQWt8Ds+Xop3IRP0cy6RCniPp1hGU/UTqK66u8or5CDHJPNPJtYnTJ/bp0DP8twAjuxOCrv
X-Gm-Message-State: AOJu0Yz5+4GHMy+owJTg1y3k0L8TCP4jmvDkEnmwx+WNpUJFHWKt1Da5
	1oErsOI5D+ykJscc+BOfPyQ7sUieEaIS3K5mReM+LE54hJfVj6VJ
X-Google-Smtp-Source: AGHT+IGO+UBAljYUKl4PAtKDUE8xi/oE31T+TEtE/VSp6UjAj09qYWQSrtRtW8zw0s6szgb97QpKFA==
X-Received: by 2002:adf:e0d1:0:b0:33e:c91a:127e with SMTP id m17-20020adfe0d1000000b0033ec91a127emr4308274wri.63.1711314923080;
        Sun, 24 Mar 2024 14:15:23 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d4a09000000b00341bdecdae3sm5420388wrq.117.2024.03.24.14.15.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 14:15:22 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2 0/1] Support kCFI + BPF on arm64
Date: Sun, 24 Mar 2024 21:15:17 +0000
Message-Id: <20240324211518.93892-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V2:
V1: https://lore.kernel.org/bpf/20240227151115.4623-1-puranjay12@gmail.com/
- Rebased on latest bpf-next/master

On ARM64 with CONFIG_CFI_CLANG, CFI warnings can be triggered by running
the bpf selftests. This is because the JIT doesn't emit proper CFI prologues
for BPF programs, callbacks, and struct_ops trampolines.

Example Warning:

 CFI failure at bpf_rbtree_add_impl+0x120/0x1d4 (target: bpf_prog_fb8b097ab47d164a_less+0x0/0x98; expected type: 0x9e4709a9)
 WARNING: CPU: 0 PID: 1488 at bpf_rbtree_add_impl+0x120/0x1d4
 Modules linked in: bpf_testmod(OE) virtio_net net_failover failover aes_ce_blk aes_ce_cipher ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_mmio uio_pdrv_genirq uio dm_mod dax configfs [last unloaded: bpf_testmod(OE)]
 CPU: 0 PID: 1488 Comm: new_name Tainted: P           OE      6.8.0-rc1+ #1
 Hardware name: linux,dummy-virt (DT)
 pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : bpf_rbtree_add_impl+0x120/0x1d4
 lr : bpf_prog_234260f1d6227155_rbtree_first_and_remove+0x218/0x438
 sp : ffff80008444bb10
 x29: ffff80008444bb10 x28: ffff80008444bbf0 x27: ffff80008444bb60
 x26: 0000000000000000 x25: 0000000000000010 x24: 0000000000000008
 x23: 0000000000000001 x22: ffff00000ab71658 x21: ffff8000843dd5fc
 x20: ffff00000ab459f0 x19: ffff00000ab71358 x18: 0000000000000000
 x17: 000000009e4709a9 x16: 00000000d4202000 x15: 0000aaaadf15e420
 x14: 0000000000004007 x13: ffff800084448000 x12: 0000000000000000
 x11: dead00000000eb9f x10: ffff00000ab71370 x9 : 0000000000000000
 x8 : ffff00000ab71658 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffff00000ab71658 x0 : ffff00000ab71358
 Call trace:
  bpf_rbtree_add_impl+0x120/0x1d4
  bpf_prog_234260f1d6227155_rbtree_first_and_remove+0x218/0x438
  bpf_test_run+0x190/0x358
  bpf_prog_test_run_skb+0x354/0x460
  bpf_prog_test_run+0x128/0x164
  __sys_bpf+0x364/0x428
  __arm64_sys_bpf+0x30/0x44
  invoke_syscall+0x64/0x128
  el0_svc_common+0xb4/0xe8
  do_el0_svc+0x28/0x34
  el0_svc+0x58/0x108
  el0t_64_sync_handler+0x90/0xfc
  el0t_64_sync+0x1a8/0x1ac
 irq event stamp: 35493817
 hardirqs last  enabled at (35493816): [<ffff8000802e4268>] unit_alloc+0x110/0x1b0
 hardirqs last disabled at (35493817): [<ffff8000802ad35c>] bpf_spin_lock+0x2c/0xec
 softirqs last  enabled at (35493688): [<ffff800080275934>] bpf_ksym_add+0x164/0x184
 softirqs last disabled at (35493810): [<ffff800080cd9ac8>] local_bh_disable+0x4/0x30
 ---[ end trace 0000000000000000 ]---

This patch fixes the prologue and trampoline generation code to emit the
KCFI hash before the expected branch targets. The KCFI hashes are generated
at compile time and are unique to function prototypes. To allow the JIT to
find these hashes at runtime, the following behaviour of the compiler is used:

Two function prototypes are declared, one for BPF programs and another for callbacks:

extern unsigned int __bpf_prog_runX(const void *ctx, const struct bpf_insn *insn);
extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);

We force a reference to these external symbols:

__ADDRESSABLE(__bpf_prog_runX);
__ADDRESSABLE(__bpf_callback_fn);

This makes the compiler add the following two symbols with the hashes in
the symbol table:

00000000d9421881     0 NOTYPE  WEAK   DEFAULT  ABS __kcfi_typeid___bpf_prog_runX
000000009e4709a9     0 NOTYPE  WEAK   DEFAULT  ABS __kcfi_typeid___bpf_callback_fn

The JIT can now use the above symbols to emit the hashes in the prologues of
the programs and callbacks.

For struct_ops trampoline, the bpf_struct_ops_prepare_trampoline() function
receives a stub function that would have the hash at (function - 4). The
bpf_struct_ops_prepare_trampoline() sets `flags = BPF_TRAMP_F_INDIRECT;`
which tells prepare_trampoline() to find the hash before the stub function
and emit it in the struct_ops trampoline.

Running the selftests causes no CFI warnings:
---------------------------------------------

test_progs: Summary: 454/3613 PASSED, 62 SKIPPED, 74 FAILED
test_tag: OK (40945 tests)
test_verifier: Summary: 789 PASSED, 0 SKIPPED, 0 FAILED

ARM64 Doesn't support DYNAMIC_FTRACE_WITH_CALL_OPS when CFI_CLANG is
enabled. This causes all tests that attach fentry to kernel functions to fail.

While running the selftests, I saw some CFI warnings which were related to
static calls. Josh Poimboeuf had sent a patch series[1] last year that includes
a patch to fix this issue. Applying this patch and [1] fixes all kCFI issues.

[1] https://lore.kernel.org/all/cover.1679456900.git.jpoimboe@kernel.org/

Puranjay Mohan (1):
  arm64/cfi,bpf: Support kCFI + BPF on arm64

 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
 arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 28 +++++++++++++----
 3 files changed, 99 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

-- 
2.40.1


