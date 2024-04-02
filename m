Return-Path: <linux-kernel+bounces-127583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70122894DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931AD1C225D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC95336D;
	Tue,  2 Apr 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uw95NDyf"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5F46B80
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047810; cv=none; b=HVTDhwofAQvQiP+u1dpScU0lGmQtCqerGiA6ORLrpQSJgaR8omWbX6hMzJW6gvhSThFffbIRWiLwwCOycjLoejbzUP2jCUyrBkAIzz4P5g7mROHEpE8DWeWLFEKLq84O+Xcw3uHbI+W2i7o1L1J+Vb2P0ngqnCTLH3XzRos+dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047810; c=relaxed/simple;
	bh=efnEV+jz+9UHrcY2jlfavBbD8PHpHnq48JZQ1nNzHus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/LVLwENnYthyNziPhpJ2jCcSA0xeKw7WMnJrnrx7D9mSkQiz3i87hSbU7pGvAFoRBLP3BnOJxvflWWTx4TCsrCCfm9zDyaomeRsQ/7LUOQh1q7LNu5rvDFDnkbvKGN0HjIR0jhvIahC0G0wLdCrwzELZwQS8FL+8WrsRwQuB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uw95NDyf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29f749b6667so3382633a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712047808; x=1712652608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz7rwc4geH+1dxlJ323CGCG7tEqlqWjReSINIJGPJKU=;
        b=Uw95NDyfLvUcd40aP83taY4Kfll3UA2QFAkPhfEH4R5selYNLNazDANvTtdm6mZ1fo
         dEsZe6neuj0eItcvXJTFHP76s+66C+S7IlZatCHqV15I+j1LYDIJ8giavZAzrRluoLvQ
         EDSvY8EgiOvLglj9BxI8QyAlh/T4mLvisHmiXFxufi8aEEekbO4zMksQvBxzdkWQGzoH
         Rntwx5sfIEFyhsRjisSodhoLiEfLbeiyW6c1W+VVNykFtoiHuFc3apoZZlHEoaqqH//k
         fQWlM75SqmGVi2CawulwUNldWlNn8Wddecc9pmpIBywYOsonuRSL1KUYKxPFMNe6Cyll
         4avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047808; x=1712652608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz7rwc4geH+1dxlJ323CGCG7tEqlqWjReSINIJGPJKU=;
        b=QMXCL75FQE/VdO+6cha/Fd0zSoGZcXO2Cuh2UL4iySfdqYAL/5rm329d5NLrwjwr5k
         IAYX9MOl17iO0HJmpz/LVZwjI1qAqJP9Rgb11xEXDI+uUfBHhF5cJryUMMewj/fRmSWL
         YbAZzDD0RiQqREbUzzofkfqcXXuuTMSTWZnfF6N4NDLzYCgvnWdDCCTx5J9n4sASAtWO
         IERro4ZePrZAM38gH3xNcKr0ZHviyEoHJsrLleBglcbr51tNxXIr8WktiPFx/xZWZnhH
         +DyBwc///9434lHwnL4QRzJxuPuXraOrqD7mlOJyV4ZdMBXcU65s9TENsBcTTz8p1byB
         EEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9KaLrouzpSyTPRuAtVJqOfidjxlGekegKi+dX9mZCvqpX5SgziPm9St863fYWnq32RDTmKXtJ/RilRot962X/PDzBMaflrPHCivbt
X-Gm-Message-State: AOJu0YzDTAW1Jmy3k9PJbQ7vnKJOD3O1RZpMjGklxVH4FHrAjzFY0PRr
	VK6lrbsXAbt7bg45udG6H0r8iyAld+m16Jp/19StasJtNjNJGd0uv3k1cjwQul1tswYVl0Tz/HN
	ax1QguFSf7XDAbB0nCmrCryxlxTYvSV9V8emM3g==
X-Google-Smtp-Source: AGHT+IFvJQlp+Burer3fvv1JlHoCyo4mxNBegfM0FSNZz2/mzilX0eYZN2AjeoVWsWMpj5C+SKTCju0yQPQS6KLpi5k=
X-Received: by 2002:a17:90b:46c6:b0:2a2:176f:fba9 with SMTP id
 jx6-20020a17090b46c600b002a2176ffba9mr9417095pjb.43.1712047808026; Tue, 02
 Apr 2024 01:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315015916.21545-1-daweilics@gmail.com> <ZgqOEJ5sCANkkk5N@linux.ibm.com>
 <CAG5MgCq3GT=CVj7Hz8rUMfNG1c9ypVsTSDKNESHV9tY_qWSt2g@mail.gmail.com> <e7d5bec3-be2a-4eea-b946-7f1739b0b4d0@linux.ibm.com>
