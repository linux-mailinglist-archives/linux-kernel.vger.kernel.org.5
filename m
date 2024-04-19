Return-Path: <linux-kernel+bounces-151226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0368AAB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8069286F99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64787CF17;
	Fri, 19 Apr 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgFNtVIn"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1309762E5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518433; cv=none; b=kCej9xLJQ8E3cRMrtyE1uZkHRSU40DFCk7y5K66rGV/ehAH08BHpscdxitUjHntpl7llrF2uWwJ7ylPA1L17okmNRu9lCXcl2JcsQhwNTfHqAQZtr2+muPbEu9zHyTJG/4mP9Sc6dpNgEajNck1LS2Pa6Ke+yVuptJcPt3PI6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518433; c=relaxed/simple;
	bh=f/XXKW3CQGCLxHJFsZ56dca+Iom4O86+CCs87u021U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llbZZu78E6NuVo2sIK6St3lEfdJ3ZPxBcvxsY8P8GBBfu1Y/JAHrWwTmC0dTDn4NjzEzvYMDRVEyL3OxIczGmVVgePUNGZQpt05jEIIJCO/QV2a3ZHGw8tM56AUrEwDUu9uh/6zRL8ZxJiABm+lol3xaV1+VXsIR888n0KTfttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgFNtVIn; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c70b652154so1132263b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713518431; x=1714123231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZb5Wu31Ln+HxhQBqmF3digZI4BhULWU+f2EciYJo+E=;
        b=GgFNtVIn2BnK2QFZEiNEg0LYSJze+fvbfDjHxDnFD8yjNChiunXyJpZyubZaSbLUkd
         QtpaDLKO90RxtDuTs682fg0AqgXi07pEuAa9GrYtz2F0OZLLUEgyC96puc2EStzCJJoc
         48tchDj5M6br9uSXlKAUOF+aSPCO0do0ohJxDpNAWCGXT+iXcaII4+AoLZqOvKtWbwea
         4OWYWs6UbkQ82b464WINKNbshp+Hm+kSL/mZcvbEDZNb1BaY7NdW5bk8sFsVVu/PXHq6
         UR8bY0BEqqzqs4IZ8rN5Mxnz/0ppaSQVqbJbxhk/86MLdTmqCwrU2LKuiKCKKpnktVaZ
         jfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518431; x=1714123231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZb5Wu31Ln+HxhQBqmF3digZI4BhULWU+f2EciYJo+E=;
        b=AAzlEUt2nTd56/yVCYNnqGKhg7spJ9zXOZuo1Uth14/imxDIh/DrLNo5y75xijnfBa
         rhN1PttbR3d4NteclF8jgXwFgQuoawFkDN80DTNFwBANNrmqO8EBcixCJfJhpt2vtKnI
         HzjzkGBLwAg3xSzImp1N2ReywZDHuydJY2C4+yFLSSLbDeOw2S//SKQa368oMfTgJfxZ
         lWI+1CkASj4KBS/naAPYn2Am0E7cp/HKXGayB2jZ3ouAC21S8mOR/i5s5BiNX7gTk/M5
         qxymHdJ7reDkfoLwtgslWUpY/Y7M78n41AyjRmbv1BhPLR9juNK8HFqBjZFnZhFCYs/U
         br0A==
X-Forwarded-Encrypted: i=1; AJvYcCV1OWNXWcOWPkEDZNCjLW/zzx4QOBgKBEsTZlEwllo5AFON2cidbZRuLWqW0mf8d8RojdLn5iKNIP7Z0QxYWJD7NCKZZWdfzwotAlyz
X-Gm-Message-State: AOJu0Yzq/OwER0ji8GjeWLgrCNiQf4krEsf1UtOG1wYso6HmWw2ZOD9/
	tVwPAtBMopm40ZQjFZkRVUyEa6YZ2e50FTZN2zgfxGx+QocdGC3NZKRx5qLBDoFS3KLA6M5Zkry
	SuTi4ES/uujuDwyXXNTCDkch8vqs=
X-Google-Smtp-Source: AGHT+IGm0855gIqDEWhOIzTvrfnoydm2uqIKhqss1bu2Uycc5lOWJg6AkXsii5Nq6BHsknzLSv5AeUGINQVv7Ckbnjg=
X-Received: by 2002:a05:6870:2415:b0:229:f035:f5b2 with SMTP id
 n21-20020a056870241500b00229f035f5b2mr1671752oap.17.1713518430654; Fri, 19
 Apr 2024 02:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226082349.302363-1-yu.c.chen@intel.com> <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net> <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net> <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
 <ZiEaKOQwiNEglYtS@chenyu5-mobl2> <20240419082440.GB6345@noisy.programming.kicks-ass.net>
 <20240419084520.GE12673@noisy.programming.kicks-ass.net>
In-Reply-To: <20240419084520.GE12673@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 19 Apr 2024 17:20:19 +0800
Message-ID: <CAB8ipk99Rv5Psu=J5TuPxVRqoW2-CfaeFWYmXDAGgL20QbMNTw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, 
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Tianchen Ding <dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Apr 19, 2024 at 10:24:40AM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 18, 2024 at 09:03:36PM +0800, Chen Yu wrote:
> >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 31bca05c3612..9f203012e8f5 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -696,15 +696,23 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
> > >   *
> > >   * XXX could add max_slice to the augmented data to track this.
> > >   */
> > > +
> > > +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> > > +{
> > > +   s64 limit;
> > > +
> > > +   limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> > > +   return clamp(lag, -limit, limit);
> > > +}
> >
> > Right, helper makes sense.
>
> A possible other helper might be the below. But that depends if we want
> to clip after scaling too. No super strong preference.
>
> Please post your patch with a proper changelog and we'll get it sorted.

Thanks Peter, I will send the v2 later after my local testing:)


>
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -696,15 +696,19 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   *
>   * XXX could add max_slice to the augmented data to track this.
>   */
> -static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity=
 *se)
> +static s64 entity_lag(u64 avruntime, struct sched_entity *se)
>  {
> -       s64 lag, limit;
> -
> -       SCHED_WARN_ON(!se->on_rq);
> -       lag =3D avg_vruntime(cfs_rq) - se->vruntime;
> +       s64 vlag, limit;
>
> +       vlag =3D avruntime - se->vruntime;
>         limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> -       se->vlag =3D clamp(lag, -limit, limit);
> +       return clamp(vlag, -limit, limit);
> +}
> +
> +static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity=
 *se)
> +{
> +       SCHED_WARN_ON(!se->on_rq);
> +       se->vlag =3D entity_lag(avg_vruntime(cfs_rq), se);
>  }
>
>  /*
> @@ -3760,7 +3764,7 @@ static void reweight_eevdf(struct sched_
>          *         =3D V  - vl'
>          */
>         if (avruntime !=3D se->vruntime) {
> -               vlag =3D (s64)(avruntime - se->vruntime);
> +               vlag =3D entity_lag(avruntime, se);
>                 vlag =3D div_s64(vlag * old_weight, weight);
>                 se->vruntime =3D avruntime - vlag;
>         }

BR
---
xuewen

