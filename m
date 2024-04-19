Return-Path: <linux-kernel+bounces-151221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938228AAB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F71F22811
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BE7BB07;
	Fri, 19 Apr 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCjIW1I/"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1BF9CD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518250; cv=none; b=Clr/zUPBqWjQpNrG0uAT+vLBpXd+8P1P1MB3MluE5rMczHsQGPFPQktw7tvwwSeOAHQwC5/5gys7G1DjUWbSDcjOQJOxcwwOd77blb5+H9QiWr1HP7o/nCwvaH8HiJnxhuN0UrVtd4e195cQ/SK78mmGzhJ6/IeG5xVC66vxM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518250; c=relaxed/simple;
	bh=1DtyOCucXV6riDy233DQyhMsLvk1q54yUwi06C0Gn20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSdhKKuh4sHm1wpF930oCnPnr1lthmHz7/AYGG7tk1SwhBDbnB/ssH6PjehBVwDLPIBUJ67rW1KSNB2fYikjBbsUr7ptc2mZnwjDSAIi1Z1Gd3ouLEk9QOaoYdbHvd7N2Qrl9O4zMRzGkeDMwXs9GLCeaRVybr0nrdp3qbWsgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCjIW1I/; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbbc6e51d0so1100491b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713518248; x=1714123048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N35+MPuRZDcE+EQJvR0INfFRKisc0fubZM24HOhZf1I=;
        b=VCjIW1I/FB/CZXN9F9klaSJYpCNa4+pdiT96vsfIKXoWg5OBX8vcUSmcBzhZ7xSoB5
         MHFVwWs1LmxHTX9julM7fNaFT/jKAkQKql+VSlfh9sFwE+5P6Jw8vqeKqlL57mgxTNNR
         38dErAaaaAAAoHEDQiwbKO0fXEazIfZZapZlAfT53XZ5qn5JHs4YmbJ6fsyTrNWFMBV3
         5Ksru9dImxRhSW/t0+UzYrOrvDipUHFqQRi+B16Idf9UE6cagVJTDQu275sgqHaxsNfg
         TVZ+Xxz8jamY8eaHNOJdzOlnPS7L23EpiBkdgravIBfADyAxgpAFruKLSeEXdkGhohZ5
         pMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518248; x=1714123048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N35+MPuRZDcE+EQJvR0INfFRKisc0fubZM24HOhZf1I=;
        b=nw6+xiDrdbS1ZxwdWOM/NnYVEk3xVClwpXVBawFFnmU/Og83EZsx1F7B7DJHc/2uSB
         46clv1owJPoGXO4c/2Hc1pTQ5qd1kw6Ta9RN1gmfVwGhtfkS4O4PGZpvol3oV43lMDuW
         CHB/JAXeFPLfG1W5WARTzbfablSZXDguwIS4+Agb9mwrVeF2cMHlCtnmhK9ZKHLyaCuz
         ELdTORLn3A/WeWvQcnpccBlXihNgaZsgAJyiCYxvYu82TLe58bNF8DB8IWL132i1HCve
         CG1BmyOo0lJGcmljUCDRi6CpXuEjToxMaNQ8HRP5bja7r7zdwPZHWDNNA/3tU8aAUx2T
         Ey6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzDTQqwX62CfL5QwnNzdafXWZswtxFzde1uJjwU5LfP65+RJpn5gLPzlGeMAKZnbCEG9AwY3G5tXJsenppl+bh4NCd2ZYFh/1JW1kC
X-Gm-Message-State: AOJu0YyEnjLXmyqGqsuf/73N/Qy17BsWwyZXIndJ4dzz0JQMfMtLjZn2
	LitsumoZiBLYiBzjgM4GLNUGNtqFXw7skAkG3FUP+WJtc3cGwCOKFIm+K3KS1XLOwkS20SR1m8L
	1XNEBVPVgcFAvjpAiw+A7GPqiZhw=
X-Google-Smtp-Source: AGHT+IFlcKwZdBrXzmMSOwwL45mmAVv+FIua6SFFiB06dHuI6A3i+P5PG7CuMpjUav36VvSdPnwp8ggMUg5NRKCIBdQ=
X-Received: by 2002:a05:6870:1ec4:b0:22e:76c1:ddce with SMTP id
 pc4-20020a0568701ec400b0022e76c1ddcemr1903911oab.6.1713518248616; Fri, 19 Apr
 2024 02:17:28 -0700 (PDT)
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
In-Reply-To: <20240419082440.GB6345@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 19 Apr 2024 17:17:17 +0800
Message-ID: <CAB8ipk_B7zsQt2wa5pda4ehN6f0yHi_mV=unVThnOYTKQz=5aw@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 4:24=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Apr 18, 2024 at 09:03:36PM +0800, Chen Yu wrote:
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 31bca05c3612..9f203012e8f5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -696,15 +696,23 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
> >   *
> >   * XXX could add max_slice to the augmented data to track this.
> >   */
> > +
> > +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> > +{
> > +     s64 limit;
> > +
> > +     limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> > +     return clamp(lag, -limit, limit);
> > +}
>
> Right, helper makes sense.
>
> > @@ -3721,6 +3729,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq,=
 struct sched_entity *se,
> >       if (avruntime !=3D se->vruntime) {
> >               vlag =3D (s64)(avruntime - se->vruntime);
> >               vlag =3D div_s64(vlag * old_weight, weight);
> > +             vlag =3D limit_entity_lag(se, vlag);
> >               se->vruntime =3D avruntime - vlag;
>
> So the !on_rq case has clamping in update_entity_lag() which is before
> scaling. And that makes more sense to me, because putting a limit on
> vlag before the multiplication *should* ensure the multiplication itself
> doesn't overflow.
>
> But now you allow it to compute garbage and then clip the garbage.
>
> >       }
> >
> > @@ -3768,6 +3777,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq=
, struct sched_entity *se,
> >
> >       update_load_set(&se->load, weight);
> >
> > +     if (!se->on_rq)
> > +             se->vlag =3D limit_entity_lag(se, se->vlag);
> > +
>
> Except you now add clamping after scaling too, but in a really weird
> place. Should this not go right after the div_s64() that scales?

Yes, it's better to put it  after the div_s64().

>
> Unlike the reweight_eevdf() case, there might be an argument for doing
> it after scaling in this case. Namely, you can have multiple reweights
> stacking their scale ops.
>
>
> Also, could you put a few words in on how often these clips are hit? I
> suspect it's fairly rare (but crucial when it does).

I think this probability may be not small, because the user space
often modifies the task's nice value while the task is sleeping.
I also would add logs to check it.

BR

