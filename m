Return-Path: <linux-kernel+bounces-13854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A32821394
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2DF1F2180F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506302CA4;
	Mon,  1 Jan 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0Mkl6b7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBC2112;
	Mon,  1 Jan 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbf67d619cso1026509b6e.2;
        Mon, 01 Jan 2024 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704107502; x=1704712302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNnxOU2+G8waeVOIzpeqbn32mzprQadtN0TBoaKPd64=;
        b=D0Mkl6b7+/Hpsqit5m5vwZAx+ZQC7lRAc2aDjjAdViX8CTjjIrFUC4qtPU8rWkd2Tq
         vWt3jtcTcNpA5Zf2NkY7j5ZkpUefmBb8Yh2KlIFoJP2+P7KlJZ0JXCoe7KcvVnMbnFnc
         vMA2UVbw26QLTFfTThzUKy5+/dSPbyblP0f0GfSCCztLgSjuY+h2i9xadwNXY7auYEk9
         MqgGbGwgo6n7ZrXwCi1Q8xPBmbLTH9r7IY2RWSNRvMmC3JrNgm3UteyA+8QvhxjdaD/J
         8buvva6R6zEEDP9G2JlTEhFCTAq9/iaqw1HNXNFOy0sx1w5JA/MOrtI0b24aEsf10Ae7
         tpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704107502; x=1704712302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNnxOU2+G8waeVOIzpeqbn32mzprQadtN0TBoaKPd64=;
        b=qqKKd5yuQYJH+4stfiEWbCIwySpRMVTZCgBBtx1S5MPN3eSrA23haYQPyVH1BZFYxW
         4R7PNBFaeGYHjZObTa+gypau9n/USeOxZjiROEbV014+084Ly58b2DPSBV0PfKkjIszI
         STbx7I6qW6fITPuWOhLiKbyLdpREOPoq+uDXyas5Z2rMKHR9JPFZG4ZsHAToKF/xQKuR
         8FdKsZX+TaiuXiSFh6ZjZ9vRuvz1DF2fFP8CK3PQPMZNtRxyWFGparDea+n9Gfz+h8R+
         PG12bgBQONjK5ZcSQ8onq3EAXjkFqAHHjSxbypWM24pWCXeMUC0jItpHLjuZqBwDWzuo
         6cBA==
X-Gm-Message-State: AOJu0Yz0iBWqziU1CoY8cLj/p8c9/m7EUNwt42oYeAdVm2K1vi+9Xdb3
	65hoyioHf33asj1PeL/YXMTXVF/IOnJYEm2IIOs=
X-Google-Smtp-Source: AGHT+IF0/KGi7lNzz8RhyqBJp2eeYuiq6KrkDAni6Nc91xXrg/D0KSzlRUAuV0FODfMTuH5msvCm7Xmrp9Tvs1mw/2E=
X-Received: by 2002:a05:6808:10c8:b0:3bb:cffe:d893 with SMTP id
 s8-20020a05680810c800b003bbcffed893mr6314903ois.48.1704107502134; Mon, 01 Jan
 2024 03:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204214635.2916691-1-alessandro.carminati@gmail.com> <CAK7LNASo6dDrgt=cyLDBqSuZKdb=+SpJCnigBXWN8Y5ricECKQ@mail.gmail.com>
In-Reply-To: <CAK7LNASo6dDrgt=cyLDBqSuZKdb=+SpJCnigBXWN8Y5ricECKQ@mail.gmail.com>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 1 Jan 2024 12:11:05 +0100
Message-ID: <CAPp5cGSYUvOXdR8e_N-LcJY74hrXFQitykCWN3NDYmQ48nyBNA@mail.gmail.com>
Subject: Re: [PATCH v7] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Mladek <pmladek@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Nick Alcock <nick.alcock@oracle.com>, Kris Van Hees <kris.van.hees@oracle.com>, 
	Eugene Loh <eugene.loh@oracle.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Viktor Malik <vmalik@redhat.com>, Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,



