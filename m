Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439DA7A8B18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjITSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjITSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:05:27 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FDDB9;
        Wed, 20 Sep 2023 11:05:19 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57b3b486f98so81254eaf.2;
        Wed, 20 Sep 2023 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233118; x=1695837918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Ln3euR7SRigSQl8mVYSUbuGX7czfGSSGnI68EYUXA=;
        b=f4nt4J0NJSvQrHbwNY7RaxuA/jhOACOSHl/fkCEr5zGxKU9r34N3k9PPW9clwq/p/f
         M9aGP3Kg4TZ0icXVEkK6UVnhVacQK9qjlcgunpNEl7f+RaDKNmiORZsQmGLHa1BVlX7A
         AxJzLj8wO1rEpw+SZEGVSLOOnxhiV+uM17Kp47jsArM0BFQfOAYPDfcozYwMYykENkZk
         HrcQhKJlEQ6kYucBts1DWUg1GoXTQeSniChr0NsZdFZHSRuWh7UgoKrq6GlJcT5O0GQI
         r/wUoJBQ3sm0RvsT3ecAFsYmCPzIBEsl0Vmqkqt+MHwC2nVa2/yhDol1voMTUoTAM+69
         lKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233118; x=1695837918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4Ln3euR7SRigSQl8mVYSUbuGX7czfGSSGnI68EYUXA=;
        b=hGB5yh03qkbRoQUI1DqmJdQ+DBf12RuDX5H17xFhvNJOIwVtWf+X8bHE69Xk8Gvg45
         ABcYqUBVSEnE+bvyiVBZydIbHHzWMP4ex3LAXazYg2soFa+pjnIUsC/nhz+Rib81CY1v
         KlCRkFN7975SIc8wXEiLNFlUPYCRHG6wAMGCqIdfl3Lz+Y7AqHTRSAz8OCUqTIjEOzjv
         EuiIlO72w2SrjimNgdq3MK8EIER7SuSIZXyga2XsyJrbXhuG0dns+Oq8F+FL9cbX163T
         ljbNH6VZHqkjaN/O9NEd1nJNhn3WZTC262MMEanmnbnLWNp9I3FBiFotrAISRma22l4N
         5BRA==
X-Gm-Message-State: AOJu0YzWM0d6GvJ//R136xY/OubyD5oNhvn1Qbl3rXM1lif54eZW8/vI
        pCesJY8C7G5vEK4yxyeJDhE8eqsH6FbHMxb1BJ2/AN0XQQ4a2g==
X-Google-Smtp-Source: AGHT+IFcj9pJCXLFTe1Vl5NhryQtnEa1p4B+acFEw43OOIDAH+svKv6RJkaS65JwKp0PjzszHc74aKy6l7cJWteDyQM=
X-Received: by 2002:a4a:750d:0:b0:571:28d5:2c71 with SMTP id
 j13-20020a4a750d000000b0057128d52c71mr3334009ooc.2.1695233118403; Wed, 20 Sep
 2023 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230919193948.465340-1-alessandro.carminati@gmail.com> <4833924.GXAFRqVoOG@pwmachine>
In-Reply-To: <4833924.GXAFRqVoOG@pwmachine>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Wed, 20 Sep 2023 20:04:42 +0200
Message-ID: <CAPp5cGQH1QYM6fr_TRqh6BJDgYS89ncPzx3que5q92o2b0gmLw@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To:     Francis Laniel <flaniel@linux.microsoft.com>
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
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Francis,

Thanks a lot for the review.

