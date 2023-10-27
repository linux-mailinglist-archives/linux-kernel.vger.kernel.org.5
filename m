Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252647D945A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbjJ0J4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjJ0J4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:56:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C894D192;
        Fri, 27 Oct 2023 02:56:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B71EC433CC;
        Fri, 27 Oct 2023 09:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698400597;
        bh=odni0FlBV4euAYz7waCuAX8+6NQnBIo+d57hM3LEMgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vPvRBFEjTPphdy1fGC+2WFHeuFYDmvYLY8wxLXpQsgo+7Lg7G9LP/G6gpuFuQB6lp
         vRbITekGbBPT6Z+Go2PsC24YMvTCt5VrxJ0E6JTuVHdg3yqsIvYwD33UFfRbsLXOXi
         D9VND8rgDvTVWaBA0TWOkeLbtsZtoe3/GVpTMm5cnGuRWRf6Orm4zt9Uy61UWHoCgQ
         h8drdoM6U/thdzHUmfCyy8wJE1Ad9V9tL/E/fa/tmOlHmNsfp/hNVY4dWyLz8RMsw0
         7mcgKDmEIQPjvSXP26qZIffuqsuh3dtWkhyP+h3YuVLxzKHGrZFDtQsTymMTaImJS3
         VZbpCzMgAlSOw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce29d1db6eso1434474a34.1;
        Fri, 27 Oct 2023 02:56:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIuja6YVggs1B4n7HzS++35VWs2MZoV5mO9LYxgEhsb4EGoViV
        Oxv8Pyvq1xdDVnn5Tpm0zEStN+znu8UbOK3GaMg=
X-Google-Smtp-Source: AGHT+IFGebNE6Qxw/fw/tMsta4m3Qr2HhV052WFBE4XbwB7W8GzbeoIeKhqkAHbNEBNyc29I9eNFqPzPI4BuK91uI1k=
X-Received: by 2002:a05:6871:4397:b0:1e9:88a0:a67f with SMTP id
 lv23-20020a056871439700b001e988a0a67fmr1799739oab.23.1698400596734; Fri, 27
 Oct 2023 02:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-17-masahiroy@kernel.org>
 <1fac9d12-2ec2-4ccb-bb81-34f3fc34789e@westnet.com.au>
