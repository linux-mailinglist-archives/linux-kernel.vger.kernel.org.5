Return-Path: <linux-kernel+bounces-47773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767608452A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD15A1F261A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A3158D9D;
	Thu,  1 Feb 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaBzDN3f"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1D3158D7C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775884; cv=none; b=fdlqW3Hf+AhrR8mu/6Og8fym0hPuzffOd/wgKX0ZVx1NWcCc7sxTKX7L5lyVyQog5zbMlQKZPKde17AwRCWSyvFuDCsrrnPIbnZK5TAfcHiVNFRnyqBxoiYmfcglcQ0z17OADlD4h4z+B6bx0YRupsj39+5KkPF8zk97O5ZxmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775884; c=relaxed/simple;
	bh=nHXt1Dp2jSr4fCGQT8FH/tmmfiC/MkvLT78PNHEXGzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=am4BY+7Yg5j/OXfs1IpF7m6OyPJ3MVHSuM/oUXPibuhg+10W+yaEYUF78M5dPTbsNd5wq+7lcoXSHsoUGa5/WhLXNfmNwHptAzuqtAK1Na0KXFReeYAFyG5LeHYMMngEfvRA3tOjIlTadv4vPn9shmJ483bTexh6ZOBQV9sYWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaBzDN3f; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55fc9a581f8so90591a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775880; x=1707380680; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nHXt1Dp2jSr4fCGQT8FH/tmmfiC/MkvLT78PNHEXGzE=;
        b=XaBzDN3fzIFeF+9BMENb4suJJytwiDeZ9VvPqRwx/E8owDBCGx/xyXJ4WPGoqVT2PP
         a40SRuypG22UvKX6Xakg4qVasD+9BdvnrTrXp1ojrBEFA5Q6IAfM4ELSR8k+EWMv8GfV
         AYGBFT+tAJk0JggtXnbzMLeIXMzeeXrQp0/jVVXCJ7JUGhnYCvOiRaI2ryyDZtBZyDHL
         aRm2gtqWU50sjq6KZTFuWpBQ6919dsky7EUEPfoWb6ceWuGdrPOuoZCM6mI4vS8hAr3U
         App5Ng2qfZSsI9Hbt5ffa1rhrYKv1ABbBpJi6VA785fQfUTMHz6PuzL42Oop099avsEc
         wGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775880; x=1707380680;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHXt1Dp2jSr4fCGQT8FH/tmmfiC/MkvLT78PNHEXGzE=;
        b=ZjKK6miT2ifW7ebG5/ThG04NMhA2LEp+gNt3w7kMX310i2HbTGz3sBZeNzATaNr+Ot
         NhXZtjNfXjrcgEoZ6HTigrt5QlmpJcTh0QDE3hM5auBxEUbtlTQC0IGaDik2feQ7L7g6
         23kxzsHxtko9GgnWjtPG+rIjdO9PYAzzLi8oR/6TewKTnSosNjuEPvrJd+gSlDSS6Ecw
         ShElS1aShEpAow2DvBflg64LUeMQdafUayWcVpvs+C7kC9QrIk+gppdDnIn22nnUWwH3
         mrwFayECBBszac3wg83R0R3jINh5DR//xC+34CYXjOUSpnTPSSDIPZN1+y70pwrSFtqh
         803g==
X-Gm-Message-State: AOJu0Yy627AKUiOHANBvd6IzoKWjVoXPJryGra3BVu+Kn5FK4GMQD/Y9
	GR1QXHecz1rS+YNvs+5MnLeZOQEhVl3qxkZh+pNCXFkn08g07VKU+kO4K+VJSUTkWAvZ
X-Google-Smtp-Source: AGHT+IH49fgByfl1LfnGqpFGC2kywuRdEvMHqY76KOAa845Az0ac6RQmyzwmj6MpAUL3/nMW59HHAw==
X-Received: by 2002:aa7:c988:0:b0:55f:3d22:b307 with SMTP id c8-20020aa7c988000000b0055f3d22b307mr2343351edt.41.1706775879947;
        Thu, 01 Feb 2024 00:24:39 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402340b00b0055f11bd3564sm3399222edc.8.2024.02.01.00.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:24:39 -0800 (PST)
Message-ID: <670808962822c7f3be7072f5bcd8cec6536e98bc.camel@gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links
 removal for dt overlays
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: nuno.sa@analog.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org,  Saravana Kannan <saravanak@google.com>
Date: Thu, 01 Feb 2024 09:24:39 +0100
In-Reply-To: <CAJZ5v0hbGF6u5D8iyiziWMceph124wnC6KOH+V9Y2xqQgkZu5g@mail.gmail.com>
References: 
	<20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
	 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
	 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
	 <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
	 <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com>
	 <8682d7f7ee1a60902b1f3e5529a4adbaf4846aa0.camel@gmail.com>
	 <CAJZ5v0hW60++hhKG=yBE7+rB9qt2m+tO_WAf=YFhNU2-y3VHFw@mail.gmail.com>
	 <9a4b4dd60c35dd4e00b97e19fced0e79a86f6eef.camel@gmail.com>
	 <CAJZ5v0hbGF6u5D8iyiziWMceph124wnC6KOH+V9Y2xqQgkZu5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 17:05 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 4:46=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Wed, 2024-01-31 at 16:10 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Jan 31, 2024 at 3:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >=20
