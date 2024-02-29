Return-Path: <linux-kernel+bounces-85920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311D86BCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E2BB24A12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340E23A2;
	Thu, 29 Feb 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvYrFwR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7BA28;
	Thu, 29 Feb 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166411; cv=none; b=EPIF8XVMwPQ9t6Azbp7DTrSXTE4xaSF/96/Co9Tvri5gPJ2SIIVGabf4RGKR7GyUBDPKBMVbswr4heUdVq82vgz3fbORvepK7hPmFCAFPvQ1PjXzd5t3Fl7pIVjF9lD6axQdjnAT3omlvlkiAxaabmjVkWVsOAtrOSjSwXSyLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166411; c=relaxed/simple;
	bh=FE5fXkTTamf2L/tsv454ghZMPutfU9Yu/yTk983qt4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgrIoQe7A25ZPHOuvCI7TYAF5Ml6hGV36iUMII6mjsrNfjjbdjwAdKpJWXG+U66h6N3ZdEgURf1N0zMdCuJjIvYVp4879nimtkJ0WHkRzP6cqAtegZChPxPVgBPMjy6vYI5bZfkevGX/2DVQw88Sc9lf9dRSoGGKi39wNvai0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvYrFwR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C8C433F1;
	Thu, 29 Feb 2024 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709166410;
	bh=FE5fXkTTamf2L/tsv454ghZMPutfU9Yu/yTk983qt4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LvYrFwR73x2BG2X/6Bui4IV1/pjES5co1D+7woVLFUshy2Q11QpTPafmKwAb5yL7b
	 kmr7MGv/O0ouYLe0jDmU9ULfiY3nrOvnuvxkXHuOTXeHc6+CTdyMfGsIedbmAE0qYt
	 aB/5iz4VXu8VTIxlsdZO6WVH7eAhaeDGsXNuaVB8RXF46t+R1ThxxI52R1jmKbAvdL
	 h301FMetMkPoLEE4uxAPs7RVLZUvoEX1FTiTNBNYEl7oEe+PVdp1zjcDGCzRk0SD6q
	 Dgp2PbdR5oWWeLHB1czQnst+eTI0fOgSusTnv4kXvjeuEoIZyx+JfqJes2t6bdzlkM
	 o4i3dALIDWLIg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bd533be0so271886e87.0;
        Wed, 28 Feb 2024 16:26:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeHSjTmrJfefMmVIBEcpgTOceD00+MJanRBIubXm/uPiTrFrHQUYSOIcIIiKRnGZC0YfedYPE1bIwekZgyGCm6pC8EuTuH5mmwhApPqxMdfzJnsvemyIjeAxPI6UgNUa6pE+fvu13lbQ==
X-Gm-Message-State: AOJu0Yx/R8YiL2scf6vXEmGladiSiMTuUJo/kGUMrOd5uSjIRAS9Zxt0
	eewfnQxPGGkpHuouUyRH5RY4WAtTR1oKD/oYz76gqkE52Lozl6ceiAnQCiGJqiMbaQnKMpMnldK
	hveNvgGVDA8Ey5v5eZeP68u69wg==
X-Google-Smtp-Source: AGHT+IEEcV4dOi5OMBCOxmM9QFSOSs3rJhNN/d3mlyipoRep5l3UcxOkEoMJVNBJeY5uTVdeK8a1j5V+LUCY6pM7Cqs=
X-Received: by 2002:a05:6512:3c90:b0:512:cef7:4754 with SMTP id
 h16-20020a0565123c9000b00512cef74754mr441672lfv.5.1709166408628; Wed, 28 Feb
 2024 16:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-3-saravanak@google.com> <20240223171849.10f9901d@booty>
 <CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
 <20240226125226.705efef3@booty> <CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
 <CAGETcx_6UEpOJteQ0Gmfb=NgU+9MZumtmyLbn++C=uj7nOon=g@mail.gmail.com>
In-Reply-To: <CAGETcx_6UEpOJteQ0Gmfb=NgU+9MZumtmyLbn++C=uj7nOon=g@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Feb 2024 18:26:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com>
Message-ID: <CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 2/3] of: property: Improve finding the
 supplier of a remote-endpoint property
