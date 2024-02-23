Return-Path: <linux-kernel+bounces-77954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE267860D46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E281C1C241CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F21F93F;
	Fri, 23 Feb 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV9mxGVp"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF9250EB;
	Fri, 23 Feb 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678388; cv=none; b=gTagGs4X33riv7vszWoCWQTYHaLoxrFl1lVA3YsnAmgAeVNLvcNXrwxjQTC1MXBrS56NGB71eJslPqMTNl8kAgigbJFoD31hjPgfDsNqaFOPXMN8In4NYBB7r7MhtYPK/qYCpMsWoyMP5pzxUlk9chkJJ2wLYquWhr0T269Iw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678388; c=relaxed/simple;
	bh=P+0dV2bEhpRcGmHcWdU5rnbnRVpbRsTQwB4jPcw4OPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfOKcUdnONeGhzUwdPjczhZIB+u4ocY7Njak+J5Ru5xHkSNSu9YubFf3k/hkjAr5MQcLGGFE6OssaZ350PTxcrN/GNMZPDNrnWG7dLPJ3JJ2k8+QQHiWyG+NjphqgaOx6C+9EkDhpiDk7Vw2v0Uav1eFPryA4pOTsm2UsSsiO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV9mxGVp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso546908a12.1;
        Fri, 23 Feb 2024 00:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708678385; x=1709283185; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+0dV2bEhpRcGmHcWdU5rnbnRVpbRsTQwB4jPcw4OPU=;
        b=UV9mxGVpDR0xI/x7FxZ1pVtIc5zb6nuPm4bzVYRpQP54j6EvlqG3RrA5RHeifodqKs
         Ac+Ra1+rG41LzpsjLvf0uuPbGc6my20npCUQlbUbz9Lt5zP2cLG4CdS/+ERAyTUQu9dD
         0ddE4ku+GJyrVi1nYmZUMUHS4HS6XqrEH7eur3qEdA8J8P0h5cGVeIDjqFzyihHuxBmE
         2WxsbEknLXoacs3KfO0ffmdq8yBckYPKbaSDAcqK4OWwZqtnjrlB45AKRV9Xowr96V46
         czvXBIIBaCiBzgYQqI2K2TWd0U/lebGAF+xigbnUjBbgZ9P55FJwB+7kj8gRg4ZPUF7J
         JeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678385; x=1709283185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+0dV2bEhpRcGmHcWdU5rnbnRVpbRsTQwB4jPcw4OPU=;
        b=EkKP0cs2sOMR4KfFo825szWEYuUrknatbds4f3DX8lIbGJvyMMSyB6a92vxAxsqc3v
         e385ejxvpL8Q2Msx8mxnbnLLjUHd/AHQuvSMPYlMFGNAhvGEPmSoVvdfS/ZIMobxg5Vg
         mXqAbQxaT8X/iNcqeLR08Fu9a3wtu6l7HPErvkaRnzKrJcvxx2C2GqDGQAM3BWaR1i6q
         HNm9o6wHAk1bm295k+aWBBbTYMMlZRzSb4PXvjFl3qgDkh9bhSrt/SCBbMI1GLxnkLa7
         7Ba7pQv4dlB06pVEqYYHtG5r/rXRwqXR/7eWPrBfyYisoBvr5K06D/JcSa9uQS6MVXVg
         vEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXqFirrNAUrRTrAuGZTP1IcU4hr0EeBP7yZKFEEfVDXCEjLJ2jr2DP3xmvorqIA/eV0gxNcA8RNps2MfWV+0wpomsiFCce8G09ydnfPbLL/Bk2rUdY5jNn0rDjOweBtMIOZGVKkD5vGQ==
X-Gm-Message-State: AOJu0Yzgd3TI4HbqIQasgQYFS6J025F7Im63u75yodgXmU2l81XvXzhm
	EAfM+Be+BgCiLpz/LGrEkBP3nuDAdLDw7wo9s9F/Ld1UjL5AU8MW
