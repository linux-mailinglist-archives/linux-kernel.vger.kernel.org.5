Return-Path: <linux-kernel+bounces-15185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26682280A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39482284F72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AA1774E;
	Wed,  3 Jan 2024 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxRJdLZl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336F17988;
	Wed,  3 Jan 2024 05:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17922C433CB;
	Wed,  3 Jan 2024 05:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704259031;
	bh=Ftpkj8e4e/uJKLz0f6l5DA/ZEcA8s4mTAOFPduXaCbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZxRJdLZlbSrkV7T82ZKgPZx+llIrTh1kkLZc/KEO7WxKtoanyk3NZKivKe6QXK0L2
	 Xu+chuiAZYryC0swEd9TBWTSF9Au9oBBPt3TNzesNPUCOYmZC5MCc1wCzoFRsloYmG
	 5ZZyhjm0H9noaYSTNk8Bay5WbI41FsYHxeJUcGzWawzag55KMgf1s2OThovcAqEHTQ
	 xJ7osUUwAW+uZj5K8co7VMeys0upolKqVDqo2Tt7D1SrAR3GBCNpc7AiPxtbYM0D8e
	 FWjHlugYXJ4RV5mL/rOPl8XxamR3HNYnu5j2UUzCV5KVc9XwS5odBWtj9x98XJ6R10
	 NB8qYe7fqkh1A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2048e63dbd9so3256956fac.1;
        Tue, 02 Jan 2024 21:17:11 -0800 (PST)
X-Gm-Message-State: AOJu0YwbD1s0p/qx/oAhkDodmDLu2YhZ3sUt/tpGvlrGhG9DpYq0qbbm
	7Mvh8JfCjOeNU1Q5MJoRs+pxsieGn8CWBUc6kiM=
X-Google-Smtp-Source: AGHT+IE4S3FLEXM55aEyV/3DkpRfihQLelFHpLW6nefXRLOPEfw7AVJL15lBRzfviRegU7+JEIHwQsIrADmKgZIeMcc=
X-Received: by 2002:a05:6871:1c5:b0:204:5a14:c4c9 with SMTP id
 q5-20020a05687101c500b002045a14c4c9mr12651064oad.52.1704259030325; Tue, 02
 Jan 2024 21:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204214635.2916691-1-alessandro.carminati@gmail.com>
 <CAK7LNASo6dDrgt=cyLDBqSuZKdb=+SpJCnigBXWN8Y5ricECKQ@mail.gmail.com> <CAPp5cGSYUvOXdR8e_N-LcJY74hrXFQitykCWN3NDYmQ48nyBNA@mail.gmail.com>
In-Reply-To: <CAPp5cGSYUvOXdR8e_N-LcJY74hrXFQitykCWN3NDYmQ48nyBNA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 3 Jan 2024 14:16:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZ07hnAH_LT0QDKuHmn23Mgs-v124B3rpVjvBD=j21fA@mail.gmail.com>
Message-ID: <CAK7LNARZ07hnAH_LT0QDKuHmn23Mgs-v124B3rpVjvBD=j21fA@mail.gmail.com>
Subject: Re: [PATCH v7] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
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

