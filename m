Return-Path: <linux-kernel+bounces-67551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2175856D57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EA128C3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A8F139567;
	Thu, 15 Feb 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOP2x0be"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C71386B3;
	Thu, 15 Feb 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024087; cv=none; b=S3RUujtudBunO9gVORw1RAU96MeVGpHwnsJ1rAwhIEeqAXJinGdN2LUd8jauluYe1HDrKuLf58cilrWuMXa9/yVPXiFjFQqhhakEbY0usQw3ZkGFTxypvouzA9kS7p3arLcfyWzOTt0VqIboRuBEClTZnI8IFWu6ZgBYfpGcUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024087; c=relaxed/simple;
	bh=xUEvaW+4N6VgQMqkLNRIhjMY8wMfZAB4Z6nCLMSZX/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcLxSldWWc7fe7j6NHjvA4TQvfPEwAYgxaB5jUtYYWfg+DS8nyg5cPFDuJO4TqwRoguoa8oI4Ny6E3gtD8bkHJWsg8ku1MSVDhtck7lL/TDHV0j3rwAsViHPfmf80NhaxcY6fYKai0JBkCyB719dfiQG5AlbmsYsSL87j9SJp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOP2x0be; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d1025717c7so14416411fa.2;
        Thu, 15 Feb 2024 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708024084; x=1708628884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjTbENydrbuRWSXbS+/c8JRxZTMf9Ate8Q6rJufWxjU=;
        b=dOP2x0beCPOtmkYWC7Zl/nZ0PFiNjHDo9+A3nJMcnSKiY12a3uVC5XvuijRektzvbH
         z+o+78t4tEKni6Np89Mga8m9Pb6TBG1sLNsKjqhc33RjceYLIAP5+sq2TwhXfm+OscA1
         c307HMa92NR0EX+0yDzLJWJpxQ7c/F13KfNmqGkYGzeo9pWkmw760bCj8ZdW+iBzqsnc
         yiDkHU9sE+fG2Hs7vFosTtR73C33T6u2Iyk5WuKpQ2p0q2XT0ihH9kJNOIKPpriapalu
         A+FeJZp5/I4vbfw4IJeDPbHLVl5GDGhVFoLhljIbyKcbeJfQ9Wsajt1KMIUS0btQ4tvm
         ue3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024084; x=1708628884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjTbENydrbuRWSXbS+/c8JRxZTMf9Ate8Q6rJufWxjU=;
        b=k74gWkcOABaDT120tgn9gDUFKQasdHsYjIsL2ICdehuFxL67zl6Iy362DAgnyKIUMK
         nZyrj2jdVupVpjXBa9RaZ7OQerBWkOqFqIIaP3Lmd8V1u1O9xaaPU56RzMYVp8usQWB6
         L2ScJFUPB4M6mUGosUcWcnBZSx7dCYjBfogLdfSw1kAyjE/XC6z1cwNa62yCiKUquVOh
         1h/djUrROmTplT4l7sijzfVKJQMTiu9YFjQ16iMUIrxFvrSsgxBrkM4hBxYpKrU6iTel
         YJh1/zgyb7JuQM6sABVENcFH9vazc7LG0dGnURx6d5pJl8//vNV2v8oephPKGpXW6Jdc
         DsCw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMRDwKa2n00ZkLB1OM5ert0zWMDRCLhpKQ3vR4qk4VafSP9GVtA7LDWtxdvEx6TRAIPqi5Q+Ya6baDJ9rQxO3Mo9zNUM17CsR2KZ/bOnNgRMLC1uIfiQtrSsxg4cVumo0JWfl
X-Gm-Message-State: AOJu0YyJfpivKu3+EW0rBh1BwmJZf9i6fxE1x1P7fBoitNS5Vpv4dELg
	3qjtbtN5tbFT30O71AwQ82AlCb9wzUS57JSOuf4pgjCQzgwXhsJBcFkcmcAJg8m76PcDSrprnQ1
	JUc60tLh6vRtRCT6V9Ya7KRZWmxw=
X-Google-Smtp-Source: AGHT+IGvdwDuWE82135UuIcL3SI7YfwCsW9Gc4KSorhfuvqkkIcc6b9W6zcdrL/DBV38q26ho1PtyoR055v77S/alrE=
X-Received: by 2002:a2e:994d:0:b0:2d1:749:c85f with SMTP id
 r13-20020a2e994d000000b002d10749c85fmr1698386ljj.47.1708024083404; Thu, 15
 Feb 2024 11:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
 <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
 <ZcPMi6DX5PN4WwHr@google.com> <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
 <87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
 <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com>
 <CAMgjq7A+B4s52XYOFSan0fzUV-7o-GeAD3pfKkQtHo6uPHbrxQ@mail.gmail.com>
 <CAMgjq7BvTJmxrWQOJvkLt4g_jnvmx07NdU63sGeRMGde4Ov=gA@mail.gmail.com> <Zc1eXmliu09sElxQ@google.com>
