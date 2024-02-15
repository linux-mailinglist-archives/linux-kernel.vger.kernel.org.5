Return-Path: <linux-kernel+bounces-66308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92602855A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B1528DE50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0BB67D;
	Thu, 15 Feb 2024 05:26:56 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F228E6;
	Thu, 15 Feb 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974815; cv=none; b=rVR1aebahD7A1B8M6RZ0pUomu6lp/GWyJ/XQJ3jph8LT/yHueAeuGKzpc4ditYirCczPDp6aT8j03oCAXk1H8otCM5aJz9jI2QacCAFRFXza/WUSOi7urATCI0/9HBDdvPXXO2fgkFWS4Jo9ihy1DRFjQ0Y9qclGnh2bBTpTNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974815; c=relaxed/simple;
	bh=qudj50MsrXJBc2/l83E4vE1vsmzaPnBg5wtWaZSUQj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4UIN2ioCLeUpoWI/+Ytsvy93r7Iwi4ed4VkCWMpWvqWi+akCRnX4ItZBFsZn1hATuwsW/ujSucjaZ+IXeb2wQ6qKPpWZjGzxBsMBmE7dUQltReyAO08plPqZLb8eqOd6AWw6enlM1Htr7cbdFI8zX/AS+/LkhfSiDSQpiV86ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso487155b3a.2;
        Wed, 14 Feb 2024 21:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707974813; x=1708579613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyxQNQK0uTNTZnSbnKT+Xd+wPCudPnqbKEQ4MhMWKww=;
        b=MKvvTxz6I5o8Pp3hPlWDf5TTdcH96ErbNQHjC3xnHXQeqo2cFwrOUnL9Ia+ZKE8JAL
         AkkReJMDlIPhXK0HTHx3w+koQwOlVZyzMb1nFwhKZlyPnm5PPqRHYXbpIClRVnM5YYXc
         nBJFudn+Ay0sbTvnEbE5If9cXtG6DeeLxI//q5QjAQ/LT50l+VOsHPv5uDAj5hbwTN68
         BU4iHlfew597Fv6Izs+u0t/WCfIpJaa+iIvh2ob9U2xSAIFNP1PziF6+wy5EJgQbEvpA
         tz02ijqRf/ofmQGS126RwZ9JEkuPuSfiusYrdBcLTJ9jVGjElLGlAM1UoonhMRrlD6QK
         xQHw==
X-Forwarded-Encrypted: i=1; AJvYcCWLxaMRcHYrh2kCC6YvpUbdWNh/8VR/n8pc7pFQ3frVVIRAAKFlyTPcaApsiXCNgnuNRaWYXutUvqdUE5hV7U4/ZSelDwelocgpNW3StR7GAN6z/W1i58yWtwSUPgOCCKF03Oc6Dg6PJ+HVvYNirg==
X-Gm-Message-State: AOJu0YwwhS1uxUi5d55xZXkBgVBMPKro+1Ee/v1B/4pnwJfMc0ltPm+K
	SWarEI9GrWl147CrEgLtJAWii+F9jRHzGBaPmWILHBgjrqjCWOYuJE5zMf5ZvJM85LkK59bIOpN
	Lz5vlOOKHAjLrp2WlIavIEdq6X2Q=
X-Google-Smtp-Source: AGHT+IEKyBJy0sJXXBsHFFb1FNMTg2xrIDX2tzbjZziRV4o2wa90sAynADD13Lf1l/4XttxWvw/70AFodOP3rcjbs/s=
X-Received: by 2002:a05:6a21:164e:b0:19e:b925:f191 with SMTP id
 no14-20020a056a21164e00b0019eb925f191mr962704pzb.10.1707974813584; Wed, 14
 Feb 2024 21:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-4-namhyung@kernel.org>
 <CAP-5=fVK3vvNoaGHPep8NCweGw9cztKBGQh5+0bVX91PhWp5Eg@mail.gmail.com>
