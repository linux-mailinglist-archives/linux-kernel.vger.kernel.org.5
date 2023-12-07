Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38079808007
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjLGFOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:14:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FFFA4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:14:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b35199f94so43945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701926047; x=1702530847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Pxd+lnPv4x9MlUm6Rhu+8NVCYwleD9tYCqVOix1Io=;
        b=XeZE+0Gl8Dg8xs4AR4rSACFO5oUWzPcDLOlaXGGd5IvAXSgokk44E6n7u23GSnE0Dl
         68IJAZXU/kXpydrU5KvhuvgyS2C7oftKLJyy8+ufj/5oU6Du9cGrlRKtBC1uNYp4iDtb
         3IEcMToOiQ7a03g4xJAYQ9AAgy7+few6DZ9SKzzvPTlNt05Fvgn4D8P7dgZT9pjhZquS
         QEUht7dK9iTpumoSk451h3GEb8q196UPcKpAld8yce0JBpw7zv9i1mdkB2wKme9rFxlb
         JNhcImN3dcekADKwvS6oyliT65zojwfK9Zg9o/HmxKOMwIbbtUHQ7hV2NOWVWXhcapnG
         nOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701926047; x=1702530847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Pxd+lnPv4x9MlUm6Rhu+8NVCYwleD9tYCqVOix1Io=;
        b=m1r2VjKuV4SIAghLhirrltkLDKdVy8XalzE/OBX3shyoMJb3NQReXfkJT7CusDaG50
         YktUOcRVTIk1JbbCswKPkP7uMeNiYgFKT1d/HgfH8755/VxT4P99IYCpPDa6oP1vkhzs
         54LJ6/hVPyJ0t+eUzSVe7s7sts1COy3b/QGmT9XpMNwZUqZb7I7laBOwnzk+2s2BChUO
         /TZqftVV8m//RHuMoUxI3IwHT2ypsgWBQeRacnKX15X4GAomy//jmmwI14w8pgRAN6Lq
         cK73a2N6JCKXQdRyO6Ard0XnYMjtkwwzSssPtq56yPjB6dVscrfPe+2y/E5sQKoxQTFx
         ITAw==
X-Gm-Message-State: AOJu0Yxac8ylStCpd3tURCLmtzFbD3YzIx9JnoXdkQIzp+BOBcPts2Fl
        NS4t1gMSsHFZ9dXe9vhorWTlFrZ+iDcjORjiMbpHsw==
X-Google-Smtp-Source: AGHT+IHWDuD6z17+AiF2zLT0TvhlMU7cNcF1CBVrn7PNW+21d5McRfiI68op+8nM4oIr1e2UfqMxOHXJCsmrklXIh18=
X-Received: by 2002:a05:600c:4e8d:b0:40b:33aa:a2b9 with SMTP id
 f13-20020a05600c4e8d00b0040b33aaa2b9mr166091wmq.4.1701926047162; Wed, 06 Dec
 2023 21:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-7-irogers@google.com>
 <ZWjEqw1cAw/eIpQH@kernel.org> <CAP-5=fUj7ZCchuwBW7xLe0UK8eupQUH3n9t0vcXGg=F57g-eMQ@mail.gmail.com>
 <ZWj93nq9GBpga7nT@kernel.org>
