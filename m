Return-Path: <linux-kernel+bounces-46499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6A844095
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F2F281974
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47B7BB10;
	Wed, 31 Jan 2024 13:30:35 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2444C7AE65
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707834; cv=none; b=aQ9ZnVJDeMo4HfrwxaVjZbW0iafJtUQ0G4iDk7xnZYBMEYaDfIVr5POKsfO2oujvqJs6SSwXRR5j6CslD5kGOgxBZvtjBPER4eUzEqNYbM4k04qbolY0Rhv70aq0e0pRa2a19iBx/PpyB8GUlxzqbCM5Oro9pNaB4+3pqz0rUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707834; c=relaxed/simple;
	bh=9MHyl2YuajP1t5RTzvhWTy6pVSz8JSWVNyEoJ3+fI4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2nlUWZOsWimD3zhP6vAr6QdQ30cy4DIh+enaXTgmJQVh3iSRx6DKAaD2j0bF+wL83+1L0n7REA6Tfn2ZPbD3Pe7HolIX4i8t8o5nMfO7U8p7eg5HnBbR+aYtsyg+D1UJSUEOs1CnEfSIy4X1q0mg1ryJlJ9JGt8V2Gf9hWX8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a47232667so291784eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707832; x=1707312632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/rYmxaRyYcbls7DLNAJGNk9JtvKcHEco425CoFE7h8=;
        b=plFz7tEtLt7ImRPvbIu0f4K9z8zBJhGZSeYzxX5f/aCdYh5BnY0oKSoF+CpUs7wHN8
         SQLgYB7e/KdE/+osUnxpjBk5oaFkaSN4eunYXIv9iCM4ltL0z6Cvb7q8JILRrIBUGRrl
         wQ3uAbJPBVEreOJC/FaCRWJq7gAnYPVi8MtpgfjRVjQBv6wf+/l2ZfPCpwVu01VppLes
         ySU05LBtk/mXqBYajzJnveuNlUaDAfRQi3rtpPq5NSDuglQVscCwOOHsw4tyEBCkMgqd
         4t+JSsfIwmwOJGGoHCXwVm7m+36A3KoRlIgOoeH/WhLxvB43TxWwyVK5+5DCeXy1Sy7N
         gzXA==
X-Forwarded-Encrypted: i=0; AJvYcCWfZJxCzvG+JgTBIV/fjSoJBI7Vis6+yu2xGDfplxUkkhxWuf9U8Nqw5jRIeXj4NgVcM+vkSYDiyWtVDRONPRwRjk01BwD7u1ZL9hxy
X-Gm-Message-State: AOJu0YyBHG1ts0+ruT54iOxY2EqKE2Wm9qXBKtZmp8UxQmIRQi6YiTHG
	imQquilKHtEepRbRQSe6aGTlEo5RJmwHUDVg4Nb13pH1gYK7Z7lJe20tqzuyYW7gZ8LbmGLDvYS
	eI3EB8kTqRULA6a5zeO+aHaIzTUk=
X-Google-Smtp-Source: AGHT+IHpOBMRVTnwpVok/4beLIL/TkCN5tTRjeqI9mD9VY7x96Ig05JoGQDYJFpjPA7LLZIuU8QiCdP37ZGvmMGr05Q=
X-Received: by 2002:a05:6820:139:b0:599:9e03:68da with SMTP id
 i25-20020a056820013900b005999e0368damr1536206ood.0.1706707832016; Wed, 31 Jan
 2024 05:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com> <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
