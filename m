Return-Path: <linux-kernel+bounces-112399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54688794C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD81F21B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4F53395;
	Sat, 23 Mar 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dygyLIxz"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66B4D9ED;
	Sat, 23 Mar 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208844; cv=none; b=bwdj2Kn3uBWbe/9lotUizOedif3CqTWDf0PxRMKlO5dl/eLff6vmxctAh+bHRjm1ie+/mnqqOJI6R87UZK/eX2PedxxOzucG87r1PnX86XVxAoL0BBu401+weri+GIm7SOWyzDqgeTrCeGeWapfQLhaasZkhxT8u9eEGZo+CnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208844; c=relaxed/simple;
	bh=vN2GuPTGMANXSO4mSpjLFQl4+5b43aBZX8eDL5al/Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgpnnbRdj1f2NwIm194lPJSbsaogBI3EK2mydPPlnKTPGkBOZC/cG3oF/Ygi85OVw6jbzYObVg3L2XjKygxOhL96129pEER6hBYJKq24yAm8p/z4HuczAiJ+kAf610g+U3dpST3ktprPQqKUrq2r3qOeaxVq0g+lldATOuSV794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dygyLIxz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so39694381fa.2;
        Sat, 23 Mar 2024 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711208840; x=1711813640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay+jcBPkjGLbrzuCqBdp1fIpXDsG9gp+1V2JFol5/jQ=;
        b=dygyLIxz2CKTAlnBTfNeW7mxM8wEjm4e42Kq9xvfukmqMafajWkPZc4VXp5rzZIj4A
         ulevxSUEex9DfjuwsGyWQSa1s9dirCtarqOt65nwAQdw1oui/bfFkgCSZEodx4RTLpr8
         lZ3B87/ESaemanfKmTxwz6xlEO+m9uESovhfRr7CWDJbERuTs9dCV1meBCKZ4lee0hpF
         udHWOJig3DNYghPziMuxVojjxVi1FVtQnrG0eMnnVDXBW1EYuvo+9Ico4wDZfYrA7XEh
         5fiSRGlE5Xv2zYdoibUavg+clHrBf5x+FIfxyD7GLNWMZq2cwFwzMMbZIYNHG7EdJ7NT
         k1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711208840; x=1711813640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay+jcBPkjGLbrzuCqBdp1fIpXDsG9gp+1V2JFol5/jQ=;
        b=ji+WT1HRVxzECs0Exbgs9adkNDtJcWAjs5lwm6U//EY2e08VT4CSMmXWgULA7Qa6De
         AblijQCq3pGexPaBTMxqHW4u/kIgcWAQ/7/kHzU0G0+SUSDZSoggKJYTxPgcFWejgoRr
         5DPk/xH6nHX64ZKDXfh4S59cqWB9tB99twCj1gNSxqArtF6DqQaLaeUm1Ns++d5kUCj4
         DwETH+tUwmcuTFkL/y55JvchrzkmrfkBkq6inDk8UK5ZcNNpKErjzDOuuthuH2lko/R5
         ETDiNSHn+msvLFV8nLDENChXOKV4HavXPjdS0ANBE4JSVuVT5fuxpVBol1sKt4BJuGlc
         HHXw==
X-Forwarded-Encrypted: i=1; AJvYcCVpMA5eXuJ7NC+HWr/uZctlVmSUmhsIZfupflxIMJy2rJw8kZnePw4w5oTE92DMAHLGPShMeHPImPNv7EXmcO8YpGIZ6g8L3wyoJ6RUdBADW3CHQcLuT8WVvEJJUd9UIqh+
X-Gm-Message-State: AOJu0Yx2mPCfbCzC1AscotmQ4pZEiCESCmKHDMH/GCl24cIVrSdkeuM0
	XbBcAIdeLbe6kdjnA6R7MecOYwESNihbEYN6RhRZyKyzYFOfh7iR
X-Google-Smtp-Source: AGHT+IFkp577tDhpMqE6g4lzfPBqHjO/0IXLmRGAIlqrGpT/rmtEg6S9Fthz6rn6wJ37q+lXPaTRrQ==
X-Received: by 2002:a2e:9b8a:0:b0:2d4:9f78:4f62 with SMTP id z10-20020a2e9b8a000000b002d49f784f62mr1644660lji.0.1711208840003;
        Sat, 23 Mar 2024 08:47:20 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c339300b00414041032casm765572wmp.1.2024.03.23.08.47.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 08:47:19 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
Date: Sat, 23 Mar 2024 15:46:52 +0000
Message-Id: <20240323154652.54572-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240323154652.54572-1-puranjay12@gmail.com>
References: <20240323154652.54572-1-puranjay12@gmail.com>
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
 arch/riscv/net/bpf_jit.h        |  1 +
 arch/riscv/net/bpf_jit_comp64.c | 15 +++++++++++++++
 arch/riscv/net/bpf_jit_core.c   |  1 +
 3 files changed, 17 insertions(+)

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
index f51b832eafb6..3c389e75cb96 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1083,6 +1083,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (BPF_CLASS(insn->code) == BPF_ALU64 && insn->off == BPF_ADDR_SPACE_CAST &&
+		    insn->imm == 1U << 16) {
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
@@ -2010,3 +2020,8 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 9b6696b1290a..aaef1d0c7c46 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -82,6 +82,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx->prog = prog;
 	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (!ctx->offset) {
-- 
2.40.1


