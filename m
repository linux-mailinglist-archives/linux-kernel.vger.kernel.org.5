Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3707BADAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjJEVgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:36:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36095
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:36:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso4675a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696541791; x=1697146591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWddOZrmmasiWu5O0KWGa9lmgFQoWcrVlIGB6YyWgVs=;
        b=4bJSH3eKN6MBY0Fpg0QIuGImOmRogXegcl4rJtKoq4BHU191C99zCRMoMz55rlPTTl
         IdHXlJVarO7ktFPAKrq3G7RTTRSApiidYU7KAPTnxItPPINLAXJyOUMlL8+Pz5mc2y3t
         bVWTXXqLg/nk+Cv1NEIIyPzU+lyR3WWwNWaWLXcBy75kL27BFIKk9zEopXfA67pc1YbM
         YjCWjQIMKGFuW8qy+s43YvrtMUtbuCRKAH2LItQ06bKkezqTHj5kV+oWlzTXHgXRXZ+i
         69hnaLjLeqjU2lrsmnGh8Ssdbgw4E9umxVYCnk78nEFjBRnNoAbQRJa+83Ke/zVUaTxb
         TdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541791; x=1697146591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWddOZrmmasiWu5O0KWGa9lmgFQoWcrVlIGB6YyWgVs=;
        b=g3KTNQwkqnsL+ax18S3OcICO8f7V+AoiXjVQYyF8R1SR62lYOmUWUuEkoNQopv3+sf
         1quXUlffB7rTLyP0nBtYxW7T5fPsNqtg8Nzk4rjaxu90QAXgfTkAePBQi8lpiO6H2ov7
         PISJtoeA4ikegxEF84EEL3UIjYiE9IAMdh+7a6WAeeB2mAypxhK+cYF/hqyXaMMScShH
         L1cd1nMyCFGcMFxSYDziAhXybKMXt6C/3+EiELDPh81BcRM4D0D6ROuv7ObKHxbcBEPk
         NdOD1V9Y56ukmmuvzfjo33TAOFF+l2THH604mPeS0tKo0HvYstZ+mED5f7AQUBJOSnJ2
         22lg==
X-Gm-Message-State: AOJu0Yzfj2Xo8w3orUO/WMSR78HvmlwqJ0C2saqAoNEiJCfYlCNQYxVL
        JWZ3P9Fd0lUDTNychD+653q+rtDRAqXebAtdgvBQJQ==
X-Google-Smtp-Source: AGHT+IGlPnoq0UGE7DkoUzQp1yA5leDO8Cu3vmPbEmr9NZ49zBh/WWSakqyb4sccb/9wcCnTmo4j2D3js6AfFSbidkA=
X-Received: by 2002:a50:9f67:0:b0:522:4741:d992 with SMTP id
 b94-20020a509f67000000b005224741d992mr121564edf.4.1696541790666; Thu, 05 Oct
 2023 14:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230928194801.2278999-1-mmaurer@google.com> <CAK7LNAQP9FVCArnw=JDBbtbu-3bxx162kqT24bUbffPtwE18uA@mail.gmail.com>
In-Reply-To: <CAK7LNAQP9FVCArnw=JDBbtbu-3bxx162kqT24bUbffPtwE18uA@mail.gmail.com>
From:   Matthew Maurer <mmaurer@google.com>
Date:   Thu, 5 Oct 2023 14:36:19 -0700
Message-ID: <CAGSQo01=UxFmPRo6OTU1443izumvF+Z0fevgdWVdHK6DGTehCQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Respect HOSTCC when linking for host
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:59=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Fri, Sep 29, 2023 at 4:48=E2=80=AFAM Matthew Maurer <mmaurer@google.co=
m> wrote:
> >
> > Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined=
,
> > resulting in build failures in hermetic environments where `cc` does no=
t
> > exist. This includes both hostprogs and proc-macros.
> >
> > Since we are setting the linker to `HOSTCC`, we set the linker flavor t=
o
> > `gcc` explicitly. The linker-flavor selects both which linker to search
> > for if the linker is unset, and which kind of linker flags to pass.
> > Without this flag, `rustc` would attempt to determine which flags to
> > pass based on the name of the binary passed as `HOSTCC`. `gcc` is the
> > name of the linker-flavor used by `rustc` for all C compilers, includin=
g
> > both `gcc` and `clang`.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> >  rust/Makefile         | 2 ++
> >  scripts/Makefile.host | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 87958e864be0..da664d7aed51 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -383,6 +383,8 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o =
FORCE
> >  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
> >        cmd_rustc_procmacro =3D \
> >         $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> > +               -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> > +               -Clink-args=3D'$(subst ','\'',$(KBUILD_HOSTLDFLAGS))' \
>
>
>
> Why not consistently use the escsq macro here too ?
>
>
I didn't use it in rust/Makefile because that makefile doesn't
directly import scripts/Kbuild.include, and I was under the mistaken
impression that scripts/ was supposed to be its own namespace, even if
Make wasn't enforcing it. Inspecting other functions in
scripts/Kbuild.include though, it's clear they're called elsewhere, so
I'll upload another version of the patch using escsq here as well.
>
>
>
>
> >                 --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --ext=
ern proc_macro \
> >                 --crate-type proc-macro \
> >                 --crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> > diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> > index 8f7f842b54f9..08d83d9db31a 100644
> > --- a/scripts/Makefile.host
> > +++ b/scripts/Makefile.host
> > @@ -91,6 +91,8 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
> >  # current working directory, which may be not accessible in the out-of=
-tree
> >  # modules case.
> >  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) =
\
> > +                -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> > +                -Clink-args=3D'$(call escsq,$(KBUILD_HOSTLDFLAGS))' \
> >                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
> >                   $(HOSTRUSTFLAGS_$(target-stem))
> >
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada
