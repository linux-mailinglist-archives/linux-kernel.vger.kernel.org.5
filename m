Return-Path: <linux-kernel+bounces-120098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F117588D186
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E721C2D833
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C6113DBB6;
	Tue, 26 Mar 2024 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9qE6WgB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D017173B;
	Tue, 26 Mar 2024 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493392; cv=none; b=KAv3jRVY5yqfxWiGrvJcbhornPoXhhEfV3wFF69L6h6b2IZ7o0Ip2gRkXbfIK3tsYa1lRXmjAShB7TWiJHfLUu6+2B68PgjZo+kFabvJAWz/3D1EXVyHrhvctaX0k11dZhraeTxfHCwncqmdwPm7UQLOleb7qSlbSySbTg07BFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493392; c=relaxed/simple;
	bh=Ubz3xbzdHeUNbsNcvKmBlKV+oPIRtP7cPabCiRNL04o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dYvy81vTsxQgipSb9Qt9ipMG75rqGB/UDJfVqoWSfThy1VyE2jI/5FKWR+0o3z4Y0Q+Q8RONItozGULPw7gsfwQGThblrre0uIP8+OJDH1BjP9Cpfy0O3Wcp+nvMDdcsmO521JxT5VRmpZg6u+SMj/6m68DVCsCBl167MxHENPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9qE6WgB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4149134390cso4182815e9.2;
        Tue, 26 Mar 2024 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711493389; x=1712098189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zT8/zXegG1a9wcJELvNhGSJACyR7iVf1nN14z4Po9Z0=;
        b=Z9qE6WgBD+WVKOzl77iIKKgizQ4zPs0K30P/XOP68MmfwJocDTbUfi7FpH/qi2OGuS
         qENpEVhZOKyKayKVIbjB5bNPQnXLKwGqyFVT8t2ZmDwCDuWfQaF8mN+AW0QFSw4Smbe7
         p7QASIYFkK1C9bDg8FKc8K0E8Q2fu/VhounIA3Z/2gNTHA7xZ7c6TpVYmqbr1z0XGB1C
         pPS/j+2fuEPRm5Ry/OTxSIFKdOfGvBEYgjhVFaJ98mQtDIb+lJGRWYWVZ9h0WIkvonqI
         3j9begx1rITQbEYocSpGPrxCWsG/f+SxqGLMRJdg2X8cWuXbQzgdROIJNz3laBfIM1qs
         Vi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493389; x=1712098189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zT8/zXegG1a9wcJELvNhGSJACyR7iVf1nN14z4Po9Z0=;
        b=QMOcy97dXOppIXCMFCYePtzgNUYjl//ZUy2IoFByqBRmf4ptRHISEwMGDZQsV+dm8C
         VOMvjnEQF7SU3nEfAC+Rq32+MRwNmYXHr5NR4MMP7PVO1Hly0bPnPu1MX/DC3n+oIUH5
         +VgJ9RmGO/cfuWq3p6aa3f9+ukCnZj7fuDBU1VjuaMJLJ3bAbXZsZCuwQPhVCG0oIKbR
         a4OEIF2OrjlRMMnF7jGSye2QrofusPZi65yuGe+2v9n48FSOtJOKY3tJMf9x7W90ABpX
         pGSH6vPDVeNX0ukoqDMnYLN3QB3H+lEkk5S/5QFYgS7o0jcOuLYQ39Luua5VE15hxW+J
         8QWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmbhL7C5JUYP45Stul9soCawwyAId2/z6w397qZEcvuUDPlk/xCi1w3MPXo80TZVoonq6+5tF6y7Mpz4h/UoQblvQZbsLe08jxOWhLashX82M8OuyAW4UliBRuWiwX1kFI
X-Gm-Message-State: AOJu0YxJ7S98tHmqzXgYkuVDVoJdDXsqPfltsYDu33BSZSYq7D8+SHED
	hb99LZaorvUqbJ2sfsQtdliyL16RNC/dIX36ATkE4DpRFDJpiGzV
X-Google-Smtp-Source: AGHT+IGuvco2dvJZdGDwR9HtHvjUbmxA93PQU54yFOcHJ+99tI6hKAZGdYtXOMSbBfmWUuXwxklmqA==
X-Received: by 2002:a05:600c:548a:b0:414:7384:1ec2 with SMTP id iv10-20020a05600c548a00b0041473841ec2mr2058143wmb.9.1711493389125;
        Tue, 26 Mar 2024 15:49:49 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c1c8800b004148c3685ffsm287072wms.3.2024.03.26.15.49.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:49:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/2] bpf,riscv: Add support for BPF Arena
Date: Tue, 26 Mar 2024 22:49:41 +0000
Message-Id: <20240326224943.86912-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V3
V2: https://lore.kernel.org/bpf/20240325155434.65589-1-puranjay12@gmail.com/
- Use REG_DONT_CLEAR_MARKER in place of DONT_CLEAR as the name.
- Use RV_REG_ZERO for the above as it is guaranteed to be never used in as
  dst/src register in BPF LDX/STX/ST instructions.
- Use #define RV_REG_ARENA for RV_REG_S7

Changes in V2
V1: https://lore.kernel.org/bpf/20240323154652.54572-1-puranjay12@gmail.com/
- Used S7 in place of S11 for storing the kernel_vm_start
- Used 17 in place of 16 for DONT_CLEAR marker
- Remove an unused variable
- Removed some misleading information from the commit message.

This series adds the support for PROBE_MEM32 and bpf_addr_space_cast
instructions to the RISCV BPF JIT. These two instructions allow the
enablement of BPF Arena.

All arena related selftests are passing:

  root@rv-tester:~/bpf# uname -p
  riscv64
  root@rv-tester:~/bpf# ./test_progs -a "*arena*"
  #3/1     arena_htab/arena_htab_llvm:OK
  #3/2     arena_htab/arena_htab_asm:OK
  #3       arena_htab:OK
  #4/1     arena_list/arena_list_1:OK
  #4/2     arena_list/arena_list_1000:OK
  #4       arena_list:OK
  #434/1   verifier_arena/basic_alloc1:OK
  #434/2   verifier_arena/basic_alloc2:OK
  #434/3   verifier_arena/basic_alloc3:OK
  #434/4   verifier_arena/iter_maps1:OK
  #434/5   verifier_arena/iter_maps2:OK
  #434/6   verifier_arena/iter_maps3:OK
  #434     verifier_arena:OK
  Summary: 3/10 PASSED, 0 SKIPPED, 0 FAILED

This feature needs the following two fixes in the bpf/bpf.git to work
properly:

f7f5d1808b1b6 ("bpf: verifier: fix addr_space_cast from as(1) to as(0)")
443574b033876 ("riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi")

There is a lot of code repetition for LDX, STX, and ST. I will be sending a
follow-up patch to refactor these.

Puranjay Mohan (2):
  bpf,riscv: Implement PROBE_MEM32 pseudo instructions
  bpf,riscv: Implement bpf_addr_space_cast instruction

 arch/riscv/net/bpf_jit.h        |   2 +
 arch/riscv/net/bpf_jit_comp64.c | 205 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |   2 +
 3 files changed, 207 insertions(+), 2 deletions(-)

-- 
2.40.1


