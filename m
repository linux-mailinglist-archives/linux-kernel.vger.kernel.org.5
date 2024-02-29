Return-Path: <linux-kernel+bounces-86442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574286C562
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0131F26359
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF15EE75;
	Thu, 29 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l23WjzDX"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811315E08F;
	Thu, 29 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199270; cv=none; b=R6xAiLRUYcDv+ZhHKKOPAvCMa/RBxHX+kMU2Ns6TFrGrBCddXo4Bbm2uLy6l8X6qralx/LU8W0Mu8kqevUAemlrJ7jY9tWmXR3LDaAi12NxcWAvYg/Uf3oZG5jYH96uy7EgK2oHIOqjnTQBa4swMj722hQk7/X5ksiBS13bsM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199270; c=relaxed/simple;
	bh=o8gbZwF10LCv9UWZMQ0ZGmjP9/uC4G8Yn5JLvt2eYes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPXtQRTct/tmBPvyZ9ITz0r7FldNWYF96/iiO1TuHs3fEvZCLQJYLPmnToI/NRWwAC2ssZvxAzf+OW/oRMRixZQXukm1qbXzxpIKv1KkFB4Z6UGL/aIMVOClQ3u5R8qMatm3go5tuSO4hY5bmaC2UM2J+azWYq6XoxHvITggp50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l23WjzDX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2823FFF808;
	Thu, 29 Feb 2024 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709199266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qox6e5cdQpNa2Zc8vUoW89TqqTDyKUlTFOGSqGcUjC0=;
	b=l23WjzDXviIyASupehXHYvHXbS4WV27yvlgOeb8EbWG5ydDjf7RXhVUY0ttR2BpjWU6xHH
	tBYZSJ/dtkVwwa5NRbgSlYYPNMzKNQVSeozpW+p5YTf2P34YFvt7zGoh6A7svEfFXUVuA+
	/w9tdjhFbm4HwHzEgIoSxBpEoUDd32JV1RhusGxr0Xo09eq7ShY+R5zp4g0D+QE0gboqt6
	F+0cmNoMzSNEcEWw0jbRSXFMZLdujc2zu87jUeI7f3UoGiXVRLgG6HIhxkrFEPlTiYtDMm
	Wvlk7PHZPIRAQk8wyCTYS8aAaGpnOy/uQuy5ozTI+hr+ziRvKoBTiAMmLet3dg==
Date: Thu, 29 Feb 2024 10:34:23 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Frank Rowand
 <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv?=
 =?UTF-8?Q?=C3=A9?= Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [REGRESSION] Re: [PATCH v2 2/3] of: property: Improve finding
 the supplier of a remote-endpoint property
Message-ID: <20240229103423.1244de38@booty>
In-Reply-To: <CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com>
References: <20240207011803.2637531-1-saravanak@google.com>
	<20240207011803.2637531-3-saravanak@google.com>
	<20240223171849.10f9901d@booty>
	<CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
	<20240226125226.705efef3@booty>
	<CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
	<CAGETcx_6UEpOJteQ0Gmfb=NgU+9MZumtmyLbn++C=uj7nOon=g@mail.gmail.com>
	<CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com>
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

Hi Rob, Saravana,