In-Reply-To: <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 14:30:20 +0100
Message-ID: <CAJZ5v0gAK9CChRPSx7Lu=BrGQo22q4swpvvN3__wFw68NfqKPA@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links removal
 for dt overlays
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >
> > For device links, releasing the supplier/consumer devices references
> > happens asynchronously in device_link_release_fn(). Hence, the possible
> > release of an of_node is also asynchronous. If these nodes were added
> > through overlays we have a problem because this does not respect the
> > devicetree overlays assumptions that when a changeset is
> > being removed in __of_changeset_entry_destroy(), it must hold the last
> > reference to that node. Due to the async nature of device links that
> > cannot be guaranteed.
> >
> > Given the above, in case one of the link consumer/supplier is part of
> > an overlay node we call directly device_link_release_fn() instead of
> > queueing it. Yes, it might take some significant time for
> > device_link_release_fn() to complete because of synchronize_srcu() but
> > we would need to, anyways, wait for all OF references to be released if
> > we want to respect overlays assumptions.
> >
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > This RFC is a follow up of a previous one that I sent to the devicetree
> > folks [1]. It got rejected because it was not really fixing the root
> > cause of the issue (which I do agree). Please see the link where I
> > fully explain what the issue is.
> >
> > I did also some git blaming and did saw that commit
> > 80dd33cf72d1 ("drivers: base: Fix device link removal") introduced
> > queue_work() as we could be releasing the last device reference and hen=
ce
> > sleeping which is against SRCU callback requirements. However, that sam=
e
> > commit is now making use of synchronize_srcu() which may take
> > significant time (and I think that's the reason for the work item?).
> >
> > However, given the dt overlays requirements, I'm not seeing any
> > reason to not be able to run device_link_release_fn() synchronously if =
we
> > detect an OVERLAY node is being released. I mean, even if we come up
> > (and I did some experiments in this regard) with some async mechanism t=
o
> > release the OF nodes refcounts, we still need a synchronization point
> > somewhere.
> >
> > Anyways, I would like to have some feedback on how acceptable would thi=
s
> > be or what else could I do so we can have a "clean" dt overlay removal.
> >
> > I'm also including dt folks so they can give some comments on the new
> > device_node_overlay_removal() function. My goal is to try to detect whe=
n an
> > overlay is being removed (maybe we could even have an explicit flag for
> > it?) and only directly call device_link_release_fn() in that case.
> >
> > [1]:
> > https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nuno.=
sa@analog.com/
> > ---
> >  drivers/base/core.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 14d46af40f9a..31ea001f6142 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(devlink);
> >
> > +static bool device_node_overlay_removal(struct device *dev)
> > +{
> > +     if (!dev_of_node(dev))
> > +             return false;
> > +     if (!of_node_check_flag(dev->of_node, OF_DETACHED))
> > +             return false;
> > +     if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> >  static void device_link_release_fn(struct work_struct *work)
> >  {
> >       struct device_link *link =3D container_of(work, struct device_lin=
k,
> > rm_work);
> > @@ -532,8 +544,19 @@ static void devlink_dev_release(struct device *dev=
)
> >        * synchronization in device_link_release_fn() and if the consume=
r or
> >        * supplier devices get deleted when it runs, so put it into the
> > "long"
> >        * workqueue.
> > +      *
> > +      * However, if any of the supplier, consumer nodes is being remov=
ed
> > +      * through overlay removal, the expectation in
> > +      * __of_changeset_entry_destroy() is for the node 'kref' to be 1
> > which
> > +      * cannot be guaranteed with the async nature of
> > +      * device_link_release_fn(). Hence, do it synchronously for the
> > overlay
> > +      * case.
> >        */
> > -     queue_work(system_long_wq, &link->rm_work);
> > +     if (device_node_overlay_removal(link->consumer) ||
> > +         device_node_overlay_removal(link->supplier))
> > +             device_link_release_fn(&link->rm_work);
> > +     else
> > +             queue_work(system_long_wq, &link->rm_work);
> >  }
> >
> >  static struct class devlink_class =3D {
> >
> > ---
> > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > change-id: 20240123-fix-device-links-overlays-5422e033a09b
> > --
> >
> > Thanks!
> > - Nuno S=C3=A1
> >
>
> Hi Rafael,
>
> Would be nice to have your feedback on this one or if this is a complete =
nack...
> I think calling device_link_release_fn() synchronously is ok but I might =
be
> completely wrong.

Well, it sounds like you are expecting me to confirm that what you are
doing makes sense, but I cannot do that, because I am not sufficiently
familiar with DT overlays.

You first need to convince yourself that you are not completely wrong.

> +Cc Saravan as he should also be very familiar with device_links and see =
if the
> above fairly simple solution is sane.
>
> I also don't want to be pushy as I know you guys are all very busy but it=
's (i
> think) the third time I resend the patch :)

Sorry about that, I haven't realized that my input is requisite.

So the patch not only calls device_link_release_fn() synchronously,
but it also calls this function directly and I, personally, wouldn't
do at least the latter.

It should be fine to run it synchronously from within
devlink_dev_release(), it will just take time for the SRCU
synchronization, but AFAICS it is not generally safe to run it without
dropping the last reference to the device link.