In-Reply-To: <1fac9d12-2ec2-4ccb-bb81-34f3fc34789e@westnet.com.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 Oct 2023 18:56:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQ_W5Yva5a4Xx8E2EYi-tN7x3OHgMFhK+93W+BiX1=9Q@mail.gmail.com>
Message-ID: <CAK7LNASQ_W5Yva5a4Xx8E2EYi-tN7x3OHgMFhK+93W+BiX1=9Q@mail.gmail.com>
Subject: Re: [PATCH v5 16/21] kbuild: generate KSYMTAB entries by modpost
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 1:30=E2=80=AFPM Greg Ungerer <gregungerer@westnet.c=
om.au> wrote:
>
> Hi Masahiro,
>
> On 15/5/23 01:27, Masahiro Yamada wrote:
> > Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> > CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> > whether the EXPORT_SYMBOL() is placed in *.c or *.S.
> >
> > This commit applies a similar approach to the entire data structure of
> > EXPORT_SYMBOL() for further cleanups. The EXPORT_SYMBOL() compilation
> > is split into two stages.
> >
> > When a source file is compiled, EXPORT_SYMBOL() is converted into a
> > dummy symbol in the .export_symbol section.
> >
> > For example,
> >
> >      EXPORT_SYMBOL(foo);
> >      EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);
> >
> > will be encoded into the following assembly code:
> >
> >      .section ".export_symbol","a"
> >      __export_symbol__foo:
> >              .asciz ""
> >              .balign 8
> >              .quad foo
> >      .previous
> >
> >      .section ".export_symbol","a"
> >      __export_symbol_gpl_bar:
> >              .asciz "BAR_NAMESPACE"
> >              .balign 8
> >              .quad bar
> >      .previous
> >
> > They are just markers to tell modpost the name, license, and namespace
> > of the symbols. They will be dropped from the final vmlinux and modules
> > because the *(.export_symbol) will go into /DISCARD/ in the linker scri=
pt.
> >
> > Then, modpost extracts all the information about EXPORT_SYMBOL() from t=
he
> > .export_symbol section, and generates C code:
> >
> >      KSYMTAB_FUNC(foo, "", "");
> >      KSYMTAB_FUNC(bar, "_gpl", "BAR_NAMESPACE");
> >
> > KSYMTAB_FUNC() (or KSYMTAB_DATA() if it is data) is expanded to struct
> > kernel_symbol that will be linked to the vmlinux or a module.
> >
> > With this change, EXPORT_SYMBOL() works in the same way for *.c and *.S
> > files, providing the following benefits.
> >
> > [1] Deprecate EXPORT_DATA_SYMBOL()
> >
> > In the old days, EXPORT_SYMBOL() was only available in C files. To expo=
rt
> > a symbol in *.S, EXPORT_SYMBOL() was placed in a separate *.c file.
> > arch/arm/kernel/armksyms.c is one example written in the classic manner=
.
> >
> > Commit 22823ab419d8 ("EXPORT_SYMBOL() for asm") removed this limitation=
.
> > Since then, EXPORT_SYMBOL() can be placed close to the symbol definitio=
n
> > in *.S files. It was a nice improvement.
> >
> > However, as that commit mentioned, you need to use EXPORT_DATA_SYMBOL()
> > for data objects on some architectures.
> >
> > In the new approach, modpost checks symbol's type (STT_FUNC or not),
> > and outputs KSYMTAB_FUNC() or KSYMTAB_DATA() accordingly.
> >
> > There are only two users of EXPORT_DATA_SYMBOL:
> >
> >    EXPORT_DATA_SYMBOL_GPL(empty_zero_page)    (arch/ia64/kernel/head.S)
> >    EXPORT_DATA_SYMBOL(ia64_ivt)               (arch/ia64/kernel/ivt.S)
> >
> > They are transformed as follows and output into .vmlinux.export.c
> >
> >    KSYMTAB_DATA(empty_zero_page, "_gpl", "");
> >    KSYMTAB_DATA(ia64_ivt, "", "");
> >
> > The other EXPORT_SYMBOL users in ia64 assembly are output as
> > KSYMTAB_FUNC().
> >
> > EXPORT_DATA_SYMBOL() is now deprecated.
> >
> > [2] merge <linux/export.h> and <asm-generic/export.h>
> >
> > There are two similar header implementations:
> >
> >    include/linux/export.h        for .c files
> >    include/asm-generic/export.h  for .S files
> >
> > Ideally, the functionality should be consistent between them, but they
> > tend to diverge.
> >
> > Commit 8651ec01daed ("module: add support for symbol namespaces.") did
> > not support the namespace for *.S files.
> >
> > This commit shifts the essential implementation part to C, which suppor=
ts
> > EXPORT_SYMBOL_NS() for *.S files.
> >
> > <asm/export.h> and <asm-generic/export.h> will remain as a wrapper of
> > <linux/export.h> for a while.
> >
> > They will be removed after #include <asm/export.h> directives are all
> > replaced with #include <linux/export.h>.
> >
> > [3] Implement CONFIG_TRIM_UNUSED_KSYMS in one-pass algorithm (by a late=
r commit)
> >
> > When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
> > the directory tree to determine which EXPORT_SYMBOL to trim. If an
> > EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
> > second traverse, where some source files are recompiled with their
> > EXPORT_SYMBOL() tuned into a no-op.
> >
> > We can do this better now; modpost can selectively emit KSYMTAB entries
> > that are really used by modules.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> This breaks building kernels with an m68k-uclinux-gcc toolchain that have
> modules configured. Before this change they built and ran fine.
> They build and run fine if CONFIG_MODULES is not set.
>
> A few hundred errors like this spew out:
>
>      scripts/mod/modpost -o Module.symvers -T modules.order vmlinux.o
>      ERROR: modpost: vmlinux: .export_symbol section references '', but i=
t does not seem to be an export symbol
>      ERROR: modpost: vmlinux: .export_symbol section references '', but i=
t does not seem to be an export symbol
>      ERROR: modpost: vmlinux: .export_symbol section references '', but i=
t does not seem to be an export symbol
>      ...



Where can I download a prebuilt m68k-uclinux-gcc?









--
Best Regards
Masahiro Yamada