Il giorno dom 31 dic 2023 alle ore 06:35 Masahiro Yamada
<masahiroy@kernel.org> ha scritto:
>
> On Tue, Dec 5, 2023 at 6:48=E2=80=AFAM Alessandro Carminati (Red Hat)
> <alessandro.carminati@gmail.com> wrote:
> >
> > In the kernel environment, situations frequently arise where identical
> > names are shared among symbols within both the core image and modules.
> > While this doesn't pose issues for the kernel's binary itself, it
> > complicates trace or probe operations using tools like kprobe.
> >
> > This patch introduces "kas_alias" to address this challenge.
> >
> > During the kernel's build process, just before linking the vmlinux
> > image in the "scripts/link-vmlinux.sh", symbol name frequencies are
> > collected.
> > This collection includes both the core kernel components and modules.
> > Subsequently, within the same action, the nm data relative to vmlinux
> > is modified by adding aliases based on the comprehensive symbol
> > information gathered.
> >
> > The collection process occurs in two phases:
> >
> > 1. First phase: Executed during the linking of vmlinux, "kas_alias" sca=
ns
> >    all symbols provided by the 'nm' data against the vmlinux core image
> >    and all objects used for module linkage. This phase requires all
> >    modules objects to be produced at this stage, thereby adding a vmlin=
ux
> >    dependency for linking modules in 'scripts/Makefile.modfinal'.
> >
> > 2. Second phase: In a subsequent run in the same build, "kas_alias"
> >    processes module objects and injects aliases into the objects' symbo=
l
> >    tables where necessary. This operation is done by modifying
> >    'scripts/Makefile.modfinal' to include an action for each processed
> >    module.
> >
> > Example:
> >
> > Consider the symbol "device_show", you can expect an output like the
> > following:
> >
> >  ~ # cat /proc/kallsyms | grep " name_show"
> > ffffcaa2bb4f01c8 t name_show
> > ffffcaa2bb4f01c8 t name_show@kernel_irq_irqdesc_c_264
> > ffffcaa2bb9c1a30 t name_show
> > ffffcaa2bb9c1a30 t name_show@drivers_pnp_card_c_186
> > ffffcaa2bbac4754 t name_show
> > ffffcaa2bbac4754 t name_show@drivers_regulator_core_c_678
> > ffffcaa2bbba4900 t name_show
> > ffffcaa2bbba4900 t name_show@drivers_base_power_wakeup_stats_c_93
> > ffffcaa2bbec4038 t name_show
> > ffffcaa2bbec4038 t name_show@drivers_rtc_sysfs_c_26
> > ffffcaa2bbecc920 t name_show
> > ffffcaa2bbecc920 t name_show@drivers_i2c_i2c_core_base_c_660
> > ffffcaa2bbed3840 t name_show
> > ffffcaa2bbed3840 t name_show@drivers_i2c_i2c_dev_c_100
> > ffffcaa2bbef7210 t name_show
> > ffffcaa2bbef7210 t name_show@drivers_pps_sysfs_c_66
> > ffffcaa2bbf03328 t name_show
> > ffffcaa2bbf03328 t name_show@drivers_hwmon_hwmon_c_72
> > ffffcaa2bbff6f3c t name_show
> > ffffcaa2bbff6f3c t name_show@drivers_remoteproc_remoteproc_sysfs_c_215
> > ffffcaa2bbff8d78 t name_show
> > ffffcaa2bbff8d78 t name_show@drivers_rpmsg_rpmsg_core_c_455
> > ffffcaa2bbfff7a4 t name_show
> > ffffcaa2bbfff7a4 t name_show@drivers_devfreq_devfreq_c_1395
> > ffffcaa2bc001f60 t name_show
> > ffffcaa2bc001f60 t name_show@drivers_extcon_extcon_c_389
> > ffffcaa2bc009890 t name_show
> > ffffcaa2bc009890 t name_show@drivers_iio_industrialio_core_c_1396
> > ffffcaa2bc01212c t name_show
> > ffffcaa2bc01212c t name_show@drivers_iio_industrialio_trigger_c_51
> > ffffcaa2bc025e2c t name_show
> > ffffcaa2bc025e2c t name_show@drivers_fpga_fpga_mgr_c_618
> > ffffcaa2a052102c t name_show    [hello]
> > ffffcaa2a052102c t name_show@hello_hello_c_8    [hello]
> > ffffcaa2a051955c t name_show    [rpmsg_char]
> > ffffcaa2a051955c t name_show@drivers_rpmsg_rpmsg_char_c_365     [rpmsg_=
char]
> >
> > where hello, is a plain helloworld module built OOT.
> >
> > Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gma=
il.com>
> >
> > ---
> >
> > NOTE1:
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
> >
> > Changes from v1:
> > * Integrated changes requested by Masami to exclude symbols with prefix=
es
> >   "_cfi" and "_pfx".
> > * Introduced a small framework to handle patterns that need to be exclu=
ded
> >   from the alias production.
> > * Excluded other symbols using the framework.
> > * Introduced the ability to discriminate between text and data symbols.
> > * Added two new config symbols in this version:
> >   CONFIG_KALLSYMS_ALIAS_DATA, which allows data for data, and
> >   CONFIG_KALLSYMS_ALIAS_DATA_ALL, which excludes all filters and provid=
es
> >   an alias for each duplicated symbol.
> >
> > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carmina=
ti@gmail.com/
> >
> > Changes from v2:
> > * Alias tags are created by querying DWARF information from the vmlinux=
.
> > * The filename + line number is normalized and appended to the original
> >   name.
> > * The tag begins with '@' to indicate the symbol source.
> > * Not a change, but worth mentioning, since the alias is added to the
> >   existing list, the old duplicated name is preserved, and the livepatc=
h
> >   way of dealing with duplicates is maintained.
> > * Acknowledging the existence of scenarios where inlined functions
> >   declared in header files may result in multiple copies due to compile=
r
> >   behavior, though it is not actionable as it does not pose an operatio=
nal
> >   issue.
> > * Highlighting a single exception where the same name refers to differe=
nt
> >   functions: the case of "compat_binfmt_elf.c," which directly includes
> >   "binfmt_elf.c" producing identical function copies in two separate
> >   modules.
> >
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carmina=
ti@gmail.com/
> >
> > Changes from v3:
> > * kas_alias was rewritten in Python to create a more concise and
> >   maintainable codebase.
> > * The previous automation process used by kas_alias to locate the vmlin=
ux
> >   and the addr2line has been replaced with an explicit command-line swi=
tch
> >   for specifying these requirements.
> > * addr2line has been added into the main Makefile.
> > * A new command-line switch has been introduced, enabling users to exte=
nd
> >   the alias to global data names.
> >
> > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carmina=
ti@gmail.com/
> >
> > Changes from v4:
> > * Fixed the O=3D<build dir> build issue
> > * The tool halts execution upon encountering major issues, thereby ensu=
ring
> >   the pipeline is interrupted.
> > * A cmdline option to specify the source directory added.
> > * Minor code adjusments.
> > * Tested on mips32 and i386
> >
> > https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carminat=
i@gmail.com/
> >
> > Changes from v5:
> > * Regex filter extended to all symbols
> > * Alias creation extended to module objects
> > * Code cleaned and commented
> > * kas_alias verbose execution via KAS_ALIAS_DEBUG env variable
> > * CONFIG_KALLSYMS_ALIAS_SRCLINE selects KBUILD_BUILTIN to ensure no rac=
es
> >   during modules build
> > * Tested on x86_64, aarch64 and i386
> >
> > https://lore.kernel.org/all/20230927173516.1456594-1-alessandro.carmina=
ti@gmail.com/
> >
> > Changes from v6:
> > * Generate a file to facilitate the construction of custom OOT modules =
using aliases.
> >   In this context, it is needed to export the modules.symbfreq file, a =
product of
> >   the build.
> > * Previously, kas_alias was intended to run once, executing all tasks w=
ithin the same
> >   session. In this version, two targets have been introduced to split t=
he work into
> >   distinct phases: one for creating aliases for the core image and anot=
her for
> >   generating aliases for modules.
> > * The module aliases production statement has been inserted in the
> >   scripts/Makefile.modfinal. Instead of being executed individually for=
 each module,
> >   it now runs once for all modules.
> > * The approach for excluding symbols in .init and .exit ELF sections ha=
s undergone a
> >   rewrite.
> > * kas_alias is now capable of applying aliases to OOT modules. However,=
 for this to
> >   occur, the 'modules.symbfreq' file needs to be accessible during the =
build.
> >   If it is not found, aliases won't be added.
> >
> > https://lore.kernel.org/all/20231024201157.748254-1-alessandro.carminat=
i@gmail.com/
>
>
>
>
>
> I am concerned with your code.
> At least, I'd like you to understand the Makefile principle.
>
>
>
>
>
> <output>: <input>
>        <command>
>
>
>
> The <command> reads <input> and generates <output>.
>
> The <command> must not modify <input>.
>
>
> If you deviate from this principle,
> we will never know where build artifacts are updated.
>
>
>
>
> Your code looks like this:
>
>
> %.ko:  %.o %.mod.o
>         Your script inserts aliases to %.o
>         Link %.o and %.mod.o into %.ko
>
>
>
> Your script updates the input file, %.o.
> This is never acceptable.
>
>
>

I truly appreciate your guidance regarding the Makefile principle. I realiz=
e
now that my self-taught approach overlooked key aspects, particularly the
importance of not modifying the input file, and I'm committed to aligning m=
y
code with this principle.

Before I proceed, I seek a better understanding of how the kernel community
aims to address the duplicate symbols issue.

> Anyway, @FILENAME_LINE seems a cheesy workaround after all,
> and I do not see a good reason to grow the ugliness.

