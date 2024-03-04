Return-Path: <linux-kernel+bounces-91239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11AC870B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A19D1F217B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F917AE72;
	Mon,  4 Mar 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STOXi1xk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294462143;
	Mon,  4 Mar 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584109; cv=none; b=sWn/BQ2qKrxbup96XzeGjiwe/UAc0FarQThDEtxOI1uGz4lvRQ50LDP7t3gIXOsI+UQ7Typ9a/OWiVleSIUBgo4uRL72ZGVftmcpg/ZlKPyK8QlXyuJ7Q+9/YO5cfIXB5+UsJ4cSY+/WrfSGM01kvzOrs5gDhBFHRRA9PnG0Gio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584109; c=relaxed/simple;
	bh=kK56UPJtrMgrhC+eWkyoWONsRRS13BbXbI9WLikncpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQ7PKM8DrG96fmCKUtfLp4w5i+6Or4nJQuKn68KzwcaN+hw1o0oi4SsHX9z8IfrB9/82QX0ejImG9UL6odRBOHwTT4WpuTp36y9ecV2KM3RPokdVuBOACqFY9QKKHxlM7AXuwwmv9qioKh0+Sdw4TQMvnOuBP4rkK0+pjhRZ2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STOXi1xk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e8c63f23so5526345e9.0;
        Mon, 04 Mar 2024 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584105; x=1710188905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8374zjIQzoAP6NawexwSb/Q1q4lgTdoXyDk5N8EOwc=;
        b=STOXi1xk0r6wDpy/h2h3fUddJHNio+JfY733HmrvlR/nTAj+3ZIgEWknZwAXYLe6dP
         H2mW5cGaSiycDzQzk8KfmvqskHhdbr5Ol+l4u63uz5EMahXT6hB4+br2vSgGnpPgeDTP
         VXu+X7JE57a4de9C7EZEYb+bJXgF/2QOE66wnsC1w9PHMzqvKyMYp74pPgoUfCkrBA4h
         NicNvufdsIXHOk27vJH00QyGi2vPPVu0jS3rsqMCAE02dCGnMxNAI+xM0ElLMvfItfUj
         HPMMW8pHm+T8YS6JzabGpcV7YW8Ygv9tQ3igwGGeRWgDe6NPxBHWedquGcduvJh3j9ye
         FhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584105; x=1710188905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8374zjIQzoAP6NawexwSb/Q1q4lgTdoXyDk5N8EOwc=;
        b=AiteLH3DswiFAdu5OcYSzQoPLgen2PK5N8BLQbjMX4Ph2GcTB23bKX3hqHL7BNUsQU
         VOnQTzvGkFrHA31kGyj6pQ2IN1BDjkPHHBkbUZgp59gmaXZH+i/s+lBnLVZdbAHgU4jW
         Rf/v1C0GDa0QGcY5udLFHsUIfnxILlyjB7+tvX6cfXRUBswcprBzpXGbJwSO2d7KFdgn
         sNHitVocluLAUU9kICD6NnijHhUxLabx+oe28S49RGqIzfRXA87US+1rUCloqHFWRR19
         gAnB3ZvAxP8sHIq/kEAnAXoxUGV+E6MIGjNpCu8JO3BcDnpSyFfPZO3ruRWzPIIn51Vx
         g6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxxBZ+zeW/XCaMwHNaVmk0Bi63PIjhK9fHR3sWq5rmiI3521k8dDvsx2A76yw33H8+itEuzi1QueTy/ixYexMnCZNgQ1sdz0vsO7z0KDEC1bfDJ8d7nvHSAJ0z3bJ/mtYv
X-Gm-Message-State: AOJu0YzaU9wYRvoELhx93rs1Jt7S5oc+F3cYZp/yc2yLYW1UqxW8hrul
	KSz04z2TnepClBdUkcYajBdVuD/h+7P35fdAJKVp42DHvr2R86TJ
