Return-Path: <linux-kernel+bounces-112806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2720887E5E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5756A281866
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F63D51D;
	Sun, 24 Mar 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHG3XvMQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C36FB1;
	Sun, 24 Mar 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711305153; cv=none; b=iQauoCGEPdFeO6OpQ+pgeWsPehW/q0dDV/siTPqgTDgwiXUh3q9oqvdnI6LqlzirJr0X27anukRcrnZO1jhK8lOcCQvlMWoOgdua0RhvTKJnw+LbTcY+xhlKvLa9/JtJQ3EZiXlPJR/fdDvEUk5kpqioUm1d2RQDVlzWXxRU7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711305153; c=relaxed/simple;
	bh=xACiWGSfAwPijodTq1yeqLhtB8lO5Blz7Pu5eoZFipM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJgXW7g3lKMojXMGw7IFstBz6LGmV3WVIkQcVdV1rYfYr9PeLsJRHeysgmSkYfXercGR1ZkDBhBEeJsaiQEU2lhCrf109uutGAgQmThbXPy/+x7k0y0tLWa3X5SloniqpzIBdMb+iwZSx+ULaGowbEpsZLo03r+riT+DeoKpgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHG3XvMQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so23581235e9.1;
        Sun, 24 Mar 2024 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711305150; x=1711909950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YgFoPDahBoX9a3c+u51n6JSDl+OQcVW6qMPz/uDOO3s=;
        b=RHG3XvMQF//UNKZMYYtjyMH0kAtFATKdI1PcRj75D+j772sB4yQy6losGIRhkw7RWg
         ZKlN6hbavbB7uIEjnc+/ipXA9Q4CEJ27m8zJlTwGf/Hk1xFpJZA6Jz34+XjKa/b8bdVe
         7ArLfVOlHGyvZFHGfdmvPQuumDHO7pdLTcZlyontgPH3dPO4b7MDGRJ3bwlrKt+idwX1
         qZu0MrvVhwfCfnyu/kt/WvqVimtBWrEoUxA2GLhwEGyoWtX1Hffd3G7cOlq/DQuJjtoq
         dmxo4l1MnOg7DEKjM9/9dJa4wKk9BdD/FMtEQZ2XizElZZLvUV9zUNFosWQQJ/S3zBX2
         WzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711305150; x=1711909950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgFoPDahBoX9a3c+u51n6JSDl+OQcVW6qMPz/uDOO3s=;
        b=T+MAwR2JClCaspD7vrTaJ4bj19PHbW+jyYo4akZP+Jinaqrm9UL/g/m/0grfIKjG7G
         uZhGRjJY2XwoL8MDUx34KA/nO94kI5LqCSoWmuq1O+WTLr7cM8rliWThEL+fN1MHAIfy
         F5QK1Iu5cSCROZVtkXvoY9hRt5RkVaMo3sXAA6TQWGK9ZDgAiI4lWW+e119/lQjGHq75
         dLtuLIWsHba+mKER3Z/EIRm1sdpqqJYFaHD1eA/ppYS6FaTdmJsbZKxeY6HItShDFuBW
         lkN5f5o8AlGWuJNEDwZut95wBmAMsLduQWFOAmoHZ+Q4tkqv93n12S1k083WR8F5upRS
         wKUw==
X-Forwarded-Encrypted: i=1; AJvYcCWZs3bmtcx6jiHT4aJwp8ZfwKZR16pZqFLo+pYd289Yia1BJNeMa+6GmlcToXHBKAlx8ury4feJoufqWKfgXryghxblN3rsTc3p4TDchdUY/xXl9VWIpHH08ZCS87/oS1DZBvcAwJtCwfet2BwC7iKJ0TEWAl+2+wu0
X-Gm-Message-State: AOJu0YyGEEnvMfFdLI3vLJC+X7npks109GZwR0GRv+5eyS4WWK/25V0X
	ZkwqdttSyHg/kqcNcM2+cgvR2VuvsXHARno5qD8v27h7jlDV+V1e
X-Google-Smtp-Source: AGHT+IGM53m/kDUbq4T3NKJK2jcfwadv9V6wq5bIhWTQF7ZAq8xCTABqtr0XCIKZPrN42QueJyRoIQ==
X-Received: by 2002:a05:6000:4012:b0:341:cb34:780a with SMTP id cp18-20020a056000401200b00341cb34780amr1386181wrb.28.1711305150093;
        Sun, 24 Mar 2024 11:32:30 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d42cd000000b0033ec312cd8asm7374018wrr.33.2024.03.24.11.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 11:32:29 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next] bpf: implement insn_is_cast_user() helper for JITs
Date: Sun, 24 Mar 2024 18:32:26 +0000
Message-Id: <20240324183226.29674-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a helper function to check if an instruction is
addr_space_cast from as(0) to as(1). Use this helper in the x86 JIT.

Other JITs can use this helper when they add support for this instruction.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  3 +--
 include/linux/filter.h      | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9b3136187938..98349d11fae2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1350,8 +1350,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_X:
-			if (insn->off == BPF_ADDR_SPACE_CAST &&
-			    insn->imm == 1U << 16) {
+			if (insn_is_cast_user(insn)) {
 				if (dst_reg != src_reg)
 					/* 32-bit mov */
 					emit_mov_reg(&prog, false, dst_reg, src_reg);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index cf12bfa2a78c..42dbceb04ca6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -228,6 +228,16 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 	return insn->code == (BPF_ALU | BPF_MOV | BPF_X) && insn->imm == 1;
 }
 
+/* addr_space_cast from as(0) to as(1) is for converting bpf arena pointers
+ * to pointers in user vma.
+ */
+static inline bool insn_is_cast_user(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+			      insn->off == BPF_ADDR_SPACE_CAST &&
+			      insn->imm == 1U << 16;
+}
+
 /* BPF_LD_IMM64 macro encodes single 'load 64-bit immediate' insn */
 #define BPF_LD_IMM64(DST, IMM)					\
 	BPF_LD_IMM64_RAW(DST, 0, IMM)
-- 
2.40.1


