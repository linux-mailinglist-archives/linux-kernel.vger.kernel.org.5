Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3067F784954
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjHVSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHVSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:17:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27711F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:16:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-407db3e9669so44431cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692728216; x=1693333016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uZBVdn9PjISI+a8IOqGGCmu5Tr6AKYR2CBCJp7yUKs=;
        b=aLXz1d5MKVrHWXFIqAr98B2jwOcnPPymV1EfB3I6gpNI2grulyiBmXIZp70TMaGJaG
         4wsjm4aWPMryyAp9BIqbta+fejcf9YH7WlpjLen1rQCHlHbLvg+P7suIE5NpcWFEWjHR
         2dqiG+XKQirGBfn/Mxixg5LEqIP53SFnMqk0KlUFjt6zNBX81NSVYGFmtmKi005HXnaG
         yDbrTds4x3v3DY+NYkqVD7WRKZPLYrpK3ykKvbr8hlur+yMaSZ5OFFvF6vD1vrKa7+xJ
         J7QGI9YahADnOjrjjwhYg7de4vz9W8ws/cmrMxb5G/9BqUkDLFzKV5QuSF3f8vWHIWhG
         57Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692728216; x=1693333016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uZBVdn9PjISI+a8IOqGGCmu5Tr6AKYR2CBCJp7yUKs=;
        b=gsQXJeGi6tZlvcumibXxFgLAfQ9Ayq0zuWp1mdAuHAL5dA2r5PeFhaw5FdopHh1KyJ
         uEN/xNo4pQnESLlRDAvS3VXC934qe+JHzQMgOGYY5pgGkHxDem5WlvVaP1dp0dvEmrzn
         Y4rFedJO7uJcHgE+Y1GGFMQIfeHOU8yGEceVaV5Hp0fVrcej/rWew0n8Q0P2tQYOZNME
         2HSiTi8u8OMx9V2vv0nR2znJr/RXOwaseWc1mDVcAcszMbOvJA6sAQ5ZmOnhE1iOcGmL
         FJ3nPZxVpjoAtqm5wb63l+lMXZO449I8CUNsN/DPOargaRJ4o+82w/lef1tPaMiHbOS5
         9pWQ==
X-Gm-Message-State: AOJu0YyVrjCvs/rNfogZ4DUHC9hA/RSQRDU4l2qkzELLUC3POZMlnZWK
        jovtCs6uSN3psD4iGiURxb/ze2vf96+Q4SZnL8Pd8Q==
X-Google-Smtp-Source: AGHT+IHZ+QfC0i9BvXLVQQzfWXwTxTudZH1AaxoPPN6OvE15niHfIKpmlL0GXrjKi/TMpT8CO2RXR58SnsVAGqwD8Hw=
X-Received: by 2002:a05:622a:407:b0:410:a4cb:9045 with SMTP id
 n7-20020a05622a040700b00410a4cb9045mr358204qtx.18.1692728215736; Tue, 22 Aug
 2023 11:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZN1ELw41wQE5zDrK@kernel.org> <CAP-5=fVU07VHcQE6r9k7aEV+xM3_HFcgY+5Y8N7qVvsZD3V9vg@mail.gmail.com>
 <ZONpMu2/tQvZgM/S@kernel.org> <CAP-5=fX_DdDV8CVWvcRCP9iWwZAmGYBdi5_RRczB3HQUuRdrOw@mail.gmail.com>
 <ZOT5mK2MgQXTx75w@kernel.org>
In-Reply-To: <ZOT5mK2MgQXTx75w@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Aug 2023 11:16:44 -0700
Message-ID: <CAP-5=fVpk=KW4kpfdFYKFhwCZesiFzfsPVM0=2Lvr+-uro1J_A@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:08=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Aug 21, 2023 at 07:52:46AM -0700, Ian Rogers escreveu:
> > On Mon, Aug 21, 2023 at 6:40=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Aug 16, 2023 at 03:10:00PM -0700, Ian Rogers escreveu:
> > > > On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Arnaldo Carvalho de Melo <a=
cme@kernel.org> wrote:
> > > > >   R2 min value is negative, either use unsigned or 'var &=3D cons=
t'
> > > > >   processed 22 insns (limit 1000000) max_states_per_insn 0 total_=
states 1 peak_states 1 mark_read 1
> > > > >   -- END PROG LOAD LOG --
> > > > >   libbpf: prog 'sys_enter_sendto': failed to load: -13
> > > > >   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > > > >   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf=
': -13
> > > > >
> > > > > So use the suggested &=3D variant since sizeof(saddr) =3D=3D 128 =
bytes.
> > > >
> > > > Could this be an assert?
> > >
> > > you mean (removing the change to saddr to make it trigger):
> >
> > I was more meaning that doing sizeof(x) -1 and assuming that x is a
> > power of two should really have an assert that sizeof(x) is a power of
>
> Right, that was my understanding, and that is what:
>
> _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augm=
ented_args->saddr) needs to be a power of two")
>
> Does, right?

Yep, I was reading your emails in order :-)

Thanks,
Ian

