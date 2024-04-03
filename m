Return-Path: <linux-kernel+bounces-130540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79478979AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B9B2183D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE53155308;
	Wed,  3 Apr 2024 20:15:36 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A96BE4D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175336; cv=none; b=KlkZptzrDekh9Q4js7cbiVPsy47lIKo1hxco6tU/hv1RaxaAP4HiHU/OqX+VVUYw4ITcnmUCAHBVDulCvF8r7O76XhBemm9mLXSOXyeLMslSotDy0NuvWbYjVyP6bzlXwh83SBOJVIhKTNxZfF+Lckh+J+WKhVflGiqyL/d/y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175336; c=relaxed/simple;
	bh=KvOEtLyuXPGn5vvFqMeIvsE64RMxdq6BxREYcuVaCMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB55i6w0+by7qywFwWVTY3m6y58g20DYXDbS3MCFmNy52RUrW3JL8P1GVG5YVig08+urKnPGrqbHVLT6iIgGcOp/MnnXvbXHxwxx0PYwU8bCgwHyO/cIw7NMamM0ckoELnwZ42ndEYS9o5kRt567WxY8qJj0T3DYMfCijIjJ7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e782e955adso194885b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712175334; x=1712780134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svGwFWmbfUiAfQcf8SsuBavSqOlyPN+DUVCm92e3kPU=;
        b=BqAJjttNfz05ZIm7prEYoWiMbLhkIhDqfawUsNczEEE92NA8dlgYD3+nCTmMwx1rFN
         iW8PGVPfYl4mJ16fiVoxzl61av3fDaNKZn3TH1AI5cXZFtTX8YoUh/eQJK636E8Hlsek
         ymQLN7ICnWPtAKiA7wRLOJ2oIMxy8zAdV61Bq/SPUjUS3seeRkXfYALzFayr4jm533o4
         vYVO+fq/l2jnAdGTTAzlP+zUUUkqtIV2Enh4I/Vilm29t/P6oLJjrc7TSX/WZ0kS637g
         z4AJRlPCvd8F0OSafzajd7uABLeFgm/Sb4BCkhFCuABbCPZIsQRMqvYWKy3NUETWcX2G
         wrHg==
X-Forwarded-Encrypted: i=1; AJvYcCVN+6jH9dKiopwgkskYJUFQt2uB4vMSmL4TZaJ4r/RVT+hdSv4sD7W4Ypr7LQIB79KYeWiyEU+17YdhEqCKObCNfA7xwHApHV8oYqsM
X-Gm-Message-State: AOJu0YxslPZ+v5Ge6U5XPyQo5Ifwn/5krttbL64Jqe7JRhHNjfzll9V4
	iGVweVwzGRWvA7KWSfSdHQh3shcOQUouAtyiyFPzQ80eGDmA9lV379xC8iSij1+6hndktlJThiZ
	JwFK0ldCYOT7NRls9UwchljVEGSKpCE8S
X-Google-Smtp-Source: AGHT+IFHsRB2fVoD7qY7l0X2gxuw4o0MzZbGGeL+LivVrBtsX0npWgPK6fAgrmxiSW/ijcQ/t0m7C+eHwmHKId3pVrk=
X-Received: by 2002:a05:6a21:8183:b0:1a3:8984:b334 with SMTP id
 pd3-20020a056a21818300b001a38984b334mr725027pzb.22.1712175334172; Wed, 03 Apr
 2024 13:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zg1ywF7uRsfXYfYS@x1> <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>
 <Zg2zfKFdGCJaYc36@x1>
In-Reply-To: <Zg2zfKFdGCJaYc36@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 3 Apr 2024 13:15:22 -0700
Message-ID: <CAM9d7cgPxFS2FRc+FETXV4z7ev-SCesDNcQihs5qdA_KZ2pOew@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf annotate: Initialize 'arch' variable not to trip
 some -Werror=maybe-uninitialized
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:52=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 03, 2024 at 09:01:56AM -0700, Ian Rogers wrote:
> > On Wed, Apr 3, 2024 at 8:16=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > In some older distros the build is failing due to
> > > -Werror=3Dmaybe-uninitialized, in this case we know that this isn't t=
he
> > > case because 'arch' gets initialized by evsel__get_arch(), so just in=
it
> > > it to NULL to silence those cases.
> > >
> > > E.g.:
> > >
> > >     32    17.12 opensuse:15.5                 : FAIL gcc version 7.5.=
0 (SUSE Linux)
> > >         util/annotate.c: In function 'hist_entry__get_data_type':
> > >     util/annotate.c:2269:15: error: 'arch' may be used uninitialized =
in this function [-Werror=3Dmaybe-uninitialized]
> > >       struct arch *arch;
> > >                    ^~~~
> > >     cc1: all warnings being treated as errors
> > >
> > >       43     7.30 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.=
5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> > >     util/annotate.c: In function 'hist_entry__get_data_type':
> > >     util/annotate.c:2351:36: error: 'arch' may be used uninitialized =
in this function [-Werror=3Dmaybe-uninitialized]
> > >        if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
> > >                                         ^~~~~~~~~~~~~~~~~~~~~
> > >     cc1: all warnings being treated as errors
> > >
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > This looks fine but I couldn't line up the errors with code in the
> > tree. I was curious why the "maybe-uninitialized" was failing. Perhaps
> > evsel__get_arch should set the out argument to NULL when an error
> > occurs. This fix is also good but may potentially need repeating for
> > other evsel__get_arch cases, so a fix in evsel__get_arch may be
> > preferable.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Trying with this on top, i.e. what you suggests:
>
> From 70e6fd996ce7f9c9adbb30640ed666025bf6f1e4 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 3 Apr 2024 16:49:54 -0300
> Subject: [PATCH 1/1] WIP
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/annotate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index f316e0b65897957a..35235147b111e788 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -838,8 +838,10 @@ static int evsel__get_arch(struct evsel *evsel, stru=
ct arch **parch)
>         struct arch *arch;
>         int err;
>
> -       if (!arch_name)
> +       if (!arch_name) {
> +               *parch =3D NULL;
>                 return errno;
> +       }
>
>         *parch =3D arch =3D arch__find(arch_name);
>         if (arch =3D=3D NULL) {
> @@ -2266,7 +2268,7 @@ struct annotated_data_type *hist_entry__get_data_ty=
pe(struct hist_entry *he)
>  {
>         struct map_symbol *ms =3D &he->ms;
>         struct evsel *evsel =3D hists_to_evsel(he->hists);
> -       struct arch *arch =3D NULL;
> +       struct arch *arch;
>         struct disasm_line *dl;
>         struct annotated_insn_loc loc;
>         struct annotated_op_loc *op_loc;
> --
> 2.44.0
>

