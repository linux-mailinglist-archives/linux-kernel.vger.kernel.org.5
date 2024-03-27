Return-Path: <linux-kernel+bounces-121428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FEB88E7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC41F343D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC01474D7;
	Wed, 27 Mar 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAnLAVG7"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052637162;
	Wed, 27 Mar 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549454; cv=none; b=VBP3L62SZXje1VAPCbPhvFeSfzsWJt0zJOLyoeKS6ZvWvAwF0dsrc0qdKeJbqfLMVWHP5baO2r4AopHbhyLgUMkkmnp0q8cGAMUFLcXLA886xGmhWAlWC26NlTcSJq5or02jUGjtuC6uWHmib7XRoSgVpCDv6GdMmplXlWg2OQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549454; c=relaxed/simple;
	bh=5uybJQeoz0UlYmhYcedH9Y62JUHYOiDZUT4JRsBnQI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlzX8srk+f0Mszz9NbNjpCwOhhf2f3PgDG4iyuTRg5WPK4FgxEdxJtKziQl6s/RAcaJglujysYtS9CPwjusGaI2a0ynuKpptTysb1avJUUNafXfGPBy4XnM8qBU5ykMZRnt+foa7MuyYNx038h8m6Jye5GGD99HY3R8gPjPSya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAnLAVG7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a0579a968so72531987b3.3;
        Wed, 27 Mar 2024 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711549451; x=1712154251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRkC23Bbx4fNIp5RQWCN9/rshJX5/fqHtJ7QVDAkoWQ=;
        b=IAnLAVG7wXT/vub8/8/rTuNOTDzNZMkzNOO0g9ODvvNqVW4x/gL32Aa/SHVnm/tQTr
         JWk39TNlwkEuJLB45o7UNwI6XJ/nhJfKzvn3ytM1CcBP998wyX9l9ZOCZle4iXoW0z2G
         GoJ06pFyvZMLXFe+B8tq/UYcNHUsLXK+x5qOjC1NgRpLXZnuNBREuDATLtsvtnkRrRDL
         8bSn5Fsv8yZV+Zul1oFN7flsviX19f/nIiS5VpsuFRFVra9A+OoFPC9ReAQ7FGnqzwSM
         ZEvb07UHL5G/kpT3E3kbNoShQ7Gf3PY9DSEbifzLzgdGnmBJpeg5mG3UB/ggjDZe5aCZ
         s4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549451; x=1712154251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRkC23Bbx4fNIp5RQWCN9/rshJX5/fqHtJ7QVDAkoWQ=;
        b=OvGdQFWjmzT41K19CrMJ8bVarahkStf6Kq2wUM7BVyjoBFk9IhILScmZoa7PDE1UAF
         4+BLeTAuyNKCbzPmnYV944+P4G9QANC0OLmSvFRa00BkvyqIMlP7TyEfI6qnZ6+KA3Cf
         NIl3tCe1dZRI/9qF8VJMKJhX7L74QfJEC+yt7wGmNSlJEDOeaxNs0Br3otuMjfgzprUh
         wkqwg4pFo+IXNXcPrJa4V54gAb9N4Pk43rIG5ogK1s9d7GLWEQPitFtydl4vH17zJJBZ
         oGRAy+9y51PqBiKM+pDLHlApNO7M2rXhY/StiH6DbMjZ/gVI2+EdIHJdLtHhA09hpMRx
         kIWA==
X-Forwarded-Encrypted: i=1; AJvYcCUfIbaCmNn+8ugc2vQom4gQf15HdItAFDISFUr3zbT+iHYDJS6fBK9oR1UIin6OlnasEQJF7ACTP7u1dWq9P8gK5U6oBIdXV6fRjQG4++M1RCyPghUiG8GEQDsajfkbuTEr963VaiHirUxKjwA=
X-Gm-Message-State: AOJu0YwGOL1npaYT3JzPn7k5AlPtOLa59t3Xdxm66dtTyoWAJBY6yPt/
	A4pSJUXCqrnZheX7KoRBMvdQmclrv9nbOCjkXDD24hX5x3rKrb71igXhK1Cfgxgmr4tIDx4rQdy
	gcdK6EWKD4j8FC92Pppn4AlaKTnw=
X-Google-Smtp-Source: AGHT+IGF8iJXEFFPCUrOJPMSEJRnBYJOyochq9rP2jG94TH4EA+XFTak+JA6CGAod218V07rScTsQUgah2QISYfNZEo=
X-Received: by 2002:a81:a011:0:b0:611:3002:30 with SMTP id x17-20020a81a011000000b0061130020030mr2742805ywg.8.1711549450809;
 Wed, 27 Mar 2024 07:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327032337.188938-2-wedsonaf@gmail.com> <20240327081317.45574-1-kernel@valentinobst.de>
In-Reply-To: <20240327081317.45574-1-kernel@valentinobst.de>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 27 Mar 2024 11:23:59 -0300
Message-ID: <CANeycqo9noMJGSCsjCoH29xuPTJ7NEmYnFBE__9D+tvaqsiLdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: introduce `InPlaceModule`
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, walmeida@microsoft.com, 
	Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 05:13, Valentin Obst <kernel@valentinobst.de> wrote:
>
> > This allows modules to be initialised in-place in pinned memory, which
> > enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> > registrations, etc.) in modules without any extra allocations.
> >
> > Drivers that don't need this may continue to implement `Module` without
> > any changes.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
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
>
> This does not compile with `CONFIG_AX88796B_RUST_PHY=y || m` (or the
> phylib abstractions' doctests) since the module `Registration` is not
> `Send`.

Thanks for the heads up. I thought I had enabled all rust code but
indeed I was missing this. I will fix it in v2.

> I remember Trevor raising the question whether we want to require modules
> to be `Send`. I am not aware of any examples of `!Send` modules but I guess
> it would be possible to write code that is only correct under the
> assumption that it is loaded/unloaded in the same context.

It might be possible in the future, but I don't believe it is now
because all rust modules support unloading. And there is no guarantee
that the thread unloading (and therefore calling module_exit) is the
same that loaded (and called module_init), so a module must be Send to
properly handle drop being called from a different thread.

Not requiring Send on the original Module trait was an oversight that
I don't want to repeat in InPlaceModule.

>
> @Trevor: Are you aware of any modules with that requirement?
>
> I have been using this patch for quite a while with my TCP CCAs now
> (without the `Send` bound) and did not experience any other issues; thus
> offering:
>         Tested-by: Valentin Obst <kernel@valentinobst.de>

Thanks!

>
>         - Best Valentin
>
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
> > +                match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr()) }} {{
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

