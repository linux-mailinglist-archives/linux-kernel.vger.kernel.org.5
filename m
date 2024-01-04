Return-Path: <linux-kernel+bounces-16735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FF824316
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAF2B250CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD63A22EFE;
	Thu,  4 Jan 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5ICfODo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D022336
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4670a58b118so95700137.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704376205; x=1704981005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmcHXU84jO7/aD/+uybBFnY8Y1yiePevOt8pOFnzJnU=;
        b=l5ICfODoDrHL0Nuq6YZH8Nk3GxtBMj8BT3EflBHOtNMnp7fjsy9qbKJ5nDxMKh8j2K
         HRoq1hLH7xfaqYPdxfQzWXmN5XdXUYeRR/I3DBcTc49bTTUQVCeHBzY94k06IAFpOHDX
         v8FfYwcjZLeqJoyo2cTfL7CNG31Zch2uIkRiJD87cc6YXqiYVpzvHaD3mXVlO4I6rcB+
         Ls++AQdF++hKRQgsoHzBqy8GadGcaHZbeAwZevhdMZl058lBM4X1jFz2oQNhvxYcW6SY
         lX0Q1a5W6EIT1BubSXguECmSQ2k3MzucISwkkAX6Fsc0VklATyoWuUo0xugXZvcH5kg+
         OJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376205; x=1704981005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmcHXU84jO7/aD/+uybBFnY8Y1yiePevOt8pOFnzJnU=;
        b=KCXcGCbtoQP8Rt7oWedR9v2qS8169GjEfN7T6bKNf2XyKLFg7I6GLOI1t4SXJvyAHD
         nLScgfA03fpvZH4RC6FwWfXcXizLp9wPZ40XJ6M0A8LukMwN/XpRlUkdBvV6/PEMWg7R
         3HT5J66m6eumSfXCfb/1sDCsohbJRWMegHjvzDlw1iJoNeykRqRijDZqTfHJS6bidaiQ
         iw4rAAUPZjLCSRS4czoGYhskOAjU5dB9JLnZekr8NTyiLUQlLwmaVMP7n0aJ82oc6ET/
         1bWiQlFUS86yM7g8fix6yhH/Td/l/cLcswZ48NIMZPsDQrLrfbpxWtmpi2G9L15bzXJg
         Uvhg==
X-Gm-Message-State: AOJu0Yyyk/aWTYuFrOT0Cf0LWE9HsP9eT+6gGq1w072sj9gpdu8vzeI5
	HrnnKlkiYmpQlC6tvaoLYbTSoL5QzXLT2ZXg/viJ6qviXy8t
X-Google-Smtp-Source: AGHT+IEAG/I6C9BLRfLo85MzbCkaRVNqJu+9FkpCp4Ck+/c2Obav4H8mDC12zSpvDgDHq2jOZdWQCtux3iqfLUKsiTg=
X-Received: by 2002:a05:6102:15a8:b0:467:a64f:aa27 with SMTP id
 g40-20020a05610215a800b00467a64faa27mr421440vsv.15.1704376205029; Thu, 04 Jan
 2024 05:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-3-b05ab61e6d5b@google.com>
 <3fba196a-8cb6-4ce9-9e67-bfb716a2d171@proton.me> <ZYRtuRXPgQcN_3cr@boqun-archlinux>
In-Reply-To: <ZYRtuRXPgQcN_3cr@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 14:49:54 +0100
Message-ID: <CAH5fLghmG4e0RjVdPuyWYgCt2cQ9+_WRP81tGxS4qyL91vHiEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rust: sync: add `CondVar::wait_timeout`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 5:54=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Dec 20, 2023 at 11:31:05AM +0000, Benno Lossin wrote:
> > On 12/16/23 16:31, Alice Ryhl wrote:
> > > @@ -102,7 +105,12 @@ pub fn new(name: &'static CStr, key: &'static Lo=
ckClassKey) -> impl PinInit<Self
> > >          })
> > >      }
> > >
> > > -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, =
guard: &mut Guard<'_, T, B>) {
> > > +    fn wait_internal<T: ?Sized, B: Backend>(
> > > +        &self,
> > > +        wait_state: u32,
> > > +        guard: &mut Guard<'_, T, B>,
> > > +        timeout: c_long,
> > > +    ) -> c_long {
> > >          let wait =3D Opaque::<bindings::wait_queue_entry>::uninit();
> > >
> > >          // SAFETY: `wait` points to valid memory.
> > > @@ -113,11 +121,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, =
wait_state: u32, guard: &mut Guar
> > >              bindings::prepare_to_wait_exclusive(self.wait_list.get()=
, wait.get(), wait_state as _)
> > >          };
> > >
> > > -        // SAFETY: No arguments, switches to another thread.
> > > -        guard.do_unlocked(|| unsafe { bindings::schedule() });
> > > +        // SAFETY: Switches to another thread. The timeout can be an=
y number.
> > > +        let ret =3D guard.do_unlocked(|| unsafe { bindings::schedule=
_timeout(timeout) });
> >
> > I am not sure what exactly the safety requirements of `schedule_timeout=
`
> > are. I looked at the function and saw that the timout should not be
> > negative. But aside from that only the the context switching should be
> > relevant. What things are not allowed to do when calling `schedule`
> > (aside from the stuff that klint catches)?
>
> One thing is that you probably don't want to call `schedule` with task
> state being TASK_DEAD, if so the `schedule` would be counted as
> `ARef<Task>::drop()`, see __schedule() -> context_switch() ->
> finish_context_switch(), and the task may be freed after that, which
> free the stack of the task, and anything that references a object on the
> stack would be a UAF. On the other hand, if the task state is not
> TASK_DEAD, `schedule*()` should be a no-op regarding memory safety.
>
> > Because if there are none, then I would put the "switches to another
> > thread" part into a normal comment.
> >
>
> I think it's possible to make schedule_timeout() a safe function: we can
> define setting task state TASK_DEAD as an unsafe operation, whose safety
> requirement is something like: "Must ensure that if some code can
> reference a memory object that belongs to the task (e.g. a stack
> variable) after the task calls a followed `schedule()`, the code must
> also hold an additional reference count to the task."
>
> Yes, it might be out of the scope of this patchset though.

These things sound like they are out of scope of this patchset.
Changing it from schedule to schedule_timeout doesn't change whether
this is ok or not.

Alice