Regarding the FILENAME_LINE implementation, my assumption stemmed from
notable comments by

Luis Chamberlain
https://lore.kernel.org/all/ZLVxUQiC5iF+xTPQ@bombadil.infradead.org/

Petr Mladek
https://lore.kernel.org/all/ZQFtdJEKJ9taYpA0@alley/

within the threads related to my work, but the idea itself originated
elsewhere: the erlies message I'm aware of, carrying this contents is a
Petr's message as answer to another thread.
https://lore.kernel.org/all/ZEeO_rWL4bDh5vui@alley/

If FILENAME_LINE doesn't serve the community's purpose, and my interpretati=
on
was mistaken, I apologize for any inconvenience caused and will cease work =
on
this aspect.

>
>
>
>
>
> > ---
> >  Makefile                  |  14 +-
> >  init/Kconfig              |  22 ++
> >  scripts/Makefile.modfinal |  30 +-
> >  scripts/kas_alias.py      | 600 ++++++++++++++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh   |  27 +-
> >  5 files changed, 688 insertions(+), 5 deletions(-)
> >  create mode 100755 scripts/kas_alias.py
> >
> > diff --git a/Makefile b/Makefile
> > index 99db546fbb45..810a0cd21d20 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -479,6 +479,7 @@ OBJCOPY             =3D $(LLVM_PREFIX)llvm-objcopy$=
(LLVM_SUFFIX)
> >  OBJDUMP                =3D $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> >  READELF                =3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> >  STRIP          =3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> > +ADDR2LINE      =3D $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
> >  else
> >  CC             =3D $(CROSS_COMPILE)gcc
> >  LD             =3D $(CROSS_COMPILE)ld
> > @@ -488,6 +489,7 @@ OBJCOPY             =3D $(CROSS_COMPILE)objcopy
> >  OBJDUMP                =3D $(CROSS_COMPILE)objdump
> >  READELF                =3D $(CROSS_COMPILE)readelf
> >  STRIP          =3D $(CROSS_COMPILE)strip
> > +ADDR2LINE      =3D $(CROSS_COMPILE)addr2line
> >  endif
> >  RUSTC          =3D rustc
> >  RUSTDOC                =3D rustdoc
> > @@ -591,7 +593,7 @@ export RUSTC_BOOTSTRAP :=3D 1
> >  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_C=
OMPILE LD CC HOSTPKG_CONFIG
> >  export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BIN=
DGEN CARGO
> >  export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
> > -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS L=
EX YACC AWK INSTALLKERNEL
> > +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF ADDR2LINE PAHOLE RESOLV=
E_BTFIDS LEX YACC AWK INSTALLKERNEL
> >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAG=
S_MODULE
> > @@ -1453,6 +1455,16 @@ KBUILD_BUILTIN :=3D 1
> >  modules: vmlinux
> >  endif
> >
> > +# *.ko are usually independent of vmlinux, but CONFIG_KALLSYMS_ALIAS_S=
RCLINE
> > +# is another exception.
> > +# At the time when vmlinux is being linked, kas_alias operates on both=
 vmlinux
> > +# and modules. To prevent races with modules, kas_alias needs to pause=
 operations
> > +# while it is executed.
> > +ifdef CONFIG_KALLSYMS_ALIAS_SRCLINE
> > +KBUILD_BUILTIN :=3D 1
> > +modules: vmlinux
> > +endif
> > +
> >  modules: modules_prepare
> >
> >  # Target to prepare building external modules
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 9ffb103fc927..f68341b29576 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
> >           time constants, and no relocation pass is required at runtime=
 to fix
> >           up the entries based on the runtime load address of the kerne=
l.
> >
> > +config KALLSYMS_ALIAS_SRCLINE
> > +       bool "Produces alias for duplicated text symbols" if EXPERT
> > +       depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
> > +       help
> > +         It is not uncommon for drivers or modules related to similar
> > +         peripherals to have symbols with the exact same name.
> > +         While this is not a problem for the kernel's binary itself, i=
t
> > +         becomes an issue when attempting to trace or probe specific
> > +         functions using infrastructure like ftrace or kprobe.
> > +
> > +         This option addresses this challenge, producing alias for tex=
t
> > +         symbol names that include the file name and line where the sy=
mbols
> > +         are defined in the source code.
> > +
> > +config KALLSYMS_ALIAS_SRCLINE_DATA
> > +       bool "Produces alias also for global variables names"
> > +       depends on KALLSYMS_ALIAS_SRCLINE
> > +       help
> > +         Sometimes it can be useful to refer to global vars by name. S=
ince
> > +         they suffer the same issue as text symbols, this config optio=
n
> > +         allows having aliases for global variables names too.
> > +
> >  # end of the "standard kernel features (expert users)" menu
> >
> >  # syscall, maps, verifier
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 8568d256d6fb..acde29a46c6b 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -15,6 +15,32 @@ include $(srctree)/scripts/Makefile.lib
> >  # find all modules listed in modules.order
> >  modules :=3D $(call read-file, $(MODORDER))
> >
> > +ifeq ($(KBUILD_BUILTIN),y)
> > +  ifeq ($(or $(CONFIG_DEBUG_INFO_BTF_MODULES),$(CONFIG_KALLSYMS_ALIAS_=
SRCLINE)),y)
> > +    VMLINUX_DEP :=3D vmlinux
> > +  endif
> > +endif
> > +
> > +VMLINUX_DEP ?=3D
>
>
> This line seems meaningless to me.
>
>
>
>
> > +
> > +ifeq ($(CONFIG_KALLSYMS_ALIAS_SRCLINE),y)
> > +  ifeq ($(CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA),y)
> > +    KAS_DATA :=3D --process_data
> > +  endif
> > +
> > +  ifdef KAS_ALIAS_DEBUG
> > +      DEBUG_FLAG :=3D $(KAS_ALIAS_DEBUG)
> > +  else
> > +      DEBUG_FLAG :=3D 0
> > +  endif
> > +
> > +  KAS_ALIAS_MODULE_CMD :=3D $(srctree)/scripts/kas_alias.py --symbol_f=
requency $(extmod_prefix)modules.symbfreq \
> > +  --debug $(DEBUG_FLAG)  --nm $(NM) $(KAS_DATA) \
> > +  --addr2line $(ADDR2LINE) --basedir $(srctree) --separator @ \
> > +  single_module \
> > +  --objcopy $(OBJCOPY) --objdump $(OBJDUMP) --target-module
> > +endif
> > +
> >  __modfinal: $(modules:%.o=3D%.ko)
> >         @:
> >
> > @@ -30,6 +56,7 @@ quiet_cmd_cc_o_c =3D CC [M]  $@
> >
> >  quiet_cmd_ld_ko_o =3D LD [M]  $@
> >        cmd_ld_ko_o +=3D                                                =
   \
