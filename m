Return-Path: <linux-kernel+bounces-19255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A2826A63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73371F22186
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672614002;
	Mon,  8 Jan 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMoVhfyU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014111C80
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so1654493a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705138; x=1705309938; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E0vDlQoKyAco+NdcD9yAh9jSMQmjmWkpatnJ10hqzJI=;
        b=WMoVhfyUnec6uL7nML6et7BIbQyFV/tIH3Mx5dd6+BxjN807yPJRLbZTBrrHe0we3Z
         Gwv2pkDsrhWbhQfMEM1iaiSBlJHvb51t/4cU0UxyO/BV9OK+Ad+ZMiOf3+/WFTkW99yG
         309meYdvXbpOGizhSA2vBKIaw7PnmGbY+1CKqrkRnj7AYl/KCN2wI70OFrFWsG/dseOM
         mgnOC9IrfSjbR2dN+pF3H5uxkX/uYBJXcPwZ2ElolDtc0VbH4XuDAf5JC5DTU5BuQNGZ
         EbcJKcMGJ3BNJYc4eGLUGCg+q27xPNOgG2xXGO2XeN7fF6IJB0iHLd90UC40qhETQ87V
         pbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705138; x=1705309938;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0vDlQoKyAco+NdcD9yAh9jSMQmjmWkpatnJ10hqzJI=;
        b=HGeQ3IuB/q05IVMtyXlbrN+mpCqQ/W19qPWSen6pQkFKfaqISi159wOmdGtsU9XdSP
         OfnPDZaTmRDGygQVjKr0mcbjNVKF0kDNYJ7U/hV5qwoHCm80VEgGeTeWq4vdQRZ/nuzb
         QicSLtrCXqEqohgxOFfsD8Blhaj4lwYkRLS+zxV52pszifxiSqn48XTfks4dd07fzneN
         GXm4T/C1+FfonHyLPoCZy0FSBpDVBlNhJmkkFJuOsBhriGAXHJkO/VW8ywO8BLmwckC6
         O1vtkBMSjLSBY5uoolBuE6QfilAV7jLfi371P2HWW7T615YaeIo3luCJLalD1s1Kh0Lw
         4zGQ==
X-Gm-Message-State: AOJu0YxR2PphzX4sWxDXoCBTVvqaH/IGuhofEqs9PlDH3GqjWLL5IScK
	/roDeHFAsl1najrTT/f7/W0=
X-Google-Smtp-Source: AGHT+IFj6sV+jmOFGWsReop6qpbNW3+Kiar0tn0Wih/HUFEiHMMcg9gxlY61wiPNxyfmL2clHiYwgA==
X-Received: by 2002:a50:8e05:0:b0:557:5d3c:955 with SMTP id 5-20020a508e05000000b005575d3c0955mr1548636edw.50.1704705138313;
        Mon, 08 Jan 2024 01:12:18 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a056402164c00b005532a337d51sm4054571edx.44.2024.01.08.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:12:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:12:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.8
Message-ID: <ZZu8bzshIjF689TQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-01-08

   # HEAD: 2b9d9e0a9ba0e24cb9c78336481f0ed8b2bc1ff2 locking/mutex: Clarify that mutex_unlock(), and most other sleeping locks, can still use the lock object after it's unlocked

Locking changes for v6.8:

- lock guards:

   - Use lock guards in the ptrace code

   - Introduce conditional guards to extend to conditional lock
     primitives like mutex_trylock()/mutex_lock_interruptible()/etc.

- lockdep:

   - Optimize 'struct lock_class' to be smaller

   - Update file patterns in MAINTAINERS

- mutexes: Document mutex lifetime rules a bit more

 Thanks,

	Ingo

------------------>
Christophe JAILLET (2):
      MAINTAINERS: Add include/linux/lockdep*.h
      locking/lockdep: Slightly reorder 'struct lock_class' to save some memory

Ingo Molnar (1):
      locking/mutex: Clarify that mutex_unlock(), and most other sleeping locks, can still use the lock object after it's unlocked

Jann Horn (1):
      locking/mutex: Document that mutex_unlock() is non-atomic

Peter Zijlstra (2):
      cleanup: Add conditional guard support
      ptrace: Convert ptrace_attach() to use lock guards


 Documentation/locking/mutex-design.rst |  18 ++++
 MAINTAINERS                            |   2 +-
 include/linux/cleanup.h                |  52 ++++++++++-
 include/linux/lockdep_types.h          |   2 +-
 include/linux/mutex.h                  |   3 +-
 include/linux/rwsem.h                  |   8 +-
 include/linux/sched/task.h             |   2 +
 include/linux/spinlock.h               |  41 +++++++++
 kernel/locking/mutex.c                 |   5 ++
 kernel/ptrace.c                        | 154 ++++++++++++++++-----------------
 10 files changed, 197 insertions(+), 90 deletions(-)

