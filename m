Return-Path: <linux-kernel+bounces-149457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B18A9155
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CFE1C20F07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E74F20E;
	Thu, 18 Apr 2024 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVED6d/m"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC453AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409055; cv=none; b=TcQhvqDSHlDxpTtkAS6ZjyAoLPr2Yme8/BLVT0LkKlncyTa9OlbTj8yL7gMUpDYHznu2IIrv9oJ2Z8AR921C2gWN3WjpYqmWLDmhev920CrEviWaJQA/DHGn6GGeqfyGKH8qb6c67aOZLfobI4uNlfgKt/OCiOe8qvvFhJk7bIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409055; c=relaxed/simple;
	bh=fIv3bLYUQPcWF088aYdMkOMRQMqf1zFqm6Nv8oLXyuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYBk9bngtITBJ5810VGQIdv/GbYVx0JMfRpjJAAVuSR7H56msoL4SNZrl2wEYLAVFmfvVwoxJLw/aBQOSTh48TOVcm5tTx0ZfGznb88nfA07SMrCm06HOPQMEWuKvLrMiJzkeXAZcdGL7YZwpKA5eiNRyiBrKsN4bHVN7Xm6QEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVED6d/m; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2390335b67cso6825fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713409053; x=1714013853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8kao/g8Q8+eIqH7aAXit3ZE9PsmSiD4NM8tiUS+pFA=;
        b=fVED6d/mG7dQcCa97FI7axzk3qxrOUuFBGau09Ty0jzpZvLPzqc0HPvwbqMlXnDjNB
         FQA9u6vOxDeTXOH0drx3z1vOAdPHAtgbQ6fsUoUJaLmy7snuFU7jUk7l7JA+aaxZXY7d
         IKNgLfXMRGoIicMjSbLs1mrkmj6h/UD7eD5//B0tecxfJ4+/oRW8peqUarHFC7PG+GE6
         ZjLS2htMvJfPwVWU9rwWLdPAKpMY3TxsPzfel33Nb8qrDM5nO6DEv3JmZjBSDWbfmblg
         ZCPLQCBRfxDcKsSfpxScz5F0+87JeCG9v5Qg6WnI6xkbssWQLLjQ3hGxzINYzeYPD9si
         Dsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713409053; x=1714013853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8kao/g8Q8+eIqH7aAXit3ZE9PsmSiD4NM8tiUS+pFA=;
        b=SmeB08OmOL5aomArgUHyt0YvGv785/aMSvZJCalE1P6JYVn7QZHrljPMmL6tog9dZv
         9JpiSZuAtQ5WD56S5yGbM5886t+Ks8oprszE/ap2G2D2lXA6E+316T+OcXuR1H5XLFVK
         P+dIIfwRIqDKVYGuy/kPW8TiazM/do3pITi/6uYhkJr02H6w4hC5eDD9d253GJT5IeOt
         btkAPHyWfMNoxCU6kANCMgeXhA/2ePs2rQpHCOqEPtlz17wjVn4ZCk+UBgMqILhIiD5E
         J9sk/yjkQbKdfRACq483yj1Ua9zJbMbpXR90KkEHiiJfr+FCHJEos0zlRKv5iiPjrZ+v
         144w==
X-Forwarded-Encrypted: i=1; AJvYcCUFPwXL791mGUe63PzLljAOtcpjV74GbKogTnvUFx6vpECdBUeR4G6Ae5sS82Q0q8SQpLxLCjY+3Ahs9PHwF5BzfY7D5M4f4sYW2dmI
X-Gm-Message-State: AOJu0Yzcad0ReZ9njaNmQjYioc3HQh9XE+egLZIWfZTHziIuYdmUl4pI
	2IedyFvL4+Pb9mOKr4wMQdCEvY/oMbUq1NucPZQEcbAgfJySarZWjyF6s36BYzUvvH5kvO7o5Nd
	iY67N2oL2FvNicuh8k4ydwJvqit4=
