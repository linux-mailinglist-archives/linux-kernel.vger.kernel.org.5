Return-Path: <linux-kernel+bounces-103447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62787BF73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01A91F22009
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBE71733;
	Thu, 14 Mar 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCsnFWvA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2A71746;
	Thu, 14 Mar 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428418; cv=none; b=cI7BrjjPUZGFDlvio9/y3CAyY1NcTDOmFibxJMxOhA/Dk1VzUCUn20U/slHe7GTHJVzAyeMm8QAc9dTwvJVP3pIquQ4LV0XNi9f+a2NyRVk7jKA8O8hzJOk1deQyvS0j5PNM6bbpTCMTnocpYr/jyY3e57tatoQ7rOVdIwptWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428418; c=relaxed/simple;
	bh=iz+TloJkrWvl3/uamHD3XhGQyNmVGCiJUcAdHfkXKhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/DDy8MbPSotCaS9Vil7xvJzBJyF+agdMrtwhDza9PXTghXSCHVBghL7VT5cT2QmrxohxdjcLaJN478JfV72kqQKWr1D2P7H4CW2vSv5nIagaDofeY0b9AO7osH8Mno4H7dnzZvYQZ1WRR5Cs8i9OTEBzslsYTRnwiJfT7vcKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCsnFWvA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e8f906f3dso943795f8f.3;
        Thu, 14 Mar 2024 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710428414; x=1711033214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI3xTRdT9yHEzesZP0OmYuDOzf2tVAyENBLL8gdkx4Y=;
        b=GCsnFWvAebfQFZYl5pPzJZyQvhJHhO5yE6+r/DdYkLMcB6rH6wC5BIj2it9nSXsSSe
         FWJMxKaZQHrl24rshJ7eG6kmMFDjy6Jjk3bFzi7imIzYjZgWOt5glIeGUzfh2gDFxU7K
         yyzZtAId2x+X3NUiIsho71e8MFyh68dcjoZgHx7byERaCJRbZmcsULmlmJcFgJQILlLf
         cZH2wFqkutBAFobzzcocB/9O2t0UYmdze+aGVyjjdRFAAwHmEn1RBG9Q/TuLk8oMzI/h
         RqgMZMCte79UTi8tetNcMAIz48KbBeTO+qYpdBCdUuTkgGFsfprruKEqz2DYqv4PLuwI
         ai7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428414; x=1711033214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI3xTRdT9yHEzesZP0OmYuDOzf2tVAyENBLL8gdkx4Y=;
        b=M1iPmC8F0+fucXASknhgVJvZxxc4dKeiQ89hhagRF7ZGfk1zTr/cHxmZw343SLyId6
         a63dCemZS5Td+CRMnzi4STqsW+KEWUhCLx8e2eSXk5p1LBGQeTmH0t8WlSqjAaTCkTuU
         /1k1w3Sm8ktJToqxqb258PNR1v1kdQ0L6NC9fo7XvuY0vBcSpoltHrmwkM/FtL6YK7VK
         uSzdSjRqQuGmer13RlgL4PDgKM9iidZhtDkZFgoIdAoFqa2960VpclSyh+aLaIIuIgJL
         deJ5CRNm1puukEZzVP1riCO9/aojLGI6Gw1msL9Lz2esuSohgmH5BQX7uxJeHWjO08yY
         SiWw==
X-Forwarded-Encrypted: i=1; AJvYcCXw3r1KJn04Ar/UWuNRy05yJSlOf/X4q0Ieht1ece5OqppoyDaa6AZtU+OwVwoIgeYIVrHWfvZuZ1WsAVqZwdrAsKU3vnClVxgazSL7GPGG99fFrd7r1tY+Axt+EB/entEL
X-Gm-Message-State: AOJu0YwaFWMrtADVZ9CKHjPRm3NO18MxgMmIG4fqb7BB3WpLN7KbA5bb
	Bmhs+nSxXxS+yr9RxgntoRQ50dygdVEchS6kuDafXt3I6weufALC
