Return-Path: <linux-kernel+bounces-107937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C958803C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED38B223F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBD2C6AA;
	Tue, 19 Mar 2024 17:42:14 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906D208A1;
	Tue, 19 Mar 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870134; cv=none; b=HhMl6/2uaaFNQLUAz0jxAR3AEyJrDKe+Hs87E7sOAlx3WjoJCw/BG/edgcjACei5i2gtohVZNXv0pHk+RXkBG+z/A1oUkCT02yBicqs6lKWZGIaIpMCOBvt7IO6/WJkYcqKy//BmaMtquX6Kn3KjVmNViVwCP54Xo2jT0kE1OLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870134; c=relaxed/simple;
	bh=AgU9Svcnbf6Lfrp1ANDmtgj8B8waw/EZGq1NnqZGO4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcDvZlLvbAVdJ6t1FwhKL1g1a59Lj/x+tgR3Scv7UqvIRS8uEakxsRdsragXVHU1BpyDxJuzxS/JkUF8XefPzkMVrDCcwgWosACZ3Dfw5q2aZ1w9LmPZlFnGOydM9QRs7UddvPINVtptKlTak0ZSMIzVdzCJUx3U4wslNvR/nPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29dfad24f36so2735037a91.0;
        Tue, 19 Mar 2024 10:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870132; x=1711474932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVvQsj8IKYVDEIpv3zumpFbZSz5ooPpC4xOYdmheWIo=;
        b=REHo9lvrT4DmiwVz+imZximn6DcsfRRxjVlxJPjoF6qXj0jQN/8Bqoz33lqs3kcdgb
         EXTc/mmalgp22B0JWD+HrceqlFLuUy6Kggmdmku3S1RAG28F2IN+x5mlR4MyqxytZCeB
         pslhkHzugkRMCilz54NKk4oq0QqhT+gQipEpya/ftaL5LyiIeLJWzRbLK6typmtWLt0Q
         5Mfhs+ZWPXhaSZeMXyz2aY8RE75vXYpydt+YCPweIjHaKfAqd0Z1o+3mT7kSr3YAArrY
         Ewyrk35UGxputD8r/TLii9c7gWMuJySw9zBc5Xzx1761w4GOx1SrQ+ROnAoRm2TRnGS/
         UthQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh6ycMSJJPxpavkMB9f7tUU82B9MMzUcXeqhsPcaD9ZRHAivKSBYBdr4xGPQcU2rh+adxI8FaiIhqmKCz1TpZTvXXd+aZKomv/UPEaoj6Y+JWMDJpU3GVMstKTqCakeg7NnTY/47HdH7MOSaCAhoMLSuTE1CNqe4bsT9YUhzzfD8yTb/L45Ib7kiqMCGFuA9p1hvfOaZo0LY0LN89N3rQ7YE5U/iqPXQm/FiZAWMOnFJ2o5g==
X-Gm-Message-State: AOJu0YzpUrjafnxpfB46LVCjhyBwfKqoq/XryTCGST5eTqhLbtU+AMQW
	JUL2Bx+owSzg4n8O4NjlHQIhzxcQj6+qm62bTYRvdMHuD2JD5NDOfB/eJttAmim6K5M9IqbmdXD
	aQv9oEQHr9du1g32A87zL4Bh65BI=
X-Google-Smtp-Source: AGHT+IHyJlZ4rJucpKnBC8DCvj4eCMKEgd05E859QaJGu3wsvLbSSvPpcTwXQxpMqy/r3LFHwtBNfpAyE+g3gw1luiI=
X-Received: by 2002:a17:90b:3c6:b0:29f:f1f0:88c2 with SMTP id
 go6-20020a17090b03c600b0029ff1f088c2mr822891pjb.4.1710870132007; Tue, 19 Mar
 2024 10:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-5-namhyung@kernel.org>
 <ZfmZobDmVFxEQ6hU@x1>
In-Reply-To: <ZfmZobDmVFxEQ6hU@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 10:42:00 -0700
Message-ID: <CAM9d7chdEcA7qFS3k=DGfeXcdZP1xWvdory_-Q0WFPfGi0St_Q@mail.gmail.com>
Subject: Re: [PATCH 04/23] perf dwarf-aux: Add die_find_func_rettype()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 18, 2024 at 10:50:56PM -0700, Namhyung Kim wrote:
> > The die_find_func_rettype() is to find a debug entry for the given
> > function name and sets the type information of the return value.  By
> > convention, it'd return the pointer to the type die (should be the
> > same as the given mem_die argument) if found, or NULL otherwise.
> >
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/dwarf-aux.c | 43 +++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/dwarf-aux.h |  4 ++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index cd9364d296b6..9080119a258c 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -696,6 +696,49 @@ Dwarf_Die *die_find_inlinefunc(Dwarf_Die *sp_die, =
Dwarf_Addr addr,
> >       return die_mem;
> >  }
> >
> > +static int __die_find_func_rettype_cb(Dwarf_Die *die_mem, void *data)
> > +{
> > +     const char *func_name;
> > +
> > +     if (dwarf_tag(die_mem) !=3D DW_TAG_subprogram)
> > +             return DIE_FIND_CB_SIBLING;
> > +
> > +     func_name =3D dwarf_diename(die_mem);
> > +     if (func_name && !strcmp(func_name, data))
> > +             return DIE_FIND_CB_END;
> > +
> > +     return DIE_FIND_CB_SIBLING;
> > +}
> > +
> > +/**
> > + * die_find_func_rettype - Search a return type of function
> > + * @cu_die: a CU DIE
> > + * @name: target function name
> > + * @die_mem: a buffer for result DIE
> > + *
> > + * Search a non-inlined function which matches to @name and stores the
> > + * return type of the function to @die_mem and returns it if found.
> > + * Returns NULL if failed.  Note that it doesn't needs to find a
> > + * definition of the function, so it doesn't match with address.
> > + * Most likely, it can find a declaration at the top level.  Thus the
> > + * callback function continues to sibling entries only.
> > + */
> > +Dwarf_Die *die_find_func_rettype(Dwarf_Die *cu_die, const char *name,
> > +                              Dwarf_Die *die_mem)
> > +{
> > +     Dwarf_Die tmp_die;
> > +
> > +     cu_die =3D die_find_child(cu_die, __die_find_func_rettype_cb,
> > +                             (void *)name, &tmp_die);
> > +     if (!cu_die)
> > +             return NULL;
> > +
> > +     if (die_get_real_type(&tmp_die, die_mem) =3D=3D NULL)
> > +             return NULL;
>
>
> Here you check die_get_real_type() return, may I go and do the same for
> the previous patch to address my review comment?

Sure thing! :)

