Return-Path: <linux-kernel+bounces-81312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5379B8673EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EFF1F2C50A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2D1F61F;
	Mon, 26 Feb 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A+u0mnu4"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C41CD3A;
	Mon, 26 Feb 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948353; cv=none; b=EWeyrtjnNCtly6Qo9Vqijb7coPmAFQn+QxWOMbPe3tbw0aOfTB9aflAXIM4jtMQV1fqoYBSKW+pLxjQBmI103/x/FwhXISGdiutPnRati3ftdgaMUxzOmTfkS3Au9nlxuv+ZFXa/1RbKz9SPPxM06hoLCNUtKyxMpA5W/OvIJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948353; c=relaxed/simple;
	bh=SdC1KQdlMCko1CJPSb6LDZuTc7jNEB9pAVG9bFAnLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSrWYMNQ6Ybk94HAYsd/jjCCu+3Te/vvYIMHGeZ94//30eiXpQsCaINhZP+I/k+JNU+TUTWnj2ryYnOfjAqVb5PW8yU5CdlBm4Vj+zcXqrLqcP39qe7YBB0cNTwQU3xMxWAztgMZr4OaynoBPAfkEtB0lED+hmAMmY+H+hNInfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A+u0mnu4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C3D36000A;
	Mon, 26 Feb 2024 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708948348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcNE+jdsAyRYMoNdZEeccnDlbU/TpwbrSKPOoM6fQEo=;
	b=A+u0mnu4gXMONKa8Fq7OR2dsNjAvdyKCE0wh+7jhjVr2Qc5RDPBPIwgwLhCpNLCSF0pnin
	WhigwZnL1x3vsQxIK6WU3QPd8QdoP0LGe05q1UQTPHzGyg73TXVOLRfynMMDc/PRP4zvR/
	/9UP7IHiKeknFFJ+ZPPhzanTUrXjz0BVmOADjYEioVDDgWOMGQ8cwhD/ZL9OO7+JqML58s
	t//16CsA4w9bxn5QgwfaidOqN/D2JHjm7E77DcCf8So5SOYPBh4YMscSLJn4lxcMEgyTpX
	yxpbnija6WNPiClbgKRnuy/7YMRc7Y8WOwnaoOlEymO2txrn7djtk8P9BxvJZQ==
Date: Mon, 26 Feb 2024 12:52:26 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [REGRESSION] Re: [PATCH v2 2/3] of: property: Improve finding the
 supplier of a remote-endpoint property
Message-ID: <20240226125226.705efef3@booty>
In-Reply-To: <CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
References: <20240207011803.2637531-1-saravanak@google.com>
	<20240207011803.2637531-3-saravanak@google.com>
	<20240223171849.10f9901d@booty>
	<CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Saravana,

