Return-Path: <linux-kernel+bounces-112022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFE887444
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C1D1C21C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CE37FBAE;
	Fri, 22 Mar 2024 20:54:19 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95B56B78;
	Fri, 22 Mar 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711140859; cv=none; b=RkJfMRHl1w/xA6Ogx4GpfP7aLtRQZRQ0DngbXQNiee9pFXDRaCTjjA8uNisJqoCPsnsvDWWfWukYDi8NHbNpE0jaelSDqM2+mTs2td1EeRJZbS0Sk89K5dQvRsDzmLEIw8jPUZeK7XjQgI0KnOKBNlimBNYLRRaBiz9bYSHEZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711140859; c=relaxed/simple;
	bh=qJ5FgNKO8igPyIl3IbFJ2DLkLzL3Nfy3AtmFj3UX4GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uU3gVB/7OWprbiQpHGUqN73xWAECkKULWbnPuXAyLnHeOs6Kbwh9s2mnzOzznaP5GAetF0dlaIkREA9jFVNE6nOBPZoX1qmjaf8oQVd7rrH6+y8RTOo4u/o/fmvdWWWNJ+3vI57ns9JdUNZLAz4XRtrB9X4vKyOibHSxhM23cN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29ddfada0d0so1520615a91.3;
        Fri, 22 Mar 2024 13:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711140857; x=1711745657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUvde+vJOWlMCi43uwRr3KT9dfStRwrN3Ih9yU0tQWg=;
        b=NA/Kko/KKb+aFSYpsdiSiQ5Zgaap+NWSbOslY5rkqTFV6tUM9iNrf1+1OOOUTdMGTS
         1pbilpuUK4fW8krpUrm/eYbyPr7lCF1yAYtP+72f0oN5wZwA2vFo6UGnbtyfbLPuUnvr
         PJNWN5yVDj7aad0Pl1+L3/Q7OcqspYfO8osTNuyOmsyIAFQwiMPRGMVQChUTuNwjIwMb
         zoCuwPNOA7ZZdyMPSWlHeXCL1dF3FbxFpIuGy49dpZ508LtxEAU+nJ76nmAEasAFiij3
         RCsmxRCZj01//PMZ22wSpgEZ9QkuUyiXa1YMvvNoj/bhMtlJJ4vOaGYX7gxodAMk1MKm
         1IPA==
X-Forwarded-Encrypted: i=1; AJvYcCUoP9Dj02RAIDN4f9w+bsrTDphvCCazjDyv5UxIefEtK/K7uHCS4eMMDM1UZUmPCneh0crdfF6mTUpfzxyKB8h1f3ThKSIgHIb6dBcHmey+1VKx3pkBNwvyR/LuLbpqWNfZ5AWtfbVcITaxE8qxzzKqk88nMiT2yHq/pg2VoKmCm5mZ4Q==
X-Gm-Message-State: AOJu0YzWKIsejpOrYtYEMP6Bcr3JLs3EvLnjwHbpaKrIJ22cqcFdl4XJ
	PrgdSO+wYrHEd5q9ccECKD95u6FZua/Jq/WT9OwDsJgxqtVdo4+Cgfaplub7Wj8NZXWGH6AvbRH
	8XqCHP+aPCb49a4jP3ezS6z6Gou4=
X-Google-Smtp-Source: AGHT+IELzPsVTYhLERrUtvP2iXqcjJxKY8QJnJyziAecrquP5sGkNIup/XnAa6SfQVg0FUDwqRnOjitipt83gZfy7jM=
X-Received: by 2002:a17:90a:dc02:b0:29f:6a6f:c42 with SMTP id
 i2-20020a17090adc0200b0029f6a6f0c42mr741135pjv.13.1711140857003; Fri, 22 Mar
 2024 13:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com> <20240321160300.1635121-5-irogers@google.com>
 <CAM9d7ciUwKrHsk3GencSDCRDEP0oUX6H99-uRmL=zf4gCgtdHQ@mail.gmail.com>
In-Reply-To: <CAM9d7ciUwKrHsk3GencSDCRDEP0oUX6H99-uRmL=zf4gCgtdHQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 22 Mar 2024 13:54:06 -0700
Message-ID: <CAM9d7chjyg9TyPLO68Tx3dWO1itT8bfMCuu4ATV_hV-47MjZUA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] perf dsos: Add dsos__for_each_dso
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:43=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Mar 21, 2024 at 9:03=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > To better abstract the dsos internals, add dsos__for_each_dso that
> > does a callback on each dso. This also means the read lock can be
> > correctly held.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
[SNIP]
> > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > index d269e09005a7..d43f64939b12 100644
> > --- a/tools/perf/util/dsos.c
> > +++ b/tools/perf/util/dsos.c
> > @@ -433,3 +433,19 @@ struct dso *dsos__find_kernel_dso(struct dsos *dso=
s)
> >         up_read(&dsos->lock);
> >         return res;
> >  }
> > +
> > +int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, v=
oid *data), void *data)
> > +{
> > +       struct dso *dso;
> > +
> > +       down_read(&dsos->lock);
> > +       list_for_each_entry(dso, &dsos->head, node) {
> > +               int err;
> > +
> > +               err =3D cb(dso, data);
> > +               if (err)
> > +                       return err;
>
> Please break and return the error to release the lock.

Hmm.. I saw this code was replaced by the next patch.
Then probably it'd be ok to leave it.

Thanks,
Namhyung

>
> > +       }
> > +       up_read(&dsos->lock);
> > +       return 0;
> > +}