To: Saravana Kannan <saravanak@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:58=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Wed, Feb 28, 2024 at 1:56=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:
> >
> > On Mon, Feb 26, 2024 at 5:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bo=
otlin.com> wrote:
> > >
> > > Hello Saravana,
> > >
> > > On Fri, 23 Feb 2024 17:35:24 -0800
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > > On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.ceresol=
i@bootlin.com> wrote:
> > > > >
> > > > > Hello Saravana,
> > > > >
> > > > > [+cc Herv=C3=A9 Codina]
> > > > >
> > > > > On Tue,  6 Feb 2024 17:18:01 -0800
> > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > > After commit 4a032827daa8 ("of: property: Simplify of_link_to_p=
handle()"),
> > > > > > remote-endpoint properties created a fwnode link from the consu=
mer device
> > > > > > to the supplier endpoint. This is a tiny bit inefficient (not b=
uggy) when
> > > > > > trying to create device links or detecting cycles. So, improve =
this the
> > > > > > same way we improved finding the consumer of a remote-endpoint =
property.
> > > > > >
> > > > > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle=
()")
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > >
> > > > > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> > > > > getting unexpected warnings during device tree overlay removal. A=
fter a
> > > > > somewhat painful bisection I identified this patch as the one tha=
t
> > > > > triggers it all.
> > > >
> > > > Thanks for the report.
> > > >
> > > > >
> > > > > > ---
> > > > > > --- a/drivers/of/property.c
> > > > > > +++ b/drivers/of/property.c
> > > > > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5",=
 NULL)
> > > > > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > > > > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> > > > > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > > > > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > > > > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > > > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_interru=
pts(struct device_node *np,
> > > > > >       return of_irq_parse_one(np, index, &sup_args) ? NULL : su=
p_args.np;
> > > > > >  }
> > > > > >
> > > > > > +static struct device_node *parse_remote_endpoint(struct device=
_node *np,
> > > > > > +                                              const char *prop=
_name,
> > > > > > +                                              int index)
> > > > > > +{
> > > > > > +     /* Return NULL for index > 0 to signify end of remote-end=
points. */
> > > > > > +     if (!index || strcmp(prop_name, "remote-endpoint"))
> > > > >
> > > > > There seem to be a bug here: "!index" should be "index > 0", as t=
he
> > > > > comment suggests. Otherwise NULL is always returned.
> > > >
> > > > Ah crap, I think you are right. It should have been "index". Not
> > > > "!index". But I tested this! Sigh. I probably screwed up my testing=
.
> > > >
> > > > Please send out a Fix for this.
> > > >
> > > > Geert, we got excited too soon. :(
> > > >
> > > > > I am going to send a quick patch for that, but haven't done so ye=
t
> > > > > because it still won't solve the problem, so I wanted to open the=
 topic
> > > > > here without further delay.
> > > > >
> > > > > Even with the 'index > 0' fix I'm still getting pretty much the s=
ame:
> > > >
> > > > This part is confusing though. If I read your DT correctly, there's=
 a
> > > > cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_devli=
nk
> > > > should not be enforcing any ordering between those devices ever.
> > > >
> > > > I'm surprised that in your "working" case, fw_devlink didn't detect
> > > > any cycle. It should have. If there's any debugging to do, that's t=
he
> > > > one we need to debug.
> > > >
> > > > >
> > > > > [   34.836781] ------------[ cut here ]------------
> > > > > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.c:=
1064 devm_kfree+0x8c/0xfc
> > > > > ...
> > > > > [   35.024751] Call trace:
> > > > > [   35.027199]  devm_kfree+0x8c/0xfc
> > > > > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_kms_=
helper]
> > > > > [   35.036990]  devres_release_group+0xe0/0x164
> > > > > [   35.041264]  i2c_device_remove+0x38/0x9c
> > > > > [   35.045196]  device_remove+0x4c/0x80
> > > > > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > > > > [   35.054003]  device_release_driver+0x18/0x24
> > > > > [   35.058279]  bus_remove_device+0xcc/0x10c
> > > > > [   35.062292]  device_del+0x15c/0x41c
> > > > > [   35.065786]  device_unregister+0x18/0x34
> > > > > [   35.069714]  i2c_unregister_device+0x54/0x88
> > > > > [   35.073988]  of_i2c_notify+0x98/0x224
> > > > > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > > > > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > > > > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > > > > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > > > > ...
> > > > >
> > > > > By comparing the two versions I found that before removing the ov=
erlay:
> > > > >
> > > > >  * in the "working" case (with this patch reverted) I have:
> > > > >
> > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > >    platform:hpbr--i2c:13-002c
> > > > >    platform:panel-dsi-lvds--i2c:13-002c
> > > >
> > > > Can you check the "status" and "sync_state_only" file in this folde=
r
> > > > and tell me what it says?
> > > >
> > > > Since these devices have a cyclic dependency between them, it shoul=
d
> > > > have been something other than "not tracked" and "sync_state_only"
> > > > should be "1". But my guess is you'll see "active" and "0".
> > > >
> > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > >    regulator:regulator.31--i2c:13-002c
> > > > >    #
> > > > >
> > > > >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as mentio=
ned):
> > > > >
> > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > >    platform:hpbr--i2c:13-002c
> > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > >    regulator:regulator.30--i2c:13-002c
> > > > >    #
> > > > >
> > > > > So in the latter case the panel-dsi-lvds--i2c:13-002c link is mis=
sing.
> > > > > I think it gets created but later on removed. Here's a snippet of=
 the
