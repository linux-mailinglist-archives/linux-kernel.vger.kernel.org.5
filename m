Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934578795F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbjHXUdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243550AbjHXUc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:32:56 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042BE6D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:32:54 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a01d654111so101775241.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692909174; x=1693513974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHgc3WP+Nh6Vx2D3nfsqbnX7Tv1DqoV0JUg0NhhaZj0=;
        b=yUSsrWXewLlVITH1WXfUdKTdRJucx44NluTkLK1hKUN7MOAOoeNAxg0GbiBkppLBqw
         2SSw7fRty8PZ4jahXDUgvCq6mHGME3/pusrnlWgJBQyOLKpyGrwtNZ76eo8bzd4gEbps
         yRsgzQ8KQjJ/SYrfq4tsGNfmnB+XT/f61OeeP2a91WwQmxDzHRf5reDG0dTf5yreKwOP
         YkPC563nZqNgtMUZ6rDBIU3zgrCfc4DRcSVZJC+mjhLctJcnN6fh+yCgPrn8OqJW//CO
         J1fTP929LHNCV/PLeEV0dYOaVChPytLLrG7ZW53zcO8+NggVhA0Ci2pCr05ZYWWLt7Gj
         Y3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909174; x=1693513974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHgc3WP+Nh6Vx2D3nfsqbnX7Tv1DqoV0JUg0NhhaZj0=;
        b=PoV2pFhB6TlSBjUxOWewtcQngT0GdEgnhi4dyrbiAdhJqxl3yDYtKxlPb1raYC/v81
         ibDnRggj0tdi5JqHVU7lsESz8KAmbS1hA9Fmhcaql9ar2mO3V3+x8dy0qNZ3b7z3dHXV
         gv0b8H0pbt7Sw/9ptLURr+YELDjHYQ+un9gweWYJyRfV2JGvLhYfUnovaxVEbExn++5A
         HF1EJSDETOOG6JbMS17hZXHiwC/FFzT0Wul72rcKgDxhNVNfKZJbNifbZkHnwZ+jx95W
         ZMdSWrPGg8CZi7aaSVWiM3zG3sBTzWRDrG+eXn1FSt8lCXI4eRFBNltpBmPCv4oW+XOq
         QvvA==
X-Gm-Message-State: AOJu0YyNe6xh4twWiyCxif0uFRG5a9tM0DpjDQd6aNqz6kQWcaGfO/Zn
        gX67ODCiUr72LWpYOXjAxt2FJb7AnspY3AXUvePwpg==
X-Google-Smtp-Source: AGHT+IHx+HdR8IQ8OXZN+MAUVyWyXJ/kKMpdKNVgDgofuFkKOBodmgQtn3uFU6QlecscjQN2j2BzMPtDM26C8djqy14=
X-Received: by 2002:a05:6102:2d3:b0:44d:3f58:c42f with SMTP id
 h19-20020a05610202d300b0044d3f58c42fmr13443054vsh.11.1692909173739; Thu, 24
 Aug 2023 13:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-docs-v1-1-67e061278b8f@google.com> <20230824184910.GA2015748@dev-arch.thelio-3990X>
In-Reply-To: <20230824184910.GA2015748@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 24 Aug 2023 13:32:42 -0700
Message-ID: <CAKwvOdkdb=dDggNNPHb08AiZNp5V-H9utgm0H+2hJmZJdO-biA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: refresh docs
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Tom Rix <trix@redhat.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Thu, Aug 24, 2023 at 11:49=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Thu, Aug 24, 2023 at 11:03:17AM -0700, ndesaulniers@google.com wrote:
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1907 [0]
> > ---
> >
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Nit: Your signed-off-by ended up below the fold, was it in your cover
> letter commit rather than your actual commit?

Heh, no. I'm restoring a machine after suffering drive corruption last
week. I just got patatt and friends re-set up, but I forgot to `git
commit --amend -s` for this patch once everything was working again.
Thanks for catching this!

>
> Aside from the relatively minor comments below, this looks like a really
> good improvement to the documentation to me. It feels like it is more
> targeting users or non-kbuild folks now, which I think is great.
>
> I trust you to address my comments as you see fit, so please carry
> forward:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the review!

> I see a few new kernel-doc warnings from not adjusting the underlines to
> match the new length of the title:
>
>   Documentation/kbuild/llvm.rst:40: WARNING: Title underline too short.
>
>   The LLVM=3D argument
>   --------------
>   Documentation/kbuild/llvm.rst:40: WARNING: Title underline too short.
>
>   The LLVM=3D argument
>   --------------
>   Documentation/kbuild/llvm.rst:102: WARNING: Title underline too short.
>
>   The LLVM_IAS=3D argument
>   -----------------
>   Documentation/kbuild/llvm.rst:102: WARNING: Title underline too short.
>
>   The LLVM_IAS=3D argument
>   -----------------

