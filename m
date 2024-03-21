Return-Path: <linux-kernel+bounces-110250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2527885C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8966B240B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ADB126F23;
	Thu, 21 Mar 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2V8AnPH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35C8624E;
	Thu, 21 Mar 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035071; cv=none; b=RTshH72FHk3Nvq0FfnF3ZFAVlFjXvrQnKDcbjYVY62pSFouq5y6SnggiwRzC5IfZtdmBAbqxSw2xfO1wrOVpBCV5SbXZhbIAq29C/ExWwvsIPKYtrBmanHI7hIu1sE1GltOXVCYttwNNCLoG5AGf+iK8TvMT8FZ+mEUTK8QjiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035071; c=relaxed/simple;
	bh=zuZVbsZ2MqalPAwdY7Ruzi14ilWt8q0p1FkWTz7Nn9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PmEDyIQo6Y8n27pwv+ZJbd5+HwIhw/CCe88z67r3nOuvPJx0xYfKWAEt2Do6SrdRPwQpcAdyyBvZicJJd8owcIzM7zwijOxP88gSFGpFjmjzwvDPb8biagx33U1hSCY3EZ/R9+6whQEjlTZajP2jbMxcoIR9rssLqzeAcpM6gsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2V8AnPH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41477211086so4042115e9.1;
        Thu, 21 Mar 2024 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035068; x=1711639868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZtMkxhYHr3cmoF6PxywbCBZ7mb57k0gnbHTqu/snDY=;
        b=D2V8AnPHSSMeGCl7yDAc9u9kmoanicfn2h6YxMhkSf+1a+4KbLlKuB3vJT8sVblW8k
         Y5hqqeobpNRVLj6JcDi+eyjHHcSSfm492t4yqE9yPc163QtW+5qM8+sQb/t8aYRE5NRY
         3EGRkhqVQnLhFguV+b8J/zup3OM1T7j61EYvvYxMN0A9kR0Tvxam18I0YP1VKXDIjnWo
         OBelRKZh0pfyDfiQAEKeXwaBT38jwVF3uPgD8V4CBfS0Scoav+8mGPuAR/lKBpaxF7qS
         xU30r4E/iReY4ge+MmmGMNOEogc3+kGFpzPZRw8eM1Oa1M3XHBvqpGs6tUWR+DTlaFEU
         wI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035068; x=1711639868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZtMkxhYHr3cmoF6PxywbCBZ7mb57k0gnbHTqu/snDY=;
        b=llRCNPl73X7uLPnhlinnumaO0o1qMP6yQgWQF6RwUozkoacluYET2ugNrNNtSJBw3F
         jhGGO34T5DOi4dDFujlCt5qJ3/eLaLPujoHnLC8dVEOHULTUoBbezP28AFHv0+xynPZl
         itA961fkdn88MjoGrfxEGHn80bcGmhHCTXgPCT5/f4lOzOODCKkeBgLRlZenPPmYWvL0
         AfviOBws2KRUR1gxvWouUKWR3Io1E+KHgj/ybrWWjYOyOP2XbIpsZvqt29hQ1FnnIvBf
         //9N8I+qzpTP4AEPSEoJBbdW0kKUbtjTz6EkQ7J6k3Q1vZrJL/1tHViYVjETdogsvWXv
         mP0g==
X-Forwarded-Encrypted: i=1; AJvYcCWtwGjMKbyS3kF6IAigY/V8jf6DpjAO03ikOwR+30gYG1Fw88cNjXH2tWb5w3ytyPVL4Uky/Zb6Czb3L04soVQqzXL6q1JOnyMHIN17TIuOvrCCz0mDzlYiVz/Y66JztCut
X-Gm-Message-State: AOJu0Yw/PyO/cOTzEW0EqfKVy76rSlhl/RBDhOyIagS1i/XtMk/WI9iU
	bQYHumG6+/+gIQrh8IrtWcVYholEuHQxMOa/bcKxy+cXtl2NlekG
X-Google-Smtp-Source: AGHT+IGrc7VKuS/BUOxLA3tpAXsZ/63wxeFTnUP9ocXnK6AAEqKML+y1MoYiyLuBvSDeAuDe/5PNdQ==
X-Received: by 2002:a05:600c:a49:b0:414:6773:d13b with SMTP id c9-20020a05600c0a4900b004146773d13bmr2202794wmq.12.1711035067543;
        Thu, 21 Mar 2024 08:31:07 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b0041463334822sm88000wmb.26.2024.03.21.08.31.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 08:31:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/2] bpf,arm64: Add support for BPF Arena
Date: Thu, 21 Mar 2024 15:31:00 +0000
Message-Id: <20240321153102.103832-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V2
V1: https://lore.kernel.org/bpf/20240314150003.123020-1-puranjay12@gmail.com/
- Fix build warnings by using 5 in place of 32 as DONT_CLEAR marker.
  R5 is not mapped to any BPF register so it can safely be used here.

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


