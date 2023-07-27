Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF37644D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjG0EUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjG0EUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:20:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522682717
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:20:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40540a8a3bbso112631cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690431645; x=1691036445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDWif2m5byX45hQoE5JAyEJ71zmQ4VucYXfmypMa/vo=;
        b=1GmDnVof1by7OkOqsXKi5kTWfXre0qhvCvy41TSaYqUAbifVAUlnihFA5fyX6auBLb
         cNxi+sY7HoUd2HoJvNUjXXXTFPrmDDBL8wARGKgIsf648bWfwQyimPMBn/c8IwS/mFLG
         /fUYC1+1AOCqiyX6uVVbQBT5Ce3LsL5VnaZJWE6pR2GjhVQ8/p65wuG7TcbL8nbOSWSX
         sQbYHh6Os1DIHfnCNT2ZJ4yJezJSTBrCIohwqKXiQ7MyUb4xVZYmdeklVyvTXFlXhKd8
         Dhz941/rnP7Usbs+diM55v8FfO3paxkOJJgIuPwSxzkEwL6U2+TCzwDvZjL22eFtKwMG
         YUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690431645; x=1691036445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDWif2m5byX45hQoE5JAyEJ71zmQ4VucYXfmypMa/vo=;
        b=WDUuRtoBhYeXDU0yF8d/zgLwjh6ohHGci53mCGu7IgpvdNJyK3OssctICFGnZvS0xg
         k8b3EY0Ps638uEg8Y3ZxeYGVdxYeNtFUzeu/nxVO4EEnMEiUTyqcU94HqVXz1gaRPuuP
         e+FSfh2yac0y/b9GAqUlLWaOaUZqLMkxxSmDyfpQ8iYhpJSwL8CcTz1KRRbE0ZhRYGoC
         50SqCn0u1Nl3NvSgWTyRbhlHZmIo9zhu1nPlWolKNw2wBFUJtETbwxjwzqwNSAmHYIEN
         PxzvhLNuoNtLsx6PLaTNbNPRN9OJRIJX6ZCqadfjC/JX1zQ7uv9ieBfX/MyM4bicBrSP
         ZR0Q==
X-Gm-Message-State: ABy/qLYFEuSwVPzAU2URVmSCnnr30ab1fVgZR2GAhjoY5Gghtu3pm0ig
        bKLELBG+1YDq3t3FBonHjWqHWSf3OpGTVheVVc+5aQ==
X-Google-Smtp-Source: APBJJlESVlYW2atLxqn0NY7UiLPLOv7RsTDyF0YF810qXSGs5fHdwCx0fZdt3Qrp/pIYzMlUaBQkjFKAWnW/UuvX5pk=
X-Received: by 2002:a05:622a:190c:b0:403:dcd4:b9b1 with SMTP id
 w12-20020a05622a190c00b00403dcd4b9b1mr148241qtc.18.1690431645325; Wed, 26 Jul
 2023 21:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <ca25b1b3-dc7a-b0bb-dce4-8d11eb343438@gmail.com>
In-Reply-To: <ca25b1b3-dc7a-b0bb-dce4-8d11eb343438@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Jul 2023 21:20:33 -0700
Message-ID: <CAP-5=fX2ar7Pfj9it8pX_ohgC7OzY59iuDFSQTY7Kcnkc3-S5g@mail.gmail.com>
Subject: Re: [perf] Build error when using LTO on 6.4
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Perf <linux-perf-users@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 8:55=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Hi,
>
> I notice a build regression on Bugzilla [1]. Quoting from it:
>
> > Starting with Kernel 6.4, I see a build error when using "-flto" to bui=
ld perf. This used to work fine with earlier Kernels when using either bfd =
or mold as linker when using GCC 13.1.1.

Hmm.. strange I've never seen this work with GCC.

> >
> > This is the PKGBUILD I use as my build recipe: https://github.com/ms178=
/archpkgbuilds/blob/main/packages/bpf/PKGBUILD

If this binary is for distribution BUILD_BPF_SKEL=3D1 should be set. We
need to make this an opt-out rather than opt-in. The last time we did
this there was some friction:
https://lore.kernel.org/lkml/CAHk-=3DwjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5Kc=
pdEQCaA@mail.gmail.com/