In-Reply-To: <ZWj93nq9GBpga7nT@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 21:13:54 -0800
Message-ID: <CAP-5=fWFUx7nKECSM4zD7bxYGiyopK5eXKRh-FYbzrM4SgrfjQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/50] tools lib api: Add io_dir an allocation free
 readdir alternative
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 1:25=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 30, 2023 at 09:56:42AM -0800, Ian Rogers escreveu:
> > On Thu, Nov 30, 2023 at 9:21=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Mon, Nov 27, 2023 at 02:08:18PM -0800, Ian Rogers escreveu:
> > > > glibc's opendir allocates a minimum of 32kb, when called recursivel=
y
> > > > for a directory tree the memory consumption can add up - nearly 300=
kb
> > > > during perf start-up when processing modules. Add a stack allocated
> > > > variant of readdir sized a little more than 1kb.
> > >
> > > Now, on some systems:
> > >
> > >   CC      /tmp/build/perf/pmu-events/pmu-events.o
> > > In file included from util/machine.c:39:
> > > /tmp/build/perf/libapi/include/api/io_dir.h: In function =E2=80=98io_=
dir__readdir=E2=80=99:
> > > /tmp/build/perf/libapi/include/api/io_dir.h:46:16: error: implicit de=
claration of function =E2=80=98getdents64=E2=80=99; did you mean =E2=80=98g=
etentropy=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > >    ssize_t rc =3D getdents64(iod->dirfd, iod->buff, sizeof(iod->buff)=
);
> > >                 ^~~~~~~~~~
> > >                 getentropy
> > >   CC      /tmp/build/perf/tests/workloads/brstack.o
> > >   CC      /tmp/build/perf/tests/workloads/datasym.o
> > >   CC      /tmp/build/perf/util/maps.o
> >
> >
> > Sorry for that. Is it a _GNU_SOURCE issue? I thought we generally had
>
> Nope, some systems just don't have that function in its libc, for
> instance, a Red Hat derivative with glibc 2.28:
>
> glibc-2.28-189.5.el8_6.x86_64
>
> [perfbuilder@56645cef2169 /]$ grep -r getdents64 /usr/include
> /usr/include/bits/syscall.h:#ifdef __NR_getdents64
> /usr/include/bits/syscall.h:# define SYS_getdents64 __NR_getdents64
> /usr/include/asm-generic/unistd.h:#define __NR_getdents64 61
> /usr/include/asm-generic/unistd.h:__SYSCALL(__NR_getdents64, sys_getdents=
64)
> /usr/include/sanitizer/linux_syscall_hooks.h:#define __sanitizer_syscall_=
pre_getdents64(fd, dirent, count)         \
> /usr/include/sanitizer/linux_syscall_hooks.h:  __sanitizer_syscall_pre_im=
pl_getdents64((long)(fd), (long)(dirent), \
> /usr/include/sanitizer/linux_syscall_hooks.h:#define __sanitizer_syscall_=
post_getdents64(res, fd, dirent, count)         \
> /usr/include/sanitizer/linux_syscall_hooks.h:  __sanitizer_syscall_post_i=
mpl_getdents64(res, (long)(fd), (long)(dirent), \
> /usr/include/sanitizer/linux_syscall_hooks.h:void __sanitizer_syscall_pre=
_impl_getdents64(long fd, long dirent, long count);
> /usr/include/sanitizer/linux_syscall_hooks.h:void __sanitizer_syscall_pos=
t_impl_getdents64(long res, long fd, long dirent,
> /usr/include/asm/unistd_64.h:#define __NR_getdents64 217
> /usr/include/asm/unistd_x32.h:#define __NR_getdents64 (__X32_SYSCALL_BIT =
+ 217)
> /usr/include/asm/unistd_32.h:#define __NR_getdents64 220
> [perfbuilder@56645cef2169 /]$
>
> Systems with musl libc fail differently:
>
>    6    19.51 alpine:3.18                   : FAIL gcc version 12.2.1 202=
20924 (Alpine 12.2.1_git20220924-r10)
>       CC      /tmp/build/perf/util/sample-raw.o
>       CC      /tmp/build/perf/tests/kmod-path.o
>       CC      /tmp/build/perf/tests/thread-map.o
>       CC      /tmp/build/perf/tests/topology.o
>     In file included from util/machine.c:39:
>     /tmp/build/perf/libapi/include/api/io_dir.h: In function 'io_dir__rea=
ddir':
>     /tmp/build/perf/libapi/include/api/io_dir.h:46:56: error: passing arg=
ument 2 of 'getdents' from incompatible pointer type [-Werror=3Dincompatibl=
e-pointer-types]
>        46 |                 ssize_t rc =3D getdents64(iod->dirfd, iod->bu=
ff, sizeof(iod->buff));
>           |                                                     ~~~^~~~~~
>           |                                                        |
>           |                                                        struct=
 io_dirent64 *
>     In file included from util/machine.c:2:
>     /usr/include/dirent.h:52:19: note: expected 'struct dirent *' but arg=
ument is of type 'struct io_dirent64 *'
>        52 | int getdents(int, struct dirent *, size_t);
>           |                   ^~~~~~~~~~~~~~~
>
> Their devel distro also fails like that:
>
>    7    20.49 alpine:edge                   : FAIL gcc version 13.1.1 202=
30722 (Alpine 13.1.1_git20230722)
>       CC      /tmp/build/perf/tests/sdt.o
>       CC      /tmp/build/perf/util/maps.o
>       CC      /tmp/build/perf/tests/is_printable_array.o
>       CC      /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder=
.o
>     In file included from util/machine.c:39:
>     /tmp/build/perf/libapi/include/api/io_dir.h: In function 'io_dir__rea=
ddir':
>     /tmp/build/perf/libapi/include/api/io_dir.h:46:56: error: passing arg=
ument 2 of 'getdents' from incompatible pointer type [-Werror=3Dincompatibl=
e-pointer-types]
>        46 |                 ssize_t rc =3D getdents64(iod->dirfd, iod->bu=
ff, sizeof(iod->buff));
>           |                                                     ~~~^~~~~~
>           |                                                        |
>           |                                                        struct=
 io_dirent64 *
>     In file included from util/machine.c:2:
>     /usr/include/dirent.h:52:19: note: expected 'struct dirent *' but arg=
ument is of type 'struct io_dirent64 *'
>        52 | int getdents(int, struct dirent *, size_t);
>           |                   ^~~~~~~~~~~~~~~
>       CC      /tmp/build/perf/tests/bitmap.o
>
> And then we have nolibc:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ find tools/ -name nolibc
> tools/include/nolibc
> tools/testing/selftests/nolibc
> =E2=AC=A2[acme@toolbox perf-tools-next]$ grep getdents64 tools/include/no=
libc/*
> tools/include/nolibc/sys.h: * int getdents64(int fd, struct linux_dirent6=
4 *dirp, int count);
> tools/include/nolibc/sys.h:int sys_getdents64(int fd, struct linux_dirent=
64 *dirp, int count)
> tools/include/nolibc/sys.h:     return my_syscall3(__NR_getdents64, fd, d=
irp, count);
> tools/include/nolibc/sys.h:int getdents64(int fd, struct linux_dirent64 *=
dirp, int count)
> tools/include/nolibc/sys.h:     return __sysret(sys_getdents64(fd, dirp, =
count));
> tools/include/nolibc/types.h:/* for getdents64() */
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> On musl libc systems:
>
> / $ grep -A1 -B20 getdents64 /usr/include/*.h
> /usr/include/dirent.h-#define DT_SOCK 12
> /usr/include/dirent.h-#define DT_WHT 14
> /usr/include/dirent.h-#define IFTODT(x) ((x)>>12 & 017)
> /usr/include/dirent.h-#define DTTOIF(x) ((x)<<12)
> /usr/include/dirent.h-int getdents(int, struct dirent *, size_t);
> /usr/include/dirent.h-#endif
> /usr/include/dirent.h-
> /usr/include/dirent.h-#ifdef _GNU_SOURCE
> /usr/include/dirent.h-int versionsort(const struct dirent **, const struc=
t dirent **);
> /usr/include/dirent.h-#endif
> /usr/include/dirent.h-
> /usr/include/dirent.h-#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SO=
URCE)
> /usr/include/dirent.h-#define dirent64 dirent
> /usr/include/dirent.h-#define readdir64 readdir
> /usr/include/dirent.h-#define readdir64_r readdir_r
> /usr/include/dirent.h-#define scandir64 scandir
> /usr/include/dirent.h-#define alphasort64 alphasort
> /usr/include/dirent.h-#define versionsort64 versionsort
> /usr/include/dirent.h-#define off64_t off_t
> /usr/include/dirent.h-#define ino64_t ino_t
> /usr/include/dirent.h:#define getdents64 getdents
> /usr/include/dirent.h-#endif
> / $

I'm confused. It seems nolibc has support, musl doesn't and with old
glibcs it depends. I added a feature test in a the latest patch series
to hopefully workaround this:
https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
Could you help check and I suspect the syscall implementation needs
some work for if SYS_getdents64 isn't defined, etc.

Thanks,
Ian

> > _GNU_SOURCE defined on the command line for reallocarray. Maybe we
> > shouldn't define this on the command line and do it immediately before
> > the relevant include with:
> >
> > #ifndef _GNU_SOURCE
> > #define _GNU_SOURCE
> > #endif
> >
> > like in tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> >
> > Thanks,
> > Ian
> >
> > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/api/Makefile |  2 +-
> > > >  tools/lib/api/io_dir.h | 75 ++++++++++++++++++++++++++++++++++++++=
++++
> > > >  2 files changed, 76 insertions(+), 1 deletion(-)
> > > >  create mode 100644 tools/lib/api/io_dir.h
> > > >
> > > > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > > > index 044860ac1ed1..186aa407de8c 100644
> > > > --- a/tools/lib/api/Makefile
> > > > +++ b/tools/lib/api/Makefile
> > > > @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
> > > >               $(call do_install_mkdir,$(libdir_SQ)); \
> > > >               cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> > > >
> > > > -HDRS :=3D cpu.h debug.h io.h
> > > > +HDRS :=3D cpu.h debug.h io.h io_dir.h
> > > >  FD_HDRS :=3D fd/array.h
> > > >  FS_HDRS :=3D fs/fs.h fs/tracing_path.h
> > > >  INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/api
> > > > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > > > new file mode 100644
> > > > index 000000000000..f3479006edb6
> > > > --- /dev/null
> > > > +++ b/tools/lib/api/io_dir.h
> > > > @@ -0,0 +1,75 @@
> > > > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > > > +/*
> > > > + * Lightweight directory reading library.
> > > > + */
> > > > +#ifndef __API_IO_DIR__
> > > > +#define __API_IO_DIR__
> > > > +
> > > > +#include <dirent.h>
> > > > +#include <fcntl.h>
> > > > +#include <stdlib.h>
> > > > +#include <unistd.h>
> > > > +#include <sys/stat.h>
> > > > +
> > > > +struct io_dirent64 {
> > > > +     ino64_t        d_ino;    /* 64-bit inode number */
> > > > +     off64_t        d_off;    /* 64-bit offset to next structure *=
/
> > > > +     unsigned short d_reclen; /* Size of this dirent */
> > > > +     unsigned char  d_type;   /* File type */
> > > > +     char           d_name[NAME_MAX + 1]; /* Filename (null-termin=
ated) */
> > > > +};
> > > > +
> > > > +struct io_dir {
> > > > +     int dirfd;
> > > > +     ssize_t available_bytes;
> > > > +     struct io_dirent64 *next;
> > > > +     struct io_dirent64 buff[4];
> > > > +};
> > > > +
> > > > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > > > +{
> > > > +     iod->dirfd =3D dirfd;
> > > > +     iod->available_bytes =3D 0;
> > > > +}
> > > > +
> > > > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > > > +{
> > > > +     lseek(iod->dirfd, 0, SEEK_SET);
> > > > +     iod->available_bytes =3D 0;
> > > > +}
> > > > +
> > > > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *i=
od)
> > > > +{
> > > > +     struct io_dirent64 *entry;
> > > > +
> > > > +     if (iod->available_bytes <=3D 0) {
> > > > +             ssize_t rc =3D getdents64(iod->dirfd, iod->buff, size=
of(iod->buff));
> > > > +
> > > > +             if (rc <=3D 0)
> > > > +                     return NULL;
> > > > +             iod->available_bytes =3D rc;
> > > > +             iod->next =3D iod->buff;
> > > > +     }
> > > > +     entry =3D iod->next;
> > > > +     iod->next =3D (struct io_dirent64 *)((char *)entry + entry->d=
_reclen);
> > > > +     iod->available_bytes -=3D entry->d_reclen;
> > > > +     return entry;
> > > > +}
> > > > +
> > > > +static inline bool io_dir__is_dir(const struct io_dir *iod, struct=
 io_dirent64 *dent)
> > > > +{
> > > > +     if (dent->d_type =3D=3D DT_UNKNOWN) {
> > > > +             struct stat st;
> > > > +
> > > > +             if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=3D=
*/0))
> > > > +                     return false;
> > > > +
> > > > +             if (S_ISDIR(st.st_mode)) {
> > > > +                     dent->d_type =3D DT_DIR;
> > > > +                     return true;
> > > > +             }
> > > > +     }
> > > > +     return dent->d_type =3D=3D DT_DIR;
> > > > +}
> > > > +
> > > > +#endif
> > > > --
> > > > 2.43.0.rc1.413.gea7ed67945-goog
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