> > > > > kernel log when that happens:
> > > > >
> > > > > [    9.578279] ----- cycle: start -----
> > > > > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/d=
si-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@3080=
0000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > [    9.578329] ----- cycle: end -----
> > > > > [    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(s)=
 with /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > ...
> > > >
> > > > Somewhere in this area, I'm thinking you'll also see "device:
> > > > 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not? And=
 if
> > > > you enabled device link logs, you'll see that it was "sync state on=
ly"
> > > > link.
> > > >
> > > > > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc@0=
/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > ...
> > > > > [    9.597280] ----- cycle: start -----
> > > > > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@3080=
0000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/d=
si-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > [    9.607581] ----- cycle: end -----
> > > > > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /panel=
-dsi-lvds
> > > > > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': de=
vice_add
> > > > > ...
> > > > > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/d=
si-lvds-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > > > > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/d=
si-lvds-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > > > > ...
> > > > > [    9.739840] panel-simple panel-dsi-lvds: Dropping the link to =
13-002c
> > > > > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': de=
vice_unregister
> > > >
> > > > Oh yeah, see. The "device_add" I expected earlier is getting remove=
d here.
> > > >
> > > > > [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-dsi-=
lvds
> > > > > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': de=
vice_unregister
> > > > >
> > > > > And here's the relevant portion of my device tree overlay:
> > > > >
> > > > > --------------------8<--------------------
> > > > >
> > > >
> > > > I think the eventual fix would be this series + adding a
> > > > "post-init-providers" property to the device that's supposed to pro=
be
> > > > first and point it to the device that's supposed to probe next. Do
> > > > this at the device node level, not the endpoint level.
> > > > https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak@goo=
gle.com/
> > >
> > > I'm certainly going to look at this series in more detail and at the
> > > debugging you asked for, however I'm afraid I won't have access to th=
e
> > > hardware this week and it's not going to be a quick task anyway.
> > >
> > > So in this moment I think it's quite clear that this specific patch
> > > creates a regression and there is no clear fix that is reasonably
> > > likely to get merged before 6.8.
> > >
> > > I propose reverting this patch immediately, unless you have a better
> > > short-term solution.
> >
> > It's just this one of the 3 patches that needs reverting?
>
> I sent a fix. With the fix, it's just exposing a bug elsewhere.

That's not telling me what to do...

You say apply the fix. Luca says revert. I say I wish I made this 6.9
material. Which is it?

If the overlay applying depends on out of tree code (likely as there
are limited ways to apply an overlay in mainline), then I don't really
care if there is still a regression.

Rob

