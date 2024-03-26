Return-Path: <linux-kernel+bounces-120099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBD88D189
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4579FB2559A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446513E022;
	Tue, 26 Mar 2024 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhiQXUm/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385A13DDC5;
	Tue, 26 Mar 2024 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493396; cv=none; b=E8CUxD7DqQvm5zEDkVyFraGF4u8TmWRomGcRYyFxDonS9nvV7xp+OBTib8UPV1amJmkxhRkVNAu8xTU3fVcCmHKdW1Qz6djMfgemlCVKwWcIEJ5M1N8LN/hjlzwu9vdbMM8bBU0iQp8oaBgUeE4shvjxlEu6SDqZXb5vH0epxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493396; c=relaxed/simple;
	bh=WYo6yBOtXYvQgWRjib59OKGMELEwODQ0dVsxraCITzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxWBbPFA54ezuStBc6HZGXMcAyQQwC0vmxLYVvUVj91t47rEyWY8DHwWd4jdKSxQtMhiWA+stZd69w582gF0AgMPzi0FB2SGzEdmz3JkUjwQQ3ix9cWEdTvjM4Nwgb2ADyZugQ/bbtgUqXPg8/RTUHnmbr2v3Nu8ufZKS8fLsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhiQXUm/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c607f31so11539295e9.0;
        Tue, 26 Mar 2024 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711493393; x=1712098193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3weLF5Sb4Q+wabt4jeLMZ+5PbEmTvipwFWAfKQdv08Y=;
        b=MhiQXUm/NRBKAk7BJHntGqOKWs/ATWyionvHfv3RkSa8OOEBv8E9UIdkaqvUfQPHWM
         OZRkRb99QLjYQWosVwNQjvbP2PNSo0lfMrXm5QIjAWwejmvH100P5Q4vxXdoC5QIL9qn
         xDdBtm7eiST2VwRegZ7bWtJt1GMsh/XpIaBi2PGDOtjrTl3MUKeRAUC+oJMuz4Khn39p
         QKX6cdbeeScAedJWu+oMqquS/e8o/kUQmCxMcV/ocwoSkO2FAm9El4y0U0mARqvESEOz
         9yOWZTzMgxkrPzyRwAH3VxhjmFD8EGiZIbXCCX/2SEhyf0JSHQFvqp6RQRraV8ZEtJbT
         wVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493393; x=1712098193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3weLF5Sb4Q+wabt4jeLMZ+5PbEmTvipwFWAfKQdv08Y=;
        b=JSFN/w8SmwalkHqP9Aapen2Gv+tInSS1Gu2g5z7mR/LWB0/a0E75/UnKO/4e8igtY+
         GFGnzxQvv8huLU1IefMW8ttEHZRnaj0lUlgvVU6hSCrjuvNPy5Q84rFkNYN8LCEtO36H
         nipEn0nXG2UDH/dGNKTh+8a0iKQ+kBKxr7wXelgF5w3iRtpsqmH1KCVmUR9g6aWpvDMG
         HPAoMgU1ptIpBxunu9kpnh+GpfUBrBkcwgavqQgbJH+38wPZnNAbBxPHgZ/hWXzbSFZR
         g3UWreQm+6Tcg6kBbemtXlMAuqon4rCCeYB4UwahYrwcKuKEm05Q5Se9OzqrQe0wYP7p
         1mcw==
X-Forwarded-Encrypted: i=1; AJvYcCW4xmVnfbXZns166iM4WV0GEpBVUlmF0DtFi9jxHL0YA3Gtkyy65LmdqbzOgax3rf1FvZ9Ynut0psXIAePTnw+1DcGTRn+Kghs6VeGOelRvYmKvEhfn5WoMwNQT8ZGXDi3u
X-Gm-Message-State: AOJu0YxFnM7Abrt/ogXb/tBt00nxp411pyMP4ie7xcPLxcKL3p31mMCf
	QTDmqFqp9JgmRW9oQKFh6Pf3ijykZK44Yt1StOUODjNtgCzYZnnO
X-Google-Smtp-Source: AGHT+IHY2MD/5lLxuBrdt7RmNwMvPSJPfX0Tti7xaEtjfoQn/pbGBF2q3vfkAPi4LCQp8JwSSBI1wg==
X-Received: by 2002:a05:600c:45c8:b0:414:87f7:a77 with SMTP id s8-20020a05600c45c800b0041487f70a77mr6784341wmo.8.1711493393020;
        Tue, 26 Mar 2024 15:49:53 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bg34-20020a05600c3ca200b004148cd4d484sm290530wmb.9.2024.03.26.15.49.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:49:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo instructions
Date: Tue, 26 Mar 2024 22:49:42 +0000
Message-Id: <20240326224943.86912-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240326224943.86912-1-puranjay12@gmail.com>
References: <20240326224943.86912-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
instructions.  They are similar to PROBE_MEM instructions with the
following differences:
- PROBE_MEM32 supports store.
- PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
  src/dst register
- PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in S7
  in the prologue). Due to bpf_arena constructions such S7 + reg +
  off16 access is guaranteed to be within arena virtual range, so no
  address check at run-time.
- S11 is a free callee-saved register, so it is used to store kern_vm_start
- PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
  LDX faults the destination register is zeroed.

To support these on riscv, we do tmp = S7 + src/dst reg and then use
tmp2 as the new src/dst register. This allows us to reuse most of the
code for normal [LDX | STX | ST].

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/net/bpf_jit.h        |   1 +
 arch/riscv/net/bpf_jit_comp64.c | 191 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |   1 +
 3 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index f4b6b3b9edda..8a47da08dd9c 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -81,6 +81,7 @@ struct rv_jit_context {
 	int nexentries;
 	unsigned long flags;
 	int stack_size;
+	u64 arena_vm_start;
 };
 
 /* Convert from ninsns to bytes. */
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 1adf2f39ce59..73726f455f6b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -18,6 +18,7 @@
 
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
+#define RV_REG_ARENA RV_REG_S7 /* For storing arena_vm_start */
 
 static const int regmap[] = {
 	[BPF_REG_0] =	RV_REG_A5,
@@ -255,6 +256,10 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
 		store_offset -= 8;
 	}
