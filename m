Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A877F0B32
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjKTEBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:01:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543E9C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:00:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C527C433C8;
        Mon, 20 Nov 2023 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700452856;
        bh=PpTK8auIEQZVOONBIzA9dERSXkViO2NVQHipJce4ncw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tH+sazeUqKEpwwa3rYnbqoDtZjO2KgEqzGY/4e+X77qw3r25D+E8j2n++MrD70cgn
         6lXI/KLfk5yL47ct4McvQT9doVlZmX3cTNod4gFD3kSyoq6CtvyMJ//F7i5n0TY1UE
         yqvBw11oSGOxPaI75D1g8k5kVhAZ0wCdLboGAfQ9m1P4Mqqy4nHdu3XLXaEcxrQhM+
         +1IztyQONClWwyBNG+mt4DewlDuhBckDe853kOwU2ocRhrFdC91IOO79PIl4YxVp01
         Vmaewo7HQ3UQ0OiEFoHMvHJWIDYe9JrgaE0KND+tyXZopSPGsKGYoBXsb4lSSi+Amd
         Sg3RoTf7DWbIg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so2460475fac.0;
        Sun, 19 Nov 2023 20:00:56 -0800 (PST)
X-Gm-Message-State: AOJu0YwN94572U8oP+KQH1cdGWnmBjATE9BF+7way9YJtjUlnhHhmiLO
        7VXfbWloCLIPl6hX9AorX0kKt+DmDXSZqYKty1M=
X-Google-Smtp-Source: AGHT+IG8TO2n6fdh27OxQ8PTGhWWZGY41vFUC71Hvk9PyNDD/GUuuF2k0nVAIERn1IIglF3ITO4Qx91oSlV6NLMaogA=
X-Received: by 2002:a05:6870:c1d2:b0:1e9:8b78:899c with SMTP id
 i18-20020a056870c1d200b001e98b78899cmr8484469oad.55.1700452855421; Sun, 19
 Nov 2023 20:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20231115004932.650702-1-ak@linux.intel.com> <CAK7LNASS1YWdqW5TUXQ0iC3vgoDbUf-M-cRX0BvrkOV8HPyjxg@mail.gmail.com>
In-Reply-To: <CAK7LNASS1YWdqW5TUXQ0iC3vgoDbUf-M-cRX0BvrkOV8HPyjxg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Nov 2023 13:00:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAp3kGDXmHyhwAtYhkCrqG0s4eXvfkxXyK1gg+0sO63A@mail.gmail.com>
Message-ID: <CAK7LNASAp3kGDXmHyhwAtYhkCrqG0s4eXvfkxXyK1gg+0sO63A@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Add inline-account tool
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 1:32=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Nov 15, 2023 at 9:49=E2=80=AFAM Andi Kleen <ak@linux.intel.com> w=
rote:
>
>
> This is a standalone script, which is unrelated to kbuild.
>
> Please change the subject to
>
> "scripts: Add inline-account tool"
>
>
>
>
>
> >
> > A common cause of binary code bloat is excessive inlining. Traditional
> > tools (like nm --size-sort -t d) don't address that directly because
> > they only see the final functions, but don't know about inlines.
> >
> > This patch adds inline-account that makes it easy to track that down
> > by accounting code bytes to all functions visible in the debug informat=
ion,
> > as well as code lines.
> >
> > Here are some examples:
> >
> > Show all inlines that increase code size by >1K in the core scheduler:
> >
> > $ inline-account.py --min-bytes=3D1000 kernel/sched/core.o
> > Total code bytes seen 75690
> >
> > Code bytes by functions:
> > Function                                           Total          Avg  =
 Num
> > rq_pin_lock                                        1401  (0.02%)  35   =
 39
> > __sched_setscheduler                               1277  (0.02%)  41   =
 31
> > perf_fetch_caller_regs                             1012  (0.01%)  17   =
 58
