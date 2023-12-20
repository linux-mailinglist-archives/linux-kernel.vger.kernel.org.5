Return-Path: <linux-kernel+bounces-6160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA181952D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F4283BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460EC11732;
	Wed, 20 Dec 2023 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA3chXYD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A4EACD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fdde8b98so20337539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703031685; x=1703636485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfYZl5ZrcfbZuMK/TopLSwtg7XNXi/JhwSQdO+z2kF8=;
        b=kA3chXYDKidrsZZHlID8nlaRfCZJXE85UsL6eI+NdCwxBmxE4YCdIR0yoyYzj+9wJ/
         3XtiSbjmuV9s3lFQlHgEWEjHPH7XlNZOjQjMwUngeLvyLGnzE9A9tXmg3Zes41olPjpJ
         oI0hLR1/xQbsL6bmPI5Zm1Sih/UxLrpHQSPRJw4R+AZZEkN81x3fwxSeA/+knqROFcm+
         ygJY3prSJSjJVRxB061ijZ1joxMNjX5gtuqgVyKGIWv6b9dp8FU96wKqVLGP93OhW5PI
         0j1CSeijA3eC5vvswttqXM7Mo6G5tSEF7D4YjQKRvjAa6BT/MEJL/vUAXD6jqYGAtC8D
         3PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031685; x=1703636485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfYZl5ZrcfbZuMK/TopLSwtg7XNXi/JhwSQdO+z2kF8=;
        b=TcvHI7yKMsQTqaNWOxtsY8G5q/wEfJTmQy4iLfM0/e1+DQSFAP8cxs9fiJiXHrfGm2
         u8OrrDd0hriY5P2kgPVJdX0TCjWIqkyC6uKHWwNCNKiN2irLNZ+pJ/Zp8JeWQwuwNm+F
         JXr1Y2e1O0S3W9wikq3E80eksEPUAhRxs4HNsFCP9vVGct8MRqqLZCJS//96NCMzajTu
         j/iEPxAGNBvDQ1HexmKtcUdP48JF5myvNc5lwAqh6i0GDHPqT+xLk7WGbdFkBVUy7jvm
         fHBtGFmV9GascGzAjSW+lUWZCMw+/7xBfX1N6baoKOdH8198xPMnRBSHNhackliagqTb
         yY1A==
X-Gm-Message-State: AOJu0YxNPm5vDMP27VfrugLZ+IVJWGkeLNG0j1sEs9qwB6hchu6GSvRg
	BMXy15ZRnNwY010aN+dK8Jl66xRZC+lxfz/cVGrAUKmgc1usow==
X-Google-Smtp-Source: AGHT+IH8HoIT17fSSZbOHgb3YqJpC/ukBGjW+e32jgnnwlNoqvIMO1p3SvoENHMGYIpCveLGx+INexzbqhJKFp11Vsk=
X-Received: by 2002:a05:6602:123b:b0:7ba:72f2:430c with SMTP id
 z27-20020a056602123b00b007ba72f2430cmr127233iot.6.1703031684948; Tue, 19 Dec
 2023 16:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211052850.3513230-1-debug.penguin32@gmail.com>
 <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com>
 <CALk6Uxog_LLF2dec2J54baMfee8jCOEabjWLG6-L=FEyZ-FFBQ@mail.gmail.com>
 <CAKEwX=OwFk7aL-PGE4JBR0qy5NzbDbSmPGyu8yd7FK+yU8mRBg@mail.gmail.com> <CALk6Uxp_vKh2y-Fjh5=0gP_gmBZTLuJ8T0CLAFedRp79zaJikQ@mail.gmail.com>
In-Reply-To: <CALk6Uxp_vKh2y-Fjh5=0gP_gmBZTLuJ8T0CLAFedRp79zaJikQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 19 Dec 2023 16:21:13 -0800
Message-ID: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: sjenning@redhat.com, akpm@linux-foundation.org, 
	Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:04=E2=80=AFAM Ronald Monthero