X-Google-Smtp-Source: AGHT+IHbTbMtHaq9bspX/vZCCO1+aoX9vsybER44sO+00buq4wgGQxNpZxIz6qKi6v4tq9zIdZpxYQ==
X-Received: by 2002:a05:600c:5191:b0:412:e902:87a7 with SMTP id fa17-20020a05600c519100b00412e90287a7mr1117353wmb.20.1709584105222;
        Mon, 04 Mar 2024 12:28:25 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id o39-20020a05600c512700b00412d60cb914sm8808428wms.5.2024.03.04.12.28.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:28:24 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xukuohai@huaweicloud.com
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next] arm64, bpf: Use bpf_prog_pack for arm64 bpf trampoline
Date: Mon,  4 Mar 2024 20:28:03 +0000
Message-Id: <20240304202803.31400-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We used bpf_prog_pack to aggregate bpf programs into huge page to
relieve the iTLB pressure on the system. This was merged for ARM64[1]
We can apply it to bpf trampoline as well. This would increase the
preformance of fentry and struct_ops programs.

[1] https://lore.kernel.org/bpf/20240228141824.119877-1-puranjay12@gmail.com/

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 55 +++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5afc7a525eca..c5b461dda438 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2076,7 +2076,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		/* store return value */
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
 		/* reserve a nop for bpf_tramp_image_put */
-		im->ip_after_call = ctx->image + ctx->idx;
+		im->ip_after_call = ctx->ro_image + ctx->idx;
 		emit(A64_NOP, ctx);
 	}
 
@@ -2091,7 +2091,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 				run_ctx_off, false);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->image + ctx->idx;
+		im->ip_epilogue = ctx->ro_image + ctx->idx;
 		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
@@ -2124,9 +2124,6 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_RET(A64_R(10)), ctx);
 	}
 
-	if (ctx->image)
-		bpf_flush_icache(ctx->image, ctx->image + ctx->idx);
-
 	kfree(branches);
 
 	return ctx->idx;
@@ -2169,14 +2166,43 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret < 0 ? ret : ret * AARCH64_INSN_SIZE;
 }
 
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
-				void *image_end, const struct btf_func_model *m,
+void *arch_alloc_bpf_trampoline(unsigned int size)
+{
+	return bpf_prog_pack_alloc(size, jit_fill_hole);
+}
+
+void arch_free_bpf_trampoline(void *image, unsigned int size)
+{
+	bpf_prog_pack_free(image, size);
+}
+
+void arch_protect_bpf_trampoline(void *image, unsigned int size)
+{
+}
+
+void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
+{
+}
+
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
+				void *ro_image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
 	int ret, nregs;
+	void *image, *tmp;
+	u32 size = ro_image_end - ro_image;
+
+	/* image doesn't need to be in module memory range, so we can
+	 * use kvmalloc.
+	 */
+	image = kvmalloc(size, GFP_KERNEL);
+	if (!image)
+		return -ENOMEM;
+
 	struct jit_ctx ctx = {
 		.image = image,
+		.ro_image = ro_image,
 		.idx = 0,
 	};
 
@@ -2185,15 +2211,26 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	if (nregs > 8)
 		return -ENOTSUPP;
 
-	jit_fill_hole(image, (unsigned int)(image_end - image));
+	jit_fill_hole(image, (unsigned int)(ro_image_end - ro_image));
 	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
 
-	if (ret > 0 && validate_code(&ctx) < 0)
+	if (ret > 0 && validate_code(&ctx) < 0) {
 		ret = -EINVAL;
+		goto out;
+	}
 
 	if (ret > 0)
 		ret *= AARCH64_INSN_SIZE;
 
+	tmp = bpf_arch_text_copy(ro_image, image, size);
+	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
+		goto out;
+	}
+
+	bpf_flush_icache(ro_image, ro_image + size);
+out:
+	kvfree(image);
 	return ret;
 }
 
-- 
2.40.1


