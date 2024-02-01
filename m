Return-Path: <linux-kernel+bounces-48138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90DC8457DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069ED1C21F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC95B69F;
	Thu,  1 Feb 2024 12:31:18 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AD5CDE1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790677; cv=none; b=FC3GrSmvr0HJqCEqCscmqOU3WZX8Lvh52P8ad9J0MGbA1Z8YOHWHshOm3fd+cx8T4Nw8A18MLR8I6j7CIz30ssSv2cUOipCQZMaXu3x+IozjiY5jHQbd9TWRNRfadX3eqLGE3PNNhtbJpVqBuA0Z+fiqNA26JIbvP+U7Bwbd1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790677; c=relaxed/simple;
	bh=AZcDMiwKwImAHX0D+N+niEHC4vKrEl4BGUr5/jsSz4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHrRt2jMUV6ixvSbtXMqBr/joKpEiixgJX1r4DphmnVR2FUPcg59XOg71S9unR0/Lbe88gsVnUWkLnVO5KKb7ED/xRNmbCBjRcAbYMTANfP5GJPVxhojj4gSi31nEQ21jiZk6evYwiBekCOl+vFKJjKpa4qIDKfDGF9sckmwgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5958d3f2d8aso288067eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706790674; x=1707395474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBAmwJkJOtGWa41Nw8qQgNiPlSfUJMeT7everNxfDNA=;
        b=DwTHUPqxW7I5PtRrnNzaLGKzwiv6H2sJryzPlA6jiUYZgVt80MKW/nxzjIlWtSiEni
         23tlWnJJd+JQwshJdTWNVChrh7AUXyKtn08cdfSZ9EseE6AC+gFzF8iTL1IrL46kQd0R
         pm3RgjFGbG+9ej+5x3YRxZ4dscrRHRcvPj558XFbjM1v0seYKiaOhmIXVoDku898sfv3
         MECbhuTVSah6biaMuwiG/x54oT0ulIrB1mKztEJTZAnnMmyIgEMJAnzXtZN0Ofx0eOL7
         10RgK70CBFOYovEtNrO9x+v2sfyNuFkBCdGHt+ngaPSqPHRryKaOuwnOyiqqZb1MBPHv
         kr+w==
X-Gm-Message-State: AOJu0YyCKq4/UDspcgrvWNgXGbhAf5993nz1sskKTU5lti3UA2iUbFhI
	JlxBUGUQemSbcjEgiN97OVQWvbKsBcin5KeJKzUaqEN18biIYPSUcGlxr0w/uqyUzA4QHL+GFlx
	MRkbQYPcapC/3aIU6dAnyXFjdZBc=
X-Google-Smtp-Source: AGHT+IEO82L7OeoBgzVn3sNkjYC7Tkkt8fj5SrNLDyxRsj/U6farPqwknqfJsSLfuIyvn+uMyE5Z/0odveVO9YjLQgM=
X-Received: by 2002:a05:6820:b90:b0:599:fbcc:1c75 with SMTP id
 eg16-20020a0568200b9000b00599fbcc1c75mr2537951oob.0.1706790674602; Thu, 01
 Feb 2024 04:31:14 -0800 (PST)
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
 <CAJZ5v0hW60++hhKG=yBE7+rB9qt2m+tO_WAf=YFhNU2-y3VHFw@mail.gmail.com>
 <9a4b4dd60c35dd4e00b97e19fced0e79a86f6eef.camel@gmail.com>
 <CAJZ5v0hbGF6u5D8iyiziWMceph124wnC6KOH+V9Y2xqQgkZu5g@mail.gmail.com> <670808962822c7f3be7072f5bcd8cec6536e98bc.camel@gmail.com>