X-Google-Smtp-Source: AGHT+IGavNnAptUN2blGRTmuOpPztaGMZwrcWqpMVXSQkqcqYXePoz816ryMUUKKxkraC8I2C9WyXw==
X-Received: by 2002:aa7:d958:0:b0:565:7ce5:abdb with SMTP id l24-20020aa7d958000000b005657ce5abdbmr380202eds.10.1708678384724;
        Fri, 23 Feb 2024 00:53:04 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id y11-20020a50e60b000000b00563d03030e8sm6194589edm.55.2024.02.23.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:53:04 -0800 (PST)
Message-ID: <bb1e42785d9fad7be1d48d1fa76a749e89a6a207.camel@gmail.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan
	 <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Fri, 23 Feb 2024 09:56:25 +0100
In-Reply-To: <20240223094628.340ad536@bootlin.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-2-herve.codina@bootlin.com>
	 <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
	 <c4e1092298244c288212e9f6cdbf7c26d0e9d83b.camel@gmail.com>
	 <CAGETcx9h4=k9XW+jZCw9zcVZruNZLPDQDt_sNZYXc05eQ2_uWQ@mail.gmail.com>
	 <20240223094628.340ad536@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 09:46 +0100, Herve Codina wrote:
> Hi,
>=20
> On Thu, 22 Feb 2024 17:08:28 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> > On Tue, Feb 20, 2024 at 10:56=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > >=20
> > > On Tue, 2024-02-20 at 16:31 -0800, Saravana Kannan wrote:=C2=A0=20
> > > > On Thu, Nov 30, 2023 at 9:41=E2=80=AFAM Herve Codina <herve.codina@=
bootlin.com>
> > > > wrote:=C2=A0=20
> > > > >=20
> > > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal"=
)
> > > > > introduces a workqueue to release the consumer and supplier devic=
es
> > > > > used
> > > > > in the devlink.
> > > > > In the job queued, devices are release and in turn, when all the
> > > > > references to these devices are dropped, the release function of =
the
> > > > > device itself is called.
> > > > >=20
> > > > > Nothing is present to provide some synchronisation with this work=
queue
> > > > > in order to ensure that all ongoing releasing operations are done=
 and
> > > > > so, some other operations can be started safely.
> > > > >=20
> > > > > For instance, in the following sequence:
> > > > > =C2=A0 1) of_platform_depopulate()
> > > > > =C2=A0 2) of_overlay_remove()
> > > > >=20
> > > > > During the step 1, devices are released and related devlinks are
> > > > > removed
> > > > > (jobs pushed in the workqueue).
> > > > > During the step 2, OF nodes are destroyed but, without any
> > > > > synchronisation with devlink removal jobs, of_overlay_remove() ca=
n
> > > > > raise
> > > > > warnings related to missing of_node_put():
> > > > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2
> > > > >=20
> > > > > Indeed, the missing of_node_put() call is going to be done, too l=
ate,
> > > > > from the workqueue job execution.
> > > > >=20
> > > > > Introduce device_link_wait_removal() to offer a way to synchroniz=
e
> > > > > operations waiting for the end of devlink removals (i.e. end of
> > > > > workqueue jobs).
> > > > > Also, as a flushing operation is done on the workqueue, the workq=
ueue
> > > > > used is moved from a system-wide workqueue to a local one.=C2=A0=
=20
> > > >=20
> > > > Thanks for the bug report and fix. Sorry again about the delay in
> > > > reviewing the changes.
> > > >=20
> > > > Please add Fixes tag for 80dd33cf72d1.
> > > > =C2=A0
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > ---
> > > > > =C2=A0drivers/base/core.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++=
+++++++---
> > > > > =C2=A0include/linux/device.h |=C2=A0 1 +
> > > > > =C2=A02 files changed, 24 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > index ac026187ac6a..2e102a77758c 100644
> > > > > --- a/drivers/base/core.c
> > > > > +++ b/drivers/base/core.c
> > > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > > > =C2=A0static void __fw_devlink_link_to_consumers(struct device *d=
ev);
> > > > > =C2=A0static bool fw_devlink_drv_reg_done;
> > > > > =C2=A0static bool fw_devlink_best_effort;
> > > > > +static struct workqueue_struct *fw_devlink_wq;
> > > > >=20
> > > > > =C2=A0/**
> > > > > =C2=A0 * __fwnode_link_add - Create a link between two fwnode_han=
dles.
> > > > > @@ -530,12 +531,26 @@ static void devlink_dev_release(struct devi=
ce
> > > > > *dev)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It may take a =
while to complete this work because of the
> > > > > SRCU
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronizatio=
n in device_link_release_fn() and if the
> > > > > consumer or
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices ge=
t deleted when it runs, so put it into
> > > > > the "long"
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices ge=
t deleted when it runs, so put it into
> > > > > the
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dedicated workqueue=
.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, =
&link->rm_work);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(fw_devlink_wq, &=
link->rm_work);=C2=A0=20
> > > >=20
> > > > This has nothing to do with fw_devlink. fw_devlink is just triggeri=
ng
> > > > the issue in device links. You can hit this bug without fw_devlink =
too.
> > > > So call this device_link_wq since it's consistent with device_link_=
*
> > > > APIs.
> > > > =C2=A0
> > >=20
> > > I'm not sure if I got this right in my series. I do call
> > > devlink_release_queue() to
> > > my queue. But on the Overlay side I use fwnode_links_flush_queue() be=
cause
> > > it looked
> > > more sensible from an OF point of view. And including (in OF code)
> > > linux/fwnode.h
> > > instead linux/device.h makes more sense to me.
> > > =C2=A0
> > > > > =C2=A0}
> > > > >=20
> > > > > +/**
> > > > > + * device_link_wait_removal - Wait for ongoing devlink removal j=
obs
> > > > > to terminate
> > > > > + */
> > > > > +void device_link_wait_removal(void)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal job=
s are queued in the dedicated work
> > > > > queue.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all=
 removal jobs are terminated, ensure
