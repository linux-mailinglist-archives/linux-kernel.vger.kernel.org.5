Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C222D7892D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHZAzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjHZAzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:55:38 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9A2700
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:55:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64f387094ddso8713996d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693011335; x=1693616135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6RkCT9rSkVySeF7oK32PT66QhgnsW86j3bNSp8S/GY=;
        b=oAj0Xhbjf5yTdOKB1WAuycTN/SiUDJiYSaForBGRHveSaa1gUDjG6VYsXQR3xdvfoF
         IMpgq6iEHpbd3nJierI1qjyRZaxBO9bbMwWcUXejJCMk74ZSLWWxMbY3ZPlWNN8HK2qw
         8SnjTssCUoOhklQqSABflyTLibAolFIK5lBh3lxqt48jQ4HiuRAn2sl3e91ACzJZf5q0
         nd0o/0nzQBuPRBIrqwtSdfYkym4tGBLP4w39p42PfntgUIybb+FMvHUIeCXiPDe6Bl1v
         djPvg9DwK7a4G++u4njNdtDg01ygFdeHYff7MA9K4McOAa8tKRKAXhuwXpa2QPHq/9XM
         b7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693011335; x=1693616135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6RkCT9rSkVySeF7oK32PT66QhgnsW86j3bNSp8S/GY=;
        b=cryuhcmP8IB/+W0m9MMdc24nl7i8p2xV+INeO02ANeadguoMwXGeLGncxmsqtnLe2v
         heaSCdaTKx7iMkk8zjE1fGQu81z2Oq0hfpb44aF9140JaV7zBrFo+g4gL8XWfuQlb2hu
         0RxV181oVv2mn/DaAqclg6LptU1cD8JGOq/SeqMXHVmkMRIQ3Uk0Urk6fmDnwH+ZGHGz
         wna5f8kejo6JUwlskdVUrL3T/pcKHfZgcG6C//FkpJdsU/9pxQFVFHpsxpvpmC23F5FX
         QT0J/OxePV4D5lukKF/cILp9GSETDcGPZCjAB1a29b1Tn1T4UfN2OO+TGhoJl3fDcsQ/
         XcRQ==
X-Gm-Message-State: AOJu0YxuY2J64Lj86zRyp+U905DLmuu0bCpHVh3GcbsAS5ALzUAvf+Ox
        9DEFLcWdo6WBTYwOMjH2/8lxQAvGuLTmJfFmPmNpaQ==
X-Google-Smtp-Source: AGHT+IFLB1bjlJLhl8Cis3kA4nw6Sw4NujbX0ssLjzbI1Xc2l6Fjhy/GE40WLmn4n4sqIqEyWGILiCE6/hm1g+CmAL4=
X-Received: by 2002:a0c:f049:0:b0:63f:87a5:63cd with SMTP id
 b9-20020a0cf049000000b0063f87a563cdmr21773814qvl.7.1693011335411; Fri, 25 Aug
 2023 17:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230823120816.824352-1-masahiroy@kernel.org> <20230823202040.GA2236267@dev-arch.thelio-3990X>
 <20230824185930.GA2025001@dev-arch.thelio-3990X> <CAKwvOdm+oPs1kV+RCa0Y_v95dfUuvYCGAGE-HDASq8ajE56uDg@mail.gmail.com>
 <CAK7LNAQZUYjhFeXip3m5NrNOUBZ93pHdL+qrn-M4OeRpC5q9LA@mail.gmail.com>
In-Reply-To: <CAK7LNAQZUYjhFeXip3m5NrNOUBZ93pHdL+qrn-M4OeRpC5q9LA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Aug 2023 17:55:23 -0700
Message-ID: <CAKwvOdmDZ2Af8ZHCpsN2M=SCJknPOy7dW=1tiMS6TENxp-D3Vw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: get lib-y objects back to static library
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>
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

