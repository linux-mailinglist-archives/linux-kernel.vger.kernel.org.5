Return-Path: <linux-kernel+bounces-9058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE581BFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C175BB22A20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204E76915;
	Thu, 21 Dec 2023 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOVkWtdl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868E768EC;
	Thu, 21 Dec 2023 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-591a6f1385eso755342eaf.0;
        Thu, 21 Dec 2023 12:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703191291; x=1703796091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75TTzCiG4ggMgy+54jvB3HXr6/e+oYj02XIhaK0ijwA=;
        b=QOVkWtdlsUhBD74S3cXU3kfFfd+N2uELjKC3Iw6WpDOwCqz1FceIyfgL2HVbavDn+t
         BOKpOR3pWTkHeAclH9F2FF+jMua04ICaRPg/KOL+sq5kGMWGxbyXi45eUmvHRh1kWtrc
         bATIudm0/A788MMe9vqt5mUqVkKQWhJZoI0hDdbogm4z7uf1/hv/pLINUoqsRtE9MN1E
         5n0cNuAYKE1CfoO06zV/W4LQcQSFlWAhMH4eGeXbO3VxOso7c7EHIYPBDTzzcY5G4pu4
         TibS/wpQJis7xOKLdNgD1Zu2PUL/eUAkZN86ytuDBiv3+6V9bouCI2AOtb00dLVYzuxJ
         Sc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703191291; x=1703796091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75TTzCiG4ggMgy+54jvB3HXr6/e+oYj02XIhaK0ijwA=;
        b=rfXgR+hjbaXqb3S+ZyDwxFN5m4tAuhe0wdatplUOKUlgVm2Rs+VlKPPKr52gLsgAva
         U56BJGSTsVt7ywvZQM0usjWiJ6b/YdtOYI7IfMnkzoe4VhqhQoh/Y8iJmqbDWOWBEaAz
         wyAXh/XuQqFnS/I+FlxoHjX1HdMB7lIHsL9I/fUZYJ434bNb2BYynkPVGi+Dlr6Nx+WK
         Z2u3/vFS6KwCNOwqwx9Ihh7YV+4/umiXpSai4ZUHBBp22y9GBOSOHOUHZ7JkgIvsAh6x
         vlNiJbUSqV2WxswNEfu5DUZzVC+EujoIIAkX9lM4fonFZLJPFv8VWXEmMK0kBWETMIgF
         mu2g==
X-Gm-Message-State: AOJu0Yzs8msaCDQHGSznGG62gfcUrT8ba1kUXf710Xg29/NOkwmorW26
	YbKbjtK0/6ZW8BXVXjuPwfqB0DdfUHc3v8lzOTA=
X-Google-Smtp-Source: AGHT+IET3uucpVqXltB1hjmGPONILiJHU38JmCB49yxHVHsJDBjtouywUlB6EYlW1qxhJDVCvJ/J/GXR+7VVQ2frfs4=
X-Received: by 2002:a05:6820:1c97:b0:594:2014:e0cf with SMTP id
 ct23-20020a0568201c9700b005942014e0cfmr263018oob.5.1703191290955; Thu, 21 Dec
 2023 12:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204214635.2916691-1-alessandro.carminati@gmail.com> <8312091.T7Z3S40VBb@pwmachine>
In-Reply-To: <8312091.T7Z3S40VBb@pwmachine>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 21 Dec 2023 21:40:54 +0100
Message-ID: <CAPp5cGSc-k_h3Q7Dy+h8ScnY5A9SB5f9ci_uF6BZ_JnwRapmhQ@mail.gmail.com>
Subject: Re: [PATCH v7] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Nick Alcock <nick.alcock@oracle.com>, Kris Van Hees <kris.van.hees@oracle.com>, 
	Eugene Loh <eugene.loh@oracle.com>, Viktor Malik <vmalik@redhat.com>, 
	Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Francis,
Thanks for the review.

Il giorno gio 21 dic 2023 alle ore 18:23 Francis Laniel
<flaniel@linux.microsoft.com> ha scritto:
>
> Hi!
>
>
> Le lundi 4 d=C3=A9cembre 2023, 22:46:35 CET Alessandro Carminati (Red Hat=
) a
> =C3=A9crit :
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
> > ffffcaa2a052102c t name_show  [hello]
> > ffffcaa2a052102c t name_show@hello_hello_c_8  [hello]
> > ffffcaa2a051955c t name_show  [rpmsg_char]
> > ffffcaa2a051955c t name_show@drivers_rpmsg_rpmsg_char_c_365   [rpmsg_ch=
ar]
> >
> > where hello, is a plain helloworld module built OOT.
>
> Thank you for sending the v7 and sorry for the delay!
> I tested it and it works fine:
> root@vm-amd64:~# uname -r
> 6.7.0-rc6-00079-g6162f0ee7bcb
> root@vm-amd64:~# grep name_show /proc/kallsyms | head -5
> ffffffffb400f230 t __pfx_pmu_name_show
> ffffffffb400f240 t pmu_name_show
> ffffffffb40fb1d0 t __pfx_name_show
> ffffffffb40fb1e0 t name_show
> ffffffffb40fb1e0 t name_show@kernel_irq_irqdesc_c_264
>
> I am curious about the module part, can you please indicate me how you te=
sted
> it?

