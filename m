Return-Path: <linux-kernel+bounces-87623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C786D69F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B11C22E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6674BEA;
	Thu, 29 Feb 2024 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA/8hugE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC686D53B;
	Thu, 29 Feb 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244654; cv=none; b=LYSyBxB+F7Qjq9T8uX99jaqeDTO4GaIGrp7iolhKbfoXLrmoijR2c4AsPt02VUc8vVi8QURkq0rrnXeWOGlPlMWdFjuPcC1xUEk88UadKVbrKZy15EMGWuhgdsH5TUbynRQMNH50fdlnZXTxIze3MsiONPs73RTN0rSfpubaMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244654; c=relaxed/simple;
	bh=46vq4PfRdp/Bc+EgaGt6gpSe4x73R8hDgW+FEMQ4OFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhyeHAxcQNsX0ZmSycwpyTxEaep2vL2b5Bo21kF3+WQzK5uMgkXFtUSF/fGH4KGk5flj/Sqgjl44031dNT7QmRs9dhWqx7u0I9NWk2qUQvRKcSS1mTI5uuRQXQXLHIuML0TF7XIpDqwSmF3uRjAqFfT5pbyJMW8ld5GTkupYEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA/8hugE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678CFC43399;
	Thu, 29 Feb 2024 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244653;
	bh=46vq4PfRdp/Bc+EgaGt6gpSe4x73R8hDgW+FEMQ4OFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eA/8hugEapqWNQc65cvSh02csIkBEqemHkqUz6TSH7rP1+1koagmHsXE5p84tFKpP
	 slzvcIaBg34+2fa22gnbAaF7/yQ1HxkncHIzydASDodkQwZy8x0Qnfxl0oYRQU/WOk
	 YMCj7P8cqWGbiibAnEvYHLzvbR0w7lc5IgfAXcOjAbKgE4gPEcAe9bupNY+JG70vii
	 mo/UiMtD14wU+y+4QOofAlfHQMIK3jEKLIlq2nepKwP2QaqHTTSnshkfaqWccXvGhx
	 jwwqKXln3gEXSpb28BFOc5baVqdIgZGqrpJEBLR93GhXO6xkJ5916N4f3vEe+65yGm
	 S4yQ4h1cFRW1A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d1094b5568so15415631fa.1;
        Thu, 29 Feb 2024 14:10:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9scECUKE1iaZHrI+49YcNmIb1z2iGqdPo3xfFzTDmAbTNii8Z9zV0poUlnizQ3h+/EP46X/ZmYrryZQFjPLWh4REJHHiSFVWiHMZn0dhtM44bPng+vVGU/TOLLn/guu9Eilo1dOAdRw==
X-Gm-Message-State: AOJu0YwhmLXBH4cZoU5Eu6cDJsE0kSvvu1FhDwpDWnDWMGTOHoS+L9Ur
	rYZ1MAu3isJ3SbT7C8nLnkrIfHadtdUaa596oGgO3UOHaOlg4IixDhRTtCfehxx4dao9fJgoBdc
	pZTeWe1rflfobsraKCucwINfQgg==
X-Google-Smtp-Source: AGHT+IFlig/8HMMK8+8MAlG9oVSV1G9e9ARknWO63MMLHRAapkcwDQT7jsUS/iOZgXLILEwE/gbLzb/tU8kfZqC0Uqk=
X-Received: by 2002:a05:651c:1545:b0:2d2:7702:cb74 with SMTP id
 y5-20020a05651c154500b002d27702cb74mr2473667ljp.20.1709244651514; Thu, 29 Feb
 2024 14:10:51 -0800 (PST)
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
 <CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com> <20240229103423.1244de38@booty>
