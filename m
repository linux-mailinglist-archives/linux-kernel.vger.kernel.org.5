Return-Path: <linux-kernel+bounces-150867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110138AA605
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888221F217FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BF762DA;
	Thu, 18 Apr 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4cj02v2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59B29CEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483937; cv=none; b=TrBoNe9AM3ShrHc6rDxU2E/CYlnr5XhFXwisH2OPdItZ99htMDpPmvS4/HmR/MUKKWvrhVJXyx9tb9fFlPBbcvsEtvttP0HC5WI7O+YwD6V+3JnWlSGvr/hIV2FB8CzjTHtkNzY2muQkMi3ySBKMSrwp7m2wSUwwJ8aIKgKmK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483937; c=relaxed/simple;
	bh=th0CzhF2YU4QjdnHLPIjfo/+ayU0qLtwiM1QwUhOzWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIzHWsWtE84nS2Io879etA6MbJvxVu0OTiSnV21MigFZPnHKDha82ftcJ7ESuJgufh0/kClheBeqZKwHXtP3wXe8zHp9wiBTfOinvJGJgcAe8Ixj11uDkxqIQCH0tKQePL1OaGxRG6hKl4WBRlpaxqooh+UU6SGL74OgD9JCuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4cj02v2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713483936; x=1745019936;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=th0CzhF2YU4QjdnHLPIjfo/+ayU0qLtwiM1QwUhOzWk=;
  b=Q4cj02v2lkDxtRsl5FwatBQ+PYeoZygKDje/ejs+tMsaH908ci1HbUej
   D4vbY1qSGsDDUHC7Rcjjx1r+zmR3ZKjp6HM3MQ+hnlo4DRF+J463F5Mco
   O/sMgvutpcgkFSYSzPaF1yIBdL3HNatySsIJ5W85pWzLtOhTVS3cDtnAQ
   4S0Y0oPnx/tKfjFeaeyjDA3ONOsC9x0g5+4eE43kJxrcQ/0FP1gyD+p0M
   MkS0RWLHAVVK4FvDvJ4e9ptK33LlM21b6ddvQ+i6sGwuwIO9D9sHjUOyV
   0NihxbN0H9xMnz1F12i0Ww67A5kWo6Ui8eQI11QfIOpRd9QpniKY/58yH
   w==;
X-CSE-ConnectionGUID: yr6xS31aTFaCjOvvDFpdmg==
X-CSE-MsgGUID: Ki+Q1qVWROqsyJFosKzfww==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12848096"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12848096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 16:45:31 -0700
X-CSE-ConnectionGUID: URUg7TAlT7WFJyT+EvxvQQ==
X-CSE-MsgGUID: 00WTTTG9Q/K8L7qXtQp0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23767324"
Received: from schen9-mobl2.jf.intel.com (HELO [10.24.8.104]) ([10.24.8.104])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 16:45:30 -0700
Message-ID: <ec479251e6245148b89b226f734192f6d5343bbc.camel@linux.intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>, Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Abel Wu
 <wuyun.abel@bytedance.com>,  Ingo Molnar <mingo@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Yujie Liu <yujie.liu@intel.com>,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Tianchen Ding <dtcccc@linux.alibaba.com>
Date: Thu, 18 Apr 2024 16:45:29 -0700
In-Reply-To: <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
	 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
	 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
	 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
	 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
	 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
	 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
	 <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 21:03 +0800, Chen Yu wrote:
> Hi Xuewen,
>=20
> On 2024-04-18 at 10:57:22 +0800, Xuewen Yan wrote:
> > Hi Yu
> >=20
> > On Thu, Apr 18, 2024 at 2:35=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> w=
rote:
> > >=20
> > > On 2024-04-09 at 11:21:04 +0200, Peter Zijlstra wrote:
> > > > On Mon, Apr 08, 2024 at 09:11:39PM +0800, Chen Yu wrote:
> > > > > On 2024-04-08 at 13:58:33 +0200, Peter Zijlstra wrote:
> > > > > > On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:
> > > > > >=20
> > > > > > > > According to the log, vruntime is 18435852013561943404, the
> > > > > > > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 204=
8 =3D 2677,
> > > > > > > > thus:
> > > > > > > > s64 delta =3D (s64)(18435852013561943404 - 763383370431) =
=3D -10892823530978643
> > > > > > > >      delta * 2677 =3D 7733399554989275921
> > > > > > > > that is to say, the multiply result overflow the s64, which=
 turns the
> > > > > > > > negative value into a positive value, thus eligible check f=
ails.
> > > > > > >=20
> > > > > > > Indeed.
> > > > > >=20
> > > > > > From the data presented it looks like min_vruntime is wrong and=
 needs
> > > > > > update. If you can readily reproduce this, dump the vruntime of=
 all
