Return-Path: <linux-kernel+bounces-19203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61C8269BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF392827FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28611BE65;
	Mon,  8 Jan 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUoVk1SL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8310A19;
	Mon,  8 Jan 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso18348255e9.1;
        Mon, 08 Jan 2024 00:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704703514; x=1705308314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzg4HzfPcWhfRiLrivgKIlyEbM/OTkAKrGpME537imM=;
        b=OUoVk1SLuhTrJfmssWYNCL+n2B72hL+KtnpxksgIvWYm2bEUf33wFAL0glk+5o3hm/
         iVlC7eDb15rY1inzway4MrVBHrFgoGkm6ys1gmJLqwo/ixzZcOoBNuQWe/F7ILJ+UtPC
         UO1jp8n5sDfcu56ZkIQyX9wdNay/d1TiR7mv68NHdU6xlk/TapNA9225I596eK/ZLncw
         M+VzZKa7QAWcfi5eZfAfgildslL8Pp6qv0zaOuEcjHh/F0knSLnsxUnjQNDAcwJitqIJ
         avz35GTlU8z/+ze1vEhgoTRKM9dp1IiEwbwEZkYBngAarYIgSD7v2L648MBnamWuCJs4
         J1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703514; x=1705308314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzg4HzfPcWhfRiLrivgKIlyEbM/OTkAKrGpME537imM=;
        b=fLMOFiOq+WomA743SNmXiFAhEVgRLW3xVbApcn1OhVlXiey9yX5Jr/q/7OuOwKeZDY
         6ZoyCdhlw+SagHy1WdumKbyaXB93HjPUWsQuYBPEemHtKjk4Q/ey9VPOk583TFYy5Zjr
         pFN9vBoduBYKTmxb5SlViQX556c78IdaEGxkTLA+5QvIoXs/L+qxQhaJDx8/vWzkCR9/
         /z96hEZUBZbeK5yn23Y3nmFNY3bj/mP/fXtCf2IdMHA2O7eicXd/8so8m+wrVcWHMZnh
         zqvHA31yALNZUwelDgpIBebyRa1xGQtSMS8bmFfsrvNxRmMtBl06SzG9g4Nze6j61yeh
         wmIQ==
X-Gm-Message-State: AOJu0Yx8bpV39yQmfrkvKA62CVDnGBMn3btMlcrTI7+qNDdCYpgO9gtd
	IGHuco+nqavOD9DQJOC1eog=
X-Google-Smtp-Source: AGHT+IFMLGmSbCjUFO+IBcZAPlZAVuir8TFgJhtrxznRO3uQG3ahegbc1LmBIuwgivVsCJJBEfg7pg==
X-Received: by 2002:a05:600c:a42:b0:40d:8f82:79bb with SMTP id c2-20020a05600c0a4200b0040d8f8279bbmr1779956wmq.182.1704703513816;
        Mon, 08 Jan 2024 00:45:13 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b0040d5ae2906esm10256913wmq.30.2024.01.08.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:45:13 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 09:45:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Jann Horn <jannh@google.com>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] locking/mutex: Clarify that mutex_unlock(), and most other
 sleeping locks, cannot be used to reference-count objects
Message-ID: <ZZu2F8KNygWzWVY7@gmail.com>
References: <20231130204817.2031407-1-jannh@google.com>
 <170142744948.398.4203675877225809071.tip-bot2@tip-bot2>
 <20231201121808.GL3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201121808.GL3818@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Dec 01, 2023 at 10:44:09AM -0000, tip-bot2 for Jann Horn wrote:
> 
> > --- a/Documentation/locking/mutex-design.rst
> > +++ b/Documentation/locking/mutex-design.rst
> > @@ -101,6 +101,12 @@ features that make lock debugging easier and faster:
> >      - Detects multi-task circular deadlocks and prints out all affected
> >        locks and tasks (and only those tasks).
> >  
> > +Releasing a mutex is not an atomic operation: Once a mutex release operation
> 
> I still object to this confusing usage of atomic. Also all this also
> applies to all sleeping locks, rwsem etc. I don't see why we need to
> special case mutex here.
> 
> Also completion_done() has an explicit lock+unlock on wait.lock to
> deal with this there.

Fair enough - but Jan's original observation stands: mutexes are the 
sleeping locks most similar to spinlocks, so the locking & object lifetime 
pattern that works under spinlocks cannot be carried over to mutexes in all 
cases, and it's fair to warn about this pitfall.

We single out mutex_lock(), because they are the most similar in behavior 
to spinlocks, and because this concern isn't hypothethical, it has been 
observed in the wild with mutex users.

How about the language in the attached patch?

Thanks,

	Ingo

================>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 8 Jan 2024 09:31:16 +0100
Subject: [PATCH] locking/mutex: Clarify that mutex_unlock(), and most other sleeping locks, cannot be used to reference-count objects

Clarify the mutex_unlock() lock lifetime rules a bit more.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20231201121808.GL3818@noisy.programming.kicks-ass.net
---
 Documentation/locking/mutex-design.rst | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 7572339b2f12..f5270323cf0b 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -101,12 +101,21 @@ features that make lock debugging easier and faster:
     - Detects multi-task circular deadlocks and prints out all affected
       locks and tasks (and only those tasks).
 
-Releasing a mutex is not an atomic operation: Once a mutex release operation
-has begun, another context may be able to acquire the mutex before the release
-operation has fully completed. The mutex user must ensure that the mutex is not
-destroyed while a release operation is still in progress - in other words,
-callers of mutex_unlock() must ensure that the mutex stays alive until
-mutex_unlock() has returned.
+A mutex - and most other sleeping locks like rwsems - do not provide an
+implicit refcount for the memory they occupy, which could then be released
+with mutex_unlock().
+
+[ This is in contrast with spin_unlock() [or completion_done()], which APIs can
+  be used to guarantee that the memory is not touched by the lock implementation
+  after spin_unlock() releases the lock. ]
+
+Once a mutex release operation has begun within mutex_unlock(), another context
+may be able to acquire the mutex before the release operation has fully completed,
+and it's not safe to free the object then.
+
+The mutex user must ensure that the mutex is not destroyed while a release operation
+is still in progress - in other words, callers of mutex_unlock() must ensure that
+the mutex stays alive until mutex_unlock() has returned.
 
 Interfaces
 ----------

