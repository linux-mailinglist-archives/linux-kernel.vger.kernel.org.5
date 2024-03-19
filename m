Return-Path: <linux-kernel+bounces-107925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A258803A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2391F25E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22020B21;
	Tue, 19 Mar 2024 17:40:11 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0362B9BA;
	Tue, 19 Mar 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870010; cv=none; b=Hm/zE/4y/8YoApzYhbA/pchQmIjra1wtdTLb4Th3ICKywTHt7UVxlXx6I1tZZh7xPuQj/IdTekz4URBeRqBBoeQlce4mPiaQoFqAqfR6x7bqPhy/wyrKqWU/hDBie6Z+vYAfFupHSI8ULSuhcFqwgwPGYkx+WHGP0R3RO7oRvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870010; c=relaxed/simple;
	bh=MhtixsmRO9wFMNPa7fZ+A1C63+g4Vno5+EgJASe3E04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vq1kPDlX93B65XdY1DrOBvjICyTOyw6USZFtKqhdwmSYAvdB0J6W0riBGTLmQ+kg+oPg749Vy4FGfinckkQY29BalsA4u4pPvx+j1OxI//YuI8He5rgfrxla+w1re5vFgH4eZJaIw68hBkLmhL8U+Wkfx3YvjOMC42KTyEKVCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29de4e12d12so4147328a91.3;
        Tue, 19 Mar 2024 10:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870009; x=1711474809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh275OKIsAYQ5o+GHxL9VNQG4dc3doJhtyP2ubPY/Z8=;
        b=PlwWOiS0hu8V9MsEQZU6ID8Ew/CV0zr8FRgkiumAPMQFTdNQ4QG7JaPGf7EjxB8SmB
         Xj+NPes5YR72SGsmBQonFO3HpwaJe9tiZuR/jTcBPiFL33oGYQUyNnFDcsh5JQbfgri3
         V++96vKi2rU6HPIWOKiP5GzT6okDy4M0q+2UwXdmb/JMmwE71wdTsY107CDfhBeWbqRh
         llDLrFWrxRAcJQTR/Dt1idZXTm3EAi1VBC3ZmMsS3r7CfBuFj4NDihVj7oWJVKcjDhaI
         mIl5UEmRqQVr52dEmxmxl/XaMTf9NG+9iDABRr2gBfqBWqZzTHlYmT/bcj+elZWCsBT4
         DdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8gggwmTdcVGzSPLWbFeg40KW06TdEenyoMAzHpFor1hs3eg8sMRQlTor4Acp5yFa9F3WcgfMia9QTqCzhmFDaqIK8wW40LhUYeDQ7fyGTskH1ViJ0o69D5P/H1hwq99JM2440kjEu05iaP2+7tjBYIi5mFmu+C7bb0stIAJCwQuLo59MYDqwVAsrXwgHkKy8kQBpc2i4Hy/DHWGydNeSyXDkxifJyFNUVSDxNrdHN9G9meg==
X-Gm-Message-State: AOJu0Yyq4iOrAzIG8lygF8SlRX77mRTFrilFIhnTfPokLgmWnOiH5sVC
	PTqbGMaF+neur46OItjvGsbAn7Hjl/TGGUaH4viM8W9RxQXRnSulnthJKk8IMYY8QOfs0EI5ugA
	1lxbJFlOM5x75uxbpFUlDdo7fEyRsNw7f
X-Google-Smtp-Source: AGHT+IFiRXVc5OoJ0hTZM0ANlRt2pYfdwl7srRGMkaCNCC9FY2P/oXFOO8VZ2L36SCVsBHcHH7PesVORwZ7PyNWqqVI=
X-Received: by 2002:a17:90b:788:b0:29c:844:a91 with SMTP id
 l8-20020a17090b078800b0029c08440a91mr11532418pjz.48.1710870008555; Tue, 19
 Mar 2024 10:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-2-namhyung@kernel.org>
 <ZfmWgbkApCMoeWHm@x1>
In-Reply-To: <ZfmWgbkApCMoeWHm@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 10:39:56 -0700
Message-ID: <CAM9d7cgm_-zyiZpCVoKH2dfqEESO5ohZYHYRnnBFWxagDiMrqA@mail.gmail.com>
Subject: Re: [PATCH 01/23] perf dwarf-aux: Remove unused pc argument
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

