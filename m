Return-Path: <linux-kernel+bounces-83898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD86D869FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D751F2D4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3351009;
	Tue, 27 Feb 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbdqzm+6"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FB3D988;
	Tue, 27 Feb 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060890; cv=none; b=e+/1fQc0+smHrQfuFBJ2tBoPkWqPd8Tsa2FXM3Jp/WG5EmWMwxpVNFHGyE9Y2IEcripkoSi1Fl6ehXqxCUyJkGMznRR0T0nqX4XhJu19QiojVG2/nz/Ts8xP6oM6hSLGwTOYG/i6vsZHC7N2SyEFScsSq+iEraYmBdaCgg5wkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060890; c=relaxed/simple;
	bh=TQh6LW1PVOfcw8bXd7iNWDVNACOkDhRazrivKvtV6eA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKG8tTKyKlcD9hnvjuUSXu8WsJQayfvgGAhHwE1e0VnJ/W4aJUzOGJCxagOSRsfj3orOi2ADLmmeoPe4qhdcU5YzzFKklyQoqg5Lz9RLbMf1clTaWrpSuubJkUi+TXDhbDaMltfsQZEHU2p+QkeL3y/PkLcLJXV5FFAr5wv7VsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbdqzm+6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso5708672e87.3;
        Tue, 27 Feb 2024 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060886; x=1709665686; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TQh6LW1PVOfcw8bXd7iNWDVNACOkDhRazrivKvtV6eA=;
        b=nbdqzm+6f5Yh6AqPrSaiPUUvBH5DrDlZAbyxgUZHMTPe+as0221GC+Fg0nIOB//iE/
         4BmiQ9YjEljFkXUzMqKh5zVmqIXVMYZEhBdbReY9LfpayhUTjS4mQOKOKTwErYmGCKGy
         RtC9+A6MaNqn4H1m3dPjQGlZFI6D6Bkg5L9AMdNnRt412XfUpHQmVm38XKKcSqdJ2P1i
         JCut8i29dy8XbiFaxhvpQIg2ZUOfadHKezJRZl/SlvanJr3Vk9Swnls886HDljW2osbn
         jMaUpP43x2VsHdO3hNghP+TRo+gAtmWZPxn3q6EEZEyMw9mAdnVAbTI31GG6RAiMhVrI
         v5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060886; x=1709665686;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQh6LW1PVOfcw8bXd7iNWDVNACOkDhRazrivKvtV6eA=;
        b=wc//2WMa8LhrExDNGShZwxnpGlLrhYqN4/tqEM9BMhpIkjDq9JsKZtR+TIfcbBOl/p
         FHAYtQTzPRDE2iGBhbBCAzv0ch6vfUKfEP8KJWcxlpOy0htccYWJZUEB4JkXNa9qvX4h
         hqLxuic9q1u74owZClXlA9GcAUCJIuZeinHfvrPHvUX2seRpqEVdvc4IVC9XEUyVpcc/
         M3leyIpvkLsF4yYoTvzLTC3SvywI1/lU4S/jEr90Cudofgh7B+pQDjp3m/HNqPwmoEBU
         J2vpaoV6hmVwnz28JYLfHkrphqd9gsZuRpMewq5yOEoyCwrE5wDmErVuZg6+NifQuxuA
         PWzw==
X-Forwarded-Encrypted: i=1; AJvYcCWCROvPBvBp4FPPQ5w0of0+TXkPZlr3N/8AgVlG61m8r3WZz0dom+qYcBRPhpYbli+0V5MzcYSf5J2HLYAf/zEOkEoYtWpTRMb9qTb29ICPeAdYy6EKzM6YIa2ogkN3cPRNyUStUC8qOQ==
X-Gm-Message-State: AOJu0Yw9zm3ub4VcpkBTR1y74gfZVM+4eRqD4CiU4cXB2jAVY5KCD82+
	Cbj4qgrNvwsjbOICCQmIBJvBLJa0PNnFxiRYswVy3VaufWTgscx6
X-Google-Smtp-Source: AGHT+IF9Eb7aJCmvFjgVa4JvyKENTpBU9O4sSWo5TWq/zGN5Tl8NmF0e39RI98BdQUS/fX0zy9Qpag==
X-Received: by 2002:a05:6512:3996:b0:513:13ef:187 with SMTP id j22-20020a056512399600b0051313ef0187mr1336647lfu.51.1709060886143;
        Tue, 27 Feb 2024 11:08:06 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id m18-20020a50d7d2000000b00564e4debe29sm1081306edj.78.2024.02.27.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:08:05 -0800 (PST)
