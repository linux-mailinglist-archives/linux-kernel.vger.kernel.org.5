Return-Path: <linux-kernel+bounces-159671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF68B31E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED911F2206E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733813C8FA;
	Fri, 26 Apr 2024 08:02:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D5762FF;
	Fri, 26 Apr 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118557; cv=none; b=bSkF4mTnNNwMM757TMTq3r8GtQ4DKSe/L43dIy8UH/AJzvu1DuyotxsvbDGFuXz3j3ni+NnRvtJd416FW9XJdJzWMMEvKZPpvqyk+eVsZTkhcKd2Q3TRQTkwLcUJi13C4ZO5rbu/1FDYCK9G/rJRDMIBnJMwUM3c91Fq7max98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118557; c=relaxed/simple;
	bh=5DzvnFhpBpUJt4RSZwfBJZLdio99DLDe1icuSKFbjFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h2/m/7sK0pIP9bQm87Fo9h3a5HoiKzYCuyQfumFMXu33Cv0QMw+IGtsU8TrMPW+Ppoed6CES7GwksPKKVgJ1q06HHPaZQ973dJ7VbL7HaW8nGtaVUtLLtwrLhwIN/rHaTgvUwTK0J23Suc+t3ItbqE69n451s1t/8555TiItttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43Q81xGe4192807; Fri, 26 Apr 2024 17:01:59 +0900
X-Iguazu-Qid: 2rWhAUbYirZdWvlLp7
X-Iguazu-QSIG: v=2; s=0; t=1714118519; q=2rWhAUbYirZdWvlLp7; m=/Lyerl9OXsq+THcaPTylrfkVlvPSTUl+KzFCVHKXbIU=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 43Q81vfP1943313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 26 Apr 2024 17:01:57 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id F240F48A84;
	Fri, 26 Apr 2024 17:01:56 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 86ECA1938B55A8;
	Fri, 26 Apr 2024 16:39:47 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002SAAAAAA00BBM;
	 Fri, 26 Apr 2024 16:39:47 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id 7B53CAA284800;
	Fri, 26 Apr 2024 16:39:47 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 17:01:55 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Fri,
 26 Apr 2024 17:01:55 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: Paul E Luse <paul.e.luse@linux.intel.com>,
        Yu Kuai
	<yukuai1@huaweicloud.com>
CC: "song@kernel.org" <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luse, Paul E"
	<paul.e.luse@intel.com>
Subject: RE: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
Thread-Topic: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
Thread-Index: AdqLx+XD0n9rpAUxRba5DThcEUS6pAF1ejgc//zL4YD/937IgA==
Date: Fri, 26 Apr 2024 08:01:55 +0000
Message-ID: <4b8f2f7499bd497c9db280775ae4ea81@kioxia.com>
References: <47c035c3e741418b80eb6b73d96e7e92@kioxia.com>
 <8d21354c-9e67-b19c-1986-b4c027dff125@huaweicloud.com>
 <20240416073806.50e3ff5d@peluse-desk5> <20240416154113.114dc42f@peluse-desk5>
In-Reply-To: <20240416154113.114dc42f@peluse-desk5>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28344.001
x-tm-as-result: No-10--7.668700-8.000000
x-tmase-matchedrid: 4uiQDFKJCRSmagT1k9kBpu5i6weAmSDKQV99ahimM1VYC5LPd7Bvbf3c
	g9WGG5V+HkAOv6n9gx5hoUIS5GGeElqzeP+fKaZirltvlARhKR0Jlr1xKkE5ucC5DTEMxpeQfiq
	1gj2xET/uo3YBjUsFh2kzi5An54UG0UwGeYlGH8nOvXpg7ONnXYiuaoNXJrK/njPfVXLnMPpdvd
	jb5IwdboBsLAy4Xg8nk60UwrkrF+Q7mT8/EEC+/t5x7RpGJf1aWC/7aMfV0JHyXa/7gO3s/eQ5w
	ujMC0dGS8TZctow9KA99FRUGO9LC6sKBwAAbK0INT0Qrj4fxTWhxK8Q8oY751PJPmOOhanxBUz2
	Q+xpjHgAr2+Yl5G+KEqGW42c0HkYUrCpHdMhGxSSJLHHb2KALZ8z6yZBmpaQePIcxyHyQ7B/HKm
	e7ZTCHzu0b394gf+xqvVqP+O9J1pK69zQ3OcNluJMNIftzCCT9qZsX+XDJhCHvxzu1FG4kXHoU3
	FSpRakyP5rOgF6xbQk6hi9T3GK5+9MJYPOVXnMZ7RHc0AX9yEQOcMSo0926rEOBl2MVn3Qmn3Zw
	Jqelp8aQPl5Dimwj2EjXesrhGFfNyl1nd9CIt2DGx/OQ1GV8gD6RpjqQGaF+gtHj7OwNO2FR9Ha
	u8GO7mOyIFxsyFI0FWgWw7VpSwggBNMyfWznSpWwJd6jQkqPYBKnkM8aAXc=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.668700-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28344.001
x-tm-snts-smtp: DC8A42DBCA8CCF84F8042C574AE0422201E5FF69DB6EAEFAAA9413D2596B34822000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB04.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB04.r1.kioxia.com