On Fri, 23 Feb 2024 17:35:24 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> >
> > Hello Saravana,
> >
> > [+cc Herv=C3=A9 Codina]
> >
> > On Tue,  6 Feb 2024 17:18:01 -0800
> > Saravana Kannan <saravanak@google.com> wrote:
> > =20
> > > After commit 4a032827daa8 ("of: property: Simplify of_link_to_phandle=
()"),
> > > remote-endpoint properties created a fwnode link from the consumer de=
vice
> > > to the supplier endpoint. This is a tiny bit inefficient (not buggy) =
when
> > > trying to create device links or detecting cycles. So, improve this t=
he
> > > same way we improved finding the consumer of a remote-endpoint proper=
ty.
> > >
> > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> > > Signed-off-by: Saravana Kannan <saravanak@google.com> =20
> >
> > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> > getting unexpected warnings during device tree overlay removal. After a
> > somewhat painful bisection I identified this patch as the one that
> > triggers it all. =20
>=20
> Thanks for the report.
>=20
> > =20
> > > ---
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
> > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_interrupts(st=
ruct device_node *np,
> > >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args=
np;
> > >  }
> > >
> > > +static struct device_node *parse_remote_endpoint(struct device_node =
*np,
> > > +                                              const char *prop_name,
> > > +                                              int index)
> > > +{
> > > +     /* Return NULL for index > 0 to signify end of remote-endpoints=
 */
> > > +     if (!index || strcmp(prop_name, "remote-endpoint")) =20
> >
> > There seem to be a bug here: "!index" should be "index > 0", as the
> > comment suggests. Otherwise NULL is always returned. =20
>=20
> Ah crap, I think you are right. It should have been "index". Not
> "!index". But I tested this! Sigh. I probably screwed up my testing.
>=20
> Please send out a Fix for this.
>=20
> Geert, we got excited too soon. :(
>=20
> > I am going to send a quick patch for that, but haven't done so yet
> > because it still won't solve the problem, so I wanted to open the topic
> > here without further delay.
> >
> > Even with the 'index > 0' fix I'm still getting pretty much the same: =
=20
>=20
> This part is confusing though. If I read your DT correctly, there's a
> cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_devlink
> should not be enforcing any ordering between those devices ever.
>=20
> I'm surprised that in your "working" case, fw_devlink didn't detect
> any cycle. It should have. If there's any debugging to do, that's the
> one we need to debug.
>=20
> >
> > [   34.836781] ------------[ cut here ]------------
> > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.c:1064 d=
evm_kfree+0x8c/0xfc
> > ...
> > [   35.024751] Call trace:
> > [   35.027199]  devm_kfree+0x8c/0xfc
> > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_kms_helper]
> > [   35.036990]  devres_release_group+0xe0/0x164
> > [   35.041264]  i2c_device_remove+0x38/0x9c
> > [   35.045196]  device_remove+0x4c/0x80
> > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > [   35.054003]  device_release_driver+0x18/0x24
> > [   35.058279]  bus_remove_device+0xcc/0x10c
> > [   35.062292]  device_del+0x15c/0x41c
> > [   35.065786]  device_unregister+0x18/0x34
> > [   35.069714]  i2c_unregister_device+0x54/0x88
> > [   35.073988]  of_i2c_notify+0x98/0x224
> > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > ...
> >
> > By comparing the two versions I found that before removing the overlay:
> >
> >  * in the "working" case (with this patch reverted) I have:
> >
> >    # ls /sys/class/devlink/ | grep 002c
> >    platform:hpbr--i2c:13-002c
> >    platform:panel-dsi-lvds--i2c:13-002c =20
>=20
> Can you check the "status" and "sync_state_only" file in this folder
> and tell me what it says?
>=20
> Since these devices have a cyclic dependency between them, it should
> have been something other than "not tracked" and "sync_state_only"
> should be "1". But my guess is you'll see "active" and "0".
>=20
> >    platform:regulator-sys-1v8--i2c:13-002c
> >    regulator:regulator.31--i2c:13-002c
> >    #
> >
> >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as mentioned):
> >
> >    # ls /sys/class/devlink/ | grep 002c
> >    platform:hpbr--i2c:13-002c
> >    platform:regulator-sys-1v8--i2c:13-002c
> >    regulator:regulator.30--i2c:13-002c
> >    #
> >
> > So in the latter case the panel-dsi-lvds--i2c:13-002c link is missing.
> > I think it gets created but later on removed. Here's a snippet of the
> > kernel log when that happens:
> >
> > [    9.578279] ----- cycle: start -----
> > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvd=
s-bridge@2c: cycle: depends on /panel-dsi-lvds
> > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000/i=
2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > [    9.578329] ----- cycle: end -----
> > [    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(s) with =
/soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > ... =20
>=20
> Somewhere in this area, I'm thinking you'll also see "device:
> 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not? And if
> you enabled device link logs, you'll see that it was "sync state only"
> link.
>=20
> > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc@0/bus@3=
0800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > ...
> > [    9.597280] ----- cycle: start -----
> > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000/i=
2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvd=
s-bridge@2c: cycle: depends on /panel-dsi-lvds
> > [    9.607581] ----- cycle: end -----
> > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /panel-dsi-l=
vds
> > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': device_a=
dd
> > ...
> > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvd=
s-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvd=
s-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > ...
> > [    9.739840] panel-simple panel-dsi-lvds: Dropping the link to 13-002c
> > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': device_u=
nregister =20
>=20
> Oh yeah, see. The "device_add" I expected earlier is getting removed here.
>=20
> > [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-dsi-lvds
> > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': device_u=
nregister
> >
> > And here's the relevant portion of my device tree overlay:
> >
> > --------------------8<--------------------
> > =20
>=20
> I think the eventual fix would be this series + adding a
> "post-init-providers" property to the device that's supposed to probe
> first and point it to the device that's supposed to probe next. Do
> this at the device node level, not the endpoint level.
> https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak@google.co=
m/

I'm certainly going to look at this series in more detail and at the
debugging you asked for, however I'm afraid I won't have access to the
hardware this week and it's not going to be a quick task anyway.

So in this moment I think it's quite clear that this specific patch
creates a regression and there is no clear fix that is reasonably
likely to get merged before 6.8.

I propose reverting this patch immediately, unless you have a better
short-term solution.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

