Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D7782CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjHUOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjHUOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:53:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34954E8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:53:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40c72caec5cso474841cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692629578; x=1693234378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a2GldPZ/BiydqOm5rNhLVPSjcwh3Fq0xXm+vILSjlc=;
        b=EoZxbhIl03N6utKds/vZ+uRcaXbwn4hy6f5p8AqXk9j3GJIijPXuCbBliz2w97o63d
         ZidjwF2OEYBMNwWDygM0C4QUQVXJ9BQWOath+gHMNw0xQPhrbYu9yBa42jazhXvBlNlJ
         bVUAeCv81g3eK4nRkYGFaYwNVqX/fqCs5QKsPiokT12yO5CSeHzb8dBDIQdrGgihxv+d
         h4a5tjxD48/LVTIYA4Oot+xltmOngVc7yEKc5tkHlA/YWu1Xjspz8G8GOE4bELHgssEg
         oxq/WmHjPOB/Lx+SpdPMyMn+pHyrMc/Ll+2OeEFzwsTXfOqLXDBplcDgBLPiLh95s/0y
         iW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629578; x=1693234378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a2GldPZ/BiydqOm5rNhLVPSjcwh3Fq0xXm+vILSjlc=;
        b=K8KyYomU7Vr/cD9r88doc4/Qk19MbsFXXP+Acr7kv30peDPXmVwKzgA8nfGZkPdjsD
         SOGJ5ekeqZxvuoVi5L947cPzKta0aez5tXEbAnCJy042vRu6+MJkNw+bACe5IeZnyRiH
         JfJn2sWu2KVQNu5LnD6cwY31zLT4FAIOxF4Y14dNjY7gmEzztHDAcvaQwUTBr3XPmUht
         TKkPlfQnvi9AzE1f4zCJQ4NZi0s1FmDCSBSlxlRA8Y4x/KNXvzU+Ja81NdjUojIBoXI5
         p/wGVke/d9FNF8fY8o7A5HvwuNj2hivntpJndeusSderKj6wjX0O7ipmlk4MZfmNPtRj
         2wzA==
X-Gm-Message-State: AOJu0YzZ2MXCIOt3OGrGXcyQIwSoJ+SsUBtPm1ndRrrCzRcuUvWpRf7m
        lU3Q3l4YbgIrrGSxVoLsi4aKwFE0JGoYo8rs706TfFGQ8xBbHducW3eq0A==
X-Google-Smtp-Source: AGHT+IG0r6/mANbuz2Z/NfeOn8asRdB5EqcTMyMOsysKAFwyPmxbabZfmuo1whTuyLGEPLmWLNiGxDDnBwdLgvVc0eY=
X-Received: by 2002:a05:622a:48:b0:3f8:5b2:aef0 with SMTP id
 y8-20020a05622a004800b003f805b2aef0mr599317qtw.24.1692629578372; Mon, 21 Aug
 2023 07:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <ZN1ELw41wQE5zDrK@kernel.org> <CAP-5=fVU07VHcQE6r9k7aEV+xM3_HFcgY+5Y8N7qVvsZD3V9vg@mail.gmail.com>
 <ZONpMu2/tQvZgM/S@kernel.org>
In-Reply-To: <ZONpMu2/tQvZgM/S@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Aug 2023 07:52:46 -0700
Message-ID: <CAP-5=fX_DdDV8CVWvcRCP9iWwZAmGYBdi5_RRczB3HQUuRdrOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf_skel augmented_raw_syscalls: Cap the socklen
 parameter using &= sizeof(saddr)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 6:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 16, 2023 at 03:10:00PM -0700, Ian Rogers escreveu:
> > On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > >   R2 min value is negative, either use unsigned or 'var &=3D const'
> > >   processed 22 insns (limit 1000000) max_states_per_insn 0 total_stat=
es 1 peak_states 1 mark_read 1
> > >   -- END PROG LOAD LOG --
> > >   libbpf: prog 'sys_enter_sendto': failed to load: -13
> > >   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > >   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -=
13
> > >
> > > So use the suggested &=3D variant since sizeof(saddr) =3D=3D 128 byte=
s.
> >
> > Could this be an assert?
>
> you mean (removing the change to saddr to make it trigger):

