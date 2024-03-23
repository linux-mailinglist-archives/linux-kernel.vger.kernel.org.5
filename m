Return-Path: <linux-kernel+bounces-112398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE488794A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D11C20E01
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7845029;
	Sat, 23 Mar 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhmnA+PM"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630D4502E;
	Sat, 23 Mar 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208841; cv=none; b=CxXof2ZkXziQVKtT9eAlAy2F61x12LgiPmgjjqYC0bbDtUzxNlmVbEHxDOUolahVKsYvp6YohZWMg3awIgk0DiS50kFCF1DmKlrjGEOMLGNaClPOwJSbEslsesBUjF9+K2pjikNa0QsJEt+RS9voNJlSvtpAbNB1PhEAJLgS2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208841; c=relaxed/simple;
	bh=7Z8N19JWf6+DNa1qRCJTdPGlLjz1hRqunkKvwnm32b0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TF2rYpdtXYmdQ26MfMn7epkv4WV+AySxFACfVZBtVoC0xEllZIz/45GEzTrr33vKut9ZmVZVsm1O7VaihloXrz9dZXiAFXVp58d3plVHbWCUVpzwASv8XjZsojmJhrwu2sfFOeNrk0QN/mT3GUsFoUDf9uULo3vl/9AsiOyV7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhmnA+PM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341b01dbebbso1725022f8f.0;
        Sat, 23 Mar 2024 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711208837; x=1711813637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYcdKvrH334e2k0Y2PcCA4T8trIDzqn6L6Ft1Vz/dXg=;
        b=FhmnA+PM7q7Ul8fy2PmTTd0qwBzgdrRe05WumZ7+7nFQ+TCw3LYijMtvL/7KYPohUq
         zJuJfiUbeYMy+cvtcPpUwN1UfVBXe91ssiF7WVkmOyl+z4iKS2asY/7taZtyHGl+pwqu
         MF3/NDD2JFEcjfTli6HJbdgzg0UEhx3zW5uGdqErO2d2x7vCqUsC4nlwZyqzt15ZxVA2
         UPA98rmasIKjUEtsA0EdTdWtZQ2BS6KQO6hqID/w7tb+qJAAuzlzkocfNfuKpOAcmfmL
         Arfnm1NdpLTAqRiiAGL3XAK8iNd7gRdxk7eOO/hOnOgip4zAAZipLLeAYL93nSM7VWCH
         LWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711208837; x=1711813637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYcdKvrH334e2k0Y2PcCA4T8trIDzqn6L6Ft1Vz/dXg=;
        b=rbPDPFac3lNiWFIp83TKmpRNQx+AQDa9FadqrGeNdyKkItF1ydMYsorkGTeIlrxlpg
         qdAKXjHkuy2Ounotb3wfh5WkrRzfMqWHrkXT+BvnSbQ4gzkrdN0rCPPM+FOxWowF/5yH
         ldeWCMzKqJd10NKHFgNd/EWCjEJOUZ8vGWxCe0bwwaYt5U2BN4tUjkdEh+4AHajIUnf9
         PGImEfbw5xdr1CLQ22Ca29LBnEFZL+zUmjJLuTSG/XbpmP+inLpXEEmEWFCEwajAH101
         ywDfZhxKFDaK6+IZLvT4aNjLBXqqXxEWvjf1GHs+fpYOICEnEvDWj0PZLdy1CeyEMv7R
         4MtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh+7ClKJ3C/DjbYpfuGR+BbZOnm7LxL3fbNhamjVPFckacTcKS7qGyXtzyzZoCG5VojhbNk1PQyDxn7pVfojeHMuVUdbAH4xa0juSMPPt6CxgS9085JES+ocIWwcjTe+1v
X-Gm-Message-State: AOJu0YxdY+XkqxrT2gWnEPDAXJRNUqvvxG1qfVC5jN/kHLj79EnN2Nkr
	RrCP/6acrFkQlurGza0VXIMHkMHKiDC5wWAUdPKSPhU1Kd9mBTJ1
X-Google-Smtp-Source: AGHT+IGbwZZVJIKX1KxuU36E5zIZfYcNyOZAatMQfr7PoMcqlJAB5lw+1vkR+nKkkVDw8ccVt0RLiA==
X-Received: by 2002:adf:eb88:0:b0:341:c673:f1e8 with SMTP id t8-20020adfeb88000000b00341c673f1e8mr232997wrn.9.1711208837216;
        Sat, 23 Mar 2024 08:47:17 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b004147f7f70c3sm2794298wmq.39.2024.03.23.08.47.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 08:47:16 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo instructions
Date: Sat, 23 Mar 2024 15:46:51 +0000
Message-Id: <20240323154652.54572-2-puranjay12@gmail.com>
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

Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
instructions.  They are similar to PROBE_MEM instructions with the
following differences:
- PROBE_MEM32 supports store.
- PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
  src/dst register
- PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in S11
  in the prologue). Due to bpf_arena constructions such S11 + reg +
  off16 access is guaranteed to be within arena virtual range, so no
  address check at run-time.