> >
> > Code bytes by nearby source line blocks:
> > prefix /home/ak/lsrc/git/linux/
> > Line                                               Total
> > kernel/sched/sched.h:1610                          1387  (0.02%)
> > include/trace/events/sched.h:16                    1172  (0.02%)
> > include/trace/events/sched.h:222                   1058  (0.01%)
> >
> > This indicates that rq_pin_lock should likely be not inline,
> > and perhaps perf_fetch_caller_regs not either.
> >
> > Note that not all large inlines are necessary bloat. If there is only
>
>
> necessarily bloat?
>
>
>
>
>
>
>
>
>
> > a single call site it isn't bloat (the tool currently cannot distinguis=
h
> > that case). For example it is commonly seen with syscall definitions
> > that use single large inlines with only a single caller. In the example
> > above I think it's the case with __sched_setscheduler.
> >
> > Show the >1K inlines in lib/maple_tree.o, which for some reason
> > comes in at a incredible 73k of code size:
> >
> > $ inline-account.py --min-bytes 1000 lib/maple_tree.o
> > Total code bytes seen 73578
> >
> > Code bytes by functions:
> > Function                                           Total          Avg  =
 Num
> > mas_mab_cp                                         5537  (0.08%)  37   =
 149
> > mas_pop_node                                       3798  (0.05%)  28   =
 131
> > ma_slots                                           2368  (0.03%)  14   =
 162
> > ma_pivots                                          2353  (0.03%)  10   =
 222
> > mas_destroy_rebalance                              2056  (0.03%)  42   =
 48
> > mas_start                                          1661  (0.02%)  13   =
 125
> > mas_set_parent                                     1454  (0.02%)  20   =
 72
> > mas_set_alloc_req                                  1410  (0.02%)  17   =
 80
> > mte_node_type                                      1360  (0.02%)  5    =
 228
> > mas_data_end                                       1189  (0.02%)  16   =
 74
> > mte_to_node                                        1085  (0.01%)  3    =
 276
> > mas_split                                          1053  (0.01%)  65   =
 16
> > mas_topiary_replace                                1033  (0.01%)  38   =
 27
> > mas_root_expand                                    1001  (0.01%)  35   =
 28
> >
> > Code bytes by nearby source line blocks:
> > prefix /home/ak/lsrc/git/linux/
> > Line                                               Total
> > lib/maple_tree.c:210                               1360  (0.02%)
> > include/trace/events/maple_tree.h:80               1283  (0.02%)
> > lib/maple_tree.c:649                               1193  (0.02%)
> > lib/maple_tree.c:288                               1097  (0.01%)
> >
> > It's clear there is a lot of potential for shrinking here, as a quick
> > experiment shows:
> >
> > $ size lib/maple_tree.o
> >    text    data     bss     dec     hex filename
> >   72257    5312       8   77577   12f09 lib/maple_tree.o
> > $ sed -i -e s/__always_inline// -e 's/ inline/ /' lib/maple_tree.c
> > $ make -s lib/maple_tree.o
> > $ size lib/maple_tree.o
> >    text    data     bss     dec     hex filename
> >   47774    4720       8   52502    cd16 lib/maple_tree.o
> >
> > 34% reduction just from trusting the compiler. Most of it seems
> > to come from abuse of __always_inline. I suppose a large scale
> > tree purge of that would give some decent binary size results.
> >
> > $ inline-account.py --show=3D5 kernel/workqueue.o
> > Total code bytes seen 40403
> >
> > Code bytes by functions:
> > Function                                           Total          Avg  =
 Num
> > bitmap_copy                                        1477  (0.04%)  26   =
 56
> > show_pwq                                           912   (0.02%)  76   =
 12
> > workqueue_init_early                               846   (0.02%)  29   =
 29
> > __flush_workqueue                                  753   (0.02%)  31   =
 24
> > alloc_and_link_pwqs                                558   (0.01%)  69   =
 8