On Mon, Jan 1, 2024 at 8:11=E2=80=AFPM Alessandro Carminati
<alessandro.carminati@gmail.com> wrote:
>
> Hello,
>
>
>
> Il giorno dom 31 dic 2023 alle ore 06:35 Masahiro Yamada
> <masahiroy@kernel.org> ha scritto:
> >
> > On Tue, Dec 5, 2023 at 6:48=E2=80=AFAM Alessandro Carminati (Red Hat)
> > <alessandro.carminati@gmail.com> wrote:
> > >
> > > In the kernel environment, situations frequently arise where identica=
l
> > > names are shared among symbols within both the core image and modules=
.
> > > While this doesn't pose issues for the kernel's binary itself, it
> > > complicates trace or probe operations using tools like kprobe.
> > >
> > > This patch introduces "kas_alias" to address this challenge.
> > >
> > > During the kernel's build process, just before linking the vmlinux
> > > image in the "scripts/link-vmlinux.sh", symbol name frequencies are
> > > collected.
> > > This collection includes both the core kernel components and modules.
> > > Subsequently, within the same action, the nm data relative to vmlinux
> > > is modified by adding aliases based on the comprehensive symbol
> > > information gathered.
> > >
> > > The collection process occurs in two phases:
> > >
> > > 1. First phase: Executed during the linking of vmlinux, "kas_alias" s=
cans
> > >    all symbols provided by the 'nm' data against the vmlinux core ima=
ge
> > >    and all objects used for module linkage. This phase requires all
> > >    modules objects to be produced at this stage, thereby adding a vml=
inux
> > >    dependency for linking modules in 'scripts/Makefile.modfinal'.
> > >
> > > 2. Second phase: In a subsequent run in the same build, "kas_alias"
> > >    processes module objects and injects aliases into the objects' sym=
bol
> > >    tables where necessary. This operation is done by modifying
> > >    'scripts/Makefile.modfinal' to include an action for each processe=
d
> > >    module.
> > >
> > > Example:
> > >
> > > Consider the symbol "device_show", you can expect an output like the
> > > following:
> > >
> > >  ~ # cat /proc/kallsyms | grep " name_show"
> > > ffffcaa2bb4f01c8 t name_show
> > > ffffcaa2bb4f01c8 t name_show@kernel_irq_irqdesc_c_264
> > > ffffcaa2bb9c1a30 t name_show
> > > ffffcaa2bb9c1a30 t name_show@drivers_pnp_card_c_186
> > > ffffcaa2bbac4754 t name_show
> > > ffffcaa2bbac4754 t name_show@drivers_regulator_core_c_678
> > > ffffcaa2bbba4900 t name_show
> > > ffffcaa2bbba4900 t name_show@drivers_base_power_wakeup_stats_c_93
> > > ffffcaa2bbec4038 t name_show
> > > ffffcaa2bbec4038 t name_show@drivers_rtc_sysfs_c_26
> > > ffffcaa2bbecc920 t name_show
> > > ffffcaa2bbecc920 t name_show@drivers_i2c_i2c_core_base_c_660
> > > ffffcaa2bbed3840 t name_show
> > > ffffcaa2bbed3840 t name_show@drivers_i2c_i2c_dev_c_100
> > > ffffcaa2bbef7210 t name_show
> > > ffffcaa2bbef7210 t name_show@drivers_pps_sysfs_c_66
> > > ffffcaa2bbf03328 t name_show
> > > ffffcaa2bbf03328 t name_show@drivers_hwmon_hwmon_c_72
> > > ffffcaa2bbff6f3c t name_show
> > > ffffcaa2bbff6f3c t name_show@drivers_remoteproc_remoteproc_sysfs_c_21=
5
> > > ffffcaa2bbff8d78 t name_show
> > > ffffcaa2bbff8d78 t name_show@drivers_rpmsg_rpmsg_core_c_455
> > > ffffcaa2bbfff7a4 t name_show
> > > ffffcaa2bbfff7a4 t name_show@drivers_devfreq_devfreq_c_1395
> > > ffffcaa2bc001f60 t name_show
> > > ffffcaa2bc001f60 t name_show@drivers_extcon_extcon_c_389
> > > ffffcaa2bc009890 t name_show
> > > ffffcaa2bc009890 t name_show@drivers_iio_industrialio_core_c_1396
> > > ffffcaa2bc01212c t name_show
> > > ffffcaa2bc01212c t name_show@drivers_iio_industrialio_trigger_c_51
> > > ffffcaa2bc025e2c t name_show
> > > ffffcaa2bc025e2c t name_show@drivers_fpga_fpga_mgr_c_618
> > > ffffcaa2a052102c t name_show    [hello]
> > > ffffcaa2a052102c t name_show@hello_hello_c_8    [hello]
> > > ffffcaa2a051955c t name_show    [rpmsg_char]
> > > ffffcaa2a051955c t name_show@drivers_rpmsg_rpmsg_char_c_365     [rpms=
g_char]
> > >
> > > where hello, is a plain helloworld module built OOT.
> > >
> > > Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@g=
mail.com>
> > >
> > > ---
> > >
> > > NOTE1:
> > > About the symbols name duplication that happens as consequence of the
> > > inclusion compat_binfmt_elf.c does, it is evident that this corner is
> > > inherently challenging the addr2line approach.
> > > Attempting to conceal this limitation would be counterproductive.
> > >
> > > compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't h=
elp
> > > but report all functions and data declared by that file, coming from
> > > binfmt_elf.c.
> > >
> > > My position is that, rather than producing a more complicated pipelin=
e
> > > to handle this corner case, it is better to fix the compat_binfmt_elf=
.c
> > > anomaly.
> > >
> > > This patch does not deal with the two potentially problematic symbols
> > > defined by compat_binfmt_elf.c
> > >
> > > Changes from v1:
> > > * Integrated changes requested by Masami to exclude symbols with pref=
ixes
> > >   "_cfi" and "_pfx".
> > > * Introduced a small framework to handle patterns that need to be exc=
luded
> > >   from the alias production.
> > > * Excluded other symbols using the framework.
> > > * Introduced the ability to discriminate between text and data symbol=
s.
> > > * Added two new config symbols in this version:
> > >   CONFIG_KALLSYMS_ALIAS_DATA, which allows data for data, and
> > >   CONFIG_KALLSYMS_ALIAS_DATA_ALL, which excludes all filters and prov=
ides
> > >   an alias for each duplicated symbol.
> > >
> > > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carmi=
nati@gmail.com/
> > >
> > > Changes from v2:
> > > * Alias tags are created by querying DWARF information from the vmlin=
ux.
> > > * The filename + line number is normalized and appended to the origin=
al
> > >   name.
> > > * The tag begins with '@' to indicate the symbol source.
> > > * Not a change, but worth mentioning, since the alias is added to the
> > >   existing list, the old duplicated name is preserved, and the livepa=
tch
> > >   way of dealing with duplicates is maintained.
> > > * Acknowledging the existence of scenarios where inlined functions
> > >   declared in header files may result in multiple copies due to compi=
ler
> > >   behavior, though it is not actionable as it does not pose an operat=
ional
> > >   issue.
> > > * Highlighting a single exception where the same name refers to diffe=
rent
> > >   functions: the case of "compat_binfmt_elf.c," which directly includ=
es
> > >   "binfmt_elf.c" producing identical function copies in two separate
> > >   modules.
> > >
> > > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carmi=
nati@gmail.com/
> > >
> > > Changes from v3:
> > > * kas_alias was rewritten in Python to create a more concise and
> > >   maintainable codebase.
> > > * The previous automation process used by kas_alias to locate the vml=
inux
> > >   and the addr2line has been replaced with an explicit command-line s=
witch
> > >   for specifying these requirements.
> > > * addr2line has been added into the main Makefile.
> > > * A new command-line switch has been introduced, enabling users to ex=
tend
> > >   the alias to global data names.
> > >
> > > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carmi=
nati@gmail.com/
> > >
> > > Changes from v4:
> > > * Fixed the O=3D<build dir> build issue
> > > * The tool halts execution upon encountering major issues, thereby en=
suring
> > >   the pipeline is interrupted.
> > > * A cmdline option to specify the source directory added.
> > > * Minor code adjusments.
> > > * Tested on mips32 and i386
> > >
> > > https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carmin=
ati@gmail.com/
> > >
> > > Changes from v5:
> > > * Regex filter extended to all symbols
> > > * Alias creation extended to module objects
> > > * Code cleaned and commented
> > > * kas_alias verbose execution via KAS_ALIAS_DEBUG env variable
> > > * CONFIG_KALLSYMS_ALIAS_SRCLINE selects KBUILD_BUILTIN to ensure no r=
aces
> > >   during modules build
> > > * Tested on x86_64, aarch64 and i386
> > >
> > > https://lore.kernel.org/all/20230927173516.1456594-1-alessandro.carmi=
nati@gmail.com/
> > >
> > > Changes from v6:
> > > * Generate a file to facilitate the construction of custom OOT module=
s using aliases.
> > >   In this context, it is needed to export the modules.symbfreq file, =
a product of
> > >   the build.
> > > * Previously, kas_alias was intended to run once, executing all tasks=
 within the same
