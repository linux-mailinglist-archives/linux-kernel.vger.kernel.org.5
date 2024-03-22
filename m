Return-Path: <linux-kernel+bounces-111631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F19886EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2DE28357F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987D48781;
	Fri, 22 Mar 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f45hVtJO"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9B481B3;
	Fri, 22 Mar 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118317; cv=none; b=X8BEoDv5xMo14Z9roH4R+0Re4id1IQfu7t3m/hNiWc+6oNcHgs4rk8t71bpS8yzN+jpXwUeJgvttuQtbqsNkCviTVraB/1br+XhWHxgl5xR2p7pv9Wv8vkI73so0gU9/HcWu0HTH494LaTa50obq18bKa+MG8p/Jcu5VodTDmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118317; c=relaxed/simple;
	bh=UYu09zXduUkm+JBpN/Y+TghaNpL7q3wgNHbep29sdA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CiL8138RHZbT8H8ae6xqmLR4u2w4AT3HNN1NnpXVaH5vG18BH3WynCQrbPJiJJ1XOEUwpLon2KgAi+/30FM/1bOcinOYA//rwUqCewbx7t4JugRO7440pMDP842P7kHMqw3n+/dfIG7nvaHxZUPOjTAZ2iuxSD15w7h6cy6a24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f45hVtJO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4146fe16a1aso16852595e9.1;
        Fri, 22 Mar 2024 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118314; x=1711723114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKzLRPLFfDKfGP0XYZGykBAFy/DE3UMNbmNAv4XV4p4=;
        b=f45hVtJOtasi0EsOcMms1/CobVX6nLF+YQGdp3uo0qx8jobCzzeix8WOfG8NNS0eHa
         H0ojapfFQpogIiqjdP1nyyoApJfxABMWYVOsReqHcCLbOTw8HtOH77pVH3H5/nja17ld
         udpGSqGz7K3oAvc3+lAJl7VK0qAUrc8lkEKrNA0ZXmdXiYyAluD0+ZNQxvWdPBTS0kyA
         aNfam1L/jPLsEL4uoKD0odWWwer/Cu4RRJQaCEZNkBNz1Q2TAkDi+01P6k7NtTULi+Id
         25nW8ZMQCcL+JOagRlmq7o6ez5xpW8nQ2EXBlUd6rYHuprpisq7u5JDegOJIoDs13NYl
         rsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118314; x=1711723114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKzLRPLFfDKfGP0XYZGykBAFy/DE3UMNbmNAv4XV4p4=;
        b=XWbWEnTaEvlW35ufaczgx9ZCKUosTd1Li+kLAxUUGMP8R/mE3g/Yr14zndBMnO9u2q
         FWSdOoRUlbxbxVh231oh/H50HgYPRSqgaObgc6Tbb4prj92CfM5ky7CNjEOESxSSKcB5
         b7U4PF9o7CMsTqEfPJZcWbt22wx9kyKhjRpkqJDMxN/DZHYRGIfN/yGFGr7blE+HEOWo
         bfz5FF7BDF1iycmpybCnzN9//woLaaIOCRuh7MkzeU6PJl3p+zPlBbmQ31nfdQ3SJjKV
         VSxJp7wHUnCn+dbs3sTc4tfxMVZpaFkdnztlrnsE7RjzC29/LC0S1nPmMcdXnLf5sDsO
         +Liw==
X-Forwarded-Encrypted: i=1; AJvYcCVwcjMnOfj1F1KrStD595j04HJKaEEbqAy0xVVdBX9scb/WH6OoxtjV/oAGJH5GFfZofyox1OEyicsX0inrf2CLCfPWLONl3Al7YetaXtz/Z+DoFsdVAzorwRYRlhaJelgJ
X-Gm-Message-State: AOJu0YyqUlHzCUNUnlzBongW1aMzEWOZx4TTtnwy3ScoTB6b2rKm+QLF
	OyVTM0AHmR4F7M82Os5t3XS8wlgLJaJ10PcdMYxTzPk0wCxDYjEK
X-Google-Smtp-Source: AGHT+IGzQogvPhukuBYoDN9FrU8Da6oUbBGenCI8NWXeIhXKSt0arOEE+DvWr59JKV87Diz2jxEZRg==
X-Received: by 2002:a05:600c:1546:b0:414:71b2:73c4 with SMTP id f6-20020a05600c154600b0041471b273c4mr1811485wmg.12.1711118314000;
        Fri, 22 Mar 2024 07:38:34 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00414674a1a40sm3244029wmb.45.2024.03.22.07.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 07:38:33 -0700 (PDT)
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
	linux-riscv@lists.infradead.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] bpf: verifier: fix NULL pointer dereference in do_misc_fixups()
Date: Fri, 22 Mar 2024 14:38:29 +0000
Message-Id: <20240322143829.40808-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addr_space_cast instruction is convered to a normal 32 bit mov by the
verifier if the cast from as(0) to as(1) or if the user has set the flag
BPF_F_NO_USER_CONV in the arena.

If the BPF program doesn't have an associated arena
env->prog->aux->arena is NULL and the verifier currently doesn't check
for it being NULL before accessing map_flags. This can cause a NULL
pointer dereference:

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

Add a check for NULL pointer before checking map_flags.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/bpf/CABOYnLz09O1+2gGVJuCxd_24a-7UueXzV-Ff+Fr+h5EKFDiYCQ@mail.gmail.com/
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca6cacf7b42f..78945e7b856d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19607,7 +19607,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt;) {
 		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
 			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
-			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
+			    (env->prog->aux->arena &&
+			     (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV))) {
 				/* convert to 32-bit mov that clears upper 32-bit */
 				insn->code = BPF_ALU | BPF_MOV | BPF_X;
 				/* clear off, so it's a normal 'wX = wY' from JIT pov */
-- 
2.40.1