On Wed, 28 Feb 2024 18:26:36 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Feb 28, 2024 at 5:58=E2=80=AFPM Saravana Kannan <saravanak@google=
com> wrote:
> >
> > On Wed, Feb 28, 2024 at 1:56=E2=80=AFPM Rob Herring <robh+dt@kernel.org=
> wrote: =20
> > >
> > > On Mon, Feb 26, 2024 at 5:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@=
bootlin.com> wrote: =20
> > > >
> > > > Hello Saravana,
> > > >
> > > > On Fri, 23 Feb 2024 17:35:24 -0800
> > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > =20
> > > > > On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.ceres=
oli@bootlin.com> wrote: =20
> > > > > >
> > > > > > Hello Saravana,
> > > > > >
> > > > > > [+cc Herv=C3=A9 Codina]
> > > > > >
> > > > > > On Tue,  6 Feb 2024 17:18:01 -0800
> > > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > > > =20
> > > > > > > After commit 4a032827daa8 ("of: property: Simplify of_link_to=
_phandle()"),
> > > > > > > remote-endpoint properties created a fwnode link from the con=
sumer device
> > > > > > > to the supplier endpoint. This is a tiny bit inefficient (not=
 buggy) when
> > > > > > > trying to create device links or detecting cycles. So, improv=
e this the
> > > > > > > same way we improved finding the consumer of a remote-endpoin=
t property.
> > > > > > >
> > > > > > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phand=
le()")
> > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com> =20
> > > > > >
> > > > > > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> > > > > > getting unexpected warnings during device tree overlay removal.=
 After a
> > > > > > somewhat painful bisection I identified this patch as the one t=
hat
> > > > > > triggers it all. =20
> > > > >
> > > > > Thanks for the report.
> > > > > =20
> > > > > > =20
> > > > > > > ---
> > > > > > > --- a/drivers/of/property.c
> > > > > > > +++ b/drivers/of/property.c
> > > > > > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5=
", NULL)
> > > > > > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > > > > > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > > > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > > > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> > > > > > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > > > > > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > > > > > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > > > > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_inter=
rupts(struct device_node *np,
> > > > > > >       return of_irq_parse_one(np, index, &sup_args) ? NULL : =
sup_args.np;
> > > > > > >  }
> > > > > > >
> > > > > > > +static struct device_node *parse_remote_endpoint(struct devi=
ce_node *np,
> > > > > > > +                                              const char *pr=
op_name,
> > > > > > > +                                              int index)
> > > > > > > +{
> > > > > > > +     /* Return NULL for index > 0 to signify end of remote-e=
ndpoints. */
> > > > > > > +     if (!index || strcmp(prop_name, "remote-endpoint")) =20
> > > > > >
> > > > > > There seem to be a bug here: "!index" should be "index > 0", as=
 the
> > > > > > comment suggests. Otherwise NULL is always returned. =20
> > > > >
> > > > > Ah crap, I think you are right. It should have been "index". Not
> > > > > "!index". But I tested this! Sigh. I probably screwed up my testi=
ng.
> > > > >
> > > > > Please send out a Fix for this.
> > > > >
> > > > > Geert, we got excited too soon. :(
> > > > > =20
> > > > > > I am going to send a quick patch for that, but haven't done so =
yet
> > > > > > because it still won't solve the problem, so I wanted to open t=
he topic
> > > > > > here without further delay.
> > > > > >
> > > > > > Even with the 'index > 0' fix I'm still getting pretty much the=
 same: =20
> > > > >
> > > > > This part is confusing though. If I read your DT correctly, there=
's a
> > > > > cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_dev=
link
> > > > > should not be enforcing any ordering between those devices ever.
> > > > >
> > > > > I'm surprised that in your "working" case, fw_devlink didn't dete=
ct
> > > > > any cycle. It should have. If there's any debugging to do, that's=
 the
> > > > > one we need to debug.
> > > > > =20
> > > > > >
> > > > > > [   34.836781] ------------[ cut here ]------------
> > > > > > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.=
c:1064 devm_kfree+0x8c/0xfc
> > > > > > ...
> > > > > > [   35.024751] Call trace:
> > > > > > [   35.027199]  devm_kfree+0x8c/0xfc
> > > > > > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_km=
s_helper]
> > > > > > [   35.036990]  devres_release_group+0xe0/0x164
> > > > > > [   35.041264]  i2c_device_remove+0x38/0x9c
> > > > > > [   35.045196]  device_remove+0x4c/0x80
> > > > > > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > > > > > [   35.054003]  device_release_driver+0x18/0x24
> > > > > > [   35.058279]  bus_remove_device+0xcc/0x10c
> > > > > > [   35.062292]  device_del+0x15c/0x41c
> > > > > > [   35.065786]  device_unregister+0x18/0x34
> > > > > > [   35.069714]  i2c_unregister_device+0x54/0x88
> > > > > > [   35.073988]  of_i2c_notify+0x98/0x224
> > > > > > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > > > > > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > > > > > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > > > > > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > > > > > ...
> > > > > >
> > > > > > By comparing the two versions I found that before removing the =
overlay:
> > > > > >
> > > > > >  * in the "working" case (with this patch reverted) I have:
> > > > > >
> > > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > > >    platform:hpbr--i2c:13-002c
> > > > > >    platform:panel-dsi-lvds--i2c:13-002c =20
> > > > >
> > > > > Can you check the "status" and "sync_state_only" file in this fol=
der
> > > > > and tell me what it says?
> > > > >
> > > > > Since these devices have a cyclic dependency between them, it sho=
uld
> > > > > have been something other than "not tracked" and "sync_state_only"
> > > > > should be "1". But my guess is you'll see "active" and "0".
> > > > > =20
> > > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > > >    regulator:regulator.31--i2c:13-002c
> > > > > >    #
> > > > > >
> > > > > >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as ment=
ioned):
> > > > > >
> > > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > > >    platform:hpbr--i2c:13-002c
> > > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > > >    regulator:regulator.30--i2c:13-002c
> > > > > >    #
> > > > > >
> > > > > > So in the latter case the panel-dsi-lvds--i2c:13-002c link is m=
issing.
> > > > > > I think it gets created but later on removed. Here's a snippet =
of the
> > > > > > kernel log when that happens:
> > > > > >
> > > > > > [    9.578279] ----- cycle: start -----
> > > > > > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3=
/dsi-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30=
800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > [    9.578329] ----- cycle: end -----
> > > > > > [    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(=
s) with /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > ... =20
> > > > >
> > > > > Somewhere in this area, I'm thinking you'll also see "device:
> > > > > 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not? A=
nd if
> > > > > you enabled device link logs, you'll see that it was "sync state =
only"
> > > > > link.
> > > > > =20
> > > > > > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc=
@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > ...
> > > > > > [    9.597280] ----- cycle: start -----
> > > > > > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30=
800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3=
/dsi-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > > [    9.607581] ----- cycle: end -----
> > > > > > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /pan=
el-dsi-lvds
> > > > > > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': =
device_add
> > > > > > ...
> > > > > > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3=
/dsi-lvds-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > > > > > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3=
/dsi-lvds-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > > > > > ...
> > > > > > [    9.739840] panel-simple panel-dsi-lvds: Dropping the link t=
o 13-002c
> > > > > > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': =
device_unregister =20
> > > > >
> > > > > Oh yeah, see. The "device_add" I expected earlier is getting remo=
ved here.
> > > > > =20
> > > > > > [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-ds=
i-lvds
> > > > > > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': =
device_unregister
> > > > > >
> > > > > > And here's the relevant portion of my device tree overlay:
> > > > > >
> > > > > > --------------------8<--------------------
> > > > > > =20
> > > > >
> > > > > I think the eventual fix would be this series + adding a
> > > > > "post-init-providers" property to the device that's supposed to p=
robe
> > > > > first and point it to the device that's supposed to probe next. Do
> > > > > this at the device node level, not the endpoint level.
> > > > > https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak@g=
oogle.com/ =20
> > > >
> > > > I'm certainly going to look at this series in more detail and at the
> > > > debugging you asked for, however I'm afraid I won't have access to =
the
> > > > hardware this week and it's not going to be a quick task anyway.
> > > >
> > > > So in this moment I think it's quite clear that this specific patch
> > > > creates a regression and there is no clear fix that is reasonably
> > > > likely to get merged before 6.8.
> > > >
> > > > I propose reverting this patch immediately, unless you have a better
> > > > short-term solution. =20
> > >
> > > It's just this one of the 3 patches that needs reverting? =20

Just this patch. I reverted only this and the issue disappeared.

> > I sent a fix. With the fix, it's just exposing a bug elsewhere.=20

Exactly, this patch has two issues and only the easy one has a fix [0]
currently as far as I know.

> You say apply the fix. Luca says revert. I say I wish I made this 6.9
> material. Which is it?
>=20
> If the overlay applying depends on out of tree code (likely as there
> are limited ways to apply an overlay in mainline), then I don't really
> care if there is still a regression.

Obviously, to load and unload the overlays I'm using code not yet
in mainline. It is using of_overlay_fdt_apply() and of_overlay_remove()
via a driver underdevelopment that is similar to the one Herv=C3=A9 and
Lizhi Hou are working on [1][2].

I see the point that "we are not breaking existing use cases as no code
is (un)loading overlays except unittest", sure.

As I see it, we have a feature in the kernel that is not used, but it
will be, eventually: there are use cases, development is progressing and
patches are being sent actively. My opinion is that we should not
put additional known obstacles that will make it even harder than it
already is.

[0]
https://lore.kernel.org/linux-devicetree/20240224052436.3552333-1-saravanak=
@google.com/
[1]
https://lore.kernel.org/all/1692120000-46900-1-git-send-email-lizhi.hou@amd=
com/
[2]
https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.=
com/

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

