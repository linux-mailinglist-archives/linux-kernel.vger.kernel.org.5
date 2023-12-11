Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58CC80DFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjLKXyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjLKXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:54:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B595AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:54:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf09be81bso669e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702338856; x=1702943656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ7j+yIdTJRyXFdhEKM+ZLZA7awoAwqre77RM7G9Wrs=;
        b=suB2ivVYlsaZIYmO2V5cbStZE+6uZ64Zvix9EyqcPES8ecp9Nz8HygVLbcK1Cdzas3
         l77K4Eajz9l/+L95zCSu0ydXAdGkY9BkWiHc5ChvU61v4tFlvSDn9ZS04ZPVwZsgUEEY
         IvT6+OzVO30fUx6u0QLViotfl1DzeK9aL+kh0btIxnRmuLGC/WKwbez7O1jdqYxBdqMN
         6RMiPWd32+O5Chq2XDP67yNyYBlsA6zzPT8sNQG7ZXdKmxJBcvOMVyTL8jdM91qHw3CB
         fqcb/3j+EjrTu9/fZ/1zgOxs+MPArSyQ8mPBGSiEeQ52o4dccHtdlUGVz7M1wKfUoo39
         TeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338856; x=1702943656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ7j+yIdTJRyXFdhEKM+ZLZA7awoAwqre77RM7G9Wrs=;
        b=dxKbJuWyDFsaCjyVG3IGnyNxt9xiM3aE8VTb7uAd3D/GVn7QK7HTkQjEMorvni8H6o
         9MXmu3kdU1dmB+sBTuRZ3wGtDi/+oRrnOkeywGF3Y6NLqgDZwqLSJ2ZUtqWBhMJGyMM5
         Yd/Nr/yotPiO/PDqMDCyYsgY20Lm7AalVKfrHS+/KjMlV48vA1ityt8lSyENheFwqLCu
         jIiFhLPO3oUUf6MS2QH12hLRLIr6OIKxOeJ9v7hUmyuZ9eCtSYI3mW9xkaGTSzhdc5rp
         tD8zcqcHOU510W4Qd+EOQPF96OKc0XRqj0VDr/yjKZatkPNKQISgpu9W4Nu7gPtrN7t0
         DMQg==
X-Gm-Message-State: AOJu0YxVZwgNrkrIlueTUZnYvcLdgm4ZL3MSe2EFf6tLCVgZ8tCeOCCd
        z8QlbvRYblokKTpU0gFt8I+YRClB9eaPCkXppbP6fQ==
X-Google-Smtp-Source: AGHT+IEmEIpdMnovcBjeELo+iAnrH5adstoKW9gIppDFr+tLk3kphnfLFiT7ncA8CWwyMA2rs7ttZnRXVoqOY8E+LKI=
X-Received: by 2002:a05:6512:292:b0:50b:fe63:f06 with SMTP id
 j18-20020a056512029200b0050bfe630f06mr187376lfp.4.1702338856097; Mon, 11 Dec
 2023 15:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com> <20231207050433.1426834-3-irogers@google.com>
 <CAM9d7cgRZp3PieHDvsdFXG+pNG0TTKoAaH6ZxC1XAnrvRLE1Pw@mail.gmail.com>
In-Reply-To: <CAM9d7cgRZp3PieHDvsdFXG+pNG0TTKoAaH6ZxC1XAnrvRLE1Pw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Dec 2023 15:54:04 -0800
Message-ID: <CAP-5=fXuZCkbAU0wakLyu3svpvUjzugAOjZzeGg9jZyJRXpoDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] tools lib api: Add io_dir an allocation free
 readdir alternative
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 3:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Dec 6, 2023 at 9:04=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > glibc's opendir allocates a minimum of 32kb, when called recursively
> > for a directory tree the memory consumption can add up - nearly 300kb
> > during perf start-up when processing modules. Add a stack allocated
> > variant of readdir sized a little more than 1kb.
> >
> > As getdents64 may be missing from libc, add support using syscall.
>
> Unfortunately my alpine build has:
>
> In file included from util/machine.c:2:
> /build/libapi/include/api/io_dir.h:17:23: error: conflicting types for
> 'getdents'; have 'ssize_t(int,  void *, size_t)' {aka 'long int(int,
> void *, long unsigned int)'}
>    17 | static inline ssize_t getdents64(int fd, void *dirp, size_t count=
)
>       |                       ^~~~~~~~~~
> /usr/include/dirent.h:52:5: note: previous declaration of 'getdents'
> with type 'int(int,  struct dirent *, size_t)' {aka 'int(int,  struct
> dirent *, long unsigned int)'}
>    52 | int getdents(int, struct dirent *, size_t);
>       |     ^~~~~~~~