Are you referring to the process of building an OOT module and including
aliases?

If that's the query, the current build now generates an additional file
named modules.symbfreq, which contains the frequencies of symbols.
Here's an example:

~ # cat modules.symbfreq
[...]
bcm2835_handle_irq:1
bcm2836_arm_irqchip_handle_irq:1
dw_apb_ictl_handle_irq:1
gic_handle_irq:2
aic_handle_irq:1
[...]

To proceed, this file needs to be copied to the root directory of the OOT
module, following which the module can undergo the regular build process.

If this file is not found during the build, no aliases will be added to tha=
t
particular module.

>
> I found some nits in the code but nothing critical:

I experimented with several approaches to tackle this problem before
discovering one that proved satisfactory. However, these multiple revisions
caused a misalignment in the documentation.
I apologize for the oversight.

>
> > Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Alessandro Carminati (Red Hat)
> > <alessandro.carminati@gmail.com>
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
ti@gm
> > ail.com/
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
ti@gm
> > ail.com/
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
ti@gm
> > ail.com/
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
i@gma
> > il.com/
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
ti@gm
> > ail.com/
> >
> > Changes from v6:
> > * Generate a file to facilitate the construction of custom OOT modules =
using
> > aliases. In this context, it is needed to export the modules.symbfreq f=
ile,
> > a product of the build.
> > * Previously, kas_alias was intended to run once, executing all tasks w=
ithin
> > the same session. In this version, two targets have been introduced to
> > split the work into distinct phases: one for creating aliases for the c=
ore
> > image and another for generating aliases for modules.
> > * The module aliases production statement has been inserted in the
> >   scripts/Makefile.modfinal. Instead of being executed individually for=
 each
> > module, it now runs once for all modules.
> > * The approach for excluding symbols in .init and .exit ELF sections ha=
s
> > undergone a rewrite.
> > * kas_alias is now capable of applying aliases to OOT modules. However,=
 for
> > this to occur, the 'modules.symbfreq' file needs to be accessible durin=
g
> > the build. If it is not found, aliases won't be added.
> >
> > https://lore.kernel.org/all/20231024201157.748254-1-alessandro.carminat=
i@gma
> > il.com/ ---
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
> > @@ -479,6 +479,7 @@ OBJCOPY           =3D $(LLVM_PREFIX)llvm-objcopy$
> (LLVM_SUFFIX)
> >  OBJDUMP              =3D $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> >  READELF              =3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> >  STRIP                =3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> > +ADDR2LINE    =3D $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
> >  else
> >  CC           =3D $(CROSS_COMPILE)gcc
> >  LD           =3D $(CROSS_COMPILE)ld
> > @@ -488,6 +489,7 @@ OBJCOPY           =3D $(CROSS_COMPILE)objcopy
> >  OBJDUMP              =3D $(CROSS_COMPILE)objdump
> >  READELF              =3D $(CROSS_COMPILE)readelf
> >  STRIP                =3D $(CROSS_COMPILE)strip
> > +ADDR2LINE    =3D $(CROSS_COMPILE)addr2line
> >  endif
> >  RUSTC                =3D rustc
> >  RUSTDOC              =3D rustdoc
> > @@ -591,7 +593,7 @@ export RUSTC_BOOTSTRAP :=3D 1
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
> > LDFLAGS_MODULE @@ -1453,6 +1455,16 @@ KBUILD_BUILTIN :=3D 1
> >  modules: vmlinux
> >  endif
> >
> > +# *.ko are usually independent of vmlinux, but
> > CONFIG_KALLSYMS_ALIAS_SRCLINE +# is another exception.
> > +# At the time when vmlinux is being linked, kas_alias operates on both
> > vmlinux +# and modules. To prevent races with modules, kas_alias needs =
to
> > pause operations +# while it is executed.
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
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 8568d256d6fb..acde29a46c6b 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -15,6 +15,32 @@ include $(srctree)/scripts/Makefile.lib
> >  # find all modules listed in modules.order
> >  modules :=3D $(call read-file, $(MODORDER))
> >
> > +ifeq ($(KBUILD_BUILTIN),y)
> > +  ifeq ($(or
> > $(CONFIG_DEBUG_INFO_BTF_MODULES),$(CONFIG_KALLSYMS_ALIAS_SRCLINE)),y) +
> > VMLINUX_DEP :=3D vmlinux
> > +  endif
> > +endif
> > +
> > +VMLINUX_DEP ?=3D
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
> > +  KAS_ALIAS_MODULE_CMD :=3D $(srctree)/scripts/kas_alias.py
> > --symbol_frequency $(extmod_prefix)modules.symbfreq \ +  --debug
> > $(DEBUG_FLAG)  --nm $(NM) $(KAS_DATA) \
> > +  --addr2line $(ADDR2LINE) --basedir $(srctree) --separator @ \
> > +  single_module \
> > +  --objcopy $(OBJCOPY) --objdump $(OBJDUMP) --target-module
> > +endif
> > +
> >  __modfinal: $(modules:%.o=3D%.ko)
> >       @:
> >
> > @@ -30,6 +56,7 @@ quiet_cmd_cc_o_c =3D CC [M]  $@
> >
> >  quiet_cmd_ld_ko_o =3D LD [M]  $@
> >        cmd_ld_ko_o +=3D                                                =
 \