Il giorno mer 20 set 2023 alle ore 12:53 Francis Laniel
<flaniel@linux.microsoft.com> ha scritto:
>
> Hi.
>
> Le mardi 19 septembre 2023, 22:39:48 EEST Alessandro Carminati (Red Hat) =
a
> =C3=A9crit :
> > It is not uncommon for drivers or modules related to similar peripheral=
s
> > to have symbols with the exact same name.
> > While this is not a problem for the kernel's binary itself, it becomes =
an
> > issue when attempting to trace or probe specific functions using
> > infrastructure like ftrace or kprobe.
> >
> > The tracing subsystem relies on the `nm -n vmlinux` output, which provi=
des
> > symbol information from the kernel's ELF binary. However, when multiple
> > symbols share the same name, the standard nm output does not differenti=
ate
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
> >
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
> >
> > Changes from v1:
> > - Integrated changes requested by Masami to exclude symbols with prefix=
es
> >   "_cfi" and "_pfx".
> > - Introduced a small framework to handle patterns that need to be exclu=
ded
> >   from the alias production.
> > - Excluded other symbols using the framework.
> > - Introduced the ability to discriminate between text and data symbols.
> > - Added two new config symbols in this version: CONFIG_KALLSYMS_ALIAS_D=
ATA,
> >   which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, which
> >   excludes all filters and provides an alias for each duplicated symbol=
.
> >
> > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carmina=
ti@gm
> > ail.com/
> >
> > Changes from v2:
> > - Alias tags are created by querying DWARF information from the vmlinux=
.
> > - The filename + line number is normalized and appended to the original
> >   name.
> > - The tag begins with '@' to indicate the symbol source.
> > - Not a change, but worth mentioning, since the alias is added to the
> >   existing list, the old duplicated name is preserved, and the livepatc=
h
> >   way of dealing with duplicates is maintained.
> > - Acknowledging the existence of scenarios where inlined functions
> >   declared in header files may result in multiple copies due to compile=
r
> >   behavior, though it is not actionable as it does not pose an operatio=
nal
> >   issue.
> > - Highlighting a single exception where the same name refers to differe=
nt
> >   functions: the case of "compat_binfmt_elf.c," which directly includes
> >   "binfmt_elf.c" producing identical function copies in two separate
> >   modules.
> >
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carmina=
ti@gm
> > ail.com/
> >
> > Changes from v3:
> > - kas_alias was rewritten in Python to create a more concise and
> >   maintainable codebase.
> > - The previous automation process used by kas_alias to locate the vmlin=
ux
> >   and the addr2line has been replaced with an explicit command-line swi=
tch
> >   for specifying these requirements.
> > - addr2line has been added into the main Makefile.
> > - A new command-line switch has been introduced, enabling users to exte=
nd
> >   the alias to global data names.
> >
> > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carmina=
ti@gm
> > ail.com/
> >
> > NOTE:
> > About the symbols name duplication that happens as consequence of the
> > inclusion compat_binfmt_elf.c does, it is evident that this corner is
> > inherently challenging the addr2line approach.
> > Attempting to conceal this limitation would be counterproductive.
> >
> > compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't hel=
p
> > but report all functions and data declared by that file, coming from
> > binfmt_elf.c.
> >
> > My position is that, rather than producing a more complicated pipeline
> > to handle this corner case, it is better to fix the compat_binfmt_elf.c
> > anomaly.
> >
> > This patch does not deal with the two potentially problematic symbols
> > defined by compat_binfmt_elf.c
>
> First, thank you for the v4, you will find in the remaining of the messag=
es
> some comments but for now, I did not test it (this is planned).
> On a general way, using python really helps here as the code is more
> straightforward, thank you for this change.
>
> Regarding the problem with compat_binfmt_elf.c, do you have any idea on h=
ow to
> address it?
> I can maybe take a look at it but I would like to avoid breaking everythi=
ng.

compat_binfmt_elf.c is a clever hack that enables sharing source code
between two different modules while allowing for command differences throug=
h
config macros [1] [2].
The key lies in the fact they have only few differences.

In my view, a good approach would be to refactor both compat_binfmt_elf.c a=
nd
binfmt_elf.c, extracting common code and accessing it through wrappers.
This way, anyone looking to explore the functionality provided by either mo=
dule
would have distinct symbols to work with.
Consolidating the two functions into one also seems beneficial, including i=
n
contexts like livepatch scenarios.

