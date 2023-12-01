Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC18012EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379349AbjLASkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:40:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A3D63
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:40:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso1070a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701456043; x=1702060843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkVHqNvonNn8A5RdXCNM0KGca3KT1K9/6epU/Ala7ns=;
        b=gJh5Bp2Gq+zevHlFu7FzvXMLs/Dr6P8fJ86RAC/FgyO8UzEXlxo3OY+HPn29N9cUDM
         I5Gryuusox6WflgyVQ92N7v2DHj1Xg6utmR6NCKn0gr353JVS7t5I6UBgQnZDib4o1Fi
         fMPGeHpCxOq1adthQw/URIRsEupe3BqbGUJhyFNUcqI//xtjXDd/HF2Fe8Odqj6xxe1m
         uhUVMsUugsdltseN4pY3aMz87z1t2QpRo03OYfAe9cs6KlWRZzgBPNLQrVAou9DIRAuy
         YYsFXM3CkHHGuszmOII0pAqWD/UJAVV1YwcoVtgxy4MU1dAL42q9YBZ39ZzhH+2f2nRR
         jx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456043; x=1702060843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkVHqNvonNn8A5RdXCNM0KGca3KT1K9/6epU/Ala7ns=;
        b=en0AOm2p/A1mwwLZwXHfP7UlXyQ25kwM1mqO7Fgx39CX5PSs9vGeyNF9uF34y90GrI
         j/TFG9X4ZeDx3gxtPpm7iKvwVUOGk+0pfdNfhnpqU0zEV6xWJ9YSQyrPsBoxVc1qa9yS
         e1Ze9GPAW+cywog0b+iGcHfX8dGPzPFoUkAJklVjW/xCv6/jn53Pcbat7NEJxSDVZ19M
         ajgeTV9HddHvcxmPZRPpd3KS/J79+p3cj0MGkhMN0BnkOrDl19S9dzy0waKK7UlCQNa0
         TBFLLiFZTlJWgjOzYPllrnY8QY3IV/lka8zJji6iKjY7eLRopeI/LR4BlvUuElrfC6fB
         2ZDw==
X-Gm-Message-State: AOJu0YyqrcczOFh5MAWcT5ZxGc7uw84SW7iSxg8ACn/gR5mGQBFRAM5I
        VEYnZN964Yfs2aZ94tkbZ/OdG4m2fPreMun/Q0jp/g==
X-Google-Smtp-Source: AGHT+IHFucvwGuwgf6CWwT0KxM9o15mQSPjEtFtLdi2XRjUgtzKITMVco+W+TyDdXuCWjtgGx7pIOKvxPeuX3lZfkVw=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr160337edc.6.1701456042587; Fri, 01 Dec
 2023 10:40:42 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3xSoYb+45f1RLtktROJrpiDQ1otNvdR+YLQf7m+Krj5Q@mail.gmail.com>
 <811a97651e144b83a35fd7eb713aeeae@AcuMS.aculab.com>
In-Reply-To: <811a97651e144b83a35fd7eb713aeeae@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Dec 2023 19:40:06 +0100
Message-ID: <CAG48ez1jT0T69t62wrduEWLSwY0UZpm0CwK4tC3uTPiWJ-powg@mail.gmail.com>
Subject: mutex/spinlock semantics [was: Re: io_uring: incorrect assumption
 about mutex behavior on unlock?]
To:     David Laight <David.Laight@aculab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 7:30=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Jann Horn
> > Sent: 01 December 2023 16:41
> >
> > mutex_unlock() has a different API contract compared to spin_unlock().
> > spin_unlock() can be used to release ownership of an object, so that
> > as soon as the spinlock is unlocked, another task is allowed to free
> > the object containing the spinlock.
> > mutex_unlock() does not support this kind of usage: The caller of
> > mutex_unlock() must ensure that the mutex stays alive until
> > mutex_unlock() has returned.
>
> The problem sequence might be:
>         Thread A                Thread B
>         mutex_lock()
>                                 code to stop mutex being requested
>                                 ...
>                                 mutex_lock() - sleeps
>         mutex_unlock()...
>                 Waiters woken...
>                 isr and/or pre-empted
>                                 - wakes up
>                                 mutex_unlock()
>                                 free()
>                 ... more kernel code access the mutex
>                 BOOOM
>
> What happens in a PREEMPT_RT kernel where most of the spin_unlock()
> get replaced by mutex_unlock().
> Seems like they can potentially access a freed mutex?

RT spinlocks don't use mutexes, they use rtmutexes, and I think those
explicitly support this usecase. See the call path:

spin_unlock -> rt_spin_unlock -> rt_mutex_slowunlock

rt_mutex_slowunlock() has a comment, added in commit 27e35715df54
("rtmutex: Plug slow unlock race"):

         * We must be careful here if the fast path is enabled. If we
         * have no waiters queued we cannot set owner to NULL here
         * because of:
         *
         * foo->lock->owner =3D NULL;
         *                      rtmutex_lock(foo->lock);   <- fast path
         *                      free =3D atomic_dec_and_test(foo->refcnt);
         *                      rtmutex_unlock(foo->lock); <- fast path
         *                      if (free)
         *                              kfree(foo);
         * raw_spin_unlock(foo->lock->wait_lock);

That commit also explicitly refers to wanting to support this pattern
with spin_unlock() in the commit message.
