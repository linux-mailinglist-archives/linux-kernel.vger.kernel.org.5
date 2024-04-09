Return-Path: <linux-kernel+bounces-137270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5909389DFB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB228E86E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7E13AD08;
	Tue,  9 Apr 2024 15:51:26 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9713667F;
	Tue,  9 Apr 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677886; cv=none; b=jJGNhp18O2dq9E/vSAm98eg9XzHCKFW8EDhPR//54Z48LUcHJqHMZ7QA65/kA6KHqyVpS/54HcQ4IvfODzd/qkgB+r7RMXYagYgrl6y8wnV6YTnUQMQVtufqAKE1GBTMVENMgPBuToVK5AsOPXBAe5hPmrFij+gLzcTowbPr8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677886; c=relaxed/simple;
	bh=bdt/bR+NhJhIw+HiJQzVZ+Uyt6Q1HO/2VzhcIjPmoTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o466+usKKW1mM25VqIPyHMxibUGTyvzj6g10wE0HG96ZTQJ9R+UE5hc9jmvRjT1Vl8k6xaHAXrZXfWFl5vBunqw0okXoVxyWCPZa+uBG7XHDEOOZXZ00LqdVt3p5vROmgwYmlrYxeglk5BxeyV7MrEKzTQCORSm/u0X0YDzCP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so971554a91.2;
        Tue, 09 Apr 2024 08:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677884; x=1713282684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iStaDiJUNn76p5iia7p4n3GHyQy8GKOLFFVj9zvj24=;
        b=f+XQCxvgvTuXKc/OePur+WpAzG+xb6BqDiOCzpQHnBENPDtAq/stfqmX3hxRLxBZrX
         96BwX2A8kW9+y89WBZ5oG+KnIQ6l3QOZOHDswj0mhfHBcZ7JetnS3IFJrpnMdin2qfPp
         oMlsmDpfgKOyvEuoWPU6C0VkE8kWCV/WMz1ZZj94vMT3YIcC3THbuixSu+SheCeKj4nw
         +pGsOswbJpH8jFKkPA6xF65BAGhrW9x4iRotVBjjlDrCGY7OOiIarIRo9VMdq56Kz4Pc
         KegQff1SCQ2mTupByBTVdw4AXcy0lM4I85YpSERl+778lDvn8O+UxmqiI30TaWXZZbXl
         mCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXABpwJOHyz55AavmVnekvLn/R/Dy+D2Ft4swZjnICFPY0IvN9In/LvXMyiPAJTS/PUW/EEb6ltZqr7QhuLh/Ks8xk4MsXsQe/FYGqeZ9a6KNJnlNvWzYax7pNdRRcD0OzqBT7I9PBPKzRqR8/30A==
X-Gm-Message-State: AOJu0Yzh1c0o5hM06YNBGnigGzzir32mDlmSQOmhWz/xxM9HMHYCX3O/
	3MFR2p20Y302qC0AfUZxGIwJM7s13695J7V+akLdxq+GdsHeT06Sgk9/3mxBY8e0eWmhC9Z9Bho
	QKQ1uQLXgHv5apM2yzMUk2xCoR6s=
X-Google-Smtp-Source: AGHT+IGhizdnGDQXqrK8UwNhe+8FbSog4L66KyixWACXgLYZgdMqaNu4NhQkUn8w51V9Wcfs3wfw3jSBPQHXxAT3hjI=
X-Received: by 2002:a17:90b:11cd:b0:2a2:73e9:c3bf with SMTP id
 gv13-20020a17090b11cd00b002a273e9c3bfmr28936pjb.20.1712677884057; Tue, 09 Apr
 2024 08:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408185520.1550865-1-namhyung@kernel.org> <ZhRB4BULj1Y1f1TN@x1>
 <ZhTw7e+sy0wfzgR5@gmail.com> <ZhVJegoH7FKVtp0F@x1>
In-Reply-To: <ZhVJegoH7FKVtp0F@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 08:51:11 -0700
Message-ID: <CAM9d7ciifGEZt_hdDTZaQfQTjoCiHssWZB9Lg6cX26EOLZ=2=w@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo and Ingo,