I was more meaning that doing sizeof(x) -1 and assuming that x is a
power of two should really have an assert that sizeof(x) is a power of
2. Using 127 and asserting sizeof(x)=3D=3D128 also works.

Thanks,
Ian

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 9c1d0b271b20f693..521ce2d7357d983c 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -10,6 +10,16 @@
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
>
> +/**
> + * is_power_of_2() - check if a value is a power of two
> + * @n: the value to check
> + *
> + * Determine whether some value is a power of two, where zero is *not*
> + * considered a power of two.  Return: true if @n is a power of 2, other=
wise
> + * false.
> + */
> +#define is_power_of_2(n) (n !=3D 0 && ((n & (n - 1)) =3D=3D 0))
> +
>  #define MAX_CPUS  4096
>
>  // FIXME: These should come from system headers
> @@ -112,7 +122,10 @@ struct augmented_args_payload {
>                 struct {
>                         struct augmented_arg arg, arg2;
>                 };
> -               struct sockaddr_storage saddr;
> +               struct {
> +                       struct sockaddr_storage real_saddr;
> +                       char padding;
> +               } saddr;
>                 char   __data[sizeof(struct augmented_arg)];
>         };
>  };
> @@ -187,6 +200,7 @@ int sys_enter_connect(struct syscall_enter_args *args=
)
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> +       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "siz=
eof(augmented_args->saddr) needs to be a power of two");
>         socklen &=3D sizeof(augmented_args->saddr) - 1;
>
>         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
>
>
> --------------------------------
>
>   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_sys=
calls.bpf.o
> util/bpf_skel/augmented_raw_syscalls.bpf.c:203:2: error: static_assert fa=
iled due to requirement 'sizeof (augmented_args->saddr) !=3D 0 && ((sizeof =
(augmented_args->saddr) & (sizeof (augmented_args->saddr) - 1)) =3D=3D 0)' =
"sizeof(augmented_args->saddr) needs to be a power of two"
>         _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "siz=
eof(augmented_args->saddr) needs to be a power of two");
>         ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make[2]: *** [Makefile.perf:1104: /tmp/build/perf-tools-next/util/bpf_ske=
l/.tmp/augmented_raw_syscalls.bpf.o] Error 1
> make[1]: *** [Makefile.perf:238: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
>
> And here the assert being satisfied:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 9c1d0b271b20f693..43549b63b433d81e 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -10,6 +10,16 @@
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
>
> +/**
> + * is_power_of_2() - check if a value is a power of two
> + * @n: the value to check
> + *
> + * Determine whether some value is a power of two, where zero is *not*
> + * considered a power of two.  Return: true if @n is a power of 2, other=
wise
> + * false.
> + */
> +#define is_power_of_2(n) (n !=3D 0 && ((n & (n - 1)) =3D=3D 0))
> +
>  #define MAX_CPUS  4096
>
>  // FIXME: These should come from system headers
> @@ -187,6 +197,7 @@ int sys_enter_connect(struct syscall_enter_args *args=
)
>          if (augmented_args =3D=3D NULL)
>                  return 1; /* Failure: don't filter */
>
> +       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "siz=
eof(augmented_args->saddr) needs to be a power of two");
>         socklen &=3D sizeof(augmented_args->saddr) - 1;
>
>         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
> =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
>   INSTALL libsubcmd_headers
>   INSTALL libperf_headers
>   INSTALL libapi_headers
>   INSTALL libbpf_headers
>   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_sys=
calls.bpf.o
>   GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/augmented_raw_syscalls=
.skel.h
>   INSTALL libsymbol_headers
>   CC      /tmp/build/perf-tools-next/builtin-trace.o
>   LD      /tmp/build/perf-tools-next/perf-in.o
>   LINK    /tmp/build/perf-tools-next/perf
>   INSTALL binaries
>   INSTALL tests
>   INSTALL libperf-jvmti.so
>   INSTALL libexec
>   INSTALL perf-archive
>   INSTALL perf-iostat
>   INSTALL strace/groups
>   INSTALL perl-scripts
>   INSTALL python-scripts
>   INSTALL dlfilters
>   INSTALL perf_completion-script
>   INSTALL perf-tip
> make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
>
>
>
