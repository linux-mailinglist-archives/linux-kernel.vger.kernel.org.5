Return-Path: <linux-kernel+bounces-46756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B08443A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372661F26682
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533912A15E;
	Wed, 31 Jan 2024 16:05:16 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4D12A15C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717115; cv=none; b=b6ZspaU1NFbAmyLVCbBgr+XODtyc6fmpVu7EEN/YGiXPibczWWpkd3rfg85MNSZPUv89r3eIT8ytEhOHHfWmJb1x/Jt2qWQbOa8RK03tTQpDQ/4fuQsAZd9hhIFH9jfXxqPxk82RF612ETBVMBFQoRvLrIryNmZKcZEgafCkk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717115; c=relaxed/simple;
	bh=7mKW+OHj3yGbTswJBa10dhFZoNBsPYh0fy7RTmxx1eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxaK+CkxMYR87UVA9qFEpZ+kH974Jcu3y0j0DTd9W37cOzubHKP53rL21kghFk2wHIb0zJdiP2a1rfLp37uYD/hFaMY9K+ftz5rLXTCYjilPkVLzt1bYNoEHIzc5MlZG433qcN4/SE3Kj/ynULBxWWtGRConRK2Jm90zkkYfASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a24bf7cadso1087311eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717113; x=1707321913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7OaZiinwbzng/0HgaGMCW4qacoR+2u1bX4wvl4xbCg=;
        b=c5mceaPespC/ex59vMBoXPCyaaPEPwgRcMJYagldjI0ACrEpUXx9sv3MdwEKjZ24Ve
         ZLds1WoyjB9+/Ro0sgO9z8DNyoMnd3yFR4rbMfg3n7jbznd4Gy9/xLRpg/l809pm8FQ8
         n3lbFu36rEmyy0hAvDf6RjtiYdE0pfe9R/4nQjlQq078ESBBzX34ESkiG0eYlZfOS4br
         kk6H7x14J3pO1FkiFnzXQTrj/m+8tNL6qdBXANZwBvJwM4N3BHdW1mHPDmx4YGIpP0ZV
         t0veeUL5pSbyilI1TmrEvQyjRx9KwRufAZUsN+Pwo6GJSGoRccOUf1l+2gKcOFeDatqI
         /Svg==
X-Forwarded-Encrypted: i=0; AJvYcCUZJwOcO0m8epfebZCwKe/6v2del94SkQMJ8KHQkNKenqXxHiAcCqUYrTBdfdhw8SM29l1aqfIW3m8N6fXAEFBs4BNu3rUcO0EfaD48
X-Gm-Message-State: AOJu0Yx8XWmmBdB7skHWuq2yycr1uGdznSgx02C11Qa/iD5ueUGoA2N9
	zcI7plBUcn6FeX0rGBov1tcJ5q+gT2SUaOtiuVHNvNv1WR8v9MCKH6HVY5F2Jq6Mv0MJM9gS5jj
	8Bix6BEd29bKmyFK1u7HaBDx5ft0=
X-Google-Smtp-Source: AGHT+IErDYoefTwYsWl+oj3VgNhS6W7vgBMPp2AVhj8HRfc7hSQ3tU4b0G/pFN4T2E3Muyl+8CItGNPZg1LtdmK/YTc=
X-Received: by 2002:a05:6820:1c96:b0:59a:bf5:a0da with SMTP id
 ct22-20020a0568201c9600b0059a0bf5a0damr51991oob.0.1706717112759; Wed, 31 Jan
 2024 08:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
 <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
 <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
 <25d3cfd74b26eb6a4aa07f1da93ccf4815b0b1c6.camel@gmail.com>
 <CAJZ5v0hX4Yv7UVng=O4tZyb_O7D2EcymdEDdSUrVDPk6h51VjA@mail.gmail.com>
 <8682d7f7ee1a60902b1f3e5529a4adbaf4846aa0.camel@gmail.com>
 <CAJZ5v0hW60++hhKG=yBE7+rB9qt2m+tO_WAf=YFhNU2-y3VHFw@mail.gmail.com> <9a4b4dd60c35dd4e00b97e19fced0e79a86f6eef.camel@gmail.com>