> > > > > > tasks on the runqueue and see if min_vruntime is indeed correct=
.
> > > > > >=20
> > > > >=20
> > > > > This was the dump of all the entities on the tree, from left to r=
ight,
> > > >=20
> > > > Oh, my bad, I thought it was the pick path.
> > > >=20
> > > > > and also from top down in middle order traverse, when this issue =
happens:
> > > > >=20
> > > > > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:=
2048 cfs_rq->min_vruntime:763383370431
> > > > > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:1843=
5852013562231446
> > > > >                     min_vruntime:18437121115753667698 vruntime:18=
435852013561943404, load:629
> > > > >=20
> > > > >=20
> > > > > [  514.536772][ T8390] Traverse rb-tree from left to right
> > > > > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_v=
runtime:763383370431 vruntime:763383370431 non-eligible  <-- leftmost se
> > > > > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_v=
runtime:763760947228 vruntime:763760947228 non-eligible
> > > > >=20
> > > > > [  514.538539][ T8390] Traverse rb-tree from topdown
> > > > > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:76338487043=
1 min_vruntime:763383370431 vruntime:763383370431 non-eligible   <-- root s=
e
> > > > > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:76376244722=
8 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > > >=20
> > > > > The tree looks like:
> > > > >=20
> > > > >           se (0xec1234e0)
> > > > >                   |
> > > > >                   |
> > > > >                   ----> se (0xec4fcf20)
> > > > >=20
> > > > >=20
> > > > > The root se 0xec1234e0 is also the leftmost se, its min_vruntime =
and
> > > > > vruntime are both 763383370431, which is aligned with
> > > > > cfs_rq->min_vruntime. It seems that the cfs_rq's min_vruntime get=
s
> > > > > updated correctly, because it is monotonic increasing.
> > > >=20
> > > > Right.
> > > >=20
> > > > > My guess is that, for some reason, one newly forked se in a newly
> > > > > created task group, in the rb-tree has not been picked for a long
> > > > > time(maybe not eligible). Its vruntime stopped at the negative
> > > > > value(near (unsigned long)(-(1LL << 20)) for a long time, its vru=
ntime
> > > > > is long behind the cfs_rq->vruntime, thus the overflow happens.
> > > >=20
> > > > I'll have to do the math again, but that's something in the order o=
f not
> > > > picking a task in about a day, that would be 'bad' :-)
> > > >=20
> > > > Is there any sane way to reproduce this, and how often does it happ=
en?
> > >=20
> > > After adding some ftrace in place_entity() and pick_eevdf(), with the
> > > help from Yujie in lkp, the issue was reproduced today. The reason wh=
y se's vruntime
> > > is very small seems to be related to task group's reweight_entity():
> > >=20
> > > vlag =3D (s64)(avruntime - se->vruntime);
> > > vlag =3D div_s64(vlag * old_weight, weight);
> > > se->vruntime =3D avruntime - vlag;
> > >=20
> > > The vlag above is not limited by neither 2*se->slice nor TICK_NSEC,
> > > if the new weight is very small, which is very likely, then the vlag
> > > could be very large, results in a very small vruntime.
> > >=20
> > >=20
> > > The followings are the details why I think above could bring problems=
:
> > >=20
> > > Here is the debug log printed by place_entity():
> > >=20
> > >=20
> > > [  397.597268]cfs_rq:0xe75f7100
> > >               cfs_rq.avg_vruntime:-1111846207333767
> > >               cfs_rq.min_vruntime:810640668779
> > >               avg_vruntime():686982466017
> > >               curr(0xc59f4f20 rb_producer weight:15 vruntime:14477731=
96654 sum_exec_ns:187707021870 ctx(0 73)
> > >               leftmost(0xeacb6e00 vruntime:332464705486 sum_exec_ns:7=
8776125437 load:677)
> > > ..
> > >=20
> > > [  397.877251]cfs_rq:0xe75f7100
> > >               cfs_rq.avg_vruntime:-759390883821798
> > >               cfs_rq.min_vruntime:810640668779
> > >               avg_vruntime(): 689577229374
> > >               curr(0xc59f4f20 rb_producer weight:15 vruntime:14536409=
07998 sum_ns:187792974673 ctx(0 73)
> > >               leftmost(0xeacb6e00 vruntime:-59752941080010 sum_ns:787=
76125437 load:4)
> > >=20
> > >=20
> > > The leftmost se is a task group, its vruntime reduces from 3324647054=
86 to
> > > -59752941080010, because its load reduced from 677 to 4 due to update=
_cfs_group()
> > > on the tree entities.
> > >=20
> > > Back to reweight_entity():
> > > vlag =3D avruntime - se->vruntime =3D 689577229374 - 332464705486 =3D=
 357112523888;
> > > vlag =3D vlag * old_weight / weight =3D 357112523888 * 677 / 4 =3D 60=
441294668044;
> > > se->vruntime =3D avruntime - vlag =3D -59751717438670;
> > >=20
> > > the new se vruntime -59751717438670 is close to what we printed -5975=
2941080010,
> > > consider that the avg_vruntime() vary.
> > >=20
> > > Then later this leftmost se has changed its load back and forth, and =
when the load is 2,
> > > the vuntime has reached a dangerous threshold to trigger the s64 over=
flow in
> > > eligible check:
> > >=20
> > > [  398.011991]cfs_rq:0xe75f7100
> > >               cfs_rq.avg_vruntime:-11875977385353427
> > >               cfs_rq.min_vruntime:810640668779
> > >               cfs_rq.avg_load:96985
> > >               leftmost(0xeacb6e00 vruntime:18446623907344963655 load:=
2)
> > >=20
> > > vruntime_eligible()
> > > {
> > >=20
> > >    key =3D se.vruntime - cfs_rq.min_vruntime =3D -120977005256740;
> > >    key * avg_load overflow s64...
> > > }
> > >=20
> > > As a result the leftmost one can not be picked, and NULL is returned.
> > >=20
> > > One workaround patch I'm thinking of, if this analysis is in the
> > > right direction, maybe I can have a test later:
> > >=20
> > > thanks,
> > > Chenyu
> > >=20
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6e0968fb9ba8..7ab26cdc3487 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3965,8 +3965,13 @@ static void reweight_eevdf(struct cfs_rq *cfs_=
rq, struct sched_entity *se,
> > >          *         =3D V  - vl'
> > >          */
> > >         if (avruntime !=3D se->vruntime) {
> > > +               s64 limit;
> > > +
> > >                 vlag =3D (s64)(avruntime - se->vruntime);
> > >                 vlag =3D div_s64(vlag * old_weight, weight);
> > > +               /* TBD: using old weight or new weight? */
> > > +               limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TIC=
K_NSEC), se);
> > > +               vlag =3D clamp(lag, -limit, limit);
> > >                 se->vruntime =3D avruntime - vlag;
> > >         }
> > >=20
> >=20
> > According to previous discussion:
> > https://lore.kernel.org/all/CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20=
n0xbx94w@mail.gmail.com/
> >=20
> > Could this patch avoid this problem?
> >=20
>=20
> 100 cycles has passed with the following change, with the fork() cased re=
moved.
> There was no NULL pointer issue observed so far. Meanwhile, I've launched=
 a test
> with Tianchen's patch set on top of this one to see if everything goes we=
ll.
>=20
> Can you take a look if the following change make sense, and if yes, could=
 you
> send v2 and CC the reporters, so they could also have a try if this helps=
.
>=20
> Reported-by: Sergei Trofimovich <slyich@gmail.com>
> Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
> Reported-by: Igor Raits <igor@gooddata.com>
> Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ft=
Six+KjiTVxg8nw@mail.gmail.com/
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@in=
tel.com/
> Reported-by: Yujie Liu <yujie.liu@intel.com>
>=20
>=20
> And in v2, it would be helpful to include the reason why we did this chan=
ge, how
> about something like this:
>=20
> "
> kernel encounters the following error when running workload:
>=20
> BUG: kernel NULL pointer dereference, address: 0000002c
> EIP: set_next_entity (fair.c:?)
>=20
> which was caused by NULL pointer returned by pick_eevdf().
>=20
> Further investigation has shown that, the entity_eligible() has an
> false-negative issue when the entity's vruntime is far behind the
> cfs_rq.min_vruntime that, the (vruntime - cfs_rq->min_vruntime) * load
> caused a s64 overflow, thus every entity on the rb-tree is not
> eligible, which results in a NULL candidate.
>=20
> The reason why entity's vruntime is far behind the cfs_rq.min_vruntime
> is because during a on_rq task group's update_cfs_group()->reweight_eevdf=
(),
> there is no limit on the new entity's vlag. If the new weight is much
> smaller than the old one,

Probably worth mentioning in commit log that the vlag could be many times l=
arger than the scheduling
entity's time slice leading to vruntime overflow on going to a really small=
 weight.  We're limiting
the lag update on reweight_eevdf() to a max of twice the sched entity's tim=
e slice to prevent lag overflow, just
as we are doing on update_sched_entity().

This will help to clarify the reason for the change when looking at this pa=
tch for the first time.

Tim

>=20
> vlag =3D div_s64(vlag * old_weight, weight)
>=20
> generates a huge vlag, and results in very small(negative) vruntime.
>=20
> Thus limit the range of vlag accordingly.
>=20
> "
>=20
>=20

