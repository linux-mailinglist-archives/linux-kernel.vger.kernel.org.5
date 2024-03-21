Return-Path: <linux-kernel+bounces-110252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5194885C21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2496CB2797B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829F1272D5;
	Thu, 21 Mar 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHfsJuwf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06D1272C8;
	Thu, 21 Mar 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035083; cv=none; b=eQCRt3tNU+0uIcxJclKd0YkNQrdCjn3uSBxYn/y3ZVPgjHdlUQfE6JGjNRjBjO3tbPPk8oYthyBxuotS+kfN9661XeoSdCWJMm3Iz3g6LlKP8pxpiTBQpK2DkJjhgho1+CWEm+kuDJAyT7kA2JEf231M8+UthLWbGsCEv4qt0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035083; c=relaxed/simple;
	bh=2rGdoqF668uYepxfQWZoyOzDGjqm7xw/5DNbv/hg+Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2xPvT2Jkp+0ciOEXaM6u8xUOXUzZu8y5PN43+Yz3oQ9zZauH08wFDCOOr6ospgeuK2nXKmrr0Jc8vp73+mV4sW6ggaXe65jjdO8EZmUsV1Mk77pPp9UuUpv1JUTEtIzJFF2HBdzdU6Al6TfJyxinyqlfGV0Z4MLF9DKYd9BYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHfsJuwf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41400a9844aso13101725e9.0;
        Thu, 21 Mar 2024 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035080; x=1711639880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87dUkmKfEXDjEMcYMn2ZOdwscW6wYiLZbdIrm3D7rAA=;
        b=VHfsJuwfriFYg2deCaP/LIoq+nUiyMI4osmh32V+Xh1s90LahfxLFP/WpwnJP9O3Hj
         1+CR/UrJZ4AQy6WK5U/fu19t0BZP6k8/t0l2YmjnMsj+yQww4Sjk62mScXPvNuI3wpC9
         HoRgeMwoz2GWd1nMozf3HePycdmAAKMUqS8kiC5+b5aRZ6kuS2A9fnbCHlzIjH3CrGX5
         VGqrRJc176YAoti8PVP1e/4/Lxf4WZsBEpBtaQXuVzVcrC7MtPWOokhvbmTYx16pza3g
         +miB3R/sKFimm8DxSIub9dfD6HcK/SEOxSYyxlqcGHsfjp/VFj2/TCcL+Fgs07qX5eNJ
         99NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035080; x=1711639880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87dUkmKfEXDjEMcYMn2ZOdwscW6wYiLZbdIrm3D7rAA=;
        b=hv7CMUxl5RIiyqCNV1flchmBXulkvhld4gq1f9funt0YKrtJKvTnzJ0e/8ibj/w9hK
         +GEDkZw8y2GzLfbdbzyzF5qJiWf5LhIQk5p+lirS+jo19uylBAOB9vC8Tgxz5+sdU3Gd
         1GzqNmA2se9pSDJGl/vVwipHiAZVuGZ9XjArVdSs+RmS6LJzG+uSSHZmfPiGufIj9V1+
         cOFQVyFJpKmp5grHLGjJGORn1SY+JWOlt2RaAG/aMC1ZaRL8y+c91YpvcwOzQlvrcI6v
         J8ibWGSmVoPz7yyHoH6fT6o+Yzf3VX997Bm6NSMkwUDNcEmS29by5yoYHUliRk8yUvrd
         NDqA==
X-Forwarded-Encrypted: i=1; AJvYcCXaoBibSRFw4kAgzcNwFX1m6kkQ3nJqObLz7HEpDzvnGDOEEW0yZlCxSyGGwsHphOZpwE3lFTUrJQfl2t6znX86xY9NlVIjDZndvt47/SqhMGNcgqNT6JlVv9ylI49ceYYe
X-Gm-Message-State: AOJu0Yyf2LTNb9uO/IHrJmMJpD/5K5EUZrOO7R2mlGMlSRffucoqkI/u
	bc7s6SbvAFjursjO0MtXh5g/NTJaTKkmMeIQnzT5IERXPCjZCL6w
X-Google-Smtp-Source: AGHT+IFKN9ZMnfDwuZUhBCnOwG9Guarjn8pvcsN3avqjkyzJhQmvidufLPMIMN86rLtmk//waPC+sA==
X-Received: by 2002:a05:600c:3ca2:b0:414:76df:41d6 with SMTP id bg34-20020a05600c3ca200b0041476df41d6mr1375195wmb.13.1711035080104;
        Thu, 21 Mar 2024 08:31:20 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id fs7-20020a05600c3f8700b0041465c859d0sm79769wmb.39.2024.03.21.08.31.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 08:31:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
Date: Thu, 21 Mar 2024 15:31:02 +0000
Message-Id: <20240321153102.103832-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240321153102.103832-1-puranjay12@gmail.com>
References: <20240321153102.103832-1-puranjay12@gmail.com>
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
index b9b5febe64f0..37c94ebd06b2 100644
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
@@ -2511,6 +2541,11 @@ bool bpf_jit_supports_exceptions(void)
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


