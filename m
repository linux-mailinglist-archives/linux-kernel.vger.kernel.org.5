Return-Path: <linux-kernel+bounces-111705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61FD886FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC0A282949
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15053390;
	Fri, 22 Mar 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwf/1TxW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AE74CE13;
	Fri, 22 Mar 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121727; cv=none; b=QcHePE7YsVFI7al9u1AfnTwbN6r8d1nKrR1huyqjGdFzHOs4i6RFMPBBIQfi6RiojcZ0Z0hQHaYTJ5DxJPHpWBmAbIeRUNlLz9R/GkCmNgsB0Ie94nOWtcS8EFzWBfLgQncuqiMm9YgDDwOdTNkdbDURQLOkAdTvBS0RZ1Ye720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121727; c=relaxed/simple;
	bh=02j24gEqA+EZmEVwAp4heMwAZitLAHaWVd6m6M01xKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WYnXLLfMOtj0//eF+LgfyJcLq+sHAu+VUIckerz1j8fZOvsnFWKPG0a7Lnz17IfAesbP6UH1sCS7eeacec3CHC0CeLzWaW/PWjb6BJEMxyUctuf+vmCx6kaLYgI7QrdPHeL0q/YBEQZ4TyDoPzsBVmpWwmHzUHy8wwjKJAnEVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwf/1TxW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4147e135f4dso3812835e9.2;
        Fri, 22 Mar 2024 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711121724; x=1711726524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2r+Sc0zL+nf1gEPeJNoGBVBB9OnWPPwrmsFxPbOcOs=;
        b=Nwf/1TxWT4KsEXY44PMG5UDee7Jb9a2p1xtYzYtmsLRZ8wd3yV1jjzfUT78lX2G+uT
         g78NBS2vyz/fzH7vkHCNfnIm2NEMnFVWhRdZAMtAUad7dfBC+U7vQIAhhTUUFakD7zd+
         B9eP8sjyM6FA1bjTb3JP5RF5hIXFx6tk69QoT3TSizKVQHQBFgOmVW+ljq5E6Kn1lzAm
         IQwD6z5p57kmVXcSSGoEM1ty9aU/RBMjXclZ68uijsQfqS/IfGh6slMDsxzl+EsDwAwo
         qgGRnk0O8qZ5V+vr74K5Tuusr8MM0KhmE/b8KdLQOe3tkBN+ZKhHhQUhhSewppP7yJGx
         8/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711121724; x=1711726524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2r+Sc0zL+nf1gEPeJNoGBVBB9OnWPPwrmsFxPbOcOs=;
        b=bbXIIMFH3Y3KLvK882gT9KqjhOCVvbvyOqJu4p+ddTBhWn6W7Ye05h3mE0i/zNHwf0
         DCz5sdF+qxzMp05sJSLLB0SuCND91uWSDiGkGxqZuvGXD2uKSwyE0OkzFrm+31bZCRR/
         KUVu1tLnEhVzOaLoLOHaLZoH41CgjbTwxXVEX8D2cVYAHNn1cAZRoz49hbziLiNOs2r5
         JvWf5jJJYxB2sjkozy+prmnIqykIeFyr13JMG50BDCoOg9wKfy6eVLOry7EcZ9u8IwKK
         SjUtWunKhfJgaL8l8+H8W5bwlTRD0nvSSSEISsEgB8fFRZjFn1UVhivfWW2KuGaXdu5A
         DoNg==
X-Forwarded-Encrypted: i=1; AJvYcCVMcE4jqIzMNimGMDSeKTBLXaRa88zrRgbE9nzKPhAqlSXYgycQrPVq4HwhggGYnWEFVtTRA7gPXYtrOdUAt85aEf2yv+pFBzCnH3k1LP+q06UJDrPKOJbgDtp0kgYEIYXu
X-Gm-Message-State: AOJu0YwegOSH+Ed55n8cwNDsTRmX+tk3dnfbNoKOJHE1npFLtCDFAgvE
	35DDP2dXGD/o65LIH7CeEczVFEeSaMvRdNixmjPVHfS4U+Xf0cBe
