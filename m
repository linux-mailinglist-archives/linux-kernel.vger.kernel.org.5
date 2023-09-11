Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59D679B634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379304AbjIKWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351876AbjIKVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 17:44:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8A32BFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:31:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76f066e4fffso303482885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694467836; x=1695072636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk1XDmqFwXUmTLSDlfzOoXD9AdaNAh9AxlQYo7gmX+U=;
        b=BqqIjrnM54Y6S6S1xVZljIPvpRm9I4BBiL4ta09OUgHmkeMIEdO7U6smT1gQS44Krq
         e8oPrU7Og1dWQRk7D3JSl/drRH1rnHi/dFLNxij2d34Ha7R8YXMRRbulTCobQ4lh/Wua
         9WXgrcPtXNNxH0y+yedxRiPey3Vix2W2U6IqB0sGOj2a1KTdh1uEYfpv0TA4Z8g2kPsc
         n1ldjOyI5bPxSkCHWssxoOvRcsvSF0xKwi3njg4tw8mBQMy0X69DSUeGqNoECk24cxP0
         +EElGbFs+wqRzsubgcu+v2SlgfvOFzYGsBgGBQgfaMszJZ0KXHR9ftT8dZqX9qz2smdL
         7NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694467836; x=1695072636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk1XDmqFwXUmTLSDlfzOoXD9AdaNAh9AxlQYo7gmX+U=;
        b=ROhQ8kB8i/xxN4Q2jytPTaDAr1bjbdaHlLSCsiBV4i1NfDfu1fchI41pyQVMv6KpwT
         E4/VDkGaZtEmg8cSg8urS4AZ9mRQL62JuuNuadWP6lKLkDOGJogC4L/y8pObY8yggt/g
         jEVTNlmqm8KWfxYaKmlwoVs7yxmNwDI4t/NmRvtSVyQc/YvmJ++D7pUEmU2DItELGFby
         +PYa5Rd/BInnXX6kO4+fZFzpJpn0/VHHosR9vo+MjxeE0LtUBopdIPPsuVAu4XAoaMi7
         46CoIZcEiBmGNvQTjjdc6Ais6J3jnJ9QdbyE1TP3MZctZ94QVF6o5K9W1N6ZyPEC/mzm
         5n+g==
X-Gm-Message-State: AOJu0YyH+37osMOm8pnBCZKTssnzr7Gzz0oZOVwKQkKXyB+mlH4YCORr
        Hq257QfGx8+bL/HbvuEXZtv5finvOSW7+P9BWVdJANfivD9EXApygKzCfw==
X-Google-Smtp-Source: AGHT+IHyaS9QKpap21B51umX64WFD1kwW1xpsmjerzMmTR5YKpb3rU4yHxt08JSEW/yD0p6ZFSUJGrDbdT7FWwaJzkc=
X-Received: by 2002:a0c:efce:0:b0:63d:6138:1027 with SMTP id
 a14-20020a0cefce000000b0063d61381027mr10551959qvt.42.1694465372796; Mon, 11
 Sep 2023 13:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-missingvardecl2-init-main-c-v2-1-08498a9cf740@google.com>
 <CAKwvOd=uqAf3bX=5FTQ2JdvLmN7m4rS55cXuT01xbRqBN21NaQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=uqAf3bX=5FTQ2JdvLmN7m4rS55cXuT01xbRqBN21NaQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Sep 2023 13:49:22 -0700
Message-ID: <CAKwvOd=er2cLyzz2B-dAeR1mFi8YkN5ouuK4-qxhsCmEdJyqBA@mail.gmail.com>
Subject: Re: [PATCH v2] init: fix -Wmissing-variable-declarations clang warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>
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

