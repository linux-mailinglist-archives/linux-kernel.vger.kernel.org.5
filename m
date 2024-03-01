Return-Path: <linux-kernel+bounces-87994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1F86DBE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688901C21036
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4E6931E;
	Fri,  1 Mar 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E77RZDPO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9968464;
	Fri,  1 Mar 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277247; cv=none; b=RvDmA+Gp7xMkt9zSX3X0GEndQj6lX4k6yY8rRGKKoCrTgE+w7+GNomZ36KT9gquhElwp40xrdJ5HWa0NOGm30e1KMh8XGV23//fvHF7Hx28dG8k5cN58OM9nm/xtMRw25Z9b4oasxPQHUr7qN0MIo8TqYdgPdRbBiJ93A8PX95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277247; c=relaxed/simple;
	bh=zHyCNb+M7bJHZHKFsMuj1BXY3bDXLq7chS/v9D+XciM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1BdsG4hFmu/hdKniiUtJ7a+aBzEWQF93QgyO2vgmzKkiMwoDO/VwDueeaL5MuPZmYr51e3OC0fiFQuuj+VqgRbTxXweZXAGK5+YkqoFp9f9WFqlmpoXqklA4SqMrzdnfoALQqSUgMykuP9HFZXU+RS7hHspLt8xzhfsCWDA1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E77RZDPO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412c780464dso2366315e9.0;
        Thu, 29 Feb 2024 23:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709277243; x=1709882043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zHyCNb+M7bJHZHKFsMuj1BXY3bDXLq7chS/v9D+XciM=;
        b=E77RZDPOqk4n7KzUTBQQzH7LFbb+OsGvJ+x7iO+hFY8A3Veyh/HvTn7yq3fTTX9Q6P
         qyzXURWSb7dBIzhy0A1LZTwwTeOtN4es4qp3KApPa8c0hjtw9X4uCwdq7QGgZY9vY/un
         j5GB8Jx32bTh6JJo/neFdTFSpL1EVCaMxiDm6Y0KvamUvokDEKmEUbxcsv2MPT4TawWW
         3niC60+HdTTIv4Vmi9R9Lyl8xyybBG/3bCuD3nQGOCvKNXoLVQxR4ro3x9L6gpFRN8Ca
         49TU/bch+emPLRLSs111+9H10ybdcgbCpl3AK5okcPhRNxCYgvIMBUgIKmlowKbgJSGa
         Xt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709277243; x=1709882043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHyCNb+M7bJHZHKFsMuj1BXY3bDXLq7chS/v9D+XciM=;
        b=qFxAqJNCjYm0Tts0/AUQDukV6l8gjSyNYLqFH8zOWUOraWtScoCzEY4kaaiismmSPn
         xRyNiOsrzj0kGu49KLY3S+pV9qnY/HskVNSYCoJC17XHhTYQImiBUnMJMqR2cLxYJy98
         m2VL9ZmlRB+G5nuwr1V9RrBaXVShVblPq2nmhqko+WcIEXJLTt/tCIegRVEBheOORDIc
         Ad8Yo0UZVajdOdpBfO9JtV/OnZqE8oa/UFMpp+QRjuGat3HBABRQJN8/oFkWPrcO3YcS
         ID8xhxWfQuzalbOvxf49ZaRUoac0hnc1v1Ytlo5qocdw5lqEwqy8C8FpXCFN/tlX4FTH
         CTNg==
X-Forwarded-Encrypted: i=1; AJvYcCWq43IPtv3hEEuVFzGmckjk5vStcnYzopR5aVtXpd5o2uH4hxSnmEsNkAhdBe+dNeiZ9nNc6OjZuULJTS4xSsDMJ6m3qFCAXwUSy2Z9hpjp14DWGVCvbyOWL0y95jGVqsK7cy92YxDhrw==
X-Gm-Message-State: AOJu0YzhyCtpsBmvgLb/Tk5WeVlGT5YbpDzJumFxSMw+qyfvKtUooOpa
	SEtYt2x6OpqFrbZU4iN8cWtsRPWuilwtPFpqpQKlKc/+25i12EqBQjuotNUJLen1u21D
X-Google-Smtp-Source: AGHT+IGDbROoWlVJ969kkwExks+L4YEqs3G96Q+NVASKSMB3EQkkEnL2Tq08jV3KYBWipmBSVSKugg==
X-Received: by 2002:a05:600c:3d87:b0:412:c1d5:1e96 with SMTP id bi7-20020a05600c3d8700b00412c1d51e96mr650572wmb.16.1709277242947;
        Thu, 29 Feb 2024 23:14:02 -0800 (PST)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b0033e17341ebesm2254817wrx.117.2024.02.29.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:14:02 -0800 (PST)
Message-ID: <98c8c1389995b70e62a72daf42908c45d3cbe544.camel@gmail.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi
 Hou <lizhi.hou@amd.com>,  Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Fri, 01 Mar 2024 08:14:01 +0100
