Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EF788D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbjHYQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHYQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:58:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4559310C3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:58:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64f383be0d4so6705486d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692982695; x=1693587495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzViBHldC+RI22TEG0j7kQnNM5R8iBDVvQGj+6x3kdI=;
        b=dZqOzCwkPiONuy5VW9hhqJNPnprJXN+iCIq0LmO44pKNVyhxKricv/IVKLpZvr6k6E
         EDjVIQfo4lpvd2G9d/PkayncSdYqciOTxejJMlR8Bzg9YfNSSO2HNKkk88pZ+kRq3f5G
         fnrjo6wgBVt2sSyAWRrQC11F2hp7tqc7AW5zoSt4bYt1YRUvrU3gKiTVRfSqbIup4GHH
         3TqXycZY0/WGrI30E5Q4GKT98Ng9ns0XLXJRUkdbCnnlI6ZXdnQXFuQ4yPn+9oKZjfhC
         /Y5Ftn6xXkwEvrZ8/Yz1a2p9pEg3VW0rJfToxeWsgb2Vcz5a6jL85WvmnRR9A+6vKfFx
         6QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982695; x=1693587495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzViBHldC+RI22TEG0j7kQnNM5R8iBDVvQGj+6x3kdI=;
        b=XvmHJJVzxWlQ05PvDDAjG5CCAniKT8IDiLwJYLXK0FQ/+o++6iJ6IBBLH3Dnfz59kE
         LCjRqXpMhSP78nDqzjmI2DLsNFI3z03KtRMsPF29ntKMalgTkP2dOzIoK8LCFCn/zmtr
         HysUQ8B6XlrPeUwizvirnxpkLFKDnR93gxyUrZ+kP8tARg9njOsLrGQHx0lQ/6BpIu0N
         KEb0TA06p7/51d5u2tX5gumQ9grgZ2eJhuTO4vQg+E3hQcNPJ8F3ql9DqxOi05e2bVyy
         QetpGiU2eUtSVjQW3E52jbY9xAfICyKvRh4NMyLSihUg877U953cJ38qDJmhcDCDeQjo
         jCWg==
X-Gm-Message-State: AOJu0Yx1Fmsfdrb7RbT5vOUcC7Furou8LGxok0zxBOoDpkNI+jhXUOjx
        4f3c20fOwx+ZBeTxbiFigwPjAztCB3BOAG4GIku+zEaZ97HItMHfBY8TBA==
X-Google-Smtp-Source: AGHT+IHAtToNmv9oGDm9pH6IumMoojQhr2gcmDc5PuU7gQw3nxUulvw6FGjwp0/Auf+Tz/K0WlHwGDaQhvUZiqYBFHc=
X-Received: by 2002:a05:6214:17c9:b0:635:e773:dc04 with SMTP id
 cu9-20020a05621417c900b00635e773dc04mr19098075qvb.56.1692982695260; Fri, 25
 Aug 2023 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230823120816.824352-1-masahiroy@kernel.org> <20230823202040.GA2236267@dev-arch.thelio-3990X>
 <20230824185930.GA2025001@dev-arch.thelio-3990X>
In-Reply-To: <20230824185930.GA2025001@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Aug 2023 09:58:03 -0700
Message-ID: <CAKwvOdm+oPs1kV+RCa0Y_v95dfUuvYCGAGE-HDASq8ajE56uDg@mail.gmail.com>
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

On Thu, Aug 24, 2023 at 11:59=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Wed, Aug 23, 2023 at 01:20:42PM -0700, Nathan Chancellor wrote:
> > Hi Masahiro,
> >
> > On Wed, Aug 23, 2023 at 09:08:16PM +0900, Masahiro Yamada wrote:
> > > Revert the following two commits:
> > >
> > >  - 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when=
 CONFIG_MODULES=3Dy")
> > >  - 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects reliably")
> > >
> > > Now, lib-y is back to static library again, and the link order is
> > > consistent w/wo CONFIG_MODULES.
> > >
> > > Since commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
> > > modpost"), .vmlinux.export.c contains references to exported symbols.
> > > If a symbol in a lib-y object is exported, that object is always link=
ed
> > > even without any explicit user in vmlinux.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  Makefile | 5 -----
> > >  1 file changed, 5 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 87a9eef3fb4b..71e9c65d9eae 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1113,12 +1113,7 @@ export ARCH_DRIVERS  :=3D $(drivers-y) $(drive=
rs-m)
> > >  # Externally visible symbols (used by link-vmlinux.sh)
> > >
> > >  KBUILD_VMLINUX_OBJS :=3D ./built-in.a
> > > -ifdef CONFIG_MODULES
> > > -KBUILD_VMLINUX_OBJS +=3D $(patsubst %/, %/lib.a, $(filter %/, $(libs=
-y)))
> > > -KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
> > > -else
> > >  KBUILD_VMLINUX_LIBS :=3D $(patsubst %/,%/lib.a, $(libs-y))
> > > -endif
> > >
> > >  export KBUILD_VMLINUX_LIBS
> > >  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
> > > --
> > > 2.39.2
> > >
> >
> > The build error that prompted 7273ad2b08f8 from [1] appears to return
> > with this patch, for example:
> >
> > $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper virtconf=
ig all
> > ...
> > ERROR: modpost: "__memcat_p" [drivers/hwtracing/stm/stm_core.ko] undefi=
ned!
> > ...
> >
> > [1]: https://github.com/ClangBuiltLinux/linux/issues/515
>
> One thing I forgot to note with this is this occurs when targeting arm,
> arm64, hexagon, i386, powerpc, s390, and x86_64 with various in-tree
> configurations (I can provide a list if necessary).

shot in the dark here, but does this help? (Nathan indicates it does,
at least for `ARCH=3Darm64 virtconfig`)
```
diff --git a/lib/Makefile b/lib/Makefile
index 1ffae65bb7ee..289ab15f8659 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -33,9 +33,11 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
         flex_proportions.o ratelimit.o \
         is_single_threaded.o plist.o decompress.o kobject_uevent.o \
         earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
-        nmi_backtrace.o win_minmax.o memcat_p.o \
+        nmi_backtrace.o win_minmax.o \
         buildid.o

+obj-y  +=3D memcat_p.o
+
 lib-$(CONFIG_PRINTK) +=3D dump_stack.o
 lib-$(CONFIG_SMP) +=3D cpumask.o

```
Masahiro,
I don't fully understand "when to use obj-y vs lib-y" in a kernel
Makefile.  I've read Documentation/kbuild/makefiles.rst and I still
don't get it.  Is this answered elsewhere in the docs? Can you explain
it to me?  Do we need to update the docs?


--=20
Thanks,
~Nick Desaulniers