> > > > > that any
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has =
run to completion.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drain_workqueue(fw_devlink_=
wq);=C2=A0=20
> > > >=20
> > > > Is there a reason this needs to be drain_workqueu() instead of
> > > > flush_workqueue(). Drain is a stronger guarantee than we need in th=
is
> > > > case. All we are trying to make sure is that all the device link
> > > > remove work queued so far have completed.
> > > > =C2=A0
> > >=20
> > > Yeah, I'm also using flush_workqueue().
> > > =C2=A0
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > > +
> > > > > =C2=A0static struct class devlink_class =3D {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "devlink",
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D devlin=
k_groups,
> > > > > @@ -4085,9 +4100,14 @@ int __init devices_init(void)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_dev_char_kobj =
=3D kobject_create_and_add("char",
> > > > > dev_kobj);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysfs_dev_char_ko=
bj)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto char_kobj_err;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_devlink_wq =3D alloc_wor=
kqueue("fw_devlink_wq", 0, 0);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fw_devlink_wq)=C2=A0=
=20
> > > >=20
> > > > Fix the name appropriately here too please.=C2=A0=20
> > >=20
> > > Hi Saravana,
> > >=20
> > > Oh, was not aware of this series... Please look at my first patch. It
> > > already has a
> > > review tag by Rafael. I think the creation of the queue makes more se=
nse
> > > to be done
> > > in devlink_class_init(). Moreover, Rafael complained in my first vers=
ion
> > > that
> > > erroring out because we failed to create the queue is too harsh since
> > > devlinks can
> > > still work.=C2=A0=20
> >=20
> > I think Rafael can be convinced on this one. Firstly, if we fail to
> > allocate so early, we have bigger problems.
> >=20
> > > So, what we do is to schedule the work if we have a queue or too call
> > > device_link_release_fn() synchronously if we don't have the queue (no=
te
> > > that failing
> > > to allocate the queue is very unlikely anyways).=C2=A0=20
> >=20
> > device links don't really work when you synchronously need to delete a
> > link since it always uses SRCUs (it used to have a #ifndef CONFIG_SRCU
> > locking). That's like saying a code still works when it doesn't hit a
> > deadlock condition.
> >=20
> > Let's stick with Herve's patch series since he send it first and it
> > has fewer things that need to be fixed. If he ignores this thread for
> > too long, you can send a revision of yours again and we can accept
> > that.
>=20
> I don't ignore the thread :)
>=20
> Hope I could take some time in the near future to send a v2 of this
> series.

Hi Herve,

Just let me know if you don't see that happening anytime soon :). I'm very
interested in having this applied fairly soon and I think the base idea for=
 the
fix is more or less in place (for both series). So it should be minor detai=
ls
now :).

- Nuno S=C3=A1


