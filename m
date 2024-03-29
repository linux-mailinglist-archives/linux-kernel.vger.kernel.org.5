Return-Path: <linux-kernel+bounces-125371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E568924B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E092850EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BB13AA48;
	Fri, 29 Mar 2024 19:57:50 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DA13A403;
	Fri, 29 Mar 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742269; cv=none; b=L4+CT4agXuegKc3zTGsyn7bkr3vIwOmbHF7rZZ7OzfZNPRk/wjIMTR2T0rFht7RXY5xH0UJ7+2ial2MXzD2ktC+wb/85CBpVz3REaifPuZ9ulyDbrMWBAeN8CBUgmkRdd1S6v7sdCSwEWFksSPV0XDoKV0j5RSH6LgmyEK41+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742269; c=relaxed/simple;
	bh=Eb00Nd/4FbSasWchIqCKO3IHhuDaMWOWUkVBp3B0ox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFU6XDTl9GkCxi7eNG8pKtFPUgQ1JA4NqX68RglFinj/5ycwtJZNJN5oYZUS7qEa6/ARt7kk6mZPFu/M4Pjg0b005FgZn23ypn8XyUT8mreKNzHnDdYuo+oalqseAhLNfqhoCcyJIeaiyxqPSWHyKaSkT4jOmVMdlmiwzSTe5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a1fdcc3659so1698570a91.2;
        Fri, 29 Mar 2024 12:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742267; x=1712347067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s8+DG4ef6vbCXZ0BFAbjvZwYptw5QONeO+ShZzGSPg=;
        b=JeEkGCJOvjMBO9pszmPrO20uVOxiX/XbgYiHN1VSHZFTsjbX2oueMDJp/Xscb4OnvE
         qSSm7nxFUMDt6VxqQZE/UJwLcnTBK1LvnkdIVs79ZE6LncpiPER1Pll6smFM/cSt3w+3
         awSHFJ8asK0vTOkjxq9k2oU8AzLd798ZhtndvAgEOfFnwEQoURCdDRs2rLOoAYYEm6Oa
         mpN2/CTYl37dlETLTJ622F6gXQiHZOUouChptkJ0Po6n4TLiNRlcSh2hUwWJzepug0cu
         E/WEzADO3jTUE+pwnR5dWNb/20uMeS1TgUyMrVxdU+TCxNI/M3KZYKTCtz9DhCw5Fcke
         NAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/kuIfsj45XlyM2cii8nIbLmFZWE6weWf1SCna7NqZQ7dgG217qjf+IsKdjfL7Cix2US8dwz2Ly9j6XjmlhSLB6XJYZE5FPA05yTFcBSaWmkiDnbV4jP9jzHbwYM+QoTq4zSOh5vshsk1JPn0xw==
X-Gm-Message-State: AOJu0YwvDDN7WvnkMSMDvSA0HUi0W7oQn+Q4fDxzNmkJQT6cy9jxiPdP
	i3IrqBCxDlogR7IsMFydQ95qblNffOHwoBaqDNhGVaQJDOi0M3aEQh+VEP5ti2Qe5W9CQ3GxrOm
	juDY9ZwBpNnP4rSYvHtsgYbvXaZgDVKNt
X-Google-Smtp-Source: AGHT+IH/pE83jaS/PrbeuhjhlBOBUisEkV4Y5Yp/ZkBehFXfAAt2MGsiU78RoVrQeIoUFGSxiu7bSwGCiOebu0gqUus=
X-Received: by 2002:a17:90a:7e03:b0:299:5b95:cd7d with SMTP id
 i3-20020a17090a7e0300b002995b95cd7dmr2762225pjl.45.1711742267378; Fri, 29 Mar
 2024 12:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328232009.466018-1-namhyung@kernel.org> <CAP-5=fX296_EROp6D+zX4OOABOkwkHrE-2v7F0K=Jo5zSZ_-zw@mail.gmail.com>
In-Reply-To: <CAP-5=fX296_EROp6D+zX4OOABOkwkHrE-2v7F0K=Jo5zSZ_-zw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Mar 2024 12:57:35 -0700
Message-ID: <CAM9d7cgyMFZLvacgV6SKazzy2Vg7Kk=qTtDyPef1W8fVFNy+cQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate: Use libcapstone as a disasssembler
To: Ian Rogers <irogers@google.com>
Cc: Changbin Du <changbin.du@huawei.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Fri, Mar 29, 2024 at 9:33=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 28, 2024 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > As we've added libcapstone support, it's natural to use it for perf ann=
otate
> > as well.  This change added the capstone support on x86 first.  Other a=
rchs
> > can be added later (by someone who can verify it doesn't break things).
> >
> > For now it tries to use capstone (if available) before objdump.  But it
> > doesn't support source file and line number info.  So users should use =
the
> > objdump (by passing --objdump=3DPATH option) if they need them.  For ex=
ample,
> > this command line will keep the existing behavior (i.e. using objdump).
> >
> >   # not to use capstone for disassembly
> >   $ perf annotate --objdump=3Dobjdump
> >
> > The capstone uses LLVM objdump style output which is slightly different=
 than
> > the GNU objdump.  But it should not have differences besides that.  I'v=
e
> > verified the result of data type profiling and it produced the same out=
put
> > but gave me ~3x speedups.
> >
> > Thanks,
> > Namhyung
>
> I wanted to see what -fsanitize=3Daddress would think of libcaptstone
> and no issues,  so:
>
> Tested-by: Ian Rogers <irogers@google.com>

Thanks for checking it!

>
> Some thoughts:
>  - it may be worth adding to the commit message in "perf annotate:
> Split out util/disasm.c" that there's no functional change,
>  - we lack perf annotate testing,
>  - it seems capstone should be opt-out rather than opt-in as a library
> dependency (given the performance delta and the objdump interactions
> are at best messy),
>  - if libcapstone could solve our addr2line issues too this would be grea=
t :-).

I think addr2line should be handled using libdw.  I'll take a look.

Thanks,
Namhyung