> > > Hi,
> > >
> > > =1B$B:_=1B(B 2024/04/18 13:44, tada keisuke =1B$B<LF;=1B(B:
> > > > This patch depends on patch 07.
> > > >
> > > > All rdevs running in RAID 1/10 switch nr_pending to atomic mode.
> > > > The value of nr_pending is read in a normal operation
> > > > (choose_best_rdev()). Therefore, nr_pending must always be
> > > > consistent.
> > > >
> > > > Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
> > > > Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
> > > > ---
> > > >   drivers/md/md.h     | 14 ++++++++++++++
> > > >   drivers/md/raid1.c  |  7 +++++++
> > > >   drivers/md/raid10.c |  4 ++++
> > > >   3 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > > > index ab09e312c9bb..57b09b567ffa 100644
> > > > --- a/drivers/md/md.h
> > > > +++ b/drivers/md/md.h
> > > > @@ -236,6 +236,20 @@ static inline unsigned long
> > > > nr_pending_read(struct md_rdev *rdev) return
> > > > atomic_long_read(&rdev->nr_pending.data->count); }
> > > >
> > > > +static inline bool nr_pending_is_percpu_mode(struct md_rdev
> > > > *rdev) +{
> > > > +	unsigned long __percpu *percpu_count;
> > > > +
> > > > +	return __ref_is_percpu(&rdev->nr_pending, &percpu_count);
> > > > +}
> > > > +
> > > > +static inline bool nr_pending_is_atomic_mode(struct md_rdev
> > > > *rdev) +{
> > > > +	unsigned long __percpu *percpu_count;
> > > > +
> > > > +	return !__ref_is_percpu(&rdev->nr_pending,
> > > > &percpu_count); +}
> > > > +
> > > >   static inline int is_badblock(struct md_rdev *rdev, sector_t s,
> > > > int sectors, sector_t *first_bad, int *bad_sectors)
> > > >   {
> > > > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > > > index 12318fb15a88..c38ae13aadab 100644
> > > > --- a/drivers/md/raid1.c
> > > > +++ b/drivers/md/raid1.c
> > > > @@ -784,6 +784,7 @@ static int choose_best_rdev(struct r1conf
> > > > *conf, struct r1bio *r1_bio) if (ctl.readable_disks++ =3D=3D 1)
> > > >   			set_bit(R1BIO_FailFast, &r1_bio->state);
> > > >
> > > > +		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
> > > >   		pending =3D nr_pending_read(rdev);
> > > >   		dist =3D abs(r1_bio->sector -
> > > > conf->mirrors[disk].head_position);
> > > > @@ -1930,6 +1931,7 @@ static int raid1_add_disk(struct mddev
> > > > *mddev, struct md_rdev *rdev) if (err)
> > > >   				return err;
> > > >
> > > > +
> > > > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> > > > raid1_add_conf(conf, rdev, mirror, false); /* As all devices are
> > > > equivalent, we don't need a full recovery
> > > >   			 * if this was recently any drive of the
> > > > array @@ -1949,6 +1951,7 @@ static int raid1_add_disk(struct mddev
> > > > *mddev, struct md_rdev *rdev) set_bit(Replacement, &rdev->flags);
> > > >   		raid1_add_conf(conf, rdev, repl_slot, true);
> > > >   		err =3D 0;
> > > > +
> > > > percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> > >
> > > I don't understand what's the point here, 'nr_pending' will be used
> > > when the rdev issuing IO, and it's always used as atomic mode, there
> > > is no difference.
> > >
> > > Consider that 'nr_pending' must be read from IO fast path, use it as
> > > atomic is something we must accept. Unless someone comes up with a
> > > plan to avoid reading 'inflight' counter from fast path like generic
> > > block layer, it's not ok to me to switch to percpu_ref for now.

The main purpose of this patchset is to improve RAID5 performance.
In the current RAID 1/10 design, the value of nr_pending is intentionally a=
lways in atomic mode because it must be read in IO fast path.
Unless the design of reading the value of nr_pending has changed, I believe=
 that this patchset is a reasonable design and RAID1 performance is about t=
he same as atomic_t before this patchset was applied.
Paul's results also show that.

Best Regards,
Keisuke

> > > +CC Paul
> > >
> > > HI, Paul, perhaps you RR mode doesn't need such 'inflight' counter
> > > anymore?
> > >
> >
> > I too am struggling to see the benefit but am curious enough that I
> > will run some tests on my own as I have fresh baseline RAID1 large
> > sweep performance data ready right now.
> >
> > So my WIP round robin patch won't need nr_pedning for SSDs but I think
> > it will for HDD plus I need a new atomic counter for round robin for
> > SSDs anyway but I see no perfomrnace impact so far from adding it.
> >
> > -Paul
> >
>=20
> I can run more if others are interested (RAID5 or HDD for example) but
> at least for RAID1 there's really no difference.  This was a quick run,
> just 40 sec each, 16 jobs and the rest ofthe fio params are on the
> charts. 2 disk RAID1. THe baseline is 6.8.0 from the md repo.
> Using my favorite drives, of course, KIOXIA KCMYDVUG3T20 :)
>=20
> Here's the results: https://photos.app.goo.gl/Avyw64eXCqWFWrs78
>=20
> NOTE:  There are few small randoms where it appears to help but I
> assumed that was because these are small randoms with very short run
> times.  SO I reran the 4K mixed rw randoms with 5 minute run time and
> that chart is at the very bottom and shows that over longer duration
> its a wash, there's no clear winner.  I'm sure an even longer run would
> show more consistently close results.