X-Google-Smtp-Source: AGHT+IF9MjWUDc0G2dqgfYlGfH/cW1qfBklijD6u73H3QKnKwGmESUweLgWOmtdlNCgEGkxGNzH0AHVPAcpRsOKCiNY=
X-Received: by 2002:a05:6870:f2a9:b0:22e:d258:bc43 with SMTP id
 u41-20020a056870f2a900b0022ed258bc43mr1705883oap.42.1713409053017; Wed, 17
 Apr 2024 19:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226082349.302363-1-yu.c.chen@intel.com> <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net> <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net> <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
In-Reply-To: <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 18 Apr 2024 10:57:22 +0800
Message-ID: <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Abel Wu <wuyun.abel@bytedance.com>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, 
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu

On Thu, Apr 18, 2024 at 2:35=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> On 2024-04-09 at 11:21:04 +0200, Peter Zijlstra wrote:
> > On Mon, Apr 08, 2024 at 09:11:39PM +0800, Chen Yu wrote:
> > > On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> > > > On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> > > >
> > > > > > According to the log, vruntime is 18435852013561943404, the
> > > > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 =
=3D 2677,
> > > > > > thus:
> > > > > > s64 delta =3D (s64)(18435852013561943404 - 763383370431) =3D -1=
0892823530978643
> > > > > >      delta * 2677 =3D 7733399554989275921
> > > > > > that is to say, the multiply result overflow the s64, which tur=
ns the
> > > > > > negative value into a positive value, thus eligible check fails=
.
> > > > >
> > > > > Indeed.
> > > >
> > > > From the data presented it looks like min_vruntime is wrong and nee=
ds
> > > > update. If you can readily reproduce this, dump the vruntime of all
> > > > tasks on the runqueue and see if min_vruntime is indeed correct.
> > > >
> > >
> > > This was the dump of all the entities on the tree, from left to right=
,
> >
> > Oh, my bad, I thought it was the pick path.
> >
> > > and also from top down in middle order traverse, when this issue happ=
ens:
> > >
> > > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048=
 cfs_rq->min_vruntime:763383370431
> > > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852=
013562231446
> > >                     min_vruntime:18437121115753667698 vruntime:184358=
52013561943404, load:629
> > >
> > >
> > > [  514.536772][ T8390] Traverse rb-tree from left to right
> > > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vrunt=
ime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
> > > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vrunt=
ime:763760947228 vruntime:763760947228 non-eligible
> > >
> > > [  514.538539][ T8390] Traverse rb-tree from topdown
> > > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 mi=
n_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root se
> > > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 mi=
n_vruntime:763760947228 vruntime:763760947228 non-eligible
> > >
> > > The tree looks like:
> > >
> > >           se (0xec1234e0)
> > >                   |
> > >                   |
> > >                   ----> se (0xec4fcf20)
> > >
> > >
> > > The root se 0xec1234e0 is also the leftmost se, its min_vruntime and
> > > vruntime are both 763383370431, which is aligned with
> > > cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime gets
> > > updated correctly, because it is monotonic increasing.
> >
> > Right.
> >
> > > My guess is that, for some reason, one newly forked se in a newly
> > > created task group, in the rb-tree has not been picked for a long
> > > time(maybe not eligible). Its vruntime stopped at the negative
> > > value(near (unsigned long)(-(1LL << 20)) for a long time, its vruntim=
e
> > > is long behind the cfs_rq->vruntime, thus the overflow happens.
> >
> > I'll have to do the math again, but that's something in the order of no=
t
> > picking a task in about a day, that would be 'bad' :-)
> >
> > Is there any sane way to reproduce this, and how often does it happen?
>
> After adding some ftrace in place_entity() and pick_eevdf(), with the
> help from Yujie in lkp, the issue was reproduced today. The reason why se=
's vruntime
> is very small seems to be related to task group's reweight_entity():
>
> vlag =3D (s64)(avruntime - se->vruntime);
> vlag =3D div_s64(vlag * old_weight, weight);
> se->vruntime =3D avruntime - vlag;
>
> The vlag above is not limited by neither 2*se->slice nor TICK_NSEC,
> if the new weight is very small, which is very likely, then the vlag
> could be very large, results in a very small vruntime.
>
>
> The followings are the details why I think above could bring problems:
>
> Here is the debug log printed by place_entity():
>
>
> [  397.597268]cfs_rq:0xe75f7100
>               cfs_rq.avg_vruntime:-1111846207333767
>               cfs_rq.min_vruntime:810640668779
>               avg_vruntime():686982466017
>               curr(0xc59f4f20 rb_producer weight:15 vruntime:144777319665=
4 sum_exec_ns:187707021870 ctx(0 73)
>               leftmost(0xeacb6e00 vruntime:332464705486 sum_exec_ns:78776=
125437 load:677)
> ..
>
> [  397.877251]cfs_rq:0xe75f7100
>               cfs_rq.avg_vruntime:-759390883821798
>               cfs_rq.min_vruntime:810640668779
>               avg_vruntime(): 689577229374
>               curr(0xc59f4f20 rb_producer weight:15 vruntime:145364090799=
8 sum_ns:187792974673 ctx(0 73)
>               leftmost(0xeacb6e00 vruntime:-59752941080010 sum_ns:7877612=
5437 load:4)
>
>
> The leftmost se is a task group, its vruntime reduces from 332464705486 t=
o
> -59752941080010, because its load reduced from 677 to 4 due to update_cfs=
_group()
> on the tree entities.
>
> Back to reweight_entity():
> vlag =3D avruntime - se->vruntime =3D 689577229374 - 332464705486 =3D 357=
112523888;
> vlag =3D vlag * old_weight / weight =3D 357112523888 * 677 / 4 =3D 604412=
94668044;
> se->vruntime =3D avruntime - vlag =3D -59751717438670;
>
> the new se vruntime -59751717438670 is close to what we printed -59752941=
080010,
> consider that the avg_vruntime() vary.
>
> Then later this leftmost se has changed its load back and forth, and when=
 the load is 2,
> the vuntime has reached a dangerous threshold to trigger the s64 overflow=
 in
> eligible check:
>
> [  398.011991]cfs_rq:0xe75f7100
>               cfs_rq.avg_vruntime:-11875977385353427
>               cfs_rq.min_vruntime:810640668779
>               cfs_rq.avg_load:96985
>               leftmost(0xeacb6e00 vruntime:18446623907344963655 load:2)
>
> vruntime_eligible()
> {
>
>    key =3D se.vruntime - cfs_rq.min_vruntime =3D -120977005256740;
>    key * avg_load overflow s64...
> }
>
> As a result the leftmost one can not be picked, and NULL is returned.
>
> One workaround patch I'm thinking of, if this analysis is in the
> right direction, maybe I can have a test later:
>
> thanks,
> Chenyu
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e0968fb9ba8..7ab26cdc3487 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3965,8 +3965,13 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, =
struct sched_entity *se,
>          *         =3D V  - vl'
>          */
>         if (avruntime !=3D se->vruntime) {
> +               s64 limit;
> +
>                 vlag =3D (s64)(avruntime - se->vruntime);
>                 vlag =3D div_s64(vlag * old_weight, weight);
> +               /* TBD: using old weight or new weight? */
> +               limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NS=
EC), se);
> +               vlag =3D clamp(lag, -limit, limit);
>                 se->vruntime =3D avruntime - vlag;
>         }
>

According to previous discussion:
https://lore.kernel.org/all/CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xb=
x94w@mail.gmail.com/

Could this patch avoid this problem?

BR

> --
> 2.25.1
>
>
>