On Mon, Sep 11, 2023 at 1:46=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 5, 2023 at 3:43=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
> >
> > When building x86/defconfig with Clang-18 I encounter the following war=
ning:
> > | init/main.c:189:13: warning: no previous extern declaration for non-s=
tatic variable 'envp_init' [-Wmissing-variable-declarations]
> > |   189 | const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TER=
M=3Dlinux", NULL, };
> > | init/main.c:189:7: note: declare 'static' if the variable is not inte=
nded to be used outside of this translation unit
> > |   189 | const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TER=
M=3Dlinux", NULL, };
> >
> > Make `envp_init` static and provide `handle_initrd` its own copy.
> >
> > This silences the warning and makes the code more readable as you no
> > longer have to track down extern definitions inside of `handle_initrd`.
> > It is now more self-contained.
>
> But this is now creating duplicate string arrays in the kernel image.
>
> Why can't this be:
> 1. declared in include/linux/initrd.h
> 2. defined in init/main.c
> 3. referenced in init/do_mounts.c
>
> The extern declaration in init/do_mounts_initrd.c isn't even correct!
> It's missing a `const`! That's the kind of monkey business this
> warning is trying to help avoid. C has headers for this reason, let's
> use them.
>
> Perhaps users of call_usermodehelper_setup need an update, or
> envp_init actually should not be const.

I prefer v1 as the basis; though as kbuild test robot noted to you,
there are other references to envp_init that now need to be cleaned up
in addition.

When you say you build tested v1, I assume you only built init/main.o
and not vmlinux. Make sure to build test ALL files which refer to
variables you've modified.

call_usermodehelper_setup and its callers either need to be cleaned
up, or we should consider dropping const.

>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1920
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > The kernel test robot didn't like v1 of this patch and I prefer Kees'
> > approach to simplifying this code anyways so I'm sending this v2.
> > Hopefully the CI builds clean (as I am locally using their repro).
> >
> > Changes in v2:
> > - Make envp_init static and provide handle_initrd() with a copy (thanks=
 Kees)
> > - Rebase onto mainline (2dde18cd1d8fa)
> > - Link to v1: https://lore.kernel.org/r/20230830-missingvardecl2-init-m=
ain-c-v1-1-59007a637259@google.com
> > ---
> > Note: build-tested only.
> >
> > It should be noted that `handle_initrd` has been marked as deprecated
> > and perhaps the entire thing can be removed as per it's own message:
> > | using deprecated initrd support, will be removed in 2021.
> > ---
> >  init/do_mounts_initrd.c | 4 ++--
> >  init/main.c             | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
> > index 425f4bcf4b77..154bd0de85a6 100644
> > --- a/init/do_mounts_initrd.c
> > +++ b/init/do_mounts_initrd.c
> > @@ -87,7 +87,7 @@ static void __init handle_initrd(char *root_device_na=
me)
> >  {
> >         struct subprocess_info *info;
> >         static char *argv[] =3D { "linuxrc", NULL, };
> > -       extern char *envp_init[];
> > +       static char *envp[] =3D { "HOME=3D/", "TERM=3Dlinux", NULL, };
> >         int error;
> >
> >         pr_warn("using deprecated initrd support, will be removed in 20=
21.\n");
> > @@ -100,7 +100,7 @@ static void __init handle_initrd(char *root_device_=
name)
> >         init_mkdir("/old", 0700);
> >         init_chdir("/old");
> >
> > -       info =3D call_usermodehelper_setup("/linuxrc", argv, envp_init,
> > +       info =3D call_usermodehelper_setup("/linuxrc", argv, envp,
> >                                          GFP_KERNEL, init_linuxrc, NULL=
, NULL);
> >         if (!info)
> >                 return;
> > diff --git a/init/main.c b/init/main.c
> > index ad920fac325c..9a473107bb8f 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -186,7 +186,7 @@ static int __init set_reset_devices(char *str)
> >  __setup("reset_devices", set_reset_devices);
> >
> >  static const char *argv_init[MAX_INIT_ARGS+2] =3D { "init", NULL, };
> > -const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=3Dlinux=
", NULL, };
> > +static const char *envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=
=3Dlinux", NULL, };
> >  static const char *panic_later, *panic_param;
> >
> >  static bool __init obsolete_checksetup(char *line)
> >
> > ---
> > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > change-id: 20230830-missingvardecl2-init-main-c-93dc1013ff8a
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