In-Reply-To: <670808962822c7f3be7072f5bcd8cec6536e98bc.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 13:31:02 +0100
Message-ID: <CAJZ5v0iydQhHY8a3t94x1PRbkMJHTqu51cF7YvE-18D+OLjJvg@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links removal
 for dt overlays
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:24=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Wed, 2024-01-31 at 17:05 +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 31, 2024 at 4:46=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote:
> > >
> > > On Wed, 2024-01-31 at 16:10 +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Jan 31, 2024 at 3:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, 2024-01-31 at 15:28 +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Jan 31, 2024 at 3:18=E2=80=AFPM Nuno S=C3=A1 <noname.nu=
no@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2024-01-31 at 14:30 +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Wed, Jan 31, 2024 at 1:20=E2=80=AFPM Nuno S=C3=A1 <nonam=
e.nuno@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay w=
rote:
> > > > > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > > >
> > > > > > > > > > For device links, releasing the supplier/consumer devic=
es
> > > > > > > > > > references
> > > > > > > > > > happens asynchronously in device_link_release_fn(). Hen=
ce, the
> > > > > > > > > > possible
> > > > > > > > > > release of an of_node is also asynchronous. If these no=
des were
> > > > > > > > > > added
> > > > > > > > > > through overlays we have a problem because this does no=
t respect
> > > > > > > > > > the
> > > > > > > > > > devicetree overlays assumptions that when a changeset i=
s
> > > > > > > > > > being removed in __of_changeset_entry_destroy(), it mus=
t hold the
> > > > > > > > > > last
> > > > > > > > > > reference to that node. Due to the async nature of devi=
ce links
> > > > > > > > > > that
> > > > > > > > > > cannot be guaranteed.
> > > > > > > > > >
> > > > > > > > > > Given the above, in case one of the link consumer/suppl=
ier is part
> > > > > > > > > > of
> > > > > > > > > > an overlay node we call directly device_link_release_fn=
() instead
> > > > > > > > > > of
> > > > > > > > > > queueing it. Yes, it might take some significant time f=
or
> > > > > > > > > > device_link_release_fn() to complete because of synchro=
nize_srcu()
> > > > > > > > > > but
> > > > > > > > > > we would need to, anyways, wait for all OF references t=
o be
> > > > > > > > > > released
> > > > > > > > > > if
> > > > > > > > > > we want to respect overlays assumptions.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > > > > > ---
> > > > > > > > > > This RFC is a follow up of a previous one that I sent t=
o the
> > > > > > > > > > devicetree
> > > > > > > > > > folks [1]. It got rejected because it was not really fi=
xing the
> > > > > > > > > > root
> > > > > > > > > > cause of the issue (which I do agree). Please see the l=
ink where I
> > > > > > > > > > fully explain what the issue is.
> > > > > > > > > >
> > > > > > > > > > I did also some git blaming and did saw that commit
> > > > > > > > > > 80dd33cf72d1 ("drivers: base: Fix device link removal")=
 introduced
> > > > > > > > > > queue_work() as we could be releasing the last device r=
eference
> > > > > > > > > > and
> > > > > > > > > > hence
> > > > > > > > > > sleeping which is against SRCU callback requirements. H=
owever,
> > > > > > > > > > that
> > > > > > > > > > same
> > > > > > > > > > commit is now making use of synchronize_srcu() which ma=
y take
> > > > > > > > > > significant time (and I think that's the reason for the=
 work
> > > > > > > > > > item?).
> > > > > > > > > >
> > > > > > > > > > However, given the dt overlays requirements, I'm not se=
eing any
> > > > > > > > > > reason to not be able to run device_link_release_fn()
> > > > > > > > > > synchronously if
> > > > > > > > > > we
> > > > > > > > > > detect an OVERLAY node is being released. I mean, even =
if we come
> > > > > > > > > > up
> > > > > > > > > > (and I did some experiments in this regard) with some a=
sync
> > > > > > > > > > mechanism
> > > > > > > > > > to
> > > > > > > > > > release the OF nodes refcounts, we still need a synchro=
nization
> > > > > > > > > > point
> > > > > > > > > > somewhere.
> > > > > > > > > >
> > > > > > > > > > Anyways, I would like to have some feedback on how acce=
ptable
> > > > > > > > > > would
> > > > > > > > > > this
> > > > > > > > > > be or what else could I do so we can have a "clean" dt =
overlay
> > > > > > > > > > removal.
> > > > > > > > > >
> > > > > > > > > > I'm also including dt folks so they can give some comme=
nts on the
> > > > > > > > > > new
> > > > > > > > > > device_node_overlay_removal() function. My goal is to t=
ry to
> > > > > > > > > > detect
> > > > > > > > > > when
> > > > > > > > > > an
> > > > > > > > > > overlay is being removed (maybe we could even have an e=
xplicit
> > > > > > > > > > flag
> > > > > > > > > > for
> > > > > > > > > > it?) and only directly call device_link_release_fn() in=
 that case.