> >
> > This is the konsole output I get now with Kernel 6.4.5:
> >
> > [CODE]
> > CFLAGS=3D'-Wno-error=3Dbad-function-cast -Wno-error=3Ddeclaration-after=
-statement -Wno-error=3Dswitch-enum -Wbad-function-cast -Wdeclaration-after=
-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declaration=
s -Wmissing-prototypes -Wno-system-headers -Wold-style-definition -Wpacked =
-Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wunde=
f -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow =
-DHAVE_SYSCALL_TABLE_SUPPORT -DHAVE_ARCH_X86_64_SUPPORT -Iarch/x86/include/=
generated -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -=
Werror -DNDEBUG=3D1 -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wal=
l -Wextra -std=3Dgnu11 -fstack-protector-all -U_FORTIFY_SOURCE -D_FORTIFY_S=
OURCE=3D2 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/t=
mp/makepkg/linux-tools/src/linux/tools/perf/util/include -I/tmp/makepkg/lin=
ux-tools/src/linux/tools/perf/arch/x86/include -I/tmp/makepkg/linux-tools/s=
rc/linux/tools/include/ -I/tmp/makepkg/linux-tools/src/linux/tools/arch/x86=
/include/uapi -I/tmp/makepkg/linux-tools/src/linux/tools/include/uapi -I/tm=
p/makepkg/linux-tools/src/linux/tools/arch/x86/include/ -I/tmp/makepkg/linu=
x-tools/src/linux/tools/arch/x86/ -I/tmp/makepkg/linux-tools/src/linux/tool=
s/perf/util -I/tmp/makepkg/linux-tools/src/linux/tools/perf -DHAVE_PTHREAD_=
ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GE=
T_CURRENT_DIR_NAME -DHAVE_GETTID -DHAVE_FILE_HANDLE -DHAVE_DWARF_GETLOCATIO=
NS_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT -DHAVE_SCHED_GETCPU_=
SUPPORT -DHAVE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SU=
PPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT -DHAVE_D=
EBUGINFOD_SUPPORT -DHAVE_DWARF_SUPPORT  -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PR=
OLOGUE -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAM=
E -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -D=
NO_LIBPERL -DHAVE_TIMERFD_SUPPORT -DHAVE_LIBPYTHON_SUPPORT -DHAVE_CXA_DEMAN=
GLE_SUPPORT -DHAVE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT -DH=
AVE_LIBCAP_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT -DHAVE_K=
VM_STAT_SUPPORT -DDISASM_FOUR_ARGS_SIGNATURE -DDISASM_INIT_STYLED -DHAVE_PE=
RF_READ_VDSO32 -DHAVE_AUXTRACE_SUPPORT -DHAVE_LIBTRACEEVENT -DLIBTRACEEVENT=
_VERSION=3D66813 -I/tmp/makepkg/linux-tools/src/linux/tools/perf/libapi/inc=
lude -I/tmp/makepkg/linux-tools/src/linux/tools/perf/libbpf/include -I/tmp/=
makepkg/linux-tools/src/linux/tools/perf/libsubcmd/include -I/tmp/makepkg/l=
inux-tools/src/linux/tools/perf/libsymbol/include -I/tmp/makepkg/linux-tool=
s/src/linux/tools/perf/libperf/include' LDFLAGS=3D'-Wl,-O3,--as-needed,-Bsy=
mbolic-functions,--sort-common,-flto=3Dauto -fopenmp -fuse-ld=3Dmold -march=
=3Dnative -mtune=3Dnative -maes -mbmi2 -mpclmul -Wl,-zmax-page-size=3D0x200=
000 -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -L/usr/lib ' \
> >   '/usr/bin/python' util/setup.py \
> >   --quiet build_ext; \
> > cp python_ext_build/lib/perf*.so python/
> > rm -f -f /tmp/makepkg/linux-tools/src/linux/tools/perf/libbpf/libbpf.a;=
 ar rcs /tmp/makepkg/linux-tools/src/linux/tools/perf/libbpf/libbpf.a /tmp/=
makepkg/linux-tools/src/linux/tools/perf/libbpf/staticobjs/libbpf-in.o
> > [snip]
> > gcc -Wno-error=3Dbad-function-cast -Wno-error=3Ddeclaration-after-state=
ment -Wno-error=3Dswitch-enum -Wbad-function-cast -Wdeclaration-after-state=
ment -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmi=
ssing-prototypes -Wno-system-headers -Wold-style-definition -Wpacked -Wredu=
ndant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwr=
ite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -DHAVE=
_SYSCALL_TABLE_SUPPORT -DHAVE_ARCH_X86_64_SUPPORT -Iarch/x86/include/genera=
ted -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror=
 -DNDEBUG=3D1 -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -Wex=
tra -std=3Dgnu11 -fstack-protector-all -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=
=3D2 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/tmp/ma=
kepkg/linux-tools/src/linux/tools/perf/util/include -I/tmp/makepkg/linux-to=
ols/src/linux/tools/perf/arch/x86/include -I/tmp/makepkg/linux-tools/src/li=
nux/tools/include/ -I/tmp/makepkg/linux-tools/src/linux/tools/arch/x86/incl=
ude/uapi -I/tmp/makepkg/linux-tools/src/linux/tools/include/uapi -I/tmp/mak=
epkg/linux-tools/src/linux/tools/arch/x86/include/ -I/tmp/makepkg/linux-too=
ls/src/linux/tools/arch/x86/ -I/tmp/makepkg/linux-tools/src/linux/tools/per=
f/util -I/tmp/makepkg/linux-tools/src/linux/tools/perf -DHAVE_PTHREAD_ATTR_=
SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT -DHAVE_GET_CUR=
RENT_DIR_NAME -DHAVE_GETTID -DHAVE_FILE_HANDLE -DHAVE_DWARF_GETLOCATIONS_SU=
PPORT -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT -DHAVE_SCHED_GETCPU_SUPPO=
RT -DHAVE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT=
 -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT -DHAVE_DEBUGI=
