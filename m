Return-Path: <linux-kernel+bounces-120100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F8988D18C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D121F67637
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F113E047;
	Tue, 26 Mar 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeFS0gWp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D913E021;
	Tue, 26 Mar 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493399; cv=none; b=IsrNMZj02X0rvgyPYzO/PH3fhiSP02fJ8Eao/0WBaVoHb0NZOtai/hjhdcDWnqOy3ednb88AtFjc3eJa9PmC/5xFEzI77OFn/FLBBBhKBLuNQ+kI6gG8xh6oecdX82/wuPQlPqSE7ELojeWafkEkUsz4I+E6T1+sRO6Dg8uXQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493399; c=relaxed/simple;
	bh=edclenFj9+SQGA7bB6RroMZmnrRMDR8575UOHB76NRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Km/XMIWA+8vWY5HVBXc0gobpuSFVmrGeipUhAJRAPE/gklLnm/4vpW3zCTNEFrVEEjtEjsTrZhPOn6ex1kuB+L0dH2WEjQNjKdIRYf7p+1txhQJby1GhGQ7Sv7VBPzl+PZKA/JE63aOS9C5XCksVus7Z1kHapCo6s15pO+r1bko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeFS0gWp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41488f9708fso18350385e9.3;
        Tue, 26 Mar 2024 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711493396; x=1712098196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqH53emhj0ZHk3SA+TnfR4YHUcLP3f6dmGi1LFi0aPE=;
        b=MeFS0gWpxC4+AGb1isFPRM6xGlDrFedTKxU5xncRAoLvFptMqlGYNBTAZZ9BvihIcB
         pEqXcD5No9uHp81CR4Ssxjx1/ax9LAn5j1lFC8icuvD0ySFKg/LwnCxVcbxhJZBtsVyF
         s8n3o2CjUXzKJwZUi5pMc1SBMTW7vNByNAyTGIxqcXF3Lbgm0zJ6WO66nvEh5qPwErEm
         lJYDD3V/0B6SJMfjiSWoHClXoZ0aEDRHWxP3CQiMGcznr9ivENp4waOao0qd1kTKnDw+
         le0tApcJFhekWYx2SVbESBSiM2Q8ZlRwuDl+61t9SyQl/aOI8PchChp9nA7KZ8y/hEOT
         GXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493396; x=1712098196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqH53emhj0ZHk3SA+TnfR4YHUcLP3f6dmGi1LFi0aPE=;
        b=OpGfz6g748hndfS7+PMHU/XJqjzGL3M1bPPeSqBZhvOeRbCA8lm0NixVDwhyfTumjH
         0hOG6F/N+v7C9iKiIOJ5I1B2mSAROSvzJGky+pZWu482C9qcp9lrOk3cadQrQzKBtYZs
         gI9W8OGEr6SVUirKnFHqibYex+MldNJqksHFR515uJZKFFdHdktUz/bcoxChsDKkrWzy
         l3DuLYu1a7gT6zwoYUZnjIvBXyrr7T3b6NPTTM0UVTlu86cnNnOCNmaWwWDofEmFOk+h
         kbPrls/Gl7ItGLiw1INYgvpQsKv1THzLYqwxbRQeQcLKbs4cOVlvvczU73z/sbjCdLHO
         84jg==
X-Forwarded-Encrypted: i=1; AJvYcCVvX0fd3iQeVhJN5imrexbSaDDFL42jvYr5gCiXpecJL3pxxnkeledmweDwd13SP/wf9fJJ9kFLHa6NesUWlu06+Nou9opwZ8eSK02abH8ZJ8LcwVsW/8z9qnWShH+K1CLr
X-Gm-Message-State: AOJu0YxginVLUW0/pistk3z56ziQwKZ0bLKQ1MCWa146hx8DiE9zNL/Y
	PJV290qm6Cf7Zqc17fk69MQKK6G1xdQgC8JJeS1HxJxqyOFx6LId
X-Google-Smtp-Source: AGHT+IGVs4tvD2hr/XRcoPDRw8wLKaUP0mLoeoIke8y8cC3QFM07b30ekxvcDnvYaAxc5yvrD5w/fg==
X-Received: by 2002:a05:600c:1906:b0:414:8065:2d25 with SMTP id j6-20020a05600c190600b0041480652d25mr600522wmq.38.1711493396244;
        Tue, 26 Mar 2024 15:49:56 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id h8-20020adffd48000000b0033e9d9f891csm13227006wrs.58.2024.03.26.15.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:49:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
Date: Tue, 26 Mar 2024 22:49:43 +0000
Message-Id: <20240326224943.86912-3-puranjay12@gmail.com>
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
index 73726f455f6b..77ea306452d4 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1081,6 +1081,15 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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


