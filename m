Return-Path: <linux-kernel+bounces-122930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D7688FFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8334D1C2AB89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322B7FBA9;
	Thu, 28 Mar 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEQ+2Jlv"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A37BB14;
	Thu, 28 Mar 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630593; cv=none; b=ALBTDnbG/6A2Ma1pyi181TYgZOKELjFNDKG5vaGkAgvpolUbDEgHvZ8AMKE6+Ld1OAC/A9WtIbI9I/iXSFer3XvqJnIKBU9wNlayxFOS7WIMQyfLd/PeSVBMjeBzWK4Ib7rmp7vzDJvo2+zVMK9v7w4UFf2J/35lwo8+3U8k2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630593; c=relaxed/simple;
	bh=hQzmvbxhNNSAwoVfixFw3/NX8Dks0Gpga5/5/VJjYVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmIeRv18cTAo2mYaVHjbbXypX2UT6+6YVxtUSmgVRPq3qMOHtr2nWLtNVAo69JJ1UQLFMaKnoHI67PRcYM3PlJBP/2ONPJWhEGF068LS/lC4xUjALuP0vuPWgBn6quT/tPZ8gykNzlfn03DEubq+0tpzIEZd9/yFqV+V2HVWKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEQ+2Jlv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6114c9b4d83so8203027b3.3;
        Thu, 28 Mar 2024 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711630591; x=1712235391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=53348LneH/B5psreK0+yHl8Gf7XqOlbsOvfHAb0AlJY=;
        b=SEQ+2Jlv3BSulrNHt6iBAXJUx0oUUurrzJMw780JAVGQCyTF0GUdIUtM/0qsaN1E9l
         JOC8X9AWEQebHB+sbb6yWY8/UWVrpIuJNylPgJ+Gyxkqpt5AgcSr5fbtKpbG34S193Gp
         w210meMdXcq2E6OVdqRNecCYsLV4JEQe1T58onOMgP0VCkeErlA4dH5ARgQ0ZnQ6Of9B
         GN0hma2r0HE6UEtG2DzkSSh4kQ/DcJWpAPS4sglBfAKtu3g3cpeJKB2FoaQaweqTCeDd
         PknHjpFFVTp0br9cZL/sCCueJ/rRew9lmBTZfvJ8XrdQDFaavPUfthH9qRHi6QHCGhz1
         7vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630591; x=1712235391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53348LneH/B5psreK0+yHl8Gf7XqOlbsOvfHAb0AlJY=;
        b=CT2jOaD/Gwgd4jawaAIjZ3klaY2VTxnfU2HU9R/eJmKpPvb3wmX7PkzoHJh8fX+gS0
         XucjiUJbaXhcbgNW7Z+D1ny2C1t5OxfG/YfsUi9mfXp+ZoK+pF+T8iKdAJx6nzJQxeC4
         6/Y/ooFVerwiVGIQzNuZHkF0b6u8x7E8q2BwTrvPdQScSSZ2ag18b1z7xkjysNKpX/6s
         ml0q4Ju506MQkqbQoD62HveYwAqYNwM1PN/2yr9SeDue1+tShVXfSWurYIfNDOc6D53r
         BpOA8LmXleKHtPqg3k0qE0tL+dWfvLMyEq+JG30liBqsKwwa2Mo85cwC88fXFNR8HjZj
         ZNZA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEQ0e1zGjD1DkgU2zsOMXab1EHbdD/Xr+UnX+pTl9O2HLZxQCgofKtuy/ljIdwlPAASi9I+uApLSWBVShSelpeLSew5b+R6NC0y2L
X-Gm-Message-State: AOJu0YxWz61yX/EglNsUC2QYdtFb6jUsFH5jd6c7oxjRk6jQxryBGzC6
	TX1XRtJfoKZVCnhBc2hK4E4vK9ncEvdX0PQnotoonJI17TyW9JnN4tLvwy42R6hnIV1EQxP1+rm
	vVJ0y5bK8v1TPceW4vZ4iLXmb2sNTw3Qq
X-Google-Smtp-Source: AGHT+IERv0U/5ChTdKjMEfziFMGM5U1eEKHd+Sii3rl9PtPcL0cF0GOOaE68QkIl8WJaFOqP4Ii6zw66SFkvk6ZKOME=
X-Received: by 2002:a0d:eb8c:0:b0:611:9a29:b2f2 with SMTP id
 u134-20020a0deb8c000000b006119a29b2f2mr2641958ywe.34.1711630590768; Thu, 28
 Mar 2024 05:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327032337.188938-1-wedsonaf@gmail.com> <20240327032337.188938-2-wedsonaf@gmail.com>
 <b5ef6fdb-781f-4caf-98ac-1f2ceca9f6d0@proton.me>
