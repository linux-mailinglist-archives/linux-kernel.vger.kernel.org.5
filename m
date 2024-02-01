Return-Path: <linux-kernel+bounces-47661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BB8450E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A93B26F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE9178B66;
	Thu,  1 Feb 2024 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Z7W1Csz4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A4612EE;
	Thu,  1 Feb 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766425; cv=none; b=Nq27Z1F7oHaTHqD/H9SrD++f7qH+h0qEufwun0WPTRPr7hR7LwJXZjCwvsz2cA4MZLc79JPncY/R1Lk0MhgFRxJrjSgMVemy6+GAt1erGAnDO+ygCBMNjxjezI+sFLEyN5b+DCvzENtKcLR46n4ZzL8dpCHR3TNshgvO9eZM85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766425; c=relaxed/simple;
	bh=ybfkOrGY7XUkUYn6qLq1G4d+b5az7wtgUrTBTKa4DtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBikafVQg8iO1berlXRFlVrr0n76RWwA9qIvPL8wK/xFp6C6YYwAyfh2SwhLe1Q6ZcZmx0hc1c5MUd7WQpLfXGMlBs40ELpVLioCgYjPaiRuL2OZVHWn1g89+UwSL460nUdcq3oChJgJoI5sZiAegJIuwvVd2tHOET215e/AO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Z7W1Csz4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4115kU5G3816769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 31 Jan 2024 21:46:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4115kU5G3816769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706766394;
	bh=NnI+ixxEJIjCDHzMNs2KvyM1MBjUL2v+GswxZaV0nbs=;
	h=From:To:Cc:Subject:Date:From;
	b=Z7W1Csz4bxl4OqpAKF6mPoNNyssxL0kX0YYcDkA2iD42J+LwybUfhhMvsivR3PWa7
	 GKa5nXMz8QJDyewLMtDmCghSEVHJNrS3gfbYnVuET+T24eNSGIFvMFmT4S1GeNyzg/
	 hlVBYLI7RrkSP8Zaauna45VOMrM/Biqsfq5po1pYGYzS/m/s20mDyUPpAJ6PsCajCc
	 q3LDgLBPG6q0G7m2FrAq6cmIbI2R5XQQUEq1e5UEpyu5EJehuGYHFK+XLrsO9XL0TU
	 IrIbaNMs6ooHsUWnQktAkvaooJLK3ud74jkSJRcCaOCTAiaZ002k7gLNC4n2ZOSH4v
	 W6OBD1pM4p94g==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [PATCH v1 0/3] x86/cpufeatures: Automatically generate required and disabled feature masks
Date: Wed, 31 Jan 2024 21:46:26 -0800
Message-ID: <20240201054629.3816748-1-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CPU feature is not configured, e.g., CONFIG_X86_FRED=n, in a
build config, its feature disable flag, e.g. DISABLE_FRED, needs to
be defined and added to a specific disabled CPU features mask in
<asm/disabled-features.h>, as the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/fred&id=e554a8ca49d6d6d782f546ae4d7f036946e7dd87

This patch set adds an awk script to automatically generate a header
with required and disabled CPU features masks based on build config.


H. Peter Anvin (Intel) (2):
  x86/cpufeatures: Add {required,disabled} feature configs
  x86/cpufeatures: Generate a feature mask header based on build config

Xin Li (Intel) (1):
  x86/cpufeatures: Remove {disabled,required}-features.h

 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |  16 +-
 arch/x86/Kconfig.cpufeatures                  | 149 +++++++++++++++++
 arch/x86/Makefile                             |  17 +-
 arch/x86/boot/cpucheck.c                      |   3 +-
 arch/x86/boot/cpuflags.c                      |   1 -
 arch/x86/boot/mkcpustr.c                      |   3 +-
 arch/x86/include/asm/Kbuild                   |   1 +
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |   4 +-
 arch/x86/include/asm/cpufeature.h             |   1 +
 arch/x86/include/asm/cpufeatures.h            |   8 -
 arch/x86/include/asm/disabled-features.h      | 154 ------------------
 arch/x86/include/asm/required-features.h      | 104 ------------
 arch/x86/kernel/verify_cpu.S                  |   1 +
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 arch/x86/tools/featuremasks.awk               | 108 ++++++++++++
 lib/atomic64_test.c                           |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h      |   8 -
 .../arch/x86/include/asm/disabled-features.h  | 154 ------------------
 .../arch/x86/include/asm/required-features.h  | 104 ------------
 tools/perf/check-headers.sh                   |   2 -
 25 files changed, 303 insertions(+), 553 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 create mode 100755 arch/x86/tools/featuremasks.awk
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h


base-commit: 078b7b997b47c7166c1240cf1d39db9f646a56be
-- 
2.43.0