In-Reply-To: <9a4b4dd60c35dd4e00b97e19fced0e79a86f6eef.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 17:05:01 +0100
Message-ID: <CAJZ5v0hbGF6u5D8iyiziWMceph124wnC6KOH+V9Y2xqQgkZu5g@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links removal
 for dt overlays
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:46=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Wed, 2024-01-31 at 16:10 +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 31, 2024 at 3:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote:
> > >
> > > On Wed, 2024-01-31 at 15:28 +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nu=
no@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote=
:
> > > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > > >
> > > > > > > > For device links, releasing the supplier/consumer devices
> > > > > > > > references
> > > > > > > > happens asynchronously in device_link_release_fn(). Hence, =
the
> > > > > > > > possible
> > > > > > > > release of an of_node is also asynchronous. If these nodes =
were
> > > > > > > > added
> > > > > > > > through overlays we have a problem because this does not re=
spect
> > > > > > > > the
> > > > > > > > devicetree overlays assumptions that when a changeset is
> > > > > > > > being removed in __of_changeset_entry_destroy(), it must ho=
ld the
> > > > > > > > last
> > > > > > > > reference to that node. Due to the async nature of device l=
inks
> > > > > > > > that
> > > > > > > > cannot be guaranteed.
> > > > > > > >
> > > > > > > > Given the above, in case one of the link consumer/supplier =
is part
> > > > > > > > of
> > > > > > > > an overlay node we call directly device_link_release_fn() i=
nstead
> > > > > > > > of
> > > > > > > > queueing it. Yes, it might take some significant time for
> > > > > > > > device_link_release_fn() to complete because of synchronize=
_srcu()
> > > > > > > > but
> > > > > > > > we would need to, anyways, wait for all OF references to be
> > > > > > > > released
> > > > > > > > if
> > > > > > > > we want to respect overlays assumptions.
> > > > > > > >
> > > > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > ---
> > > > > > > > This RFC is a follow up of a previous one that I sent to th=
e
> > > > > > > > devicetree
> > > > > > > > folks [1]. It got rejected because it was not really fixing=
 the
> > > > > > > > root
> > > > > > > > cause of the issue (which I do agree). Please see the link =
where I
> > > > > > > > fully explain what the issue is.
> > > > > > > >
> > > > > > > > I did also some git blaming and did saw that commit
> > > > > > > > 80dd33cf72d1 ("drivers: base: Fix device link removal") int=
roduced
> > > > > > > > queue_work() as we could be releasing the last device refer=
ence
> > > > > > > > and
> > > > > > > > hence
> > > > > > > > sleeping which is against SRCU callback requirements. Howev=
er,
> > > > > > > > that
> > > > > > > > same
> > > > > > > > commit is now making use of synchronize_srcu() which may ta=
ke
> > > > > > > > significant time (and I think that's the reason for the wor=
k
> > > > > > > > item?).
> > > > > > > >
> > > > > > > > However, given the dt overlays requirements, I'm not seeing=
 any
