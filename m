Return-Path: <linux-kernel+bounces-19227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3F826A04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404E32842E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45E11CAD;
	Mon,  8 Jan 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCi0nvJS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DE1170D;
	Mon,  8 Jan 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28fb463a28so143515366b.3;
        Mon, 08 Jan 2024 01:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704704415; x=1705309215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tWRPiEm6SRTvxIeaeOoy7OGjCFGwYUaCN6NMlRQxRU=;
        b=cCi0nvJS9+0/TGeMSRfF77taxvLdGS3OGBq3CFCsoIt7dSZWweLhjhp7Wm1htAtONQ
         dSR4aVm4sqIxaeqEsvfTavO69UD7ReAGwRgBUWJMyuwMmTvcJO6v9Clu5bsAnFJqmHwz
         fXSf7ltySn7o6KZ/LL6hm94+MMZ2jnbc8GNjlIK80qW3k1xdd2dEVreDjC2oKYrPBrhw
         4YbofS1DUQpCQom4nd3bJVjr1Wt6FtBbY3VCoZnJKykj4vvtsEjZjL02RPngHBN71gDS
         fwf6HDxmm7SRRZwiqJFXu/Dt0sM/MPAnwkvqN1gcfbqapKPNxzDTRujx9F8v2YWyczGZ
         giHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704415; x=1705309215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tWRPiEm6SRTvxIeaeOoy7OGjCFGwYUaCN6NMlRQxRU=;
        b=N1mwoFcmnrsNZHvlnXoQj/taq6qDr4VWBTI5Yle57p3xLVdVcKpqoIbeqPqlZo/hAB
         wFEkt1CqRSNqeuGjJ7sXO6FelmEg5Uxx+RC0pVFYOiZvNxF7YvWwigpBREAwHO8XMVGz
         q2UFxibeKn/1+GJDy5MeJzZ5jzoUynbDOyQNYEkJidMypx+IZHCo3Y6IpmGE/aJ8V31j
         GkIfhS7uvydeLLY644bRRrpEGKC4pvuSD651do/KpSIbjvVdpjHH5UFqLdHWqi7LtqF9
         L0d7s56US5pHC+sktSti1aVWBcLbTMdnchTX6kEabDu2eGiccaBG2aMaJrdvLYWSBEry
         +nxw==
X-Gm-Message-State: AOJu0Yz4TdjQO12tY924PEWFMq3DQbQW4E97h2wPlZwsnMRfy5z56ngA
	dtDt3ZoUqVEIYyHoKniZ5mObtp5HMZY=
X-Google-Smtp-Source: AGHT+IGqMdc0eJe9zjiO5NCSLk2qAhKaqOUTkBdU7bxcTKreIFBETZvTDPnDFjJkTDLFzRdhBocIMg==
X-Received: by 2002:a17:906:3d42:b0:a27:e0ae:99a8 with SMTP id q2-20020a1709063d4200b00a27e0ae99a8mr1194698ejf.145.1704704415315;
        Mon, 08 Jan 2024 01:00:15 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id jw17-20020a170906e95100b00a29bd8f9edbsm2650748ejb.72.2024.01.08.01.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:00:14 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:00:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Jann Horn <jannh@google.com>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH -v2] locking/mutex: Clarify that mutex_unlock(), and most
 other sleeping locks, can still use the lock object after it's unlocked
Message-ID: <ZZu5nBicXKwgYrsg@gmail.com>
References: <20231130204817.2031407-1-jannh@google.com>
 <170142744948.398.4203675877225809071.tip-bot2@tip-bot2>
 <20231201121808.GL3818@noisy.programming.kicks-ass.net>
 <ZZu2F8KNygWzWVY7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZu2F8KNygWzWVY7@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > > +Releasing a mutex is not an atomic operation: Once a mutex release operation
> > 
> > I still object to this confusing usage of atomic. Also all this also 
> > applies to all sleeping locks, rwsem etc. I don't see why we need to 
> > special case mutex here.
> > 
> > Also completion_done() has an explicit lock+unlock on wait.lock to deal 
> > with this there.
> 
> Fair enough - but Jan's original observation stands: mutexes are the 
> sleeping locks most similar to spinlocks, so the locking & object 
> lifetime pattern that works under spinlocks cannot be carried over to 
> mutexes in all cases, and it's fair to warn about this pitfall.
> 
> We single out mutex_lock(), because they are the most similar in behavior 
> to spinlocks, and because this concern isn't hypothethical, it has been 
> observed in the wild with mutex users.
> 
> How about the language in the attached patch?

Refined the language a bit more in the -v2 patch below.

Thanks,

	Ingo

=============>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 8 Jan 2024 09:31:16 +0100
Subject: [PATCH] locking/mutex: Clarify that mutex_unlock(), and most other sleeping locks, can still use the lock object after it's unlocked

Clarify the mutex lock lifetime rules a bit more.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231201121808.GL3818@noisy.programming.kicks-ass.net
---
 Documentation/locking/mutex-design.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 7572339b2f12..7c30b4aa5e28 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -101,12 +101,24 @@ features that make lock debugging easier and faster:
     - Detects multi-task circular deadlocks and prints out all affected
       locks and tasks (and only those tasks).
 
-Releasing a mutex is not an atomic operation: Once a mutex release operation
-has begun, another context may be able to acquire the mutex before the release
-operation has fully completed. The mutex user must ensure that the mutex is not
-destroyed while a release operation is still in progress - in other words,
-callers of mutex_unlock() must ensure that the mutex stays alive until
-mutex_unlock() has returned.
+Mutexes - and most other sleeping locks like rwsems - do not provide an
+implicit reference for the memory they occupy, which reference is released
+with mutex_unlock().
+
+[ This is in contrast with spin_unlock() [or completion_done()], which
+  APIs can be used to guarantee that the memory is not touched by the
+  lock implementation after spin_unlock()/completion_done() releases
+  the lock. ]
+
+mutex_unlock() may access the mutex structure even after it has internally
+released the lock already - so it's not safe for another context to
+acquire the mutex and assume that the mutex_unlock() context is not using
+the structure anymore.
+
+The mutex user must ensure that the mutex is not destroyed while a
+release operation is still in progress - in other words, callers of
+mutex_unlock() must ensure that the mutex stays alive until mutex_unlock()
+has returned.
 
 Interfaces
 ----------