> > > > On Wed, 2024-01-31 at 15:28 +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno=
@gmail.com> wrote:
> > > > > >=20
> > > > > > On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > > > > > > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.=
nuno@gmail.com> wrote:
> > > > > > > >=20
> > > > > > > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wro=
te:
> > > > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > >=20
> > > > > > > > > For device links, releasing the supplier/consumer devices
> > > > > > > > > references
> > > > > > > > > happens asynchronously in device_link_release_fn(). Hence=
, the
> > > > > > > > > possible
> > > > > > > > > release of an of_node is also asynchronous. If these node=
s were
> > > > > > > > > added
> > > > > > > > > through overlays we have a problem because this does not =
respect
> > > > > > > > > the
> > > > > > > > > devicetree overlays assumptions that when a changeset is
> > > > > > > > > being removed in __of_changeset_entry_destroy(), it must =
hold the
> > > > > > > > > last
> > > > > > > > > reference to that node. Due to the async nature of device=
 links
> > > > > > > > > that
> > > > > > > > > cannot be guaranteed.
> > > > > > > > >=20
> > > > > > > > > Given the above, in case one of the link consumer/supplie=
r is part
> > > > > > > > > of
> > > > > > > > > an overlay node we call directly device_link_release_fn()=
 instead
> > > > > > > > > of
> > > > > > > > > queueing it. Yes, it might take some significant time for
> > > > > > > > > device_link_release_fn() to complete because of synchroni=
ze_srcu()
> > > > > > > > > but
> > > > > > > > > we would need to, anyways, wait for all OF references to =
be
> > > > > > > > > released
> > > > > > > > > if
> > > > > > > > > we want to respect overlays assumptions.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > > ---
> > > > > > > > > This RFC is a follow up of a previous one that I sent to =
the
> > > > > > > > > devicetree
> > > > > > > > > folks [1]. It got rejected because it was not really fixi=
ng the
> > > > > > > > > root
> > > > > > > > > cause of the issue (which I do agree). Please see the lin=
k where I
> > > > > > > > > fully explain what the issue is.
> > > > > > > > >=20
> > > > > > > > > I did also some git blaming and did saw that commit
> > > > > > > > > 80dd33cf72d1 ("drivers: base: Fix device link removal") i=
ntroduced
> > > > > > > > > queue_work() as we could be releasing the last device ref=
erence
> > > > > > > > > and
> > > > > > > > > hence
> > > > > > > > > sleeping which is against SRCU callback requirements. How=
ever,
> > > > > > > > > that
> > > > > > > > > same
> > > > > > > > > commit is now making use of synchronize_srcu() which may =
take
> > > > > > > > > significant time (and I think that's the reason for the w=
ork
> > > > > > > > > item?).
> > > > > > > > >=20
> > > > > > > > > However, given the dt overlays requirements, I'm not seei=
ng any
> > > > > > > > > reason to not be able to run device_link_release_fn()
> > > > > > > > > synchronously if
> > > > > > > > > we
> > > > > > > > > detect an OVERLAY node is being released. I mean, even if=
 we come
> > > > > > > > > up
> > > > > > > > > (and I did some experiments in this regard) with some asy=
nc
> > > > > > > > > mechanism
> > > > > > > > > to
> > > > > > > > > release the OF nodes refcounts, we still need a synchroni=
zation
> > > > > > > > > point
> > > > > > > > > somewhere.
> > > > > > > > >=20
> > > > > > > > > Anyways, I would like to have some feedback on how accept=
able
> > > > > > > > > would
> > > > > > > > > this
> > > > > > > > > be or what else could I do so we can have a "clean" dt ov=
erlay
> > > > > > > > > removal.
> > > > > > > > >=20
> > > > > > > > > I'm also including dt folks so they can give some comment=
s on the
> > > > > > > > > new
> > > > > > > > > device_node_overlay_removal() function. My goal is to try=
 to
