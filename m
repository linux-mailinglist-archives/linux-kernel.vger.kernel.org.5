Return-Path: <linux-kernel+bounces-112397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED8887948
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E586928301A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB914502A;
	Sat, 23 Mar 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du1NX8mp"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97E45BF3;
	Sat, 23 Mar 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208838; cv=none; b=rr9wbWuJHUxvaH4GYcgFvdzmY74hQq3ByKWZ8TztLaLn80opJ+HpACLF2RyXgxsdKx5rr+OIYeU+DkL7rMl5fnczUSJ12Yjue6PgTZ6oJi637T9xkGdeaiOxdS61C1jgiHm2Nv+UQ2/BZTBsClkilmQEV4IdWAC4VZ3LSYcnLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208838; c=relaxed/simple;
	bh=VwjJtGko5WC6moVs2lpU2UyRd2ZgOQn7/miu/V/CtNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gw0VarNIEe1xc6gzNwILGOXFKgeuC4HDkyF97NmKyOUajXitTJb0buzQWjKO1RMZ8v8dl62uBuzU4pKEwdlcEkffcjLh2IVKQ8BDxpRYXefj/y1zYeXv6uQTwOOYCUh6nE0ieURGftwsDqI3iVrOp6LfUkSL1LqArx7VuKWfaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du1NX8mp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1897826f8f.2;
        Sat, 23 Mar 2024 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711208835; x=1711813635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMU5gNAuADzB5Tcq4mD6yx393J+u7FkWid9t2/0ApH0=;
        b=du1NX8mpkeEzlz81IZMPGWTnKJR4TpnysacGo/70vxEIRs6nxmDjicH5V7uYZ3PO6J
         obDQBXHpwWnKrPngFDImcnHgI9Fmz1gqmihnGZsDx8dkUm3lnlbHPcLRWBkvT0haCLZz
         5gORDJpfyKCufDo7q3+K20k+R0Yn0tUIR6AJyYMPQjjlzUy0LqIvmgRnI14cGAxBdGFj
         vizyD6v3E/WD1MDycP7uVXmrB9/SB4fCFvynmfMhmuNfAPn5mLiiipiSjfloGQ0hxM0S
         GH1JQ9m50Ab2wUqyy6rCc5j6mXFBCWzDF2+f6uyRXcyoCxhFB68DBe/4L1IeMDNoztoE
         32AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711208835; x=1711813635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMU5gNAuADzB5Tcq4mD6yx393J+u7FkWid9t2/0ApH0=;
        b=IzV8zTCZDK0lIKXZGamhUfBwPiEe0NsNXEwLrlJlpLNvStFgKP1O5yF/FsUX6qMKXO
         +U0vgTeswRRSXSvnI1Ls+8Bk4ksI7taiywPf1OtL0On/0b75K6kfO/MVWLixNrHvCof9
         VMUs/O4N5BYnQfwHVIU+srZ4SlKklZEHVDxtdlVEeOza+5gywsq6/o3X5nlwPS3g9BK7
         Hhmv2wKTSsUdvYX/lQX2Te6xnamhaB/FMfzdnwr9jD85iPjLnFWQLT9T9CsbwHpcGb8l
         VkQMzzcmXy26sMfPKwGL29Lo9hj6LSa5hxgy8bV/ZJshpRqRtqdlCxQt8I7tZs2aATUd
         Z4gw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIQ9CEkmVugb1Vvr5BMjk6MR28tQV7wcPGLEPfy8EwbpJIU1NOKPV11N73KEhlepPUjBNXC4hUD4Nn4z7dHfipsYVZwvz4qYmaqBikfq8dPM7qbOmWHMFcY2kvNeUQNDi
X-Gm-Message-State: AOJu0YwFKMwZDhiEgrYCnhhPMsQqy6n3SWVit3X6ZSZTj5CL9n1RS3hA
	w9MD0MpRDJDy84kXvnpleSgL7MzbohzVFSW0S8SaG1dcje8J0Qy6
X-Google-Smtp-Source: AGHT+IH/IKbgeQ/i+N5Wg6tsT0hn/z/Fll6a4YCP+GxaBGqM4pQZ/LTjS10uSGbsNkzc/9U74IyS8g==
X-Received: by 2002:a5d:6a0a:0:b0:33e:7979:edc6 with SMTP id m10-20020a5d6a0a000000b0033e7979edc6mr1887414wru.15.1711208834702;
        Sat, 23 Mar 2024 08:47:14 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033e756ed840sm4676011wrb.47.2024.03.23.08.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 08:47:14 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 0/2] bpf,riscv: Add support for BPF Arena
Date: Sat, 23 Mar 2024 15:46:50 +0000
Message-Id: <20240323154652.54572-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This needs the following commit in bpf/bpf.git to work correctly:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=f7f5d1808b1b66935a24dd796dd1a0612ca9c147

Puranjay Mohan (2):
  bpf,riscv: Implement PROBE_MEM32 pseudo instructions
  bpf,riscv: Implement bpf_addr_space_cast instruction

 arch/riscv/net/bpf_jit.h        |   2 +
 arch/riscv/net/bpf_jit_comp64.c | 208 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |   3 +
 3 files changed, 210 insertions(+), 3 deletions(-)

-- 
2.40.1