- S11 is a free callee-saved register, so it is used to store kern_vm_start
- PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
  LDX faults the destination register is zeroed.

To support these on riscv, we do tmp = S11 + src/dst reg and then use
tmp2 as the new src/dst register. This allows us to reuse most of the
code for normal [LDX | STX | ST].

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/net/bpf_jit.h        |   1 +
 arch/riscv/net/bpf_jit_comp64.c | 193 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |   2 +
 3 files changed, 193 insertions(+), 3 deletions(-)

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
index aac190085472..f51b832eafb6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -255,6 +255,10 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
 		store_offset -= 8;
 	}
+	if (ctx->arena_vm_start) {
+		emit_ld(RV_REG_S11, store_offset, RV_REG_SP, ctx);
+		store_offset -= 8;
+	}
 
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
@@ -548,6 +552,7 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
+#define DONT_CLEAR		16	/* RV_REG_A6 unused in BPF */
 
 bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
@@ -555,7 +560,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
 	int regs_offset = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
 
-	*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) = 0;
+	if (regs_offset != DONT_CLEAR)
+		*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) = 0;
 	regs->epc = (unsigned long)&ex->fixup - offset;
 
 	return true;
@@ -572,7 +578,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	off_t fixup_offset;
 
 	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
-	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX))
+	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
+	     BPF_MODE(insn->code) != BPF_PROBE_MEM32))
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
@@ -622,6 +629,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	ex->insn = ins_offset;
 
+	if (BPF_CLASS(insn->code) != BPF_LDX)
+		dst_reg = DONT_CLEAR;
+
 	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
 		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 	ex->type = EX_TYPE_BPF;
@@ -1063,7 +1073,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		    BPF_CLASS(insn->code) == BPF_JMP;
 	int s, e, rvoff, ret, i = insn - ctx->prog->insnsi;
 	struct bpf_prog_aux *aux = ctx->prog->aux;
-	u8 rd = -1, rs = -1, code = insn->code;
+	u8 rd = -1, rs = -1, code = insn->code, reg_arena_vm_start = RV_REG_S11;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
 
@@ -1523,6 +1533,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
+	/* LDX | PROBE_MEM32: dst = *(unsigned size *)(src + S11 + off)*/
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
 	{
 		int insn_len, insns_start;
 		bool sign_ext;
@@ -1530,6 +1545,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
 			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
 
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit_add(RV_REG_T2, rs, reg_arena_vm_start, ctx);
+			rs = RV_REG_T2;
+		}
+
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
 			if (is_12b_int(off)) {
@@ -1666,6 +1686,87 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
 		break;
 
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+	{
+		int insn_len, insns_start;
+
+		emit_add(RV_REG_T3, rd, reg_arena_vm_start, ctx);
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
+		ret = add_exception_handler(insn, ctx, rd, insn_len);
+		if (ret)
+			return ret;
+
+		break;
+	}
+
 	/* STX: *(size *)(dst + off) = src */
 	case BPF_STX | BPF_MEM | BPF_B:
 		if (is_12b_int(off)) {
@@ -1712,6 +1813,83 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
+		emit_add(RV_REG_T2, rd, reg_arena_vm_start, ctx);
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
+		ret = add_exception_handler(insn, ctx, rd, insn_len);
+		if (ret)
+			return ret;
+
+		break;
+	}
+
 	default:
 		pr_err("bpf-jit: unknown opcode %02x\n", code);
 		return -EINVAL;
@@ -1743,6 +1921,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		stack_adjust += 8;
 	if (seen_reg(RV_REG_S6, ctx))
 		stack_adjust += 8;
+	if (ctx->arena_vm_start)
+		stack_adjust += 8;
 
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
@@ -1794,6 +1974,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		emit_sd(RV_REG_SP, store_offset, RV_REG_S6, ctx);
 		store_offset -= 8;
 	}
+	if (ctx->arena_vm_start) {
+		emit_sd(RV_REG_SP, store_offset, RV_REG_S11, ctx);
+		store_offset -= 8;
+	}
 
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
@@ -1807,6 +1991,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 		emit_mv(RV_REG_TCC_SAVED, RV_REG_TCC, ctx);
 
 	ctx->stack_size = stack_adjust;
+
+	if (ctx->arena_vm_start)
+		emit_imm(RV_REG_S11, ctx->arena_vm_start, ctx);
 }
 
 void bpf_jit_build_epilogue(struct rv_jit_context *ctx)
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 6b3acac30c06..9b6696b1290a 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -50,6 +50,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	int pass = 0, prev_ninsns = 0, i;
 	struct rv_jit_data *jit_data;
 	struct rv_jit_context *ctx;
+	u64 arena_vm_start;
 
 	if (!prog->jit_requested)
 		return orig_prog;
@@ -80,6 +81,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto skip_init_ctx;
 	}
 
+	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	ctx->prog = prog;
 	ctx->offset = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
 	if (!ctx->offset) {
-- 
2.40.1