NFOD_SUPPORT -DHAVE_DWARF_SUPPORT  -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGU=
E -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME -DH=
AVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -DNO_LI=
BPERL -DHAVE_TIMERFD_SUPPORT -DHAVE_LIBPYTHON_SUPPORT -DHAVE_CXA_DEMANGLE_S=
UPPORT -DHAVE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT -DHAVE_L=
IBCAP_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT -DHAVE_KVM_ST=
AT_SUPPORT -DDISASM_FOUR_ARGS_SIGNATURE -DDISASM_INIT_STYLED -DHAVE_PERF_RE=
AD_VDSO32 -DHAVE_AUXTRACE_SUPPORT -DHAVE_LIBTRACEEVENT -DLIBTRACEEVENT_VERS=
ION=3D66813 -I/tmp/makepkg/linux-tools/src/linux/tools/perf/libapi/include =
-I/tmp/makepkg/linux-tools/src/linux/tools/perf/libbpf/include -I/tmp/makep=
kg/linux-tools/src/linux/tools/perf/libsubcmd/include -I/tmp/makepkg/linux-=
tools/src/linux/tools/perf/libsymbol/include -I/tmp/makepkg/linux-tools/src=
/linux/tools/perf/libperf/include -Wl,-O3,--as-needed,-Bsymbolic-functions,=
--sort-common,-flto=3Dauto -fopenmp -fuse-ld=3Dmold -march=3Dnative -mtune=
=3Dnative -maes -mbmi2 -mpclmul -Wl,-zmax-page-size=3D0x200000 -Wl,-z,noexe=
cstack  -lunwind-x86_64 -lunwind -llzma  -L/usr/lib  \
> >         perf-in.o pmu-events/pmu-events-in.o -Wl,--whole-archive /tmp/m=
akepkg/linux-tools/src/linux/tools/perf/libapi/libapi.a /tmp/makepkg/linux-=
tools/src/linux/tools/perf/libperf/libperf.a /tmp/makepkg/linux-tools/src/l=
inux/tools/perf/libsubcmd/libsubcmd.a /tmp/makepkg/linux-tools/src/linux/to=
ols/perf/libsymbol/libsymbol.a /tmp/makepkg/linux-tools/src/linux/tools/per=
f/libbpf/libbpf.a  -Wl,--no-whole-archive -Wl,--start-group -lpthread -lrt =
-lm -ldl -lelf -ldebuginfod -ldw -lunwind-x86_64 -lunwind -llzma -lcrypto -=
lslang -lpython3.11 -ldl -lm -lutil -lstdc++ -lz -llzma -lzstd -lcap -lnuma=
 -ltraceevent -Wl,--end-group -o perf
> > mold: error: undefined symbol: main
>
> >>>> referenced by /usr/lib/Scrt1.o:(.text)
> >>>>               /usr/lib/Scrt1.o:(_start)
> > mold: error: undefined symbol: perf_pmu__getcpuid
> >>>> referenced by pmu-events.c
> >>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_events_tabl=
e)>>>
> >>>>               referenced by pmu-events.c
> >>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_metrics_tab=
le)
> > mold: error: undefined symbol: strcmp_cpuid_str
> >>>> referenced by pmu-events.c
> >>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_events_tabl=
e)>>>
> >>>>               referenced by pmu-events.c
> >>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_metrics_tab=
le)>>>
> >>>>               referenced by pmu-events.c
> >>>>               pmu-events/pmu-events-in.o:(find_core_events_table)>>>
> >>>>               referenced 1 more times
> >
> > mold: error: undefined symbol: _ctype
> >>>> referenced by kallsyms.c
> >>>>
> >>>>               /tmp/makepkg/linux-tools/src/linux/tools/perf/libsymbo=
l/libsymbol.a(libsymbol-in.o):(__tolower)>>>
> >>>>               referenced by kallsyms.c
> >>>>
> >>>>               /tmp/makepkg/linux-tools/src/linux/tools/perf/libsymbo=
l/libsymbol.a(libsymbol-in.o):(__toupper)
> > mold: error: undefined symbol: strlcpy
> >>>> referenced by exec-cmd.c
> >>>>
> >>>>               /tmp/makepkg/linux-tools/src/linux/tools/perf/libsubcm=
d/libsubcmd.a(libsubcmd-in.o):(get_pwd_cwd)
> > [/CODE]
> >
> > I have noticed a patch series of Ian Rodgers that might adress this iss=
ue, but his reported errors were different to mine, see: https://www.spinic=
s.net/lists/kernel/msg4872566.html
> >
> > Compiler: gcc-version 13.1.1 20230714 (GCC)
>
> See Bugzilla for the full thread.
>
> Anyway, I'm adding this regression to regzbot:
>
> #regzbot introduced: v6.3..v6.4.5 https://bugzilla.kernel.org/show_bug.cg=
i?id=3D217706

Thanks, I'm not sure there is anything actionable for the bug.
clang/llvm has always worked with LTO at Google. With my changes gcc
works for me with some non-zero effort.

Thanks,
Ian

> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217706
>
> --
> An old man doll... just what I always wanted! - Clara
