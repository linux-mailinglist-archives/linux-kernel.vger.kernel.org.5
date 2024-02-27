Return-Path: <linux-kernel+bounces-83904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D1869FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0701F2E3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDB145FE6;
	Tue, 27 Feb 2024 19:13:37 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C051C4D;
	Tue, 27 Feb 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061216; cv=none; b=l+NWWPSFI5CCWVLC+KC/rYkLqg1udKBzTzd0D4Y68iej6DAVJcwuGjCYXUCmU2V7Yie4jspygLb5/X4PWDBynCK35WYpTkKFlBB2CS+HXsDlvbX57dhLmvm6cTE9JdenwulCT4P8rPPk+lKHMRrJqZUFtnQraJy8x4//2ikCnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061216; c=relaxed/simple;
	bh=BdNWLB/9Q80f5latk6Tvf+i8jtOLoAB7p0iJYrLzeCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTmtYiBdZmxK+Ev110sQzFpOzZVW7e2qCsAh5DxHqKsUMbgEMr+DSDanqX6Qy2rkM6WR6Sp+KcWEMPhv0vpZ+cjcK0bYdw/dorxOOJzeX9LzLNpJ27+k4NeA7Z2+D6sR/p7hbwrxVto8vCJAn8bR5+Jy7yRPjcLl1GE1Cu9uAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4857d93ebso1406226a34.0;
        Tue, 27 Feb 2024 11:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061214; x=1709666014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+2L4lyqqD2zuVta+J15BPKHif64xeqes4P7tV8IFMI=;
        b=VwLzSCvKTbyG2qT20KM7nCwsZIIVenaSAlLiF1gHrD9JCH/AzwFCswYRV7fM0courI
         seEZ6y8S0dacLX4xrtCx3OSdLph0HaVw92U3dfXj/s8NY26qOEkAiefEXsaZ9yByH/A5
         iorXnq1Ywb1Fm7nXXj9lWthiV3WXrFK+KpvtDjtJ+AhoQLxUUYw7jQtpvCeE/xp7qJnY
         feZNavVnZwKp1pKI8l8/STUNozGLCMfRbaJ7+u/5Ym2L5nWNywe88w7e6p9a9cSvB5zA
         NMIzMFt2tHJcgDgWhcKHU+MALTDTDMN+V0r5GiakUFhTE1RvvDYX0qj0/MDkDlKr7Yye
         391w==
X-Forwarded-Encrypted: i=1; AJvYcCULjgTnwsam00NbjXnfshtm+3tfk/U0hKhSimklodcYP9N1O2iVhKbyK7iO8yhfP+WYBXKawuoFEse5LGn48s66uvZLQIdeHBoI25bFxuKlI8Dy0nucNYlU06U6dw8QlGYFIMg3U5ccjw==
X-Gm-Message-State: AOJu0YxFpxkbS9VufiRJSO1IWMEbmdU59/OcZPqiIENNRVLWAZfe9YzW
	+ZwRZ8ReRZnZ8v15Kz6l7SuDrJOoQ8nDuJdIYW4irkgfwzPD5tXDPwXvJAl8fNOZaGEIIjSyPX2
	L8ZDQfWlJ1Tc0EAEPyMR+l32oYL0=
X-Google-Smtp-Source: AGHT+IFJxKNnL/HMz3LSvkzFZs4C7QS5yy6HpFPIjQTw56GSIrdr+nCfBayizBLjnLY6Cq5110coAPBd4l6eQZor/1U=
X-Received: by 2002:a4a:d0d4:0:b0:5a0:3aeb:ae3f with SMTP id
 u20-20020a4ad0d4000000b005a03aebae3fmr11072622oor.0.1709061214431; Tue, 27
 Feb 2024 11:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130174126.688486-1-herve.codina@bootlin.com>
 <20231130174126.688486-3-herve.codina@bootlin.com> <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
 <20240227162422.76a00f11@bootlin.com> <86f2262d059db84070745e299d96dde3e6078220.camel@gmail.com>
 <20240227185402.57a3b924@bootlin.com> <9ae28df7a4770bf94358dac36fd5e0942877f147.camel@gmail.com>
In-Reply-To: <9ae28df7a4770bf94358dac36fd5e0942877f147.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 20:13:23 +0100
Message-ID: <CAJZ5v0jE8QfSrs1uqgU7RceGWbT12YymouAOhsb7WxKmMbGeGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with the
 devlink removals
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Nuno Sa <nuno.sa@analog.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:08=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> Hi Herve,
>
> On Tue, 2024-02-27 at 18:54 +0100, Herve Codina wrote:
> > Hi Nuno,
> >
> > On Tue, 27 Feb 2024 17:55:07 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >
> > > On Tue, 2024-02-27 at 16:24 +0100, Herve Codina wrote:
> > > > Hi Saravana, Luca, Nuno,
> > > >
> > > > On Tue, 20 Feb 2024 16:37:05 -0800
> > > > Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > >
> > > > > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > > > > index a9a292d6d59b..5c5f808b163e 100644
> > > > > > --- a/drivers/of/overlay.c
> > > > > > +++ b/drivers/of/overlay.c
> > > > > > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > > > > >                 goto out;
> > > > > >         }
> > > > > >
> > > > > > +       /*
> > > > > > +        * Wait for any ongoing device link removals before rem=
oving some
> > > > > > of
> > > > > > +        * nodes
> > > > > > +        */
> > > > > > +       device_link_wait_removal();
> > > > > > +
> > > > >
> > > > > Nuno in his patch[1] had this "wait" happen inside
> > > > > __of_changeset_entry_destroy(). Which seems to be necessary to no=
t hit
> > > > > the issue that Luca reported[2] in this patch series. Is there an=
y
> > > > > problem with doing that?
> > > > >
> > > > > Luca for some reason did a unlock/lock(of_mutex) in his test patc=
h and
> > > > > I don't think that's necessary.
> > > >
> > > > I think the unlock/lock in Luca's case and so in Nuno's case is nee=
ded.
> > > >
> > > > I do the device_link_wait_removal() wihout having the of_mutex lock=
ed.
> > > >
> > > > Now, suppose I do the device_link_wait_removal() call with the of_m=
utex locked.
> > > > The following flow is allowed and a deadlock is present.
> > > >
> > > > of_overlay_remove()
> > > >   lock(of_mutex)
> > > >      device_link_wait_removal()
> > > >
> > > > And, from the workqueue jobs execution:
> > > >   ...
> > > >     device_put()
> > > >       some_driver->remove()
> > > >         of_overlay_remove() <--- The job will never end.
> > > >                                  It is waiting for of_mutex.
> > > >                                  Deadlock
> > > >
> > >
> > > We may need some input from Saravana (and others) on this. I might be=
 missing
