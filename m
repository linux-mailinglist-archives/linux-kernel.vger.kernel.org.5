Return-Path: <linux-kernel+bounces-150319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229C8A9D38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657FA1C20978
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BA161933;
	Thu, 18 Apr 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFJnipS+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CFB41C71;
	Thu, 18 Apr 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450984; cv=none; b=W269kNOReE9uboqVU+qxATh5Be1MptY4uyImo+RNdPXi53FcA7kAjup2G6K4bA9VBTr6/HA7UMtb/G02SL6FO1fvfllDGviPgCADOMp7yLK2I8R5LE79psNTF1FAvAeuSsVBiBSfcpr7FVAgX8UE5JELnQnFxdY3l7iV55yC3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450984; c=relaxed/simple;
	bh=M6U0rjdf8U6RK8i0cs3YEunM23bUqM+mF3NUJ2kNZtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAHYaf8Hnqhzr0nD8uiZ8sHo5rH4Sa45QMwTbh/UV0ARisvsKAXgUxegqPnvqAq3ttc9it3mqPLYJKWPe9KbsqSjmDn1H3BO4W2K/1cd2dBU0Xa8vJ2rh1QyCzknMdnCj5liHzG/Mo/96cKBVg9sI7jkVinVHmHo+o0bvVi9Bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFJnipS+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713450983; x=1744986983;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6U0rjdf8U6RK8i0cs3YEunM23bUqM+mF3NUJ2kNZtQ=;
  b=dFJnipS+iTv7i7PtgepoE7RhM91UUfCSEmrq9Igpo8z0R/IrSMqr8cJR
   /4UHOQ9zSHlN+btDFtucTDarqIbY/+W6OMM2L4bJvUGz9Ey7jApewtSal
   aUMlzsWaJSEKoE2W9x9DybS6mNmuDL/TVaXR9z1U6ECccZ+lmn6kFWhGU
   RPjH0W1mATIZq1ILPA8cwZTq1FE/WgcjLMROk2vMVD+w7rwehNgQte2oJ
   WtQy/h5rfcRWfB01pneDVfvkzn+Z/dUnet2twJHRJCJTHHmqjTN+vQbOJ
   DPaDu/Q7AbYpFPra2PMWZPykgrgoplPOp1Z5sTCFqX2t39TtiWyNSbwPB
   A==;
X-CSE-ConnectionGUID: exYZh36JTeOefB1gSSEwMQ==
X-CSE-MsgGUID: uGO4pqPPQ8esrnzAHoMGpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20146262"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20146262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:36:22 -0700
X-CSE-ConnectionGUID: PN2pXaY/Sa6p1CR1/ciTqQ==
X-CSE-MsgGUID: YvrH9gx3QhmodywluCaaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23085579"
Received: from mchatter-mobl.amr.corp.intel.com (HELO peluse-desk5) ([10.213.188.90])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:36:21 -0700
Date: Tue, 16 Apr 2024 07:38:06 -0700
From: Paul E Luse <paul.e.luse@linux.intel.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tada keisuke <keisuke1.tada@kioxia.com>, "song@kernel.org"
 <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luse, Paul
 E" <paul.e.luse@intel.com>
Subject: Re: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
Message-ID: <20240416073806.50e3ff5d@peluse-desk5>
In-Reply-To: <8d21354c-9e67-b19c-1986-b4c027dff125@huaweicloud.com>
References: <47c035c3e741418b80eb6b73d96e7e92@kioxia.com>
	<8d21354c-9e67-b19c-1986-b4c027dff125@huaweicloud.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; aarch64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Apr 2024 14:39:53 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
