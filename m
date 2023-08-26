Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E97892A0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjHZAHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjHZAHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0EE7F;
        Fri, 25 Aug 2023 17:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2534A618F3;
        Sat, 26 Aug 2023 00:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBF1C433CB;
        Sat, 26 Aug 2023 00:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693008416;
        bh=0I+nmCUUlRbQL6fHjG3Kk241/Nft9HAKiAuAaOFovII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=grYuwKBDDg5AXMPD5U5r5hpdECrYSp40tsRPPcV3UxrVy6WF5V8cXoG+G0IEjmItc
         k6GVU3nC6f+RPrIXPv0V4tuSnydQzKZtMfnLoRIEa7HARK2UIXTz87DppNfL4JaIF2
         qOzmYW5mBB3AYzBD5QodqXETg/jeO0tbTkV5+LzuElvfBVWBpsrzzColkiYJ64oNKz
         Lls4BzAUBprxGAtAzq8hwMO5wm34OBVAZ4ZZnx1YrVhiebYSnF3NoUDxtM6MhtKEtv
         4WkIt/RGpUmqecpMBIo9ReQKlwrcSmj24otDNlIogf21NDBmNj29jN6LKWyIDG8cwm
         jMfeBHzsqhzVw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1cccbd43250so943621fac.1;
        Fri, 25 Aug 2023 17:06:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwH+oFXZ1SslC5YLT3i1hzGxjOl9gGorM+Uzes6xcAUUnawuBaq
        FKfEnZA7caNNMUCjI7iChVazDKtuQEvwFDgrO48=
X-Google-Smtp-Source: AGHT+IFZpVK5GnkYhM/8wtJ4p9ZRo3OeRG84hFfiBMe2971d/dMyGvPOJwdznzfMcdomnPHv+Lw4dBpslALgGP8Eysg=
X-Received: by 2002:a05:6870:5693:b0:1be:dbd9:dd21 with SMTP id
 p19-20020a056870569300b001bedbd9dd21mr4457808oao.48.1693008415716; Fri, 25
 Aug 2023 17:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230823120816.824352-1-masahiroy@kernel.org> <20230823202040.GA2236267@dev-arch.thelio-3990X>
 <20230824185930.GA2025001@dev-arch.thelio-3990X> <CAKwvOdm+oPs1kV+RCa0Y_v95dfUuvYCGAGE-HDASq8ajE56uDg@mail.gmail.com>
In-Reply-To: <CAKwvOdm+oPs1kV+RCa0Y_v95dfUuvYCGAGE-HDASq8ajE56uDg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 26 Aug 2023 09:06:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZUYjhFeXip3m5NrNOUBZ93pHdL+qrn-M4OeRpC5q9LA@mail.gmail.com>
Message-ID: <CAK7LNAQZUYjhFeXip3m5NrNOUBZ93pHdL+qrn-M4OeRpC5q9LA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: get lib-y objects back to static library
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 6:45=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Aug 24, 2023 at 11:59=E2=80=AFAM Nathan Chancellor <nathan@kernel=
.org> wrote:
> >
> > On Wed, Aug 23, 2023 at 01:20:42PM -0700, Nathan Chancellor wrote:
> > > Hi Masahiro,
> > >
> > > On Wed, Aug 23, 2023 at 09:08:16PM +0900, Masahiro Yamada wrote:
> > > > Revert the following two commits:
> > > >
> > > >  - 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly wh=
en CONFIG_MODULES=3Dy")
> > > >  - 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects reliably=
")
> > > >
> > > > Now, lib-y is back to static library again, and the link order is
> > > > consistent w/wo CONFIG_MODULES.
> > > >
> > > > Since commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
> > > > modpost"), .vmlinux.export.c contains references to exported symbol=
s.
> > > > If a symbol in a lib-y object is exported, that object is always li=
nked
> > > > even without any explicit user in vmlinux.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  Makefile | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 87a9eef3fb4b..71e9c65d9eae 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1113,12 +1113,7 @@ export ARCH_DRIVERS  :=3D $(drivers-y) $(dri=
vers-m)
> > > >  # Externally visible symbols (used by link-vmlinux.sh)
> > > >
> > > >  KBUILD_VMLINUX_OBJS :=3D ./built-in.a
> > > > -ifdef CONFIG_MODULES
> > > > -KBUILD_VMLINUX_OBJS +=3D $(patsubst %/, %/lib.a, $(filter %/, $(li=
bs-y)))
> > > > -KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
> > > > -else
> > > >  KBUILD_VMLINUX_LIBS :=3D $(patsubst %/,%/lib.a, $(libs-y))
> > > > -endif
> > > >
> > > >  export KBUILD_VMLINUX_LIBS
> > > >  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
> > > > --
> > > > 2.39.2
> > > >
> > >
> > > The build error that prompted 7273ad2b08f8 from [1] appears to return
> > > with this patch, for example:
> > >
> > > $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper virtco=
nfig all
> > > ...
> > > ERROR: modpost: "__memcat_p" [drivers/hwtracing/stm/stm_core.ko] unde=
fined!
> > > ...
> > >
> > > [1]: https://github.com/ClangBuiltLinux/linux/issues/515
> >
> > One thing I forgot to note with this is this occurs when targeting arm,
> > arm64, hexagon, i386, powerpc, s390, and x86_64 with various in-tree
> > configurations (I can provide a list if necessary).
>
> shot in the dark here, but does this help? (Nathan indicates it does,
> at least for `ARCH=3Darm64 virtconfig`)
> ```
> diff --git a/lib/Makefile b/lib/Makefile
> index 1ffae65bb7ee..289ab15f8659 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -33,9 +33,11 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
>          flex_proportions.o ratelimit.o \
>          is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>          earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
> -        nmi_backtrace.o win_minmax.o memcat_p.o \
> +        nmi_backtrace.o win_minmax.o \
>          buildid.o
>
> +obj-y  +=3D memcat_p.o
> +


No. it is not a solution.

We will end up with a whack-a-mole game
because this kind of issue (EXPORT_SYMBOL from lib-y)
happens in general.






>  lib-$(CONFIG_PRINTK) +=3D dump_stack.o
>  lib-$(CONFIG_SMP) +=3D cpumask.o
>
> ```
> Masahiro,
> I don't fully understand "when to use obj-y vs lib-y" in a kernel
> Makefile.  I've read Documentation/kbuild/makefiles.rst and I still
> don't get it.  Is this answered elsewhere in the docs? Can you explain
> it to me?  Do we need to update the docs?


The original intention (that existed before I became the Kbuild maintainer)=
 was:

 obj-y     linked to vmlinux unconditionally

 lib-y  :  the compiled object goes into a static library. Hence,
conditionally linked.
           (If no symbol in lib-y object is referenced, it is not linked at=
 all)





If ARCH supports CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
it is more optimal.


With lib-y, objects are conditionally linked.

With CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
symbols are conditionally linked.





One solution could be to delete lib-y entirely.


--=20
Best Regards
Masahiro Yamada
