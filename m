Return-Path: <linux-kernel+bounces-122530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8D88F91C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8055D1C2B2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7251C28;
	Thu, 28 Mar 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyk96+CI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C81EF0E;
	Thu, 28 Mar 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612253; cv=none; b=WY+ukt7RMnhnE2bDof/lCHHGcn1svCPv/4ogB67Fv8JiobzE2rnGzle7/4lsbkUfDAMrGqos26SGC3d8oMiiOC4lXk0bYy/SJGDPZKVuCVjOv6++ZrRiW4xxMqF44HScCZ8bjk2UBUMvBFilaxKRAmkulKFi9d7T6jgoTGlDtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612253; c=relaxed/simple;
	bh=qlC9DkYFkkvL93MPhdhtUXJJp8tkNbJWevmd6FmfsJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJJ0RsC61LBg95pW3sWPpprKH/2F8FgQgJ9hkU1sXHLgx+Xu15IwlDtMhFNc7VQT6yLkh93yVlu8UJQvGg64jdrBL9ziQMDmxZ006kqqe31kcfPmtG8owiPT7PMvcxocjqaUee/JMewJkGmluyLB9h78xoUxrZTqC3GREBn1pvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyk96+CI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0bec01232so6044265ad.3;
        Thu, 28 Mar 2024 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612251; x=1712217051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R85AsXScbEz12UU7rf0ghEgyGGHyz4cOYh1MWUd1+YA=;
        b=Nyk96+CIMwHHmF9q9KIGStp3zAJ9pMoWKNbyeLbPmFWytVIEZV5YhUmoL3jf/gtB2n
         0UdZGF7y11nyvQ2/EUxdIcdq45+uLBgGfd614z2K+zwOYufYKoUmubTaaQ467EnkqBAB
         5+faI8j2yqLK2oQ1FLS4iFf/K5lqOlUMjzu9eu7AsXZIwj1owQD0kcW2u9AngKDPzqXF
         zqZ3jWm9Ku0wF/RfgMzIxvHPtqY3a5n5uEBQYGksS+li7UB98zjAM4LLbyIwoS54h8Hi
         oXsWmcXMhDFfcC6n7dj8i/rwGcIdcL59cH1KeYs6D0tjZzazcA3mWgpCuWTf2U3yjusN
         EHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612251; x=1712217051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R85AsXScbEz12UU7rf0ghEgyGGHyz4cOYh1MWUd1+YA=;
        b=H/TmLUrG7NDopWdYtM/FuQ1oZY7XGzHhs07kPDB2JgVKQA7oaIPF5uyX+H8E5UKwpd
         Khq2beIXSYWO/nNM8+tP3dxNo+Ryc8G8JApzARUNcppp3tko/bn0JruePU1rhpfUzQ91
         kXoZGCdt+ejyWQJbu76ilf/G9gxWjjOqy9ZY8PpCBA2pzvDKueojb1yOb+tzJLB51mcU
         LptV31oohzYvYvF8qQCsuP9HpqYewOkHFBJwvFISegJEo6gzVMb8DbS82AMdI6dvchQv
         fKHD2Mz/lGoL6fjAntbMvbhPKJuDvf7zFSdwwc2IbMR7bdarABc+HJRwb0yp24DLJCUj
         ze4A==
X-Gm-Message-State: AOJu0YyNH2RAiWnmwMDcMt/Zdhw3Cf0R/lieFuOxbihb7FAxWGCRR2Ix
	eU7HcKFH5c8oYajm7Zai9L0i6uotVtgX5N0ZVRgMpl1sgv/SmX7MeLYuRf34
X-Google-Smtp-Source: AGHT+IGcSOJ8UiM7ubjVfnmCp+pwDae3zWI5bm5or2EdD4XUOtWGEwIv2QWnuiBPLPo4aeWJYiMVnQ==
X-Received: by 2002:a17:902:e541:b0:1e0:9122:abc4 with SMTP id n1-20020a170902e54100b001e09122abc4mr2345672plf.21.1711612250907;
        Thu, 28 Mar 2024 00:50:50 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b001e0ea5c910dsm862362plh.18.2024.03.28.00.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:50:50 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 00/10] rcu/x86: Use per-cpu rcu preempt count
Date: Thu, 28 Mar 2024 15:53:08 +0800
Message-Id: <20240328075318.83039-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

X86 can access percpu data in a single instruction.

Use per-cpu rcu preempt count and make it able to be inlined.

patch 1-7: prepare
patch 8-10: implement PCPU_RCU_PREEMPT_COUNT

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>

Lai Jiangshan (10):
  lib: Use rcu_preempt_depth() to replace current->rcu_read_lock_nesting
  rcu: Move rcu_preempt_depth_set() to rcupdate.h
  rcu: Reorder tree_exp.h after tree_plugin.h
  rcu: Add macros set_rcu_preempt_special() and
    clear_rcu_preempt_special()
  rcu: Make rcu_read_unlock_special() global
  rcu: Rename marco __LINUX_RCU_H to __KERNEL_RCU_H
  sched/core: Add rcu_preempt_switch()
  rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
  x86/rcu: Add rcu_preempt_count
  x86/rcu: Add THUNK rcu_read_unlock_special_thunk

 arch/x86/Kconfig                   |   1 +
 arch/x86/entry/thunk_64.S          |   5 ++
 arch/x86/include/asm/current.h     |   3 +
 arch/x86/include/asm/rcu_preempt.h | 109 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c       |   7 +-
 include/linux/rcupdate.h           |  36 ++++++++++
 kernel/rcu/Kconfig                 |   8 +++
 kernel/rcu/rcu.h                   |  15 +++-
 kernel/rcu/tree.c                  |   2 +-
 kernel/rcu/tree_exp.h              |   2 +-
 kernel/rcu/tree_plugin.h           |  41 +++++++----
 kernel/sched/core.c                |   2 +
 lib/locking-selftest.c             |   6 +-
 13 files changed, 211 insertions(+), 26 deletions(-)
 create mode 100644 arch/x86/include/asm/rcu_preempt.h

-- 
2.19.1.6.gb485710b