> > > > > > > > > detect
> > > > > > > > > when
> > > > > > > > > an
> > > > > > > > > overlay is being removed (maybe we could even have an exp=
licit
> > > > > > > > > flag
> > > > > > > > > for
> > > > > > > > > it?) and only directly call device_link_release_fn() in t=
hat case.
> > > > > > > > >=20
> > > > > > > > > [1]:
> > > > > > > > > https://lore.kernel.org/linux-devicetree/20230511151047.1=
779841-1-nuno.sa@analog.com/
> > > > > > > > > ---
> > > > > > > > > =C2=A0drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > > > > > > > =C2=A01 file changed, 24 insertions(+), 1 deletion(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > > > > index 14d46af40f9a..31ea001f6142 100644
> > > > > > > > > --- a/drivers/base/core.c
> > > > > > > > > +++ b/drivers/base/core.c
> > > > > > > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_att=
rs[] =3D {
> > > > > > > > > =C2=A0};
> > > > > > > > > =C2=A0ATTRIBUTE_GROUPS(devlink);
> > > > > > > > >=20
> > > > > > > > > +static bool device_node_overlay_removal(struct device *d=
ev)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev_of_node(dev))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of=
_node, OF_DETACHED))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!of_node_check_flag(dev->of=
_node, OF_OVERLAY))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > =C2=A0static void device_link_release_fn(struct work_stru=
ct *work)
> > > > > > > > > =C2=A0{
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_link *link =
=3D container_of(work, struct
> > > > > > > > > device_link,
> > > > > > > > > rm_work);
> > > > > > > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(stru=
ct device
> > > > > > > > > *dev)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization in=
 device_link_release_fn() and if the
> > > > > > > > > consumer
> > > > > > > > > or
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supplier devices g=
et deleted when it runs, so put it into
> > > > > > > > > the
> > > > > > > > > "long"
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * workqueue.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * However, if any of the =
supplier, consumer nodes is being
> > > > > > > > > removed
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * through overlay removal=
, the expectation in
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * __of_changeset_entry_de=
stroy() is for the node 'kref' to
> > > > > > > > > be 1
> > > > > > > > > which
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cannot be guaranteed wi=
th the async nature of
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device_link_release_fn(=
). Hence, do it synchronously for
> > > > > > > > > the
> > > > > > > > > overlay
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * case.
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &lin=
k->rm_work);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (device_node_overlay_removal=
(link->consumer) ||
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_=
node_overlay_removal(link->supplier))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device_link_release_fn(&link->rm_work);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 queue_work(system_long_wq, &link->rm_work);
> > > > > > > > > =C2=A0}
> > > > > > > > >=20
> > > > > > > > > =C2=A0static struct class devlink_class =3D {
> > > > > > > > >=20
> > > > > > > > > ---
> > >=20
> > > [cut]
> > >=20
> > > > > No, IMV devlink_dev_release() needs to be called via
> > > > > device_link_put_kref(), but it may run device_link_release_fn()
> > > > > directly if the link is marked in a special way or something like
> > > > > this.
> > > >=20
> > > > Sorry, I'm not totally getting this. I'm directly calling
> > > > device_link_release_fn() from=C2=A0 devlink_dev_release(). We shoul=
d only get
> > > > into
> > > > devlink_dev_release() after all the references are dropped right (b=
eing it
> > > > the
> > > > release callback for the link class)?
> > >=20
> > > OK, I got confused somehow, sorry.
> > >=20
> > > It should work.
> > >=20
> > > I kind of don't like adding OF-specific code to the driver core, but
> > > if this is fine with Greg, it can be done.=C2=A0 It should depend on
> >=20
> > Not perfect but I'm not seeing any other way. We need to somehow see if=
 the node
> > is part of an OVERLAY and AFAIK, the only way is looking at the node fl=
ags. I'll
> > wait on Greg's feedback.
> >=20
> > > CONFIG_OF_OVERLAY, though.
> >=20
> > I guess that should be already indirectly implied. I mean if CONFIG_OF_=
OVERLAY
> > is not set, I guess there's not way for
> > of_node_check_flag(dev->of_node, OF_OVERLAY)) return true. But yeah, I =
can bail
> > out right away if IS_ENABLED(CONFIG_OF_OVERLAY) is not set.
> >=20
> > > I would like a comment to be added to device_link_release_fn() to
> > > explain why the overlay case needs synchronous execution in there.
> >=20
> > I do have the following comment before checking device_node_overlay_rem=
oval():
> >=20
> >=20
> > "* However, if any of the supplier, consumer nodes is being removed
> > =C2=A0* through overlay removal, the expectation in
> > =C2=A0* __of_changeset_entry_destroy() is for the node 'kref' to be 1 w=
hich
> > =C2=A0* cannot be guaranteed with the async nature of
> > =C2=A0* device_link_release_fn(). Hence, do it synchronously for the ov=
erlay
> > =C2=A0* case."
> >=20
> > I can elaborate more if you prefer...
>=20
> No, that should suffice IMV, thanks.
>=20
> Now that I think of it there is one more possibility: A dedicated
> workqueue can be used for running device_link_release_fn() and the DT
> overlay code can flush it after the device link deletion.

Hmm, I did some experiments with that but having a work item per kobject (b=
eing that
the common thing between of_node and device) but that (even though it worke=
d) ended
up being overly complicated.

I think I went with the above because, in theory, you can have DT waiting f=
or
unrelated releases but that should really be a corner a case. So, if you pr=
efer a
dedicated queue I can give that a try to see how it looks like. Thinking in
allocating a queue (maybe with the same flags as system_long_wq) in:

devlink_class_init()

Then we can have a new fwnode_link_flush_queue() helper to call from DT. Na=
ming it
like this as DT guys might also not like much of having device specific cal=
ls in
there (and fwnode_link) actually fits IMO).

Is it something like this that you have in mind?


Thanks for helping!
- Nuno S=C3=A1