oops! remind me of the make target to observe these?

> > -For example, to cross-compile the arm64 kernel::
> > +     make LLVM=3D1 LD=3Dld.bfd CROSS_COMPILE=3Ds390x-linux-gnu-
>
> This should probably have ARCH=3Ds390?

Oops! Good catch!

>
> > -     make ARCH=3Darm64 LLVM=3D1
> > +``CROSS_COMPILE`` is not used to prefix the Clang compiler binary (or
> > +corresponding LLVM utilities), but it will be for any GNU toolchain ut=
ilities.
> > +This example will invoke ``s390x-linux-gnu-ld.bfd`` as the linker, so =
ensure
> > +that is reachable in your ``$PATH``.
>
> I like the example as I feel like it addresses some of the fear I have ha=
d
> around recommending LLVM=3D1 as the initial build suggestion but 'LLVM=3D=
1
> LD=3Dld.bfd CROSS_COMPILE=3Ds390x-linux-gnu-' does not compose as you des=
cribe here
> because $(LD) is not prefixed with $(CROSS_COMPILE) anywhere in Makefile.=
 The
> non-$(LLVM) default assignment of $(LD) is '$(CROSS_COMPILE)ld' and that =
is
> overridden by 'LD=3Dld.bfd' on the command line.
>
> In other words, this should be
>
>   make ARCH=3Ds390 LLVM=3D1 LD=3Ds390x-linux-gnu-ld.bfd
>
> and have the note about CROSS_COMPILE prefixing any GNU toolchain utiliti=
es
> removed. It should problably have OBJCOPY and OBJDUMP too, as those are
> required due to https://github.com/ClangBuiltLinux/linux/issues/859 and
> https://github.com/ClangBuiltLinux/linux/issues/1530.

Ah right; I'm no longer able to repro the build failure with OBJDUMP,
though I still see warnings.

I kind of feel like we should bring back CROSS_COMPILE in some form;
having to respecify the triple is still sub-optimal.

i.e. today:
$ make LLVM=3D1 ARCH=3Ds390 LD=3Ds390x-linux-gnu-ld.bfd
OBJCOPY=3Ds390x-linux-gnu-objcopy OBJDUMP=3Ds390x-linux-gnu-objdump

vs

$ make LLVM=3D1 ARCH=3Ds390 CROSS_COMPILE=3Ds390x-linux-gnu- LD=3Dld.bfd
OBJCOPY=3Dobjcopy OBJDUMP=3Dobjdump

but perhaps that's a change for another day.

>
> > -If ``LLVM_IAS=3D0`` is specified, ``CROSS_COMPILE`` is also used to de=
rive
> > -``--prefix=3D<path>`` to search for the GNU assembler and linker. ::
> > +The LLVM_IAS=3D argument
> > +-----------------
> >
> > -     make ARCH=3Darm64 LLVM=3D1 LLVM_IAS=3D0 CROSS_COMPILE=3Daarch64-l=
inux-gnu-
> > +Clang can assemble assembler code. You can pass ``LLVM_IAS=3D0`` to di=
sable this
> > +behavior and have Clang invoke the system assembler instead (or the as=
sembler
> > +based on ``CROSS_COMPILE``). ``CROSS_COMPILE`` is necessary when ``LLV=
M_IAS=3D0``
> > +is set when cross compiling in order to set ``--prefix=3D`` for the co=
mpiler to
> > +find the corresponding non-integrated assembler.
>
> Thanks a lot for documenting this behavior, it is one of the most common
> issues I run into myself (adding LLVM_IAS=3D0 without CROSS_COMPILE) and
> maybe this note will be what I need in order to remember :)

Ah right, I'll make that clearer.

> >
> > -We provide prebuilt stable versions of LLVM on `kernel.org <https://ke=
rnel.org/pub/tools/llvm/>`_.
> > -Below are links that may be useful for building LLVM from source or pr=
ocuring
> > -it through a distribution's package manager.
> > +We provide prebuilt stable versions of LLVM on `kernel.org
> > +<https://kernel.org/pub/tools/llvm/>`_. These have been optimized with=
 profile
> > +data for building Linux kernels. Below are links that may be useful fo=
r
>
> Maybe make a note of why this matters? ", which should lower kernel
> build times compared to non-optimized LLVM toolchains."?

Ack

--=20
Thanks,
~Nick Desaulniers
