Return-Path: <linux-kernel+bounces-160433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC28B3D70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05FB1F2366A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646C16D9D7;
	Fri, 26 Apr 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANHRY97b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F581159585;
	Fri, 26 Apr 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150731; cv=none; b=s0NVA9utJwlzam9lVfzoOOyd0Q6ykpP8UhXuikkparGvyXJHSrN3VyAAkgLZh7pYbBoJxauBWK+jUeSxQKvuJFqyBPx3x4BpvMNFWRgjjYwTwOzIOcr/mUZFDyQdAEN4rooh0U1GZAfDFaRcap0UwYur7Q8fKt2Jty7VQ8csBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150731; c=relaxed/simple;
	bh=czJKKop2DrqgxYKXJiuw6Oxa2VkgBI8VGFIhqSB6+0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3FzeLVpUPhC1UyhLnlFxEHh4b1Zx6NHdWY7y1Ca8MgxgDZDAremFzVtOZFUxYymhxNyHtatCmhHgaXnDfAsCrP1G2ty7Kwa8DIIu1aksQJqHuumuT9B4UsVezZI2NCgnZnXFHKHDm7xZhvEGr8IQwz2aKVyQtJim3IfwF5qoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANHRY97b; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714150730; x=1745686730;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czJKKop2DrqgxYKXJiuw6Oxa2VkgBI8VGFIhqSB6+0M=;
  b=ANHRY97bN7rUnyRXwx8352vx2QOJcW6ygybBlSqf6952TXYRYE1SPrs4
   BxChhLIuRmuEBzZRQibFz3ewyCPQRmWz6iuU4U+59o+6vKloSWwkrsf8q
   PqF9zIUWp1Um+uONdK+BukJ+WaCnCzbZcXAK4Ltb1DjHOwnpyanrISBTT
   kAtghWefuKKNmeyyveKeK9puy9JsKHvPMtK3+45QoM6gmCjzXI3ip0UA3
   uC+/QYwT9TRRE/0H6Buwc3WGt8oFO8Duw459QYknB7FjN1doQg2RRtL8s
   KhnGRXD9BRKFegcvlmqTPhkf23y6K1VOm13G2QFYXH5W7U+8aAsMQeUO4
   A==;
