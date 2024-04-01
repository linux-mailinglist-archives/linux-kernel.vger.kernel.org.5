Return-Path: <linux-kernel+bounces-126908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF272894443
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D8F283083
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F854919;
	Mon,  1 Apr 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOI3GsCd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00353E07;
	Mon,  1 Apr 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992147; cv=none; b=RnMa1RMd8v80/SirNrxuCTaAUjqg1/ULpedR3W9FHFfiWCniZNQyvwH7GoAeZ56dVJ68oWKpVIn8id/8EtqL9O1wJmHxpxq6RrudQE71OgTkH7IHIBDUoFhkPMtM7QDDDgDOevl/1SVX18gHcnFmhnM2LXvqaOleQ+CwKFW8uhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992147; c=relaxed/simple;
	bh=xw2fSt3BPp5V8iNV7DJ3a94MeIEOICDQVGI97xUAnZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtlaT+0l8BxplxO6imRJNkUl+Vp55unD75H/y9eff0G7bL4I4X8Iev73cm8Ogj7ZkrPq+gZpMxz+Ph86EbY0ZWzzey/D1ruKBikAZbU+O+drBa3wzqeFt6LFzh85vnew1Y0cQOFSPN4gs5QzLTspYdkUQCPaU5MNxO13YUIAHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOI3GsCd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4156e5c1c7eso1470505e9.1;
        Mon, 01 Apr 2024 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992144; x=1712596944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgPeZhzTZ788WN0jjZdJYqbUvceJFXHDXpD1Py9NPLc=;
        b=KOI3GsCdX241Lq2dVgjBUrj+ItAxkyfVEiGVv4HJL3qU8viW2lts/xvMfC8CRZE2g0
         2iBB8t2AXx8i0CVn+fsR0onM1riocEe5zKO/xNP+YldvsgvQiMvxHtC7krF0Wl5KOfd2
         dHwciyWuaFnV7fS/AX+i5HsCLL+EZ4yXr21RFB1LnhpguEXfGK5HTM7eigT0BNLADdr/
         X6o4pxZsJrvoU+mJbgJD8ThCrPegL4Sxt2jtg00HEoCjh3q0DoSQYr4UCGH8Zb0h94Pz
         bVqZE8eL5jbt6IvibqdUAIUa4TIwV1IOMkdbTXzloHpGsY7QMjtKfY8MZSeWRClWV65C
         CMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992144; x=1712596944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgPeZhzTZ788WN0jjZdJYqbUvceJFXHDXpD1Py9NPLc=;
        b=lbzM7vVW88/Obxqw3v2yRgrMQyAn7dUOAycJ+HstZXaAdP7LxVF1Qgm8ye6cdDXFnZ
         cR+8oUs7fVNP9Gv9PsRSP2bxv/6coeLk2+J8UvCdIUPkJwKc6c98ncx0gOK+OHm5zFM8
         CUk1BFmYd1T+7VLyDonccQ5GWJN4lV8lo4jjvGo6uTFRjGlALSiSJ86cmHad+J+bUZhO
         jfURErIeHIywH8U3GyRT5HTwQDT5/xBxdRiVzTK19e7iA6LADdbuwcrG/RDeBkafxMMk
         rxDl9boEuEhT8jvK4OBozFiTLmuspXrbeXraElXgaV8S5MJAGf66/2ZYSsegtxQDTtGZ
         lPsA==
X-Forwarded-Encrypted: i=1; AJvYcCVAvJahnkQGy0driBxtDlZRbhdE3sNMqYwqHA1n+fK4vzckyoGgiHR0FAxAB+lCI5Q9c5XN1cuoMxd1x/i2oawgHVszBNERnfS6ZHD4Em0M4b2h8BycvIGTvVNG16rabk2/dJykEdaPnRriu7lNSbQMvFvViJPZZh6i
X-Gm-Message-State: AOJu0Yw2LOlamw8uH5WyEs4AFa88SWEmPkyCmkkfWTFotMM3zC9NF6p6
	VZp2D9vswWPRt8+RN9WkR6/+8iTNkBQWY4Hf+G6eoQpa+HnGasfZ+CCRl2i6
X-Google-Smtp-Source: AGHT+IGDm9V39i/631xCWYmvLNeaIhpUNQ+uXk5p1/MjgyRw6sTTRjQlm0NOw2oq4hejtcwExTJTvA==
X-Received: by 2002:a05:600c:5123:b0:414:37f:2798 with SMTP id o35-20020a05600c512300b00414037f2798mr8851789wms.6.1711992143906;
        Mon, 01 Apr 2024 10:22:23 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0041401eb021asm15273108wmq.24.2024.04.01.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:22:22 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/2] x86/bpf: Fix IP for relocating call depth accounting
Date: Mon,  1 Apr 2024 19:19:00 +0200
Message-ID: <20240401172157.5717-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240401172157.5717-1-ubizjak@gmail.com>
References: <20240401172157.5717-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

The recently introduced support for %rip-relative relocations in the
call thunk template:

  17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")

assumes that the code is being patched in-place, so the destination
of the relocation matches the address of the code. This is not true
for the call depth accounting emitted by the BPF JIT, so the calculated
address is wrong and usually causes a page fault.

Pass the destination IP when the BPF JIT emits call depth accounting.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fcd20c6dc7f9..67b68d0d17d1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
-extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
+extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_call_dest(void *dest)
 	return dest;
 }
 static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
-							  void *func)
+							  void *func, void *ip)
 {
 	return 0;
 }
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 30335182b6b0..e92ff0c11db8 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
 
-int x86_call_depth_emit_accounting(u8 **pprog, void *func)
+int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
 {
 	unsigned int tmpl_size = SKL_TMPL_SIZE;
 	u8 insn_buff[MAX_PATCH_LEN];
@@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 		return 0;
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, tmpl_size, *pprog,
+	apply_relocation(insn_buff, tmpl_size, ip,
 			 skl_call_thunk_template, tmpl_size);
 
 	memcpy(*pprog, insn_buff, tmpl_size);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e55745f512e1..df5fac428408 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -480,7 +480,7 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
 	OPTIMIZER_HIDE_VAR(func);
-	ip += x86_call_depth_emit_accounting(pprog, func);
+	ip += x86_call_depth_emit_accounting(pprog, func, ip);
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
@@ -1972,20 +1972,17 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
-			int offs;
+			u8 *ip = image + addrs[i - 1];
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
 				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
-				if (!imm32)
-					return -EINVAL;
-				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
-			} else {
-				if (!imm32)
-					return -EINVAL;
-				offs = x86_call_depth_emit_accounting(&prog, func);
+				ip += 7;
 			}
-			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
+			if (!imm32)
+				return -EINVAL;
+			ip += x86_call_depth_emit_accounting(&prog, func, ip);
+			if (emit_call(&prog, func, ip))
 				return -EINVAL;
 			break;
 		}
@@ -2835,7 +2832,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * Direct-call fentry stub, as such it needs accounting for the
 		 * __fentry__ call.
 		 */
-		x86_call_depth_emit_accounting(&prog, NULL);
+		x86_call_depth_emit_accounting(&prog, NULL, image);
 	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-- 
2.42.0