>=20
> =E5=9C=A8 2024/04/18 13:44, tada keisuke =E5=86=99=E9=81=93:
> > This patch depends on patch 07.
> >=20
> > All rdevs running in RAID 1/10 switch nr_pending to atomic mode.
> > The value of nr_pending is read in a normal operation
> > (choose_best_rdev()). Therefore, nr_pending must always be
> > consistent.
> >=20
> > Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
> > Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
> > ---
> >   drivers/md/md.h     | 14 ++++++++++++++
> >   drivers/md/raid1.c  |  7 +++++++
> >   drivers/md/raid10.c |  4 ++++
> >   3 files changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index ab09e312c9bb..57b09b567ffa 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -236,6 +236,20 @@ static inline unsigned long
> > nr_pending_read(struct md_rdev *rdev) return
> > atomic_long_read(&rdev->nr_pending.data->count); }
> >  =20
> > +static inline bool nr_pending_is_percpu_mode(struct md_rdev *rdev)
> > +{
> > +	unsigned long __percpu *percpu_count;
> > +
> > +	return __ref_is_percpu(&rdev->nr_pending, &percpu_count);
> > +}
> > +
> > +static inline bool nr_pending_is_atomic_mode(struct md_rdev *rdev)
> > +{
> > +	unsigned long __percpu *percpu_count;
> > +
> > +	return !__ref_is_percpu(&rdev->nr_pending, &percpu_count);
> > +}
> > +
> >   static inline int is_badblock(struct md_rdev *rdev, sector_t s,
> > int sectors, sector_t *first_bad, int *bad_sectors)
> >   {
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index 12318fb15a88..c38ae13aadab 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -784,6 +784,7 @@ static int choose_best_rdev(struct r1conf
> > *conf, struct r1bio *r1_bio) if (ctl.readable_disks++ =3D=3D 1)
> >   			set_bit(R1BIO_FailFast, &r1_bio->state);
> >  =20
> > +		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
> >   		pending =3D nr_pending_read(rdev);
> >   		dist =3D abs(r1_bio->sector -
> > conf->mirrors[disk].head_position);=20
> > @@ -1930,6 +1931,7 @@ static int raid1_add_disk(struct mddev
> > *mddev, struct md_rdev *rdev) if (err)
> >   				return err;
> >  =20
> > +
> > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> > raid1_add_conf(conf, rdev, mirror, false); /* As all devices are
> > equivalent, we don't need a full recovery
> >   			 * if this was recently any drive of the
> > array @@ -1949,6 +1951,7 @@ static int raid1_add_disk(struct mddev
> > *mddev, struct md_rdev *rdev) set_bit(Replacement, &rdev->flags);
> >   		raid1_add_conf(conf, rdev, repl_slot, true);
> >   		err =3D 0;
> > +
> > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending); =20
>=20
> I don't understand what's the point here, 'nr_pending' will be used
> when the rdev issuing IO, and it's always used as atomic mode, there
> is no difference.
>=20
> Consider that 'nr_pending' must be read from IO fast path, use it as
> atomic is something we must accept. Unless someone comes up with a
> plan to avoid reading 'inflight' counter from fast path like generic
> block layer, it's not ok to me to switch to percpu_ref for now.
>=20
> +CC Paul
>=20
> HI, Paul, perhaps you RR mode doesn't need such 'inflight' counter
> anymore?
>=20

I too am struggling to see the benefit but am curious enough that I
will run some tests on my own as I have fresh baseline RAID1 large sweep
performance data ready right now.

So my WIP round robin patch won't need nr_pedning for SSDs but I think
it will for HDD plus I need a new atomic counter for round robin for
SSDs anyway but I see no perfomrnace impact so far from adding it.

-Paul

> Thanks,
> Kuai
>=20
> >   		conf->fullsync =3D 1;
> >   	}
> >  =20
> > @@ -3208,6 +3211,7 @@ static void raid1_free(struct mddev *mddev,
> > void *priv); static int raid1_run(struct mddev *mddev)
> >   {
> >   	struct r1conf *conf;
> > +	struct md_rdev *rdev;
> >   	int i;
> >   	int ret;
> >  =20
> > @@ -3269,6 +3273,9 @@ static int raid1_run(struct mddev *mddev)
> >   	/*
> >   	 * Ok, everything is just fine now
> >   	 */
> > +	rdev_for_each(rdev, mddev) {
> > +
> > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> > +	}
> >   	rcu_assign_pointer(mddev->thread, conf->thread);
> >   	rcu_assign_pointer(conf->thread, NULL);
> >   	mddev->private =3D conf;
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index b91dd6c0be5a..66896a1076e1 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -808,6 +808,7 @@ static struct md_rdev *read_balance(struct
> > r10conf *conf,=20
> >   		nonrot =3D bdev_nonrot(rdev->bdev);
> >   		has_nonrot_disk |=3D nonrot;
> > +		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
> >   		pending =3D nr_pending_read(rdev);
> >   		if (min_pending > pending && nonrot) {
> >   			min_pending =3D pending;
> > @@ -2113,6 +2114,7 @@ static int raid10_add_disk(struct mddev
> > *mddev, struct md_rdev *rdev) p->recovery_disabled =3D
> > mddev->recovery_disabled - 1; rdev->raid_disk =3D mirror;
> >   		err =3D 0;
> > +
> > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending); if
> > (rdev->saved_raid_disk !=3D mirror) conf->fullsync =3D 1;
> >   		WRITE_ONCE(p->rdev, rdev);
> > @@ -2127,6 +2129,7 @@ static int raid10_add_disk(struct mddev
> > *mddev, struct md_rdev *rdev) err =3D mddev_stack_new_rdev(mddev,
> > rdev); if (err)
> >   			return err;
> > +
> > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending); conf->fullsync
> > =3D 1; WRITE_ONCE(p->replacement, rdev);
> >   	}
> > @@ -4028,6 +4031,7 @@ static int raid10_run(struct mddev *mddev)
> >   	rdev_for_each(rdev, mddev) {
> >   		long long diff;
> >  =20
> > +
> > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending); disk_idx =3D
> > rdev->raid_disk; if (disk_idx < 0)
> >   			continue;
> >  =20
>=20
>=20