X-CSE-ConnectionGUID: Vt5jsbszRzyedioS+WjFKA==
X-CSE-MsgGUID: j2LiS8+PQ7mlQFxzT9WceA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9725608"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9725608"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:58:50 -0700
X-CSE-ConnectionGUID: eALeRG/SQreIstmVktGfJg==
X-CSE-MsgGUID: avSTa2EbQBCV4WEez3A1RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="29919576"
Received: from ainumpud-mobl1.amr.corp.intel.com (HELO peluse-desk5) ([10.212.96.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:58:48 -0700
Date: Thu, 25 Apr 2024 02:12:24 -0700
From: Paul E Luse <paul.e.luse@linux.intel.com>
To: tada keisuke <keisuke1.tada@kioxia.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, "song@kernel.org" <song@kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>, "linux-raid@vger.kernel.org"
 <linux-raid@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Luse, Paul E" <paul.e.luse@intel.com>
Subject: Re: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
Message-ID: <20240425021224.6419ee2c@peluse-desk5>
In-Reply-To: <4b8f2f7499bd497c9db280775ae4ea81@kioxia.com>
References: <47c035c3e741418b80eb6b73d96e7e92@kioxia.com>
	<8d21354c-9e67-b19c-1986-b4c027dff125@huaweicloud.com>
	<20240416073806.50e3ff5d@peluse-desk5>
	<20240416154113.114dc42f@peluse-desk5>
	<4b8f2f7499bd497c9db280775ae4ea81@kioxia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; aarch64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 08:01:55 +0000
tada keisuke <keisuke1.tada@kioxia.com> wrote:

> > > > Hi,
> > > >
> > > > =E5=9C=A8 2024/04/18 13:44, tada keisuke =E5=86=99=E9=81=93:
> > > > > This patch depends on patch 07.
> > > > >
> > > > > All rdevs running in RAID 1/10 switch nr_pending to atomic
> > > > > mode. The value of nr_pending is read in a normal operation
> > > > > (choose_best_rdev()). Therefore, nr_pending must always be
> > > > > consistent.
> > > > >
> > > > > Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
> > > > > Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
> > > > > ---
> > > > >   drivers/md/md.h     | 14 ++++++++++++++
> > > > >   drivers/md/raid1.c  |  7 +++++++
> > > > >   drivers/md/raid10.c |  4 ++++
> > > > >   3 files changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > > > > index ab09e312c9bb..57b09b567ffa 100644
> > > > > --- a/drivers/md/md.h
> > > > > +++ b/drivers/md/md.h
> > > > > @@ -236,6 +236,20 @@ static inline unsigned long
> > > > > nr_pending_read(struct md_rdev *rdev) return
> > > > > atomic_long_read(&rdev->nr_pending.data->count); }
> > > > >
> > > > > +static inline bool nr_pending_is_percpu_mode(struct md_rdev
> > > > > *rdev) +{
> > > > > +	unsigned long __percpu *percpu_count;
> > > > > +
> > > > > +	return __ref_is_percpu(&rdev->nr_pending,
> > > > > &percpu_count); +}
> > > > > +
> > > > > +static inline bool nr_pending_is_atomic_mode(struct md_rdev
> > > > > *rdev) +{
> > > > > +	unsigned long __percpu *percpu_count;
> > > > > +
> > > > > +	return !__ref_is_percpu(&rdev->nr_pending,
> > > > > &percpu_count); +}
> > > > > +
> > > > >   static inline int is_badblock(struct md_rdev *rdev,
> > > > > sector_t s, int sectors, sector_t *first_bad, int
> > > > > *bad_sectors) {
> > > > > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > > > > index 12318fb15a88..c38ae13aadab 100644
> > > > > --- a/drivers/md/raid1.c
> > > > > +++ b/drivers/md/raid1.c
> > > > > @@ -784,6 +784,7 @@ static int choose_best_rdev(struct r1conf
> > > > > *conf, struct r1bio *r1_bio) if (ctl.readable_disks++ =3D=3D 1)
> > > > >   			set_bit(R1BIO_FailFast,
> > > > > &r1_bio->state);
> > > > >
> > > > > +
> > > > > WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev)); pending =3D
> > > > > nr_pending_read(rdev); dist =3D abs(r1_bio->sector -
> > > > > conf->mirrors[disk].head_position);
> > > > > @@ -1930,6 +1931,7 @@ static int raid1_add_disk(struct mddev
> > > > > *mddev, struct md_rdev *rdev) if (err)
> > > > >   				return err;
> > > > >
> > > > > +
> > > > > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> > > > > raid1_add_conf(conf, rdev, mirror, false); /* As all devices
> > > > > are equivalent, we don't need a full recovery
> > > > >   			 * if this was recently any drive
> > > > > of the array @@ -1949,6 +1951,7 @@ static int
> > > > > raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
> > > > > set_bit(Replacement, &rdev->flags); raid1_add_conf(conf,
> > > > > rdev, repl_slot, true); err =3D 0;
> > > > > +
> > > > > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> > > >
> > > > I don't understand what's the point here, 'nr_pending' will be
> > > > used when the rdev issuing IO, and it's always used as atomic
> > > > mode, there is no difference.
> > > >
> > > > Consider that 'nr_pending' must be read from IO fast path, use
> > > > it as atomic is something we must accept. Unless someone comes
> > > > up with a plan to avoid reading 'inflight' counter from fast
> > > > path like generic block layer, it's not ok to me to switch to
> > > > percpu_ref for now.
>=20
> The main purpose of this patchset is to improve RAID5 performance.
> In the current RAID 1/10 design, the value of nr_pending is
> intentionally always in atomic mode because it must be read in IO
> fast path. Unless the design of reading the value of nr_pending has
> changed, I believe that this patchset is a reasonable design and
> RAID1 performance is about the same as atomic_t before this patchset
> was applied. Paul's results also show that.
>=20
> Best Regards,
> Keisuke

I only tested RAID1 and do believe that simpler is better so would
prefer not to change the RAID1 code.  I can run some RAID5 tests on
this as well unless you have some wide sweeping results? Would love to
see more RAID5 performance improvments.  Shushu has another RAID5 perf
patch out there that I think has some very good potential, it would be
good if you could take a look at that one.

-Paul

>=20
> > > > +CC Paul
> > > >
> > > > HI, Paul, perhaps you RR mode doesn't need such 'inflight'
> > > > counter anymore?
> > > >
> > >
> > > I too am struggling to see the benefit but am curious enough that
> > > I will run some tests on my own as I have fresh baseline RAID1
> > > large sweep performance data ready right now.
> > >
> > > So my WIP round robin patch won't need nr_pedning for SSDs but I
> > > think it will for HDD plus I need a new atomic counter for round
> > > robin for SSDs anyway but I see no perfomrnace impact so far from
> > > adding it.
> > >
> > > -Paul
> > >
> >=20
> > I can run more if others are interested (RAID5 or HDD for example)
> > but at least for RAID1 there's really no difference.  This was a
> > quick run, just 40 sec each, 16 jobs and the rest ofthe fio params
> > are on the charts. 2 disk RAID1. THe baseline is 6.8.0 from the md
> > repo. Using my favorite drives, of course, KIOXIA KCMYDVUG3T20 :)
> >=20
> > Here's the results: https://photos.app.goo.gl/Avyw64eXCqWFWrs78
> >=20
> > NOTE:  There are few small randoms where it appears to help but I
> > assumed that was because these are small randoms with very short run
> > times.  SO I reran the 4K mixed rw randoms with 5 minute run time
> > and that chart is at the very bottom and shows that over longer
> > duration its a wash, there's no clear winner.  I'm sure an even
> > longer run would show more consistently close results.
>=20
>=20