In-Reply-To: <CAP-5=fVK3vvNoaGHPep8NCweGw9cztKBGQh5+0bVX91PhWp5Eg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 14 Feb 2024 21:26:42 -0800
Message-ID: <CAM9d7ci=A9rwZxEYYQRi-Cncs7NSpRG+TaH5knTdEPZYxJWp9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf hist: Do not use event index in hpp__fmt()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 4:08=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Feb 12, 2024 at 11:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > The __hpp__fmt() is to print period values in a hist entry.  It handles
> > event groups using linked pair entries.  Until now, it used event index
> > to print values of group members.  But we want to make it more robust
> > and support groups even if some members in the group were removed.
>
> I'm unclear how it breaks currently. The evsel idx is set the evlist
> nr_entries on creation and not updated by a remove. A remove may
> change a groups leader, should the remove also make the next entry's
> index idx that of the previous group leader?

The evsel__group_idx() returns evsel->idx - leader->idx.
If it has a group event {A, B, C} then the index would be 0, 1, 2.
If it removes B, the group would be {A, C} with index 0 and 2.
The nr_members is 2 now so it cannot use index 2 for C.

Note that we cannot change the index of C because some information
like annotation histogram relies on the index.

>
> > Let's use an index table from evsel to value array so that we can skip
> > dummy events in the output later.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/hist.c | 34 ++++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index 5f4c110d840f..9c4c738edde1 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -48,15 +48,30 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct =
hist_entry *he,
> >         if (evsel__is_group_event(evsel)) {
> >                 int idx;
> >                 struct hist_entry *pair;
> > -               int nr_members =3D evsel->core.nr_members;
> > +               int nr_members =3D evsel->core.nr_members - 1;
>
> A comment on the -1 would be useful.

The 'nr_members' includes the leader which is already printed.
In this code, we want to print member events only, hence -1.
I'll add it to the comment.

Thanks,
Namhyung

>
> Thanks,
> Ian
>
>
> >                 union {
> >                         u64 period;
> >                         double percent;
> >                 } *val;
> > +               struct evsel *member;
> > +               struct evsel **idx_table;
> >
> >                 val =3D calloc(nr_members, sizeof(*val));
> >                 if (val =3D=3D NULL)
> > -                       return 0;
> > +                       goto out;
> > +
> > +               idx_table =3D calloc(nr_members, sizeof(*idx_table));
> > +               if (idx_table =3D=3D NULL)
> > +                       goto out;
> > +
> > +               /*
> > +                * Build an index table for each evsel to the val array=
.
> > +                * It cannot use evsel->core.idx because removed events=
 might
> > +                * create a hole so the index is not consecutive anymor=
e.
> > +                */
> > +               idx =3D 0;
> > +               for_each_group_member(member, evsel)
> > +                       idx_table[idx++] =3D member;
> >
> >                 /* collect values in the group members */
> >                 list_for_each_entry(pair, &he->pairs.head, pairs.node) =
{
> > @@ -66,8 +81,15 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct h=
ist_entry *he,
> >                         if (!total)
> >                                 continue;
> >
> > -                       evsel =3D hists_to_evsel(pair->hists);
> > -                       idx =3D evsel__group_idx(evsel);
> > +                       member =3D hists_to_evsel(pair->hists);
> > +                       for (idx =3D 0; idx < nr_members; idx++) {
> > +                               if (idx_table[idx] =3D=3D member)
> > +                                       break;
> > +                       }
> > +
> > +                       /* this should not happen */
> > +                       if (idx =3D=3D nr_members)
> > +                               continue;
> >
> >                         if (fmt_percent)
> >                                 val[idx].percent =3D 100.0 * period / t=
otal;
> > @@ -75,8 +97,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hi=
st_entry *he,
> >                                 val[idx].period =3D period;
> >                 }
> >
> > -               /* idx starts from 1 to skip the leader event */
> > -               for (idx =3D 1; idx < nr_members; idx++) {
> > +               for (idx =3D 0; idx < nr_members; idx++) {
> >                         if (fmt_percent) {
> >                                 ret +=3D hpp__call_print_fn(hpp, print_=
fn,
> >                                                           fmt, len, val=
[idx].percent);
> > @@ -89,6 +110,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct h=
ist_entry *he,
> >                 free(val);
> >         }
> >
> > +out:
> >         /*
> >          * Restore original buf and size as it's where caller expects
> >          * the result will be saved.
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

