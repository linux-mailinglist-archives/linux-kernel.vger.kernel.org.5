Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2697A4F83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjIRQp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjIRQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:45:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFEA3AB7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:38:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53074ee0c2aso17061a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695055113; x=1695659913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3SM+9HHyctg6dKNxTmfV4NWzrd21mc1tYe06HY4Uio=;
        b=2PqZkzd9k7yBu34EVfNCf8J6+6m/vsWIg4rJL7U3M9ow79SIAsFITTQXWMjXHbRIYA
         LgdfxIAQQ4Ci1bQPYWbFYeDacaQNXgV2+kqwZTC7d1qCvQQbJPd2xAi1PzvoaJOLTFAO
         vRqsonoxnMFxWfXPE7uvJ5fOPRAtOKkxZLN4rMeUBZ4OA9Mt4ryiJRL3RS4PfMxxkNaR
         1HQMokVsnjPzJQtJOgQt/6EBIIIZmhLOsR1y4dOLr7kWhzFWkP9/EUmkOEv6shzrYIYh
         mzDzGrmtK3rDN1l4usNiDS/I0dMJ1Hjc6+XjNMxJueKGgRbhWucVN//rP0b9YnsWkMye
         B1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055113; x=1695659913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3SM+9HHyctg6dKNxTmfV4NWzrd21mc1tYe06HY4Uio=;
        b=IILPBvqnZrvtNQoE4I4z0n4UBI8s6VH89vrtSb5n3DJmgtrZM6u0jXh2NoS+Y2UlAc
         xJW3X+MwdZfyVEI6xmsx56cwy6hs+q1bCWmqSaGULSOQmip9mWr8JwTuDNxptC2KpVZ3
         QLw054RjLyd/zswz69NwV8ieJRrbDvxtApN6aekNn0Mm+nYyN/mwywtE8Ze8xtTvkRFn
         BF9HJN8YB/nmeL9H8RNO59qQqH28V5Sss4DZaXuieoX1j0bGRpsRrBAyGmDNhUW1cYXl
         so6byD/U+hJUjoHIN1oJelE69luHvgdzmPBiGdR1g8zANn1aQlZO+r1Sv9zf5VyDzo08
         y6iw==
X-Gm-Message-State: AOJu0Yz4KH69Tr5gUZKFIhUwMJs6aWDcgsVSUypU8Ez2zpanfRswg1D3
        /tWahVsyt+P28u8QorawgdBMEEYzIzYXcNNZ8n0ufw==
X-Google-Smtp-Source: AGHT+IHoLERiM3cMevc6mq/BS8ZB7t5xuKPbZa6EUFkApsAcotBY6AOUXKnzZeo1Kdr1U6VYWmeaT73kPqlHXyf8HiA=
X-Received: by 2002:a50:8d19:0:b0:523:b133:57fe with SMTP id
 s25-20020a508d19000000b00523b13357femr160405eds.1.1695055112581; Mon, 18 Sep
 2023 09:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172900.3784163-1-mmaurer@google.com> <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
 <SLZSYLg5E9OQKI546K87wxTYYLNlT1xM-LhC4W1JFhIate6PFsKq27RcBNhSjUkErYDlzsZB4F2Vc2KOP9tDThg58_tXycWn3K29mQXlFtU=@protonmail.com>
 <0561303E-2089-43FC-AA31-836C7BB844B7@kloenk.dev> <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
 <CAKwvOdnUdFjN+aCDrHKP6RzZCFB033ycN_KkB1WKucGd6VzUSg@mail.gmail.com>