> >
> > Code bytes by nearby source line blocks:
> > prefix /home/ak/lsrc/git/linux/
> > Line                                               Total
> > include/linux/bitmap.h:268                         1336  (0.03%)
> > include/trace/events/workqueue.h:23                1038  (0.03%)
> > include/trace/events/workqueue.h:108               732   (0.02%)
> > include/trace/events/workqueue.h:59                694   (0.02%)
> > include/trace/events/workqueue.h:82                670   (0.02%)
> > $
> >
> > This is an interesting case because bitmap_copy is just
> >
> > static inline void bitmap_copy(unsigned long *dst, const unsigned long =
*src,
> >                         unsigned int nbits)
> > {
> >         unsigned int len =3D BITS_TO_LONGS(nbits) * sizeof(unsigned lon=
g);
> >
> >         if (small_const_nbits(nbits))
> >                 *dst =3D *src;
> >         else
> >                 memcpy(dst, src, len);
> > }
> >
> > memcpy (which is a macro) must sometimes generate a lot of
> > code. The small_const_nbits case definitely should be inlined though
> > because it's likely even smaller than a call. Would need
> > more investigation.
> >
> > The other large inlines are trace points. Perhaps there is something
> > there that could be done to shrink that a bit.
> >
> > Finally we can do a global accounting (currently with multiple runs):
> >
> > (ignore the percentage numbers since they are just for the local file)
> >
> > $ find -name '*.o' | xargs -n1 inline-account.py > a
> > $ sort -n -r -k 2 a | head -30
> > ZSTD_count                                         81799 (0.19%)  32   =
 2514
> > ZSTD_count                                         52233 (0.25%)  33   =
 1544
> > kmalloc                                            43324 (0.00%)  12   =
 3334
> > pv_queued_spin_unlock                              42027 (0.00%)  9    =
 4580
> > constant_test_bit                                  41667 (0.00%)  5    =
 8005
> > arch/x86/include/asm/paravirt.h:591                41044 (0.00%)
> > arch/x86/include/asm/bitops.h:207                  40153 (0.00%)
> > __refcount_add                                     37968 (0.00%)  24   =
 1532
> > page_fixed_fake_head                               36368 (0.00%)  19   =
 1832
> > include/linux/slab.h:599                           35654 (0.00%)
> > arch/x86/include/asm/jump_label.h:27               35156 (0.00%)
> > spin_lock                                          32170 (0.00%)  10   =
 3007
> > __refcount_sub_and_test                            32068 (0.00%)  17   =
 1842
> > include/linux/spinlock.h:351                       31102 (0.00%)
> > arch_static_branch                                 30874 (0.00%)  4    =
 7022
> > get_current                                        30714 (0.00%)  9    =
 3351
> > arch/x86/include/asm/current.h:41                  29912 (0.00%)
> > trace_trigger_soft_disabled                        29814 (0.00%)  21   =
 1368
> > perf_fetch_caller_regs                             27504 (0.00%)  16   =
 1634
> > ZSTD_storeSeq                                      26060 (0.06%)  30   =
 862
> > hid_map_usage                                      25582 (0.00%)  88   =
 288
> > ZSTD_compressBlock_lazy_generic                    24953 (0.12%)  46   =
 535
> > ZSTD_compressBlock_lazy_generic                    24953 (0.06%)  46   =
 535
> > paravirt_ret0                                      24152 (0.00%)  24152=
 1
> > spin_unlock_irqrestore                             23253 (0.00%)  10   =
 2281
> > include/linux/spinlock.h:406                       22526 (0.00%)
> > ZSTD_RowFindBestMatch                              21527 (0.10%)  23   =
 922
> > ZSTD_RowFindBestMatch                              21527 (0.05%)  23   =
 922
> > __list_add                                         21209 (0.00%)  11   =
 1851
