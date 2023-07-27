Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E37644A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjG0D4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjG0Dz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:55:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D02717;
        Wed, 26 Jul 2023 20:55:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26830595676so393775a91.2;
        Wed, 26 Jul 2023 20:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690430138; x=1691034938;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKPwval4JwVixs6vHq6OS1R7adXBXZhv/zbbiXcVS3s=;
        b=KwdMrCh5/NHrZj7oM+yLpwO/bAqoP94blQR3KpRENtentCqcBXUMMN4nHXxX6M7xV1
         ShnEwz3guiaFo9p13XwlXpjYbpi24DYGqDHn1SBOwzNUbJ2LjcGFCX2xZ7VSmlQujloW
         lIDVTbVJkdHGCrbOOzFFfitmXILjW102OkmjPNDR1FhK2AzgeUhtHMB6i/K4svKvUTlC
         JHucPNgI6ilcti4+217wDiMAmOPPWzwVZj0s2xlNVY+dMlx8JyXoa85JaeeTQYWjAFHh
         /LWgA4KDUiTCPgX6dGWSqxgQxpsFhDTwX29BDJn82V6rNR0amygj6IxgzBgPNxh5UUjJ
         lObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690430138; x=1691034938;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKPwval4JwVixs6vHq6OS1R7adXBXZhv/zbbiXcVS3s=;
        b=N+kUsyXNdJuUypUb/fwym6A4lTp4f4AOenpQZoO1OI5RSxcsJ/LUra3rB5hbHuNeLS
         hq3+fe7BiaaKZ9WWR6bPXNfnUKPKfHPXXv13bF1ZwkTwmCOXhKbbXaishnTkBvDjReP3
         gVl0wo2T7TFIDpedd4tZKJ70eAFb6wABKxcHAAJ023A3QqKzj7zApgyrHNiYKIIQZ9sW
         dzCvSzFpwv0d/WflaIssF6MjUpqkvBDthUqIk4/7AiBwxQ1ICvl1x5lelfTX1KWefqEQ
         xJYwr2Ia86kM6waw2cx1qpNFRtHsumHC5hOx37xrl978r0g65aUGd9k+phw/HqT6DBHR
         w2Bg==
X-Gm-Message-State: ABy/qLb/oHi23N5swHTjPNOlrmulgXbrxRSJWncakGPIXjqO47v/aCDW
        M6AOImpBDKVyr6vg5rdxYkc=
X-Google-Smtp-Source: APBJJlHssE1XTjk/Q8JN26scij/JN2XiZcd3xIP7S+0tX3vDtFcfraHefoPLwW8QEN/Qn4FpB6Hxhw==
X-Received: by 2002:a17:90a:7047:b0:263:4164:dfba with SMTP id f65-20020a17090a704700b002634164dfbamr3482072pjk.6.1690430138285;
        Wed, 26 Jul 2023 20:55:38 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902ea9300b001bba669a7eesm365951plb.52.2023.07.26.20.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 20:55:25 -0700 (PDT)
Message-ID: <ca25b1b3-dc7a-b0bb-dce4-8d11eb343438@gmail.com>
Date:   Thu, 27 Jul 2023 10:55:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Perf <linux-perf-users@vger.kernel.org>
Subject: Fwd: [perf] Build error when using LTO on 6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a build regression on Bugzilla [1]. Quoting from it:

> Starting with Kernel 6.4, I see a build error when using "-flto" to bui=
ld perf. This used to work fine with earlier Kernels when using either bf=
d or mold as linker when using GCC 13.1.1.
>=20
> This is the PKGBUILD I use as my build recipe: https://github.com/ms178=
/archpkgbuilds/blob/main/packages/bpf/PKGBUILD
>=20
> This is the konsole output I get now with Kernel 6.4.5:
>=20
> [CODE]
> CFLAGS=3D'-Wno-error=3Dbad-function-cast -Wno-error=3Ddeclaration-after=
-statement -Wno-error=3Dswitch-enum -Wbad-function-cast -Wdeclaration-aft=
er-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declara=
tions -Wmissing-prototypes -Wno-system-headers -Wold-style-definition -Wp=
acked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enu=
m -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3=
 -Wshadow -DHAVE_SYSCALL_TABLE_SUPPORT -DHAVE_ARCH_X86_64_SUPPORT -Iarch/=