On Tue, Mar 19, 2024 at 6:43=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 18, 2024 at 10:50:53PM -0700, Namhyung Kim wrote:
> > It's not used, let's get rid of it.
>
> I looked for data->pc, there is usage somewhere else, but not via
> __die_find_var_addr_cb() nor match_var_offset().
>
> I think renaming:
>
>   struct find_var_data data;
>
> to:
>
>   struct find_var_data var;
>
> And:
>
>   struct find_scope_data data;
>
> to:
>
>   struct find_scope_data scope;
>
> Helps with grepping for 'data->pc', but that can be left for later.

Ok, I can rename them later.

>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for the review!
Namhyung

>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate-data.c | 4 ++--
> >  tools/perf/util/dwarf-aux.c     | 7 ++-----
> >  tools/perf/util/dwarf-aux.h     | 6 ++----
> >  3 files changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate=
-data.c
> > index 30c4d19fcf11..59ce5f4f4a40 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -263,7 +263,7 @@ static int find_data_type_die(struct debuginfo *di,=
 u64 pc, u64 addr,
> >       offset =3D loc->offset;
> >
> >       if (reg =3D=3D DWARF_REG_PC) {
> > -             if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die=
, &offset)) {
> > +             if (die_find_variable_by_addr(&cu_die, addr, &var_die, &o=
ffset)) {
> >                       ret =3D check_variable(&var_die, type_die, offset=
,
> >                                            /*is_pointer=3D*/false);
> >                       loc->offset =3D offset;
> > @@ -312,7 +312,7 @@ static int find_data_type_die(struct debuginfo *di,=
 u64 pc, u64 addr,
> >       /* Search from the inner-most scope to the outer */
> >       for (i =3D nr_scopes - 1; i >=3D 0; i--) {
> >               if (reg =3D=3D DWARF_REG_PC) {
> > -                     if (!die_find_variable_by_addr(&scopes[i], pc, ad=
dr,
> > +                     if (!die_find_variable_by_addr(&scopes[i], addr,
> >                                                      &var_die, &offset)=
)
> >                               continue;
> >               } else {
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 2791126069b4..e84d0d6a7750 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1456,7 +1456,6 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_=
mem, void *arg)
> >  /**
> >   * die_find_variable_by_addr - Find variable located at given address
> >   * @sc_die: a scope DIE
> > - * @pc: the program address to find
> >   * @addr: the data address to find
> >   * @die_mem: a buffer to save the resulting DIE
> >   * @offset: the offset in the resulting type
> > @@ -1464,12 +1463,10 @@ static int __die_find_var_addr_cb(Dwarf_Die *di=
e_mem, void *arg)
> >   * Find the variable DIE located at the given address (in PC-relative =
mode).
> >   * This is usually for global variables.
> >   */
> > -Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
> > -                                  Dwarf_Addr addr, Dwarf_Die *die_mem,
> > -                                  int *offset)
> > +Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr add=
r,
> > +                                  Dwarf_Die *die_mem, int *offset)
> >  {
> >       struct find_var_data data =3D {
> > -             .pc =3D pc,
> >               .addr =3D addr,
> >       };
> >       Dwarf_Die *result;
> > diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> > index 85dd527ae1f7..9973801a20c1 100644
> > --- a/tools/perf/util/dwarf-aux.h
> > +++ b/tools/perf/util/dwarf-aux.h
> > @@ -146,9 +146,8 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_d=
ie, Dwarf_Addr pc, int reg,
> >                                   Dwarf_Die *die_mem);
> >
> >  /* Find a (global) variable located in the 'addr' */
> > -Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
> > -                                  Dwarf_Addr addr, Dwarf_Die *die_mem,
> > -                                  int *offset);
> > +Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr add=
r,
> > +                                  Dwarf_Die *die_mem, int *offset);
> >
> >  #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
> >
> > @@ -170,7 +169,6 @@ static inline Dwarf_Die *die_find_variable_by_reg(D=
warf_Die *sc_die __maybe_unus
> >  }
> >
> >  static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die _=
_maybe_unused,
> > -                                                Dwarf_Addr pc __maybe_=
unused,
> >                                                  Dwarf_Addr addr __mayb=
e_unused,
> >                                                  Dwarf_Die *die_mem __m=
aybe_unused,
> >                                                  int *offset __maybe_un=
used)
> > --
> > 2.44.0.291.gc1ea87d7ee-goog
> >

