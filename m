Return-Path: <linux-kernel+bounces-46604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F718441DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472261F21402
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB98286B;
	Wed, 31 Jan 2024 14:28:59 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146380C0C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711339; cv=none; b=Zrjrw6umMDZyXD8guHe1uOZtkmQhehBkJYl7aL7En+PEggPEw7o9ssF6nb4tuEg8/dfKr8YAseDpT2/lZIT4v8Rvz6xB4kGoAm9+1ce54kXuM27wnpbg58UPtesvjx2dZzAOrPghYXcsexU922kR1/bjs4lwxKDVRnGfVaeWWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711339; c=relaxed/simple;
	bh=GIY3puUwmm8gipSYVvNmXkzP4r+lY0H0/6s2wL+i7Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kgw2zoeSSTmGwlqbJ4lrMPb0degye5p+XSk1Wx4JGSIhiplMy5Me6Srz3Q94ww+NaMX/g9MC/f+kTtaEVjAdYZl1QRSi0e2v/sV87u6BrQ5+zJWPyfBTSPrdOW13gSJ4uVx5yktIY1aK6RH69s62VcSzgYEo47tBD/2xtTRyIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a134e29d2so593940eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711336; x=1707316136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbuYbhYTg4M3+vx3CF+IFiq2udSQyY8c3ipCcauV4D4=;
        b=uxNt2fOH3wsDgbvxwBKicVb0U2TGW51a9hMg2In18F3vuTT0Y73S+XF5dDNlHLQzjU
         Gyuux0Sdwr3h9It+WelkZpuUJUzTFoPIIaXpzhVT9fOv7k5FPaVaGBMbPgyplrjRTXcY
         e5bplAdIop+BmOuv+TkyLA2O3WNdRzCdg31DV+DnMailn7/b18WOgemCaWOqpIzsexEs
         Ule14c5wWcSdB+9sU68mNCjc+XJWP2W2KpzgkPJt5knXp5HoAKyFA9+NY65JmCk3dxK+
         I53SaQeq8H5Ig14f7K/6oaERs5qxD4P60qGMYPQfdB12bBZfkN7ENgoRovr85T7sJbbM
         Beaw==
X-Gm-Message-State: AOJu0Yy3i3XOjyBypW+/5zKN12nLcj0X/UEeXbu62Ftdy6goF1Jl6Nsd
	KL7xxLrqckLMu/oJPIfVgJkQOcI4hMCJUKeQSl8uzu6Ha8XjkGlI9FNjgpU0eESN0SYUyttCuBU
	KWgpT3TvWP65i+1tnLUdpnbfH/70=
X-Google-Smtp-Source: AGHT+IHdFq8z8b2V9wc0FWARlsindN6BD/8xxmNLb0+6cLn0Bo+xpEUoc89OA/yF4rB1ox11kwv7yPzriQug84hwrOQ=
X-Received: by 2002:a05:6870:55ce:b0:218:d68f:fe29 with SMTP id
 qk14-20020a05687055ce00b00218d68ffe29mr626994oac.3.1706711336553; Wed, 31 Jan
 2024 06:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com> <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
In-Reply-To: <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 15:28:45 +0100
Message-ID: <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links removal
 for dt overlays
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote:
> > >
> > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >
> > > > For device links, releasing the supplier/consumer devices reference=
s
> > > > happens asynchronously in device_link_release_fn(). Hence, the poss=
ible
> > > > release of an of_node is also asynchronous. If these nodes were add=
ed
> > > > through overlays we have a problem because this does not respect th=
e
> > > > devicetree overlays assumptions that when a changeset is
> > > > being removed in __of_changeset_entry_destroy(), it must hold the l=
ast
> > > > reference to that node. Due to the async nature of device links tha=
t
> > > > cannot be guaranteed.
> > > >
> > > > Given the above, in case one of the link consumer/supplier is part =
of
> > > > an overlay node we call directly device_link_release_fn() instead o=
f
> > > > queueing it. Yes, it might take some significant time for
> > > > device_link_release_fn() to complete because of synchronize_srcu() =
but
> > > > we would need to, anyways, wait for all OF references to be release=
d if
> > > > we want to respect overlays assumptions.
> > > >
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > > This RFC is a follow up of a previous one that I sent to the device=
tree
> > > > folks [1]. It got rejected because it was not really fixing the roo=
t
> > > > cause of the issue (which I do agree). Please see the link where I
> > > > fully explain what the issue is.
> > > >
> > > > I did also some git blaming and did saw that commit
> > > > 80dd33cf72d1 ("drivers: base: Fix device link removal") introduced
> > > > queue_work() as we could be releasing the last device reference and=
 hence
> > > > sleeping which is against SRCU callback requirements. However, that=
 same
