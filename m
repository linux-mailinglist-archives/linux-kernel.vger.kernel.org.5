Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CE809D3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573282AbjLHHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573249AbjLHHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:37:33 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442E172C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:37:39 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-464dcdaa83bso418552137.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702021059; x=1702625859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lQ92KtEiSjx5iNgTwfJK0PeI8bwxuHNEJX76kXNyWM=;
        b=P/pc92WoCCEVkMGOHnvHC5whU7ww/c2fFv4Vky9myRLOLdzwX2uqnAe8Ef/mDoXPrq
         2qpc2W3wylwwImgMpENOq8IGzqvHUZ/P0ouTATxjqytKo0Plq1oqIIc1C9tUGWdLe93a
         btivXtEg84CDi+GnW8l6JppsVrMMkknJfqlcevRGgmCDQEmq33s7DHZ16DGswyEta5rk
         c5cTlzW8MOT2oReGvD+37Su6+nbHfCW39j88fJ1YXFs4Y0wD2CGg6WlxnFBQVF9xi7QJ
         ZGHcwxV2TUnBJ0Mi7t2euQBjQjQjcXWaCuZsxnq57zNRZM7IqESk9jd7DqiMlZlynF7M
         lCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702021059; x=1702625859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lQ92KtEiSjx5iNgTwfJK0PeI8bwxuHNEJX76kXNyWM=;
        b=B3BpzkbuJS5cK6qxB2tZm13CCq2GquffHtoNoN/X4HCPAQPZF3lsh3rFbXqHPvc6aK
         t/C/pmvQQz3B1g9SzTqsKZLm9k2P43e00ZgmK+jMjm0eXZljzeWLPXJKfgPKxJLNFOro
         icBagGxtIWDeptxHXYZMwYoj0bjQcGc/45/zRrk4QN8mkt3tvh8zxOyAinJTVGbBE9fA
         kFJvcPuK8hYUC/M38GTFhC4GsXdTeRs4P61g6OC1OSbZlm7kY8RsVnolUQGIH9a0JBHw
         cBA1UNNDJKFTFeH2mJIaqmPnv/4htxD3413hFxLun9+3seDt8IPsuXAgkNKxRxoWViqd
         qBLg==
X-Gm-Message-State: AOJu0Ywb8vdJwhVAiDVLQGAK8wjs/rVzGwkE9/q0e8zjWoPBxZnaaBOO
        rMKBWHTm8M6a1w0MwWTermkkA8GA9U2swukI/8kZpQ==
X-Google-Smtp-Source: AGHT+IHRKVVKMLyxqK+eAAXAjQAmX5+OfTqS71ySOVor79g26a/KEQNbFrz+L0jA9UGjvSwjMoQqSghISxRyeUI06fY=
X-Received: by 2002:a67:f7d4:0:b0:464:7f21:17d6 with SMTP id
 a20-20020a67f7d4000000b004647f2117d6mr2365331vsp.15.1702021058807; Thu, 07
 Dec 2023 23:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com> <1dd1a3e8-ef9a-4e89-891f-b49d82acc5f8@gmail.com>
In-Reply-To: <1dd1a3e8-ef9a-4e89-891f-b49d82acc5f8@gmail.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 8 Dec 2023 08:37:27 +0100
Message-ID: <CAH5fLgijsRK3funsGuG6nbK26C+s6m0nO0i83RYD2cO3z7L22Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
To:     Tiago Lam <tiagolam@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 6, 2023 at 6:05=E2=80=AFPM Tiago Lam <tiagolam@gmail.com> wrote=
:
>
>
> On 06/12/2023 10:09, Alice Ryhl wrote:
> [...]
> > diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> > index 9861c6749ad0..a6a6b6ab0c39 100644
> > --- a/rust/kernel/sync/condvar.rs
> > +++ b/rust/kernel/sync/condvar.rs
> > @@ -120,6 +120,63 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wai=
t_state: u32, guard: &mut Guar
> >           unsafe { bindings::finish_wait(self.wait_list.get(), wait.get=
()) };
> >       }
> >
> > +    /// Atomically releases the given lock (whose ownership is proven =
by the guard) and puts the
> > +    /// thread to sleep. It wakes up when notified by [`CondVar::notif=
y_one`] or
> > +    /// [`CondVar::notify_all`], or when the thread receives a signal.
> > +    ///
> > +    /// Returns whether there is a signal pending.
> > +    fn wait_internal_timeout<T, B>(
> > +        &self,
> > +        wait_state: u32,
> > +        guard: &mut Guard<'_, T, B>,
> > +        timeout: u64,
> > +    ) -> u64
> > +    where
> > +        T: ?Sized,
> > +        B: Backend,
> > +    {
> > +        let wait =3D Opaque::<bindings::wait_queue_entry>::uninit();
> > +
> > +        // SAFETY: `wait` points to valid memory.
> > +        unsafe { bindings::init_wait(wait.get()) };
> > +
> > +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> > +        unsafe {
> > +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), =
wait.get(), wait_state as _)
> > +        };
> > +
> > +        // SAFETY: Switches to another thread.
> > +        let timeout =3D
> > +            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(t=
imeout as _) as _ });
>
> It looks like `schedule_timeout()` simply calls `schedule()` when the
> timeout passed is `MAX_SCHEDULE_TIMEOUT`, so `wait_internal_timeout()`
> could be merged together with the already existing `wait_internal()`,
> where `wait_internal()` would always call `schedule_timeout()`? I may be
> missing something, so just wondering why you decided to introduce
> another method.

Ah, nice! I didn't notice that I could combine them.

> > +    /// Releases the lock and waits for a notification in interruptibl=
e mode.
> > +    ///
> > +    /// Atomically releases the given lock (whose ownership is proven =
by the guard) and puts the
> > +    /// thread to sleep. It wakes up when notified by [`CondVar::notif=
y_one`] or
> > +    /// [`CondVar::notify_all`], or when a timeout occurs, or when the=
 thread receives a signal.
> > +    ///
> > +    /// Returns whether there is a signal pending.
> > +    #[must_use =3D "wait_timeout returns if a signal is pending, so th=
e caller must check the return value"]
> > +    pub fn wait_timeout<T: ?Sized, B: Backend>(
> > +        &self,
> > +        guard: &mut Guard<'_, T, B>,
> > +        jiffies: u64,
> > +    ) -> CondVarTimeoutResult {
>
> Should this be called `wait_timeout_interruptable` instead, so that if
> we need to add one using the `TASK_INTERRUPTIBLE` state later we don't
> need to modfy it again? It also matches the
> `schedule_timeout_interruptible` one in the kernel (although that's not
> a reason to change it just in itself).

I don't mind changing the names, but in this patch I was just
consistent with what was already there.

> > +/// The return type of `wait_timeout`.
> > +pub enum CondVarTimeoutResult {
> > +    /// The timeout was reached.
> > +    Timeout,
> > +    /// Somebody woke us up.
> > +    Woken {
> > +        /// Remaining sleep duration.
> > +        jiffies: u64,
> > +    },
> > +    /// A signal occurred.
> > +    Signal {
> > +        /// Remaining sleep duration.
> > +        jiffies: u64,
> > +    },
> > +}
>
>
> Is `Signal` and `Woken` only going to hold a single value? Would it be
> best represented as a tuple struct instead, like so?
>
>      pub enum CondVarTimeoutResult {
>          /// The timeout was reached.
>          Timeout,
>          /// Somebody woke us up.
>          Woken (u64),
>          /// A signal occurred.
>          Signal (u64),
>      }

I could do that, but I like the explicitly named version as it makes
it clear that the unit is jiffies.

Alice