In-Reply-To: <CAKwvOdnUdFjN+aCDrHKP6RzZCFB033ycN_KkB1WKucGd6VzUSg@mail.gmail.com>
From:   Matthew Maurer <mmaurer@google.com>
Date:   Mon, 18 Sep 2023 09:38:19 -0700
Message-ID: <CAGSQo00E1Wtg=f9SAcB2na69r4ASJ1L40ASPCyZV9FX+81uJCw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 8:25=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Sep 16, 2023 at 12:54=E2=80=AFPM Matthew Maurer <mmaurer@google.c=
om> wrote:
> >
> > On Sat, Sep 16, 2023 at 11:07=E2=80=AFAM Finn Behrens <me@kloenk.dev> w=
rote:
> > >
> > >
> > >
> > > On 16 Sep 2023, at 19:53, Bj=C3=B6rn Roy Baron wrote:
> > >
> > > > On Saturday, September 16th, 2023 at 18:52, Finn Behrens <me@kloenk=
.dev> wrote:
> > > >
> > > >>
> > > >> On 15 Sep 2023, at 19:28, Matthew Maurer wrote:
> > > >>
> > > >>> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is d=
efined,
> > > >>> resulting in build failures in hermetic environments where `cc` d=
oes not
> > > >>> exist. This includes both hostprogs and proc-macros.
> > > >>>
> > > >>> Since we are setting the linker to `HOSTCC`, we set the linker fl=
avor to
> > > >>> `gcc` explicitly.
> > > >> But as `HOSTCC` could also be clang, the linker flavor would then =
be wrong, would that create a problem?
> > > >
> > > > Rustc uses the gcc linker flavor for clang too. There has been a pr=
oposal to split it up, but I'm not sure of the status of that. In any case =
clang's cli is similar enough to gcc that it works fine to use the gcc link=
er flavor.
> > > >
> > > In that case this looks very reasonable.
> > >
> > > Second thing I noticed is that `HOSTCC` could be the wrong variable, =
and `HOSTLD` would make more sense as we look for the linker and not the ge=
neral C compiler.
> > >
> > Yes, thanks Bjorn - "gcc" is the linker flavor used for "Use the C
> > compiler as a linker".
> >
> > With regards to HOSTLD, I was trying to make the minimum possible
> > change. Currently, it is using the command `cc` as a linker, so this
> > would preserve existing behavior when HOSTCC is unset.
>
> Hey! Isn't HOSTCC always set? Top level Makefile lines 442-445?
Yes, you're correct. What I was trying to express was that this keeps
the build process the same as when `cc=3DHOSTCC` today, which while not
required is frequently true.
>
> What happens if you invoke the linker directly?
Rust unfortunately currently doesn't support invoking the linker
directly: https://github.com/rust-lang/rust/issues/73632
We work around this for kernel level code by manually providing
expected symbols/stubs normally injected by rustc during linking
because it is critical to use the kernel linking infrastructure there,
but this doesn't seem as important on host unless I've missed
something. While we could do that, it would add nontrivial complexity
for minimal gain.
A nontrivial chunk of rust/Makefile is currently spent working around
this lack of support for non-rustc-managed link stages.
>
> Generally, the kernel either invokes the compiler or the linker
> directly. (For assembler, it is typically preprocessed, as are linker
> scripts!)  So invoking the linker directly is a common pattern in
> kbuild.  It also makes me slightly sad if the rust compiler ends up
> invoking a c compiler, even if it's simply to drive the linker.
As mentioned earlier, we could pass $HOSTLD, but if the linker isn't
named something accurate (e.g. if the linker is not named lld, but is
lld), we need to know how to pass a flavor:
https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-flavor
Would it be appropriate to just assume the linker is named correctly?
>
> I'm concerned that while this might invoke $HOSTCC, it probably won't
> do so with any of the $KBUILD_HOSTCFLAGS set.  That's generally been a
> problem in the past.
This would not work correctly with my patch. Once we decide which of
the two linkage strategies we want (using $HOSTCC or $HOSTLD) I'll
send a new patch that forwards the flags along.
>
> For example, Android carries a downstream patch to set `-fuse-ld=3Dlld`
> for $KBUILD_HOSTCFLAGS, because its build environment doesn't contain
> GNU binutils ("guilty, officer").
Oddly, the Android kernel environment (Kleaf) is the one that I needed
this patch to build in, but it seemed to be working without a manual
KBUILD_HOSTCFLAGS forwarding.
>
> So if you set `rustc` to use `clang` as the linker, how do you
> guarantee that `-fuse-ld=3Dlld` or any of the upstream
> $KBUILD_HOSTCFLAGS get used?
>
> Android also sets `--sysroot` for the $KBUILD_HOSTCFLAGS to guarantee
> that the UAPI header tests can be built against bionic (Android's
> libc).
>
> Or is that handled elsewhere in rust/Makefile already?
>
> Also, if this is your first kernel patch, nice job! Welcome!
>
Overall, it sounds like you'd prefer if I set this to use
`KBUILD_HOSTLD` and `KBUILD_HOSTLDFLAGS`, and leave the linker flavor
to autodetect?
> >
> > If we would prefer `HOSTLD` instead we can do that, but we would need
> > to additionally inspect `LLVM` to set the linker flavor accordingly
> > (e.g. set ld vs ld.lld).
> >
> > Do folks have strong opinions between these? My primary concern is to
> > avoid calling programs by foo when their HOSTFOO variable is set.
> >
> > See https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-f=
lavor
> > for details on linker flavor settings.
> > > >>>
> > > >>> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > > >>> ---
> > > >>>  rust/Makefile         | 1 +
> > > >>>  scripts/Makefile.host | 1 +
> > > >>>  2 files changed, 2 insertions(+)
> > > >>>
> > > >>> diff --git a/rust/Makefile b/rust/Makefile
> > > >>> index 87958e864be0..2a2352638f11 100644
> > > >>> --- a/rust/Makefile
> > > >>> +++ b/rust/Makefile
> > > >>> @@ -383,6 +383,7 @@ $(obj)/exports_kernel_generated.h: $(obj)/ker=
nel.o FORCE
> > > >>>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
> > > >>>        cmd_rustc_procmacro =3D \
> > > >>>     $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> > > >>> +           -C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
> > > >>>             --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --e=
xtern proc_macro \
> > > >>>             --crate-type proc-macro \
> > > >>>             --crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> > > >>> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> > > >>> index 8f7f842b54f9..0aa95a3af1c4 100644
> > > >>> --- a/scripts/Makefile.host
> > > >>> +++ b/scripts/Makefile.host
> > > >>> @@ -91,6 +91,7 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
> > > >>>  # current working directory, which may be not accessible in the =
out-of-tree
> > > >>>  # modules case.
> > > >>>  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(dep=
file) \
> > > >>> +            -C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
> > > >>>                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) =
\
> > > >>>                   $(HOSTRUSTFLAGS_$(target-stem))
> > > >>>
> > > >>> --
> > > >>> 2.42.0.459.ge4e396fd5e-goog
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
