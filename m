Return-Path: <linux-kernel+bounces-54199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC084AC26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904A31F2471C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259FF56B78;
	Tue,  6 Feb 2024 02:22:00 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F456B68;
	Tue,  6 Feb 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186119; cv=none; b=DUK4G+BHPXDBkLAaAPAyrLdNg6ru0IiC/w1cf2Iuj+gBnK6BeEph7Rhw6s9Wb0uaCJ8AwymT78Lyhb+40OdubTMRqTx/FoatxTf8ucV+V85ikt8XcmCf7JYJngdeKMpQ+ftjdYfAa/I2hMhwNMEejB5yh6KMLmClZB0IgqOaiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186119; c=relaxed/simple;
	bh=JKL7wAZAXuBWK5HxxxWHZnoaYHvzFfXq2MhpV++aGZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVMM0InyU9d36msMcKUxrPtETrOA6kt8tDJUhdL5FDXJny1DlzZ7+qKnVP7jFJa0dEzI/jH/XRMp1tj7N4odUIYJ4H4cd3BrcFcddyoOLQD5RAQTCyPInBlTqLftDS1qFybA1An5C9c18gOLSRff5YNMO7CrCnuvkm7GAVLxgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e03c50dc68so644615b3a.1;
        Mon, 05 Feb 2024 18:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707186117; x=1707790917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmX28T1cy+Xsix2lkwN9TrnUjoz290WoN/I+0YHG2R0=;
        b=io43mXH0Hz/rEYYJ7t06QUb1g9C6GGxFjRLOLY8TduapALU4Gna7CbhsOfg7wK4F5I
         /JTuolpS/6L/rNRGMboqtRjHmyS8BeFIkN1kAfOQ00b8UJehrmt0s3HiqdpRoFqZ0wme
         kaEZ0sTS9VwthyvS68QZ7oCGeuc2lebY6Stq/6nz8KvAatrykQSNPFC33wBNfbgLLd8l
         vft4WiixocDRZ5SgoaDaZr0i+Pk4g+jvSsJfWpn6nyld9/4XoV4vhg8JHuEesYjmCJT4
         yDuCkLggwi0FTLyVOWy/n7Vv8px7ivaYtzNQEdbphGFbS3BMtwGKwMA28lQodNW39N/c
         dLgw==
X-Gm-Message-State: AOJu0YyQswAMT1lHh+It9JQVaj58g3ew5yR59yzbV54FT9Kr8ZUEvkZw
	12mp/fUbyXJq8W1GD5ue8iIA2mrHapo2UOVTj17qKPKJach2ho0rMEnkem1190XIbDZz5v0NPzZ
	GWD1kt3oCkGJ54ZzbLNeNN+OtWZFznLxSIOk=
X-Google-Smtp-Source: AGHT+IFtlgDdUulA1zYhWambzZO9B9jEcg2dgjS8aP6UuZRCzzAXieISD7+88FCtoxv6HgKCjBx9kWv/zUaN92Mm80s=
X-Received: by 2002:a05:6a00:b33:b0:6e0:3329:1044 with SMTP id
 f51-20020a056a000b3300b006e033291044mr887349pfu.29.1707186117174; Mon, 05 Feb
 2024 18:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110130.3553-1-adrian.hunter@intel.com>
 <20240202110130.3553-3-adrian.hunter@intel.com> <Zb2akm1MGCv84T-7@google.com> <046baaea-217f-4ecc-b340-b5f6f1cee0b9@intel.com>
