Return-Path: <linux-kernel+bounces-59833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4784FC46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE54D285CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FD80C14;
	Fri,  9 Feb 2024 18:49:22 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817853398;
	Fri,  9 Feb 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504561; cv=none; b=Ls32Y0R3ibHM6FXfYrpo6xi32gdeR1WI7kM2j7Vf2IOi20T/LClsYZit9GttfoFJEoa8GzkKL12XHwhAoCgftZ4wOiKO6E+tJBxYLYnfxAMaae1JPJZnbVDFdKEInLEW3QsjDAx5wKe7eDOSGTlfcmczVfYNOlcBE9V1WhNgVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504561; c=relaxed/simple;
	bh=tg8WTf20W2KZrpUYwqpC65yHOjJtUsQQZ0b9pexFSas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvwqZucTMEmqDBRR4/vkA1jZPS73zj5Qtiq7uor0XFnT3vNBxFsFCHESwLy6EK2QEAAb2pEiI+MK+PUwzh7iHI7XAiPS5nJequuN68o7pILu9ZXqKGP+IPd6WpnHkFT9LIU3TKc0rL2jITURXuI5fZEeMIvqfB8zZynFshiCe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29026523507so988938a91.0;
        Fri, 09 Feb 2024 10:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504559; x=1708109359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0rXUviYAbRHYiCCS77CX2x8qaJ8KeP6e98LyXTe4oE=;
        b=lZ78LeDUOYKfrCT0nJyJT23kXIgw5T7cTR4vrH77nGm4qPhtcffDzQ2CkMFTFkvQow
         inZ5SYdSsukVJCDuYDNT1ArOLveUI2hwXwz/SpvfTsz1+4+yH1HYDCC9enp1UpV07SUX
         WFStfMN0xzxOz205AV2xdJAXuTaEiP70tZN+O0kC01jUGHT94uszDxavteIDezYhBCtZ
         IwVzvHVP9RqmihAFiIIJyfXhtPcjdp9itGylCDk72XUjfbed/jQ14OJTPArlKqrQKJ5j
         5aXVg9C6i+TF5uJS7ldABeQaKazSAyqZOSg6yyicZR4SmUaj17Re13ctsVe9omV9BTio
         3EwQ==
X-Gm-Message-State: AOJu0YysxfDCj8O6FUJYhYkkFrBjtpv6+QRg+u/jYP5Ma9O/3fRHGpHg
	m4mbXm7s8OqiX+0pXNXO7HKlKHiTU1gbH8VpcIGDPBGlJCqp88ho69UVkhEff9FOX4Y1PuTnJK0
	2ZfKBJT8Xx0hx8iOJGHh/o/hYXps=
X-Google-Smtp-Source: AGHT+IFKxKC2OOFlhaElRiyk5W0//1uyiuBXX0QAijG4fGciVJmYdfyq42XDinBBi3+J/enj9ttb6BngX0QO1C0O+aw=
X-Received: by 2002:a17:90a:a405:b0:296:c78e:c0bc with SMTP id
 y5-20020a17090aa40500b00296c78ec0bcmr2807777pjp.9.1707504559255; Fri, 09 Feb
 2024 10:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206112929.1035548-1-changbin.du@huawei.com> <bd5ed9b2-cbb7-4b8b-b7b8-5db2eff75f17@intel.com>
In-Reply-To: <bd5ed9b2-cbb7-4b8b-b7b8-5db2eff75f17@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Feb 2024 10:49:06 -0800
Message-ID: <CAM9d7cieSFcbPj-PH=9EKzAmNJCkVCoytUbQaEz9iRi47CiF7w@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] perf: script: Intro capstone disasm engine to show
 instruction trace
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

For some reason, I cannot see Changbin's email in my mailbox. :(

