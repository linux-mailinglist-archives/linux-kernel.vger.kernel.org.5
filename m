Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F780A902
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574129AbjLHQcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574107AbjLHQcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:32:05 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74503199E;
        Fri,  8 Dec 2023 08:32:11 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso2306184276.3;
        Fri, 08 Dec 2023 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702053130; x=1702657930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcWDWrxJKJsDNQlJWfAvkrUSeWhVHUneuN6r9y2FUNo=;
        b=Au/CKWaNPQXK0UEONl/OOaLok1zy17F1B4d/3rfxhKwHeTZ3nGtNCIJTfp/p5auCw+
         1nyZPZ2uOB4/PFqGpssbv3f54eeC64MNr8kAGmmjpaY2Z/e3q9d1VMSkFKXdSYWI18OW
         BlMLSBhzVMLyUceY9Kf7hsWRR2gfbnjO5NuSJyBB4eUDwbIu9hG6+4eMb8CLDO9MR6/e
         +JvbEu4EMXLC2qY9iiOfWNgDr/GHGHGnub9Wl4VIsm65/yEc2mf3mRoHJlhAZ1alVgoS
         SrFXsodEPsGsbJfbgA637KBuZZqSWx+wUzUmLRQib+FjujBskUlnUxhidItJ+mEbovMW
         gnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053130; x=1702657930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcWDWrxJKJsDNQlJWfAvkrUSeWhVHUneuN6r9y2FUNo=;
        b=ALAKpn5PZQWgO+UdnkfMvhzSsc4JBZ/kSxht9jT2/BPjlOVf+sIfmwZBm/Y75Fgan1
         KOj6FGK4zZkLtvhupqM9r5HB04DyMWghmamgpr1I8ofAHYFhPI4+D7ymTfFHmR/bnkIB
         wQEr18Ol0aOXakNDMo6wdJStPX8gR7KyLEXV44YjHw9pqa5ILZtY18FBHmkrrDkztnBA
         P+OXzEfqgMHDz4IiMZb3PAa7aMpsNXFb7TRltm7lvA1o+FzjXu5Io/KL1x8jn2KTmxrp
         np1Ixxso6UnBi6OdCN4cTsTrEuso4dPMAoxr7q9lcM4F/VtnPB0JPpX7/w8MU2f6fwjB
         3Uow==
X-Gm-Message-State: AOJu0Yzc48mCzX3zYCehglY0qpK4QUl6P2yF6CNT1aF2eB+Mh+bIkSF/
        /VCJXR4i5iaScHo7AKal3/o+gDsg0LOnBHjxf48=
X-Google-Smtp-Source: AGHT+IGNXwRPSfsojGpRqvPHKsnX+uuLHn/BXuwd0ll2480FrLztxjVjrseRoiNqJDGmWyuUpb2W1PDHzL4aukrPMlo=
X-Received: by 2002:a05:6902:1b13:b0:db8:c416:5281 with SMTP id
 eh19-20020a0569021b1300b00db8c4165281mr216466ybb.23.1702053130681; Fri, 08
 Dec 2023 08:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com> <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com> <20231206134041.GG30174@noisy.programming.kicks-ass.net>
In-Reply-To: <20231206134041.GG30174@noisy.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Dec 2023 17:31:59 +0100
Message-ID: <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 2:41=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Anywhoo, the longer a function is, the harder it becomes, since you need
> to deal with everything a function does and consider the specuation
> window length. So trivial functions like the above that do an immediate
> dereference and are (and must be) a valid indirect target (because
> EXPORT) are ideal.

We discussed this in our weekly meeting, and we would like to ask a
few questions:

  - Could you please describe an example attack that you are thinking
of? (i.e. a "full" attack, rather than just Spectre itself). For
instance, would it rely on other vulnerabilities?

  - Is this a kernel rule everybody should follow now? i.e. "no (new?)
short, exported symbols that just dereference their pointer args". If
so, could this please be documented? Or is it already somewhere?

  - Are we checking for this in some way already, e.g. via `objtool`?
Especially if this is a rule, then it would be nice to have a way to
double-check if we are getting rid of (most of) these "dangerous"
symbols (or at least not introduce new ones, and not just in Rust but
C too).

Thanks Peter!

> That would be good, but how are you going to do that without duplicating
> the horror that is struct task_struct ?

As Alice pointed out, `bindgen` "solves" that, but it is nevertheless
extra maintenance effort.

> Well, I really wish the Rust community would address the C
> interoperability in a hurry. Basically make it a requirement for
> in-kernel Rust.

Yeah, some of us have advocated for more integrated C support within
Rust (or within `rustc` at least).

> I mean, how hard can it be to have clang parse the C headers and inject
> them into the Rust IR as if they're external FFI things.

That is what `bindgen` does (it uses Clang as a library), except it
does not create Rust IR, it outputs normal Rust code, i.e. similar to
C declarations.

But note that using Clang does not solve the issue of `#define`s in
the general case. That is why we would still need "helpers" like these
so that the compiler knows how to expand the macro in a C context,
which then can be inlined as LLVM IR or similar (which is what I
suspect you were actually thinking about, rather than "Rust IR"?).

That "mix the LLVM IRs from Clang and `rustc`" ("local LTO hack")
approach is something we have been discussing in the past for
performance reasons (i.e. to inline these small C functions that Rust
needs, cross-language, even in non-LTO builds). And if it helps to
avoid certain attacks around speculation, then even better. So if the
LLVM folks do not have any major concerns about it, then I think we
should go ahead with that (please see also my reply to comex).

GCC is still a question mark, though.

Cheers,
Miguel
