Return-Path: <linux-kernel+bounces-134274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45389AFDE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F021F21690
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912E125AC;
	Sun,  7 Apr 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaksZKTo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E318107B3;
	Sun,  7 Apr 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480610; cv=none; b=F128v/mVX0LbzMz9mM8mA4rRO3CB+hWOSO9LxcRymNFRaFtnCsza4e0B2Br2s8lsGvxinvONE+dNOTCt0miZvV8CVZKlgGtsmxUwHQx869w0bxQm4dZ7/63W1QW/d9h4AadvcDUmV0+ojhKdSX4lISosYfZJG/Cd1y3/rvHmbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480610; c=relaxed/simple;
	bh=C1ND876ga6wOsjhU/2loncqkn3wXD+UIygFGnTiw5rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLid6AvWQc3g3CEOywdzKGm9ur3CAbLULnc8g7j5J5N0kIPRDqabAHSDes7CBWNVz6S1Ndh/U7+ZFC+WSsE1SqJK3Ffw30L+dgtGzzoPDiXyYquGFCanlQLmV9EaOC1vlw4/81VtSxZyYbFlh2vWjFNtvbOfuNn7DHV/N/6B/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaksZKTo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e419d1f080so327845ad.1;
        Sun, 07 Apr 2024 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480607; x=1713085407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1bFR4gVDaJQ4aqQ51G3SX0DM+161YZC2qeUsvJ8EuA=;
        b=aaksZKTo1z9+f0PWr816QKABd7n4LOGqb2QYym5CxPtAx6Y6Kmkk4FwzhqJ68ahzh2
         sI1meLcZdrvFNa8YF2VrwdCC6y2vQ2x0X+4OkgWl3jW/EAK37BsbVLi/BCBkqEe/rf2Y
         kH4fMoBEP8VevhXcr2cOW4B+DTnIjO7xvjTRhf/591TPOFUry9bQ2u9z5Bn6lai8O+CP
         IbSQ7v8CvKGZPg2uyiI6ZkGcZJsMzQN3s6+1uEONHUVa0fCZKa3Ld+fjkixNRy64hDZf
         8vLtwYY/+JBTfcASlpCjzWN9ste9dE7pvkI4cI+GTeyAnilDHIjV8yOnfq+JalJZfYW8
         0VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480607; x=1713085407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1bFR4gVDaJQ4aqQ51G3SX0DM+161YZC2qeUsvJ8EuA=;
        b=lxGfxslyycnRjqae/wCAsZmufTVScm3pwPu8iAcAw7ieV0Dzz3x0EXNPZoDClUCOh+
         KFA5ps3bow3rCZnW1/cYvRUKmTnj3TngOnQCSYFlk/0zuj6Gn8cilH5y/vas8D40KdYD
         4iEZqLfSBta+Yz9CiyieExtP9MKCvSO/3bO0qE+SAekYszWEsrQo1pGHyUXlSS9C/Feh
         T4PM7+KO2MO4GDj5CtxVBeBtAXwBpRAh63UHA7/OTcD38/H7AlA7fi7RiOmmEacDAOVp
         6vTJaPs7FhOZwY0dfxB1Qq31wIijPC0e2qu2AUHlvHLtXiLHH9rBkjd6xuKQGiHcnk+F
         rsdw==
X-Gm-Message-State: AOJu0Yx48S6ht5+zn6qvC91fMACz64VNbEl1UMJWhm/JXUQiNzwx9MxV
	dksNE7iKDecSgn1NXYFoEmSfgQc86cSlUUz55Xv7hXozcNjSfNwybDxMmBtP
X-Google-Smtp-Source: AGHT+IHGzUUXPzELIiLivkTMJF4A9K7JA7R4Mx8XrmfEQDIn9agWRTnAWyKssQPGECrN9hIIbfWtUw==
X-Received: by 2002:a17:902:d896:b0:1e3:e256:44e0 with SMTP id b22-20020a170902d89600b001e3e25644e0mr2116520plz.31.1712480607365;
        Sun, 07 Apr 2024 02:03:27 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b001deecb4f897sm4527258plo.100.2024.04.07.02.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:26 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH V2 00/11] rcu/x86: Use per-cpu rcu preempt count
Date: Sun,  7 Apr 2024 17:05:47 +0800
Message-Id: <20240407090558.3395-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>


Changed from v1:
	Merge thunk_64.S and thunk_32.S into thunk.S
	Add missing #ifdef in arch/x86/kernel/cpu/common.c

X86 can access percpu data in a single instruction.

Use per-cpu rcu preempt count and make it able to be inlined.

patch 1-8: prepare
patch 9-11: implement PCPU_RCU_PREEMPT_COUNT

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>


Lai Jiangshan (11):
  lib: Use rcu_preempt_depth() to replace current->rcu_read_lock_nesting
  rcu: Move rcu_preempt_depth_set() to rcupdate.h
  rcu: Reorder tree_exp.h after tree_plugin.h
  rcu: Add macros set_rcu_preempt_special() and
    clear_rcu_preempt_special()
  rcu: Make rcu_read_unlock_special() global
  rcu: Rename marco __LINUX_RCU_H to __KERNEL_RCU_H
  sched/core: Add rcu_preempt_switch()
  x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S
  rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
  x86/rcu: Add rcu_preempt_count
  x86/rcu: Add THUNK rcu_read_unlock_special_thunk

 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/Makefile                |   2 +-
 arch/x86/entry/{thunk_64.S => thunk.S} |   5 ++
 arch/x86/entry/thunk_32.S              |  18 ----
 arch/x86/include/asm/current.h         |   3 +
 arch/x86/include/asm/rcu_preempt.h     | 109 +++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c           |   4 +
 include/linux/rcupdate.h               |  36 ++++++++
 kernel/rcu/Kconfig                     |   8 ++
 kernel/rcu/rcu.h                       |  15 +++-
 kernel/rcu/tree.c                      |   2 +-
 kernel/rcu/tree_exp.h                  |   2 +-
 kernel/rcu/tree_plugin.h               |  41 ++++++----
 kernel/sched/core.c                    |   2 +
 lib/locking-selftest.c                 |   6 +-
 15 files changed, 212 insertions(+), 42 deletions(-)
 rename arch/x86/entry/{thunk_64.S => thunk.S} (72%)
 delete mode 100644 arch/x86/entry/thunk_32.S
 create mode 100644 arch/x86/include/asm/rcu_preempt.h


base-commit: f2f80ac809875855ac843f9e5e7480604b5cbff5
-- 
2.19.1.6.gb485710b