In-Reply-To: <b5ef6fdb-781f-4caf-98ac-1f2ceca9f6d0@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 28 Mar 2024 09:56:19 -0300
Message-ID: <CANeycqr1oW9dh6vQkO1y5GjoVHH99XKmqrNOx=ajL=yaOHOCVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: introduce `InPlaceModule`
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 13:16, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 27.03.24 04:23, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This allows modules to be initialised in-place in pinned memory, which
> > enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> > registrations, etc.) in modules without any extra allocations.
> >
> > Drivers that don't need this may continue to implement `Module` without
> > any changes.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>
> I have some suggestions below, with those fixed,
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > ---
> >  rust/kernel/lib.rs    | 25 ++++++++++++++++++++++++-
> >  rust/macros/module.rs | 18 ++++++------------
> >  2 files changed, 30 insertions(+), 13 deletions(-)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 5c641233e26d..64aee4fbc53b 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -62,7 +62,7 @@
> >  /// The top level entrypoint to implementing a kernel module.
> >  ///
> >  /// For any teardown or cleanup operations, your type may implement [`Drop`].
> > -pub trait Module: Sized + Sync {
> > +pub trait Module: Sized + Sync + Send {
> >      /// Called at module initialization time.
> >      ///
> >      /// Use this method to perform whatever setup or registration your module
> > @@ -72,6 +72,29 @@ pub trait Module: Sized + Sync {
> >      fn init(module: &'static ThisModule) -> error::Result<Self>;
> >  }
> >
> > +/// A module that is pinned and initialised in-place.
> > +pub trait InPlaceModule: Sync + Send {
> > +    /// Creates an initialiser for the module.
> > +    ///
> > +    /// It is called when the module is loaded.
> > +    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error>;
> > +}
> > +
> > +impl<T: Module> InPlaceModule for T {
> > +    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error> {
> > +        let initer = move |slot: *mut Self| {
> > +            let m = <Self as Module>::init(module)?;
> > +
> > +            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
> > +            unsafe { slot.write(m) };
> > +            Ok(())
> > +        };
> > +
> > +        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
> > +        unsafe { init::pin_init_from_closure(initer) }
> > +    }
> > +}
> > +
> >  /// Equivalent to `THIS_MODULE` in the C API.
> >  ///
> >  /// C header: [`include/linux/export.h`](srctree/include/linux/export.h)
> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index 27979e582e4b..0b2bb4ec2fba 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> > @@ -208,7 +208,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
> >              #[used]
> >              static __IS_RUST_MODULE: () = ();
> >
> > -            static mut __MOD: Option<{type_}> = None;
> > +            static mut __MOD: core::mem::MaybeUninit<{type_}> = core::mem::MaybeUninit::uninit();
>
> I would prefer `::core::mem::MaybeUninit`, since that prevents
> accidentally referring to a module named `core`.

Makes sense, changed in v3.

I also added a patch to v3 that adds `::` to all cases in the code
generated by the macro.

>
> >
> >              // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> >              // freed until the module is unloaded.
> > @@ -275,23 +275,17 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
> >              }}
> >
> >              fn __init() -> core::ffi::c_int {{
> > -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> > -                    Ok(m) => {{
> > -                        unsafe {{
> > -                            __MOD = Some(m);
> > -                        }}
> > -                        return 0;
> > -                    }}
> > -                    Err(e) => {{
> > -                        return e.to_errno();
> > -                    }}
> > +                let initer = <{type_} as kernel::InPlaceModule>::init(&THIS_MODULE);
>
> Ditto with `::kernel::InPlaceModule`.
>
> > +                match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr()) }} {{
>
> This requires that the `PinInit` trait is in scope, I would use:
>
>      match unsafe {{ ::kernel::init::PinInit::__pinned_init(initer, __MOD.as_mut_ptr()) }} {{

Also changed in v3.

> --
> Cheers,
> Benno
>
> > +                    Ok(m) => 0,
> > +                    Err(e) => e.to_errno(),
> >                  }}
> >              }}
> >
> >              fn __exit() {{
> >                  unsafe {{
> >                      // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> > -                    __MOD = None;
> > +                    __MOD.assume_init_drop();
> >                  }}
> >              }}
> >
> > --
> > 2.34.1
> >
>