Message-ID: <9ae28df7a4770bf94358dac36fd5e0942877f147.camel@gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Nuno Sa <nuno.sa@analog.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,  Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Tue, 27 Feb 2024 20:07:59 +0100
In-Reply-To: <20240227185402.57a3b924@bootlin.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-3-herve.codina@bootlin.com>
	 <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
	 <20240227162422.76a00f11@bootlin.com>
	 <86f2262d059db84070745e299d96dde3e6078220.camel@gmail.com>
	 <20240227185402.57a3b924@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,

On Tue, 2024-02-27 at 18:54 +0100, Herve Codina wrote:
> Hi Nuno,
>=20
> On Tue, 27 Feb 2024 17:55:07 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2024-02-27 at 16:24 +0100, Herve Codina wrote:
> > > Hi Saravana, Luca, Nuno,
> > >=20
> > > On Tue, 20 Feb 2024 16:37:05 -0800
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >=20
> > > ...
> > > =C2=A0=20
> > > > >=20
> > > > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > > > index a9a292d6d59b..5c5f808b163e 100644
> > > > > --- a/drivers/of/overlay.c
> > > > > +++ b/drivers/of/overlay.c
> > > > > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Wait for any ongoin=
g device link removals before removing some
> > > > > of
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nodes
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal();
> > > > > +=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Nuno in his patch[1] had this "wait" happen inside
> > > > __of_changeset_entry_destroy(). Which seems to be necessary to not =
hit
> > > > the issue that Luca reported[2] in this patch series. Is there any
> > > > problem with doing that?
> > > >=20
> > > > Luca for some reason did a unlock/lock(of_mutex) in his test patch =
and
> > > > I don't think that's necessary.=C2=A0=20
> > >=20
> > > I think the unlock/lock in Luca's case and so in Nuno's case is neede=
d.
> > >=20
> > > I do the device_link_wait_removal() wihout having the of_mutex locked=
.
> > >=20
> > > Now, suppose I do the device_link_wait_removal() call with the of_mut=
ex locked.
> > > The following flow is allowed and a deadlock is present.
> > >=20
> > > of_overlay_remove()
> > > =C2=A0 lock(of_mutex)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal()
> > >=20
> > > And, from the workqueue jobs execution:
> > > =C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0 device_put()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 some_driver->remove()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_overlay_remove() <--- T=
he job will never end.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is waiting for of_mutex=
.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Deadlock
> > > =C2=A0=20
> >=20
> > We may need some input from Saravana (and others) on this. I might be m=
issing
> > something but can a put_device() lead into a driver remove callback? Dr=
iver code
> > is
> > not device code and put_device() leads to device_release() which will e=
ither call
> > the
> > device=C2=A0->release(), ->type->release() or the class ->dev_release()=
 And, IMO,