In-Reply-To: <046baaea-217f-4ecc-b340-b5f6f1cee0b9@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 18:21:46 -0800
Message-ID: <CAM9d7cgZi8jDDgHrAqJmLvz33VXkLb3KKiJ4uayEZniTnaFbBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf symbols: Slightly improve module file executable
 section mappings
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 10:58=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 3/02/24 03:44, Namhyung Kim wrote:
> > Hi Adrian,
> >
> > On Fri, Feb 02, 2024 at 01:01:30PM +0200, Adrian Hunter wrote:
> >> Currently perf does not record module section addresses except for
> >> the .text section. In general that means perf cannot get module sectio=
n
> >> mappings correct (except for .text) when loading symbols from a kernel
> >> module file. (Note using --kcore does not have this issue)
> >>
> >> Improve that situation slightly by identifying executable sections tha=
t
> >> use the same mapping as the .text section. That happens when an
> >> executable section comes directly after the .text section, both in mem=
ory
> >> and on file, something that can be determined by following the same la=
yout
> >> rules used by the kernel, refer kernel layout_sections(). Note whether
> >> that happens is somewhat arbitrary, so this is not a final solution.
> >>
> >> Example from tracing a virtual machine process:
> >>
> >>  Before:
> >>
> >>   $ perf script | grep unknown
> >>          CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  fff=
fffffc13e8a70 [unknown] (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-i=
ntel.ko)
> >>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.=
text\|ffff'
> >>   Map: 0-7e0 41430 [kvm_intel].noinstr.text
> >>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/k=
ernel/arch/x86/kvm/kvm-intel.ko
> >>
> >>  After:
> >>
> >>   $ perf script | grep 203.511270
> >>          CPU 0/KVM    1718   203.511270:     318341 cpu-cycles:P:  fff=
fffffc13e8a70 vmx_vmexit+0x0 (/lib/modules/6.7.2-local/kernel/arch/x86/kvm/=
kvm-intel.ko)
> >>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel | grep 'noinstr.=
text\|ffff'
> >>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/k=
ernel/arch/x86/kvm/kvm-intel.ko
> >>
> >> Reported-by: Like Xu <like.xu.linux@gmail.com>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/util/symbol-elf.c | 75 +++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 73 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf=
c
> >> index 9e7eeaf616b8..98bf0881aaf6 100644
> >> --- a/tools/perf/util/symbol-elf.c
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -23,6 +23,7 @@
> >>  #include <linux/ctype.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/zalloc.h>
> >> +#include <linux/string.h>
> >>  #include <symbol/kallsyms.h>
> >>  #include <internal/lib.h>
> >>
> >> @@ -1329,6 +1330,58 @@ int symsrc__init(struct symsrc *ss, struct dso =
*dso, const char *name,
> >>      return -1;
> >>  }
> >>
> >> +static bool is_exe_text(int flags)
> >> +{
> >> +    return (flags & (SHF_ALLOC | SHF_EXECINSTR)) =3D=3D (SHF_ALLOC | =
SHF_EXECINSTR);
> >> +}
> >> +
> >> +/*
> >> + * Some executable module sections like .noinstr.text might be laid o=
ut with
> >> + * .text so they can use the same mapping (memory address to file off=
set).
> >> + * Check if that is the case. Refer to kernel layout_sections(). Retu=
rn the
> >> + * maximum offset.
> >> + */
> >> +static u64 max_text_section(Elf *elf, GElf_Ehdr *ehdr)
> >> +{
> >> +    Elf_Scn *sec =3D NULL;
> >> +    GElf_Shdr shdr;
> >> +    u64 offs =3D 0;
> >> +
> >> +    /* Doesn't work for some arch */
> >> +    if (ehdr->e_machine =3D=3D EM_PARISC ||
> >> +        ehdr->e_machine =3D=3D EM_ALPHA)
> >> +            return 0;
> >> +
> >> +    /* ELF is corrupted/truncated, avoid calling elf_strptr. */
> >> +    if (!elf_rawdata(elf_getscn(elf, ehdr->e_shstrndx), NULL))
> >> +            return 0;
> >> +
> >> +    while ((sec =3D elf_nextscn(elf, sec)) !=3D NULL) {
> >> +            char *sec_name;
> >> +
> >> +            if (!gelf_getshdr(sec, &shdr))
> >> +                    break;
> >> +
> >> +            if (!is_exe_text(shdr.sh_flags))
> >> +                    continue;
> >> +
> >> +            /* .init and .exit sections are not placed with .text */
> >> +            sec_name =3D elf_strptr(elf, ehdr->e_shstrndx, shdr.sh_na=
me);
> >> +            if (!sec_name ||
> >> +                strstarts(sec_name, ".init") ||
> >> +                strstarts(sec_name, ".exit"))
> >> +                    break;
> >
> > Do we really need this?  It seems my module has .init.text section
> > next to .text.
> >
> >   $ readelf -SW /lib/modules/`uname -r`/kernel/fs/ext4/ext4.ko
> >   There are 77 section headers, starting at offset 0x252e90:
> >
> >   Section Headers:
> >     [Nr] Name              Type            Address          Off    Size=
   ES Flg Lk Inf Al
> >     [ 0]                   NULL            0000000000000000 000000 0000=
00 00      0   0  0
> >     [ 1] .text             PROGBITS        0000000000000000 000040 079f=
a7 00  AX  0   0 16
> >     [ 2] .rela.text        RELA            0000000000000000 13c348 04f0=
c8 18   I 74   1  8
> >     [ 3] .init.text        PROGBITS        0000000000000000 079ff0 0006=
0c 00  AX  0   0 16
> >     ...
> >
> >
> > ALIGN(0x40 + 0x79fa7, 16) =3D 0x79ff0, right?
>
> But not in memory e.g.
>
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size   E=
S Flg Lk Inf Al
>   [ 3] .text             PROGBITS        0000000000000000 0000a0 071719 0=
0  AX  0   0 16
>   [ 5] .text.unlikely    PROGBITS        0000000000000000 0717b9 000a59 0=
0  AX  0   0  1
>   [ 7] .init.text        PROGBITS        0000000000000000 072212 0004fe 0=
0  AX  0   0  1
>   [ 9] .altinstr_replacement PROGBITS    0000000000000000 072710 000004 0=
0  AX  0   0  1
>   [10] .static_call.text PROGBITS        0000000000000000 072714 000388 0=
0  AX  0   0  4
>   [12] .exit.text        PROGBITS        0000000000000000 072a9c 000078 0=
0  AX  0   0  1
>
>
> /sys/module/ext4/sections/.text:                 0xffffffffc0453000
> /sys/module/ext4/sections/.text.unlikely:        0xffffffffc04c4719
> /sys/module/ext4/sections/.init.text:            0xffffffffc053e000
> /sys/module/ext4/sections/.altinstr_replacement: 0xffffffffc04c5172
> /sys/module/ext4/sections/.static_call.text:     0xffffffffc04c5178
> /sys/module/ext4/sections/.exit.text:            0xffffffffc04c5500
>
> Need to have:
>
>         section address - offset =3D=3D .text address - .text offset
>
> perf does not record the section address, but the kernel
> layout_sections() lays out executable sections in order
> starting with .text *until* it gets to .init* or .exit*.

Ok, thanks for the explanation!

Namhyung