On Fri, Aug 25, 2023 at 5:06=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sat, Aug 26, 2023 at 6:45=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 11:59=E2=80=AFAM Nathan Chancellor <nathan@kern=
el.org> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 01:20:42PM -0700, Nathan Chancellor wrote:
> > > > Hi Masahiro,
> > > >
> > > > On Wed, Aug 23, 2023 at 09:08:16PM +0900, Masahiro Yamada wrote:
> > > > > Revert the following two commits:
> > > > >
> > > > >  - 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly =
when CONFIG_MODULES=3Dy")
> > > > >  - 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects reliab=
ly")
> > > > >
> > > > > Now, lib-y is back to static library again, and the link order is
> > > > > consistent w/wo CONFIG_MODULES.
> > > > >
> > > > > Since commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
> > > > > modpost"), .vmlinux.export.c contains references to exported symb=
ols.
> > > > > If a symbol in a lib-y object is exported, that object is always =
linked
> > > > > even without any explicit user in vmlinux.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > >  Makefile | 5 -----
> > > > >  1 file changed, 5 deletions(-)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 87a9eef3fb4b..71e9c65d9eae 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -1113,12 +1113,7 @@ export ARCH_DRIVERS  :=3D $(drivers-y) $(d=
rivers-m)
> > > > >  # Externally visible symbols (used by link-vmlinux.sh)
> > > > >
> > > > >  KBUILD_VMLINUX_OBJS :=3D ./built-in.a
> > > > > -ifdef CONFIG_MODULES
> > > > > -KBUILD_VMLINUX_OBJS +=3D $(patsubst %/, %/lib.a, $(filter %/, $(=
libs-y)))
> > > > > -KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
> > > > > -else
> > > > >  KBUILD_VMLINUX_LIBS :=3D $(patsubst %/,%/lib.a, $(libs-y))
> > > > > -endif
> > > > >
> > > > >  export KBUILD_VMLINUX_LIBS
> > > > >  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.l=
ds
> > > > > --
> > > > > 2.39.2
> > > > >
> > > >
> > > > The build error that prompted 7273ad2b08f8 from [1] appears to retu=
rn
> > > > with this patch, for example:
> > > >
> > > > $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper virt=
config all
> > > > ...
> > > > ERROR: modpost: "__memcat_p" [drivers/hwtracing/stm/stm_core.ko] un=
defined!
> > > > ...
> > > >
> > > > [1]: https://github.com/ClangBuiltLinux/linux/issues/515
> > >
> > > One thing I forgot to note with this is this occurs when targeting ar=
m,
> > > arm64, hexagon, i386, powerpc, s390, and x86_64 with various in-tree
> > > configurations (I can provide a list if necessary).
> >
> > shot in the dark here, but does this help? (Nathan indicates it does,
> > at least for `ARCH=3Darm64 virtconfig`)
> > ```
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 1ffae65bb7ee..289ab15f8659 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -33,9 +33,11 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
> >          flex_proportions.o ratelimit.o \
> >          is_single_threaded.o plist.o decompress.o kobject_uevent.o \
> >          earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
> > -        nmi_backtrace.o win_minmax.o memcat_p.o \
> > +        nmi_backtrace.o win_minmax.o \
> >          buildid.o
> >
> > +obj-y  +=3D memcat_p.o
> > +
>
>
> No. it is not a solution.
>
> We will end up with a whack-a-mole game
> because this kind of issue (EXPORT_SYMBOL from lib-y)
> happens in general.
>
>
>
>
>
>
> >  lib-$(CONFIG_PRINTK) +=3D dump_stack.o
> >  lib-$(CONFIG_SMP) +=3D cpumask.o
> >
> > ```
> > Masahiro,
> > I don't fully understand "when to use obj-y vs lib-y" in a kernel
> > Makefile.  I've read Documentation/kbuild/makefiles.rst and I still
> > don't get it.  Is this answered elsewhere in the docs? Can you explain
> > it to me?  Do we need to update the docs?
>
>
> The original intention (that existed before I became the Kbuild maintaine=
r) was:
>
>  obj-y     linked to vmlinux unconditionally
>
>  lib-y  :  the compiled object goes into a static library. Hence,
> conditionally linked.
>            (If no symbol in lib-y object is referenced, it is not linked =
at all)
>
>
>
>
>
> If ARCH supports CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> it is more optimal.
>
>
> With lib-y, objects are conditionally linked.

Then wrt. memcat_p, it sounds like there should be a Kconfig for that
that drivers such as drivers/hwtracing/stm/stm_core.ko can express a
dependency on. Yeah?

>
> With CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> symbols are conditionally linked.
>
>
>
>
>
> One solution could be to delete lib-y entirely.
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Thanks,
~Nick Desaulniers