On Tue, Apr 9, 2024 at 6:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Apr 09, 2024 at 09:40:29AM +0200, Ingo Molnar wrote:
> >
> > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > > On Mon, Apr 08, 2024 at 11:55:11AM -0700, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > I'm gonna carry these changes on the perf tools tree.  I'll update =
the
> > > > vhost.h once it lands on the mainline.
> > >
> > > Humm, maybe its not a good idea to do that this cycle?
> >
> > Maybe it's just me, but I've been looking sadly at all the header warni=
ngs
> > for months. :-) Would be better to keep them in sync with a bit higher
>
> I backtracked from asking for a delay, the reason for me first thinking
> about not doing it this time is because in perf-tools-next we have, to
> be merged for 6.10:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline torvalds/maste=
r.. | tail
> f324b73c2c05832b perf beauty: Stop using the copy of uapi/linux/prctl.h
> c8bfe3fad4f86a02 perf beauty: Move arch/x86/include/asm/irq_vectors.h cop=
y out of the directory used to build perf
> 7050e33e86ad03d2 perf beauty: Move uapi/sound/asound.h copy out of the di=
rectory used to build perf
> 44512bd6136ec7bb perf beauty: Move uapi/linux/usbdevice_fs.h copy out of =
the directory used to build perf
> ab3316119f9d0b3a perf beauty: Move uapi/linux/mount.h copy out of the dir=
ectory used to build perf
> 22916d2cbad9a20d perf beauty: Don't include uapi/linux/mount.h, use sys/m=
ount.h instead
> faf7217a397f041f perf beauty: Move uapi/linux/fs.h copy out of the direct=
ory used to build perf
> 5d8c646038f2f173 perf beauty: Fix dependency of tables using uapi/linux/m=
ount.h
> 4b3761eebb1c5c1b perf c2c: Fix a punctuation
> a9f4c6c999008c92 perf trace: Collect sys_nanosleep first argument
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> The reasoning for these changes is in the csets, for instance:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git show 7050e33e86ad03d2 | head=
 -21
> commit 7050e33e86ad03d26d7b969bba1d48ee159be496
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Mar 11 17:07:33 2024 -0300
>
>     perf beauty: Move uapi/sound/asound.h copy out of the directory used =
to build perf
>
>     It is used only to generate string tables, not to build perf, so move=
 it
>     to the tools/perf/trace/beauty/include/ hierarchy, that is used just =
for
>     scraping.
>
>     This is a something that should've have happened, as happened with th=
e
>     linux/socket.h scraper, do it now as Ian suggested while doing an
>     audit/refactor session in the headers used by perf.
>
>     Suggested-by: Ian Rogers <irogers@google.com>
>     Reviewed-by: Ian Rogers <irogers@google.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Link: https://lore.kernel.org/lkml/CAP-5=3DfWZVrpRufO4w-S4EcSi9STXcTA=
N2ERLwTSN7yrSSA-otQ@mail.gmail.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> I.e. I had moved some of the stuff that is being updated, but nah,
> better to have v6.9 tools/perf building without warnings, I'll fixup the
> merge when I merge perf-tools-next with torvalds/master after the
> updates are merged upstream.

Yeah I noticed that, but I thought it's better to keep v6.9 headers in
sync.  Please take care of them in perf-tools-next for v6.10.

>
> This is sometimes difficult to achieve tho or would require more pull
> requests to be sent to Linus to get some last minute changes, its not
> something common, but I think happened a few times.
>
> > frequency, IMO - which would reduce the pain and churn rate:
> >
> > > >  16 files changed, 809 insertions(+), 740 deletions(-)
> >
> > That's like about a year of changes missed? An update once per cycle an=
d
> > this wouldn't be nearly as painful, right?
>
> Humm, I haven't checked if it stays that long without merging, what I've
> agreed with Namhyung is to wait a bit for things to reach upstream, say
> -rc3, and then do the update, trying not to do these things nor early
> not late in the -rc sequence, to pick a sweet spot where most likely no
> changes will be made, we make the update and the perf build has no
> warnings in the final release.

I think we're doing it once per release cycle already.  This is just for v6=
9.
The kvm changes moved some code to arch directories.

This is what I did for v6.7.

https://lore.kernel.org/r/20231121225650.390246-1-namhyung@kernel.org/

Thanks,
Namhyung