> > +       [ "$(KAS_ALIAS_MODULE_CMD)" !=3D "" ] && $(KAS_ALIAS_MODULE_CMD=
) $<;      \
> >         $(LD) -r $(KBUILD_LDFLAGS)                                     =
 \
> >                 $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             =
 \
> >                 -T scripts/module.lds -o $@ $(filter %.o, $^)
> > @@ -52,7 +79,7 @@ if_changed_except =3D $(if $(call newer_prereqs_excep=
t,$(2))$(cmd-check),      \
> >         printf '%s\n' 'savedcmd_$@ :=3D $(make-cmd)' > $(dot-target).cm=
d, @:)
> >
> >  # Re-generate module BTFs if either module's .ko or vmlinux changed
> > -%.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MOD=
ULES),$(KBUILD_BUILTIN),vmlinux) FORCE
> > +%.ko: %.o %.mod.o scripts/module.lds $(VMLINUX_DEP) FORCE
> >         +$(call if_changed_except,ld_ko_o,vmlinux)
> >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >         +$(if $(newer-prereqs),$(call cmd,btf_ko))
> > @@ -65,7 +92,6 @@ targets +=3D $(modules:%.o=3D%.ko) $(modules:%.o=3D%.=
mod.o)
> >
> >  PHONY +=3D FORCE
> >  FORCE:
> > -
> >  # Read all saved command lines and dependencies for the $(targets) we
> >  # may be building above, using $(if_changed{,_dep}). As an
> >  # optimization, we don't need to read them if the target does not
> > diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> > new file mode 100755
> > index 000000000000..5b0517771389
> > --- /dev/null
> > +++ b/scripts/kas_alias.py
> > @@ -0,0 +1,600 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati <alessandro.ca=
rminati@gmail.com>
> > +#
> > +# kas_alias: Adds alias to duplicate symbols for the kallsyms output.
> > +
> > +import os
> > +import re
> > +import sys
> > +import inspect
> > +import argparse
> > +import subprocess
> > +from enum import Enum
> > +from collections import namedtuple
> > +
> > +# Regex representing symbols that need no alias
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
> > +        "^__cfi_.*$",
> > +        "^\\.LC[0-9]+$",
> > +        "^\\.L[0-9]+.[0-9]+$",
> > +        "^__UNIQUE_ID_.*$",
> > +        "^symbols\\.[0-9]+$",
> > +        "^_note_[0-9]+$"
> > +        ]
> > +
> > +class DebugLevel(Enum):
> > +    PRODUCTION =3D 0
> > +    INFO =3D 1
> > +    DEBUG_BASIC =3D 2
> > +    DEBUG_MODULES =3D 3
> > +    DEBUG_ALL =3D 4
>
>
> Re-inventing a wheel?
>
> Python supports the "logging" module.
>
>
>
>
>
>
> > +
> > +class SeparatorType:
> > +    def __call__(self, separator):
> > +        if len(separator) !=3D 1:
> > +            raise argparse.ArgumentTypeError("Separator must be a sing=
le character")
> > +        return separator
> > +
> > +Line =3D namedtuple('Line', ['address', 'type', 'name', 'addr_int'])
> > +
> > +def get_caller():
> > +    """
> > +    Used only to produce debug messages:
> > +    Gets the caller's caller name if any, "kas_alias" otherwise
> > +    Args:
> > +      None
> > +    Returns:
> > +      A string representing a name of a function.
> > +    """
> > +    stack =3D inspect.stack()
> > +    if len(stack) > 2:
> > +        caller =3D stack[2][0]
> > +        caller_name =3D caller.f_code.co_name
> > +        return caller_name
> > +    else:
> > +        return "kas_alias"
> > +
> > +def debug_print(config, print_debug_level, text):
> > +    """
> > +    Prints text if current debug level is greater or equal to print_de=
bug_level.
> > +    Args:
> > +      current_debug_level: Application debug level specified by comman=
d line.
> > +      print_debug_level: Minimum debug level message should be printed=
.
> > +      text: string representing the message.
> > +    Returns:
> > +      Nothing.
> > +    """
> > +    if int(config.debug) >=3D print_debug_level:
> > +        print(f"{get_caller()}: " + text)
> > +
> > +def parse_nm_lines(config, lines, name_occurrences=3DNone):
> > +    """
> > +    Parses a given nm output and returns the symbol list along with a =
hash of
> > +    symbol occurrences.
> > +    Args:
> > +      lines: List of tuples representing one nm line.
> > +      name_occurrences: Hash having the name as key, used to count nam=
es'
> > +                        occurrences.
> > +    Returns:
> > +      Creates a new line list proper for the nm output it parsed and, =
updates
> > +      the occurrences hash.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, "parse_nm_lines:=
 parse start")
> > +
> > +    if name_occurrences is None:
> > +        name_occurrences =3D {}
> > +
> > +    symbol_list =3D []
> > +
> > +    for line in lines:
> > +        fields =3D line.strip().split()
> > +
> > +        if len(fields) >=3D 3:
> > +            address, type, name =3D fields[0], fields[1], ' '.join(fie=
lds[2:])
> > +            symbol_list.append(Line(address, type, name, int(address, =
16)))
> > +            name_occurrences[name] =3D name_occurrences.get(name, 0) +=
 1
> > +
> > +    return symbol_list, name_occurrences
> > +
> > +def start_addr2line_process(binary_file, config):
> > +    """
> > +    Initializes an addr2line server process operating on the given ELF=
 object.
> > +    Args:
> > +      binary_file: String representing the binary file name object of =
addr2line
> > +                   queries.
> > +      addr2line_file: String representing the addr2line executable nam=
e.
> > +    Returns:
> > +      Returns addr2line process descriptor.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, f"Starting addr2=
line process on {binary_file}")
> > +
> > +    try:
> > +        addr2line_process =3D subprocess.Popen([config.addr2line_file,=
 '-fe',
> > +                                             binary_file],
> > +                                             stdin=3Dsubprocess.PIPE,
> > +                                             stdout=3Dsubprocess.PIPE,
> > +                                             stderr=3Dsubprocess.PIPE,
> > +                                             text=3DTrue)
> > +        return addr2line_process
> > +    except Exception as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(e).__name__}): {str(e)}")
> > +        sys.exit(-2)
> > +
> > +def addr2line_fetch_address(config, addr2line_process, address):
> > +    """
> > +    Queries a specific address using the active addr2line process.
> > +    Args:
> > +      addr2line_process: Descriptor of the addr2line process that is w=
anted to
> > +                         handle the query.
> > +      address: The address of the symbol that needs to be resolved.
> > +    Returns:
> > +      Returns a string representing the file and line number where the=
 symbol
> > +      at the specified address has been defined. The address is normal=
ized
> > +      before being returned.
> > +  """
> > +    debug_print(config, DebugLevel.DEBUG_ALL.value, f"Resolving {addre=
ss}")
> > +
> > +    try:
> > +        addr2line_process.stdin.write(address + '\n')
> > +        addr2line_process.stdin.flush()
> > +        addr2line_process.stdout.readline().strip()
> > +        output =3D addr2line_process.stdout.readline().strip()
> > +
> > +        return os.path.normpath(output)
> > +    except Exception as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(e).__name__}): {str(e)}")
> > +        sys.exit(-2)
> > +
> > +def process_line(line, config, section_map):
> > +    """
> > +    Determines whether a duplicate item requires an alias or not.
> > +    Args:
> > +      line: nm line object that needs to be checked.
> > +      section_map: map correlating symbols and the ELF section they ar=
e from
> > +    Returns:
> > +      Returns true if the line needs to be processed, false otherwise.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_ALL.value, f"Processing {line=
.address} {line.type} {line.name}")
> > +
> > +    # The module contains symbols that were discarded after being load=
ed. Typically,
> > +    # these symbols belong to the initialization function. These symbo=
ls have their
> > +    # address in the init section addresses, so this check prevents th=
ese symbols
> > +    # from being assigned aliases.
> > +    if section_map !=3D None:
> > +       if line.name in section_map:
> > +          if (".init" in section_map[line.name] or ".exit" in section_=
map[line.name]):
> > +              return False
> > +       else:
> > +          return False
> > +
> > +    if config.process_data_sym:
> > +        return not (any(re.match(regex, line.name) for regex in regex_=
filter))
> > +    else:
> > +        return (line.type in {"T", "t"}) and (
> > +                not (any(re.match(regex, line.name) for regex in regex=
_filter)))
> > +
> > +def fetch_file_lines(config, filename):
> > +    """
> > +    Reads a text file and retrieves its content.
> > +    Args:
> > +      filename: String representing the name of the file that needs to=
 be read.