> > >   session. In this version, two targets have been introduced to split=
 the work into
> > >   distinct phases: one for creating aliases for the core image and an=
other for
> > >   generating aliases for modules.
> > > * The module aliases production statement has been inserted in the
> > >   scripts/Makefile.modfinal. Instead of being executed individually f=
or each module,
> > >   it now runs once for all modules.
> > > * The approach for excluding symbols in .init and .exit ELF sections =
has undergone a
> > >   rewrite.
> > > * kas_alias is now capable of applying aliases to OOT modules. Howeve=
r, for this to
> > >   occur, the 'modules.symbfreq' file needs to be accessible during th=
e build.
> > >   If it is not found, aliases won't be added.
> > >
> > > https://lore.kernel.org/all/20231024201157.748254-1-alessandro.carmin=
ati@gmail.com/
> >
> >
> >
> >
> >
> > I am concerned with your code.
> > At least, I'd like you to understand the Makefile principle.
> >
> >
> >
> >
> >
> > <output>: <input>
> >        <command>
> >
> >
> >
> > The <command> reads <input> and generates <output>.
> >
> > The <command> must not modify <input>.
> >
> >
> > If you deviate from this principle,
> > we will never know where build artifacts are updated.
> >
> >
> >
> >
> > Your code looks like this:
> >
> >
> > %.ko:  %.o %.mod.o
> >         Your script inserts aliases to %.o
> >         Link %.o and %.mod.o into %.ko
> >
> >
> >
> > Your script updates the input file, %.o.
> > This is never acceptable.
> >
> >
> >
>
> I truly appreciate your guidance regarding the Makefile principle. I real=
ize
> now that my self-taught approach overlooked key aspects, particularly the
> importance of not modifying the input file, and I'm committed to aligning=
 my