> - Arnaldo
>
>
> > 2. Using 127 and asserting sizeof(x)=3D=3D128 also works.
>
>
> > Thanks,
> > Ian
> >
> > > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/=
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > index 9c1d0b271b20f693..521ce2d7357d983c 100644
> > > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > @@ -10,6 +10,16 @@
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <linux/limits.h>
> > >
> > > +/**
> > > + * is_power_of_2() - check if a value is a power of two
> > > + * @n: the value to check
> > > + *
> > > + * Determine whether some value is a power of two, where zero is *no=
t*
> > > + * considered a power of two.  Return: true if @n is a power of 2, o=
therwise
> > > + * false.
> > > + */
> > > +#define is_power_of_2(n) (n !=3D 0 && ((n & (n - 1)) =3D=3D 0))
> > > +
> > >  #define MAX_CPUS  4096
> > >
> > >  // FIXME: These should come from system headers
> > > @@ -112,7 +122,10 @@ struct augmented_args_payload {
> > >                 struct {
> > >                         struct augmented_arg arg, arg2;
> > >                 };
> > > -               struct sockaddr_storage saddr;
> > > +               struct {
> > > +                       struct sockaddr_storage real_saddr;
> > > +                       char padding;
> > > +               } saddr;
> > >                 char   __data[sizeof(struct augmented_arg)];
> > >         };
> > >  };
> > > @@ -187,6 +200,7 @@ int sys_enter_connect(struct syscall_enter_args *=
args)
> > >          if (augmented_args =3D=3D NULL)
> > >                  return 1; /* Failure: don't filter */
> > >
> > > +       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), =
"sizeof(augmented_args->saddr) needs to be a power of two");
> > >         socklen &=3D sizeof(augmented_args->saddr) - 1;
> > >
> > >         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg)=
;
> > >
> > >
> > > --------------------------------
> > >
> > >   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw=
_syscalls.bpf.o
> > > util/bpf_skel/augmented_raw_syscalls.bpf.c:203:2: error: static_asser=
t failed due to requirement 'sizeof (augmented_args->saddr) !=3D 0 && ((siz=
eof (augmented_args->saddr) & (sizeof (augmented_args->saddr) - 1)) =3D=3D =
0)' "sizeof(augmented_args->saddr) needs to be a power of two"
> > >         _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), =
"sizeof(augmented_args->saddr) needs to be a power of two");
> > >         ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 1 error generated.
> > > make[2]: *** [Makefile.perf:1104: /tmp/build/perf-tools-next/util/bpf=
_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
> > > make[1]: *** [Makefile.perf:238: sub-make] Error 2
> > > make: *** [Makefile:113: install-bin] Error 2
> > > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/per=
f'
> > >
> > > And here the assert being satisfied:
> > >
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> > > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/=
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > index 9c1d0b271b20f693..43549b63b433d81e 100644
> > > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > @@ -10,6 +10,16 @@
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <linux/limits.h>
> > >
> > > +/**
> > > + * is_power_of_2() - check if a value is a power of two
> > > + * @n: the value to check
> > > + *
> > > + * Determine whether some value is a power of two, where zero is *no=
t*
> > > + * considered a power of two.  Return: true if @n is a power of 2, o=
therwise
> > > + * false.
> > > + */
> > > +#define is_power_of_2(n) (n !=3D 0 && ((n & (n - 1)) =3D=3D 0))
> > > +
> > >  #define MAX_CPUS  4096
> > >
> > >  // FIXME: These should come from system headers
> > > @@ -187,6 +197,7 @@ int sys_enter_connect(struct syscall_enter_args *=
args)
> > >          if (augmented_args =3D=3D NULL)
> > >                  return 1; /* Failure: don't filter */
> > >
> > > +       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), =
"sizeof(augmented_args->saddr) needs to be a power of two");
> > >         socklen &=3D sizeof(augmented_args->saddr) - 1;
> > >
> > >         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg)=
;
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> > > make: Entering directory '/var/home/acme/git/perf-tools-next/tools/pe=
rf'
> > >   BUILD:   Doing 'make -j32' parallel build
> > >   INSTALL libsubcmd_headers
> > >   INSTALL libperf_headers
> > >   INSTALL libapi_headers
> > >   INSTALL libbpf_headers
> > >   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw=
_syscalls.bpf.o
> > >   GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/augmented_raw_sysc=
alls.skel.h
> > >   INSTALL libsymbol_headers
> > >   CC      /tmp/build/perf-tools-next/builtin-trace.o
> > >   LD      /tmp/build/perf-tools-next/perf-in.o
> > >   LINK    /tmp/build/perf-tools-next/perf
> > >   INSTALL binaries
> > >   INSTALL tests
> > >   INSTALL libperf-jvmti.so
> > >   INSTALL libexec
> > >   INSTALL perf-archive
> > >   INSTALL perf-iostat
> > >   INSTALL strace/groups
> > >   INSTALL perl-scripts
> > >   INSTALL python-scripts
> > >   INSTALL dlfilters
> > >   INSTALL perf_completion-script
> > >   INSTALL perf-tip
> > > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/per=
f'
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >
> > >
> > >
> > >
>
> --
>
> - Arnaldo
