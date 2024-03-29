Return-Path: <linux-kernel+bounces-125373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63E8924B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38C92852A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD913AA59;
	Fri, 29 Mar 2024 20:00:26 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E714131E59;
	Fri, 29 Mar 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742425; cv=none; b=OFuHNxgUzv7Go2zoty8nbjLuT006l/FgmehdTsKapZbXPXjB7WJqB1przQUmTeqIepIYeh+c2h/zbpY6p3hFLV+5/dtBcD2LEhTtpf3K2At5YVBf17h4ZPHbDNXZACK7W4JDUL4TPaS9qiZXVk0OulE3i7WhxT2WtDz3e0mNp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742425; c=relaxed/simple;
	bh=1++0DM8i0dqzmzqs3djr8ioXOPQ6taXqWCdJQmS/Xmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyxy69FfYZDy2rOUBCoyycd/GE542JjcCBFspvskiO0fdJhxJrdmVZqM6iHujA0EpuEyFs9DPa+7kxqqeAPoizIQBQPrEjJ6VOnfaf0eorpoY3PvDdFwdR2eSuvGixJhsOh++c1ACWq9YZ7pp6FzSmpRw0Hc4OaTqmn5U4f/qtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0ae065d24so20183495ad.1;
        Fri, 29 Mar 2024 13:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742424; x=1712347224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFkPPgjy4X9nQGJj/20EPL04yQHaXr6BMM0WUNjEyaw=;
        b=aNH9t83UcFmaUDIe/kiJSp1qjpwNnQfkuROMJ6SnafWA/2p9gLzHVlA5IQP1ahlgeP
         b9EjDhrGjtUtTOuDBSTFfmRaw+vZopTiMBz8q4mzJydk2ZJ3kb1ZlgsfyDhO173xzuuM
         rSwDQvHx36t58e/trymxJ4vrIUDiuZPfH21fpVfPfeSQI0LBgaHY5PEWk3pijShHMn98
         KfMjiBrwl+oszjeG14HeV/x6TyMVDVrYvowMwnZgF/4Y1EJuAZyO4cU2lcHlXAIe2zcL
         IauxL/gRNqA4xNtjsULV9E3Gulo9HMcEpYfcwM5lxGJyMGLJlLIqH/yzussZI+0cod45
         fsRg==
X-Forwarded-Encrypted: i=1; AJvYcCWu6jDRRiES2n/CUUx/8z6ilrdsWrEvvFJMe9X0/myBJa/+l2rL1IOiJ8IpUZEXK4V83+BbFAyFvXl2c5tmV8FZAuLqSClugHNScNUbjdUXF9+WwVj/XC5YWTGSp5gigVC/0MdqS9i4Hb4W258jOA==
X-Gm-Message-State: AOJu0YwIQY+MCxQgbv7LD7eNg4ZYfZ6lvsJYEEMJzEz4YL4OTHX1et0W
	3aOBPLNKQDy1hBZoFQwgceCILr1Ib0TJopxwUx0mEzlYKkLOKZ/eL3/zpJ7sIszrnBzZq4oDXsq
	zSL699442E3dB3R92YB0d0uh/8iI=
X-Google-Smtp-Source: AGHT+IGjOHUNw3fJhIoWBrwcrmm+A/t3n6jNxEjosPyMxmwtX/LVGK25RfHLaz3BdL4VHHEnyKH0Wn89HaZrjR3EJLk=
X-Received: by 2002:a17:902:d510:b0:1de:ffbc:8d95 with SMTP id
 b16-20020a170902d51000b001deffbc8d95mr3969864plg.67.1711742423073; Fri, 29
 Mar 2024 13:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9492dc44260c40598d1b282975eb9a4a@huawei.com>
In-Reply-To: <9492dc44260c40598d1b282975eb9a4a@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Mar 2024 13:00:10 -0700
Message-ID: <CAM9d7cgnBk03-yBBFtV37ryj13RROmaqjC9S3sUF7QhnRYrenw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf annotate: Use libcapstone to disassemble
To: duchangbin <changbin.du@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:53=E2=80=AFPM duchangbin <changbin.du@huawei.com>=
 wrote:
>
> Hi, Namhyung,
> On Thu, Mar 28, 2024 at 04:20:09PM -0700, Namhyung Kim wrote:
> > Now it can use the capstone library to disassemble the instructions.
> > Let's use that (if available) for perf annotate to speed up.  Currently
> > it only supports x86 architecture.  With this change I can see ~3x spee=
d
> > up in data type profiling.
> >
> > But note that capstone cannot give the source file and line number info=
.
> > For now, users should use the external objdump for that by specifying
> > the --objdump option explicitly.
> >
> > Cc: Changbin Du <changbin.du@huawei.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/disasm.c | 153 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 59ac37723990..c58ea6d822ed 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  #include <ctype.h>
> >  #include <errno.h>
> > +#include <fcntl.h>
> >  #include <inttypes.h>
> >  #include <libgen.h>
> >  #include <regex.h>
> > @@ -18,6 +19,7 @@
> >  #include "evsel.h"
> >  #include "map.h"
> >  #include "maps.h"
> > +#include "namespaces.h"
> >  #include "srcline.h"
> >  #include "symbol.h"
> >
> > @@ -1341,6 +1343,151 @@ symbol__disassemble_bpf_image(struct symbol *sy=
m,
> >       return 0;
> >  }
> >
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +#include <capstone/capstone.h>
> > +
> > +static int open_capstone_handle(struct annotate_args *args, bool is_64=
bit,
> > +                             csh *handle)
> > +{
> > +     struct annotation_options *opt =3D args->options;
> > +     cs_mode mode =3D is_64bit ? CS_MODE_64 : CS_MODE_32;
> > +
> > +     /* TODO: support more architectures */
> > +     if (!arch__is(args->arch, "x86"))
> > +             return -1;
> > +
> > +     if (cs_open(CS_ARCH_X86, mode, handle) !=3D CS_ERR_OK)
> > +             return -1;
> > +
> > +     if (!opt->disassembler_style ||
> > +         !strcmp(opt->disassembler_style, "att"))
> > +             cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> > +
> > +     /*
> > +      * Resolving address operands to symbols is implemented
> > +      * on x86 by investigating instruction details.
> > +      */
> > +     cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
> Enabling CS_OPT_DETAIL is to symbolize branch target address. You can ref=
er to
> print_insn_x86() in print_insn.c.

Right, I think we can add it as a comment.

Thanks,
Namhyung