> > > > > > > > > >
> > > > > > > > > > [1]:
> > > > > > > > > > https://lore.kernel.org/linux-devicetree/20230511151047=
1779841-1-nuno.sa@analog.com/
> > > > > > > > > > ---
> > > > > > > > > >  drivers/base/core.c | 25 ++++++++++++++++++++++++-
> > > > > > > > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > > > > > index 14d46af40f9a..31ea001f6142 100644
> > > > > > > > > > --- a/drivers/base/core.c
> > > > > > > > > > +++ b/drivers/base/core.c
> > > > > > > > > > @@ -497,6 +497,18 @@ static struct attribute *devlink_a=
ttrs[] =3D {
> > > > > > > > > >  };
> > > > > > > > > >  ATTRIBUTE_GROUPS(devlink);
> > > > > > > > > >
> > > > > > > > > > +static bool device_node_overlay_removal(struct device =
*dev)
> > > > > > > > > > +{
> > > > > > > > > > +     if (!dev_of_node(dev))
> > > > > > > > > > +             return false;
> > > > > > > > > > +     if (!of_node_check_flag(dev->of_node, OF_DETACHED=
))
> > > > > > > > > > +             return false;
> > > > > > > > > > +     if (!of_node_check_flag(dev->of_node, OF_OVERLAY)=
)
> > > > > > > > > > +             return false;
> > > > > > > > > > +
> > > > > > > > > > +     return true;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static void device_link_release_fn(struct work_struct =
*work)
> > > > > > > > > >  {
> > > > > > > > > >       struct device_link *link =3D container_of(work, s=
truct
> > > > > > > > > > device_link,
> > > > > > > > > > rm_work);
> > > > > > > > > > @@ -532,8 +544,19 @@ static void devlink_dev_release(st=
ruct device
> > > > > > > > > > *dev)
> > > > > > > > > >        * synchronization in device_link_release_fn() an=
d if the
> > > > > > > > > > consumer
> > > > > > > > > > or
> > > > > > > > > >        * supplier devices get deleted when it runs, so =
put it into
> > > > > > > > > > the
> > > > > > > > > > "long"
> > > > > > > > > >        * workqueue.
> > > > > > > > > > +      *
> > > > > > > > > > +      * However, if any of the supplier, consumer node=
s is being
> > > > > > > > > > removed
> > > > > > > > > > +      * through overlay removal, the expectation in
> > > > > > > > > > +      * __of_changeset_entry_destroy() is for the node=
 'kref' to
> > > > > > > > > > be 1
> > > > > > > > > > which
> > > > > > > > > > +      * cannot be guaranteed with the async nature of
> > > > > > > > > > +      * device_link_release_fn(). Hence, do it synchro=
nously for
> > > > > > > > > > the
> > > > > > > > > > overlay
> > > > > > > > > > +      * case.
> > > > > > > > > >        */
> > > > > > > > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > > > > > > > +     if (device_node_overlay_removal(link->consumer) |=
|
> > > > > > > > > > +         device_node_overlay_removal(link->supplier))
> > > > > > > > > > +             device_link_release_fn(&link->rm_work);
> > > > > > > > > > +     else
> > > > > > > > > > +             queue_work(system_long_wq, &link->rm_work=
);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static struct class devlink_class =3D {
> > > > > > > > > >
> > > > > > > > > > ---
> > > >
> > > > [cut]
> > > >
> > > > > > No, IMV devlink_dev_release() needs to be called via
> > > > > > device_link_put_kref(), but it may run device_link_release_fn()
> > > > > > directly if the link is marked in a special way or something li=
ke
> > > > > > this.
> > > > >
> > > > > Sorry, I'm not totally getting this. I'm directly calling
> > > > > device_link_release_fn() from  devlink_dev_release(). We should o=
nly get
> > > > > into
> > > > > devlink_dev_release() after all the references are dropped right =
(being it
> > > > > the
> > > > > release callback for the link class)?
> > > >
> > > > OK, I got confused somehow, sorry.
> > > >
> > > > It should work.
> > > >
> > > > I kind of don't like adding OF-specific code to the driver core, bu=
t
> > > > if this is fine with Greg, it can be done.  It should depend on
> > >
> > > Not perfect but I'm not seeing any other way. We need to somehow see =
if the node
> > > is part of an OVERLAY and AFAIK, the only way is looking at the node =
flags. I'll
> > > wait on Greg's feedback.
> > >
> > > > CONFIG_OF_OVERLAY, though.
> > >
> > > I guess that should be already indirectly implied. I mean if CONFIG_O=
F_OVERLAY
> > > is not set, I guess there's not way for
> > > of_node_check_flag(dev->of_node, OF_OVERLAY)) return true. But yeah, =
I can bail
> > > out right away if IS_ENABLED(CONFIG_OF_OVERLAY) is not set.
> > >
> > > > I would like a comment to be added to device_link_release_fn() to
> > > > explain why the overlay case needs synchronous execution in there.
> > >
> > > I do have the following comment before checking device_node_overlay_r=
emoval():
> > >
> > >
> > > "* However, if any of the supplier, consumer nodes is being removed
> > >  * through overlay removal, the expectation in
> > >  * __of_changeset_entry_destroy() is for the node 'kref' to be 1 whic=
h
> > >  * cannot be guaranteed with the async nature of
> > >  * device_link_release_fn(). Hence, do it synchronously for the overl=
ay
> > >  * case."
> > >
> > > I can elaborate more if you prefer...
> >
> > No, that should suffice IMV, thanks.
> >
> > Now that I think of it there is one more possibility: A dedicated
> > workqueue can be used for running device_link_release_fn() and the DT
> > overlay code can flush it after the device link deletion.
>
> Hmm, I did some experiments with that but having a work item per kobject =
(being that
> the common thing between of_node and device) but that (even though it wor=
ked) ended
> up being overly complicated.
>
> I think I went with the above because, in theory, you can have DT waiting=
 for
> unrelated releases but that should really be a corner a case. So, if you =
prefer a
> dedicated queue I can give that a try to see how it looks like. Thinking =
in
> allocating a queue (maybe with the same flags as system_long_wq) in:
>
> devlink_class_init()
>
> Then we can have a new fwnode_link_flush_queue() helper to call from DT. =
Naming it
> like this as DT guys might also not like much of having device specific c=
alls in
> there (and fwnode_link) actually fits IMO).
>
> Is it something like this that you have in mind?

Yes, something like this.