In-Reply-To: <Zc1eXmliu09sElxQ@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Feb 2024 03:07:44 +0800
Message-ID: <CAMgjq7C4jWRB913Zmav5BWhL8VrQ7XOVZn62SdWBXrcUMpBEow@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Minchan Kim <minchan@kernel.org>, Barry Song <21cnbao@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:44=E2=80=AFAM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> Hi Kairui,
>

Hi, Minchan,

>
> I also played the swap refcount stuff ideas and encoutered a lot
> problems(e.g., kernel crash and/or data missing).
>
> Now I realize your original solution would be best to fix under such a
> small change.
>
> Folks, please chime in if you have another idea.
>
> >
> > Instead if we add a schedule or schedule_timeout_uninterruptible(1),
>
> How much your workload is going If we use schedule instead of
> schedule_timeout_uninterruptible(1)? If that doesn't increase the
> statistics a lot, I prefer the schedule.
> (TBH, I didn't care much about the stat since it would be
> very rare).

I've tested both schedule() and schedule_timeout_uninterruptible(1)
locally using the reproducer, and some other cases, and looked all
good.

The reproducer I provided demonstrates an extreme case, so I think
schedule() is good enough already.

I currently don't have any more benchmarks or tests, as the change is
very small for most workloads. I'll use schedule() here in V3 if no
one else has other suggestions.

I remember Barry's series about large folio swapin may change the ZRAM
read time depending on folio size, and cause strange races that's
different from the reproducer. Not sure if I can test using some known
race cases. That could be helpful to verify this fix and if schedule()
or schedule_timeout_uninterruptible(1) is better here.

> > it seems quite enough to avoid repeated page faults. I did following
> > test with the reproducer I provided in the commit message:
> >
> > Using ZRAM instead of brd for more realistic workload:
> > $ perf stat -e minor-faults,major-faults -I 30000 ./a.out
> >
> > Unpatched kernel:
> > #           time             counts unit events
> >     30.000096504             33,089      minor-faults:u
> >     30.000096504            958,745      major-faults:u
> >     60.000375308             22,150      minor-faults:u
> >     60.000375308          1,221,665      major-faults:u
> >     90.001062176             24,840      minor-faults:u
> >     90.001062176          1,005,427      major-faults:u
> >    120.004233268             23,634      minor-faults:u
> >    120.004233268          1,045,596      major-faults:u
> >    150.004530091             22,358      minor-faults:u
> >    150.004530091          1,097,871      major-faults:u
> >
> > Patched kernel:
> > #           time             counts unit events
> >     30.000069753            280,094      minor-faults:u
> >     30.000069753          1,198,871      major-faults:u
> >     60.000415915            436,862      minor-faults:u
> >     60.000415915            919,860      major-faults:u
> >     90.000651670            359,176      minor-faults:u
> >     90.000651670            955,340      major-faults:u
> >    120.001088135            289,137      minor-faults:u
> >    120.001088135            992,317      major-faults:u
> >
> > Indeed there is a huge increase of minor page faults, which indicate
> > the raced path returned without handling the fault. This reproducer
> > tries to maximize the race chance so the reading is more terrifying
> > than usual.
> >
> > But after adding a schedule/schedule_timeout_uninterruptible(1) after
> > swapcache_prepare failed, still using the same test:
> >
> > Patched kernel (adding a schedule() before goto out):
> > #           time             counts unit events
> >     30.000335901             43,066      minor-faults:u
> >     30.000335901          1,163,232      major-faults:u
> >     60.034629687             35,652      minor-faults:u
> >     60.034629687            844,188      major-faults:u
> >     90.034941472             34,957      minor-faults:u
> >     90.034941472          1,218,174      major-faults:u
> >    120.035255386             36,241      minor-faults:u
> >    120.035255386          1,073,395      major-faults:u
> >    150.035535786             33,057      minor-faults:u
> >    150.035535786          1,171,684      major-faults:u
> >
> > Patched kernel (adding a schedule_timeout_uninterruptible(1) before got=
o out):
> > #           time             counts unit events
> >     30.000044452             26,748      minor-faults:u
> >     30.000044452          1,202,064      major-faults:u
> >     60.000317379             19,883      minor-faults:u
> >     60.000317379          1,186,152      major-faults:u
> >     90.000568779             18,333      minor-faults:u
> >     90.000568779          1,151,015      major-faults:u
> >    120.000787253             22,844      minor-faults:u
> >    120.000787253            887,531      major-faults:u
> >    150.001309065             18,900      minor-faults:u
> >    150.001309065          1,211,894      major-faults:u
> >
> > The minor faults are basically the same as before, or even lower since
> > other races are also reduced, with no observable performance
> > regression so far.
> > If the vague margin of this schedule call is still concerning, I think
> > another approach is just a new swap map value for parallel cache
> > bypassed swapping to loop on.
>
> Long term, the swap map vaule would be good but for now, I prefer
> your original solution with some delay with schedule.

Yes, that's also what I have in mind.

With a swap map value, actually I think the cache bypassed path may
even go faster as it can simplify some swap map value change process,
but that requires quite some extra work and change, could be
introduced later as an optimization.

> Thanks, Kairui!

Thanks for the comments!

