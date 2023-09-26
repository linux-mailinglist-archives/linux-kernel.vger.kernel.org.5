Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A87AEFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjIZPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjIZPlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:41:37 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762F120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:41:29 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-495c9eb8911so3304737e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695742889; x=1696347689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61qUDQIUo4t4iOJB48yhTUPDpR6d+0iCSSZ6+kuW/VA=;
        b=NJ+AlP6A4Utyu8vfpKspu5qn2Hx9pdiYnxnUvBYF0AwqrQwfaIIK6vXTyGwSXW7jTS
         ZSLCQwZde7Cw7eyiLNOTtpXT7zYYoZFWR141LXuv+QlfQPe88rT+lMnxkmtxCa7wF2y4
         +t5MlEWEyC0bKVCcW4NUdTEwZeFO2OWDh0ZFWF69SlkXsPeGjHoBcIacnm7KD9BQKtea
         uRCwVCD1VO3689nEgl2wmvAT9ov3DdLQOs5FESNPNIozrp8TVXwMdEv9meqlKiLghE/8
         NL5xvaDqcZVRgBYLKwXa6wy8kQCpeBnMEGuiL7GR7VlrDKBwPhap4mk+B2nvoeMaTxse
         FuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695742889; x=1696347689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61qUDQIUo4t4iOJB48yhTUPDpR6d+0iCSSZ6+kuW/VA=;
        b=InG2F+JJxcbj5FH3PQSLoMm8EpGMtLZ91j4nhJL+tlCIXkV0eYwAn09FkXaSxvWGex
         ewvGoDv2KSC//zf66clocSYMzQwlkbtRMFCeiGOdc5C6OHOle/VjxjQliZIWL+oF0IfX
         diIFVn6c5QPZ0dGDWOFRZHUv0CG88GEuagSoS/MQbfess07ShznRk3teOCGk9TkLwPP+
         RFtLbCtYkx0mIpw0nlR63MUDPJfao1mrUv7ul2+98zzR2lFgMeN9KvpW5mt6/ivnqN+W
         8b3+v6vWWmHirBE3kDsQsdBnK683CsCW0MMvu1Ubcv0WkZPDkhDKiII28wFENrgA9i1P
         Z1Cg==
X-Gm-Message-State: AOJu0Ywm0tq1VaF4us98h1DXWdZS/wpSYICyHoc5JlXrc/I2MxT/40bD
        6CvHvFcUEEA1bDDBBTCKCVBBgIGOIK68yURNJnkFuQ==
X-Google-Smtp-Source: AGHT+IGmkQfuwS2veSa8WLqQh88ElLffrGlpP684uNa6VaOgNEbMluewbtNJtDCK7Dh1ugezKsCbe6w2QB3BNkyOXDo=
X-Received: by 2002:a1f:4a41:0:b0:490:1114:f3ee with SMTP id
 x62-20020a1f4a41000000b004901114f3eemr6724907vka.8.1695742888603; Tue, 26 Sep
 2023 08:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home> <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux> <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux> <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux> <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
 <20230926162659.6555bcdc@gary-lowrisc-laptop> <ZRL3mlWXqseER8xK@Boquns-Mac-mini.home>
In-Reply-To: <ZRL3mlWXqseER8xK@Boquns-Mac-mini.home>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Tue, 26 Sep 2023 17:41:17 +0200
Message-ID: <CAH5fLggUPQtNjLg6BnYHcLmefuHdJpg0_eGVgX+dARUTRHexsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <alice@ryhl.io>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 5:24=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Sep 26, 2023 at 04:26:59PM +0800, Gary Guo wrote:
> > On Mon, 25 Sep 2023 22:26:56 +0000
> > Benno Lossin <benno.lossin@proton.me> wrote:
> >
> [...]
> > >
> > > The pointer was originally derived by a call to `into_raw`:
> > > ```
> > >      pub fn into_raw(self) -> *const T {
> > >          let ptr =3D self.ptr.as_ptr();
> > >          core::mem::forget(self);
> > >          // SAFETY: The pointer is valid.
> > >          unsafe { core::ptr::addr_of!((*ptr).data) }
> > >      }
> > > ```
> > > So in this function the origin (also the origin of the provenance)
> > > of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
> > > Raw pointers do not lose this provenance information when you cast
> > > it and when using `addr_of`/`addr_of_mut`. So provenance is something
> > > that is not really represented in the type system for raw pointers.
> > >
> > > When doing a round trip through a reference though, the provenance is
> > > newly assigned and thus would only be valid for a `T`:
> > > ```
> > > let raw =3D arc.into_raw();
> > > let reference =3D unsafe { &*raw };
> > > let raw: *const T =3D reference;
> > > let arc =3D unsafe { Arc::from_raw(raw) };
> > > ```
> > > Miri would complain about the above code.
> > >
> >
> > One thing we can do is to opt from strict provenance, so:
> >
>
> A few questions about strict provenance:
>
> > ```
> > let raw =3D arc.into_raw();
> > let _ =3D raw as usize; // expose the provenance of raw
>
> Should this be a expose_addr()?

Pointer to integer cast is equivalent to expose_addr.

> > let reference =3D unsafe { &*raw };
> > let raw =3D reference as *const T as usize as *const T;
>
> and this is a from_exposed_addr{_mut}(), right?

Integer to pointer cast is equivalent to from_exposed_addr.

> > let arc =3D unsafe { Arc::from_raw(raw) };
> > ```
> >
>
> One step back, If we were to use strict provenance API (i.e.
> expose_addr()/from_exposed_addr()), we could use it to "fix" the
> original problem? By:
>
> *       expose_addr() in as_with_ref()
> *       from_exposed_addr() in `impl From<&WithRef<T>> for Arc`
>
> right?
>
> More steps back, is the original issue only a real issue under strict
> provenance rules? Don't make me wrong, I like the ideas behind strict
> provenance, I just want to check, if we don't enable strict provenance
> (as a matter of fact, we don't do it today),

Outside of miri, strict provenance is not really something you enable.
It's a set of rules that are stricter than the real rules, that are
designed such that when you follow them, your code will be correct
under any conceivable memory model we might end up with. They will
never be the rules that the compiler actually uses.

I think by "opt out from strict provenance", Gary just meant "use
int2ptr and ptr2int casts to reset the provenance".

> will the original issue found by Alice be a UB?

Yes, it's UB under any ruleset that exists out there. There's no flag
to turn it off.

> Or is there a way to disable Miri's check on
> strict provenance? IIUC, the cause of the original issue is that "you
> cannot reborrow a pointer derived from a `&` to get a `&mut`, even when
> there is no other alias to the same object". Maybe I'm still missing
> something, but without strict provenance, is this a problem? Or is there
> a provenance model of Rust without strict provenance?

It's a problem under all of the memory models. The rule being violated
is exactly the same rule as the one behind this paragraph:

> Transmuting an & to &mut is Undefined Behavior. While certain usages may =
appear safe, note that the Rust optimizer is free to assume that a shared r=
eference won't change through its lifetime and thus such transmutation will=
 run afoul of those assumptions. So:
>
> Transmuting an & to &mut is always Undefined Behavior.
> No you can't do it.
> No you're not special.
From: https://doc.rust-lang.org/nomicon/transmutes.html

Alice
