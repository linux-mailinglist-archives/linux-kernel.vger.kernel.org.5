Return-Path: <linux-kernel+bounces-117416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86BD88AB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666211FA0797
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD914D454;
	Mon, 25 Mar 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrhuqgoA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873459B7A;
	Mon, 25 Mar 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382082; cv=none; b=n+qA7qrVhwEN8JsPUzoax9Pg3sqmdcjSBwomMgcPZ/Dgnh1N7w+xxb5h/xS72Qy7XX46AJI3xwYM/CKQAFnx1ulSZBJKftDl0tx+0ynRxdRwjR3AL8WW7ytZJt16Scar3Ic+pmc/OKoe/Cj2Rf/lz072FjG03yZ2FWeWU24ixoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382082; c=relaxed/simple;
	bh=M/2LdgTMKAufsJ70oIyDRe3UWyNSr/he1uekNnQXBmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YcHqT+hblPRGM+Xu+guv6SBoXMfYiSmlo4dyc6lzC7Tam/oxDcZklMw0QSva9Ob+KwBjs2CfIyqB5SW4isM9rLjbEduv1R9mAVDGOCehNocKXo8GKcdU1jpTdM2eW7QEf29+ekpBx/9IWbQVrRZQeBFTUwJ/8OemXUS5gW4f7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrhuqgoA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c65e890so1679915e9.3;
        Mon, 25 Mar 2024 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711382079; x=1711986879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epYSjFUVIoqSYnJF4jivkOHZPoqysXSoHtzsW/w+7kg=;
        b=DrhuqgoAAzU06qipKLrhZbqNtk4K6+PqjDpMQBupiuQ7N2GOb16XcWPjHi89y5qM4J
         G4pOZLi0iErla6uihU8SmO0uOPNcuYEpFLUSmbyfelWxkxvAMS9rZmsq2XILYRb/rjZe
         IBtbpWP4NLKCqybrMn41XIAPogmD3NMwO86Zh+5V8FS2Lrornjzs70NhGyeVOY38FRMw
         B6ZLSpEK81f6hk13bpsClvReHiABETnm6bLpW2Qx4v81ciA+HpQEpc2h6EJYiB7Jwlwe
         J5SaU8Q7ZuwK8nzaYIJe6f4GVMWZ7ynXmdS4/Oyl55SSRSPxn78uABzDCe4AKFXVWORY
         fiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382079; x=1711986879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epYSjFUVIoqSYnJF4jivkOHZPoqysXSoHtzsW/w+7kg=;
        b=T0yZ8jQxyMhKFBUZvEDucXNQqk3a+21N+oGj1A4OoR20fX5XHYOLhf9eUTXfz8vkTZ
         q+8SITK5JdJhEmOiznosnHcgeOSIR+3kMwYAAVkcDpKZdFo8POtVbubEc/8K4DBuKy0A
         W5cRmma8a0cxkQGInxsjDLLree9ocBYP8kbWmR4bwDTEYtcwMCM7MdxemBuuT45vTkpQ
         RUVOE3fUe9jCnWWF9sqS48yVe1G5T1gy4FfV00fFEhlgkYzGJaFiXt8sufNlqC7yaV8d
         xFCU3Ex7lUwOVGa2A2gHqsUlJj6iJwBo3LuZ+O8fqr1pmWJ3NYK3V6T/xyt+o5QDa50Q
         YctA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXBfGBCEau3J68qUac+Sdw7IPJOlP4LWItcO0mYTz6gEqnPi2PWQqBirTv8KZqHn6WJ8lfr51+humOkdeLG6zM4NEtBpXIQmgTHpwrcxMbA2gxE/3wNgaou6yo0Sxn7sD
X-Gm-Message-State: AOJu0Yx7wS6VftpBaDC4yTCtjUl8bTZgXVzT5TumnpzCfl228B+kXjiP
	wAXiqGXS/BNIlGc0MU9sQr43APdmz4eTcWMDMl2uaFxywZwE3F9W
X-Google-Smtp-Source: AGHT+IFEbz9WdYcx8pprFZzZ6ugY2QPqSfQqT1rwAKa5KzId0YSU+8eOqXKCBySntr6UDCXhk7+wgg==
X-Received: by 2002:a05:600c:12d2:b0:414:cd1:e46d with SMTP id v18-20020a05600c12d200b004140cd1e46dmr5220541wmd.23.1711382079166;
        Mon, 25 Mar 2024 08:54:39 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b004148a667953sm2663300wmb.8.2024.03.25.08.54.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 08:54:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/2] bpf,riscv: Add support for BPF Arena
Date: Mon, 25 Mar 2024 15:54:32 +0000
Message-Id: <20240325155434.65589-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This needs the patch[1] that adds the insn_is_cast_user() helper to build.
It also  needs the following patches/commits [2][3] to work correctly.

[1] https://lore.kernel.org/bpf/20240324183226.29674-1-puranjay12@gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=f7f5d1808b1b66935a24dd796dd1a0612ca9c147
[3] https://lore.kernel.org/bpf/20240324103306.2202954-1-pulehui@huaweicloud.com/

Puranjay Mohan (2):
  bpf,riscv: Implement PROBE_MEM32 pseudo instructions
  bpf,riscv: Implement bpf_addr_space_cast instruction

 arch/riscv/net/bpf_jit.h        |   2 +
 arch/riscv/net/bpf_jit_comp64.c | 207 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |   2 +
 3 files changed, 208 insertions(+), 3 deletions(-)

-- 
2.40.1


