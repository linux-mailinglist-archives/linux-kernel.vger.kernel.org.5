Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6807A5264
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIRS4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIRS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:56:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DDDFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:55:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52fa364f276so2376a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695063354; x=1695668154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mr4adhPkgNVKHO3js/mkzV6WskANfNP7vwkNde/9Lk=;
        b=B4EleTC/c223+P6KkvjNjxmKQAU/NHhi+pjy6hDyLnXhO6Pag6UF7t4HOG+PWQWapS
         M8v5wD9Ag6iFA9WQPy0La7hqvsHsocTN2YgCWCWEvJi0gEXTIiBtvHWL79AQiVks/UxF
         ivWrRs8iwTcd8HWsobZsRhYH6tDPeVhq7sCE1ZbunC/RthPNatffNZB0+tYQ1PGiwEI2
         ONwd35XtJpR/k4QLUjXeShAlprJRJe+R44lLHhYRZFKXB3CCs9GIrWEzHGlSpp3ZXuOx
         l9nIh/yMnFd1ihrhOo5+HaryJTIuc1pZtfj8eAQh4peBx5q1kAQT7roXS0JDRyv+lKLW
         qh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063354; x=1695668154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mr4adhPkgNVKHO3js/mkzV6WskANfNP7vwkNde/9Lk=;
        b=DZ3qzA8CltZuHpLxPnDnrJePBtp9Q0SIkAeURDnkYebkCwh4lR5QBWbZQBrEnQxNiw
         Cu9G3P+sF9aYg8tY+FDcDeBCsxzGlCDPY7UonOB4Qojwsc6Z2jy63vW2aDqw+3JNaMWx
         pQDsWojZULz91TqYNjSr39Jn3hnilg3xPInuiMc9+TE4tG6efr8Jh6QMrxRgU2uyefCQ
         Eek8wOFpAqLwdYCZVnGNOXbNdB/pDB2MfRLwTjM2fmWHH6rMzS03CEUQc5zc7FYKwCP7
         dVvEQJtDHAu9dy1g39F9ID99mnznLnWG2nMq9hsNH+3OQtss99ih4avJX2oQzkY/yvC0
         2nZA==
X-Gm-Message-State: AOJu0YyavdXGO0yfg6kp5MaiFiz4gPbx3I7NkF335RvLA4RyguK3e7XM
        mR+Yz0S/XOdnAkl620uVCIiuSNFE7l6AqNyDRbA1vg==
X-Google-Smtp-Source: AGHT+IG+jmEW70Z7xuioTadwPjTTfOEfmqUC/hLAJIx5DSmQ7AaiSYR+4QQUC+owbeQwS+8+4PhVTUuso6MJYAAd8c0=
X-Received: by 2002:a50:8e4f:0:b0:523:bdc9:48a9 with SMTP id
 15-20020a508e4f000000b00523bdc948a9mr21829edx.0.1695063353972; Mon, 18 Sep
 2023 11:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172900.3784163-1-mmaurer@google.com> <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
 <SLZSYLg5E9OQKI546K87wxTYYLNlT1xM-LhC4W1JFhIate6PFsKq27RcBNhSjUkErYDlzsZB4F2Vc2KOP9tDThg58_tXycWn3K29mQXlFtU=@protonmail.com>
 <0561303E-2089-43FC-AA31-836C7BB844B7@kloenk.dev> <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
 <CAKwvOdnUdFjN+aCDrHKP6RzZCFB033ycN_KkB1WKucGd6VzUSg@mail.gmail.com>
 <CAGSQo00E1Wtg=f9SAcB2na69r4ASJ1L40ASPCyZV9FX+81uJCw@mail.gmail.com> <CAKwvOdnbbStoEeykYnx0jbnR=TAmmcdnOXbbA4Fx0BneFW8Fsg@mail.gmail.com>
