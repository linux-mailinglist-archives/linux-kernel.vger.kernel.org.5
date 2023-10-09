Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22807BDE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376648AbjJINPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376866AbjJINPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:15:09 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4055299;
        Mon,  9 Oct 2023 06:15:05 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b706f604aso2814958eaf.0;
        Mon, 09 Oct 2023 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696857304; x=1697462104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STwCxHnTndAAb/Eszgwh9iUAe41kJkPg+oLxPrfZGyc=;
        b=dMO6C8szbPsgGG5qYBz1treCQfhaROWitytNVdu8pyQKf5f9F32LBF1D8MZ8hINViA
         sp4qTEWTin66RLHQib1wrNc7iFYCwEjN+gEciLegsJTYilNUIhuO2/degTXZNah0l69z
         sBlsz9EBqsH3kMkEzatHruZqNLr8yq/clzJnC4jfw5ZWrRcOuyEOLLUiF7YDKFpWg04E
         KiHMyUe+/hMVDCHalb2Aqe4E5XyIpqqGZ3S4yfvBSMBxCr6lDpMr/Z68E/PMNnIaRnLR
         C6Z3BDIMHM5MQZV3J6kUuNxiPWI/QfxD8GKJCRlDLronTYyq+clqU/swQrgwB0zGpewP
         +Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857304; x=1697462104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STwCxHnTndAAb/Eszgwh9iUAe41kJkPg+oLxPrfZGyc=;
        b=lCYm/dQ2ZQoVQBV1lkxCEBoOArtDbjPF8Rf1qfRug9lALsgyHRJ7e07ILAbp2GUU/X
         ANXp6DFQhDCSxmTGeh9hexbeQ5kPA7GZKeZIlW1MFnu8/ZKxHoZ+l2jDbnIDQCtR6VUX
         1zK8sjR+1+ort3vBw0w8GeSkmeVeVO5KM9sLnekysk/16tLUwizQNfmpCscnlKzewg9b
         QPRqe6CLEhPTJw0Ny+V9ia2wSAMDlxSSHGBqJ5KUvRnfQwdCyZJ1yoK+ys0C3Fty9wKF
         EovA3QHC1ir5kzElwo+5EgCc49TtHvuqwZ1v90oKl25qepcYQG/H4+8+5lbZf0w8WY1z
         JnZA==
X-Gm-Message-State: AOJu0YwyROWuvcFtKR6IXGycPiqoyH3gW4dwxoK3iiF8nY3KWEF6VsOz
        18jrr2T6O/71qOkS9bqkl4iUqZBSArjZtKOCtaEH94USZjP0SA==
X-Google-Smtp-Source: AGHT+IHQOuRQxPDxPVIC5sNmDCRFyruHovGqNMB1W6zLF1hSZnZICsvjRuoawWR+72x2niKRxZxgv8+2VMDlrSs8O5Q=
X-Received: by 2002:a4a:9b1a:0:b0:57b:82d2:8253 with SMTP id
 a26-20020a4a9b1a000000b0057b82d28253mr14325988ook.3.1696857304236; Mon, 09
 Oct 2023 06:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230927173516.1456594-1-alessandro.carminati@gmail.com> <ZR7jIxh/VNT6tMVr@oracle.com>
In-Reply-To: <ZR7jIxh/VNT6tMVr@oracle.com>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Mon, 9 Oct 2023 15:14:28 +0200
Message-ID: <CAPp5cGThN5bKsGAqiVwOV2w4tH1LgjS3eoAgucaRwty4d8JVSQ@mail.gmail.com>
Subject: Re: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kris,

Thank you for your contribution and for having your thought shared with me.

Allow me to begin this conversation by explaining what came to mind when
I decided to propose a patch that creates aliases.

The objective was to address a specific problem I was facing while
minimizing any potential impact on other aspects.
My initial consideration was the existence of numerous tools, both in the
kernel and in userspace, that rely on the current kallsyms implementation.
Both Nick and I shared the concern that making changes to elements upon
which these tools depend on could have significant consequences.

To the best of my knowledge, Nick's strategy has been to duplicate kallsyms
with something new - a new, improved kallsyms file.

However, even if Nick's patch were to be accepted, it wouldn't fully meet
my personal requirements.
This is because my goal was to utilize kprobe on a symbol that shares its
name with others. Nick's work wouldn't allow me to do this, and that's why,
I proposed an alternative.

As a result, my strategy was more modest and focused solely on creating
aliases for duplicate symbols.
By adding these aliases, existing tools would remain unaffected, and the
current system state and ecosystem would be preserved.
For instance, mechanisms like live patching could continue to use the
symbol hit count.

On the flip side, introducing these new symbols would enable tracers to
directly employ the new names without any modifications, and humans could
easily identify the symbol they are dealing with just by examining the
name.
These are the fundamental principles behind my patch - introducing aliases.

Il giorno gio 5 ott 2023 alle ore 18:25 Kris Van Hees
<kris.van.hees@oracle.com> ha scritto:
>
> On Wed, Sep 27, 2023 at 05:35:16PM +0000, Alessandro Carminati (Red Hat) wrote:
> > It is not uncommon for drivers or modules related to similar peripherals
> > to have symbols with the exact same name.
> > While this is not a problem for the kernel's binary itself, it becomes an
> > issue when attempting to trace or probe specific functions using
> > infrastructure like ftrace or kprobe.
> >
> > The tracing subsystem relies on the `nm -n vmlinux` output, which provides
> > symbol information from the kernel's ELF binary. However, when multiple
> > symbols share the same name, the standard nm output does not differentiate
> > between them. This can lead to confusion and difficulty when trying to
> > probe the intended symbol.
> >
> >  ~ # cat /proc/kallsyms | grep " name_show"
> >  ffffffff8c4f76d0 t name_show
> >  ffffffff8c9cccb0 t name_show
> >  ffffffff8cb0ac20 t name_show
> >  ffffffff8cc728c0 t name_show
> >  ffffffff8ce0efd0 t name_show
> >  ffffffff8ce126c0 t name_show
> >  ffffffff8ce1dd20 t name_show
> >  ffffffff8ce24e70 t name_show
> >  ffffffff8d1104c0 t name_show
> >  ffffffff8d1fe480 t name_show
>
> One problem that remains as far as I can see is that this approach does not
> take into consideration that there can be duplicate symbols in the core
> kernel, but also between core kernel and loadable modules, and even between
> loadable modules.  So, I think more is needed to also ensure that this
> approach of adding alias symbols is also done for loadable modules.
>
> Earlier work that cover all symbols (core kernel and loadable modules) was
> posted quite a while ago by Nick Alcock:
>
> https://lore.kernel.org/all/20221205163157.269335-1-nick.alcock@oracle.com/
>
> It takes a different approach and adds in other info that is very useful for
> tracing, but unfortunately it has been dormant for a long time now.
>
> While module symbols are handled quite differently (for kallsyms) from the
> core kernel symbols, I think that a similar approach tied in with modpost
> ought to be quite possible.  It will add to the size of modules because the
> data needs to be stored in the .ko but that is unavoidable.  But not doing it
> unfortunately would mean that the duplicate symbol issue remains unresolved
> in the presence of loadable modules.
>

In the current implementation, my work is capable of "addressing" the issue
only for duplicate symbols within the core kernel image.
This is a fact.
Currently, modules are not within the scope of my work.

Originally, my intention was to deal with duplicates in modules as the
subsequent objective.

I agree with you that addressing duplicate symbols in modules is something
that needs to be resolved, but from my perspective, it appeared to be of
lesser importance.
This is because, when trace tools are used manually, there is already an
indication of the modules where the name originates.

In this context, I would welcome the opportunity to explore additional use
cases.
By doing so, I can better align any future proposals with these real-world
scenarios and requirements I'm not considering in this moment.

In my initial intention, I had hoped to extend the use of aliases to modules
as well.
However, I encountered some challenges that need to be addressed first.
If I were to continue with this strategy, it would necessitate an impact on
the current build flow, which is something that should be discussed before
taking any concrete steps.

To identify which symbols are duplicated, including those contained in
modules, it requires exploring all the objects. If I were to propose a
complementary tool to kas_alias that operates on modules, it would need to
run on all objects to ascertain the state of the names.
Only after this assessment could it produce its output.
This would entail postponing the second kallsyms pass until after all
modules have been processed.
Additionally, modules would need to be processed twice: once to assess the
names and a second time to generate aliases for duplicated symbols.
I am uncertain if the community would be willing to accept such a delay in
the build process to introduce this feature.