X-Google-Smtp-Source: AGHT+IH5r7ZjLfQkFRP6jpsoZPsttvkM4rwwQd8yGePSGbgBCVvxMXcPVOeG74OU0p9PqgPr/d9GtQ==
X-Received: by 2002:a05:600c:21d9:b0:414:f81:e512 with SMTP id x25-20020a05600c21d900b004140f81e512mr1722162wmj.19.1711121724010;
        Fri, 22 Mar 2024 08:35:24 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id s17-20020adfa291000000b00341b7388dafsm1573716wra.77.2024.03.22.08.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 08:35:22 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf v2] bpf: verifier: reject addr_space_cast insn without arena
Date: Fri, 22 Mar 2024 15:35:18 +0000
Message-Id: <20240322153518.11555-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier allows using the addr_space_cast instruction in a program
that doesn't have an associated arena. This was caught in the form an
invalid memory access in do_misc_fixups() when while converting
addr_space_cast to a normal 32-bit mov, env->prog->aux->arena was
dereferenced to check for BPF_F_NO_USER_CONV flag.

Reject programs that include the addr_space_cast instruction but don't
have an associated arena.

root@rv-tester:~# ./reproducer
 Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000030
 Oops [#1]
 Modules linked in: sch_fq_codel drm fuse i2c_core drm_panel_orientation_quirks backlight configfs ip_tables x_tables
 CPU: 2 PID: 265 Comm: reproducer Not tainted 6.8.0 #3
 Hardware name: riscv-virtio,qemu (DT)
 epc : do_misc_fixups+0x43c/0x1168
  ra : bpf_check+0xda8/0x22b6
 epc : ffffffff8017eeaa ra : ffffffff801936d6 sp : ff200000011bb890
  gp : ffffffff82293468 tp : ff60000084fcb840 t0 : ff60000084e38048
  t1 : 0000000000000048 t2 : ff5fffff80000000 s0 : ff200000011bba60
  s1 : ff2000000101d058 a0 : ff6000008b980000 a1 : 0000000000000004
  a2 : 00000000000000e1 a3 : 0000000000000001 a4 : 0000000000010000
  a5 : 0000000000000000 a6 : 0000000000000001 a7 : ff2000000101d000
  s2 : 0000000000000002 s3 : 0000000000000000 s4 : 0000000000000000
  s5 : 0000000000000002 s6 : 0000000000000000 s7 : ff6000008b980aa0
  s8 : 0000000000010005 s9 : 0000000000000004 s10: ff6000008b980000
  s11: 0000000000000000 t3 : 0000000000002000 t4 : 0000ff0000000000
  t5 : 00ff000000000000 t6 : ff20000000000000
 status: 0000000200000120 badaddr: 0000000000000030 cause: 000000000000000d
 [<ffffffff8017eeaa>] do_misc_fixups+0x43c/0x1168
 [<ffffffff801936d6>] bpf_check+0xda8/0x22b6
 [<ffffffff80174b32>] bpf_prog_load+0x486/0x8dc
 [<ffffffff80176566>] __sys_bpf+0xbd8/0x214e
 [<ffffffff80177d14>] __riscv_sys_bpf+0x22/0x2a
 [<ffffffff80d2493a>] do_trap_ecall_u+0x102/0x17c
 [<ffffffff80d3048c>] ret_from_exception+0x0/0x64
 Code: b345 9783 0024 4685 8b63 16d7 3783 008d 7f9c 7fdc (5b9c) 83c9
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/bpf/CABOYnLz09O1+2gGVJuCxd_24a-7UueXzV-Ff+Fr+h5EKFDiYCQ@mail.gmail.com/
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
Changes in V2:
V1: https://lore.kernel.org/bpf/20240322143829.40808-1-puranjay12@gmail.com/
- Reject programs that have the addr_space_cast instruction without an
  arena rather than checking for a NULL pointer in do_misc_fixups.
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca6cacf7b42f..7d0bbee10d71 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14014,6 +14014,10 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					verbose(env, "addr_space_cast insn can only convert between address space 1 and 0\n");
 					return -EINVAL;
 				}
+				if (!env->prog->aux->arena) {
+					verbose(env, "addr_space_cast insn can only be used in a program that has an associated arena\n");
+					return -EINVAL;
+				}
 			} else {
 				if ((insn->off != 0 && insn->off != 8 && insn->off != 16 &&
 				     insn->off != 32) || insn->imm) {
-- 
2.40.1