> > > > commit is now making use of synchronize_srcu() which may take
> > > > significant time (and I think that's the reason for the work item?)=
.
> > > >
> > > > However, given the dt overlays requirements, I'm not seeing any
> > > > reason to not be able to run device_link_release_fn() synchronously=
 if we
> > > > detect an OVERLAY node is being released. I mean, even if we come u=
p
> > > > (and I did some experiments in this regard) with some async mechani=
sm to
> > > > release the OF nodes refcounts, we still need a synchronization poi=
nt
> > > > somewhere.
> > > >
> > > > Anyways, I would like to have some feedback on how acceptable would=
 this
> > > > be or what else could I do so we can have a "clean" dt overlay remo=
val.
> > > >
> > > > I'm also including dt folks so they can give some comments on the n=
ew
> > > > device_node_overlay_removal() function. My goal is to try to detect=
 when
> > > > an
> > > > overlay is being removed (maybe we could even have an explicit flag=
 for
> > > > it?) and only directly call device_link_release_fn() in that case.
> > > >
> > > > [1]:
> > > > https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-n=
uno.sa@analog.com/
> > > > ---
> > > >  drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 14d46af40f9a..31ea001f6142 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] =3D {
> > > >  };
> > > >  ATTRIBUTE_GROUPS(devlink);
> > > >
> > > > +static bool device_node_overlay_removal(struct device *dev)
> > > > +{
> > > > +     if (!dev_of_node(dev))
> > > > +             return false;
> > > > +     if (!of_node_check_flag(dev->of_node, OF_DETACHED))
> > > > +             return false;
> > > > +     if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
> > > > +             return false;
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > >  static void device_link_release_fn(struct work_struct *work)
> > > >  {
> > > >       struct device_link *link =3D container_of(work, struct device=
_link,
> > > > rm_work);
> > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct device =
*dev)
> > > >        * synchronization in device_link_release_fn() and if the con=
sumer
> > > > or
> > > >        * supplier devices get deleted when it runs, so put it into =
the
> > > > "long"
> > > >        * workqueue.
> > > > +      *
> > > > +      * However, if any of the supplier, consumer nodes is being r=
emoved
> > > > +      * through overlay removal, the expectation in
> > > > +      * __of_changeset_entry_destroy() is for the node 'kref' to b=
e 1
> > > > which
> > > > +      * cannot be guaranteed with the async nature of
> > > > +      * device_link_release_fn(). Hence, do it synchronously for t=
he
> > > > overlay
> > > > +      * case.
> > > >        */
> > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > +     if (device_node_overlay_removal(link->consumer) ||
> > > > +         device_node_overlay_removal(link->supplier))
> > > > +             device_link_release_fn(&link->rm_work);
> > > > +     else
> > > > +             queue_work(system_long_wq, &link->rm_work);
> > > >  }
> > > >
> > > >  static struct class devlink_class =3D {
> > > >
> > > > ---
> > > > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > > > change-id: 20240123-fix-device-links-overlays-5422e033a09b
> > > > --
> > > >
> > > > Thanks!
> > > > - Nuno S=C3=A1
> > > >
> > >
> > > Hi Rafael,
> > >
> > > Would be nice to have your feedback on this one or if this is a compl=
ete
> > > nack...
> > > I think calling device_link_release_fn() synchronously is ok but I mi=
ght be
> > > completely wrong.
> >
> > Well, it sounds like you are expecting me to confirm that what you are
> > doing makes sense, but I cannot do that, because I am not sufficiently
> > familiar with DT overlays.
> >
>
> I'm trying to understand if there's no hidden issue by calling it synchro=
nously.
> (don't think there is but this is rather core stuff :)).
>
> From the DT guys, it would be helpful to get feedback on the new
> device_node_overlay_removal() helper I'm introducing. The goal is to just=
 do the
> sync release in case we detect a node being removed as a result of an ove=
rlay
> removal.
>
> > You first need to convince yourself that you are not completely wrong.
>
> I mean, the problem is definitely real and if you see the link I pasted i=
n the
> cover, this will all lead to big splats.
>
> >
> > > +Cc Saravan as he should also be very familiar with device_links and =
see if
> > > the
> > > above fairly simple solution is sane.
> > >
> > > I also don't want to be pushy as I know you guys are all very busy bu=
t it's
> > > (i
> > > think) the third time I resend the patch :)
> >
> > Sorry about that, I haven't realized that my input is requisite.
> >
>
> Yeah, get_mantainers gives me you and Greg but I think you're the main de=
v on
> dev_links right?
>
> > So the patch not only calls device_link_release_fn() synchronously,
> > but it also calls this function directly and I, personally, wouldn't
> > do at least the latter.
> >
>
> So you mean adding something like adding a new
>
> device_link_release(struct device_link *link) helper
> and either call it synchronously from devlink_dev_release() or asynchrono=
usly
> from device_link_release_fn()?
>
> I can drop the RFC and send a patch with the above...

No, IMV devlink_dev_release() needs to be called via
device_link_put_kref(), but it may run device_link_release_fn()
directly if the link is marked in a special way or something like
this.

AFAICS, this is the only way to do it and be sure that all of the
references to the link have been dropped when it is freed.

