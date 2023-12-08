Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512D80AA1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjLHRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574382AbjLHRI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:08:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1B199F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:09:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so26770875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702055342; x=1702660142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl/DbN6PDteqBCGQ9SFUZrBoBUM3+MnvMlGzJ2oRlWc=;
        b=ONs6dyzXBrS2AgfPXz7Wapyl+fljixPVb1qHAtkf8G502cZ6qgPZVGjxq5ifLGHzT6
         7pNcGPNTV0dZrkVI5RbIjPBjlBhOHacc8v9Qdg71gmuK27bjPEbtR22OumupL4Jm2y+o
         k3Nmi3SMHgmdHQSrzYtyEjJUYSlW+AkpOuWrC7XR+u0eySwupG4XNcdC2rgx+4d6+sXx
         66FAuWXokvwRuXHuD0vNPkK7Mw0QJ2VtHtRYxg1st0wMPNexWYPy0vOyZ0tlC+Gr18Zx
         0eAJewCSGWJcWFZqW7q+dmJ8nm9qxLWHZmyY+VjD7yI9CDPDti7vt1PrMYsM5AE9z9us
         Z/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055342; x=1702660142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl/DbN6PDteqBCGQ9SFUZrBoBUM3+MnvMlGzJ2oRlWc=;
        b=f22iydfdPVKT4wO6wT2e0N79l3OUbQygqxAPKsmGx07jTswXLajB1wn/mZT3V3Yg1y
         s8/1ABG89vw8rOtasUYN2mFY2vBWpqQLeCnOGr1uAue7WILsOUvmzBXgeCiiizlpKN+K
         M/pm2eAanxvD1oLFv7YMy7O22ZYy+G+5zV2oCgyrrjrnKrMY0cMZ/2T3QHQwO7VPfJ9D
         7Az4Vk+6MoVtw5/RWtfkZLqdfuS8T0n0s60CA7JtCOeS4xOrcwngkP0Zm3ZQLO60cbNz
         PHqydM954rI3eP6/5OOBtud4IysNeSmcg0iNm/DCdOcKTvJ1Yiqnxbs8lL731Qn8ytx8
         itiw==
X-Gm-Message-State: AOJu0YxobbcXEsfM/05ekC0cXvSHF8/pQ0HnNCbnQ/TYCWEj7XcRDYaz
        J1l4RaESYjNO5LneWSfGnQ2vFc5zsMv/zSrH9gCwiA==
X-Google-Smtp-Source: AGHT+IEy8e06S4fId43OHcmqnKF2OESoFRh8QXmOC1uoECcvmH6MYKQYqoDygRPw7tSwVgYUj1xpnka3NZtAHQ8GNYU=
X-Received: by 2002:a05:600c:3093:b0:40b:5433:17ef with SMTP id
 g19-20020a05600c309300b0040b543317efmr118377wmn.30.1702055341613; Fri, 08 Dec
 2023 09:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com> <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net> <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <A0BFF59C-311C-4C44-9474-65DB069387BD@gmail.com> <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
In-Reply-To: <CANiq72k4H2_NZuQcpeKANqyi_9W01fLC0WxXon5cx4z=WsgeXQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Dec 2023 09:08:47 -0800
Message-ID: <CAKwvOdkgDwnC_jaGjXjk9yKYo=zWDR_3x7Drw3i=KX0Wyij6ew@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     comex <comexk@gmail.com>, Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Fri, Dec 8, 2023 at 8:19=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Dec 8, 2023 at 6:28=E2=80=AFAM comex <comexk@gmail.com> wrote:
> >
> > Regarding the issue of wrappers not being inlined, it's possible to get=
 LLVM to optimize C and Rust code together into an object file, with the he=
lp of a compatible Clang and LLD:
> >
> > @ rustc -O --emit llvm-bc a.rs
> > @ clang --target=3Dx86_64-unknown-linux-gnu -O2 -c -emit-llvm -o b.bc b=
.c
> > @ ld.lld -r -o c.o a.bc b.bc
> >
> > Basically LTO but within the scope of a single object file.  This would=
 be redundant in cases where kernel-wide LTO is enabled.
> >
> > Using this approach might slow down compilation a bit due to needing to=
 pass the LLVM bitcode between multiple commands, but probably not very muc=
h.
> >
> > Just chiming in as someone not involved in Rust for Linux but familiar =
with these tools.  Perhaps this has been considered before and rejected for=
 some reason; I wouldn=E2=80=99t know.
>
> Thanks comex for chiming in, much appreciated.
>
> Yeah, this is what we have been calling the "local-LTO hack" and it
> was one of the possibilities we were considering for non-LTO kernel
> builds for performance reasons originally. I don't recall who
> originally suggested it in one of our meetings (Gary or Bj=C3=B6rn
> perhaps).
>
> If LLVM folks think LLVM-wise nothing will break, then we are happy to

On paper, nothing comes to mind.  No promises though.

From a build system perspective, I'd rather just point users towards
LTO if they have this concern.  We support full and thin lto.  This
proposal would add a third variant for just rust drivers.  Each
variation on LTO has a maintenance cost and each have had their own
distinct fun bugs in the past.  Not sure an additional variant is
worth the maintenance cost, even if it's technically feasible.

> go ahead with that (since it also solves the performance side), but it
> would be nice to know if it will always be OK to build like that, i.e.
> I think Andreas actually tried it and it seemed to work and boot, but
> the worry is whether there is something subtle that could have bad
> codegen in the future.
>
> (We will also need to worry about GCC.)
>
> Cheers,
> Miguel



--=20
Thanks,
~Nick Desaulniers