> > +    Returns:
> > +      Returns a string list representing the lines read in the file.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, f"Fetch {filenam=
e}")
> > +
> > +    try:
> > +        with open(filename, 'r') as file:
> > +            lines =3D [line.strip() for line in file.readlines()]
> > +        return lines
> > +    except FileNotFoundError:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(FileNotFoundError).__name__}): {str(FileNotFo=
undError)}")
> > +        sys.exit(-2)
> > +
> > +def do_nm(filename, config):
> > +    """
> > +    Runs the nm command on a specified file.
> > +    Args:
> > +      filename: String representing the name of the file on which nm s=
hould
> > +      run against.
> > +      nm_executable: String representing the nm executable filename.
> > +    Returns:
> > +      Returns a strings list representing the nm output.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, f"executing {con=
fig.nm_file} -n {filename}")
> > +
> > +    try:
> > +        nm_output =3D subprocess.check_output([config.nm_file, '-n', f=
ilename],
> > +                      universal_newlines=3DTrue, stderr=3Dsubprocess.S=
TDOUT).splitlines()
> > +        return nm_output
> > +    except subprocess.CalledProcessError as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(e).__name__}): {str(e)}")
> > +        sys.exit(-2)
> > +
> > +def make_objcpy_arg(config, line, decoration, section_map):
> > +    """
> > +    Produces an objcopy argument statement for a single alias to be ad=
ded in a
> > +    module.
> > +    Args:
> > +      line: nm line object target for this iteration.
> > +      decoration: String representing the decoration (normalized addr2=
line
> > +                  output) to be added at the symbol name to have the a=
lias.
> > +      section_map: map correlating symbols and the ELF section they ar=
e from
> > +    Returns:
> > +      Returns a string that directly maps the argument string objcopy =
should
> > +      use to add the alias.
> > +    """
> > +    try:
> > +        flag =3D "global" if line.type.isupper() else "local"
> > +        debug_print(config, DebugLevel.DEBUG_MODULES.value,
> > +                 f"{line.name + decoration}=3D{section_map[line.name]}=
:0x{line.address},{flag}")
> > +        return (
> > +                "--add-symbol "
> > +                f"{line.name + decoration}=3D{section_map[line.name]}:=
0x{line.address},{flag} "
> > +               )
> > +    except Exception:
> > +        debug_print(config, DebugLevel.PRODUCTION.value,
> > +              f"make_objcpy_arg warning: Skip alias for {line.name}"
> > +              f" type {line.type} because no corresponding section fou=
nd.")
> > +        return ""
> > +
> > +def execute_objcopy(config, objcopy_args, object_file):
> > +    """
> > +    Uses objcopy to add aliases to a given module object file.
> > +    Since objcopy can't operate in place, the original object file is =
renamed
> > +    before operating on it. At function end, a new object file having =
the old
> > +    object's name is carrying the aliases for the duplicate symbols.
> > +    Args:
> > +      objcopy_executable: String representing the object copy executab=
le file.
> > +      objcopy_args: Arguments (aliases to add to the object file) to b=
e used
> > +                    in the objcopy execution command line.
> > +      object_file: Target object file (module object file) against whi=
ch objcopy is executed.
> > +    Returns:
> > +      Nothing is returned, but as a side effect of this function execu=
tion,
> > +      the module's object file contains the aliases for duplicated sym=
bols.
> > +    """
> > +    # Rename the original object file by adding a suffix
> > +    backup_file =3D object_file + '.orig'
> > +    debug_print(config, DebugLevel.DEBUG_MODULES.value, f"rename {obje=
ct_file} to {backup_file}")
> > +    os.rename(object_file, backup_file)
> > +
> > +    full_command =3D (
> > +                    f"{config.objcopy_file} "
> > +                    f"{objcopy_args} {backup_file} {object_file}"
> > +                   )
> > +    debug_print(config, DebugLevel.DEBUG_MODULES.value, f"executing {f=
ull_command}")
> > +
> > +    try:
> > +        subprocess.run(full_command, shell=3DTrue, check=3DTrue)
> > +    except subprocess.CalledProcessError as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(e).__name__}): {str(e)}")
> > +        sys.exit(-2)
> > +
> > +def generate_decoration(line, config, addr2line_process):
> > +    """
> > +    Generates symbol decoration to be used to make the alias name, by
> > +    querying addr2line.
> > +    Args:
> > +      line: nm line object that needs an alias.
> > +      config: Object containing command line configuration.
> > +      addr2line_process: Descriptor of the addr2line process that serv=
es
> > +                         the binary object where the symbol belongs.
> > +    Returns:
> > +      Returns a string representing the decoration for the given symbo=
l,
> > +      or empty string if this can not be done. E.g., addr2line can't f=
ind
> > +      the point where the symbol is defined.
> > +    """
> > +    output =3D addr2line_fetch_address(config, addr2line_process, line=
.address)
> > +    base_dir =3D config.linux_base_dir + "/"
> > +    cwd =3D os.getcwd() + "/"
> > +    absolute_base_dir =3D os.path.abspath(os.path.join(cwd, base_dir))
> > +
> > +    if output.startswith(base_dir):
> > +        output =3D output[len(base_dir):]
> > +
> > +    if output.startswith(absolute_base_dir):
> > +        output =3D output[len(absolute_base_dir):]
> > +
> > +    if output.startswith('/'):
> > +            output =3D output[1:]
> > +
> > +    decoration =3D config.separator + "".join(
> > +        "_" if not c.isalnum() else c for c in output
> > +    )
> > +    # The addr2line can emit the special string "?:??" when addr2line =
can not find the
> > +    # specified address in the DWARF section that after normalization =
it becomes "____".
> > +    # In such cases, emitting an alias wouldn't make sense, so it is s=
kipped.
> > +    if decoration !=3D config.separator + "____":
> > +        return decoration
> > +    return ""
> > +
> > +def section_interesting(section):
> > +    """
> > +    checks if a section is of interest.
> > +    Args:
> > +      section: string representing the section needed to be tested.
> > +    Returns:
> > +      True if it is, False otherwise.
> > +    """
> > +    sections_regex =3D [r".text", r".data", r".bss", r".rodata"]
> > +
> > +    for pattern in sections_regex:
> > +        if re.search(pattern, section):
> > +            return True
> > +    return False
> > +
> > +def get_symbol2section(config, file_to_operate):
> > +    """
> > +    This function aims to produce a map{symbol_name]=3Dsection_name fo=
r
> > +    any given object file.
> > +    Args:
> > +      objdump_executable: String representing the objdump executable.
> > +      file_to_operate: file whose section names are wanted.
> > +    Returns:
> > +      Returns a map, where the key is the symbol name and the value is
> > +      a section name.
> > +    """
> > +    try:
> > +        output =3D subprocess.check_output(
> > +                   [config.objdump_file, '-h', file_to_operate],
> > +                   universal_newlines=3DTrue)
> > +        section_pattern =3D re.compile(r'^ *[0-9]+ ([.a-z_]+) +([0-9a-=
f]+).*$', re.MULTILINE)
> > +        section_names =3D section_pattern.findall(output)
> > +        result =3D {}
> > +        for section, section_siza in section_names:
> > +            if int(section_siza, 16) !=3D 0 and section_interesting(se=
ction):
> > +                debug_print(config, DebugLevel.DEBUG_ALL.value, f"CMD =
=3D> {config.objdump_file} -tj {section} {file_to_operate}")
> > +                try:
> > +                    output =3D subprocess.check_output(
> > +                           [config.objdump_file, '-tj', section, file_=
to_operate],
> > +                           universal_newlines=3DTrue)
> > +                except subprocess.CalledProcessError:
> > +                      pass
> > +                func_names_pattern =3D re.compile(r'[0-9a-f]+.* ([.a-z=
A-Z_][.A-Za-z_0-9]+)$', re.MULTILINE)
> > +                matches =3D func_names_pattern.findall(output)
> > +                for func_name in matches:
> > +                    result[func_name] =3D section
> > +
> > +
> > +    except Exception as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(e).__name__}): {str(e)}")
> > +        sys.exit(-2)
> > +    return result
> > +
> > +def produce_output_modules(config, symbol_list, name_occurrences,
> > +                           module_file_name, addr2line_process):
> > +    """
> > +    Computes the alias addition on a given module object file.
> > +    Args:
> > +      config: Object containing command line configuration.
> > +      symbol_list: List of tuples representing nm lines for the given =
object
> > +                   file.
> > +      name_occurrences: Hash that stores symbol occurrences for the bu=
ild.
> > +      module_file_name: String representing the target moule object fi=
le.
> > +      addr2line_process: Descriptor of the addr2line process that is w=
anted to
> > +                         handle the query.
> > +    Returns:
> > +      Nothing is returned, but as a side effect of this function execu=
tion,
> > +      the module's object file contains the aliases for duplicated sym=
bols.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_ALL.value, "produce_output_mo=
dules computation starts here ")
> > +    objcopy_args =3D "";
> > +    args_cnt =3D 0
> > +    section_map =3D get_symbol2section(config, module_file_name)
> > +    for module_symbol in symbol_list:
> > +        debug_print(config, DebugLevel.DEBUG_ALL.value, f"--> Processi=
ng {module_symbol}")
> > +        try:
> > +            if (name_occurrences[module_symbol.name] > 1) and process_=
line(module_symbol, config, section_map):
> > +                decoration =3D generate_decoration(module_symbol, conf=
ig, addr2line_process)
> > +                debug_print(config, DebugLevel.DEBUG_ALL.value, f"--- =
{module_symbol} occurred multiple times and is a candidate for alias: decor=
ation '{decoration}'")
> > +                if decoration !=3D "":
> > +                    objcopy_args =3D objcopy_args + make_objcpy_arg(co=
nfig, module_symbol, decoration, section_map)
> > +                    args_cnt =3D args_cnt + 1
> > +                    if args_cnt > 50:
> > +                       debug_print(config, DebugLevel.DEBUG_MODULES.va=
lue, "Number of arguments high, split objcopy"
> > +                                   " call into multiple statements.")
> > +                       execute_objcopy(config, objcopy_args, module_fi=
le_name)
> > +                       args_cnt =3D 0> +                       objcopy=
_args =3D ""
> > +        except KeyError:
> > +            pass
> > +    execute_objcopy(config, objcopy_args, module_file_name)
>
>
>
> So, you call execute_objcopy() to do
> "rename <mod> <mod>.orig" and "objcopy <mod>.orig <mod>"
> even when no alias is inserted?
>
>
>
>
>
>
> > +
> > +def produce_output_vmlinux(config, symbol_list, name_occurrences, addr=
2line_process):
> > +    """
> > +    Computes the alias addition for the core Linux on image.
> > +    Args:
> > +      config: Object containing command line configuration.
> > +      symbol_list: List of tuples representing nm lines for the given =
object
> > +                   file.
> > +      name_occurrences: Hash that stores symbol occurreces for the bui=
ld.
> > +      addr2line_process: Descriptor of the addr2line process that is w=
anted to
> > +                         handle the query.
> > +    Returns:
> > +      Nothing is returned, but as a side effect of this function execu=
tion,
> > +      the core kernel image contains the aliases for duplicated symbol=
s.
> > +    """
> > +    with open(config.output_file, 'w') as output_file:
> > +       for obj in symbol_list:
> > +            output_file.write(f"{obj.address} {obj.type} {obj.name}\n"=
)
> > +            if (name_occurrences[obj.name] > 1) and process_line(obj, =
config, None):
> > +                decoration =3D generate_decoration(obj, config, addr2l=
ine_process)
> > +                debug_print(config,DebugLevel.DEBUG_ALL.value, f"Symbo=
l {obj.name} appears multiple times, and decoration is {decoration}")
> > +                if decoration !=3D "":
> > +                    debug_print(config, DebugLevel.DEBUG_ALL.value, f"=
Writing on {config.output_file} the additional '{obj.address} {obj.type} {o=
bj.name + decoration}'")
> > +                    output_file.write(f"{obj.address} {obj.type} {obj.=
name + decoration}\n")
> > +
> > +def read_name_occurrences(config):
> > +    """
> > +    Reads symbol frequencies from the file specified in the 'config' a=
rgument.
> > +
> > +    If the file is not found, it gracefully returns an empty map.
> > +
> > +    Args:
> > +      config: A configuration object or dictionary containing necessar=
y information
> > +              to locate the file.
> > +
> > +    Returns:
> > +      A map where keys represent symbol names and values represent the=
ir frequencies.
> > +    """
> > +    name_occurrences =3D {}
> > +    # This code reads occurrences of symbol names from a file containi=
ng both the core image
> > +    # and modules frequencies resulted from the computation of the "co=
re_image" action.
> > +    # It reads from the file specified by command-line arguments; if t=
he file doesn't exist
> > +    # or the filename isn't specified, it returns an empty map.
> > +    # The code relies on accessing and reading config.symbol_frequency=
_file containing
> > +    # symbol name frequencies.
> > +    # In a complete build, this file is generated during the "core ima=
ge" action earlier
> > +    # in the build process.
> > +    # However, when building a custom OOT module, it is needed to ensu=
re that this file
> > +    # is accessible in the current directory where the module source c=
ode is being built.
> > +    # Not having this file result in a module that have no aliases eve=
n if they are needed
> > +    if config.symbol_frequency_file is not None:
> > +        try:
> > +            with open(config.symbol_frequency_file, 'r') as file:
> > +                for line in file:
> > +                    key, value =3D line.strip().split(':')
> > +                    name_occurrences[key]=3Dint(value)
> > +        except FileNotFoundError:
> > +            pass
> > +
> > +    return name_occurrences
> > +
> > +def check_aliases(config, module_nm_lines):
> > +   """
> > +   Flags modules that already have aliases based on the given 'module_=
nm_lines'.
> > +
> > +   This function takes in configuration details and a list of strings =
representing
> > +   the 'nm' command output for a specific module. It detects instances=
 where a module
> > +   already possesses an alias, which might occur after a build interru=
ption and restart.
> > +
> > +   The detection logic is straightforward: it examines if the separato=
r character is
> > +   present in the symbol name. If found, it uses this separator to che=
ck if the
> > +   previous symbol shares the same name. This detection assumes 'nm' i=
s invoked with
> > +   the '-n' flag, ensuring symbol sorting.
> > +
> > +   Args:
> > +     config: A configuration object or dictionary containing necessary=
 information.
> > +     module_nm_lines: A list of strings representing the 'nm' command =
output for a module.
> > +
> > +   Returns:
> > +     True if the module_nm_lines contains aliases, False otherwise.
> > +   """
> > +   prev =3D None
> > +   for line in module_nm_lines:
> > +       if ('@' in line.name and line.name.split(config.separator)[0] =
=3D=3D prev):
> > +           return False
> > +       prev =3D line.name
> > +   return True
> > +
> > +def main():
> > +    # Handles command-line arguments and generates a config object
> > +    parser =3D argparse.ArgumentParser(description=3D'Add alias to mul=
tiple occurring symbols name in kallsyms')
> > +    subparsers =3D parser.add_subparsers(title=3D'Subcommands', dest=
=3D'action')
> > +    core_image_parser =3D subparsers.add_parser('core_image', help=3D'=
Operates for in tree computation.')
> > +    core_image_parser.add_argument('-n', "--nmdata", dest=3D"nm_data_f=
ile", required=3DTrue, help=3D"Set vmlinux nm output file to use for core i=
mage.")
> > +    core_image_parser.add_argument('-o', "--outfile", dest=3D"output_f=
ile", required=3DTrue, help=3D"Set the vmlinux nm output file containing al=
iases.")
> > +    core_image_parser.add_argument('-v', "--vmlinux", dest=3D"vmlinux_=
file", required=3DTrue, help=3D"Set the vmlinux core image file.")
> > +    core_image_parser.add_argument('-m', "--modules_list", dest=3D"mod=
ule_list", required=3DTrue, help=3D"Set the file containing the list of the=
 modules object files.")
> > +
> > +    single_module_parser =3D subparsers.add_parser('single_module', he=
lp=3D'Operates for out of tree computation.')
> > +    single_module_parser.add_argument('-c', "--objcopy", dest=3D"objco=
py_file", required=3DTrue, help=3D"Set the objcopy executable to be used.")
> > +    single_module_parser.add_argument('-u', "--objdump", dest=3D"objdu=
mp_file", required=3DTrue, help=3D"Set objdump  executable to be used.")
>
>
> Usually dest=3D should be omitted.
>
> You can access config.objcopy, config.objdumpm,
> instead of config.objcopy_file, config_objdump_file.
>
>
>
>
>
>
> > +    single_module_parser.add_argument('-q', "--target-module", dest=3D=
"target_module", required=3DFalse, help=3D"Sets a tharget module to operate=
.")
> > +
> > +    parser.add_argument('-j', "--symbol_frequency", dest=3D"symbol_fre=
quency_file", required=3DTrue, help=3D"Specify the symbol frequency needed =
to use for producing aliases")
> > +    parser.add_argument('-z', "--debug", dest=3D"debug", required=3DFa=
lse, help=3D"Set the debug level.", choices=3D[f"{level.value}" for level i=
n DebugLevel], default=3D"1" )
> > +    parser.add_argument('-a', "--addr2line", dest=3D"addr2line_file", =
required=3DTrue, help=3D"Set the addr2line executable to be used.")
> > +    parser.add_argument('-b', "--basedir", dest=3D"linux_base_dir", re=
quired=3DTrue, help=3D"Set base directory of the source kernel code.")
> > +    parser.add_argument('-s', "--separator", dest=3D"separator", requi=
red=3DFalse, help=3D"Set separator, character that separates original name =
from the addr2line data in alias symbols.", default=3D"@", type=3DSeparator=
Type())
> > +    parser.add_argument('-d', "--process_data", dest=3D"process_data_s=
ym", required=3DFalse, help=3D"Requires the tool to process data symbols al=
ong with text symbols.", action=3D'store_true')
> > +    parser.add_argument('-e', "--nm", dest=3D"nm_file", required=3DTru=
e, help=3D"Set the nm executable to be used.")
> > +
> > +    config =3D parser.parse_args()
> > +
> > +    try:
> > +        # The core_image target is utilized for gathering symbol stati=
stics from the core image and modules,
> > +        # generating aliases for the core image. This target is design=
ed to be invoked from scripts/link-vmlinux.sh
> > +        if config.action =3D=3D 'core_image':
> > +            debug_print(config, DebugLevel.INFO.value,"Start core_imag=
e processing")
> > +
> > +            # Determine kernel source code base directory
> > +            if not config.linux_base_dir.startswith('/'):
> > +                config.linux_base_dir =3D os.path.normpath(os.getcwd()=
 + "/" + config.linux_base_dir) + "/"
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value, f"Config=
uration: {config}")
> > +
> > +            debug_print(config, DebugLevel.INFO.value, "Process nm dat=
a from vmlinux")
> > +            # Process nm data from vmlinux
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value, f"fetch_=
file_lines({config.nm_data_file})")
> > +            vmlinux_nm_lines =3D fetch_file_lines(config, config.nm_da=
ta_file)
> > +            vmlinux_symbol_list, name_occurrences =3D parse_nm_lines(c=
onfig, vmlinux_nm_lines)
> > +
> > +            debug_print(config, DebugLevel.INFO.value,"Process nm data=
 for modules")
> > +            # Process nm data for modules
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value, f"fetch_=
file_lines({config.nm_data_file})")
> > +            module_list =3D fetch_file_lines(config, config.module_lis=
t)
> > +            module_symbol_list =3D {}
> > +            for module in module_list:
> > +                module_nm_lines =3D do_nm(module, config)
> > +                module_symbol_list[module], name_occurrences =3D parse=
_nm_lines(config, module_nm_lines, name_occurrences)
> > +
> > +            debug_print(config, DebugLevel.INFO.value, f"Save name_occ=
urrences data: {config.symbol_frequency_file}")
> > +            with open(config.symbol_frequency_file, 'w') as file:
> > +                for key, value in name_occurrences.items():
> > +                    file.write(f"{key}:{value}\n")
> > +
> > +            debug_print(config, DebugLevel.INFO.value, "Produce file f=
or vmlinux")
> > +            # Produce file for vmlinux
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value, f"addr2l=
ine_process({config.vmlinux_file}, {config.addr2line_file})")
> > +            addr2line_process =3D start_addr2line_process(config.vmlin=
ux_file, config)
> > +            produce_output_vmlinux(config, vmlinux_symbol_list, name_o=
ccurrences, addr2line_process)
> > +            addr2line_process.stdin.close()
> > +            addr2line_process.stdout.close()
> > +            addr2line_process.stderr.close()
> > +            addr2line_process.wait()
> > +
> > +        # Expects to be called from scripts/Makefile.modfinal
> > +        elif config.action =3D=3D 'single_module':
> > +             debug_print(config, DebugLevel.INFO.value,"Start single_m=
odule processing")
> > +             # read simbol name frequency file
> > +             name_occurrences =3D read_name_occurrences(config)
> > +             # scan current module
> > +             module_nm_lines =3D do_nm(config.target_module, config)
> > +             mudule_nm_data, _ =3D parse_nm_lines(config, module_nm_li=
nes)
> > +             if check_aliases(config, mudule_nm_data,):
> > +                 debug_print(config, DebugLevel.DEBUG_BASIC.value, f"a=
ddr2line_process({config.target_module}, {config.addr2line_file})")
> > +                 addr2line_process =3D start_addr2line_process(config.=
target_module, config)
> > +                 debug_print(config, DebugLevel.DEBUG_BASIC.value,"add=
ing aliases to module")
> > +                 produce_output_modules(config, mudule_nm_data, name_o=
ccurrences, config.target_module, addr2line_process)
> > +                 addr2line_process.stdin.close()
> > +                 addr2line_process.stdout.close()
> > +                 addr2line_process.stderr.close()
> > +                 addr2line_process.wait()
> > +             else:
> > +                 debug_print(config, DebugLevel.INFO.value,"module is =
already aliased, skipping")
> > +
> > +        else:
> > +            raise SystemExit("Script terminated: unknown action")
> > +
> > +    except Exception as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script term=
inated due to an error ({type(e).__name__}): {str(e)}")
> > +        sys.exit(-2)
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..31afac64d7ed 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -91,7 +91,12 @@ vmlinux_link()
> >
> >         # The kallsyms linking does not need debug symbols included.
> >         if [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > -               ldflags=3D"${ldflags} ${wl}--strip-debug"
> > +               # The kallsyms linking does not need debug symbols incl=
uded,
> > +               # unless the KALLSYMS_ALIAS_SRCLINE.
> > +               if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> > +                  [ "$output" !=3D "${output#.tmp_vmlinux.kallsyms}" ]=
 ; then
>
>
> This is the same condition as checked 5 lines above, isn't it?
>
>
>
>
>
> > +                       ldflags=3D"${ldflags} ${wl}--strip-debug"
> > +               fi
> >         fi
> >
> >         if is_enabled CONFIG_VMLINUX_MAP; then
> > @@ -161,7 +166,24 @@ kallsyms()
> >         fi
> >
> >         info KSYMS ${2}
> > -       scripts/kallsyms ${kallsymopt} ${1} > ${2}
> > +       ALIAS=3D""
> > +       KAS_DATA=3D""
> > +       if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> > +               KAS_DATA=3D"--process_data"
> > +       fi
> > +       if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> > +               ALIAS=3D".alias"
> > +               # You can use KAS_ALIAS_DEBUG=3D<debug level> in the ma=
ke statements to enable
> > +               # verbose execution for kas_alias.
> > +               ${srctree}/scripts/kas_alias.py --symbol_frequency modu=
les.symbfreq \
> > +                       --debug ${KAS_ALIAS_DEBUG:-0} \
> > +                       --addr2line ${ADDR2LINE} --basedir ${srctree} -=
-nm ${NM} \
> > +                       --separator @ ${KAS_DATA} \
> > +                       core_image \
> > +                       --modules_list ${MODORDER} --vmlinux ${kallsyms=
_vmlinux} \
> > +                       --nmdata ${1} --outfile ${1}${ALIAS}
> > +       fi
> > +       scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
>
>
>
> I do not understand your quoting policy.
>
> In shell, there is no need to quote literals,
> need to quote variables.
>
> You are doing the opposite.
>
> KAS_DATA=3D"--process_data"
>   --> KAS_DATA=3D--process_data
>
>
>
> ${ADDR2LINE}  -->  "${ADDR2LINE}"
>
>
>
>
>
>
> >  }
> >
> >  # Perform one step in kallsyms generation, including temporary linking=
 of
> > @@ -203,6 +225,7 @@ cleanup()
> >         rm -f System.map
> >         rm -f vmlinux
> >         rm -f vmlinux.map
> > +       find . -type f -name "*.orig" -exec rm {} \;
>
>
> I am upset with deleting files with a well known suffix like this.
>
> When the 'patch' command fails, *.orig and *.rej will be created.
>
>
>
>
>
>
>
> >  }
> >
> >  # Use "make V=3D1" to debug this script
> > --
> > 2.34.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada

Best Regards
Alessandro Carminati