Another point worth noting is the importance of exporting this duplicate
name report in public headers to ensure consistency for oot modules.

These are my thoughts on the potential extension of my work to encompass
symbol duplicates in loadable modules. I'm genuinely interested in hearing
your perspective and ideas. If you're planning to explore a completely
different approach or believe that the alias strategy may not be the most
effective way forward, I would be happy to collaborate and combine our
efforts to propose a patch that comprehensively addresses the issue of
symbol duplicates in all its facets. Sharing our expertise and working
together could lead to a more robust and inclusive solution for the Linux
kernel community.

> > kas_alias addresses this challenge by enhancing symbol names with
> > meaningful suffixes generated from the source file and line number
> > during the kernel build process.
> > These newly generated aliases provide tracers with the ability to
> > comprehend the symbols they are interacting with when utilizing the
> > ftracefs interface.
> > This approach may also allow for the probing by name of previously
> > inaccessible symbols.
> >
> >  ~ # cat /proc/kallsyms | grep gic_mask_irq
> >  ffffd15671e505ac t gic_mask_irq
> >  ffffd15671e505ac t gic_mask_irq@drivers_irqchip_irq_gic_c_167
> >  ffffd15671e532a4 t gic_mask_irq
> >  ffffd15671e532a4 t gic_mask_irq@drivers_irqchip_irq_gic_v3_c_407
> >  ~ #
>
> In the same context as mentioned above (module symbols), I am hoping that the
> alias you generate might also be able to contain a module identifier name,
> much like the aforementioned patch series by Nick Alcock added.  We have it
> for loadable modules already of course, but as has been discussed in relation
> to the earlier work, being able to associate a module name with a symbol
> regardless of whether that module is configured to be built into the kernel
> or whether it is configured to be a loadable module is helpful for tracing
> purposes.  Especially for tracers that use tracing scripts that might get
> deployed on diverse systems where it cannot always be known at the time of
> developing the tracer scripts whether a kernel module is configured to be
> loadable or built-in.
>
> I'd be happy to work on something like this as a contribution to your work.
> I would envision the alias entry not needing to have the typical [module] added
> to it because that will already be annotated on the actual symbol entry.  So,
> the alias could be extended to be something like:
>
> ffffffffc0533720 t floppy_open  [floppy]
> ffffffffc0533720 t floppy_open@floppy:drivers_block_floppy_c_3988
>
> (absence of a name: prefix to the path would indicate the symbol is not
>  associated with any module)
>
> Doing this is more realistic now as a result of the clean-up patches that
> Nick introduced, e.g.
>
> https://lore.kernel.org/lkml/20230302211759.30135-1-nick.alcock@oracle.com/
>

Personally, I don't perceive any specific benefit in including the module name
as part of the decoration. Please don't get me wrong; I do recognize that it
enhances clarity in Nick's work.
In that context, a human can easily discern that a duplicated name originates
from a module, aiding in understanding which symbol they require as it is
already for duplicates coming from modules.

However, when it comes to my current implementation, I don't see a compelling
reason to include module name into the decoration I append to names aliases.
Please accept my apologies if I may not be taking into account any obvious use
cases, but as it stands, I don't find a strong rationale for incorporating
module names into the symbol decoration.

In any case, as you've pointed out, duplicates can arise from names in code
that is not intended to be a module.
Therefore, relying solely on the module name would not fully address the
problem you initially aimed to solve.