Presumably there is a #define getdents64 getdents .. Could we stop
caring about this version of Alpine linux?

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/Makefile     |  2 +-
> >  tools/lib/api/io_dir.h     | 84 ++++++++++++++++++++++++++++++++++++++
> >  tools/perf/Makefile.config |  4 ++
> >  3 files changed, 89 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/api/io_dir.h
> >
> > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > index 044860ac1ed1..186aa407de8c 100644
> > --- a/tools/lib/api/Makefile
> > +++ b/tools/lib/api/Makefile
> > @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
> >                 $(call do_install_mkdir,$(libdir_SQ)); \
> >                 cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> >
> > -HDRS :=3D cpu.h debug.h io.h
> > +HDRS :=3D cpu.h debug.h io.h io_dir.h
> >  FD_HDRS :=3D fd/array.h
> >  FS_HDRS :=3D fs/fs.h fs/tracing_path.h
> >  INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/api
> > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > new file mode 100644
> > index 000000000000..9b702497e05c
> > --- /dev/null
> > +++ b/tools/lib/api/io_dir.h
> > @@ -0,0 +1,84 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +/*
> > + * Lightweight directory reading library.
> > + */
> > +#ifndef __API_IO_DIR__
> > +#define __API_IO_DIR__
> > +
> > +#include <dirent.h>
> > +#include <fcntl.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <sys/stat.h>
> > +
> > +#ifndef HAVE_GETDENTS64
> > +#include <sys/syscall.h>
> > +
> > +static inline ssize_t getdents64(int fd, void *dirp, size_t count)
> > +{
> > +       return syscall(SYS_getdents64, fd, dirp, count);
> > +}
> > +#endif
> > +
> > +struct io_dirent64 {
> > +       ino64_t        d_ino;    /* 64-bit inode number */
> > +       off64_t        d_off;    /* 64-bit offset to next structure */
> > +       unsigned short d_reclen; /* Size of this dirent */
> > +       unsigned char  d_type;   /* File type */
> > +       char           d_name[NAME_MAX + 1]; /* Filename (null-terminat=
ed) */
> > +};
> > +
> > +struct io_dir {
> > +       int dirfd;
> > +       ssize_t available_bytes;
> > +       struct io_dirent64 *next;
> > +       struct io_dirent64 buff[4];
> > +};
> > +
> > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > +{
> > +       iod->dirfd =3D dirfd;
> > +       iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > +{
> > +       lseek(iod->dirfd, 0, SEEK_SET);
> > +       iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> > +{
> > +       struct io_dirent64 *entry;
> > +
> > +       if (iod->available_bytes <=3D 0) {
> > +               ssize_t rc =3D getdents64(iod->dirfd, iod->buff, sizeof=
(iod->buff));
> > +
> > +               if (rc <=3D 0)
> > +                       return NULL;
> > +               iod->available_bytes =3D rc;
> > +               iod->next =3D iod->buff;
> > +       }
> > +       entry =3D iod->next;
> > +       iod->next =3D (struct io_dirent64 *)((char *)entry + entry->d_r=
eclen);
> > +       iod->available_bytes -=3D entry->d_reclen;
> > +       return entry;
> > +}
> > +
> > +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_=
dirent64 *dent)
> > +{
> > +       if (dent->d_type =3D=3D DT_UNKNOWN) {
> > +               struct stat st;
> > +
> > +               if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=3D*/=
0))
> > +                       return false;
> > +
> > +               if (S_ISDIR(st.st_mode)) {
> > +                       dent->d_type =3D DT_DIR;
> > +                       return true;
> > +               }
> > +       }
> > +       return dent->d_type =3D=3D DT_DIR;
> > +}
> > +
> > +#endif
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index aa55850fbc21..1cef1ab4ddb7 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -357,6 +357,10 @@ ifeq ($(feature-stackprotector-all), 1)
> >    CORE_CFLAGS +=3D -fstack-protector-all
> >  endif
> >
> > +ifeq ($(feature-getdents64), 1)
> > +  CFLAGS +=3D -DHAVE_GETDENTS64
> > +endif
> > +
> >  ifeq ($(DEBUG),0)
> >    ifeq ($(feature-fortify-source), 1)
> >      CORE_CFLAGS +=3D -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