<debug.penguin32@gmail.com> wrote:
>
> On Thu, Dec 14, 2023 at 10:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> ..
> < snipped >
>
> > I should have been clearer. I'm not against the change per-se - I
> > agree that we should replace create_workqueue() with
> > alloc_workqueue(). What I meant was, IIUC, there are two behavioral
> > changes with this new workqueue creation:
> >
> > a) We're replacing a bounded workqueue (which as you noted, is fixed
> > by create_workqueue()) with an unbounded one (WQ_UNBOUND). This seems
> > fine to me - I doubt locality buys us much here.
>
> Yes the workqueue attribute change per se but the existing
> functionality remains seamless and the change is more a forward
> looking change. imo under a memory pressure scenario an unbound
> workqueue might workaround the scenario better as the number of
> backing pools is dynamic. And with the WQ_UNBOUND attribute the
> scheduler is more open to exercise some improvisations in any
> demanding scenarios for offloading cpu time slicing for workers, ie if
> any other worker of the same primary cpu had to be served due to
> workers with WQ_HIGHPRI and WQ_CPU_INTENSIVE.Although normal and
> highpri worker-pools don't interact with each other, the target cpu
> atleast need not be the same if our worker for zswap is WQ_UNBOUND.

I don't object to the change per-se. I just meant that these
changes/discussion should be spelled out in the patch's changelog :)
IMHO, we should document behavior changes if there are any. For
instance, when we switched to kmap_local_page() for zswap, there is a
discussion in the changelog regarding how it differs from the old (and
deprecated) kmap_atomic():

https://lore.kernel.org/linux-mm/20231127160058.586446-1-fabio.maria.de.fra=
ncesco@linux.intel.com/

and how that difference doesn't matter in the case of zswap.

>
> Also noting that the existing wq of zwap worker has the WQ_MEM_RECLAIM
> attribute, so is there a rescue worker for zswap during a memory
> pressure scenario ?
> Quoting: "All work items which might be used on code paths that handle
> memory reclaim are required to be queued on wq's that have a
> rescue-worker reserved for execution under memory pressure. Else it is
> possible that the worker-pool deadlocks waiting for execution contexts
> to free up"

Seems like it, but this behavior is not changed by your patch :) So
i'm not too concerned by it one way or another.

>
> Also additional thought if adding WQ_FREEZABLE attribute while
> creating the zswap worker make sense in scenarios to handle freeze and
> unfreeze of specific cgroups or file system wide freeze and unfreeze
> scenarios ? Does zswap worker participate in freeze/unfreeze code path
> scenarios ?

I don't think so, no? This zswap worker is scheduled upon the zswap
pool limit hit (which happens on the zswap store/swapping/memory
reclaim) path.

>
> > b) create_workqueue() limits the number of concurrent per-cpu
> > execution contexts at 1 (i.e only one single global reclaimer),
> > whereas after this patch this is set to the default value. This seems
> > fine to me too - I don't remember us taking advantage of the previous
> > concurrency limitation. Also, in practice, the task_struct is
> > one-to-one with the zswap_pool's anyway, and most of the time, there
> > is just a single pool being used. (But it begs the question - what's
> > the point of using 0 instead of 1 here?)
>
> Nothing in particular but I left it at default 0, which can go upto
> 256 ( @maxactive per cpu).
> But if zswap worker is always intended to only have 1 active worker per c=
pu,
> then that's fine with 1, otherwise a default setting might be flexible
> for scaling.
> just a thought, does having a higher value help for larger memory systems=
  ?

I don't think having higher value helps here tbh. We only have one
work_struct per pool, so it shouldn't make a difference either way :)

>
> > Both seem fine (to me anyway - other reviewers feel free to take a
> > look and fact-check everything). I just feel like this should be
> > explicitly noted in the changelog, IMHO, in case we are mistaken and
> > need to revisit this :) Either way, not a NACK from me.
>
> Thanks Nhat, for checking. Above are my thoughts, I could be missing
> some info or incorrect
> on certain fronts so I would seek clarifications.
> Also thanks in advance to other experts/maintainers, please share
> feedback and suggestions.
>
> BR,
> ronald

Also +Chris Li, who is also working on improving zswap :)

