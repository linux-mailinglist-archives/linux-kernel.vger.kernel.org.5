Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A327A6BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjISUDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjISUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:03:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B278F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:03:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-773a5bb6fb6so331107885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695153780; x=1695758580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l4uEd0cg+MK1zLuMTcTMLF2fu+76E8W8FTaKs4YQfM=;
        b=pEM5lbOD0gL3PxI5i7i3zQpeJMr8WxD9QgkyW8ay96xWhiiAdDj7Pw7UcHAbvrzg1w
         uS1HJLCpvkCYT7uiC4kMFKNG0ZmXjCbRgHKvGmFb1J+zkYmeQlavPJr5CvCuEF3AJt6g
         SMYQQGV+e4YMOhjAqAANbKp9b5p8uhVwaBcrJpq+OPMrOHlh0JvbG25vKOCmxEb22IQ+
         u3Sy8zD6jDfFDijAYjutAZ+kTqs1fQj1wPllcoOhkLoZumwLSdpLgX/of5bA8zyHb+qX
         87CZeLbmdSyVii/0gmi2zj6XQ/GHWfM7L1TbDOdEYPHK2d61YJDqrjsvfOChwg4vBelH
         MGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695153780; x=1695758580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l4uEd0cg+MK1zLuMTcTMLF2fu+76E8W8FTaKs4YQfM=;
        b=CXeneOlZETjuvI8fgYSqlTIJO6Gksv0xI2kARA1+qc4kgYRi34xmU+i+kwxWdj8gTM
         LWfnFJWKK/trbrMtI8BrGrX5zpT17FhHcyZNGphwjT8ExUAlhdYjsVcAa1WD95fcDSQ3
         6gMbshwu7vccJg4hwNxwKiEJiOAxLZAy44JGGVZ3MOMuC2JOuU1EWD12Yt97XgLcR/yC
         kH795FxsRae2DWRcAv/a+59Sv50p73YvbMTuoo+FmBLCdXHgkcO1lGJaW+X85U4qDDra
         qHOdBqdwK02oQ0ra9jeUCmR4Gr9ckt8XsPSR0Nf1jeswpZwRPePnXk/2mRI7CK69W7n2
         utig==
X-Gm-Message-State: AOJu0Ywsr89IKCfD2jse1gYNw/w1jyViEPQcmHuPivn7OMbWVuea8ndW
        3U410lioQ8WlqR96ZnEZoxvYJC8CbYwsA7EleWeZqQ==
X-Google-Smtp-Source: AGHT+IEg4YYJXSRCJjiZztWRLMA06g93UiRXI+JvX82ar2KRzox8IysEDd0GPASOHXXhqXoVCo+bagkSzIQDpfu/hfI=
X-Received: by 2002:a0c:e448:0:b0:64f:69a3:af3f with SMTP id
 d8-20020a0ce448000000b0064f69a3af3fmr358512qvm.39.1695153780151; Tue, 19 Sep
 2023 13:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230918234412.363087-2-mmaurer@google.com> <CAKwvOdmsNwszu4Vk1K7e39hencNcjEmjr5q7EbTJCjdY5TDsFA@mail.gmail.com>
In-Reply-To: <CAKwvOdmsNwszu4Vk1K7e39hencNcjEmjr5q7EbTJCjdY5TDsFA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Sep 2023 13:02:45 -0700
Message-ID: <CAKwvOdmanTTOmmwSMn2rQa5Ri_TpTTp7XMXZQfVh_GA694VvAA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:44=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Sep 18, 2023 at 4:44=E2=80=AFPM Matthew Maurer <mmaurer@google.co=
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
> > `gcc` explicitly.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> >
> > Updated the patch to reflect Nick's comment that KBUILD_HOSTLDFLAGS
> > should be respected as well.
> >
> > I did not switch it to use HOSTLD for two reasons:
> > * That variable is not globally defined - it is only available in two
> >   subdirectories of tools/
> > * C host scripts are linked by HOSTCC as well, even when linking a
> >   collection of object files. It *prints* HOSTLD, but invokes HOSTCC.
> >   See scripts/Makefile.host cmd_host-cmulti for an example.
>
> Sure, that makes sense to me, thanks for pointing that out.
>
> >
> >  rust/Makefile         | 4 ++++
> >  scripts/Makefile.host | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 87958e864be0..b60b7eb8c5a0 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -380,9 +380,13 @@ $(obj)/exports_bindings_generated.h: $(obj)/bindin=
gs.o FORCE
> >  $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
> >         $(call if_changed,exports)
> >
> > +KBUILD_HOSTLDFLAGS_SQ =3D '$(subst ','\'',$(KBUILD_HOSTLDFLAGS))'
>
> I don't think we need to do this kind of escaping. If a linker flag is
> passed to the linker directly as the driver has spaces such as `-z
> relro`, if it is instead passed to the compiler as the driver will not
> contain spaces (`-Wl,-z,relro`). As such, I don't think we need this
> escaping (famous last words).  Mind submitting a v3 without it?

Thanks for clarifying off list that:
```
It's not escaping the spaces, it's escaping any quotes
example: -Clink-args=3D'-Wl,-z,relro -Wl,-linker-plugin-lto'
Without the quote, the second one would go to rustc rather than the linker
```

Sorry for misunderstanding what exactly we were escaping here and why;
thanks for implementing my suggestion of passing along
KBUILD_HOSTLDFLAGS though.  That will avoid issues for Android
downstream.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > +
> >  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
> >        cmd_rustc_procmacro =3D \
> >         $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> > +               -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> > +               -Clink-args=3D$(KBUILD_HOSTLDFLAGS_SQ) \
> >                 --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --ext=
ern proc_macro \
> >                 --crate-type proc-macro \
> >                 --crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> > diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> > index 8f7f842b54f9..dc0410cae5ca 100644
> > --- a/scripts/Makefile.host
> > +++ b/scripts/Makefile.host
> > @@ -87,10 +87,14 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
> >                   $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
> >                   $(HOSTCXXFLAGS_$(target-stem).o)
> >
> > +KBUILD_HOSTLDFLAGS_SQ =3D '$(subst ','\'',$(KBUILD_HOSTLDFLAGS))'
> > +
> >  # `--out-dir` is required to avoid temporaries being created by `rustc=
` in the
> >  # current working directory, which may be not accessible in the out-of=
-tree
> >  # modules case.
> >  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) =
\
> > +                -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> > +                -Clink-args=3D$(KBUILD_HOSTLDFLAGS_SQ) \
> >                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
> >                   $(HOSTRUSTFLAGS_$(target-stem))
> >
> > --
> > 2.42.0.459.ge4e396fd5e-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
