Return-Path: <linux-kernel+bounces-85748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348B86BA47
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E30B1F24BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75172907;
	Wed, 28 Feb 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe4EZz+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CE7005A;
	Wed, 28 Feb 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157376; cv=none; b=paeFAfnZc6n6ix2IouwdW/8ne8LZbRf7aFUTLtIrd8mDhHGBogw2mKZBTvhPEjZGYISayPxuSqJJC1L2UYGZqXlWAdqnb4/fSUu0RoYb13UXOm+1EfmKJnFiXv0BjQTwOm7fc1adBmnywzTXKgkw95FUJsV/c26doVyXsRpX8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157376; c=relaxed/simple;
	bh=fivzlNuqcMyyEyoYz2yfaUo0MRQm2oPcYqIlQhQoQzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq/y9wDTLOibjf/SO2IrQ7IcuVxxcY9xEcBFNy+ESehLgUoTognvUZSA9B3CIhmXmPWbsbUQQpxG+coIxCzx4VBwdOC01V9nB13229C2AjxGk15fx0z/76s2E4zNiOp25waIxSiGL/EHw+0hdjBfqS9NyqU6KcpVw39Euucnd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe4EZz+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95694C433A6;
	Wed, 28 Feb 2024 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709157375;
	bh=fivzlNuqcMyyEyoYz2yfaUo0MRQm2oPcYqIlQhQoQzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fe4EZz+kfdJPbtG/DcShD39KdK4KAvnndiBFEnTk3LCLy1NAO4OOP7oC/Lr5w81kr
	 IOnY0elob2kMXm7Asam/Ce9H1l0zNrNtgAhtRRrot3pH3oTk0DIk6qk4zbJU0pdgL2
	 3NmyMs0JWmTE1e8hK5VcwfzagdsKRv4HmkIYgwa4K/w4n/N9Ueh6eV8lpa81Xl3/XL
	 BCVH6cNjVj0545lPd+SakJ95sjKqEn87wsXbPkB3cQvGo9BJbxR/sTJKkxugvjV0Se
	 lE9OUeMieSggEFDdsztQfu/34RYuJ5F8NjGfVPRngGUSlKwnPpk/RLf/rfh02IZgH/
	 MbuD4N6QvGPwA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bde3d197so163786e87.0;
        Wed, 28 Feb 2024 13:56:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViGln6MtXKIKVZ1IPtWFRGOrLMun8ZV1iMP0B/7NwMyR2GIqm8pqN2Z164hA97LGy8OOEO5FYyIITb15AdKjt2cjyai76ErQ9AzmpAZmihbMMxnvcgxdj8sY633F3Wgv9Y411OBhv3Og==
X-Gm-Message-State: AOJu0YyyRo2zbNWNBc2x5uMP2Hz9xlyKx0ceiM65/msdhRNhM7fYrbXx
	t/5Wc+2LMQugZ6x/dUXrU017dC5rnmkCmUBal/LstOBbt+jAXfkAAE+eK9VFa3mv5p7OVRF9aLv
	boCdB77b1pr/yWMxXEwJtHfUv/A==
X-Google-Smtp-Source: AGHT+IHBpqxL/hSxmznKsDAK2xoaM1O/59+3fzuolZJlr0PX4M0zvEPTcbz20hvuwA/guifJKYmM6MtlyyvJ0VDU/u4=
X-Received: by 2002:a05:6512:312a:b0:512:f511:578c with SMTP id
 p10-20020a056512312a00b00512f511578cmr146338lfd.18.1709157373605; Wed, 28 Feb
 2024 13:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-3-saravanak@google.com> <20240223171849.10f9901d@booty>
 <CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com> <20240226125226.705efef3@booty>
In-Reply-To: <20240226125226.705efef3@booty>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Feb 2024 15:56:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
Message-ID: <CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
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