> > > > > > > > reason to not be able to run device_link_release_fn()
> > > > > > > > synchronously if
> > > > > > > > we
> > > > > > > > detect an OVERLAY node is being released. I mean, even if w=
e come
> > > > > > > > up
> > > > > > > > (and I did some experiments in this regard) with some async
> > > > > > > > mechanism
> > > > > > > > to
> > > > > > > > release the OF nodes refcounts, we still need a synchroniza=
tion
> > > > > > > > point
> > > > > > > > somewhere.
> > > > > > > >
> > > > > > > > Anyways, I would like to have some feedback on how acceptab=
le
> > > > > > > > would
> > > > > > > > this
> > > > > > > > be or what else could I do so we can have a "clean" dt over=
lay
> > > > > > > > removal.
> > > > > > > >
> > > > > > > > I'm also including dt folks so they can give some comments =
on the
> > > > > > > > new
> > > > > > > > device_node_overlay_removal() function. My goal is to try t=
o
> > > > > > > > detect
> > > > > > > > when
> > > > > > > > an
> > > > > > > > overlay is being removed (maybe we could even have an expli=
cit
> > > > > > > > flag
> > > > > > > > for
> > > > > > > > it?) and only directly call device_link_release_fn() in tha=
t case.
> > > > > > > >
> > > > > > > > [1]:
> > > > > > > > https://lore.kernel.org/linux-devicetree/20230511151047.177=
9841-1-nuno.sa@analog.com/
> > > > > > > > ---
> > > > > > > >  drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > > > > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > > > index 14d46af40f9a..31ea001f6142 100644
> > > > > > > > --- a/drivers/base/core.c
> > > > > > > > +++ b/drivers/base/core.c
> > > > > > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs=
[] =3D {
> > > > > > > >  };
> > > > > > > >  ATTRIBUTE_GROUPS(devlink);
> > > > > > > >
> > > > > > > > +static bool device_node_overlay_removal(struct device *dev=
)
> > > > > > > > +{
> > > > > > > > +     if (!dev_of_node(dev))
> > > > > > > > +             return false;
> > > > > > > > +     if (!of_node_check_flag(dev->of_node, OF_DETACHED))
> > > > > > > > +             return false;
> > > > > > > > +     if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
> > > > > > > > +             return false;
> > > > > > > > +
> > > > > > > > +     return true;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void device_link_release_fn(struct work_struct *wor=
k)
> > > > > > > >  {
> > > > > > > >       struct device_link *link =3D container_of(work, struc=
t
> > > > > > > > device_link,
> > > > > > > > rm_work);
> > > > > > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct=
 device
> > > > > > > > *dev)
> > > > > > > >        * synchronization in device_link_release_fn() and if=
 the
> > > > > > > > consumer
> > > > > > > > or
> > > > > > > >        * supplier devices get deleted when it runs, so put =
it into
> > > > > > > > the
> > > > > > > > "long"
> > > > > > > >        * workqueue.
> > > > > > > > +      *
> > > > > > > > +      * However, if any of the supplier, consumer nodes is=
 being
> > > > > > > > removed
> > > > > > > > +      * through overlay removal, the expectation in
> > > > > > > > +      * __of_changeset_entry_destroy() is for the node 'kr=
ef' to
> > > > > > > > be 1
> > > > > > > > which
> > > > > > > > +      * cannot be guaranteed with the async nature of
> > > > > > > > +      * device_link_release_fn(). Hence, do it synchronous=
ly for
> > > > > > > > the
> > > > > > > > overlay
> > > > > > > > +      * case.
> > > > > > > >        */
> > > > > > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > > > > > +     if (device_node_overlay_removal(link->consumer) ||
> > > > > > > > +         device_node_overlay_removal(link->supplier))
> > > > > > > > +             device_link_release_fn(&link->rm_work);
> > > > > > > > +     else
> > > > > > > > +             queue_work(system_long_wq, &link->rm_work);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static struct class devlink_class =3D {
> > > > > > > >
> > > > > > > > ---
> >
> > [cut]
> >
> > > > No, IMV devlink_dev_release() needs to be called via
> > > > device_link_put_kref(), but it may run device_link_release_fn()
> > > > directly if the link is marked in a special way or something like
> > > > this.
> > >
> > > Sorry, I'm not totally getting this. I'm directly calling
> > > device_link_release_fn() from  devlink_dev_release(). We should only =
get
> > > into
> > > devlink_dev_release() after all the references are dropped right (bei=
ng it
> > > the
> > > release callback for the link class)?
> >
> > OK, I got confused somehow, sorry.
> >
> > It should work.
> >
> > I kind of don't like adding OF-specific code to the driver core, but
> > if this is fine with Greg, it can be done.  It should depend on
>
> Not perfect but I'm not seeing any other way. We need to somehow see if t=
he node
> is part of an OVERLAY and AFAIK, the only way is looking at the node flag=
s. I'll
> wait on Greg's feedback.
>
> > CONFIG_OF_OVERLAY, though.
>
> I guess that should be already indirectly implied. I mean if CONFIG_OF_OV=
ERLAY
> is not set, I guess there's not way for
> of_node_check_flag(dev->of_node, OF_OVERLAY)) return true. But yeah, I ca=
n bail
> out right away if IS_ENABLED(CONFIG_OF_OVERLAY) is not set.
>
> > I would like a comment to be added to device_link_release_fn() to
> > explain why the overlay case needs synchronous execution in there.
>
> I do have the following comment before checking device_node_overlay_remov=
al():
>
>
> "* However, if any of the supplier, consumer nodes is being removed
>  * through overlay removal, the expectation in
>  * __of_changeset_entry_destroy() is for the node 'kref' to be 1 which
>  * cannot be guaranteed with the async nature of
>  * device_link_release_fn(). Hence, do it synchronously for the overlay
>  * case."
>
> I can elaborate more if you prefer...

No, that should suffice IMV, thanks.

Now that I think of it there is one more possibility: A dedicated
workqueue can be used for running device_link_release_fn() and the DT
overlay code can flush it after the device link deletion.