+	if (ctx->arena_vm_start) {
+		emit_ld(RV_REG_ARENA, store_offset, RV_REG_SP, ctx);
+		store_offset -= 8;
+	}
 
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
@@ -548,6 +553,7 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
+#define REG_DONT_CLEAR_MARKER	0	/* RV_REG_ZERO unused in pt_regmap */
 
 bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
@@ -555,7 +561,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
 	int regs_offset = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
 
-	*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) = 0;
+	if (regs_offset != REG_DONT_CLEAR_MARKER)
+		*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) = 0;
 	regs->epc = (unsigned long)&ex->fixup - offset;
 
 	return true;
@@ -572,7 +579,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	off_t fixup_offset;
 
 	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
-	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX))
+	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
+	     BPF_MODE(insn->code) != BPF_PROBE_MEM32))
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
@@ -1539,6 +1547,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
+	/* LDX | PROBE_MEM32: dst = *(unsigned size *)(src + S7 + off)*/
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
 	{
 		int insn_len, insns_start;
 		bool sign_ext;
@@ -1546,6 +1559,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
 			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
 
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit_add(RV_REG_T2, rs, RV_REG_ARENA, ctx);
+			rs = RV_REG_T2;
+		}
+
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
 			if (is_12b_int(off)) {
@@ -1682,6 +1700,88 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
 		break;
 
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+	{
+		int insn_len, insns_start;
+
+		emit_add(RV_REG_T3, rd, RV_REG_ARENA, ctx);
+		rd = RV_REG_T3;
+
+		/* Load imm to a register then store it */
+		emit_imm(RV_REG_T1, imm, ctx);
+
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit(rv_sb(rd, off, RV_REG_T1), ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T2, off, ctx);
+			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
+			insn_len = ctx->ninsns - insns_start;
+
+			break;
+
+		case BPF_H:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit(rv_sh(rd, off, RV_REG_T1), ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T2, off, ctx);
+			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit(rv_sh(RV_REG_T2, 0, RV_REG_T1), ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		case BPF_W:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit_sw(rd, off, RV_REG_T1, ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T2, off, ctx);
+			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit_sw(RV_REG_T2, 0, RV_REG_T1, ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		case BPF_DW:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit_sd(rd, off, RV_REG_T1, ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T2, off, ctx);
+			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		}
+
+		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER,
+					    insn_len);
+		if (ret)
+			return ret;
+
+		break;
+	}
+
 	/* STX: *(size *)(dst + off) = src */
 	case BPF_STX | BPF_MEM | BPF_B:
 		if (is_12b_int(off)) {
@@ -1728,6 +1828,84 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_atomic(rd, rs, off, imm,
 			    BPF_SIZE(code) == BPF_DW, ctx);
 		break;
+
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
+	{
+		int insn_len, insns_start;
+
+		emit_add(RV_REG_T2, rd, RV_REG_ARENA, ctx);
+		rd = RV_REG_T2;
+
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit(rv_sb(rd, off, rs), ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T1, off, ctx);
+			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit(rv_sb(RV_REG_T1, 0, rs), ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		case BPF_H:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit(rv_sh(rd, off, rs), ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T1, off, ctx);
+			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit(rv_sh(RV_REG_T1, 0, rs), ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		case BPF_W:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit_sw(rd, off, rs, ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T1, off, ctx);
+			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit_sw(RV_REG_T1, 0, rs, ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		case BPF_DW:
+			if (is_12b_int(off)) {
+				insns_start = ctx->ninsns;
+				emit_sd(rd, off, rs, ctx);
+				insn_len = ctx->ninsns - insns_start;
+				break;
+			}
+
+			emit_imm(RV_REG_T1, off, ctx);
+			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+			insns_start = ctx->ninsns;
+			emit_sd(RV_REG_T1, 0, rs, ctx);
+			insn_len = ctx->ninsns - insns_start;
+			break;
+		}
+
+		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER,
+					    insn_len);
+		if (ret)
+			return ret;
+
+		break;
+	}
+
 	default:
 		pr_err("bpf-jit: unknown opcode %02x\n", code);
 		return -EINVAL;
@@ -1759,6 +1937,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		stack_adjust += 8;
 	if (seen_reg(RV_REG_S6, ctx))
 		stack_adjust += 8;
+	if (ctx->arena_vm_start)
+		stack_adjust += 8;
 
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
@@ -1810,6 +1990,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		emit_sd(RV_REG_SP, store_offset, RV_REG_S6, ctx);
 		store_offset -= 8;
 	}
+	if (ctx->arena_vm_start) {
+		emit_sd(RV_REG_SP, store_offset, RV_REG_ARENA, ctx);
+		store_offset -= 8;
+	}
 
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
@@ -1823,6 +2007,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		emit_mv(RV_REG_TCC_SAVED, RV_REG_TCC, ctx);
 
 	ctx->stack_size = stack_adjust;
+
+	if (ctx->arena_vm_start)
+		emit_imm(RV_REG_ARENA, ctx->arena_vm_start, ctx);
 }
 
 void bpf_jit_build_epilogue(struct rv_jit_context *ctx)
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 6b3acac30c06..9ab739b9f9a2 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -80,6 +80,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto skip_init_ctx;
 	}
 
+	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx->prog = prog;
 	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (!ctx->offset) {
-- 
2.40.1