x86/include/generated -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REG=
ISTER_OFFSET -Werror -DNDEBUG=3D1 -O6 -fno-omit-frame-pointer -ggdb3 -fun=
wind-tables -Wall -Wextra -std=3Dgnu11 -fstack-protector-all -U_FORTIFY_S=
OURCE -D_FORTIFY_SOURCE=3D2 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D6=
4 -D_GNU_SOURCE -I/tmp/makepkg/linux-tools/src/linux/tools/perf/util/incl=
ude -I/tmp/makepkg/linux-tools/src/linux/tools/perf/arch/x86/include -I/t=
mp/makepkg/linux-tools/src/linux/tools/include/ -I/tmp/makepkg/linux-tool=
s/src/linux/tools/arch/x86/include/uapi -I/tmp/makepkg/linux-tools/src/li=
nux/tools/include/uapi -I/tmp/makepkg/linux-tools/src/linux/tools/arch/x8=
6/include/ -I/tmp/makepkg/linux-tools/src/linux/tools/arch/x86/ -I/tmp/ma=
kepkg/linux-tools/src/linux/tools/perf/util -I/tmp/makepkg/linux-tools/sr=
c/linux/tools/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARR=
IER -DHAVE_EVENTFD_SUPPORT -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_GETTID -DHA=
VE_FILE_HANDLE -DHAVE_DWARF_GETLOCATIONS_SUPPORT -DHAVE_AIO_SUPPORT -DHAV=
E_SCANDIRAT_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHA=
VE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPO=
RT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_DWAR=
F_SUPPORT  -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_JITDUMP -DHAV=
E_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME -DHAVE_LIBUNWIND_SUPPOR=
T -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -DNO_LIBPERL -DHAVE_TIMER=
FD_SUPPORT -DHAVE_LIBPYTHON_SUPPORT -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_ZL=
IB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT -DHAVE_LIBCAP_SUPPORT =
-DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT -DHAVE_KVM_STAT_SUPPORT -=
DDISASM_FOUR_ARGS_SIGNATURE -DDISASM_INIT_STYLED -DHAVE_PERF_READ_VDSO32 =
-DHAVE_AUXTRACE_SUPPORT -DHAVE_LIBTRACEEVENT -DLIBTRACEEVENT_VERSION=3D66=
813 -I/tmp/makepkg/linux-tools/src/linux/tools/perf/libapi/include -I/tmp=
/makepkg/linux-tools/src/linux/tools/perf/libbpf/include -I/tmp/makepkg/l=
inux-tools/src/linux/tools/perf/libsubcmd/include -I/tmp/makepkg/linux-to=
ols/src/linux/tools/perf/libsymbol/include -I/tmp/makepkg/linux-tools/src=
/linux/tools/perf/libperf/include' LDFLAGS=3D'-Wl,-O3,--as-needed,-Bsymbo=
lic-functions,--sort-common,-flto=3Dauto -fopenmp -fuse-ld=3Dmold -march=3D=
native -mtune=3Dnative -maes -mbmi2 -mpclmul -Wl,-zmax-page-size=3D0x2000=
00 -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -L/usr/lib ' \
>   '/usr/bin/python' util/setup.py \
>   --quiet build_ext; \
> cp python_ext_build/lib/perf*.so python/
> rm -f -f /tmp/makepkg/linux-tools/src/linux/tools/perf/libbpf/libbpf.a;=
 ar rcs /tmp/makepkg/linux-tools/src/linux/tools/perf/libbpf/libbpf.a /tm=