> > include/linux/refcount.h:283                       20642 (0.00%)
> >
> > - So my kernel is spending around ~30K just for getting task_structs in
> > current.
> > - I'm sure ZSTD is great, but is it >200K in duplicated code worth grea=
t?
> > - page_fixed_fake_head probably shouldn't be inlined
> > - There might be some potential in out lining reference counts
> > (although that one might be truly performance critical)
> > - There's maybe some potential in shrinking trace point bloat?
> >
> > ... and more similar insights.
> >
> > Also of course there can be critical inlines that really need
> > to be inline in many sites for best performance. But that's rarely the =
case
> > if they are big because it's unlikely the small call overhead is making
> > a significant difference for a large chunk of code.
> >
> > In any case the tool is useful, so I think it deserves its place
> > in scripts/
> >
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >
> > ---
> >
> > v2: Address review comments. Change balancing to be address based.
> > Add option to set objdump binary.
> > ---
> >  scripts/inline-account.py | 201 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 201 insertions(+)
> >  create mode 100755 scripts/inline-account.py
> >
> > diff --git a/scripts/inline-account.py b/scripts/inline-account.py
> > new file mode 100755
> > index 000000000000..c32cb0547172
> > --- /dev/null
> > +++ b/scripts/inline-account.py
> > @@ -0,0 +1,201 @@
> > +#!/usr/bin/env python3
> > +# account code bytes per source code / functions from objdump -Sl outp=
ut
> > +# useful to find inline bloat
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-only
>
>
> Please move this above.
>
> The first line is the shebang.
> The second line is SPDX.
>
>
>
>
>
> > +# Author: Andi Kleen
> > +
> > +import os
> > +import sys
> > +import re
> > +import argparse
> > +import bisect
> > +import multiprocessing
>
>
> Please sort imports alphabetically.
>
>
>
> > +from collections import Counter
> > +from functools import reduce, partial
> > +
> > +def get_args():
> > +    p =3D argparse.ArgumentParser(
> > +            description=3D"""
> > +Account code bytes per source code / functions from objdump.
> > +Useful to find inline bloat.
> > +
> > +The line numbers are the beginning of a block, so the actual code can =
be later.
> > +Line numbers can be a also little off due to objdump bugs
> > +also some misaccounting can happen due to inexact gcc debug informatio=
n.
> > +The number output for functions may account a single large function mu=
ltiple
> > +times.  program/object files need to be built with -g.
> > +
> > +This is somewhat slow due to objdump -S being slow. It helps to have
> > +plenty of cores.""")
> > +    p.add_argument('--min-bytes', type=3Dint, help=3D'minimum bytes to=
 report', default=3D100)
> > +    p.add_argument('--threads', '-t', type=3Dint, default=3Dmultiproce=
ssing.cpu_count(),
>
>
> Please check that args.threads >=3D 1.
>
> If not, please show an error message.
>
>
>
>
>
> > +                   help=3D'Number of objdump processes to run')
> > +    p.add_argument('--verbose', '-v', action=3D'store_true', help=3D"P=
rint more")
> > +    p.add_argument('--show', type=3Dint, help=3D'Number of results to =
show')
> > +    p.add_argument('--objdump', default=3D"objdump", help=3D"Set objdu=
mp binary to run")
> > +    p.add_argument('file', help=3D'object file/program as input')
> > +    return p.parse_args()
> > +
> > +def get_syms(fn):
> > +    syms =3D []
> > +    pc =3D None
> > +    with os.popen("nm -n --print-size " + fn) as f:
> > +        for l in f:
> > +            n =3D l.split()
> > +            if len(n) > 2 and n[2].upper() =3D=3D "T":
> > +                pc =3D int(n[0], 16)
> > +                syms.append(pc)
> > +                ln =3D int(n[1], 16)
> > +    if not pc:
> > +        sys.exit(fn + " has no symbols")
>
>
> "if not pc" becomes true in two cases:
>  - pc is zero
>  - pc is None
>
>
> Only the latter case is "no symbols" because
> a symbol address may become zero in relocatable ELF.
>
>
>
> if len(syms) =3D=3D 0:
>      ...
>
> will work correctly.
>
> And, "pc =3D None" is unneeded.
>
>
>
>
>
>
>
>
> > +    syms.append(pc + ln)
> > +    return syms
> > +
> > +class Account:
> > +    def __init__(self):
> > +        self.funcbytes =3D Counter()
> > +        self.linebytes =3D Counter()
> > +        self.funccount =3D Counter()
> > +        self.nolinebytes =3D 0
> > +        self.nofuncbytes =3D 0
> > +        self.total =3D 0
> > +
> > +    def add(self, b):
> > +        self.funcbytes +=3D b.funcbytes
> > +        self.linebytes +=3D b.linebytes
> > +        self.funccount +=3D b.funccount
> > +        self.nolinebytes +=3D b.nolinebytes
> > +        self.nofuncbytes +=3D b.nofuncbytes
> > +        self.total +=3D b.total
> > +        return self
> > +
>
>
> Since this script implements a class,
> please follow this blank line rule.
>
>
> https://peps.python.org/pep-0008/#blank-lines
>
>
>
>
>
>
>
>
>
> > +# dont add sys.exit here, causes deadlocks
> > +def account_range(args, r):
> > +    a =3D Account()
> > +    line =3D None
> > +    func =3D None
> > +    codefunc =3D None
> > +
> > +    cmd =3D ("%s -Sl %s --start-address=3D%#x --stop-address=3D%#x" %
> > +                (args.objdump, args.file, r[0], r[1]))
> > +    if args.verbose:
> > +        print(cmd)
> > +    with os.popen(cmd) as f:
> > +        for l in f:
> > +            #      250:       e8 00 00 00 00          callq  255 <proc=
_skip_spaces+0x5>
> > +            m =3D re.match(r'\s*([0-9a-fA-F]+):\s+(.*)', l)
> > +            if m:
> > +                bytes =3D len(re.findall(r'[0-9a-f][0-9a-f] ', m.group=
(2)))
> > +                if not func:
> > +                    a.nofuncbytes +=3D bytes
> > +                    continue
> > +                if not line:
> > +                    a.nolinebytes +=3D bytes
> > +                    continue
> > +                a.total +=3D bytes
> > +                a.funcbytes[func] +=3D bytes
> > +                a.linebytes[(file, line)] +=3D bytes
> > +                codefunc =3D func
> > +                continue
> > +
> > +            # sysctl_init():
> > +            m =3D re.match(r'([a-zA-Z_][a-zA-Z0-9_]*)\(\):$', l)
> > +            if m:
> > +                if codefunc and m.group(1) !=3D codefunc:
> > +                    a.funccount[codefunc] +=3D 1
> > +                    codefunc =3D None
> > +                func =3D m.group(1)
> > +                continue
> > +
> > +            # /sysctl.c:1666
> > +            m =3D re.match(r'^([^:]+):(\d+)$', l)
> > +            if m:
> > +                file, line =3D m.group(1), int(m.group(2))
> > +                continue
> > +
> > +    if codefunc:
> > +        a.funccount[codefunc] +=3D 1
> > +    return a
> > +
> > +def get_boundaries(syms, sym_sizes, chunk):
> > +    run =3D 0
> > +    boundaries =3D [syms[0]]
> > +    for i, x in enumerate(sym_sizes):
> > +        run +=3D x
> > +        if run >=3D chunk:
> > +            boundaries.append(syms[i])
> > +            run =3D 0
> > +    boundaries.append(syms[-1])
> > +    return boundaries
> > +
> > +
> > +def process(args):
> > +    # objdump -S is slow, so we parallelize
> > +
> > +    # split symbol table into chunks for parallelization
> > +    # we split on functions boundaries to avoid mis-accounting
> > +    syms =3D get_syms(args.file)
> > +    if len(syms) < 2:
> > +        print("not enough symbols")
> > +        return
>
> This message should go to stderr instead of stdout.
>
>
>    sys.exit("not enough symbols")
>


Or, you can remove this check entirely if you
check the length in get_syms().


get_syms() requires at least one element from the loop,
and append() one more at the end.
So, get_syms() always has two or more elements.








--=20
Best Regards
Masahiro Yamada
