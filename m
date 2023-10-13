Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8F7C8093
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjJMIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJMIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:46:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14BBC2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:46:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53da80ada57so3301141a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697186788; x=1697791588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gnls/hmbBn1G4jzn/Z9Pf0jJBkrXUEs1i6LxoSc9Aw=;
        b=glzjXzNHahP5UtoAhMkLv4EA/6kFcy9IeeyqJL41Q9hNepB5Q53sGSR6vPvaGVtsQY
         AfJ3YMBDi0XcIoaFAsgHgphX/YDxm0T/QAqnTrIrzJ72LfQSzdDRKMBe+7QVcu0tcCtg
         Jnm8mVw/HZCC4EZNkosa7eKT0RysD3PqCNS7a6/uC/yIhDBEMddVSCX3VWDTgXOh7fGy
         jw7B4XIZPgtentUm5D/RtcnMWpdiUK5u/QfFijuwO79xRxJQHY8aFbOdgetc7T4RC+PG
         RcXvmMXJ4Z263UT7M2lxoSAUGR3xaxoYY8lAHfGU8LGWhVvn9DJWteuqonxs5g17X7ag
         7pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186788; x=1697791588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gnls/hmbBn1G4jzn/Z9Pf0jJBkrXUEs1i6LxoSc9Aw=;
        b=K8IWiY6sV3OWlIgaT27FJ/ebQXHeRllEBwgjaPGffymPmgprImMrRzKNfvXIimiuEL
         V2KHKRM0eVQjKRTQH5F0JmEhflztzx+KdeFAzCT+MgBBWp1iMghJHBzeRfn4vWuwU7uj
         PrsYdx30cEaW7XtpExKx6evnHxPsRZf4MtD6rgDYuwRr2OB/cQ2xnhRxKEYAHMKJV1zs
         83HyEY9HP3A7MmkA5YkbSTG9PF+ABmv+NTZZbBhbJ6k1p+3cXMVd8TNwt64suCGrIgIP
         s8s7quk87vjUbfB6mHrVkFsL91bb90SJwQj27jKD/tP3o3eFtWDpOTJbE2ApB/9iiM/H
         AV5A==
X-Gm-Message-State: AOJu0Yx7Fom78jd1Gc6LdqttWfIBlKtWMdIx/2/zxiDtYmWgbsec9dpn
        rIO2g08nCKDJTWFaR02J2XBe8pujsX0=
X-Google-Smtp-Source: AGHT+IHxTerL5vD5L9/paXKGDPVQsbH28UIZC6AXUGwTd61LPH1LBD73LbWCea2XN8BGKlbr5vg5tA==
X-Received: by 2002:aa7:c393:0:b0:530:74ed:fc85 with SMTP id k19-20020aa7c393000000b0053074edfc85mr22142707edq.3.1697186787991;
        Fri, 13 Oct 2023 01:46:27 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7cb4f000000b0052a063e52b8sm11138997edt.83.2023.10.13.01.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:46:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 10:46:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] locking/seqlock: Propagate 'const' pointers within read-only
 methods, remove forced type casts
Message-ID: <ZSkD4RLAhJaW3VyB@gmail.com>
References: <20231012143158.GA16133@redhat.com>
 <20231012143227.GA16143@redhat.com>
 <ZSg5KAFxVzKoFlhZ@gmail.com>
 <CAHk-=wgsybshMs3KLsyheP8hHhndrRhjo70L1qi+GdBZND8M+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsybshMs3KLsyheP8hHhndrRhjo70L1qi+GdBZND8M+A@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 12 Oct 2023 at 11:21, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Okay, so dropping 'const' makes sense in terms of staying bug-compatible
> > with the  previous API and not build-breaking the world - but could we
> > perhaps follow this up with fixups of the type misuse and then a removal
> > of the forced type casts from these APIs?
> 
> No. The use of 'const' here is *not* a bug.
> 
> The thing is, 'const' doesn't mean what you seem to think it means. A
> 'const' pointer in C in no way means that the target is constant - it
> means that *THIS* use of the pointer will not write to the target!

Yeah, that is absolutely what I too think 'const' means - and sorry, I 
didn't expand: I meant something like the patch below, which clearly 
separates the 'const' from the non-const pointer uses within 
<linux/seqlock.h> and removes the two forced type casts I was unhappy 
about.

The 'bug' was that the __seqprop_*ptr() wrapper was used with both const 
and non-const pointers, and we forced a type and lost a tiny bit of 
potential const propagation. The code was fine and I should not have called 
it a 'bug', but I consider the dropping of 'const' a bad pattern, and I 
sometimes exaggerate problems to trick^W convince developers to continue 
working along a given path...

In hindsight my "break the world" expectation was overblown too: our const 
propagation through these methods was almost complete already, and the 
fixes stayed within <linux/seqlock.h>.

This patch could probably be split into two patches. Lightly tested only.

Does this work for you?

Thanks,

	Ingo

===================>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 13 Oct 2023 10:15:46 +0200
Subject: [PATCH] locking/seqlock: Propagate 'const' pointers within read-only methods, remove forced type casts

Currently __seqprop_ptr() is an inline function that must chose to either
use 'const' or non-const seqcount related pointers - but this results in
the undesirable loss of 'const' propagation, via a forced type cast.

The easiest solution would be to turn the pointer wrappers into macros that 
pass through whatever type is passed to them - but the clever maze of 
seqlock API instantiation macros relies on the GCC CPP '##' macro 
extension, which isn't recursive, so inline functions must be used here.

So create two wrapper variants instead: 'ptr' and 'const_ptr', and pick the
right one for the codepaths that are const: read_seqcount_begin() and
read_seqcount_retry().

This cleans up type handling and allows the removal of all type forcing.

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/seqlock.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 4b8dcd3a0d93..80f21d2ca2aa 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -200,9 +200,15 @@ typedef struct seqcount_##lockname {					\
 } seqcount_##lockname##_t;						\
 									\
 static __always_inline seqcount_t *					\
-__seqprop_##lockname##_ptr(const seqcount_##lockname##_t *s)		\
+__seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
-	return (void *)&s->seqcount; /* drop const */			\
+	return &s->seqcount;						\
+}									\
+									\
+static __always_inline const seqcount_t *				\
+__seqprop_##lockname##_const_ptr(const seqcount_##lockname##_t *s)	\
+{									\
+	return &s->seqcount;						\
 }									\
 									\
 static __always_inline unsigned						\
@@ -247,9 +253,14 @@ __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqprop_ptr(const seqcount_t *s)
+static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
 {
-	return (void *)s; /* drop const */
+	return s;
+}
+
+static inline const seqcount_t *__seqprop_const_ptr(const seqcount_t *s)
+{
+	return s;
 }
 
 static inline unsigned __seqprop_sequence(const seqcount_t *s)
@@ -302,6 +313,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	__seqprop_case((s),	mutex,		prop))
 
 #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
+#define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
 #define seqprop_sequence(s)		__seqprop(s, sequence)(s)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
 #define seqprop_assert(s)		__seqprop(s, assert)(s)
@@ -353,7 +365,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
+	seqcount_lockdep_reader_access(seqprop_const_ptr(s));		\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -419,7 +431,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	do___read_seqcount_retry(seqprop_ptr(s), start)
+	do___read_seqcount_retry(seqprop_const_ptr(s), start)
 
 static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
@@ -439,7 +451,7 @@ static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	do_read_seqcount_retry(seqprop_ptr(s), start)
+	do_read_seqcount_retry(seqprop_const_ptr(s), start)
 
 static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