On Mon, Feb 26, 2024 at 5:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Saravana,
>
> On Fri, 23 Feb 2024 17:35:24 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>
> > On Fri, Feb 23, 2024 at 8:18=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bo=
otlin.com> wrote:
> > >
> > > Hello Saravana,
> > >
> > > [+cc Herv=C3=A9 Codina]
> > >
> > > On Tue,  6 Feb 2024 17:18:01 -0800
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > > After commit 4a032827daa8 ("of: property: Simplify of_link_to_phand=
le()"),
> > > > remote-endpoint properties created a fwnode link from the consumer =
device
> > > > to the supplier endpoint. This is a tiny bit inefficient (not buggy=
) when
> > > > trying to create device links or detecting cycles. So, improve this=
 the
> > > > same way we improved finding the consumer of a remote-endpoint prop=
erty.
> > > >
> > > > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > After rebasing my own branch on v6.8-rc5 from v6.8-rc1 I started
> > > getting unexpected warnings during device tree overlay removal. After=
 a
> > > somewhat painful bisection I identified this patch as the one that
> > > triggers it all.
> >
> > Thanks for the report.
> >
> > >
> > > > ---
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NUL=
L)
> > > >  DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> > > >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > -DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> > > >  DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
> > > >  DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
> > > >  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
> > > > @@ -1298,6 +1297,17 @@ static struct device_node *parse_interrupts(=
struct device_node *np,
> > > >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_ar=
gs.np;
> > > >  }
> > > >
> > > > +static struct device_node *parse_remote_endpoint(struct device_nod=
e *np,
> > > > +                                              const char *prop_nam=
e,
> > > > +                                              int index)
> > > > +{
> > > > +     /* Return NULL for index > 0 to signify end of remote-endpoin=
ts. */
> > > > +     if (!index || strcmp(prop_name, "remote-endpoint"))
> > >
> > > There seem to be a bug here: "!index" should be "index > 0", as the
> > > comment suggests. Otherwise NULL is always returned.
> >
> > Ah crap, I think you are right. It should have been "index". Not
> > "!index". But I tested this! Sigh. I probably screwed up my testing.
> >
> > Please send out a Fix for this.
> >
> > Geert, we got excited too soon. :(
> >
> > > I am going to send a quick patch for that, but haven't done so yet
> > > because it still won't solve the problem, so I wanted to open the top=
ic
> > > here without further delay.
> > >
> > > Even with the 'index > 0' fix I'm still getting pretty much the same:
> >
> > This part is confusing though. If I read your DT correctly, there's a
> > cycle between platform:panel-dsi-lvds and i2c:13-002c. And fw_devlink
> > should not be enforcing any ordering between those devices ever.
> >
> > I'm surprised that in your "working" case, fw_devlink didn't detect
> > any cycle. It should have. If there's any debugging to do, that's the
> > one we need to debug.
> >
> > >
> > > [   34.836781] ------------[ cut here ]------------
> > > [   34.841401] WARNING: CPU: 2 PID: 204 at drivers/base/devres.c:1064=
 devm_kfree+0x8c/0xfc
> > > ...
> > > [   35.024751] Call trace:
> > > [   35.027199]  devm_kfree+0x8c/0xfc
> > > [   35.030520]  devm_drm_panel_bridge_release+0x54/0x64 [drm_kms_help=
er]
> > > [   35.036990]  devres_release_group+0xe0/0x164
> > > [   35.041264]  i2c_device_remove+0x38/0x9c
> > > [   35.045196]  device_remove+0x4c/0x80
> > > [   35.048774]  device_release_driver_internal+0x1d4/0x230
> > > [   35.054003]  device_release_driver+0x18/0x24
> > > [   35.058279]  bus_remove_device+0xcc/0x10c
> > > [   35.062292]  device_del+0x15c/0x41c
> > > [   35.065786]  device_unregister+0x18/0x34
> > > [   35.069714]  i2c_unregister_device+0x54/0x88
> > > [   35.073988]  of_i2c_notify+0x98/0x224
> > > [   35.077656]  blocking_notifier_call_chain+0x6c/0xa0
> > > [   35.082543]  __of_changeset_entry_notify+0x100/0x16c
> > > [   35.087515]  __of_changeset_revert_notify+0x44/0x78
> > > [   35.092398]  of_overlay_remove+0x114/0x1c4
> > > ...
> > >
> > > By comparing the two versions I found that before removing the overla=
y:
> > >
> > >  * in the "working" case (with this patch reverted) I have:
> > >
> > >    # ls /sys/class/devlink/ | grep 002c
> > >    platform:hpbr--i2c:13-002c
> > >    platform:panel-dsi-lvds--i2c:13-002c
> >
> > Can you check the "status" and "sync_state_only" file in this folder
> > and tell me what it says?
> >
> > Since these devices have a cyclic dependency between them, it should
> > have been something other than "not tracked" and "sync_state_only"
> > should be "1". But my guess is you'll see "active" and "0".
> >
> > >    platform:regulator-sys-1v8--i2c:13-002c
> > >    regulator:regulator.31--i2c:13-002c
> > >    #
> > >
> > >  * in the "broken" case (v6.8-rc5 + s/!index/index > 0/ as mentioned)=
:
> > >
> > >    # ls /sys/class/devlink/ | grep 002c
> > >    platform:hpbr--i2c:13-002c
> > >    platform:regulator-sys-1v8--i2c:13-002c
> > >    regulator:regulator.30--i2c:13-002c
> > >    #
> > >
> > > So in the latter case the panel-dsi-lvds--i2c:13-002c link is missing=
.
> > > I think it gets created but later on removed. Here's a snippet of the
> > > kernel log when that happens:
> > >
> > > [    9.578279] ----- cycle: start -----
> > > [    9.578283] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-l=
vds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > [    9.578308] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000=
/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > [    9.578329] ----- cycle: end -----
> > > [    9.578334] platform panel-dsi-lvds: Fixed dependency cycle(s) wit=
h /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > ...
> >
> > Somewhere in this area, I'm thinking you'll also see "device:
> > 'i2c:13-002c--platform:panel-dsi-lvds': device_add" do you not? And if
> > you enabled device link logs, you'll see that it was "sync state only"
> > link.
> >
> > > [    9.590620] /panel-dsi-lvds Dropping the fwnode link to /soc@0/bus=
@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > ...
> > > [    9.597280] ----- cycle: start -----
> > > [    9.597283] /panel-dsi-lvds: cycle: depends on /soc@0/bus@30800000=
/i2c@30ad0000/i2cmux@70/i2c@3/dsi-lvds-bridge@2c
> > > [    9.602781] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-l=
vds-bridge@2c: cycle: depends on /panel-dsi-lvds
> > > [    9.607581] ----- cycle: end -----
> > > [    9.607585] i2c 13-002c: Fixed dependency cycle(s) with /panel-dsi=
-lvds
> > > [    9.614217] device: 'platform:panel-dsi-lvds--i2c:13-002c': device=
_add
> > > ...
> > > [    9.614277] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-l=
vds-bridge@2c Dropping the fwnode link to /panel-dsi-lvds
> > > [    9.614369] /soc@0/bus@30800000/i2c@30ad0000/i2cmux@70/i2c@3/dsi-l=
vds-bridge@2c Dropping the fwnode link to /regulator-dock-sys-1v8
> > > ...
> > > [    9.739840] panel-simple panel-dsi-lvds: Dropping the link to 13-0=
02c
> > > [    9.739846] device: 'i2c:13-002c--platform:panel-dsi-lvds': device=
_unregister
> >
> > Oh yeah, see. The "device_add" I expected earlier is getting removed he=
re.
> >
> > > [   10.247037] sn65dsi83 13-002c: Dropping the link to panel-dsi-lvds
> > > [   10.247049] device: 'platform:panel-dsi-lvds--i2c:13-002c': device=
_unregister
> > >
> > > And here's the relevant portion of my device tree overlay:
> > >
> > > --------------------8<--------------------
> > >
> >
> > I think the eventual fix would be this series + adding a
> > "post-init-providers" property to the device that's supposed to probe
> > first and point it to the device that's supposed to probe next. Do
> > this at the device node level, not the endpoint level.
> > https://lore.kernel.org/lkml/20240221233026.2915061-1-saravanak@google.=
com/
>
> I'm certainly going to look at this series in more detail and at the
> debugging you asked for, however I'm afraid I won't have access to the
> hardware this week and it's not going to be a quick task anyway.
>
> So in this moment I think it's quite clear that this specific patch
> creates a regression and there is no clear fix that is reasonably
> likely to get merged before 6.8.
>
> I propose reverting this patch immediately, unless you have a better
> short-term solution.

It's just this one of the 3 patches that needs reverting?

Rob