> > +     [ "$(KAS_ALIAS_MODULE_CMD)" !=3D "" ] && $(KAS_ALIAS_MODULE_CMD) =
$<;
> \
> >       $(LD) -r $(KBUILD_LDFLAGS)                                      \
> >               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)              \
> >               -T scripts/module.lds -o $@ $(filter %.o, $^)
> > @@ -52,7 +79,7 @@ if_changed_except =3D $(if $(call
> > newer_prereqs_except,$(2))$(cmd-check),      \ printf '%s\n' 'savedcmd_=
$@
> > :=3D $(make-cmd)' > $(dot-target).cmd, @:)
> >
> >  # Re-generate module BTFs if either module's .ko or vmlinux changed
> > -%.ko: %.o %.mod.o scripts/module.lds $(and
> > $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE +%.ko=
:
> > %.o %.mod.o scripts/module.lds $(VMLINUX_DEP) FORCE
> >       +$(call if_changed_except,ld_ko_o,vmlinux)
> >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >       +$(if $(newer-prereqs),$(call cmd,btf_ko))
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
> > +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati
> > <alessandro.carminati@gmail.com> +#
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
> > +
> > +class SeparatorType:
> > +    def __call__(self, separator):
> > +        if len(separator) !=3D 1:
> > +            raise argparse.ArgumentTypeError("Separator must be a sing=
le
> > character") +        return separator
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
> > +    Prints text if current debug level is greater or equal to
> > print_debug_level. +    Args:
> > +      current_debug_level: Application debug level specified by comman=
d
> > line. +      print_debug_level: Minimum debug level message should be
> > printed. +      text: string representing the message.
> > +    Returns:
> > +      Nothing.
> > +    """
> > +    if int(config.debug) >=3D print_debug_level:
> > +        print(f"{get_caller()}: " + text)
> > +
> > +def parse_nm_lines(config, lines, name_occurrences=3DNone):
> > +    """
> > +    Parses a given nm output and returns the symbol list along with a =
hash
> > of +    symbol occurrences.
> > +    Args:
> > +      lines: List of tuples representing one nm line.
> > +      name_occurrences: Hash having the name as key, used to count nam=
es'
> > +                        occurrences.
> > +    Returns:
> > +      Creates a new line list proper for the nm output it parsed and,
> > updates +      the occurrences hash.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, "parse_nm_lines:
> > parse start") +
> > +    if name_occurrences is None:
> > +        name_occurrences =3D {}
> > +
> > +    symbol_list =3D []
> > +
> > +    for line in lines:
> > +        fields =3D line.strip().split()
> > +
> > +        if len(fields) >=3D 3:
> > +            address, type, name =3D fields[0], fields[1], '
> > '.join(fields[2:]) +            symbol_list.append(Line(address, type,
> > name, int(address, 16))) +            name_occurrences[name] =3D
> > name_occurrences.get(name, 0) + 1 +
> > +    return symbol_list, name_occurrences
> > +
> > +def start_addr2line_process(binary_file, config):
> > +    """
> > +    Initializes an addr2line server process operating on the given ELF
> > object. +    Args:
> > +      binary_file: String representing the binary file name object of
> > addr2line +                   queries.
> > +      addr2line_file: String representing the addr2line executable nam=
e.
>
> The documentation is not up to date here.
>
> > +    Returns:
> > +      Returns addr2line process descriptor.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, f"Starting addr2=
line
> > process on {binary_file}") +
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
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(e).__name__}): {str(e)}") +
> > sys.exit(-2)
> > +
> > +def addr2line_fetch_address(config, addr2line_process, address):
> > +    """
> > +    Queries a specific address using the active addr2line process.
> > +    Args:
> > +      addr2line_process: Descriptor of the addr2line process that is w=
anted
> > to +                         handle the query.
> > +      address: The address of the symbol that needs to be resolved.
> > +    Returns:
> > +      Returns a string representing the file and line number where the
> > symbol +      at the specified address has been defined. The address is
> > normalized +      before being returned.
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
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(e).__name__}): {str(e)}") +
> > sys.exit(-2)
> > +
> > +def process_line(line, config, section_map):
> > +    """
> > +    Determines whether a duplicate item requires an alias or not.
> > +    Args:
> > +      line: nm line object that needs to be checked.
> > +      section_map: map correlating symbols and the ELF section they ar=
e
>
> It lacks documentation for config.
>
> > from +    Returns:
> > +      Returns true if the line needs to be processed, false otherwise.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_ALL.value, f"Processing
> > {line.address} {line.type} {line.name}") +
> > +    # The module contains symbols that were discarded after being load=
ed.
> > Typically, +    # these symbols belong to the initialization function.
> > These symbols have their +    # address in the init section addresses, =
so
> > this check prevents these symbols +    # from being assigned aliases.
> > +    if section_map !=3D None:
> > +       if line.name in section_map:
> > +          if (".init" in section_map[line.name] or ".exit" in
> > section_map[line.name]): +              return False
> > +       else:
> > +          return False
> > +
> > +    if config.process_data_sym:
> > +        return not (any(re.match(regex, line.name) for regex in
> > regex_filter)) +    else:
> > +        return (line.type in {"T", "t"}) and (
> > +                not (any(re.match(regex, line.name) for regex in
> > regex_filter))) +
> > +def fetch_file_lines(config, filename):
> > +    """
> > +    Reads a text file and retrieves its content.
> > +    Args:
> > +      filename: String representing the name of the file that needs to=
 be