In-Reply-To: <20240229103423.1244de38@booty>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 29 Feb 2024 16:10:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxDozqONeN818qYg9QxQVte-9Cv_GuAz7SQ1FsscwuVw@mail.gmail.com>
Message-ID: <CAL_JsqLxDozqONeN818qYg9QxQVte-9Cv_GuAz7SQ1FsscwuVw@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 2/3] of: property: Improve finding the
 supplier of a remote-endpoint property
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:34=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hi Rob, Saravana,
>
> On Wed, 28 Feb 2024 18:26:36 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
>
> > On Wed, Feb 28, 2024 at 5:58=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 1:56=E2=80=AFPM Rob Herring <robh+dt@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, Feb 26, 2024 at 5:52=E2=80=AFAM Luca Ceresoli <luca.ceresol=
i@bootlin.com> wrote:
> > > > >
> > > > > Hello Saravana,
> > > > >
> > > > > On Fri, 23 Feb 2024 17:35:24 -0800
> > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > > On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.cer=
esoli@bootlin.com> wrote:
> > > > > > >
> > > > > > > Hello Saravana,
> > > > > > >
> > > > > > > [+cc Herv=C3=A9 Codina]
> > > > > > >
> > > > > > > On Tue,  6 Feb 2024 17:18:01 -0800
> > > > > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > > > >
> > > > > > > > After commit 4a032827daa8 ("of: property: Simplify of_link_=
to_phandle()"),
> > > > > > > > remote-endpoint properties created a fwnode link from the c=
onsumer device
> > > > > > > > to the supplier endpoint. This is a tiny bit inefficient (n=
ot buggy) when
> > > > > > > > trying to create device links or detecting cycles. So, impr=
ove this the
> > > > > > > > same way we improved finding the consumer of a remote-endpo=
int property.
> > > > > > > >
> > > > > > > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_pha=
ndle()")
> > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > >
> > > > > > > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I star=
ted
> > > > > > > getting unexpected warnings during device tree overlay remova=
l. After a
> > > > > > > somewhat painful bisection I identified this patch as the one=
 that
> > > > > > > triggers it all.
> > > > > >
> > > > > > Thanks for the report.
> > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > > --- a/drivers/of/property.c
> > > > > > > > +++ b/drivers/of/property.c
> > > > > > > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl=
-5", NULL)
> > > > > > > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > > > > > > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > > > > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > > > > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NUL=
L)
> > > > > > > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > > > > > > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > > > > > > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > > > > > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_int=
errupts(struct device_node *np,
> > > > > > > >       return of_irq_parse_one(np, index, &sup_args) ? NULL =
: sup_args.np;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static struct device_node *parse_remote_endpoint(struct de=
vice_node *np,
> > > > > > > > +                                              const char *=
prop_name,
> > > > > > > > +                                              int index)
> > > > > > > > +{
> > > > > > > > +     /* Return NULL for index > 0 to signify end of remote=
-endpoints. */
> > > > > > > > +     if (!index || strcmp(prop_name, "remote-endpoint"))
> > > > > > >
> > > > > > > There seem to be a bug here: "!index" should be "index > 0", =
as the
> > > > > > > comment suggests. Otherwise NULL is always returned.
> > > > > >
> > > > > > Ah crap, I think you are right. It should have been "index". No=
t
> > > > > > "!index". But I tested this! Sigh. I probably screwed up my tes=
ting.
> > > > > >
> > > > > > Please send out a Fix for this.
> > > > > >
> > > > > > Geert, we got excited too soon. :(
> > > > > >
> > > > > > > I am going to send a quick patch for that, but haven't done s=
o yet
> > > > > > > because it still won't solve the problem, so I wanted to open=
 the topic
> > > > > > > here without further delay.
> > > > > > >
> > > > > > > Even with the 'index > 0' fix I'm still getting pretty much t=
he same:
> > > > > >
> > > > > > This part is confusing though. If I read your DT correctly, the=
re's a
> > > > > > cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_d=
evlink
> > > > > > should not be enforcing any ordering between those devices ever=
.
> > > > > >
> > > > > > I'm surprised that in your "working" case, fw_devlink didn't de=
tect
> > > > > > any cycle. It should have. If there's any debugging to do, that=
's the
> > > > > > one we need to debug.
> > > > > >
> > > > > > >
> > > > > > > [   34.836781] ------------[ cut here ]------------
> > > > > > > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devre=
s.c:1064 devm_kfree+0x8c/0xfc
> > > > > > > ...
> > > > > > > [   35.024751] Call trace:
> > > > > > > [   35.027199]  devm_kfree+0x8c/0xfc
> > > > > > > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_=
kms_helper]
> > > > > > > [   35.036990]  devres_release_group+0xe0/0x164
> > > > > > > [   35.041264]  i2c_device_remove+0x38/0x9c
> > > > > > > [   35.045196]  device_remove+0x4c/0x80
> > > > > > > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > > > > > > [   35.054003]  device_release_driver+0x18/0x24
> > > > > > > [   35.058279]  bus_remove_device+0xcc/0x10c
> > > > > > > [   35.062292]  device_del+0x15c/0x41c
> > > > > > > [   35.065786]  device_unregister+0x18/0x34
> > > > > > > [   35.069714]  i2c_unregister_device+0x54/0x88
> > > > > > > [   35.073988]  of_i2c_notify+0x98/0x224
> > > > > > > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > > > > > > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > > > > > > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > > > > > > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > > > > > > ...
> > > > > > >
> > > > > > > By comparing the two versions I found that before removing th=
e overlay:
> > > > > > >
> > > > > > >  * in the "working" case (with this patch reverted) I have:
> > > > > > >
> > > > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > > > >    platform:hpbr--i2c:13-002c
> > > > > > >    platform:panel-dsi-lvds--i2c:13-002c
> > > > > >
> > > > > > Can you check the "status" and "sync_state_only" file in this f=
older
> > > > > > and tell me what it says?
> > > > > >
> > > > > > Since these devices have a cyclic dependency between them, it s=
hould
> > > > > > have been something other than "not tracked" and "sync_state_on=
ly"
> > > > > > should be "1". But my guess is you'll see "active" and "0".
> > > > > >
> > > > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > > > >    regulator:regulator.31--i2c:13-002c
> > > > > > >    #
> > > > > > >
> > > > > > >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as me=
ntioned):
> > > > > > >
> > > > > > >    # ls /sys/class/devlink/ | grep 002c
> > > > > > >    platform:hpbr--i2c:13-002c
> > > > > > >    platform:regulator-sys-1v8--i2c:13-002c
> > > > > > >    regulator:regulator.30--i2c:13-002c
> > > > > > >    #
> > > > > > >
> > > > > > > So in the latter case the panel-dsi-lvds--i2c:13-002c link is=
 missing.
> > > > > > > I think it gets created but later on removed. Here's a snippe=
t of the
> > > > > > > kernel log when that happens:
> > > > > > >
> > > > > > > [    9.578279] ----- cycle: start -----
> > > > > > > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c=
@3/dsi-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > > > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@=
30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > > [    9.578329] ----- cycle: end -----
> > > > > > > [    9.578334] platform panel-dsi-lvds: Fixed dependency cycl=
e(s) with /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@=
2c
> > > > > > > ...
> > > > > >
> > > > > > Somewhere in this area, I'm thinking you'll also see "device:
> > > > > > 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not?=
 And if
> > > > > > you enabled device link logs, you'll see that it was "sync stat=
e only"
> > > > > > link.
> > > > > >
> > > > > > > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /s=
oc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > > ...
> > > > > > > [    9.597280] ----- cycle: start -----
> > > > > > > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@=
30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > > > > > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c=
@3/dsi-lvds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > > > > > [    9.607581] ----- cycle: end -----
> > > > > > > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /p=
anel-dsi-lvds
> > > > > > > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c'=
: device_add
> > > > > > > ...
> > > > > > > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c=
@3/dsi-lvds-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > > > > > > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c=
@3/dsi-lvds-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > > > > > > ...
> > > > > > > [    9.739840] panel-simple panel-dsi-lvds: Dropping the link=
 to 13-002c
> > > > > > > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds'=
: device_unregister
> > > > > >
> > > > > > Oh yeah, see. The "device_add" I expected earlier is getting re=
moved here.
> > > > > >
> > > > > > > [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-=
dsi-lvds
> > > > > > > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c'=
: device_unregister
> > > > > > >
> > > > > > > And here's the relevant portion of my device tree overlay:
> > > > > > >
> > > > > > > --------------------8<--------------------
> > > > > > >
> > > > > >
> > > > > > I think the eventual fix would be this series + adding a
> > > > > > "post-init-providers" property to the device that's supposed to=
 probe
> > > > > > first and point it to the device that's supposed to probe next.=
 Do
> > > > > > this at the device node level, not the endpoint level.
> > > > > > https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak=
@google.com/
> > > > >
> > > > > I'm certainly going to look at this series in more detail and at =
the
> > > > > debugging you asked for, however I'm afraid I won't have access t=
o the
> > > > > hardware this week and it's not going to be a quick task anyway.
> > > > >
> > > > > So in this moment I think it's quite clear that this specific pat=
ch
> > > > > creates a regression and there is no clear fix that is reasonably
> > > > > likely to get merged before 6.8.
> > > > >
> > > > > I propose reverting this patch immediately, unless you have a bet=
ter
> > > > > short-term solution.
> > > >
> > > > It's just this one of the 3 patches that needs reverting?
>
> Just this patch. I reverted only this and the issue disappeared.
>
> > > I sent a fix. With the fix, it's just exposing a bug elsewhere.
>
> Exactly, this patch has two issues and only the easy one has a fix [0]
> currently as far as I know.
>
> > You say apply the fix. Luca says revert. I say I wish I made this 6.9
> > material. Which is it?
> >
> > If the overlay applying depends on out of tree code (likely as there
> > are limited ways to apply an overlay in mainline), then I don't really
> > care if there is still a regression.
>
> Obviously, to load and unload the overlays I'm using code not yet
> in mainline. It is using of_overlay_fdt_apply() and of_overlay_remove()
> via a driver underdevelopment that is similar to the one Herv=C3=A9 and
> Lizhi Hou are working on [1][2].
>
> I see the point that "we are not breaking existing use cases as no code
> is (un)loading overlays except unittest", sure.
>
> As I see it, we have a feature in the kernel that is not used, but it
> will be, eventually: there are use cases, development is progressing and
> patches are being sent actively. My opinion is that we should not
> put additional known obstacles that will make it even harder than it
> already is.

Well, I don't care to do extra work of applying things and then have
to turn right around fix or revert them. It happens enough as-is with
just mainline. And no one wants to step up and fix the problems with
overlays, but are fine just carrying their out of tree patches. What's
one more. This is the 2nd case of overlay problems with out of tree
users *today*! Some days I'm tempted to just remove overlay support
altogether given the only way to apply them is unittest.

Given Geert is having issues too, I guess I'm going to revert.

Rob