In-Reply-To: <e7d5bec3-be2a-4eea-b946-7f1739b0b4d0@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 2 Apr 2024 10:49:56 +0200
Message-ID: <CAKfTPtCVQ7ooRuN-OroK90GGa2T7=HyK3kovmvJcgojvJhbwPQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix initial util_avg calculation
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Dawei Li <daweilics@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 at 10:44, Vishal Chourasia <vishalc@linux.ibm.com> wrote=
:
>
> On 02/04/24 11:17 am, Dawei Li wrote:
> > Hi Vishal
> >
> > Thanks for the comment!
> > Do you suggest using scale_load_down() in place of se_weight()?
> scale_load_down should be better.

se_weight is used for computing sched_entity's pelt signal so keep
using it looks better but all this clearly just nitpick because that
doesn't make any difference

> > It's a soft bug we should fix one way or another before what the
> > comment mentions really happens.
> IIUC, We should be moving towards using full load resolution
> for all the calculations. In that case, we need not worry about scaling l=
oad at
> all. Maybe someone could provide context here.
>
> > I am actually confused that we have both se_weight() and
> > scale_load_down(), and they do the same thing.
> >
> > Best regards,
> > Dawei
> >
> > On Mon, Apr 1, 2024 at 3:36=E2=80=AFAM Vishal Chourasia <vishalc@linux.=
ibm.com> wrote:
> >>
> >> On Thu, Mar 14, 2024 at 06:59:16PM -0700, Dawei Li wrote:
> >>> Change se->load.weight to se_weight(se) in the calculation for the
> >>> initial util_avg to avoid unnecessarily inflating the util_avg by 102=
4
> >>> times.
> >>>
> >>> The reason is that se->load.weight has the unit/scale as the scaled-u=
p
> >>> load, while cfs_rg->avg.load_avg has the unit/scale as the true task
> >>> weight (as mapped directly from the task's nice/priority value). With
> >>> CONFIG_32BIT, the scaled-up load is equal to the true task weight. Wi=
th
> >>> CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
> >>> Thus, the current code may inflate the util_avg by 1024 times. The
> >>> follow-up capping will not allow the util_avg value to go wild. But t=
he
> >>> calculation should have the correct logic.
> >>>
> >>> Signed-off-by: Dawei Li <daweilics@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - update the commit message
> >>> ---
> >>>  kernel/sched/fair.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index a19ea290b790..5f98f639bdb9 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_=
entity *se)
> >>>   * With new tasks being created, their initial util_avgs are extrapo=
lated
> >>>   * based on the cfs_rq's current util_avg:
> >>>   *
> >>> - *   util_avg =3D cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.loa=
d.weight
> >>> + *   util_avg =3D cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
> >>> + *           * se_weight(se)
> >>>   *
> >>>   * However, in many cases, the above util_avg does not give a desire=
d
> >>>   * value. Moreover, the sum of the util_avgs may be divergent, such
> >>> @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_stru=
ct *p)
> >>>
> >>>       if (cap > 0) {
> >>>               if (cfs_rq->avg.util_avg !=3D 0) {
> >>> -                     sa->util_avg  =3D cfs_rq->avg.util_avg * se->lo=
ad.weight;
> >>> +                     sa->util_avg  =3D cfs_rq->avg.util_avg * se_wei=
ght(se);
> >> Hi,
> >>
> >> The comment above the declaration of se_weight function says we should=
 be
> >> using full load resolution and get rid of this helper.
> >>
> >> Should we be adding new user of the helper?
> >>
> >> /*
> >>  * XXX we want to get rid of these helpers and use the full load resol=
ution.
> >>  */
> >> static inline long se_weight(struct sched_entity *se)
> >> {
> >>         return scale_load_down(se->load.weight);
> >> }
> >>
> >>
> >>>                       sa->util_avg /=3D (cfs_rq->avg.load_avg + 1);
> >>>
> >>>                       if (sa->util_avg > cap)
> >>> --
> >>> 2.40.1
> >>>
>