X-Google-Smtp-Source: AGHT+IFBznIkyc3oqCe9wYPXFb4WuEfceV3WoHPrD4t9ibKVdpBrHvgQ5oWN9hNQqmplqq9GOc5tNA==
X-Received: by 2002:a5d:69cd:0:b0:33e:c4c3:6f with SMTP id s13-20020a5d69cd000000b0033ec4c3006fmr267664wrw.64.1710428414293;
        Thu, 14 Mar 2024 08:00:14 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bv17-20020a0560001f1100b0033e49aebafasm959125wrb.3.2024.03.14.08.00.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:00:13 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 2/2] bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
Date: Thu, 14 Mar 2024 15:00:03 +0000
Message-Id: <20240314150003.123020-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240314150003.123020-1-puranjay12@gmail.com>
References: <20240314150003.123020-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))). The addr_space=1 is reserved as
bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY

rY = addr_space_cast(rX, 1, 0) has to be converted by JIT:

Here I explain using symbolic language what the JIT is supposed to do:
We have:
	src = [src_upper32][src_lower32] // 64 bit src kernel pointer
	uvm = [uvm_upper32][uvm_lower32] // 64 bit user_vm_start

The JIT has to make the dst reg like following
	dst = [uvm_upper32][src_lower32] // if src_lower32 != 0
	dst = [00000000000][00000000000] // if src_lower32 == 0

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit.h                     |  1 +
 arch/arm64/net/bpf_jit_comp.c                | 35 ++++++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 --
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 23b1b34db088..813c3c428fde 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -238,6 +238,7 @@
 #define A64_LSLV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSLV)
 #define A64_LSRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSRV)
 #define A64_ASRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, ASRV)
+#define A64_RORV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, RORV)
 
 /* Data-processing (3 source) */
 /* Rd = Ra + Rn * Rm */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ce66c17b73a0..e12e0df3ad1a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -82,6 +82,7 @@ struct jit_ctx {
 	__le32 *ro_image;
 	u32 stack_size;
 	int fpb_offset;
+	u64 user_vm_start;
 };
 
 struct bpf_plt {
@@ -868,6 +869,34 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn->off == BPF_ADDR_SPACE_CAST &&
+		    insn->imm == 1U << 16) {
+			/* Zero out tmp2 */
+			emit(A64_EOR(1, tmp2, tmp2, tmp2), ctx);
+
+			/* Move lo_32_bits(src) to dst */
+			if (dst != src)
+				emit(A64_MOV(0, dst, src), ctx);
+
+			/* Logical shift left by 32 bits */
+			emit(A64_LSL(1, dst, dst, 32), ctx);
+
+			/* Get upper 32 bits of user_vm_start in tmp */
+			emit_a64_mov_i(0, tmp, ctx->user_vm_start >> 32, ctx);
+
+			/* dst |= up_32_bits(user_vm_start) */
+			emit(A64_ORR(1, dst, dst, tmp), ctx);
+
+			/* Rotate by 32 bits to get final result */
+			emit_a64_mov_i(0, tmp, 32, ctx);
+			emit(A64_RORV(1, dst, dst, tmp), ctx);
+
+			/* If lo_32_bits(dst) == 0, set dst = tmp2(0) */
+			emit(A64_CBZ(0, dst, 2), ctx);
+			emit(A64_MOV(1, tmp2, dst), ctx);
+			emit(A64_MOV(1, dst, tmp2), ctx);
+		break;
+		}
 		switch (insn->off) {
 		case 0:
 			emit(A64_MOV(is64, dst, src), ctx);
@@ -1690,6 +1719,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.fpb_offset = find_fpb_offset(prog);
+	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 
 	/*
 	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
@@ -2514,6 +2544,11 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index d8ade15e2789..0445ac38bc07 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,5 +10,3 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
-verifier_arena                                   # JIT does not support arena
-arena_htab                                       # JIT does not support arena
-- 
2.40.1