> > read. +    Returns:
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
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(FileNotFoundError).__name__}):
> > {str(FileNotFoundError)}") +        sys.exit(-2)
> > +
> > +def do_nm(filename, config):
> > +    """
> > +    Runs the nm command on a specified file.
> > +    Args:
> > +      filename: String representing the name of the file on which nm s=
hould
> > +      run against.
> > +      nm_executable: String representing the nm executable filename.
>
> The documentation is not up to date.
>
> > +    Returns:
> > +      Returns a strings list representing the nm output.
> > +    """
> > +    debug_print(config, DebugLevel.DEBUG_BASIC.value, f"executing
> > {config.nm_file} -n {filename}") +
> > +    try:
> > +        nm_output =3D subprocess.check_output([config.nm_file, '-n',
> > filename], +                      universal_newlines=3DTrue,
> > stderr=3Dsubprocess.STDOUT).splitlines() +        return nm_output
> > +    except subprocess.CalledProcessError as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(e).__name__}): {str(e)}") +
> > sys.exit(-2)
> > +
> > +def make_objcpy_arg(config, line, decoration, section_map):
> > +    """
> > +    Produces an objcopy argument statement for a single alias to be ad=
ded
> > in a +    module.
> > +    Args:
> > +      line: nm line object target for this iteration.
> > +      decoration: String representing the decoration (normalized addr2=
line
> > +                  output) to be added at the symbol name to have the a=
lias.
> > +      section_map: map correlating symbols and the ELF section they ar=
e
> > from +    Returns:
> > +      Returns a string that directly maps the argument string objcopy
> > should +      use to add the alias.
> > +    """
> > +    try:
> > +        flag =3D "global" if line.type.isupper() else "local"
> > +        debug_print(config, DebugLevel.DEBUG_MODULES.value,
> > +                 f"{line.name +
> > decoration}=3D{section_map[line.name]}:0x{line.address},{flag}") +
> > return (
> > +                "--add-symbol "
> > +                f"{line.name +
> > decoration}=3D{section_map[line.name]}:0x{line.address},{flag} " +
> >    )
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
> > +    Since objcopy can't operate in place, the original object file is
> > renamed +    before operating on it. At function end, a new object file
> > having the old +    object's name is carrying the aliases for the dupli=
cate
> > symbols. +    Args:
> > +      objcopy_executable: String representing the object copy executab=
le
> > file. +      objcopy_args: Arguments (aliases to add to the object file=
) to
> > be used +                    in the objcopy execution command line.
> > +      object_file: Target object file (module object file) against whi=
ch
> > objcopy is executed. +    Returns:
>
> The documentation is not up to date.
>
> > +      Nothing is returned, but as a side effect of this function execu=
tion,
> > +      the module's object file contains the aliases for duplicated
> > symbols. +    """
> > +    # Rename the original object file by adding a suffix
> > +    backup_file =3D object_file + '.orig'
> > +    debug_print(config, DebugLevel.DEBUG_MODULES.value, f"rename
> > {object_file} to {backup_file}") +    os.rename(object_file, backup_fil=
e)
> > +
> > +    full_command =3D (
> > +                    f"{config.objcopy_file} "
> > +                    f"{objcopy_args} {backup_file} {object_file}"
> > +                   )
> > +    debug_print(config, DebugLevel.DEBUG_MODULES.value, f"executing
> > {full_command}") +
> > +    try:
> > +        subprocess.run(full_command, shell=3DTrue, check=3DTrue)
> > +    except subprocess.CalledProcessError as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(e).__name__}): {str(e)}") +
> > sys.exit(-2)
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
> > +    output =3D addr2line_fetch_address(config, addr2line_process,
> > line.address) +    base_dir =3D config.linux_base_dir + "/"
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
can
> > not find the +    # specified address in the DWARF section that after
> > normalization it becomes "____". +    # In such cases, emitting an alia=
s
> > wouldn't make sense, so it is skipped. +    if decoration !=3D
> > config.separator + "____":
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
>
> You have a typo here with the bracket.
>
> > +    any given object file.
> > +    Args:
> > +      objdump_executable: String representing the objdump executable.
> > +      file_to_operate: file whose section names are wanted.
>
> The documentation is not up to date.
>
> > +    Returns:
> > +      Returns a map, where the key is the symbol name and the value is
> > +      a section name.
> > +    """
> > +    try:
> > +        output =3D subprocess.check_output(
> > +                   [config.objdump_file, '-h', file_to_operate],
> > +                   universal_newlines=3DTrue)
> > +        section_pattern =3D re.compile(r'^ *[0-9]+ ([.a-z_]+)
> > +([0-9a-f]+).*$', re.MULTILINE) +        section_names =3D
> > section_pattern.findall(output)
> > +        result =3D {}
> > +        for section, section_siza in section_names:
>
> I think you wanted to name it "section_size".

Yeah, sure, I need to admit it, I am addicted by the copy-pasting.
It's like a typo magnet, drawing them in without I even noticing.
It's amazing how easily those little mistakes can spread around
when I am not looking.

>
> > +            if int(section_siza, 16) !=3D 0 and section_interesting(se=
ction):
> > +                debug_print(config, DebugLevel.DEBUG_ALL.value, f"CMD =
=3D>
> > {config.objdump_file} -tj {section} {file_to_operate}") +
> > try:
> > +                    output =3D subprocess.check_output(
> > +                           [config.objdump_file, '-tj', section,
> > file_to_operate], +                           universal_newlines=3DTrue=
)
> > +                except subprocess.CalledProcessError:
> > +                      pass
> > +                func_names_pattern =3D re.compile(r'[0-9a-f]+.*
> > ([.a-zA-Z_][.A-Za-z_0-9]+)$', re.MULTILINE) +                matches =
=3D
> > func_names_pattern.findall(output)
> > +                for func_name in matches:
> > +                    result[func_name] =3D section
> > +
> > +
> > +    except Exception as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(e).__name__}): {str(e)}") +
> > sys.exit(-2)
> > +    return result
> > +
> > +def produce_output_modules(config, symbol_list, name_occurrences,
> > +                           module_file_name, addr2line_process):
> > +    """
> > +    Computes the alias addition on a given module object file.
> > +    Args:
> > +      config: Object containing command line configuration.
> > +      symbol_list: List of tuples representing nm lines for the given
> > object +                   file.
> > +      name_occurrences: Hash that stores symbol occurrences for the bu=
ild.
> > +      module_file_name: String representing the target moule object fi=
le.
> > +      addr2line_process: Descriptor of the addr2line process that is w=
anted
> > to +                         handle the query.
> > +    Returns:
> > +      Nothing is returned, but as a side effect of this function execu=
tion,
> > +      the module's object file contains the aliases for duplicated
> > symbols. +    """
> > +    debug_print(config, DebugLevel.DEBUG_ALL.value, "produce_output_mo=
dules
> > computation starts here ") +    objcopy_args =3D "";
> > +    args_cnt =3D 0
> > +    section_map =3D get_symbol2section(config, module_file_name)
> > +    for module_symbol in symbol_list:
> > +        debug_print(config, DebugLevel.DEBUG_ALL.value, f"--> Processi=
ng
> > {module_symbol}") +        try:
> > +            if (name_occurrences[module_symbol.name] > 1) and
> > process_line(module_symbol, config, section_map): +
> > decoration =3D generate_decoration(module_symbol, config, addr2line_pro=
cess)
> > +                debug_print(config, DebugLevel.DEBUG_ALL.value, f"---
> > {module_symbol} occurred multiple times and is a candidate for alias:
> > decoration '{decoration}'") +                if decoration !=3D "":
> > +                    objcopy_args =3D objcopy_args + make_objcpy_arg(co=
nfig,
> > module_symbol, decoration, section_map) +                    args_cnt =
=3D
> > args_cnt + 1
> > +                    if args_cnt > 50:
> > +                       debug_print(config, DebugLevel.DEBUG_MODULES.va=
lue,
> > "Number of arguments high, split objcopy" +
> >   " call into multiple statements.") +
> > execute_objcopy(config, objcopy_args, module_file_name) +
> >     args_cnt =3D 0
> > +                       objcopy_args =3D ""
> > +        except KeyError:
> > +            pass
> > +    execute_objcopy(config, objcopy_args, module_file_name)
> > +
> > +def produce_output_vmlinux(config, symbol_list, name_occurrences,
> > addr2line_process): +    """
> > +    Computes the alias addition for the core Linux on image.
> > +    Args:
> > +      config: Object containing command line configuration.
> > +      symbol_list: List of tuples representing nm lines for the given
> > object +                   file.
> > +      name_occurrences: Hash that stores symbol occurreces for the bui=
ld.
> > +      addr2line_process: Descriptor of the addr2line process that is w=
anted
> > to +                         handle the query.
> > +    Returns:
> > +      Nothing is returned, but as a side effect of this function execu=
tion,
> > +      the core kernel image contains the aliases for duplicated symbol=
s. +
> >    """
> > +    with open(config.output_file, 'w') as output_file:
> > +       for obj in symbol_list:
> > +            output_file.write(f"{obj.address} {obj.type} {obj.name}\n"=
)
> > +            if (name_occurrences[obj.name] > 1) and process_line(obj,
> > config, None): +                decoration =3D generate_decoration(obj,
> > config, addr2line_process) +
> > debug_print(config,DebugLevel.DEBUG_ALL.value, f"Symbol {obj.name} appe=
ars
> > multiple times, and decoration is {decoration}") +                if
> > decoration !=3D "":
> > +                    debug_print(config, DebugLevel.DEBUG_ALL.value,
> > f"Writing on {config.output_file} the additional '{obj.address} {obj.ty=
pe}
> > {obj.name + decoration}'") +
> > output_file.write(f"{obj.address} {obj.type} {obj.name + decoration}\n"=
) +
> > +def read_name_occurrences(config):
> > +    """
> > +    Reads symbol frequencies from the file specified in the 'config'
> > argument. +
> > +    If the file is not found, it gracefully returns an empty map.
> > +
> > +    Args:
> > +      config: A configuration object or dictionary containing necessar=
y
> > information +              to locate the file.
> > +
> > +    Returns:
> > +      A map where keys represent symbol names and values represent the=
ir
> > frequencies. +    """
> > +    name_occurrences =3D {}
> > +    # This code reads occurrences of symbol names from a file containi=
ng
> > both the core image +    # and modules frequencies resulted from the
> > computation of the "core_image" action. +    # It reads from the file
> > specified by command-line arguments; if the file doesn't exist +    # o=
r
> > the filename isn't specified, it returns an empty map.
> > +    # The code relies on accessing and reading config.symbol_frequency=
_file
> > containing +    # symbol name frequencies.
> > +    # In a complete build, this file is generated during the "core ima=
ge"
> > action earlier +    # in the build process.
> > +    # However, when building a custom OOT module, it is needed to ensu=
re
> > that this file +    # is accessible in the current directory where the
> > module source code is being built. +    # Not having this file result i=
n a
> > module that have no aliases even if they are needed +    if
> > config.symbol_frequency_file is not None:
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
> > +   Flags modules that already have aliases based on the given
> > 'module_nm_lines'. +
> > +   This function takes in configuration details and a list of strings
> > representing +   the 'nm' command output for a specific module. It dete=
cts
> > instances where a module +   already possesses an alias, which might oc=
cur
> > after a build interruption and restart. +
> > +   The detection logic is straightforward: it examines if the separato=
r
> > character is +   present in the symbol name. If found, it uses this
> > separator to check if the +   previous symbol shares the same name. Thi=
s
> > detection assumes 'nm' is invoked with +   the '-n' flag, ensuring symb=
ol
> > sorting.
> > +
> > +   Args:
> > +     config: A configuration object or dictionary containing necessary
> > information. +     module_nm_lines: A list of strings representing the =
'nm'
> > command output for a module. +
> > +   Returns:
> > +     True if the module_nm_lines contains aliases, False otherwise.
> > +   """
> > +   prev =3D None
> > +   for line in module_nm_lines:
> > +       if ('@' in line.name and line.name.split(config.separator)[0] =
=3D=3D
> > prev): +           return False
>
> I am not 100% to understand this logic.
> You want to return True if the output contains aliases.
> So, you should rather test the following:
> if ('@' not in line.name and line.name.split(config.separator)[0] !=3D pr=
ev):
> Moreover, you should replace the hardcoded '@' by config.separator:
> if (config.separator not in line.name and line.name.split(config.separato=
r)[0] !
> =3D prev):
> What do you think?
>

You've absolutely right about the embedded "@". I overlooked it since it is
the main cause why this function is made that way.

Certain symbols might inherently contain the separator in their names.
While this generally holds true, I discovered this when using "@" as the
separator, a character I don't expect to find in a symbol name.

For instance:
~ # uname -a
Linux buildroot 6.6.3 #18 SMP PREEMPT Mon Dec  4 09:18:13 UTC 2023
aarch64 GNU/Linux
~ # cat /proc/kallsyms  | grep @ | grep -v @drivers | grep -v @lib  | \
grep -v @kernel  | grep -v @fs_  | grep -v @mm_  | grep -v @arch_  | \
grep -v @include  | grep -v @net_  | grep -v @virt  | grep -v @crypto  | \
grep -v @sound  | grep -v @init  | grep -v @ipc_  | grep -v @io_  | \
grep -v @security  | grep -v @scripts
ffffbfd5520c3ed8 t e843419@00d2_00000e2d_82d0
ffffbfd552d06b58 t e843419@0db6_000101c0_1284

This test aims to differentiate between these scenarios.

The broader context is this:
If the build is interrupted while aliases are being added to modules, a
subsequent build might encounter a situation where some modules already
possess aliases, while others are yet to undergo this process.

To prevent aliases to be added to modules that already possess them
when resuming the build, it's crucial to verify that the module that is
being processed already contain aliases.

My approach involves checking if any name includes the separator character.
Moreover, due to the ordering of symbols by 'nm -n', I can compare the curr=
ent
symbol with the previous one.
If the current symbol's first half matches the previous one, it confirms
current is an alias and the module processing can be skipped.

This check enables me to distinguish genuinely aliased modules from those
that coincidentally contain the separator in their names.

> > +       prev =3D line.name
> > +   return True
> > +
> > +def main():
> > +    # Handles command-line arguments and generates a config object
> > +    parser =3D argparse.ArgumentParser(description=3D'Add alias to mul=
tiple
> > occurring symbols name in kallsyms') +    subparsers =3D
> > parser.add_subparsers(title=3D'Subcommands', dest=3D'action') +
> > core_image_parser =3D subparsers.add_parser('core_image', help=3D'Opera=
tes for
> > in tree computation.') +    core_image_parser.add_argument('-n',
> > "--nmdata", dest=3D"nm_data_file", required=3DTrue, help=3D"Set vmlinux=
 nm output
> > file to use for core image.") +    core_image_parser.add_argument('-o',
> > "--outfile", dest=3D"output_file", required=3DTrue, help=3D"Set the vml=
inux nm
> > output file containing aliases.") +    core_image_parser.add_argument('=
-v',
> > "--vmlinux", dest=3D"vmlinux_file", required=3DTrue, help=3D"Set the vm=
linux core
> > image file.") +    core_image_parser.add_argument('-m', "--modules_list=
",
> > dest=3D"module_list", required=3DTrue, help=3D"Set the file containing =
the list
> > of the modules object files.") +
> > +    single_module_parser =3D subparsers.add_parser('single_module',
> > help=3D'Operates for out of tree computation.') +
> > single_module_parser.add_argument('-c', "--objcopy", dest=3D"objcopy_fi=
le",
> > required=3DTrue, help=3D"Set the objcopy executable to be used.") +
> > single_module_parser.add_argument('-u', "--objdump", dest=3D"objdump_fi=
le",
> > required=3DTrue, help=3D"Set objdump  executable to be used.") +
> > single_module_parser.add_argument('-q', "--target-module",
> > dest=3D"target_module", required=3DFalse, help=3D"Sets a tharget module=
 to
> > operate.") +
> > +    parser.add_argument('-j', "--symbol_frequency",
> > dest=3D"symbol_frequency_file", required=3DTrue, help=3D"Specify the sy=
mbol
> > frequency needed to use for producing aliases") +
> > parser.add_argument('-z', "--debug", dest=3D"debug", required=3DFalse,
> > help=3D"Set the debug level.", choices=3D[f"{level.value}" for level in
> > DebugLevel], default=3D"1" ) +    parser.add_argument('-a', "--addr2lin=
e",
> > dest=3D"addr2line_file", required=3DTrue, help=3D"Set the addr2line exe=
cutable to
> > be used.") +    parser.add_argument('-b', "--basedir",
> > dest=3D"linux_base_dir", required=3DTrue, help=3D"Set base directory of=
 the
> > source kernel code.") +    parser.add_argument('-s', "--separator",
> > dest=3D"separator", required=3DFalse, help=3D"Set separator, character =
that
> > separates original name from the addr2line data in alias symbols.",
> > default=3D"@", type=3DSeparatorType()) +    parser.add_argument('-d',
> > "--process_data", dest=3D"process_data_sym", required=3DFalse, help=3D"=
Requires
> > the tool to process data symbols along with text symbols.",
> > action=3D'store_true') +    parser.add_argument('-e', "--nm", dest=3D"n=
m_file",
> > required=3DTrue, help=3D"Set the nm executable to be used.") +
> > +    config =3D parser.parse_args()
> > +
> > +    try:
> > +        # The core_image target is utilized for gathering symbol stati=
stics
> > from the core image and modules, +        # generating aliases for the =
core
> > image. This target is designed to be invoked from scripts/link-vmlinux.=
sh +
> >        if config.action =3D=3D 'core_image':
> > +            debug_print(config, DebugLevel.INFO.value,"Start core_imag=
e
> > processing") +
> > +            # Determine kernel source code base directory
> > +            if not config.linux_base_dir.startswith('/'):
> > +                config.linux_base_dir =3D os.path.normpath(os.getcwd()=
 + "/"
> > + config.linux_base_dir) + "/" +            debug_print(config,
> > DebugLevel.DEBUG_BASIC.value, f"Configuration: {config}") +
> > +            debug_print(config, DebugLevel.INFO.value, "Process nm dat=
a
> > from vmlinux") +            # Process nm data from vmlinux
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value,
> > f"fetch_file_lines({config.nm_data_file})") +            vmlinux_nm_lin=
es =3D
> > fetch_file_lines(config, config.nm_data_file) +
> > vmlinux_symbol_list, name_occurrences =3D parse_nm_lines(config,
> > vmlinux_nm_lines) +
> > +            debug_print(config, DebugLevel.INFO.value,"Process nm data=
 for
> > modules") +            # Process nm data for modules
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value,
> > f"fetch_file_lines({config.nm_data_file})") +            module_list =
=3D
> > fetch_file_lines(config, config.module_list) +
> > module_symbol_list =3D {}
> > +            for module in module_list:
> > +                module_nm_lines =3D do_nm(module, config)
> > +                module_symbol_list[module], name_occurrences =3D
> > parse_nm_lines(config, module_nm_lines, name_occurrences) +
> > +            debug_print(config, DebugLevel.INFO.value, f"Save
> > name_occurrences data: {config.symbol_frequency_file}") +            wi=
th
> > open(config.symbol_frequency_file, 'w') as file: +                for k=
ey,
> > value in name_occurrences.items():
> > +                    file.write(f"{key}:{value}\n")
> > +
> > +            debug_print(config, DebugLevel.INFO.value, "Produce file f=
or
> > vmlinux") +            # Produce file for vmlinux
> > +            debug_print(config, DebugLevel.DEBUG_BASIC.value,
> > f"addr2line_process({config.vmlinux_file}, {config.addr2line_file})") +
> >        addr2line_process =3D start_addr2line_process(config.vmlinux_fil=
e,
> > config) +            produce_output_vmlinux(config, vmlinux_symbol_list=
,
> > name_occurrences, addr2line_process) +
> > addr2line_process.stdin.close()
> > +            addr2line_process.stdout.close()
> > +            addr2line_process.stderr.close()
> > +            addr2line_process.wait()
> > +
> > +        # Expects to be called from scripts/Makefile.modfinal
> > +        elif config.action =3D=3D 'single_module':
> > +             debug_print(config, DebugLevel.INFO.value,"Start single_m=
odule
> > processing") +             # read simbol name frequency file
>
> Nit: You have a typo here.
>
> > +             name_occurrences =3D read_name_occurrences(config)
> > +             # scan current module
> > +             module_nm_lines =3D do_nm(config.target_module, config)
> > +             mudule_nm_data, _ =3D parse_nm_lines(config, module_nm_li=
nes)
> > +             if check_aliases(config, mudule_nm_data,):
> > +                 debug_print(config, DebugLevel.DEBUG_BASIC.value,
> > f"addr2line_process({config.target_module}, {config.addr2line_file})") =
+
> >              addr2line_process =3D
> > start_addr2line_process(config.target_module, config) +
> > debug_print(config, DebugLevel.DEBUG_BASIC.value,"adding aliases to
> > module") +                 produce_output_modules(config, mudule_nm_dat=
a,
> > name_occurrences, config.target_module, addr2line_process) +
> >  addr2line_process.stdin.close()
> > +                 addr2line_process.stdout.close()
> > +                 addr2line_process.stderr.close()
> > +                 addr2line_process.wait()
> > +             else:
> > +                 debug_print(config, DebugLevel.INFO.value,"module is
> > already aliased, skipping") +
> > +        else:
> > +            raise SystemExit("Script terminated: unknown action")
> > +
> > +    except Exception as e:
> > +        debug_print(config, DebugLevel.PRODUCTION.value, f"Script
> > terminated due to an error ({type(e).__name__}): {str(e)}") +
> > sys.exit(-2)
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..31afac64d7ed 100755
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
>
> Rather than adding this "if", you can rework the existing one adding the =
test
> for CONFIG_KALLSYMS_ALIAS_SRCLINE.
>

Aargh, a port error from v6.
It's quite embarrassing.
The initial if statement was supposed to be replaced by the new one, and
the comment was intended to replace the old one. I'll make sure to address
this in the next version.

> >       fi
> >
> >       if is_enabled CONFIG_VMLINUX_MAP; then
> > @@ -161,7 +166,24 @@ kallsyms()
> >       fi
> >
> >       info KSYMS ${2}
> > -     scripts/kallsyms ${kallsymopt} ${1} > ${2}
> > +     ALIAS=3D""
> > +     KAS_DATA=3D""
> > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> > +             KAS_DATA=3D"--process_data"
> > +     fi
> > +     if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> > +             ALIAS=3D".alias"
> > +             # You can use KAS_ALIAS_DEBUG=3D<debug level> in the make
> statements to
> > enable +              # verbose execution for kas_alias.
> > +             ${srctree}/scripts/kas_alias.py --symbol_frequency
> modules.symbfreq \
> > +                     --debug ${KAS_ALIAS_DEBUG:-0} \
> > +                     --addr2line ${ADDR2LINE} --basedir ${srctree} --n=
m ${NM}
> \
> > +                     --separator @ ${KAS_DATA} \
> > +                     core_image \
> > +                     --modules_list ${MODORDER} --vmlinux ${kallsyms_v=
mlinux}
> \
> > +                     --nmdata ${1} --outfile ${1}${ALIAS}
> > +     fi
> > +     scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
> >  }
> >
> >  # Perform one step in kallsyms generation, including temporary linking=
 of
> > @@ -203,6 +225,7 @@ cleanup()
> >       rm -f System.map
> >       rm -f vmlinux
> >       rm -f vmlinux.map
> > +     find . -type f -name "*.orig" -exec rm {} \;
> >  }
> >
> >  # Use "make V=3D1" to debug this script
>
>
> Best regards.
>
>
Thak you

