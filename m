Return-Path: <linux-kernel+bounces-124169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59446891356
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F07C1F22231
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6A3CF7D;
	Fri, 29 Mar 2024 05:46:14 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733C3A8F7;
	Fri, 29 Mar 2024 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691174; cv=none; b=dGr/mzODk+Nmr1adlITiEy5TwCs+tSRKEAXlikNp9qahEXwDpITVTVJB554tprE0sw7UKFEPlSVhrH4tUoDi5OyBeA3MuzA+282swe/p6b171Ot3D5lAv4NxTdPtTTjm5UYKJ+0+6DJ4iVjL2KywU9l+Tum9B50qHURYDUVD/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691174; c=relaxed/simple;
	bh=KGwkGKtTA4rDrrqayQ/alyrWXig3KMsQmbrIPNkMeVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXnx+HrYOW5OdmcKRdDeqk5swJr+gvQZQwY3+H5v8D4YBEKiZY2lPLeLS+vgNRNyTDAZaU64o7+TwTJ+3tOk5eZnRH9TgaYPgZ73C9y1OkSs5a+3mDRM9NbmIBxJwUqsfglV8bsbPbtQz05QOOqk4r0a4oWEPpLt5rp4HykGRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2005943a12.0;
        Thu, 28 Mar 2024 22:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711691172; x=1712295972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+2vFU7V6j+41AhIjyIIqYWwenIJmg7wdwdRq1cmkxY=;
        b=QNYNrzIfoBI7hQN81eQOz3SIdLxjH91jl8NqjRwagkC4kiuu4Ad/R9Eyx11s07wjca
         ZSAWDmjokDZEFyEJHQBBWU+fUTyGqX+h9eW6fXsDCsKHKWND5T3lE05W9fst5pFuigyN
         Vu7b9yzMO7j3jGB0DsV5CsehM1uymVHCQjhlE7CKRTren/trGhIsjmLvjXICJto3VM/9
         zRN2uvOBEeB2OnS4/kD9i9v3rjlEymIvi0SDH/Kri6CPzkf+IZUGNCGgtFapGCFQbs0l
         JH7pj8zu9ugzIKjgXYcT/VhUOw6tuMv67xHBUsmPjLhOtUyNMDxx4tB7vm9d6YSseKo2
         oy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmWzz+tzDSQvYV2Xm2PUXACMZqrY4SDJcY9Xa8iqmorcWPXWY87FIO2MvadOt3p1dkwUgUVDFkGFcSResOmyKzhOcUFN6voykCP6Je7Yk6NeS3aaTob6qLzG47/2LXnbNVtElZVxKytcHJ7kE0RQ==
X-Gm-Message-State: AOJu0Yz926NRS4gRBY45eV39DcNgohqrYyXK90EMvVrO6A96SeGkeBRf
	CnWtfcf45tnDSM8CMSXtzrSn90livGOuGNfUKiWoE8KCIyajOlih928/567xRIDjjiKy6szE2Xb
	cZMK+t/OuQXTt1zTUvA/Y9cQSFCY=
X-Google-Smtp-Source: AGHT+IGOWkjpAWMSh8kylWMgdIo5zIaFj4PviWIV/PQJ1w4zEnYGxJLHyo5hOs8EE4FiY3pOLbnZc5CCTxzJF8XlLrs=
X-Received: by 2002:a17:90a:8284:b0:2a0:4e60:ba46 with SMTP id
 g4-20020a17090a828400b002a04e60ba46mr2209931pjn.16.1711691172259; Thu, 28 Mar
 2024 22:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326202859.960577-1-weilin.wang@intel.com> <20240326202859.960577-2-weilin.wang@intel.com>
In-Reply-To: <20240326202859.960577-2-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 28 Mar 2024 22:46:00 -0700
Message-ID: <CAM9d7cjm6uOhffsiuVKk=2GBEUBZUyhNe-5QM5--tw3-X+UBJw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:29=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Metrics that use tpebs values would use the :retire_latency keyword in
> formulas. We put all these events into a list and pass the list to perf
> record to collect their retire latency value.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> @@ -681,8 +685,56 @@ static int metricgroup__build_event_string(struct st=
rbuf *events,
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *sep, *rsep, *id =3D cur->pkey;
>                 enum perf_tool_event ev;
> +               /*
> +                * Parse and search for event name with retire_latency mo=
difier.
> +                * If found, put event name into the tpebs_events list. T=
his list
> +                * of events will be passed to perf record for sampling t=
o get
> +                * their reitre_latency value.
> +                * Search for ":R" in event name without "@". Search for =
the
> +                * last "@R" in event name with "@".

What is the retire_latency modifier exactly?
Why do you search for :R and @R?  What's the difference?
Why don't you search for "retire_latency"?

Thanks,
Namhyung


> +                */
> +               char *p =3D strstr(id, ":R");
> +               char *p1 =3D strstr(id, "@R");
> +
> +               if (p =3D=3D NULL && p1) {
> +                       p =3D strstr(p1+1, "@R");
> +                       if (p =3D=3D NULL)
> +                               p =3D p1;
> +                       p =3D p+1;
> +               }
> +
> +               if (p) {
> +                       char *name;
> +                       char *at;
> +                       struct tpebs_event *new_event =3D malloc(sizeof(s=
truct tpebs_event));
>
> -               pr_debug("found event %s\n", id);
> +                       if (!new_event)
> +                               return -ENOMEM;
> +
> +                       new_event->tpebs_name =3D strdup(id);
> +                       *p =3D '\0';
> +                       name =3D malloc(strlen(id) + 2);
> +                       if (!name)
> +                               return -ENOMEM;
> +
> +                       at =3D strchr(id, '@');
> +                       if (at !=3D NULL) {
> +                               *at =3D '/';
> +                               at =3D strchr(id, '@');
> +                               *at =3D '/';
> +                               strcpy(name, id);
> +                               strcat(name, "p");
> +                       } else {
> +                               strcpy(name, id);
> +                               strcat(name, ":p");
> +                       }
> +                       new_event->name =3D name;
> +                       *tpebs_event_size +=3D 1;
> +                       pr_debug("retire_latency required, tpebs_event_si=
ze=3D%lu, new_event=3D%s\n",
> +                               *tpebs_event_size, new_event->name);
> +                       list_add_tail(&new_event->nd, tpebs_events);
> +                       continue;
> +               }
>
>                 /* Always move tool events outside of the group. */
>                 ev =3D perf_tool_event__from_str(id);

