Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D51801274
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjLASSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:18:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA2129
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:18:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c52baaa59so950a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701454720; x=1702059520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG2qvU0QskaUquCTeF5oijEUHu0uj9CGz7uyq4JY4sk=;
        b=k7zvQIUQjgTyLEcYqwFRnGUxZHa/bg7DowIKyRfvrG0TpRk3ibV0u/G3HEn1qoeAqB
         XnZaQaCxYWCa/lcRZNdjQuw08eJbqPewDGFDBDx9lrghLNmZcApZ3N5Vv+EQqPsPiVAj
         vbt7gqWHTq3abqKSRbhaqpR2AqDkNxUnNXQxSil3wSKasCXzUeOaIpd7roog+ocQpNz+
         zM7ovAB6K4gqgsRiwittGDNJVYqfqLG9oaHbFsWxgi66tCN1E655wzZ+AA9gEG7W/a9B
         nPsqrpuv3GQuvuF5hVxfN44krwXsMuUNDiz5bWuBHvl9zjBhNlBCwiz/aAzonflwkLJn
         1m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454720; x=1702059520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG2qvU0QskaUquCTeF5oijEUHu0uj9CGz7uyq4JY4sk=;
        b=vkfFtoGBOKAssYovhXVnoz5O108Y92sBhChdLzegafXJXG7Zjt86UATUGW8gsYU5A4
         6w9k3OTSFibim+msoRzrw8+OlNe/pNT1PDF6vNCmyeFG5U8Gjg3tWycosQWJ4s/X4hB+
         H6ccgVdDsA1zEFTvADfewLLHT5aT1FoQSEhTdGty6QjnAk66s+XD/P6pN8jVzaWjs15F
         MRj1SuRTv4jsIXzbiSwP6jDoKqyBP7VzuMzgTrq4eyjNNTZj7IyC87Eei7HTqtrtzlYS
         HoQGEKYFve11bmF94mw5j7RvCF8v72MROVBzM2/Xp61OZJ7uL+t2t5H8IvlPGOkpv6AJ
         f92w==
X-Gm-Message-State: AOJu0YwSM0Tw+KfIpQDfn64+PVdzTC6tdJbv+ABEu0scXDK6gdPzatRF
        IMuK6DK1Js7RZToet7kNb3gvjP/b2ITc++b2ot4A2A==
X-Google-Smtp-Source: AGHT+IF65u7rI3BqvWNhPLCqFe6obTBbRQ5ETF5EFDDXxUy02aSXHG2k1RzarlGVTbjqjtWkoVGkW3b8radjMqSANaM=
X-Received: by 2002:a50:d5d4:0:b0:54b:6b3f:4a86 with SMTP id
 g20-20020a50d5d4000000b0054b6b3f4a86mr203053edj.4.1701454720168; Fri, 01 Dec
 2023 10:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20231130204817.2031407-1-jannh@google.com> <06c05c8b-9a3b-4c04-b898-0f82e98da70f@redhat.com>
 <CAG48ez1a=VuEWwPTjcXFAwCyt9bRH-WzAfw0uP-qVu83kdxkZw@mail.gmail.com> <28b147c3d7354d1a8ff0b903da9b54f4@AcuMS.aculab.com>
In-Reply-To: <28b147c3d7354d1a8ff0b903da9b54f4@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Dec 2023 19:18:02 +0100
Message-ID: <CAG48ez1bOwbqEbD_ycC2fyWK_tW4rqr=gogJbQOx5CECyPGZcg@mail.gmail.com>
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
To:     David Laight <David.Laight@aculab.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 7:12=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
> From: Jann Horn
> > Sent: 01 December 2023 15:02
> >
> > On Fri, Dec 1, 2023 at 1:33=E2=80=AFAM Waiman Long <longman@redhat.com>=
 wrote:
> > > On 11/30/23 15:48, Jann Horn wrote:
> > > > I have seen several cases of attempts to use mutex_unlock() to rele=
ase an
> > > > object such that the object can then be freed by another task.
> > > > My understanding is that this is not safe because mutex_unlock(), i=
n the
> > > > MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> > > > structure after having marked it as unlocked; so mutex_unlock() req=
uires
> > > > its caller to ensure that the mutex stays alive until mutex_unlock(=
)
> > > > returns.
> > > >
> > > > If MUTEX_FLAG_WAITERS is set and there are real waiters, those wait=
ers
> > > > have to keep the mutex alive, I think; but we could have a spurious
> > > > MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> > > > between the points where __mutex_unlock_slowpath() did the cmpxchg
> > > > reading the flags and where it acquired the wait_lock.
> > > >
> > > > (With spinlocks, that kind of code pattern is allowed and, from wha=
t I
> > > > remember, used in several places in the kernel.)
> > > >
> > > > If my understanding of this is correct, we should probably document=
 this -
> > > > I think such a semantic difference between mutexes and spinlocks is=
 fairly
> > > > unintuitive.
> > >
> > > Spinlocks are fair. So doing a lock/unlock sequence will make sure th=
at
> > > all the previously waiting waiters are done with the lock. Para-virtu=
al
> > > spinlocks, however, can be a bit unfair so doing a lock/unlock sequen=
ce
> > > may not be enough to guarantee there is no waiter. The same is true f=
or
> > > mutex. Adding a spin_is_locked() or mutex_is_locked() check can make
> > > sure that all the waiters are gone.
> >
> > I think this pattern anyway only works when you're only trying to wait
> > for the current holder of the lock, not tasks that are queued up on
> > the lock as waiters - so a task initially holds a stable reference to
> > some object, then acquires the object's lock, then drops the original
> > reference, and then later drops the lock.
> > You can see an example of such mutex usage (which is explicitly legal
> > with userspace POSIX mutexes, but is forbidden with kernel mutexes) at
> > the bottom of the POSIX manpage for pthread_mutex_destroy() at
> > <https://pubs.opengroup.org/onlinepubs/007904875/functions/pthread_mute=
x_destroy.html>,
> > in the section "Destroying Mutexes".
>
> I don't understand at all what any of this is about.
> You cannot de-initialise, free (etc) a mutex (or any other piece of
> memory for that matter) if another thread can have a reference to it.
> If some other code might be holding the mutex it also might be just
> about to acquire it - you always need another lock of some kind to
> ensure that doesn't happen.
>
> IIRC pretty much the only time you need to acquire the mutex in the
> free path is if locks are chained, eg:
>         lock(table)
>         entry =3D find_entry();
>         lock(entry)
>         unlock(table)
>         ...
>         unlock(entry)
>
> Then the free code has to:
>         lock(table)
>         remove_from_table(entry)
>         lock(entry)
>         unlock(entry)
>         unlock(table)
>         free(entry)

Yep, this is exactly the kind of code pattern for which I'm trying to
document that it is forbidden with mutexes (while it is allowed with
spinlocks).