p/makepkg/linux-tools/src/linux/tools/perf/libbpf/staticobjs/libbpf-in.o
> [snip]
> gcc -Wno-error=3Dbad-function-cast -Wno-error=3Ddeclaration-after-state=
ment -Wno-error=3Dswitch-enum -Wbad-function-cast -Wdeclaration-after-sta=
tement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations =
-Wmissing-prototypes -Wno-system-headers -Wold-style-definition -Wpacked =
-Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wun=
def -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -Wsha=
dow -DHAVE_SYSCALL_TABLE_SUPPORT -DHAVE_ARCH_X86_64_SUPPORT -Iarch/x86/in=
clude/generated -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTER_=
OFFSET -Werror -DNDEBUG=3D1 -O6 -fno-omit-frame-pointer -ggdb3 -funwind-t=
ables -Wall -Wextra -std=3Dgnu11 -fstack-protector-all -U_FORTIFY_SOURCE =
-D_FORTIFY_SOURCE=3D2 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_G=
NU_SOURCE -I/tmp/makepkg/linux-tools/src/linux/tools/perf/util/include -I=
/tmp/makepkg/linux-tools/src/linux/tools/perf/arch/x86/include -I/tmp/mak=
epkg/linux-tools/src/linux/tools/include/ -I/tmp/makepkg/linux-tools/src/=
linux/tools/arch/x86/include/uapi -I/tmp/makepkg/linux-tools/src/linux/to=
ols/include/uapi -I/tmp/makepkg/linux-tools/src/linux/tools/arch/x86/incl=
ude/ -I/tmp/makepkg/linux-tools/src/linux/tools/arch/x86/ -I/tmp/makepkg/=
linux-tools/src/linux/tools/perf/util -I/tmp/makepkg/linux-tools/src/linu=
x/tools/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -D=
HAVE_EVENTFD_SUPPORT -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_GETTID -DHAVE_FIL=
E_HANDLE -DHAVE_DWARF_GETLOCATIONS_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCAN=
DIRAT_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DHAVE_LIB=
ELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DH=
AVE_ELF_GETSHDRSTRNDX_SUPPORT -DHAVE_DEBUGINFOD_SUPPORT -DHAVE_DWARF_SUPP=
ORT  -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_JITDUMP -DHAVE_DWAR=
F_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME -DHAVE_LIBUNWIND_SUPPORT -DHA=
VE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -DNO_LIBPERL -DHAVE_TIMERFD_SUP=
PORT -DHAVE_LIBPYTHON_SUPPORT -DHAVE_CXA_DEMANGLE_SUPPORT -DHAVE_ZLIB_SUP=
PORT -DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT -DHAVE_LIBCAP_SUPPORT -DHAVE=
_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT -DHAVE_KVM_STAT_SUPPORT -DDISAS=
M_FOUR_ARGS_SIGNATURE -DDISASM_INIT_STYLED -DHAVE_PERF_READ_VDSO32 -DHAVE=
_AUXTRACE_SUPPORT -DHAVE_LIBTRACEEVENT -DLIBTRACEEVENT_VERSION=3D66813 -I=
/tmp/makepkg/linux-tools/src/linux/tools/perf/libapi/include -I/tmp/makep=
kg/linux-tools/src/linux/tools/perf/libbpf/include -I/tmp/makepkg/linux-t=
ools/src/linux/tools/perf/libsubcmd/include -I/tmp/makepkg/linux-tools/sr=
c/linux/tools/perf/libsymbol/include -I/tmp/makepkg/linux-tools/src/linux=
/tools/perf/libperf/include -Wl,-O3,--as-needed,-Bsymbolic-functions,--so=
rt-common,-flto=3Dauto -fopenmp -fuse-ld=3Dmold -march=3Dnative -mtune=3D=
native -maes -mbmi2 -mpclmul -Wl,-zmax-page-size=3D0x200000 -Wl,-z,noexec=
stack  -lunwind-x86_64 -lunwind -llzma  -L/usr/lib  \
>         perf-in.o pmu-events/pmu-events-in.o -Wl,--whole-archive /tmp/m=
akepkg/linux-tools/src/linux/tools/perf/libapi/libapi.a /tmp/makepkg/linu=
x-tools/src/linux/tools/perf/libperf/libperf.a /tmp/makepkg/linux-tools/s=
rc/linux/tools/perf/libsubcmd/libsubcmd.a /tmp/makepkg/linux-tools/src/li=
nux/tools/perf/libsymbol/libsymbol.a /tmp/makepkg/linux-tools/src/linux/t=
ools/perf/libbpf/libbpf.a  -Wl,--no-whole-archive -Wl,--start-group -lpth=
read -lrt -lm -ldl -lelf -ldebuginfod -ldw -lunwind-x86_64 -lunwind -llzm=
a -lcrypto -lslang -lpython3.11 -ldl -lm -lutil -lstdc++ -lz -llzma -lzst=
d -lcap -lnuma -ltraceevent -Wl,--end-group -o perf
> mold: error: undefined symbol: main
>>>> referenced by /usr/lib/Scrt1.o:(.text)
>>>>               /usr/lib/Scrt1.o:(_start)
> mold: error: undefined symbol: perf_pmu__getcpuid
>>>> referenced by pmu-events.c
>>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_events_tabl=
e)>>>
>>>>               referenced by pmu-events.c
>>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_metrics_tab=
le)
> mold: error: undefined symbol: strcmp_cpuid_str
>>>> referenced by pmu-events.c
>>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_events_tabl=
e)>>>
>>>>               referenced by pmu-events.c
>>>>               pmu-events/pmu-events-in.o:(perf_pmu__find_metrics_tab=
le)>>>
>>>>               referenced by pmu-events.c
>>>>               pmu-events/pmu-events-in.o:(find_core_events_table)>>>=

>>>>               referenced 1 more times
>=20
> mold: error: undefined symbol: _ctype
>>>> referenced by kallsyms.c
>>>>             =20
>>>>               /tmp/makepkg/linux-tools/src/linux/tools/perf/libsymbo=
l/libsymbol.a(libsymbol-in.o):(__tolower)>>>
>>>>               referenced by kallsyms.c
>>>>             =20
>>>>               /tmp/makepkg/linux-tools/src/linux/tools/perf/libsymbo=
l/libsymbol.a(libsymbol-in.o):(__toupper)
> mold: error: undefined symbol: strlcpy
>>>> referenced by exec-cmd.c
>>>>             =20
>>>>               /tmp/makepkg/linux-tools/src/linux/tools/perf/libsubcm=
d/libsubcmd.a(libsubcmd-in.o):(get_pwd_cwd)
> [/CODE]
>=20
> I have noticed a patch series of Ian Rodgers that might adress this iss=
ue, but his reported errors were different to mine, see: https://www.spin=
ics.net/lists/kernel/msg4872566.html
>=20
> Compiler: gcc-version 13.1.1 20230714 (GCC)

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.3..v6.4.5 https://bugzilla.kernel.org/show_bug.cg=
i?id=3D217706

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217706

--=20
An old man doll... just what I always wanted! - Clara
