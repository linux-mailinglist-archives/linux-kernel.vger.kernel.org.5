Return-Path: <linux-kernel+bounces-46733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D13844351
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F39B21BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47C129A83;
	Wed, 31 Jan 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD7D9pFK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24111128388
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715983; cv=none; b=OZjy9OHY3zukJL6/s9wFmofNcmY4nuvJIz4Fc3hP5NhHehKrSFTZmABKr4VrPMRCfTt0V0USNYNS6Kzqv9HJnTX5ueMFQv6Rbl4NUaDyzpGIOSGzE3eWN9cvHQtRx7PKeUQsGfI4FOmL62rq1q7CaclK8ayDdNZTobIZSf1bhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715983; c=relaxed/simple;
	bh=bl6GCEctucb3LpTEmA4gsfZksjVDsZCA1p+RTxHMwIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHz+yYGLoqyQ7x5CAVbZk5dXSKzsviIX7GEu/29MiJIb4lDp+ad5rNfTlU8JHufzBKLI9WfZC7O08hpOmiWBIFRvu5pz1p5MxcIzEoFkKZjFvQb5VH7JfDD/4YMOUvUYAeUHfo8fD5SkmNTClU7FZPay1ZB2bcRrrVI3NybY3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD7D9pFK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso69353325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706715979; x=1707320779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bl6GCEctucb3LpTEmA4gsfZksjVDsZCA1p+RTxHMwIE=;
        b=JD7D9pFKO0RVDyxwB4mNJyO4/NO0gDWkl1AqnJrF4QgURkiu6wJ0WIr5wQS8nLzVXc
         VEB+TxD4eZCUcb9TzPJ3B9ZXK+imM/X5/zPW1QqcT/R8PLyenFnoW8I0GrVfHohbvooN
         TnixHSzFQoRJ8mYNpFzftqVvNyy7Hu5NcpeRd3/Lo1xQ62aVQ/3REgzM+iZVTgc4KlH8
         7obG66dWfr8uD+wX4rRHYg1HQ93FqecHNuO0eoft8Ipop06GBtTaxEa8e8+j9AYnBvVU
         0I5k1dyOVlOlLQIGj6c7jre+9Y0t6qHQYbtAbV7m3iZ5BpFQG5FpVa3Hn6QUrR6Gv7yM
         Zzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715979; x=1707320779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bl6GCEctucb3LpTEmA4gsfZksjVDsZCA1p+RTxHMwIE=;
        b=Tv0/1/2s5MZQdbUoX1+UD6C1dXIjQvA5IY9BRQiGgU2u5zkvE4COaESp+zhOaA1PPf
         hwRH4Ho5C10WzqOW8X6pxTxMHBPIKXnoPZRJaDceZ5aNeGBaGWe4gIQ+E7sxcVXMHsK+
         EKhIr/GlkMwbj3vREqTGJF8bZhzo1hV/x+t0imLKTsTSFjVuhihcRkmPJSg58L9RLPic
         Xi8GY5apxjclowUQmH9ige9zWKDzmH4G52FAdAwRjuOelgQQAAQ09JIfDyw9NIrCTMP2
         mh37TJAvEmjU/v34TLmOHemvvoPLATlk7ZAERQemTBTP2jptLAm9sWQu50LzREAWuHhc
         1qqg==
X-Gm-Message-State: AOJu0YyDuZRGhQgvvOmstnQysVsM8Ibf18mNxxRMG48E8id1mqbftHlR
	NA6P09JHN2RirOC691wt5ukIrEMgs4FtnEiIOOxpE0Lm7yRlk2+nX9+zFB+45dxmj5Or
X-Google-Smtp-Source: AGHT+IFyUnVV7jQxNNEqOIpLYcl6y/fU9KkG6FseN527Zh/6cClvUHwINvHEcCubczVu7lYRXdXK4g==
X-Received: by 2002:a05:600c:35d3:b0:40e:fc29:f52f with SMTP id r19-20020a05600c35d300b0040efc29f52fmr1655969wmq.21.1706715979035;
        Wed, 31 Jan 2024 07:46:19 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4b9100b0040e3bdff98asm1889149wmp.23.2024.01.31.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:46:18 -0800 (PST)