> code with this principle.
>
> Before I proceed, I seek a better understanding of how the kernel communi=
ty
> aims to address the duplicate symbols issue.
>
> > Anyway, @FILENAME_LINE seems a cheesy workaround after all,
> > and I do not see a good reason to grow the ugliness.
>
> Regarding the FILENAME_LINE implementation, my assumption stemmed from
> notable comments by
>
> Luis Chamberlain
> https://lore.kernel.org/all/ZLVxUQiC5iF+xTPQ@bombadil.infradead.org/
>
> Petr Mladek
> https://lore.kernel.org/all/ZQFtdJEKJ9taYpA0@alley/
>
> within the threads related to my work, but the idea itself originated
> elsewhere: the erlies message I'm aware of, carrying this contents is a
> Petr's message as answer to another thread.
> https://lore.kernel.org/all/ZEeO_rWL4bDh5vui@alley/
>
> If FILENAME_LINE doesn't serve the community's purpose, and my interpreta=
tion
> was mistaken, I apologize for any inconvenience caused and will cease wor=
k on
> this aspect.


There is no common opinion in the community.
It is just that every person has a different thought.



When I use GDB for debugging, the debug info is optional;
even without debug info, I can use minimal functionality;
assembler-level debugging, break-point setting by specifying
an address.

By loading the symbol table, I can have better experiences;
for example, source code debugging, break-point setting by
a function name, etc.




I wonder if we can do something similar for this case.
We can use ftrace/kprobe without CONFIG_DEBUG_INFO.
This covers most use cases because kallsyms records
(address, symbol-name) tuples.

With debug info loaded, every symbol address is associated
with more info such as file name, line number, etc.


In many distributions, the debug info files of vmlinux
and modules are available under /usr/lib/debug/.


Your patch already depends on CONFIG_DEBUG_INFO,
so you have the ones in your build directory at least.

Adding <func>@<filename>_<line> aliases seems a
niche workaround, as this is duplicated data
transformed from what you already have in debug info.




--
Best Regards
Masahiro Yamada