The trade-off here is that the modifications currently made using macros wo=
uld
need to be done at runtime.
Fortunately, from what I see in the code, these changes appear to be relati=
vely
modest, and the functions don't seem to be critical loops.
Therefore, sacrificing a few cycles to evaluate a flag doesn't appear to be=
 a
game-changer.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/binfmt_elf.c#n754
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/binfmt_elf.c#n1317

>
> > Signed-off-by: Alessandro Carminati (Red Hat)
> > <alessandro.carminati@gmail.com> ---
> >  Makefile                |   4 +-
> >  init/Kconfig            |  22 +++++++
> >  scripts/kas_alias.py    | 132 ++++++++++++++++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh |  20 +++++-
> >  4 files changed, 175 insertions(+), 3 deletions(-)
> >  create mode 100755 scripts/kas_alias.py
> >
> > diff --git a/Makefile b/Makefile
> > index 4f283d915e54..f33c179f4cc3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -488,6 +488,7 @@ OBJCOPY           =3D $(LLVM_PREFIX)llvm-objcopy$
> (LLVM_SUFFIX)
> >  OBJDUMP              =3D $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> >  READELF              =3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> >  STRIP                =3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> > +ADDR2LINE    =3D $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
> >  else
> >  CC           =3D $(CROSS_COMPILE)gcc
> >  LD           =3D $(CROSS_COMPILE)ld
> > @@ -497,6 +498,7 @@ OBJCOPY           =3D $(CROSS_COMPILE)objcopy
> >  OBJDUMP              =3D $(CROSS_COMPILE)objdump
> >  READELF              =3D $(CROSS_COMPILE)readelf
> >  STRIP                =3D $(CROSS_COMPILE)strip
> > +ADDR2LINE    =3D $(CROSS_COMPILE)addr2line
> >  endif
> >  RUSTC                =3D rustc
> >  RUSTDOC              =3D rustdoc
> > @@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP :=3D 1
> >  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS
> > CROSS_COMPILE LD CC HOSTPKG_CONFIG export RUSTC RUSTDOC RUSTFMT
> > RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO export HOSTRUSTC
> > KBUILD_HOSTRUSTFLAGS
> > -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS L=
EX
> > YACC AWK INSTALLKERNEL +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF
> > ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL export PERL
> > PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
> > LDFLAGS_MODULE diff --git a/init/Kconfig b/init/Kconfig
> > index 6d35728b94b2..d45dd423e1ec 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
> >         time constants, and no relocation pass is required at runtime t=
o fix
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
> > +       symbol names that include the file name and line where the symb=
ols
> > +       are defined in the source code.
> > +
> > +config KALLSYMS_ALIAS_SRCLINE_DATA
> > +     bool "Produces alias also for global variables names"
> > +     depends on KALLSYMS_ALIAS_SRCLINE
> > +     help
> > +       Sometimes it can be useful to refer to global vars by name. Sin=
ce
> > +       they suffer the same issue as text symbols, this config option
> > +       allows having aliases for global variables names too.
> > +
> >  # end of the "standard kernel features (expert users)" menu
> >
> >  # syscall, maps, verifier
> > diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> > new file mode 100755
> > index 000000000000..8cc2a2178da6
> > --- /dev/null
> > +++ b/scripts/kas_alias.py
> > @@ -0,0 +1,132 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati
> > <alessandro.carminati@gmail.com> +#
> > +# kas_alias: Adds alias to duplicate symbols in the kallsyms output.
> > +
> > +import subprocess
> > +import sys
> > +import os
> > +import argparse
> > +import re
> > +from collections import namedtuple
> > +
> > +regex_filter =3D [
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
> > +        if len(separator) !=3D 1:
> > +            raise argparse.ArgumentTypeError("Separator must be a sing=
le
> > character") +        return separator
> > +
> > +Line =3D namedtuple('Line', ['address', 'type', 'name'])
> > +
> > +def parse_file(filename):
> > +    symbol_list =3D []
> > +    name_occurrences =3D {}
> > +
> > +    with open(filename, 'r') as file:
> > +        for line in file:
> > +            fields =3D line.strip().split()
> > +
> > +            if len(fields) >=3D 3:
> > +                address, type, name =3D fields[0], fields[1], '
> > '.join(fields[2:]) +                symbol_list.append(Line(address, ty=
pe,
> > name))
> > +                name_occurrences[name] =3D name_occurrences.get(name, =
0) + 1
> > +
> > +    return symbol_list, name_occurrences
> > +
> > +def find_duplicate(symbol_list, name_occurrences):
> > +    name_to_lines =3D {}
> > +    duplicate_lines =3D []
> > +
> > +    for line in symbol_list:
> > +        if line.name in name_to_lines:
> > +            first_occurrence =3D name_to_lines[line.name]
> > +            duplicate_lines.extend([first_occurrence, line])
> > +        else:
> > +            name_to_lines[line.name] =3D line
> > +
> > +    return duplicate_lines
> > +
> > +def start_addr2line_process(binary_file, addr2line_file):
> > +    try:
> > +        addr2line_process =3D subprocess.Popen([addr2line_file, '-fe',
> > binary_file], +
> > stdin=3Dsubprocess.PIPE, +
> > stdout=3Dsubprocess.PIPE, +
> > stderr=3Dsubprocess.PIPE, +
> > text=3DTrue)
> > +        return addr2line_process
> > +    except Exception as e:
> > +        print(f"Error starting addr2line process: {str(e)}")
> > +        return None
>
> Here, you can raise another exception, otherwise this error message will =
be
> printed on stdout as you use print().
>
> > +
> > +def addr2line_fetch_address(addr2line_process, address):
> > +    try:
> > +        addr2line_process.stdin.write(address + '\n')
> > +        addr2line_process.stdin.flush()
> > +        addr2line_process.stdout.readline().strip()
> > +        output =3D addr2line_process.stdout.readline().strip()
> > +
> > +        return os.path.normpath(output)
> > +    except Exception as e:
> > +        print(f"Error communicating with addr2line: {str(e)}")
> > +        return None
>
> Same comment than above.
>
Hmm, you might be onto something there.
The issue here is that I probably shouldn't return at all and should just
go ahead and terminate the program. I mean, if I hit this exception, it
means I couldn't spawn addr2line or fetch results from it.
In that case, I can't provide the functionality anyway.
When I initially wrote the function, my idea was to prevent the kernel
build pipeline from failing completely by taking the input and pushing it
to the output (even though the application wouldn't provide the
functionality).
But now I started thinking about it from the perspective of a user who
really needs that functionality.
Despite having to enable it, it does not present itself.
That way I'm just complicating the debug.