Message-ID: <9a4b4dd60c35dd4e00b97e19fced0e79a86f6eef.camel@gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links
 removal for dt overlays
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: nuno.sa@analog.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org,  Saravana Kannan <saravanak@google.com>
Date: Wed, 31 Jan 2024 16:49:35 +0100
In-Reply-To: <CAJZ5v0hW60++hhKG=yBE7+rB9qt2m+tO_WAf=YFhNU2-y3VHFw@mail.gmail.com>
References: 
	<20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
	 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
	 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
	 <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
	 <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com>
	 <8682d7f7ee1a60902b1f3e5529a4adbaf4846aa0.camel@gmail.com>
	 <CAJZ5v0hW60++hhKG=yBE7+rB9qt2m+tO_WAf=YFhNU2-y3VHFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:10 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 3:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Wed, 2024-01-31 at 15:28 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >=20
> > > > On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno=
@gmail.com> wrote:
> > > > > >=20
> > > > > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > >=20
> > > > > > > For device links, releasing the supplier/consumer devices
> > > > > > > references
> > > > > > > happens asynchronously in device_link_release_fn(). Hence, th=
e
> > > > > > > possible
> > > > > > > release of an of_node is also asynchronous. If these nodes we=
re
> > > > > > > added
> > > > > > > through overlays we have a problem because this does not resp=
ect
> > > > > > > the
> > > > > > > devicetree overlays assumptions that when a changeset is
> > > > > > > being removed in __of_changeset_entry_destroy(), it must hold=
 the
> > > > > > > last
> > > > > > > reference to that node. Due to the async nature of device lin=
ks
> > > > > > > that
> > > > > > > cannot be guaranteed.
> > > > > > >=20
> > > > > > > Given the above, in case one of the link consumer/supplier is=
 part
> > > > > > > of
> > > > > > > an overlay node we call directly device_link_release_fn() ins=
tead
> > > > > > > of
> > > > > > > queueing it. Yes, it might take some significant time for
> > > > > > > device_link_release_fn() to complete because of synchronize_s=
rcu()
> > > > > > > but
> > > > > > > we would need to, anyways, wait for all OF references to be
> > > > > > > released
> > > > > > > if
> > > > > > > we want to respect overlays assumptions.
> > > > > > >=20
> > > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > > ---
> > > > > > > This RFC is a follow up of a previous one that I sent to the
> > > > > > > devicetree
> > > > > > > folks [1]. It got rejected because it was not really fixing t=
he
> > > > > > > root
> > > > > > > cause of the issue (which I do agree). Please see the link wh=
ere I
> > > > > > > fully explain what the issue is.
> > > > > > >=20
> > > > > > > I did also some git blaming and did saw that commit
> > > > > > > 80dd33cf72d1 ("drivers: base: Fix device link removal") intro=
duced
> > > > > > > queue_work() as we could be releasing the last device referen=
ce
> > > > > > > and
> > > > > > > hence
> > > > > > > sleeping which is against SRCU callback requirements. However=
,
> > > > > > > that
> > > > > > > same
> > > > > > > commit is now making use of synchronize_srcu() which may take
> > > > > > > significant time (and I think that's the reason for the work
> > > > > > > item?).
> > > > > > >=20
> > > > > > > However, given the dt overlays requirements, I'm not seeing a=
ny
> > > > > > > reason to not be able to run device_link_release_fn()
> > > > > > > synchronously if
> > > > > > > we
> > > > > > > detect an OVERLAY node is being released. I mean, even if we =
come
> > > > > > > up
> > > > > > > (and I did some experiments in this regard) with some async
> > > > > > > mechanism
> > > > > > > to
> > > > > > > release the OF nodes refcounts, we still need a synchronizati=
on
> > > > > > > point
> > > > > > > somewhere.
> > > > > > >=20
> > > > > > > Anyways, I would like to have some feedback on how acceptable
> > > > > > > would
> > > > > > > this
> > > > > > > be or what else could I do so we can have a "clean" dt overla=
y
> > > > > > > removal.
> > > > > > >=20
> > > > > > > I'm also including dt folks so they can give some comments on=
 the
