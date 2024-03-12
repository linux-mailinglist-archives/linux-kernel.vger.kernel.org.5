Return-Path: <linux-kernel+bounces-100951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0A879FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C792B2153D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107BB4D108;
	Tue, 12 Mar 2024 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6+PNpqc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AD1E511;
	Tue, 12 Mar 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287980; cv=none; b=XJRtPQN1q9upjubEzCEMntTZ571McsGfeQIlRUvnOVmgu6gUc4XSX97xUomvZYY3lb5qRBSw7dkAQNPpp8FAQLQ4+wdv7VS6Gs9lnb9EeUMCKdWbbf0muBWRUkbsMdqE548XYlQZIufjaeXTvE5FF5XImRrGK5cPuBw94h6B2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287980; c=relaxed/simple;
	bh=dT4zxZA60E8FTwqPwl3Zj3F5LVm6iBcDrsHoGtZ5YbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nyBuvx6WVPdrRE4dfgWHyxkZaPJMUYPo4Xhc4w5At5D8w9bIpF/ElocL1eEYDNvYarR/Cl5s3yEtSiB/2UogYjJphoxsEFY+2yg9j3Hkads4qgNAp6h1NZQiHxO5YAwfYGU63WxFPzriqSev3C72NwJzmFthpxpP5UVCZijjTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6+PNpqc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso3244678f8f.2;
        Tue, 12 Mar 2024 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710287977; x=1710892777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lotzu8glbCkyvKHyiBPl0QIEkj9pT0hJerm/uy6gzX8=;
        b=Q6+PNpqctrmfy5sv1XggjabzmJx6uYTjFPHq9C5GrrZ18sryRlcxczsPtP2dYAhbjW
         SpywPDedtvlHLHdMsBArdPV6OvvCRbMt5p3DkIHRsZTNSzRUrTomPxZc5N/a8spaGygA
         rVhQOIngBmGkkblDdHm3kTmZp+HDFTBhBJl+whaZAh2ekbX2vZE8f7mBn6Fmpcoadyhs
         XxbbJcjOgq17YgpqYFp5eFNsXmlNJ2QOA+nBed2fofMSBuQYVKgMJgb3VTePw7QG2opM
         lEfomNbY+VY0sRb8eY0CIi5kxHLEyzHmgDADBlbgQTFTWbZIiSsA7wYTuzufPrKRK8d0
         XXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287977; x=1710892777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lotzu8glbCkyvKHyiBPl0QIEkj9pT0hJerm/uy6gzX8=;
        b=GruFZcShi1APYpie2wo5oWfcIhYFCdas6Mt3+Mz+4LelTa/MnHFbE4bz99+SjkGInS
         t/XEBiZhJb011Hbvu/J+ADK36HLBy+q+r+/MOTFV/dUzDs3JfZfITdzHl7XNSQU32yOH
         4MI0if3T8Jfk0zXxQyINcOsCIbozaE0F+ln435esxjvYmxIzLKfXiRcKygu0j2SHFO4x
         nmuDkDVi1oFoBSwkMXru551zC9T9sczgotRgo6VdcDA/2g6e4GhZL51ODmj5Gdsg492Y
         /27kNUS2bDbE58pG3ON+gl1EJYIqiDsTTTtgFafLi+GrnXvti8Pt0mW/1x5GfMR7uKuF
         WHLg==
X-Forwarded-Encrypted: i=1; AJvYcCVRFz0xGx5p1gXR5szQ0U/bijUuX6v69vOCg5KNUeYjCqm31r/OwDWEopUilDKHFB37FdJGrhojh8/BMNQ/bqBkHo6AbV3uXrTd8XmLa1fv9joAEBDX7OzEra2WczsmxW5Z
X-Gm-Message-State: AOJu0YyBO52pAbhfVN+HD/brKHY3qIogpGeSLggw/B/LZCdWYDQueir3
	Gu48eZPGFblL2jV9pmyJVNuhBEF8j2cysHe+ZfDgYvbR1Wb9CT6+
X-Google-Smtp-Source: AGHT+IEKJVmzf3TNxKGG70CKVtDbnw+LlqYiHWBmbdcvi5dUQiuHkikD9UhNxYi31PYDNGTlblnkxg==
X-Received: by 2002:adf:e592:0:b0:33e:afbf:e10b with SMTP id l18-20020adfe592000000b0033eafbfe10bmr652476wrm.3.1710287976590;
        Tue, 12 Mar 2024 16:59:36 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6acc000000b0033e7a499deasm7942255wrw.109.2024.03.12.16.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2024 16:59:35 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] bpf, arm64: fix bug in BPF_LDX_MEMSX
Date: Tue, 12 Mar 2024 23:59:17 +0000
Message-Id: <20240312235917.103626-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A64_LDRSW() takes three registers: Xt, Xn, Xm as arguments and it loads
and sign extends the value at address Xn + Xm into register Xt.

Currently, the offset is being directly used in place of the tmp
register which has the offset already loaded by the last emitted
instruction.

This will cause JIT failures. The easiest way to reproduce this is to
test the following code through test_bpf module:

{
	"BPF_LDX_MEMSX | BPF_W",
	.u.insns_int = {
		BPF_LD_IMM64(R1, 0x00000000deadbeefULL),
		BPF_LD_IMM64(R2, 0xffffffffdeadbeefULL),
		BPF_STX_MEM(BPF_DW, R10, R1, -7),
		BPF_LDX_MEMSX(BPF_W, R0, R10, -7),
		BPF_JMP_REG(BPF_JNE, R0, R2, 1),
		BPF_ALU64_IMM(BPF_MOV, R0, 0),
		BPF_EXIT_INSN(),
	},
	INTERNAL,
	{ },
	{ { 0, 0 } },
	.stack_depth = 7,
},

We need to use the offset as -7 to trigger this code path, there could
be other valid ways to trigger this from proper BPF programs as well.

This code is rejected by the JIT because -7 is passed to A64_LDRSW() but
it expects a valid register (0 - 31).

 roott@pjy:~# modprobe test_bpf test_name="BPF_LDX_MEMSX | BPF_W"
 [11300.490371] test_bpf: test_bpf: set 'test_bpf' as the default test_suite.
 [11300.491750] test_bpf: #345 BPF_LDX_MEMSX | BPF_W
 [11300.493179] aarch64_insn_encode_register: unknown register encoding -7
 [11300.494133] aarch64_insn_encode_register: unknown register encoding -7
 [11300.495292] FAIL to select_runtime err=-524
 [11300.496804] test_bpf: Summary: 0 PASSED, 1 FAILED, [0/0 JIT'ed]
 modprobe: ERROR: could not insert 'test_bpf': Invalid argument

Applying this patch fixes the issue.

 root@pjy:~# modprobe test_bpf test_name="BPF_LDX_MEMSX | BPF_W"
 [  292.837436] test_bpf: test_bpf: set 'test_bpf' as the default test_suite.
 [  292.839416] test_bpf: #345 BPF_LDX_MEMSX | BPF_W jited:1 156 PASS
 [  292.844794] test_bpf: Summary: 1 PASSED, 0 FAILED, [1/1 JIT'ed]

Fixes: cc88f540da52 ("bpf, arm64: Support sign-extension load instructions")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda438..48b19a233299 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1256,7 +1256,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				if (sign_extend)
-					emit(A64_LDRSW(dst, src_adj, off_adj), ctx);
+					emit(A64_LDRSW(dst, src, tmp), ctx);
 				else
 					emit(A64_LDR32(dst, src, tmp), ctx);
 			}
-- 
2.40.1