> > calling
> > of_overlay_remove() or something like that (like something that would l=
ead to
> > unbinding a device from it's driver) in a device release callback would=
 be at the
> > very least very questionable. Typically, what you see in there is of_no=
de_put()
> > and
> > things like kfree() of the device itself or any other data.
>=20
> I think that calling of_overlay_remove() in a device release callback mak=
es
> sense. The overlay is used to declare sub-nodes from the device node. It
> does not add/remove the device node itself but sub-nodes.
>=20

I think we are speaking about two different things... device release is not=
 the same
as the driver remove callback. I admit the pci case seems to be a beast of =
it's own
and I just spent some time (given your links) on it so I can't surely be su=
re about
what I'm about to say... But, AFAICT, I did not saw any overlay or changese=
t being
removed from a kobj_type release callback.

> The use case is the use of DT overlays to describe PCI devices.
> https://lore.kernel.org/all/1692120000-46900-1-git-send-email-lizhi.hou@a=
md.com/
> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootli=
n.com/
> --- 8< ---
> The lan966x SoCs can be used in two different ways:
>=20
> =C2=A0- It can run Linux by itself, on ARM64 cores included in the SoC. T=
his
> =C2=A0=C2=A0 use-case of the lan966x is currently being upstreamed, using=
 a
> =C2=A0=C2=A0 traditional Device Tree representation of the lan996x HW blo=
cks [1]
> =C2=A0=C2=A0 A number of drivers for the different IPs of the SoC have al=
ready
> =C2=A0=C2=A0 been merged in upstream Linux.
>=20
> =C2=A0- It can be used as a PCIe endpoint, connected to a separate platfo=
rm
> =C2=A0=C2=A0 that acts as the PCIe root complex. In this case, all the de=
vices
> =C2=A0=C2=A0 that are embedded on this SoC are exposed through PCIe BARs =
and the
> =C2=A0=C2=A0 ARM64 cores of the SoC are not used. Since this is a PCIe ca=
rd, it
> =C2=A0=C2=A0 can be plugged on any platform, of any architecture supporti=
ng PCIe.
> --- 8< ---
>=20
> This quite long story led to DT overlay support for PCI devices and so th=
e
> unittest I mentioned:
> =C2=A0 https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/of/unitte=
st.c#L3946
>=20
>=20
> So, I have a PCI driver that bind to the lan966x PCI board.
> This driver loads an overlay at probe() and unload it at remove().
> Also, this driver can be module. A simple rmmod leads to the remove() cal=
l.
>=20

Hmm, and I think that would not be an issue... Note that the code that runs=
 in
device_link_release_fn() is doing put_device() which ends ups on the kobj_t=
ype
release callback and so far I could not see any evidence of such a callback=
 being
responsible of calling device_remove() on another device. That would be wei=
rd (I
think) since I would expect such a call to happen in a kind of unregister f=
unction.

> This driver is not yet upstream because I haven't yet fixed all the issue=
s I
> encountered that's why of now, I can point only the unittest related to o=
verlay
> support for PCI.
>=20
> >=20
> > The driver remove callback should be called when unbinding the device f=
rom it's
> > drivers and devlinks should also be removed after device_unbind_cleanup=
() (i.e,
> > after
> > the driver remove callback).
> >=20
> > Having said the above, the driver core has lots of subtleties so, again=
, I can be
> > missing something. But at this point I'm still not seeing any deadlock.=
.
> >=20
>=20
> I gave a wrong example.
> Based on Luca's sequence he gave in
> =C2=A0 https://lore.kernel.org/all/20231220181627.341e8789@booty/

Regarding Luca's comments, my first approach was actually to just make the =
devlink
removal synchronously... I'm still not sure what would be the issue of doin=
g that
(other than potentially waiting some time for the srcu synchronization). Ab=
out the
unlock, I'm just not sure what could happen if someone else (other than us)=
 sneaks in
and grabs the of_mutex while we are in the middle of removing an overlay...

>=20
> We can have the following:=20
>=20
> --- 8< ---
> int of_overlay_remove(int *ovcs_id)
> {
> =C2=A0=C2=A0=C2=A0 ...
>=20
> =C2=A0=C2=A0=C2=A0 device_link_wait_removal(); // proposed by this patch =
series
>=20
> =C2=A0=C2=A0=C2=A0 mutex_lock(&of_mutex);
>=20
> =C2=A0=C2=A0=C2=A0 ...
>=20
> =C2=A0=C2=A0=C2=A0 ret =3D __of_changeset_revert_notify(&ovcs->cset);
> =C2=A0=C2=A0=C2=A0 // this ends up calling (excerpt from a long stack tra=
ce):
> =C2=A0=C2=A0=C2=A0 // -> of_i2c_notify
> =C2=A0=C2=A0=C2=A0 // -> device_remove
> =C2=A0=C2=A0=C2=A0 // -> devm_regulator_release
> =C2=A0=C2=A0=C2=A0 // -> device_link_remove
> =C2=A0=C2=A0=C2=A0 // -> devlink_dev_release, which queues work for
> =C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_release_f=
n, which in turn calls:
> =C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> device_put
> =C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> device_release
> =C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> {platform,regulato=
r,...}_dev*_release
> =C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> of_node_put() [**]
>=20
> =C2=A0=C2=A0=C2=A0 ...
>=20
> =C2=A0=C2=A0=C2=A0 free_overlay_changeset(ovcs);
> =C2=A0=C2=A0=C2=A0 // calls:
> =C2=A0=C2=A0=C2=A0 // -> of_changeset_destroy
> =C2=A0=C2=A0=C2=A0 // -> __of_changeset_entry_destroy
> =C2=A0=C2=A0=C2=A0 // -> pr_err("ERROR: memory leak, expected refcount 1 =
instead of %d...
> =C2=A0=C2=A0=C2=A0 // The error appears or not, based on when the workque=
ue runs
>=20
> err_unlock:
> =C2=A0=C2=A0=C2=A0 mutex_unlock(&of_mutex);
>=20
> =C2=A0=C2=A0=C2=A0 ...
> }
> --- 8< ---
>=20
> I think, on your side, you can have something similar.
> I was wrong (sorry for my mistake). the problem is not device_put() but
> device_remove().

But I'm not seeing how device_remove() can deadlock since I'm not sure we c=
an go from
device_link_release_fn() to device_remove(). If there's such a path, then I=
'll agree
on the deadlock.

>=20
> In my deadlog example, s/device_put()/device_remove()/
>=20

Exactly... and that is why my first question was to wonder about put_device=
() being
able to call any overlay removal code. So, do you know if it's really possi=
ble for a
device release callback to end up calling device_remove()? Because, then I =
could see
the deadlock as device_remove() can end up unbinding the device from it's d=
river and
hence calling drv->remove().

- Nuno S=C3=A1