> > > > > > > new
> > > > > > > device_node_overlay_removal() function. My goal is to try to
> > > > > > > detect
> > > > > > > when
> > > > > > > an
> > > > > > > overlay is being removed (maybe we could even have an explici=
t
> > > > > > > flag
> > > > > > > for
> > > > > > > it?) and only directly call device_link_release_fn() in that =
case.
> > > > > > >=20
> > > > > > > [1]:
> > > > > > > https://lore.kernel.org/linux-devicetree/20230511151047.17798=
41-1-nuno.sa@analog.com/
> > > > > > > ---
> > > > > > > =C2=A0drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > > > > > =C2=A01 file changed, 24 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > > index 14d46af40f9a..31ea001f6142 100644
> > > > > > > --- a/drivers/base/core.c
> > > > > > > +++ b/drivers/base/core.c
> > > > > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[]=
 =3D {
> > > > > > > =C2=A0};
> > > > > > > =C2=A0ATTRIBUTE_GROUPS(devlink);
> > > > > > >=20
> > > > > > > +static bool device_node_overlay_removal(struct device *dev)
> > > > > > > +{
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev_of_node(dev))
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of_nod=
e, OF_DETACHED))
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of_nod=
e, OF_OVERLAY))
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;
> > > > > > > +
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > > > > > +}
> > > > > > > +
> > > > > > > =C2=A0static void device_link_release_fn(struct work_struct *=
work)
> > > > > > > =C2=A0{
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_link *link =3D c=
ontainer_of(work, struct
> > > > > > > device_link,
> > > > > > > rm_work);
> > > > > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct d=
evice
> > > > > > > *dev)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in dev=
ice_link_release_fn() and if the
> > > > > > > consumer
> > > > > > > or
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices get d=
eleted when it runs, so put it into
> > > > > > > the
> > > > > > > "long"
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * However, if any of the supp=
lier, consumer nodes is being
> > > > > > > removed
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * through overlay removal, th=
e expectation in
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * __of_changeset_entry_destro=
y() is for the node 'kref' to
> > > > > > > be 1
> > > > > > > which
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cannot be guaranteed with t=
he async nature of
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device_link_release_fn(). H=
ence, do it synchronously for
> > > > > > > the
> > > > > > > overlay
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * case.
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->r=
m_work);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (device_node_overlay_removal(lin=
k->consumer) ||
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_node=
_overlay_removal(link->supplier))
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 device_link_release_fn(&link->rm_work);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 queue_work(system_long_wq, &link->rm_work);
> > > > > > > =C2=A0}
> > > > > > >=20
> > > > > > > =C2=A0static struct class devlink_class =3D {
> > > > > > >=20
> > > > > > > ---
>=20
> [cut]
>=20
> > > No, IMV devlink_dev_release() needs to be called via
> > > device_link_put_kref(), but it may run device_link_release_fn()
> > > directly if the link is marked in a special way or something like
> > > this.
> >=20
> > Sorry, I'm not totally getting this. I'm directly calling
> > device_link_release_fn() from=C2=A0 devlink_dev_release(). We should on=
ly get
> > into
> > devlink_dev_release() after all the references are dropped right (being=
 it
> > the
> > release callback for the link class)?
>=20
> OK, I got confused somehow, sorry.
>=20
> It should work.
>=20
> I kind of don't like adding OF-specific code to the driver core, but
> if this is fine with Greg, it can be done.=C2=A0 It should depend on

Not perfect but I'm not seeing any other way. We need to somehow see if the=
 node
is part of an OVERLAY and AFAIK, the only way is looking at the node flags.=
 I'll
wait on Greg's feedback.

> CONFIG_OF_OVERLAY, though.

I guess that should be already indirectly implied. I mean if CONFIG_OF_OVER=
LAY
is not set, I guess there's not way for
of_node_check_flag(dev->of_node, OF_OVERLAY)) return true. But yeah, I can =
bail
out right away if IS_ENABLED(CONFIG_OF_OVERLAY) is not set.

> I would like a comment to be added to device_link_release_fn() to
> explain why the overlay case needs synchronous execution in there.

I do have the following comment before checking device_node_overlay_removal=
():


"* However, if any of the supplier, consumer nodes is being removed
 * through overlay removal, the expectation in
 * __of_changeset_entry_destroy() is for the node 'kref' to be 1 which
 * cannot be guaranteed with the async nature of
 * device_link_release_fn(). Hence, do it synchronously for the overlay
 * case."

I can elaborate more if you prefer...

>=20
> > device_node_overlay_removal() is my way to see if the link "is marked i=
n a
> > special way" as you put it. This checks if one of the supplier/consumer=
 is
> > marked as an OVERLAY and if it's being removed (I think that OF_DETACHE=
D
> > tells
> > us that but some feedback from DT guys will be helpful).
> >=20
> > Alternatively, I could just check the OF_OVERLAY flag when the link is =
being
> > created and have a new variable in struct device_link to flag the
> > synchronous
> > release. Disadvantage is that in this way even a sysfs unbind or module
> > unload
> > (without necessarily removing the overly) would lead to a synchronous
> > release
> > which can actually make sense (now that I think about it). Because if
> > someone
> > does some crazy thing like "echo device > unbind" and then removes the
> > overlay
> > we could still hit the overly removal path before device_link_release_f=
n()
> > completed.
>=20
> This sounds more complicated than the current patch.

Agreed...

- Nuno S=C3=A1