In-Reply-To: <CAKwvOdnbbStoEeykYnx0jbnR=TAmmcdnOXbbA4Fx0BneFW8Fsg@mail.gmail.com>
From:   Matthew Maurer <mmaurer@google.com>
Date:   Mon, 18 Sep 2023 11:55:41 -0700
Message-ID: <CAGSQo01jMFVeqa=99Ne7tDXeOShcHWHBPgyiwZ+tm6x9qRJOfg@mail.gmail.com>
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Finn Behrens <me@kloenk.dev>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:43=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Sep 18, 2023 at 9:38=E2=80=AFAM Matthew Maurer <mmaurer@google.co=
m> wrote:
> >
> > On Mon, Sep 18, 2023 at 8:25=E2=80=AFAM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > What happens if you invoke the linker directly?
> > Rust unfortunately currently doesn't support invoking the linker
> > directly: https://github.com/rust-lang/rust/issues/73632
>
> Wait; does Rust have its own linker? It doesn't use the system linker?
>  Perhaps that's necessary for the rust module format? If so, TIL.
It does use the system linker (this is what -C linker is controlling),
but the command line passed to the linker may change, extra object
files may be added to the command line, etc.
>
> > > Generally, the kernel either invokes the compiler or the linker
> > > directly. (For assembler, it is typically preprocessed, as are linker
> > > scripts!)  So invoking the linker directly is a common pattern in
> > > kbuild.  It also makes me slightly sad if the rust compiler ends up
> > > invoking a c compiler, even if it's simply to drive the linker.
> > As mentioned earlier, we could pass $HOSTLD, but if the linker isn't
> > named something accurate (e.g. if the linker is not named lld, but is
> > lld), we need to know how to pass a flavor:
> > https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-flavo=
r
> > Would it be appropriate to just assume the linker is named correctly?
>
> If it were not, what does failure look like?
That depends. I think it will usually look like "unrecognized flag:
blah blah", but that's not guaranteed.
>
> command not found: asdfadfasdf
This isn't about command-not-found, it's about "I set
HOSTLD=3Dfoo/bar/weirdname, and it is an lld-like linker. rustc invoked
it assuming it is an ld-like linker."
>
> Seems fine to me. If the user mis-specifies HOSTLD=3D, then they will
> get a similar error, which should be prescriptive enough for them to
> figure out how exactly they're "holding it wrong."
>
> > > For example, Android carries a downstream patch to set `-fuse-ld=3Dll=
d`
> > > for $KBUILD_HOSTCFLAGS, because its build environment doesn't contain
> > > GNU binutils ("guilty, officer").
> > Oddly, the Android kernel environment (Kleaf) is the one that I needed
> > this patch to build in, but it seemed to be working without a manual
> > KBUILD_HOSTCFLAGS forwarding.
>
> Surprising that worked.
>
> > Overall, it sounds like you'd prefer if I set this to use
> > `KBUILD_HOSTLD` and `KBUILD_HOSTLDFLAGS`, and leave the linker flavor
> > to autodetect?
>
> Yes for the first two.
>
> Dunno, what precisely is a linker flavor?  Is that like a flavor of ice c=
ream?
> Oh, right looking at your link:
> https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-flavor
> Seems like if `LLVM=3D1` is set, or `LD=3Dld.lld`, or CONFIG_LD_IS_LLD, t=
hen
> the flavor should be set to ld.lld, else ld.  Then the
> KBUILD_HOSTLDFLAGS need to be passed, probably.
>
> But how are there "linker flavors" like ld or ld.lld if you just said
> "Rust unfortunately currently doesn't support invoking the linker
> directly: https://github.com/rust-lang/rust/issues/73632".  I'm having
> trouble reconciling the two.
Yes, what I meant by that is that *rustc* wants to invoke the linker,
rather than having the surrounding build system invoke the linker. The
exact command line passed to the linker in the final link, including
potential synthetic objects, is considered an internal detail.
>
> Can we do something more like the below?
>
> ifdef CONFIG_LD_IS_LLD
> hostrust_flags +=3D -C linker-flavor=3Dld.lld
> else
> hostrust_flags +=3D -C linker-flavor=3Dld
> endif
> hostrust_flags +=3D -C linker=3D$(HOSTLD) <todo: figure out how to pass
> KBUILD_HOSTLDFLAGS>
Yes, I can make host linking use `$(HOSTLD)` and pass the flavor based
on CONFIG_LD_IS_LLD. I'll send a variant that does that this
afternoon.
> --
> Thanks,
> ~Nick Desaulniers