I came to the conclusion that it's best to just crash the application and
halt the pipeline if either of the two fails.
I will change it accordingly.

> > +def process_line(line, config):
>
> line should be named obj here.
fair.
>
> > +    if config:
> > +        return not (any(re.match(regex, obj.name) for regex in
> > regex_filter)) +    else:
> > +        return obj.type in {"T", "t"}
> > +if __name__ =3D=3D "__main__":
> > +    parser =3D argparse.ArgumentParser(description=3D'Add alias to mul=
tiple
> > occurring symbols name in kallsyms') +    parser.add_argument('-a',
> > "--addr2line", dest=3D"addr2line_file", required=3DTrue) +
> > parser.add_argument('-v', "--vmlinux", dest=3D"vmlinux_file", required=
=3DTrue)
> > +    parser.add_argument('-o', "--outfile", dest=3D"output_file",
> > required=3DTrue) +    parser.add_argument('-n', "--nmdata",
> > dest=3D"nm_data_file", required=3DTrue) +    parser.add_argument('-s',
> > "--separator", dest=3D"separator", required=3DFalse, default=3D"@",
> > type=3DSeparatorType()) +    parser.add_argument('-d', "--data",
> > dest=3D"include_data", required=3DFalse, action=3D'store_true') +    co=
nfig =3D
> > parser.parse_args()
> > +
> > +    try:
> > +        config.linux_base_dir =3D os.getcwd()+"/"
> > +        symbol_list, name_occurrences =3D parse_file(config.nm_data_fi=
le)
> > +        addr2line_process =3D start_addr2line_process(config.vmlinux_f=
ile,
> > config.addr2line_file) +
> > +        with open(config.output_file, 'w') as file:
> > +            for obj in symbol_list:
> > +                file.write("{} {} {}\n".format(obj.address, obj.type,
> > obj.name))
>
> I am not a python expert but is there something which prevents using f-st=
ring
> here?
Agree, best to have a single style.
>
> > +                if (name_occurrences[obj.name] > 1) and
> > process_line(obj, config.include_data) : +                    output =
=3D
> > addr2line_fetch_address(addr2line_process, obj.address) +
> >  decoration =3D config.separator + "".join(
> > +                        "_" if not c.isalnum() else c for c in
> > output.replace(config.linux_base_dir, "") +                    )
>
> Cannot the above be simplified to:
> decoration =3D config.separator + config.linux_base_dir + ("_" if not c.i=
salnum()
> else c for c in output)
>
> > +                    if decoration !=3D config.separator + "____":
>
> Why exactly "____" and not "_+" (+ in the regex meaning of {1, n})?
The reason for using "____" is because when addr2line emits the special
string "?:??" its normalized version becomes "____" .
"?:??" occurs when addr2line can not find the specified address in the
DWARF section, which is typical of symbols introduced by the compiler.
In such cases, emitting an alias wouldn't make sense, so I skip it.
>
> > +                        file.write("{} {} {}\n".format(obj.address,
> > obj.type, obj.name + decoration)) +
> > +        addr2line_process.stdin.close()
> > +        addr2line_process.stdout.close()
> > +        addr2line_process.stderr.close()
> > +        addr2line_process.wait()
> > +
> > +    except Exception as e:
> > +        print(f"An error occurred: {str(e)}")
> > +        raise SystemExit("Script terminated due to an error")
>
> Maybe you can fuse the two:
> raise SystemExit(f"Script terminated due to an error: {str(e)}")
Got it, thanks
>
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..7cc24fd5f6b4 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -91,7 +91,12 @@ vmlinux_link()
> >
> >       # The kallsyms linking does not need debug symbols included.
> >       if [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > -             ldflags=3D"${ldflags} ${wl}--strip-debug"
> > +             # The kallsyms linking does not need debug symbols includ=
ed,
> > +             # unless the KALLSYMS_ALIAS_SRCLINE.
> > +             if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> > +                [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ] ;=
 then
> > +                     ldflags=3D"${ldflags} ${wl}--strip-debug"
> > +             fi
> >       fi
> >
> >       if is_enabled CONFIG_VMLINUX_MAP; then
> > @@ -161,7 +166,18 @@ kallsyms()
> >       fi
> >
> >       info KSYMS ${2}
> > -     scripts/kallsyms ${kallsymopt} ${1} > ${2}
> > +     ALIAS=3D""
> > +     KAS_DATA=3D""
> > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> > +             KAS_DATA=3D"-d"
> > +     fi
> > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> > +             ALIAS=3D".alias"
> > +             scripts/kas_alias.py \
> > +                     -a ${ADDR2LINE} -v ${kallsyms_vmlinux} -n ${1} \
> > +                     -o ${1}${ALIAS} -s @ ${KAS_DATA}
>
> The separator can indeed be set for the python script but is hardcoded fr=
om
> the kernel point of view as there are no corresponding CONFIG_.
> This is totally fine for me, as if someone wants a specific separator he/=
she can
> edit this file, but was it your goal?
Indeed.
While your earlier point made sense to me, Petr's arguments were quite
convincing.
So, the kernel does hardcode the separator, but if someone really wants
to change it, they can simply edit a character in the
scripts/link-vmlinux.sh file.
>
> > +     fi
> > +     scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
> >  }
> >
> >  # Perform one step in kallsyms generation, including temporary linking=
 of
>
> Best regards.
>
>
