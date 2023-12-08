Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B569809D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjLHH3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjLHH32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:29:28 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CA171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:29:34 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4affeacaff9so452529e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702020574; x=1702625374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrV5ggink9t0wvGsS5EUrsFBN636nAxmFkZLs8Lkbqw=;
        b=mwCRo1kVGpUiTou2WkjYI25NTjJaOu259JK+Wvxyr2LzgcwLjtOxMN969TefWOi5Tq
         O0sIVVc5oo5aLjcq6OBjvNiyeEAxislsII93DaZGO73OUn0lkQhlhlJijjfR3x1mw7ts
         3Hf8y34o13NJxAxDO0I9WdfhAyDiqDTeiD5DeAwwW7hfBtIuMTaogW3kBfkPRaV4Sngx
         k/DqGbv+iEYwoAah4dpZzQvt07tqU2k2Uv+n2RCaySZqKLU5b/KE8bETuPGetC0/7Arl
         E4HH0xyhyb4Vlx4EPtzG80LmJ4+aXGa0U4/uZz90JsTXjVz2wt6Bs0VyZQVfqOEml0qk
         H+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702020574; x=1702625374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrV5ggink9t0wvGsS5EUrsFBN636nAxmFkZLs8Lkbqw=;
        b=Y87QgLpzXaDnw0nfLg9MOleDK6bnHZ3ItpC1vBfSVFXVarirE1s9WujfD3zhNwzQ4v
         E+UaNVVC3qmYfbdsuz5G99Nf2dBMERRy9DIr+fjL8Y5uY8D2b0JKp64AzKIfRDhIJglY
         upo2oXcoyIHwzJ54VQdx56SfZTvNwEDSiOiRsRAZ63xGROkkjvX8XneroMOAnprWyjtx
         c+TiN1IfQ5CqRdQfk/Af6DzBdg8LutgzS3vp9IZW6GN724rGXI9mKTTInNn4mFE71wQ3
         vACcHXCvu8EetUxhudXbcx70g0ykJ7SqtxifpVx516ScgNeNmrccLxcT1gT5qLDVStzq
         DP6Q==
X-Gm-Message-State: AOJu0YyHmqvh8UN5ztjq+n8lzct46xi6/HKfl1ba6jAp84SS3NSLxNM2
        leTl9aDfPWbgPVHfT78JtoRsjmq+G9SxIwvPWiPVcQ==
X-Google-Smtp-Source: AGHT+IG37SFgofRSQyexRIQ9EppdOKl7gzb6/3/15FQw037tJZg2e7u6wS6pfk+BzNcLQedowcAOSwkxOAqRZfxHyVI=
X-Received: by 2002:a1f:c8c1:0:b0:4b2:c554:e9b0 with SMTP id
 y184-20020a1fc8c1000000b004b2c554e9b0mr3891594vkf.18.1702020573823; Thu, 07
 Dec 2023 23:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-1-33a4cab7fdaa@google.com> <n18Cdl9DQXfuGtD6d664Mn0rrPfxebZs31-3vQfu5N0vP0ZgfHNwBZYC4qYgU1GD-4Ue4bUhgNqs40-u8t0baAzlQ0cMMiSzTgjQnhcG50o=@proton.me>
In-Reply-To: <n18Cdl9DQXfuGtD6d664Mn0rrPfxebZs31-3vQfu5N0vP0ZgfHNwBZYC4qYgU1GD-4Ue4bUhgNqs40-u8t0baAzlQ0cMMiSzTgjQnhcG50o=@proton.me>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 8 Dec 2023 08:29:22 +0100
Message-ID: <CAH5fLgi37LER-G-ozc13TWGGxraFmP3QVYqX7oBoahyKwgfznQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: add `CondVar::notify_sync`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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

On Thu, Dec 7, 2023 at 9:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 12/6/23 11:09, Alice Ryhl wrote:
> > Wake up another thread synchronously.
> >
> > This method behaves like `notify_one`, except that it hints to the
> > scheduler that the current thread is about to go to sleep, so it should
> > schedule the target thread on the same CPU.
> >
> > This is used by Rust Binder as a performance optimization. When sending
> > a transaction to a different process, we usually know which thread will
> > handle it, so we can schedule that thread for execution next on this
> > CPU for better cache locality.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/sync/condvar.rs | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> > index b679b6f6dbeb..9861c6749ad0 100644
> > --- a/rust/kernel/sync/condvar.rs
> > +++ b/rust/kernel/sync/condvar.rs
> > @@ -155,6 +155,12 @@ fn notify(&self, count: i32, flags: u32) {
> >          };
> >      }
> >
> > +    /// Calls the kernel function to notify one thread synchronously.
> > +    pub fn notify_sync(&self) {
> > +        // SAFETY: `wait_list` points to valid memory.
> > +        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindin=
gs::TASK_NORMAL) };
>
> I took a look at the C function (i.e. __wake_up_common) and there I
> found this:
>
>     lockdep_assert_held(&wq_head->lock);
>
> So I think this function requires that the lock is held, how are you
> ensuring this?

No, we don't need to hold a lock. The call stack is:

1. __wake_up_sync
2. __wake_up_sync_key
3. __wake_up_common_lock
4. __wake_up_common

And __wake_up_common_lock will lock wq_head->lock before calling
__wake_up_common.

Alice