> > Changes from v1:
> > - Integrated changes requested by Masami to exclude symbols with prefixes
> >   "_cfi" and "_pfx".
> > - Introduced a small framework to handle patterns that need to be excluded
> >   from the alias production.
> > - Excluded other symbols using the framework.
> > - Introduced the ability to discriminate between text and data symbols.
> > - Added two new config symbols in this version: CONFIG_KALLSYMS_ALIAS_DATA,
> >   which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, which
> >   excludes all filters and provides an alias for each duplicated symbol.
> >
> > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carminati@gmail.com/
> >
> > Changes from v2:
> > - Alias tags are created by querying DWARF information from the vmlinux.
> > - The filename + line number is normalized and appended to the original
> >   name.
> > - The tag begins with '@' to indicate the symbol source.
> > - Not a change, but worth mentioning, since the alias is added to the
> >   existing list, the old duplicated name is preserved, and the livepatch
> >   way of dealing with duplicates is maintained.
> > - Acknowledging the existence of scenarios where inlined functions
> >   declared in header files may result in multiple copies due to compiler
> >   behavior, though it is not actionable as it does not pose an operational
> >   issue.
> > - Highlighting a single exception where the same name refers to different
> >   functions: the case of "compat_binfmt_elf.c," which directly includes
> >   "binfmt_elf.c" producing identical function copies in two separate
> >   modules.
> >
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/
> >
> > Changes from v3:
> > - kas_alias was rewritten in Python to create a more concise and
> >   maintainable codebase.
> > - The previous automation process used by kas_alias to locate the vmlinux
> >   and the addr2line has been replaced with an explicit command-line switch
> >   for specifying these requirements.
> > - addr2line has been added into the main Makefile.
> > - A new command-line switch has been introduced, enabling users to extend
> >   the alias to global data names.
> >
> > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carminati@gmail.com/
> >
> > Changes from v4:
> > - Fixed the O=<build dir> build issue
> > - The tool halts execution upon encountering major issues, thereby ensuring
> >   the pipeline is interrupted.
> > - A cmdline option to specify the source directory added.
> > - Minor code adjusments.
> > - Tested on mips32 and i386
> >
> > https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carminati@gmail.com/
> >
> > NOTE:
> > About the symbols name duplication that happens as consequence of the
> > inclusion compat_binfmt_elf.c does, it is evident that this corner is
> > inherently challenging the addr2line approach.
> > Attempting to conceal this limitation would be counterproductive.
> >
> > compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't help
> > but report all functions and data declared by that file, coming from
> > binfmt_elf.c.
> >
> > My position is that, rather than producing a more complicated pipeline
> > to handle this corner case, it is better to fix the compat_binfmt_elf.c
> > anomaly.
> >
> > This patch does not deal with the two potentially problematic symbols
> > defined by compat_binfmt_elf.c
> >
> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> > ---
> >  Makefile                |   4 +-
> >  init/Kconfig            |  22 +++++++
> >  scripts/kas_alias.py    | 136 ++++++++++++++++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh |  21 ++++++-
> >  4 files changed, 180 insertions(+), 3 deletions(-)
> >  create mode 100755 scripts/kas_alias.py
> >
> > diff --git a/Makefile b/Makefile
> > index 4f283d915e54..f33c179f4cc3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -488,6 +488,7 @@ OBJCOPY           = $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
> >  OBJDUMP              = $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> >  READELF              = $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> >  STRIP                = $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> > +ADDR2LINE    = $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
> >  else
> >  CC           = $(CROSS_COMPILE)gcc
> >  LD           = $(CROSS_COMPILE)ld
> > @@ -497,6 +498,7 @@ OBJCOPY           = $(CROSS_COMPILE)objcopy
> >  OBJDUMP              = $(CROSS_COMPILE)objdump
> >  READELF              = $(CROSS_COMPILE)readelf
> >  STRIP                = $(CROSS_COMPILE)strip
> > +ADDR2LINE    = $(CROSS_COMPILE)addr2line
> >  endif
> >  RUSTC                = rustc
> >  RUSTDOC              = rustdoc
> > @@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP := 1
> >  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
> >  export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
> >  export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
> > -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> > +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 6d35728b94b2..d45dd423e1ec 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
> >         time constants, and no relocation pass is required at runtime to fix
> >         up the entries based on the runtime load address of the kernel.
> >
> > +config KALLSYMS_ALIAS_SRCLINE
> > +     bool "Produces alias for duplicated text symbols" if EXPERT
> > +     depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
> > +     help
> > +       It is not uncommon for drivers or modules related to similar
> > +       peripherals to have symbols with the exact same name.
> > +       While this is not a problem for the kernel's binary itself, it
> > +       becomes an issue when attempting to trace or probe specific
> > +       functions using infrastructure like ftrace or kprobe.
> > +
> > +       This option addresses this challenge, producing alias for text
> > +       symbol names that include the file name and line where the symbols
> > +       are defined in the source code.
> > +
> > +config KALLSYMS_ALIAS_SRCLINE_DATA
> > +     bool "Produces alias also for global variables names"
> > +     depends on KALLSYMS_ALIAS_SRCLINE
> > +     help
> > +       Sometimes it can be useful to refer to global vars by name. Since
> > +       they suffer the same issue as text symbols, this config option
> > +       allows having aliases for global variables names too.
> > +
> >  # end of the "standard kernel features (expert users)" menu
> >
> >  # syscall, maps, verifier
> > diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> > new file mode 100755
> > index 000000000000..7c6b7045081c
> > --- /dev/null
> > +++ b/scripts/kas_alias.py
> > @@ -0,0 +1,136 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati <alessandro.carminati@gmail.com>
> > +#
> > +# kas_alias: Adds alias to duplicate symbols in the kallsyms output.
> > +
> > +import subprocess
> > +import sys
> > +import os
> > +import argparse
> > +import re
> > +from collections import namedtuple
> > +
> > +regex_filter = [
> > +        "^__compound_literal\\.[0-9]+$",
> > +        "^__[wm]*key\\.[0-9]+$",
> > +        "^_*TRACE_SYSTEM.*$",
> > +        "^__already_done\\.[0-9]+$",
> > +        "^__msg\\.[0-9]+$",
> > +        "^__func__\\.[0-9]+$",
> > +        "^CSWTCH\\.[0-9]+$",
> > +        "^_rs\\.[0-9]+$",
> > +        "^___tp_str\\.[0-9]+$",
> > +        "^__flags\\.[0-9]+$",
> > +        "^___done\\.[0-9]+$",
> > +        "^__print_once\\.[0-9]+$",
> > +        "^___once_key\\.[0-9]+$",
> > +        "^__pfx_.*$",
> > +        "^__cfi_.*$"
> > +        ]
> > +
> > +class SeparatorType:
> > +    def __call__(self, separator):
> > +        if len(separator) != 1:
> > +            raise argparse.ArgumentTypeError("Separator must be a single character")
> > +        return separator
> > +
> > +Line = namedtuple('Line', ['address', 'type', 'name'])
> > +
> > +def parse_file(filename):
> > +    symbol_list = []
> > +    name_occurrences = {}
> > +
> > +    with open(filename, 'r') as file:
> > +        for line in file:
> > +            fields = line.strip().split()
> > +
> > +            if len(fields) >= 3:
> > +                address, type, name = fields[0], fields[1], ' '.join(fields[2:])
> > +                symbol_list.append(Line(address, type, name))
> > +                name_occurrences[name] = name_occurrences.get(name, 0) + 1
> > +
> > +    return symbol_list, name_occurrences
> > +
> > +def find_duplicate(symbol_list, name_occurrences):
> > +    name_to_lines = {}
> > +    duplicate_lines = []
> > +
> > +    for line in symbol_list:
> > +        if line.name in name_to_lines:
> > +            first_occurrence = name_to_lines[line.name]
> > +            duplicate_lines.extend([first_occurrence, line])
> > +        else:
> > +            name_to_lines[line.name] = line
> > +
> > +    return duplicate_lines
> > +
> > +def start_addr2line_process(binary_file, addr2line_file):
> > +    try:
> > +        addr2line_process = subprocess.Popen([addr2line_file, '-fe', binary_file],
> > +                                             stdin=subprocess.PIPE,
> > +                                             stdout=subprocess.PIPE,
> > +                                             stderr=subprocess.PIPE,
> > +                                             text=True)
> > +        return addr2line_process
> > +    except Exception as e:
> > +        print(f"Error starting addr2line process: {str(e)}")
> > +        sys.exit(1)
> > +
> > +def addr2line_fetch_address(addr2line_process, address):
> > +    try:
> > +        addr2line_process.stdin.write(address + '\n')
> > +        addr2line_process.stdin.flush()
> > +        addr2line_process.stdout.readline().strip()
> > +        output = addr2line_process.stdout.readline().strip()
> > +
> > +        return os.path.normpath(output)
> > +    except Exception as e:
> > +        print(f"Error communicating with addr2line: {str(e)}")
> > +        sys.exit(1)
> > +
> > +def process_line(obj, config):
> > +    if config:
> > +        return not (any(re.match(regex, obj.name) for regex in regex_filter))
> > +    else:
> > +        return obj.type in {"T", "t"}
> > +
> > +if __name__ == "__main__":
> > +    parser = argparse.ArgumentParser(description='Add alias to multiple occurring symbols name in kallsyms')
> > +    parser.add_argument('-a', "--addr2line", dest="addr2line_file", required=True)
> > +    parser.add_argument('-v', "--vmlinux", dest="vmlinux_file", required=True)
> > +    parser.add_argument('-o', "--outfile", dest="output_file", required=True)
> > +    parser.add_argument('-n', "--nmdata", dest="nm_data_file", required=True)
> > +    parser.add_argument('-b', "--basedir", dest="linux_base_dir", required=True)
> > +    parser.add_argument('-s', "--separator", dest="separator", required=False, default="@", type=SeparatorType())
> > +    parser.add_argument('-d', "--data", dest="include_data", required=False, action='store_true')
> > +    config = parser.parse_args()
> > +
> > +    try:
> > +        config.linux_base_dir = os.path.normpath(os.getcwd() + "/" + config.linux_base_dir) + "/"
>
> This logic normalization fails when you are building the kernel in a directory
> that is symbolically linked to another fs.  E.g. I have:
>
>         /home/kvanhees/linux-stable
>
> which is a symbolic link to
>
>         /local/linux-stable
>
> Since /local is its own fs, the above normalization expression renders the
> passed-in basedir "." to be /local/linux-stable, but addr2line is reporting
> filenames under /home/kvanhees/linux-stable
>
> > +        symbol_list, name_occurrences = parse_file(config.nm_data_file)
> > +        addr2line_process = start_addr2line_process(config.vmlinux_file, config.addr2line_file)
> > +
> > +        with open(config.output_file, 'w') as file:
> > +            for obj in symbol_list:
> > +                file.write(f"{obj.address} {obj.type} {obj.name}\n")
> > +                if (name_occurrences[obj.name] > 1) and process_line(obj, config.include_data) :
> > +                    output = addr2line_fetch_address(addr2line_process, obj.address)
> > +                    decoration = config.separator + "".join(
> > +                        "_" if not c.isalnum() else c for c in output.replace(config.linux_base_dir, "")
> > +                    )
> > +                    # The addr2line can emit the special string "?:??" when addr2line can not find the
> > +                    # specified address in the DWARF section that after normalization it becomes "____".
> > +                    # In such cases, emitting an alias wouldn't make sense, so it is skipped.
> > +                    if decoration != config.separator + "____":
> > +                        file.write(f"{obj.address} {obj.type} {obj.name + decoration}\n")
> > +
> > +        addr2line_process.stdin.close()
> > +        addr2line_process.stdout.close()
> > +        addr2line_process.stderr.close()
> > +        addr2line_process.wait()
> > +
> > +    except Exception as e:
> > +        print(f"An error occurred: {str(e)}")
> > +        raise SystemExit("Script terminated due to an error")
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..c110b0f58a19 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -91,7 +91,12 @@ vmlinux_link()
> >
> >       # The kallsyms linking does not need debug symbols included.
> >       if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > -             ldflags="${ldflags} ${wl}--strip-debug"
> > +             # The kallsyms linking does not need debug symbols included,
> > +             # unless the KALLSYMS_ALIAS_SRCLINE.
> > +             if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> > +                [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > +                     ldflags="${ldflags} ${wl}--strip-debug"
> > +             fi
> >       fi
> >
> >       if is_enabled CONFIG_VMLINUX_MAP; then
> > @@ -161,7 +166,19 @@ kallsyms()
> >       fi
> >
> >       info KSYMS ${2}
> > -     scripts/kallsyms ${kallsymopt} ${1} > ${2}
> > +     ALIAS=""
> > +     KAS_DATA=""
> > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> > +             KAS_DATA="--data"
> > +     fi
> > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> > +             ALIAS=".alias"
> > +             ${srctree}/scripts/kas_alias.py \
> > +                     --addr2line ${ADDR2LINE} --vmlinux ${kallsyms_vmlinux} \
> > +                     --nmdata ${1} --outfile ${1}${ALIAS} \
> > +                     --basedir ${srctree} --separator @ ${KAS_DATA}
> > +     fi
> > +     scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
> >  }
> >
> >  # Perform one step in kallsyms generation, including temporary linking of
> > --
> > 2.34.1

Thank you.
Alessandro
