Return-Path: <linux-kernel+bounces-131321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B65898645
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E749B23E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AD85C46;
	Thu,  4 Apr 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTQ26wwJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B184D08;
	Thu,  4 Apr 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230969; cv=none; b=jllyi0b3yZ9du1lfKmqFtHgJbNJYrxhoYwDUByqe1yI4vbof4WvvX464GC2J7qRf6UO/9GKnaTTZDrJhRnGN+JSAE9cxsjZmu5LGmTMUoPKCdmoqIQtl90wOkqiHzCdDhb8OzsFbsDa7ETkEFQ1yq9C7XQql/Mo4/2WxAmbrFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230969; c=relaxed/simple;
	bh=IRwP1bIOa6/Vo2QURHfCbInT78OI5Paj2irvPCNbJA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNpZe6C7f++d+DiuaGNB6CMVtWlCZtHqlG6bSd9RiVG6MXsxx6DgxRNCAVE27ck3kUYCtzzu5ePM6D215NeRXLbKCy/FhK3QPjAg/HnDruMEZ4iFIqn1U6Ct8gf7qRFvpSSe5SluPEhk4f9ptMZ2tHd+zU3lusdln5y/fyjDI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTQ26wwJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4156c4fe401so5841955e9.1;
        Thu, 04 Apr 2024 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712230965; x=1712835765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBpxRZ3MJIcd7NAv7MGq7cr29bRjoQSHr/33JsmvHrE=;
        b=KTQ26wwJOs5gR0rzxi9rlX4Sjc+rQctGsjJb30i8ZI6fGTs/4qL+JDXM9JxQyv+RjA
         GH0nGwCJq/U+q3otTYoyDeNlXWoWQmj4bpqO4TTJgouI4fL2X/3m/tMedq6Q0ajmUjNp
         rVvN2lh9DKgMB9Al2+OfnW0/XY8bU9qWO7XnIvmfN1pwXcTbpXBHaJ5O88o/w4+pt+IO
         yGoaOIM29HmByxSidGhrmktg0uYR3fSwUN3k5p/5cBAblFGedCedalzEz04U9Q6X6GKb
         +PfqiKokCJXWsOsXkAksbz88GQWnXk/g60Dzf1nG54XhgmH7q8Ls6Vh6WFa77/4FnnEm
         v1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230965; x=1712835765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBpxRZ3MJIcd7NAv7MGq7cr29bRjoQSHr/33JsmvHrE=;
        b=aJRag1jUvzDALg18c/Sgg4obg4lBzVgYlHA0nxtlzUXfOy8FN3WYgh298UmiH7UShn
         IaTbS53rBgDLr4doSpzBflHnUmZsTjQveSZJY/2EJDgK4qRrCahE0uKrUPww4G+ol/wM
         9YyXQp3ROv/gpDGOxTizLxj7HPT23xMv2dN/NfT726UoexyoJ979XnV9dzA3xO3Y+n/3
         Y5DdEDdQTDFMgP9qttsG5Fj4klJdMj5o13AbzLYNfS8PSmWy4dcrmHWz6VoVpnl+pKkm
         J1IkvX5G+QwQmtsHo3OjsfD/u7cYRjs9U7uE9i0EMbUKrvIhEPDzMxLNpTdpv2HKuFLF
         zH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwKT2j5rLd60KWAUHNTYAjDciIBkiTcaW3K+S/lf2NdEdTwMgkFdZTv7AvW6XUTgFSQ0qpPN4BSjW60MZNFgqtN0u6dZpDKP7MRbk2RJPhi74Z3omdQeMKHRfr8XmSgl5c
X-Gm-Message-State: AOJu0YxAXo5ZEY99189t0+TL4BYqNcWYtNgbMCbn/pMnhx/xZX5MW5Gb
	w8+kAZf5uGpw4JlQESMyICksE3w2dCh+DXl7ITkW679w77pSlQXo
X-Google-Smtp-Source: AGHT+IFAPWMxNe4GVfIC6LRICc1d9X5xANtb8PN3uV2cg2QAC3WE59MFFVdGIL+Hd3zDV06z5yaLfw==
X-Received: by 2002:a05:600c:287:b0:414:6865:b5bc with SMTP id 7-20020a05600c028700b004146865b5bcmr1829278wmk.28.1712230965536;
        Thu, 04 Apr 2024 04:42:45 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b0041624540918sm2438600wmq.9.2024.04.04.04.42.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 04:42:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/2] bpf,riscv: Implement bpf_addr_space_cast instruction
Date: Thu,  4 Apr 2024 11:42:03 +0000
Message-Id: <20240404114203.105970-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404114203.105970-1-puranjay12@gmail.com>
References: <20240404114203.105970-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))). The addr_space=0 is reserved as
bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY

rY = addr_space_cast(rX, 1, 0) has to be converted by JIT.

Tested-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
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
index a4c8e1e6c1e2..15e482f2c657 100644
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
@@ -2024,3 +2033,8 @@ bool bpf_jit_supports_ptr_xchg(void)
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