> > > something but can a put_device() lead into a driver remove callback? =
Driver code
> > > is
> > > not device code and put_device() leads to device_release() which will=
 either call
> > > the
> > > device ->release(), ->type->release() or the class ->dev_release(). A=
nd, IMO,
> > > calling
> > > of_overlay_remove() or something like that (like something that would=
 lead to
> > > unbinding a device from it's driver) in a device release callback wou=
ld be at the
> > > very least very questionable. Typically, what you see in there is of_=
node_put()
> > > and
> > > things like kfree() of the device itself or any other data.
> >
> > I think that calling of_overlay_remove() in a device release callback m=
akes
> > sense. The overlay is used to declare sub-nodes from the device node. I=
t
> > does not add/remove the device node itself but sub-nodes.
> >
>
> I think we are speaking about two different things... device release is n=
ot the same
> as the driver remove callback. I admit the pci case seems to be a beast o=
f it's own
> and I just spent some time (given your links) on it so I can't surely be =
sure about
> what I'm about to say... But, AFAICT, I did not saw any overlay or change=
set being
> removed from a kobj_type release callback.
>
> > The use case is the use of DT overlays to describe PCI devices.
> > https://lore.kernel.org/all/1692120000-46900-1-git-send-email-lizhi.hou=
@amd.com/
> > https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@boot=
lin.com/
> > --- 8< ---
> > The lan966x SoCs can be used in two different ways:
> >
> >  - It can run Linux by itself, on ARM64 cores included in the SoC. This
> >    use-case of the lan966x is currently being upstreamed, using a
> >    traditional Device Tree representation of the lan996x HW blocks [1]
> >    A number of drivers for the different IPs of the SoC have already
> >    been merged in upstream Linux.
> >
> >  - It can be used as a PCIe endpoint, connected to a separate platform
> >    that acts as the PCIe root complex. In this case, all the devices
> >    that are embedded on this SoC are exposed through PCIe BARs and the
> >    ARM64 cores of the SoC are not used. Since this is a PCIe card, it
> >    can be plugged on any platform, of any architecture supporting PCIe.
> > --- 8< ---
> >
> > This quite long story led to DT overlay support for PCI devices and so =
the
> > unittest I mentioned:
> >   https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/of/unittest.=
c#L3946
> >
> >
> > So, I have a PCI driver that bind to the lan966x PCI board.
> > This driver loads an overlay at probe() and unload it at remove().
> > Also, this driver can be module. A simple rmmod leads to the remove() c=
all.
> >
>
> Hmm, and I think that would not be an issue... Note that the code that ru=
ns in
> device_link_release_fn() is doing put_device() which ends ups on the kobj=
_type
> release callback and so far I could not see any evidence of such a callba=
ck being
> responsible of calling device_remove() on another device. That would be w=
eird (I
> think) since I would expect such a call to happen in a kind of unregister=
 function.
>
> > This driver is not yet upstream because I haven't yet fixed all the iss=
ues I
> > encountered that's why of now, I can point only the unittest related to=
 overlay
> > support for PCI.
> >
> > >
> > > The driver remove callback should be called when unbinding the device=
 from it's
> > > drivers and devlinks should also be removed after device_unbind_clean=
up() (i.e,
> > > after
> > > the driver remove callback).
> > >
> > > Having said the above, the driver core has lots of subtleties so, aga=
in, I can be
> > > missing something. But at this point I'm still not seeing any deadloc=
k...
> > >
> >
> > I gave a wrong example.
> > Based on Luca's sequence he gave in
> >   https://lore.kernel.org/all/20231220181627.341e8789@booty/
>
> Regarding Luca's comments, my first approach was actually to just make th=
e devlink
> removal synchronously... I'm still not sure what would be the issue of do=
ing that
> (other than potentially waiting some time for the srcu synchronization).

It would allow forward progress to be made, but it would add potential
delay for everybody, which is only really needed in the DT overlay
case.  Sounds like something to avoid to me.

> About the unlock, I'm just not sure what could happen if someone else (ot=
her than us) sneaks in
> and grabs the of_mutex while we are in the middle of removing an overlay.=
.

If that is possible at all, I'd call it a bug.

