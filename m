Return-Path: <linux-kernel+bounces-117418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DB88AB1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527F81C3D94C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971914EC63;
	Mon, 25 Mar 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6y84QBk"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965A14EC48;
	Mon, 25 Mar 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382089; cv=none; b=PIDGkPUKzYh0w7zOo/SYQv5uEAMEMzaGz0u+9mYArYuy9vdXTBtRnEMEMQ2rIfE7xjmSMLy11DIc2OuqlJYMhCG2lxd+/5o4FPj4D/BUqgOSCBdoqPAN09o+pIIUZnUgXcivZjHfk3pbmWkeqhL0bd2qDKfxCEWvSY6PqwBf2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382089; c=relaxed/simple;
	bh=VELhCbkpXwTeoCJK5f8UCZ2Pu8ss77KS0iQmHtC4trU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2zmiGseYq2bMJa9nfxIgNCfPFKtTcXLsjKBHs3BMnvhrSIOpEXThHzUMAWTdXlXDdrnIV4JkGYke4yAXze47KoinChyXKUdCn3LmHnbwkzZWyCZVW1JkxtaxDLdK3xM2OJBSdzbYE9qRMIyERWSfYZhpD6Bo/2KGPgVUZp1RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6y84QBk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so61966291fa.0;
        Mon, 25 Mar 2024 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711382086; x=1711986886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmdLkk4cUe3qGPre+9kRw6NuC0B6UnfZpAvLyG4RAn0=;
        b=m6y84QBkorqqLu3kZiqL3xrvbXWOF1+3RXVrgP6VdEdLh44h7u5/Ae3823Kq818hrx
         cJS9+lQFzQvh8P0v6FDVeMZ+jFxSDBfrAjWhKzLi0CwK4qDhUIE5AH9IIHIVeKJNE8h9
         a7a1ZsB+gIrNEz2NU7pjey/nfBzgwMlNPOGKhN8pxICV3/Umm+/iDQkdOrqkEJNizZDX
         LKnP8k3jx0WoVPAyN3p9yLA8JuuCxj6ZVqr1bF2YTyUUT4cTx2U7ZJY6EvUIoaaFvlY4
         E5aams5KfvXI0epAZyZGN9EICwxENS0behz5d3O0HZZAR/d/HhBkK703SKA5ArIsl00M
         qJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382086; x=1711986886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmdLkk4cUe3qGPre+9kRw6NuC0B6UnfZpAvLyG4RAn0=;
        b=axtqSNK80uQ6/tALaGxHBHobkyPQ8yY4l9fbddeCXhQY65NhfbC/XZM+BFzF33uBhh
         yg8qhjXA8PAsuEUj+K3CAF4shawrpFGbQ3EGliIs9DD6nB6Gu/kO7MKFq8+tuNBuh5eM
         Tcb93gt7RsvFVca59kQAaXrbqvKbpqLELGUi8xYL/n6Du3Oyh97AZ+xhT8S5HL3bygf4
         yN2dXagwDLHvJjTpiYdqZry05eG+8NWeEAr96QxOr84+TRH1F0q9NVR5qgChrKblIZCD
         FqwG/sBtEGwdAeJetlPHRCMooTxH5qiBJ7ny+eGxmUJp2GIUDIEIU4b3i3aHyqDwsQ1Q
         pk5A==
X-Forwarded-Encrypted: i=1; AJvYcCVfWs0vMmIP17XzWBoReD4lqhshStS7Qo3wJKO7fVim7Fw2oqMHV3qh7LGtb13hOOxpZjbuaIjmWq46sqZGAJdTVFVQpQIxdSSQ84zpLsWvnM94EVLtGyj2CpTIILYPGI6l
X-Gm-Message-State: AOJu0YzlXRnroRGOOQ/HDK0ftrH+viLMSi7TirMSQ2b4wIqm8iUdQa70
	/iYMLZarAnqOn7yajLMKJo4ay/mFAXUEFFOquATqePIcMDSkj1tz
X-Google-Smtp-Source: AGHT+IHqS/JWJGZaEB94ZvnBoK5Y0Df1gZZMiFmtgQ0mmI45U2iG7SDsch649N+Rl+c6Wu3LehSo6A==
X-Received: by 2002:a2e:8014:0:b0:2d6:a699:4bae with SMTP id j20-20020a2e8014000000b002d6a6994baemr4873921ljg.6.1711382085892;
        Mon, 25 Mar 2024 08:54:45 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b0041409cabb39sm8734384wmb.18.2024.03.25.08.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 08:54:45 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huaweicloud.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2 2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
Date: Mon, 25 Mar 2024 15:54:34 +0000
Message-Id: <20240325155434.65589-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325155434.65589-1-puranjay12@gmail.com>
References: <20240325155434.65589-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))). The addr_space=0 is reserved as
bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY

rY = addr_space_cast(rX, 1, 0) has to be converted by JIT.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/net/bpf_jit.h        |  1 +
 arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++++++++
 arch/riscv/net/bpf_jit_core.c   |  1 +
 3 files changed, 16 insertions(+)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 8a47da08dd9c..5fc374ed98ea 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -82,6 +82,7 @@ struct rv_jit_context {
 	unsigned long flags;
 	int stack_size;
 	u64 arena_vm_start;
+	u64 user_vm_start;
 };
 
 /* Convert from ninsns to bytes. */
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 0c0588e327af..a5f049e72da2 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1083,6 +1083,15 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn_is_cast_user(insn)) {
+			emit_mv(RV_REG_T1, rs, ctx);
+			emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
+			emit_imm(rd, (ctx->user_vm_start >> 32) << 32, ctx);
+			emit(rv_beq(RV_REG_T1, RV_REG_ZERO, 4), ctx);
+			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
+			emit_mv(rd, RV_REG_T1, ctx);
+			break;
+		}
 		if (imm == 1) {
 			/* Special mov32 for zext */
 			emit_zextw(rd, rd, ctx);
@@ -2026,3 +2035,8 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 9ab739b9f9a2..8a69d6d81e32 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -81,6 +81,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx->prog = prog;
 	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (!ctx->offset) {
-- 
2.40.1


