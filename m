Return-Path: <linux-kernel+bounces-54198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292384AC24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3522872FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD357336;
	Tue,  6 Feb 2024 02:21:21 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2D56B8F;
	Tue,  6 Feb 2024 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186081; cv=none; b=N+dc/V/GI4MdC1cCYuTr5dihcleS3/9J0/E5883zVmNrwrUTlTn0x6js0ID03aqWiOSOqu6YZHw3ZB7nIldXA79emLDJdrbFVNVgg/wAShY2AhZsFl/o+DVgwL5uow1oLVSWsi4JGUiCFqtiSth57o3bf7nT2hJtvfgbNB6BeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186081; c=relaxed/simple;
	bh=RElkcGIX1JnV58ilDMaRWG242S1+SDXgDW8vkxla7EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RamX+dj8QGM5mF43rA/jFDXwoj4q+kxZ6t3eNULwT0vai1jC2u9guitS9uZXF1mhRVeJsNjNudvgfb45E4Do5WIsLl04I4s7ognNyIAe5lPaoeUQpMO8pd02YvqZOkKwPmrQjOuyRO8/VfUwoXeJyotWLOLoIxaJOz11GwaMhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2967682b29aso1378974a91.2;
        Mon, 05 Feb 2024 18:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707186079; x=1707790879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCgV+C17HfH/BTi7HeGrLKXd5D1dF0W0dp4NG3kQMsU=;
        b=uTZ64shCGQeyh18CYr7zAl1KULqngZ2dHGGaXnN2cTQV93zTSigwY2pi9yi6tcPaI+
         lhbV1gwTqFJpnKtLfbl4gBPkwyXmUlrHyLfSZlvIbkDdHulhb8y4o7bmDtw+tk5Cr5A1
         v/RenmMuUfYso9o/jLOGw3yrPcYw5OfgO3gfQuTWKd0Imft/PllP6jU0+YfyZ9+lcCpN
         WXf6GzKcb7V5mm1vjYroEqa5aM/RNMBjix8BpslVaUKhbXmDOQw6r88m295dprKclTEu
         1vTkkrHlD0N1p9i15Uu+ynR6v6ilFKAvKR4hgNNjhQ+NGf6khiTrvO/ymXtv6666JChK
         JcNw==
X-Gm-Message-State: AOJu0YyK3ZD4OXW0JozrxUsFYI1f2ZbzF4puupVBiUDo9Xy++r8S6nsC
	Q61HAC7h1caKVdyRWY88fvOZjAykNEwnWL+4wdaQoakOBkzQFVt6Il9bayIKbC/7U8waDkPNsTN
	pEyHa5Qh34QmEUV+OIwJ/DeEC4KM=
X-Google-Smtp-Source: AGHT+IH7LYdqP0z/h8TQBGFlI0FE+HcTmiaF2MC3p3+8MiBfqg0Nta3Eb0DRPRUKuoWhTT/jbuVXjhVWNcJOxCIadlQ=
X-Received: by 2002:a17:90b:888:b0:296:2f91:4121 with SMTP id
 bj8-20020a17090b088800b002962f914121mr1260671pjb.12.1707186078354; Mon, 05
 Feb 2024 18:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110130.3553-1-adrian.hunter@intel.com>
 <20240202110130.3553-2-adrian.hunter@intel.com> <CAM9d7cipqHheaZOj9Qr56COjjdU2Qk1pLtUzkjZxtq4g3irLww@mail.gmail.com>
 <CA+JHD91GR=Jry_=Es4m+JnySjMoKrfajW40ZHq+eYFaF9Vsngg@mail.gmail.com> <4983cc09-20ad-450b-8eba-219f75a5fab2@intel.com>
In-Reply-To: <4983cc09-20ad-450b-8eba-219f75a5fab2@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 18:21:07 -0800
Message-ID: <CAM9d7chXSvhej4Evaq1gS_g-zPd0jOVBQDh3UmKAaE2UvP7-Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script: Make it possible to see perf's kernel
 and module memory mappings
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:08=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 3/02/24 03:56, Arnaldo Carvalho de Melo wrote:
> >
> >
> > On Fri, Feb 2, 2024, 10:50 PM Namhyung Kim <namhyung@kernel.org <mailto=
:namhyung@kernel.org>> wrote:
> >
> >     On Fri, Feb 2, 2024 at 3:01=E2=80=AFAM Adrian Hunter <adrian.hunter=
@intel.com <mailto:adrian.hunter@intel.com>> wrote:
> >     >
> >     > Dump kmaps if verbose > 2.
> >
> >     Maybe we can add '--debug kmap' option rather than using an
> >     arbitrary verbose level.
>
> That is a global option but would only work for tools that are
> explicitly programmed to do the dump.  Could just do perf script
> and perf report?