In-Reply-To: <CAGETcx9x55moTrvcDCup_K0DU305TtjK4Nvjf_drfipyowKb=w@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-2-herve.codina@bootlin.com>
	 <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
	 <20240223101115.6bf7d570@bootlin.com>
	 <cdf0a9facd95a2b7ee618e6130dedb9aabf4ed09.camel@gmail.com>
	 <CAGETcx9x55moTrvcDCup_K0DU305TtjK4Nvjf_drfipyowKb=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 15:26 -0800, Saravana Kannan wrote:
> On Fri, Feb 23, 2024 at 2:41=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Fri, 2024-02-23 at 10:11 +0100, Herve Codina wrote:
> > > Hi Saravana,
> > >=20
> > > On Tue, 20 Feb 2024 16:31:13 -0800
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >=20
> > > ...
> > >=20
> > > > > +void device_link_wait_removal(void)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal job=
s are queued in the dedicated work queue.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all=
 removal jobs are terminated, ensure that
> > > > > any
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has =
run to completion.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drain_workqueue(fw_devlink_=
wq);
> > > >=20
> > > > Is there a reason this needs to be drain_workqueu() instead of
> > > > flush_workqueue(). Drain is a stronger guarantee than we need in th=
is
> > > > case. All we are trying to make sure is that all the device link
> > > > remove work queued so far have completed.
> > >=20
> > > I used drain_workqueue() because drain_workqueue() allows for jobs al=
ready
> > > present in a workqueue to re-queue a job and drain_workqueue() will w=
ait
> > > also for this new job completion.
> > >=20
> > > I think flush_workqueue() doesn't wait for this chain queueing.
> > >=20
> > > In our case, my understanding was that device_link_release_fn() calls
> > > put_device() for the consumer and the supplier.
> > > If refcounts reaches zero, devlink_dev_release() can be called again
> > > and re-queue a job.
> > >=20
> >=20
> > Looks sensible. The only doubt (that Saravana mays know better) is that=
 I'm not
> > sure put_device() on a supplier or consumer can actually lead to
> > devlink_dev_release(). AFAIU, a consumer or a supplier should not be a =
device
> > from the devlink class. Hence, looking at device_release(), I'm not sur=
e it can
> > happen unless for some odd reason someone is messing with devlinks in .=
remove()
> > or .type->remove().
>=20
> The case we are trying to fix here involves a supplier or a consumer
> device (say Device-A) being device_del(). When that happens, all the
> device links to/from the device are deleted by a call to
> device_links_purge() since a device link can't exist without both the
> supplier and consumer existing.
>=20
> The problem you were hitting is that the device link deletion code
> does the put_device(Device-A) in a workqueue. You change is to make
> sure to wait until that has completed. To do that, you only need to
> wait for the device link deletion work (already queued before
> returning from device_del()) to finish. You don't need to wait for
> anything more.
>=20
> I read up on drain_workqueue() before I made my comments. The point I
> was trying to make is that there could be some unrelated device link
> deletions that you don't need to wait on.
>=20
> But taking a closer look[1], it looks like drain_workqueue() might
> actually cause bugs because while a workqueue is being drained, if
> another unrelated device link deletion is trying to queue work, that
> will get ignored.
>=20

Oh, even worst then... please also take a look at the new v3 Herve sent. He=
rve is
already convinced about flush_workqueue(). The other sensible discussion is=
 about
releasing the of_mutex in patch 2. I'm not convinced we need it but you may=
 know
better.

> Reply to rest of the emails in this thread here:
>=20
> Nuno,
>=20
> Sorry if I messed up who sent the first patch, but I did dig back to
> your v1. But I could be wrong.
>=20

I did sent first a RFC [1] (which should also count :)). And it actually to=
ok a lot
of "pushing" with resends to get some attention on this. And if follow the =
RFC you'll
even see that I first reported the issue in May or something (but did not r=
eally put
too much effort on it at the time).

I have to admit it's a bit frustrating given how much I pushed and insisted=
 in fixing
this (and not have my own patches in :P). But that's life and in the end of=
 day I
just care about this being fixed. So, no hard feelings :).

> If devlink_dev_release() could have done the work synchronously, we'd
> have done it in the first place. It's actually a bug because
> devlink_dev_release() gets called in atomic context but the
> put_device() on the supplier/consumer can do some sleeping work.
>=20

Not sure I'm following the above. I may be missing something but looking at=
 the code
paths it actually looks like devlink_dev_release() is always called with th=
e
device_links_lock held. Therefore we need to be already in a sleeping conte=
xt or we
already have a problem...

Looking at git history, the problem we had before was that we were using ca=
ll_srcu()
and the srcu callback cannot sleep which could happen=C2=A0in a device rele=
ase function.

Anyways, Rafael already said he's fine in erroring out in case the queue fa=
ils to
allocate (as you said, if that happens the system is already likely screwed=
). My only
complain now is in the place we're allocating the queue.

[1]: https://lore.kernel.org/lkml/20231127-fix-device-links-overlays-v1-1-d=
7438f56d025@analog.com/

- Nuno S=C3=A1

> -Saravana
>=20
> [1] -
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/workqueue.c#n1727


