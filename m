Return-Path: <linux-kernel+bounces-60282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD885028F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D56B2865CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0BC6121;
	Sat, 10 Feb 2024 04:42:24 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ABB23B0;
	Sat, 10 Feb 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707540143; cv=none; b=nSKWRiMUdxZy0DSHd55qTFu9HuXNT7usZpm/fI5MiUxH0/+9f9fLUpVFSEFy3/MyA2n7Cqrwcr9/7xjVHeETH2vnL+vNeuY3dDryJcaaIzKxhtA/u5iZr9EkWAbVRpMs092ZKIxMGrZf2GUnUMP5B6rAax6TR5M1e9U20oM7YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707540143; c=relaxed/simple;
	bh=T2ASNije7gX81LNlvMmud6Kc73BC7zKEk9U2E6S4JHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZxflUoZ36MKd7XYQZQb213YBCsa172dRnqlAN79fcYtpOMAvs1WKzNvCt9Uw0H+VkdebBU5yJKT9WWOGoNy7gE5JHgqkprEhrsuaSPGkMcsik+Bqcm6HymxsnZJCgI0CfQTQGv86xEWYcUYiYmS+UCS8yExc9DZWIeAILZLdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-296dc0cab6aso1162575a91.1;
        Fri, 09 Feb 2024 20:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707540142; x=1708144942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOncT+gChfuvB+kGoeOPvG9sQftVVeruKeAijPzHPfs=;
        b=sDW29X7NCNTJ3BMDakpX2GDwOjk6OX1raT3c9YBRKzhhh+1rm67wne/fzSMoHpoFEB
         DDJFGHRNWLqVyQu7s5tSBnnQtaiCQESQXWxlFT2vQJXUmrQlBNdERtqcDwFA7F1OU654
         oOZsAMRnHMUTL8ITJKYcnPtr3k3V5aPP3ZrgITxWjPuO71RjXrGeIGkb1ZwCgP2KDS+7
         h6m3pAlsoTX5f8jIz/GzsOFv19EcwziWB66Rzmp5e2OQb6jeBfKZvK9h/O2lG9vEQUDs
         QhbBQtFZrOtJRcH5z1icRzTNt/jiNyeftlv9IWvX7Bl8o/ZfgC0rvt1fQNn4YDlwRr1x
         t4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Os+/5gpkwLNEHHWMB7HF+bjc973nHmzXBXaRw/O7oWyyHNcQYMMRUsFWaNHZOjwR/oGpzF7zRoXjtaJnPGGEoqi/z117pebTHjESNraQDW9WhHT46PpC/Wq9wD7vz8QTV06cqFC8rc4T3rDxVw==
X-Gm-Message-State: AOJu0Yxz/3Q0RZ+8fyAqXKypP5GytVhNMUFSCHM9vW9T4PArL0A9HYkU
	PGp/GvSOT5SmlFOg966lUNihjO52dtJLFSI2lqQkd/F3kNyre/0tipuMrwlUxQ6sKcWub9fqSYb
	oUfb/p2wLXEP9G5dF3UbLjxqyTlI4kPIK7WY=
X-Google-Smtp-Source: AGHT+IEEOGs8eYYJcn54c8V2Nckuq5c37tHGiBPyRpxxSegy6QGfNKKjHBSxfglzNgWTCxni6d3Zo8RdJT+D7EK6/r0=
X-Received: by 2002:a17:90a:6f46:b0:296:4e2f:a680 with SMTP id
 d64-20020a17090a6f4600b002964e2fa680mr4366458pjk.10.1707540141565; Fri, 09
 Feb 2024 20:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-8-irogers@google.com>
 <CAM9d7cih+JqmhVOSoYmRUK2+FRWnknQ6VucYpg5ZC01BYqdv=Q@mail.gmail.com>
In-Reply-To: <CAM9d7cih+JqmhVOSoYmRUK2+FRWnknQ6VucYpg5ZC01BYqdv=Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Feb 2024 20:42:09 -0800
Message-ID: <CAM9d7ci-qxL0r6SOh0_bktS33OBf6JoOE3LJzmcZgZV_uNzcLA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf srcline: Add missed addr2line closes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 4:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Jan 31, 2024 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The child_process for addr2line sets in and out to -1 so that pipes
> > get created. It is the caller's responsibility to close the pipes,
> > finish_command doesn't do it. Add the missed closes.
> >
> > Fixes: b3801e791231 ("perf srcline: Simplify addr2line subprocess")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/srcline.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > index 034b496df297..7addc34afcf5 100644
> > --- a/tools/perf/util/srcline.c
> > +++ b/tools/perf/util/srcline.c
> > @@ -399,6 +399,8 @@ static void addr2line_subprocess_cleanup(struct chi=
ld_process *a2l)
> >                 kill(a2l->pid, SIGKILL);
> >                 finish_command(a2l); /* ignore result, we don't care */
> >                 a2l->pid =3D -1;
> > +               close(a2l->in);
> > +               close(a2l->out);
>
> I was about to ask the stderr, but addr2line_subprocess_init()
> sets a2l->no_stderr already.
>
> I wish it could be handled in finish_command() but it seems
> the API allows setting external file descriptors (before calling
> start_command).  Hmm..
>
> Anyway it looks like an independent fix.

I'll apply this separately.

Thanks,
Namhyung

