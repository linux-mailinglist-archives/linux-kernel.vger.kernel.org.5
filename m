Return-Path: <linux-kernel+bounces-103445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AD87BF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EDE2857E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566EC7175D;
	Thu, 14 Mar 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cib871GY"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13071749;
	Thu, 14 Mar 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428410; cv=none; b=Y3PBN5eZB5TO/iy4vdrhzvPayM7lqMeFXrFgFxhOLOPP6UfJ2wmycN++pxxBDE9MxxWzMttFB5t19dmhVLSkspcGc/WBX3z3sYJQVRAzvvOu7Vfw2xqxTc7kKo3yPTP4iyhrDKEULEsgl0oLGtT+M0yNluFI1uwKE37o5vfyHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428410; c=relaxed/simple;
	bh=7/DqWr5rdEq+cBVg8oAa8F/rADskEBUnpUvPYUvBp3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnprWpuvfKekcJ0sJtOf/yC53wbl+jhs5PaJ6clm9xRv+Qq5cZtuK32jS6xqJj4X7e94TS45EP9Pa/gqwe28G5AtveZSQC05iAQQvJLArhKFQ0kHmwfdw/D+uk0RZIx1Cd94RvW4VsAo1UCZHCXv5xP+DYn0Ic1x4RfY9iJHmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cib871GY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e966f56c7so1059627f8f.0;
        Thu, 14 Mar 2024 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710428407; x=1711033207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqjW4NMzKRTfBHsJStcBs6+VmS9X4P0PAx/9ptrYQAE=;
        b=Cib871GY2KZaD2fWkfeTy87+eAzU6NGqUcY11u3x9fX8SaEjYDEp5JE7cr7N9l4jRX
         qnB3ENHykVUtPkiSWOYLGMrsN3xcUTQsVYaNAP5GtAma27f/oUp6BNiYn6uRK62KfYPY
         xXfwOK9OAjriJIN9hvFXJ5G1tL48sQmGP2coJssIW4o1KRv6p6+jC7aJBnhNImn5AbY8
         9lm0I7F1izLhvshHs5qQMHXLKaMcYw/B6cqTrtR5j/htmMY2g5ZxyIPNbRFAoesSptRf
         9mQp72rJa0hHvfW7Tf/2yDCnAl/tOsWv8XAkyEEXt6M3VcbY7AeF3icoXf9Yuvfy+F7s
         Hrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428407; x=1711033207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqjW4NMzKRTfBHsJStcBs6+VmS9X4P0PAx/9ptrYQAE=;
        b=DHu8aq5caITS+W/3CdCSWzJkQ1AO97981pB0k9lQr2n+8Jovjrvr1dgHBzrX24iGzL
         ZXh4/EVWSLQRz4mp1ameluHEtX6qq8Mmmlt4NMA0VnHU3TZvmHK7UOFmAn82IwPQyvnv
         43nHRChFhd/vO3jQoyaw4tyRVaDRJ1iMKg3SPonFRv/NeGGyMsXEmmPpefpwMBA8I0bz
         akYGv0Mh4m/uPfI7rFgBbQOW/J8WUFGEyJ/hfcLKgeNo51E2JdRT1bA3m7jKi6YHpxZn
         s3RClaWasq6/rCPfpej4fM9qmD9EjAKtZ22Ujj+2HSdVRAFXL4SE5j18r+hvCA8/le1s
         kOFg==
X-Forwarded-Encrypted: i=1; AJvYcCVP6oSFpz2F8ORxVsK2nFUgJkdQmN9UzcLjXw1ZUT4GRmDBo1u6VXhe+3mbemW00RcI1SVAIEJd0uVwq2PACmu5+eGeCROdLp2Aw4Z8+h14rxL1JEGTVTPhWyybJPM2dDjL
X-Gm-Message-State: AOJu0Yygg+6xuyQVnJmG7+tpUxZQG30ea+hJJ2rxsjj4C3ZCMfKUfnQb
	FsRfjDZHSUy8n9EBEgEnP1LDbfD9si5x0Vc85pqjErDh/21sRiVbZSr1Oy+Ej064PMC0
X-Google-Smtp-Source: AGHT+IEnazuqirTvzs0EMIlFEqAtC7PFDh2Ncwe0kftb1iGbJn2BbML904PHQ4HOeecoWlXdg1rA1w==
X-Received: by 2002:a5d:6408:0:b0:33e:8b95:b350 with SMTP id z8-20020a5d6408000000b0033e8b95b350mr284485wru.7.1710428407030;
        Thu, 14 Mar 2024 08:00:07 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d540e000000b0033e95bf4796sm961143wrv.27.2024.03.14.08.00.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:00:06 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 0/2] bpf,arm64: Add support for BPF Arena
Date: Thu, 14 Mar 2024 15:00:01 +0000
Message-Id: <20240314150003.123020-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the support for PROBE_MEM32 and bpf_addr_space_cast
instructions to the ARM64 BPF JIT. These two instructions allow the
enablement of BPF Arena.

All arena related selftests are passing.

  [root@ip-172-31-6-62 bpf]# ./test_progs -a "*arena*"
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

The implementation of bpf_addr_space_cast can be optimised by using ROR
(immediate) and CSEL instructions. Currently, lib/insn.c doesn't have APIs
to generate these intructions. I will send subsequent patches to implement
the APIs and then use these instructions in the JIT.

Puranjay Mohan (2):
  bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
  bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.

 arch/arm64/net/bpf_jit.h                     |   1 +
 arch/arm64/net/bpf_jit_comp.c                | 105 +++++++++++++++++--
 tools/testing/selftests/bpf/DENYLIST.aarch64 |   2 -
 3 files changed, 96 insertions(+), 12 deletions(-)

-- 
2.40.1


