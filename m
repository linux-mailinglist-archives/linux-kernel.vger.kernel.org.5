Return-Path: <linux-kernel+bounces-55708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B184C098
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B85285014
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A61C69A;
	Tue,  6 Feb 2024 23:04:51 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6441CD19;
	Tue,  6 Feb 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260691; cv=none; b=aO0VG/nFXeVkK1t/Fby6grcRM6LgAru+pzjUn6G4dhnmw6O9uPxXlJMec+/EU0N5b7aEEI/HghMu/UZsZEMcFLFgySg3ZoIX9q5kAEwDVeCAHbiuwko8p/gdw5QHlp0sQ6CXkd3fx1V9BccExYT+fW1LGdVTtecrsD2OQ/PcLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260691; c=relaxed/simple;
	bh=Bj7WtUHXfxhehFCeqs9x6LDb+Zbzpz0PHoSScUvtbLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2SyhKKLJoqYEgNsKKQeR3mcUinznILv+ffGzSg6sNgTEjdAWZ0hDTFGEcT2FbUNZxbIRsM4YIYd2UVDcEIMG/2uQscL/NasDEN0iuSUKslamr2XlZ1OWbeUsRpkpuAMIziR1YvYzdDSYnfbWP+UR7TT2BtX+IFNN60JUKaGRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e065abd351so37758b3a.3;
        Tue, 06 Feb 2024 15:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260689; x=1707865489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE3O5UKIKUsuneAmY5uurD5IR5hTBLYsMxi5qNrCvNs=;
        b=aRuYa7Pjq11fb8ZSsj4ztTS0kz1v63EwRYlx3w5mgCedd//E1dy7io8fmdp5WXegJ7
         wYRag++UkUqf5JhKNefsOSE0ocBigDRX8ZcJO1xx9vx9fhduyGvNgYPfv5k4fgefbGP9
         +ddbmXR/dnhdp28Wq2WyyhL39EUy8+GtCZy14SWWSXRrl70M5aZJYlqasTk+LZQQ8Q+/
         6kEnaJ/lj3YIIXfytGoTfNCR55auaWhDoPBt9oMjbyn1hJJNtkDswVprI7hh1pvsqEvm
         LsI5n1FT3uu2UYeHQ/VGn8Qzpv74mMpng5mMTZ0zVxKbx58fyHGCAJAiB+4srsbtGQ6O
         lw1g==
X-Gm-Message-State: AOJu0Yx87HauGVA7rPL76Dm2ECQTyWxXEUqhTxeN6tEVsdvOg8Ce0mMM
	gb3VWW+DbddOa9LRmvtac6Hfn0lHFSrQrL+8VmzJeezYDVOjlPYLDzwhTM3xSdStiPtyUrslbjf
	1HmAnjyJ0dN5KB7Lxg+76ncdsNWc=
X-Google-Smtp-Source: AGHT+IFnEmvVibr+uu5//nP9pgk/kUwAycQEoetjEX9yE3zHB+a5GSKRf1IWuIznL14ypiF2+avDP99fbP25kTPI67I=
X-Received: by 2002:a05:6a00:2283:b0:6e0:5ea0:d3bf with SMTP id
 f3-20020a056a00228300b006e05ea0d3bfmr1190550pfe.7.1707260689194; Tue, 06 Feb
 2024 15:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-5-namhyung@kernel.org>
 <CAP-5=fU=P-ib+n+OfqJAbm8gS2RY-W-KcBskoSHkC+aCmXYcXQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU=P-ib+n+OfqJAbm8gS2RY-W-KcBskoSHkC+aCmXYcXQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 15:04:37 -0800
Message-ID: <CAM9d7chvEw6r8_7agxOpWxufTo+dLaNForSFFShCFGd9KDBtoA@mail.gmail.com>
Subject: Re: [PATCH 04/14] perf map: Add map__objdump_2rip()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Fri, Feb 2, 2024 at 5:42=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Sometimes we want to convert an address in objdump output to
> > map-relative address to match with a sample data.  Let's add
> > map__objdump_2rip() for that.
>
> Hi Namhyung,
>
> I think the naming can be better here. Aren't the objdump addresses
> DSO relative offsets? Is the relative IP relative to the map or the
> DSO?

AFAIK the objdump addresses are DSO-relative and rip is to map.
They are mostly the same but sometimes different due to kASLR
for the kernel.

>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/map.c | 20 ++++++++++++++++++++
> >  tools/perf/util/map.h |  3 +++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 54c67cb7ecef..66542864b7b5 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -594,6 +594,26 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
> >         return ip + map__reloc(map);
> >  }
> >
> > +u64 map__objdump_2rip(struct map *map, u64 ip)
> > +{
> > +       const struct dso *dso =3D map__dso(map);
> > +
> > +       if (!dso->adjust_symbols)
> > +               return ip;
> > +
> > +       if (dso->rel)
> > +               return ip + map__pgoff(map);
> > +
> > +       /*
> > +        * kernel modules also have DSO_TYPE_USER in dso->kernel,
> > +        * but all kernel modules are ET_REL, so won't get here.
> > +        */

Hmm.. This comment is not true anymore.  Will remove
in other places too.

Thanks,
Namhyung


> > +       if (dso->kernel =3D=3D DSO_SPACE__USER)
> > +               return ip - dso->text_offset;
> > +
> > +       return map__map_ip(map, ip + map__reloc(map));
> > +}
> > +
> >  bool map__contains_symbol(const struct map *map, const struct symbol *=
sym)
> >  {
> >         u64 ip =3D map__unmap_ip(map, sym->start);
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 49756716cb13..65e2609fa1b1 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -132,6 +132,9 @@ u64 map__rip_2objdump(struct map *map, u64 rip);
> >  /* objdump address -> memory address */
> >  u64 map__objdump_2mem(struct map *map, u64 ip);
> >
> > +/* objdump address -> rip */
> > +u64 map__objdump_2rip(struct map *map, u64 ip);
> > +
> >  struct symbol;
> >  struct thread;
> >
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

