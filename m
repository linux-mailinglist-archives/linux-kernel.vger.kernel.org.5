Return-Path: <linux-kernel+bounces-112290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110B8877FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2024EB21549
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B310A36;
	Sat, 23 Mar 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfq9SEhn"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E901A38CF;
	Sat, 23 Mar 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189869; cv=none; b=eB6B6ZGgc+J2WkVGkHUgQwR6hxVz7R2DlN9TXZ6RIkZ14Zr0PqbJk2QZxpzFU2QL9l0NRkWueeLbv6NBmXQHZT4HikxxtETdIHRF3wsmC5iMquGFZfcDlMGWUCl4BlUn6/Cq1N3cpc2evr56QNZaUWKDsmJPRFraoZHxTuyYA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189869; c=relaxed/simple;
	bh=TkVXcG1d2qiILwljSbo4IShXE5Zgdx7k7NL3xCxtGag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JH38tjng1SNoFJWoJ/XHmKwtSfZO3TjW1MsPptg41ukTbuPyqsm7Em5kO08WEmBF71UYzhoMBXtgFtwOkXrUOXAb4DpkSCCsYYEtjz2yBhVAyvHJIYkIoYQXdz4NuyVTTb82UkdLwanLshY8jxb7jaZAgeGZk7S/WNgtbucIEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfq9SEhn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e162b1b71so2278413f8f.1;
        Sat, 23 Mar 2024 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711189866; x=1711794666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwChgsiib61i/qQJ49UyZsVu/x/VLxOqlOZmuWY4oT4=;
        b=Kfq9SEhnxjuFfkcUjm+PH0BM0ww0EZsQ/B0bztE0NiLSHWhVeIKVTqPA0cGJs8WiDQ
         5Wp2Hy33w/UfmrEYlukjPnwPcAub2/jEqRj6ktGv/1TM6SQTcelS+gg/UFwBybX8yQ2F
         U9ISZLC0ccObs6rwS8Erz2bV2ezu03xLTrpQAl+udqn5uZ/gpwTxtMoue9hm8+LUrJoY
         tTX8fYWpdzJT8MOcTnWwLVJwSc2soLuxD7E31Npu8oF5a1BfLq0lr88kDaVuA2UlfmFn
         haqVEf8AMxJs3Ugh4dL3uWgzQBRRVO9JVkf+1PUkXPXPileud828a21XcTbUh1j97KyL
         rXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711189866; x=1711794666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwChgsiib61i/qQJ49UyZsVu/x/VLxOqlOZmuWY4oT4=;
        b=T+Biov8CvdprcK82sikQ4/tfONVgqYvlA7H4YdUh/h5smcptBha1BBsIi559tLO6M9
         D5J9Eg/H0QejegHzmfMdKYiPCP8GTZT8pCfBXAwz+xghgyLt8q+XbleZMgCg4IE7py3P
         Kd1o5VIYm47DmCJfaNU2zbHp0eGVH3UQFeiHQhx59XP18Hs3v6McW0ePjts5TYVzhRrf
         4BCS7F8iFXxlAtjv0XqFQbVbWAdnPb2ncNjEcZ6jCj9UNWzDzCCVL0WyHAir98vDGOPG
         9RQzGlezYArO0Dwsisd9NmVodweMu+Aorln8ewITbdbqC+1tHysHYa/dE816RWD/OIFL
         NQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVLivo1gnKEh52IkQmlXskPiDHwbIyyWi4b0c8ATHuI6ldxIF67kjUfVZ7CCgcOxnPeUl8GvlNs8SdhazIQuZGmTTgGrvzMEhFsEJ1IKNUzIU0pxiekuEkbaY6bE40VTRFj
X-Gm-Message-State: AOJu0Yw9dQwStMQ+3/bNO1zzZsqVxppcyO/Vz9bSxE31bknTrvrgaWxQ
	FY7igvK8iUqCpP4illWcUIKjNYlxoFMhEIn5WpBXHVqnzGPzY/Ai
X-Google-Smtp-Source: AGHT+IHn2IxSaPcrU6i/6QXeuvR+V3EUB67GVPfoglaJgXC/rAVyMkVYctlOSl18f7oqvhKUFkLsfA==
X-Received: by 2002:adf:a4c5:0:b0:341:9db8:6269 with SMTP id h5-20020adfa4c5000000b003419db86269mr1094899wrb.48.1711189865964;
        Sat, 23 Mar 2024 03:31:05 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id h20-20020adfa4d4000000b0033e68338fbasm4155621wrb.81.2024.03.23.03.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 03:31:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/2] bpf,arm64: Add support for BPF Arena
Date: Sat, 23 Mar 2024 10:30:55 +0000
Message-Id: <20240323103057.26499-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V3
V2: https://lore.kernel.org/bpf/20240321153102.103832-1-puranjay12@gmail.com/
- Optimize bpf_addr_space_cast as suggested by Xu Kuohai

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

The verifier_arena selftest could fail in the CI because the following
commit is missing from bpf-next:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=fa3550dca8f02ec312727653a94115ef3ab68445

Puranjay Mohan (2):
  bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
  bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.

 arch/arm64/net/bpf_jit_comp.c                | 87 +++++++++++++++++---
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 -
 2 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.40.1


