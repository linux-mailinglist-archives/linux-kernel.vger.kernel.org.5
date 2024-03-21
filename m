Return-Path: <linux-kernel+bounces-109518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4303A881A78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6795C1C2100B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1E187F;
	Thu, 21 Mar 2024 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPNcA6mq"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909227EC;
	Thu, 21 Mar 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981038; cv=none; b=PoD4iVc+wDUb/HwrXc43eopL8G9ln2BhkD3S2vjF+HbrxmaQ4woCvmnfgb0UVmJnNlj/HcmuMHSpVKvFLek9WFu2Br7hHbVLPVwZVUzTssjStIR6bkwIf65NK2YyfxP7pnj7RtIG+sRiUGzBVdU8ipBht/B/WcIwgcfidoEth1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981038; c=relaxed/simple;
	bh=8cxU15kD6fX0oevez6pGZiT9J1W5PD4j8R69xwUcF0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDbXOaSs8N3IoVAcAVVJjAuqfjuak5j6ZSdayvH8WNgNQgnbZvseY/5X9l6MGbGfKz3eZxadlvr4lDNS0oQwvrDwVNZEGBkcM1pNaVIn3LgOfdTtKfE4tU2bFzZUBc5wOgerlTMYq7nxFaOcBbCvcW/i2ay4O5xeESwQP6GD9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPNcA6mq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69145fc4265so2984296d6.1;
        Wed, 20 Mar 2024 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710981035; x=1711585835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3zYAynjB0lRAaPerPyxypfEa4xbtjuIYo4GN4Bzp8I=;
        b=WPNcA6mqpkiywE5AOAfwABZ2By/jlpb4knKLz9HDwwLbpZU3Qe4s8LHU1XmGpNXqyF
         OfF2l0beV600ArzsQFY5DKkrrrKgIaS4Dy4cqPsyuzcJJF6kYc7V9ICCZTZYe0SL/u7W
         HM9w4gkshi74AOfalO5NcQbrNyVJSHih3aPh2qTsAYGXHrm9SFyoXnzAEkApg3WIda0U
         HT5RWPiUtfNZF24KjYcf0XMRizy/Xb+ZEmWUP8xS8DWsG37646HPhB7D+gd5SJROOfNi
         4BTMvT54gqIxYdsyLLRdICQ/7J63G8fsb0MlEEzE+3DameWZXIuSIGiw+/uQMbl0vVfX
         hyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710981035; x=1711585835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3zYAynjB0lRAaPerPyxypfEa4xbtjuIYo4GN4Bzp8I=;
        b=rZrRhpw1j94L3znXs1NNjK8fCryNkbEHKvc15PIpk8C6peNXES4xhgVFnRKOLbELDw
         0Fu4jyDR1Uf4aAcCJR3PI/rIMuR9vhcoQjSfBawt2TVVi5hwTaoFzZ9ukUxPi+/FHaB7
         6zSJzXW0H1x91wwVzlRp42SZZdumw901bF0u0fEVt16aiNVsXQWvXgildWj6gjhpYaLl
         ogdg0hJq2ovq99SMrjJae9p4bZhzD7OJVaaUP0acEEpe9IAsn3Vds5IefIZlRSB6x5M9
         sO03BzMIus1v1mCXHRy5OBtrQHIVe8srzqcgeHgVkUsu4nxn4Sb/Kimq4Z956vAz3Rj/
         J3oA==
X-Forwarded-Encrypted: i=1; AJvYcCXqZ+4p8GeCRyHC/neGRiJ9Zp6VPx431cS/Weyb5nUB3g5y5d3vjdinO9xS8IaFeNjwJDRQlHpEsvFzxy/9XeZQt+ZG4vTQqjC5YzI52cVtE9I/JzmbA7avdIqbAAgSviah
X-Gm-Message-State: AOJu0YxzbJ89TzvuUt1Nde+Grau+fZIK5e3igiJ0xTGHVMh/Ibi2mPc6
	Szhvv0DkGIzGrsllI6CCqoK8MLuLOhKmzB0pbA3uxUmLiBZDUpAJ
X-Google-Smtp-Source: AGHT+IHjdvdILHW0FF5BS2EFEyIzAUOU5eIPkyJmbh+bqNNETj9YOY+XyqJ6XkMnwzHiWFobIjtiqQ==
X-Received: by 2002:a05:6214:1845:b0:690:c629:348d with SMTP id d5-20020a056214184500b00690c629348dmr6942077qvy.36.1710981035399;
        Wed, 20 Mar 2024 17:30:35 -0700 (PDT)
Received: from lima-default.myfiosgateway.com (pool-128-6-36-140.nat.rutgers.edu. [128.6.36.140])
        by smtp.gmail.com with ESMTPSA id jn10-20020ad45dea000000b00690dd47a41csm8435406qvb.86.2024.03.20.17.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 17:30:35 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: harishankar.vishwanathan@rutgers.edu,
	andrii@kernel.org,
	sn624@cs.rutgers.edu,
	sn349@cs.rutgers.edu,
	m.shachnai@rutgers.edu,
	paul@isovalent.com,
	daniel@iogearbox.net,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
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
Subject: [PATCH] bpf-next: Avoid goto in regs_refine_cond_op()
Date: Wed, 20 Mar 2024 20:29:54 -0400
Message-Id: <20240321002955.808604-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of GE/GT/SGE/JST instructions, regs_refine_cond_op()
reuses the logic that does analysis of LE/LT/SLE/SLT instructions.
This commit avoids the use of a goto to perform the reuse.

Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de7813947981..ca6cacf7b42f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14544,7 +14544,19 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	struct tnum t;
 	u64 val;
 
-again:
+	/* In case of GE/GT/SGE/JST, reuse LE/LT/SLE/SLT logic from below */
+	switch (opcode) {
+	case BPF_JGE:
+	case BPF_JGT:
+	case BPF_JSGE:
+	case BPF_JSGT:
+		opcode = flip_opcode(opcode);
+		swap(reg1, reg2);
+		break;
+	default:
+		break;
+	}
+
 	switch (opcode) {
 	case BPF_JEQ:
 		if (is_jmp32) {
@@ -14687,14 +14699,6 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 			reg2->smin_value = max(reg1->smin_value + 1, reg2->smin_value);
 		}
 		break;
-	case BPF_JGE:
-	case BPF_JGT:
-	case BPF_JSGE:
-	case BPF_JSGT:
-		/* just reuse LE/LT logic above */
-		opcode = flip_opcode(opcode);
-		swap(reg1, reg2);
-		goto again;
 	default:
 		return;
 	}
-- 
2.40.1