I don't care.. actually `--debug perf-event-open` would work with
commands that call the syscall only.  But I'm fine either way.

>
> >
> >
> > I think we have 'perf report --mmap', no?
>
> Only shows user space maps.  Could add 'perf report --kmaps'?

That'd work too.  It's up to you.

Thanks,
Namhyung


>
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/Documentation/perf-report.txt#n542 <https://git.kernel.org/pub/=
scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-=
report.txt#n542>
> >
> > - Arnaldo
> >
> > Sent from smartphone
> >
> >
> >     Thanks,
> >     Namhyung
> >
> >     >
> >     > Example:
> >     >
> >     >   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel
> >     >   build id event received for /lib/modules/6.7.2-local/kernel/arc=
h/x86/kvm/kvm-intel.ko: 0691d75e10e72ebbbd45a44c59f6d00a5604badf [20]
> >     >   Map: 0-3a3 4f5d8 [kvm_intel].modinfo
> >     >   Map: 0-5240 5f280 [kvm_intel]__versions
> >     >   Map: 0-30 64 [kvm_intel].note.Linux
> >     >   Map: 0-14 644c0 [kvm_intel].orc_header
> >     >   Map: 0-5297 43680 [kvm_intel].rodata
> >     >   Map: 0-5bee 3b837 [kvm_intel].text.unlikely
> >     >   Map: 0-7e0 41430 [kvm_intel].noinstr.text
> >     >   Map: 0-2080 713c0 [kvm_intel].bss
> >     >   Map: 0-26 705c8 [kvm_intel].data..read_mostly
> >     >   Map: 0-5888 6a4c0 [kvm_intel].data
> >     >   Map: 0-22 70220 [kvm_intel].data.once
> >     >   Map: 0-40 705f0 [kvm_intel].data..percpu
> >     >   Map: 0-1685 41d20 [kvm_intel].init.text
> >     >   Map: 0-4b8 6fd60 [kvm_intel].init.data
> >     >   Map: 0-380 70248 [kvm_intel]__dyndbg
> >     >   Map: 0-8 70218 [kvm_intel].exit.data
> >     >   Map: 0-438 4f980 [kvm_intel]__param
> >     >   Map: 0-5f5 4ca0f [kvm_intel].rodata.str1.1
> >     >   Map: 0-3657 493b8 [kvm_intel].rodata.str1.8
> >     >   Map: 0-e0 70640 [kvm_intel].data..ro_after_init
> >     >   Map: 0-500 70ec0 [kvm_intel].gnu.linkonce.this_module
> >     >   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-lo=
cal/kernel/arch/x86/kvm/kvm-intel.ko
> >     >
> >     > The example above shows how the module section mappings are all w=
rong
> >     > except for the main .text mapping at 0xffffffffc13a7000.
> >     >
> >     > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com <mailto:adr=
ian.hunter@intel.com>>
> >     > ---
> >     >  tools/perf/builtin-script.c | 13 +++++++++++++
> >     >  1 file changed, 13 insertions(+)
> >     >
> >     > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-scr=
ipt.c
> >     > index b1f57401ff23..e764b319ef59 100644
> >     > --- a/tools/perf/builtin-script.c
> >     > +++ b/tools/perf/builtin-script.c
> >     > @@ -3806,6 +3806,16 @@ static int parse_callret_trace(const struc=
t option *opt __maybe_unused,
> >     >         return 0;
> >     >  }
> >     >
> >     > +static void dump_kmaps(struct perf_session *session)
> >     > +{
> >     > +       int save_verbose =3D verbose;
> >     > +
> >     > +       pr_debug("Kernel and module maps:\n");
> >     > +       verbose =3D 0; /* Suppress verbose to print a summary onl=
y */
> >     > +       maps__fprintf(machine__kernel_maps(&session->machines.hos=
t), stderr);
> >     > +       verbose =3D save_verbose;
> >     > +}
> >     > +
> >     >  int cmd_script(int argc, const char **argv)
> >     >  {
> >     >         bool show_full_info =3D false;
> >     > @@ -4366,6 +4376,9 @@ int cmd_script(int argc, const char **argv)
> >     >
> >     >         flush_scripting();
> >     >
> >     > +       if (verbose > 2)
> >     > +               dump_kmaps(session);
> >     > +
> >     >  out_delete:
> >     >         if (script.ptime_range) {
> >     >                 itrace_synth_opts__clear_time_range(&itrace_synth=
_opts);
> >     > --
> >     > 2.34.1
> >     >
> >
>

