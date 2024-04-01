Return-Path: <linux-kernel+bounces-126968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BF89451B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3841C212A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CEF9DF;
	Mon,  1 Apr 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsO8skZ6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A751C44;
	Mon,  1 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997921; cv=none; b=SxNRR03arNzIt4Kna1KOERYGt9UlPBXUXwlORR0oGdjvcVaTZaEMBLt9xmMF0eS+SG1uJT+eCAqTD/HJOGl8pXFtRG3zNnqhPMHtm3eylUJkT/gOrh0wszcRCNf3M1MoDD2OnV0cJFepgep/rMGnNQ3BZqp03CRkRNntzVyMjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997921; c=relaxed/simple;
	bh=hI/RWjwibOQvhGr3H9JhTRg25qqIumyDdBv7QP2SSBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDPvl+Ixb/zVk6ylJD1xsRFxKX6k3lpn79hGcWoZgGKXVCSYy6P1JZSMQmEQ0/Ev5cCZ4Vy13gekglXMkORrfSWeQA+s91SCpn26H5G08iSTeBRvu7Zro/kJmqFLwV0FGrNOlqrpGbLSYeAnOoDJF8AnEn9B0nu8hwWVnBSWg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsO8skZ6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-415a84ea9bbso986115e9.2;
        Mon, 01 Apr 2024 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997918; x=1712602718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52WgDeZ/MSi+nlkJeaj0YRfT+cyhyIXYkcaJohsx7Ts=;
        b=SsO8skZ6m6lQoPZkCjmGR6bP9pDf/7hdxScqglt6KfV8k2v1FmWwtskatZK630Mifo
         WBQLOzlilmGdy5z6oAl2RPRfxW7cWjfQgue9Ozi/GkrTg62GQu7aibBz486JuutKKYRK
         zODZSSkx9lZPXVwbQnJPPVhMhSP1glm0UHcWC/qZPunIHeRZQMRxwvkqDZVCUXXj3x2p
         E9cCCJ7dBpab/GaRJ1ypaqxjBvnwpMHvdCSF5klhmCvr353EWKV2GEz7oHI5AfPgdhYF
         jpGG32SLolUdgmnEbFu1o37/nx+FIRhe9otvj7asxjkjYD4TvVTBnOoRbuQ2OVStjStx
         CZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997918; x=1712602718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52WgDeZ/MSi+nlkJeaj0YRfT+cyhyIXYkcaJohsx7Ts=;
        b=uh4DXN796SuL5dtQzI6oXNLZ8RjuZgau5rtrrdOcRWziZ0ek+P8fJuvo/F8OvXRrvZ
         +woF1gztH9VPL16rVILTQzT3tnfJpAEMARIrg3+lVEMll7xSLekDgMwcZSgiZgFTHeXf
         6TT+Cc6q8o0uVspWTeiikVlwD6m4CQL34as3ECul8TkouSTP/5izhfwV9eUlP42dmwaH
         lPU+Q5+ysur2vTz/jbgjFI4I49yT4ASX41jk1xntXNKGb19n6TswYAPi8NnXSGLVxjfM
         EoHISjUDcYW7aoSXrV0arEsNCHGG69MzFO0qRx2a5rdw5Lc+vqTj7m6U/dewwKjYvTpj
         Cg7A==
X-Forwarded-Encrypted: i=1; AJvYcCUxoHexaPnSrlSQjYEpFbR1oXslwRjERQG1r8KUJcRVaa9G6XYYQMuTKXq6qE9ezkMDzDzOs2dvbebb1W0rR5MLFXe97Izlodenpcf3pjfZHJYwhOVFpA0ozCbow11nNTca6dxh+yIHNv+Ufpm+K07DB+FjFTUPvOfy
X-Gm-Message-State: AOJu0Yx+Xe+JSuMaRkRl6xXJvN292IDDXP8lpdYpDVYA7NQcOkM9qqkO
	tH9+VfbM+7PIQPCCqR+xsoDq9ibFBwf0U9rqll2VIxrWXSoF2ckXWqquR6Vb
X-Google-Smtp-Source: AGHT+IEHr7EZ2h1N5yq1Ku1nuFDteF4OF+6ZhDrojd7YRlZ3roesKxqxxE/SNg4oYXmPNd01Sv1/7w==
X-Received: by 2002:a05:600c:4656:b0:415:6dae:771d with SMTP id n22-20020a05600c465600b004156dae771dmr1115722wmo.7.1711997918212;
        Mon, 01 Apr 2024 11:58:38 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041552dbc539sm10950986wmk.11.2024.04.01.11.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:58:37 -0700 (PDT)
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
Subject: [PATCH RESEND bpf v2 2/2] x86/bpf: Fix IP for relocating call depth accounting
Date: Mon,  1 Apr 2024 20:55:30 +0200
Message-ID: <20240401185821.224068-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240401185821.224068-1-ubizjak@gmail.com>
References: <20240401185821.224068-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

The commit:

  59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()")

made PER_CPU_VAR() to use rip-relative addressing, hence
INCREMENT_CALL_DEPTH macro and skl_call_thunk_template got rip-relative
asm code inside of it. A follow up commit:

  17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")

changed x86_call_depth_emit_accounting() to use apply_relocation(),
but mistakenly assumed that the code is being patched in-place (where
the destination of the relocation matches the address of the code),
using *pprog as the destination ip. This is not true for the call depth
accounting, emitted by the BPF JIT, so the calculated address was wrong,
JIT-ed BPF progs on kernels with call depth tracking got broken and
usually caused a page fault.

Pass the destination IP when the BPF JIT emits call depth accounting.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
v2: Add more details to the commit message.
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