On Tue, Feb 6, 2024 at 3:50=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 6/02/24 13:29, Changbin Du wrote:
> > This series introduces capstone disassembler engine to print instructio=
ns of
> > Intel PT trace, which was printed via the XED tool.
> >
> > The advantages compared to XED tool:
> >     * Support arm, arm64, x86-32, x86_64, s390 (more could be supported=
),
> >       xed only for x86_64.
> >     * More friendly to read. Immediate address operands are shown as sy=
mbol+offs.
> >
> > Display raw instructions:
> >     $ sudo perf record --event intel_pt//u -- ls
> >     $ sudo perf script --insn-trace
> >                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __=
GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 48 3d 01 f0 ff ff
> >                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __=
GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 73 01
> >                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __=
GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: c3
> >                 perf 17423 [000] 423271.557970338:      5593ad3346d7 pe=
rf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: 85 c0
> >                 perf 17423 [000] 423271.557970338:      5593ad3346d9 pe=
rf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: 75 12
> >                 perf 17423 [000] 423271.557970338:      5593ad3346db pe=
rf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: 49 8b 84 24 a=
8 00 00 00
> >                 perf 17423 [000] 423271.557970338:      5593ad3346e3 pe=
rf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: 48 8b 50 20
> >
> > Display mnemonic instructions:
> >     $ sudo perf script --insn-trace=3Ddisasm
> >                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __=
GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so)            cmpq $-0xfff=
, %rax
> >                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __=
GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so)            jae __GI___i=
octl+0x10
> >                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __=
GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so)            retq
> >                 perf 17423 [000] 423271.557970338:      5593ad3346d7 pe=
rf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf)                test=
l %eax, %eax
> >                 perf 17423 [000] 423271.557970338:      5593ad3346d9 pe=
rf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf)                jne =
perf_evsel__enable_cpu+0xad
> >                 perf 17423 [000] 423271.557970338:      5593ad3346db pe=
rf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf)                movq=
 0xa8(%r12), %rax
> >                 perf 17423 [000] 423271.557970338:      5593ad3346e3 pe=
rf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf)                movq=
 0x20(%rax), %rdx
> >                 perf 17423 [000] 423271.557970338:      5593ad3346e7 pe=
rf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf)                cmpl=
 %edx, %ebx
> >                 perf 17423 [000] 423271.557970338:      5593ad3346e9 pe=
rf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf)                jl p=
erf_evsel__enable_cpu+0x60
> >                 perf 17423 [000] 423271.557970338:      5593ad3346eb pe=
rf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf)                xorl=
 %eax, %eax
> >
> > v7:
> >   - remove redundant space for raw instruction.
> >   - rename sample__fprintf_insn() as sample__fprintf_insn_asm() and mak=
e it empty if libcapstone is not available.
> > v6:
> >   - make '-F +disasm' fatal if libcapstone is not supported. (Adrian Hu=
nter)
> >   - display with perf version --build-options. (Adrian Hunter)
> >   - exclude libcapstone from make_minimal. (Adrian Hunter)
> > v5:
> >   - fixes and improments suggested by Adrian Hunter
> > v4:
> >   - rename 'insn_disam' to 'disasm' (Adrian Hunter)
> > v3:
> >   - fix s390 detection. (Thomas Richter)
> > v2:
> >   - add a new field 'insn_disam' instead of changing the default output=
.
> >   - preserve the old --xed option.
> >
> > Changbin Du (5):
> >   perf: build: introduce the libcapstone
> >   perf: util: use capstone disasm engine to show assembly instructions
> >   perf: script: add field 'disasm' to display mnemonic instructions
> >   perf: script: add raw|disasm arguments to --insn-trace option
> >   perf: script: prefer capstone to XED
> >
> >  tools/build/Makefile.feature               |   2 +
> >  tools/build/feature/Makefile               |   4 +
> >  tools/build/feature/test-all.c             |   4 +
> >  tools/build/feature/test-libcapstone.c     |  11 ++
> >  tools/perf/Documentation/perf-intel-pt.txt |  14 ++-
> >  tools/perf/Documentation/perf-script.txt   |  20 +--
> >  tools/perf/Makefile.config                 |  21 ++++
> >  tools/perf/Makefile.perf                   |   3 +
> >  tools/perf/builtin-script.c                |  45 +++++--
> >  tools/perf/builtin-version.c               |   1 +
> >  tools/perf/tests/make                      |   4 +-
> >  tools/perf/ui/browsers/res_sample.c        |   2 +-
> >  tools/perf/ui/browsers/scripts.c           |   2 +-
> >  tools/perf/util/Build                      |   1 +
> >  tools/perf/util/print_insn.c               | 135 +++++++++++++++++++++
> >  tools/perf/util/print_insn.h               |  16 +++
> >  16 files changed, 258 insertions(+), 27 deletions(-)
> >  create mode 100644 tools/build/feature/test-libcapstone.c
> >  create mode 100644 tools/perf/util/print_insn.c
> >  create mode 100644 tools/perf/util/print_insn.h
> >
>
> For whole patch set:
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Anyway, I see a build failure on Fedora 40.

In file included from /usr/include/capstone/capstone.h:325,
                 from util/print_insn.c:29:
/usr/include/capstone/bpf.h:94:14: error: 'bpf_insn' defined as wrong
kind of tag
   94 | typedef enum bpf_insn {
      |              ^~~~~~~~

Thanks,
Namhyung

