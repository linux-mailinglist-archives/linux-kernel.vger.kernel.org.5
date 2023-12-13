Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD365810F59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378473AbjLMLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378326AbjLMLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:04:34 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B83B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:04:41 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9d84019c5so5153502a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702465480; x=1703070280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OfkgN2PJIbw2ezV94FT4cZwlilOoY4SLjkbyeO7luc=;
        b=0kvirctxEF3tP+NgcVpfQIhGDmo6bskitzhpp8N1uL3X9AcI7Wbh7pzyPUs4EN5MjR
         eCmxJQXY7nam1daeWfv+/DtTur0zyAeYhqIacVAQnxR0QqzdIG4GwAUbnrF7KvFDaUaB
         epe+Ikn40RB9mBkUxFgWaE2wrGBew67Go3IL+/kDS80cAdKrFh+DmBEKnph8xrtLxNi9
         13VDI8bpioKJvfZoyhygom5dtqFJFrYQ32n9Md/Ga0PdvF8l+GgvcYpVTfMkcn4yNhJ+
         OwkUCyDCsXZ0ApFQ5br/xzcS3BDp/JGv/O1ZbhQdD5DKXTqiHw76kuDPcHtGsiGQ61kC
         QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465480; x=1703070280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OfkgN2PJIbw2ezV94FT4cZwlilOoY4SLjkbyeO7luc=;
        b=Yzso4GtzZRmALNhd2DXn8KEx0/5Zw2W0vNgRL64faKqnpXyWu7G2dv5yT8jEZuLD4O
         J2A/vKcrlurERdlSOn6yKg2nuY/0ZUu5KXli8HxA9Uv9HQbctPmy7PnlNwIlASVCakFh
         /HzRQT6B2Vdw+A6UVy/8ePq1OqhFJmVrQEp9vgGfUdJBknkdc3EhMLN5NN/sEKb1t69M
         zk8FFVzAztUTI6d8b76FRdu/ZLgGr+kCrx7BoEg7JQ0kZPGRSlHya/z2T2w/l3qesOqe
         gyKChaZNT+QckAjoccBgTFavnGLm9VSyGvidc/lSfCWNa1RH6cM5GXffjFAMvJwnNlVa
         MbuQ==
X-Gm-Message-State: AOJu0YwcGgwB5PceGV34z9WpojsF7Nrd2Se9wtfDNMKI8pfZSXeFWE3o
        nAdZt3ZVOvodjuSMAi4HRZ+N+EJkRFw+86/s/tprng==
X-Google-Smtp-Source: AGHT+IEM6BN7v5f3zSptK13rp4Iti293Tj3jpfPMFy+2qx3uN3e2Hkdo1HScrQhzZSsl9fR6iHqgEWv1vuVRiinjMLE=
X-Received: by 2002:a9d:6185:0:b0:6d9:e28c:28ef with SMTP id
 g5-20020a9d6185000000b006d9e28c28efmr7004936otk.55.1702465480518; Wed, 13 Dec
 2023 03:04:40 -0800 (PST)
MIME-Version: 1.0
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
 <20231211153440.4162899-1-aliceryhl@google.com> <ZXdJyGFeQEbZU3Eh@boqun-archlinux>
 <ZXe2fpN4zRlkLLJC@boqun-archlinux> <ZXjJLP5NdbxEzKpC@boqun-archlinux>
In-Reply-To: <ZXjJLP5NdbxEzKpC@boqun-archlinux>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 13 Dec 2023 12:04:29 +0100
Message-ID: <CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCmX0Ang3tAgGHA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     benno.lossin@proton.me, a.hindborg@samsung.com,
        alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com,
        brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com,
        dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
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

On Tue, Dec 12, 2023 at 9:57=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Dec 11, 2023 at 05:25:18PM -0800, Boqun Feng wrote:
> > On Mon, Dec 11, 2023 at 09:41:28AM -0800, Boqun Feng wrote:
> > > On Mon, Dec 11, 2023 at 03:34:40PM +0000, Alice Ryhl wrote:
> > > > Benno Lossin <benno.lossin@proton.me> writes:
> > > > > On 12/6/23 12:59, Alice Ryhl wrote:
> > > > > > +    /// Schedule a task work that closes the file descriptor w=
hen this task returns to userspace.
> > > > > > +    ///
> > > > > > +    /// Fails if this is called from a context where we cannot=
 run work when returning to
> > > > > > +    /// userspace. (E.g., from a kthread.)
> > > > > > +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdClo=
seError> {
> > > > > > +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_=
RESUME;
> > > > > > +
> > > > > > +        // In this method, we schedule the task work before cl=
osing the file. This is because
> > > > > > +        // scheduling a task work is fallible, and we need to =
know whether it will fail before we
> > > > > > +        // attempt to close the file.
> > > > > > +
> > > > > > +        // SAFETY: Getting a pointer to current is always safe=
.
> > > > > > +        let current =3D unsafe { bindings::get_current() };
> > > > > > +
> > > > > > +        // SAFETY: Accessing the `flags` field of `current` is=
 always safe.
> > > > > > +        let is_kthread =3D (unsafe { (*current).flags } & bind=
ings::PF_KTHREAD) !=3D 0;
> > > > >
> > > > > Since Boqun brought to my attention that we already have a wrappe=
r for
> > > > > `get_current()`, how about you use it here as well?
> > > >
> > > > I can use the wrapper, but it seems simpler to not go through a
> > > > reference when we just need a raw pointer.
> > > >
> > > > Perhaps we should have a safe `Task::current_raw` function that jus=
t
> > > > returns a raw pointer? It can still be safe.
> > > >
> > >
> > > I think we can have a `as_ptr` function for `Task`?
> > >
> > >     impl Task {
> > >         pub fn as_ptr(&self) -> *mut bindings::task_struct {
> > >             self.0.get()
> > >         }
> > >     }
> >
> > Forgot mention, yes a ptr->ref->ptr trip may not be ideal, but I think
> > eventually we will have a task work wrapper, in that case maybe
> > Task::as_ptr() is still needed somehow.
> >
>
> After some more thoughts, I agree `Task::current_raw` may be better for
> the current usage, since we can also use it to wrap a
> `current_is_kthread` method like:
>
>     impl Task {
>         pub fn current_is_kthread() -> bool {
>             let current =3D Self::current_raw();
>
>             unsafe { (*current).flags & bindings::PF_KTHREAD !=3D 0 }
>         }
>     }

I'll introduce a current_raw, then.

Alice
