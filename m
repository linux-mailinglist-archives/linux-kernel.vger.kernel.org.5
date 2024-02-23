Return-Path: <linux-kernel+bounces-77945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344E860D24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BFB1F294C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFDF19477;
	Fri, 23 Feb 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KkFIPuja"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FE1AAD2;
	Fri, 23 Feb 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677995; cv=none; b=vAyZZ65EkGIX8pEPwkAFo/08JaSOQp/1p3vvcJPcuYb1/U49D+8goqmO6dIie6R0CrspHXjPEOupqvis2SLZivlmd4hYSFtnfpMsfqJP+CpNrnmJdkSNUp4VwZKbp8dYEDjtSs8FpmztTVW3C6e1JPavGMSY4G+p9d8n6HKYnH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677995; c=relaxed/simple;
	bh=Szukh1+JJyIaxGOd3+P6qu0b0nI3hh7a/nMoWy1eW/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUMTQ433cZ+pxjBTcs176+QGT7dWYqCX9fkZt5TG0Dh34HNWhI2WEjWX6Jjlht6U1ayBOhLthLaO7rPcrGo69rHygnfxpx0Xme6duAChAYuvp0xxV9694G/zPmDAed5d+E6c+ARJfv+FUau2cHeoRaTh7CqkmsaFqgbMPZ/QX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KkFIPuja; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E6151BF207;
	Fri, 23 Feb 2024 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708677990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5puhLA25QlRDJIOFw7+qdTuvpy7Tc26KAhJD5jwUiXU=;
	b=KkFIPujaX68p5pvSED2V+otRG1s3yPQB0gWROBjUfcj+xkXXzssdvllP1PaoqrCKUTGGdT
	r1MQjxLXu6H3lKvg0U4Ra+Gf96EdvC74ZoQeLviYJKzvLouKrsYujc1egnCtaNpr2FFLGP
	CYh1yU44uef1GggElY11bV5FSQQFRkNnuf0DlnTibDiIXU2KmwVglDzQ8icMpjyyDP+DU0
	9Q34vg/eXOdxFArlWwwUFi0yldg3qY5JrhB2yntHkiwLd9NvYAS/YuroOT7OKegtNRkUaY
	ympMKmHBoOtyDBIfuPLNRPXrivtQglzGbMoqdUNchajB5VP999w6j8K7svkeTQ==
Date: Fri, 23 Feb 2024 09:46:28 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi
 Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
Message-ID: <20240223094628.340ad536@bootlin.com>
In-Reply-To: <CAGETcx9h4=k9XW+jZCw9zcVZruNZLPDQDt_sNZYXc05eQ2_uWQ@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231130174126.688486-2-herve.codina@bootlin.com>
	<CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
	<c4e1092298244c288212e9f6cdbf7c26d0e9d83b.camel@gmail.com>
	<CAGETcx9h4=k9XW+jZCw9zcVZruNZLPDQDt_sNZYXc05eQ2_uWQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Thu, 22 Feb 2024 17:08:28 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Tue, Feb 20, 2024 at 10:56 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> >
> > On Tue, 2024-02-20 at 16:31 -0800, Saravana Kannan wrote:  
> > > On Thu, Nov 30, 2023 at 9:41 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > introduces a workqueue to release the consumer and supplier devices used
> > > > in the devlink.
> > > > In the job queued, devices are release and in turn, when all the
> > > > references to these devices are dropped, the release function of the
> > > > device itself is called.
> > > >
> > > > Nothing is present to provide some synchronisation with this workqueue
> > > > in order to ensure that all ongoing releasing operations are done and
> > > > so, some other operations can be started safely.
> > > >
> > > > For instance, in the following sequence:
> > > >   1) of_platform_depopulate()
> > > >   2) of_overlay_remove()
> > > >
> > > > During the step 1, devices are released and related devlinks are removed
> > > > (jobs pushed in the workqueue).
> > > > During the step 2, OF nodes are destroyed but, without any
> > > > synchronisation with devlink removal jobs, of_overlay_remove() can raise
> > > > warnings related to missing of_node_put():
> > > >   ERROR: memory leak, expected refcount 1 instead of 2
> > > >
> > > > Indeed, the missing of_node_put() call is going to be done, too late,
> > > > from the workqueue job execution.
> > > >
> > > > Introduce device_link_wait_removal() to offer a way to synchronize
> > > > operations waiting for the end of devlink removals (i.e. end of
> > > > workqueue jobs).
> > > > Also, as a flushing operation is done on the workqueue, the workqueue
> > > > used is moved from a system-wide workqueue to a local one.  
> > >
> > > Thanks for the bug report and fix. Sorry again about the delay in
> > > reviewing the changes.
> > >
> > > Please add Fixes tag for 80dd33cf72d1.
> > >  
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > > >  include/linux/device.h |  1 +
> > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index ac026187ac6a..2e102a77758c 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > >  static void __fw_devlink_link_to_consumers(struct device *dev);
> > > >  static bool fw_devlink_drv_reg_done;
> > > >  static bool fw_devlink_best_effort;
> > > > +static struct workqueue_struct *fw_devlink_wq;
> > > >
> > > >  /**
> > > >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > > > @@ -530,12 +531,26 @@ static void devlink_dev_release(struct device *dev)
> > > >         /*
> > > >          * It may take a while to complete this work because of the SRCU
> > > >          * synchronization in device_link_release_fn() and if the consumer or
> > > > -        * supplier devices get deleted when it runs, so put it into the "long"
> > > > -        * workqueue.
> > > > +        * supplier devices get deleted when it runs, so put it into the
> > > > +        * dedicated workqueue.
> > > >          */
> > > > -       queue_work(system_long_wq, &link->rm_work);
> > > > +       queue_work(fw_devlink_wq, &link->rm_work);  
> > >
> > > This has nothing to do with fw_devlink. fw_devlink is just triggering
> > > the issue in device links. You can hit this bug without fw_devlink too.
> > > So call this device_link_wq since it's consistent with device_link_* APIs.
> > >  
> >
> > I'm not sure if I got this right in my series. I do call devlink_release_queue() to
> > my queue. But on the Overlay side I use fwnode_links_flush_queue() because it looked
> > more sensible from an OF point of view. And including (in OF code) linux/fwnode.h
> > instead linux/device.h makes more sense to me.
> >  
> > > >  }
> > > >
> > > > +/**
> > > > + * device_link_wait_removal - Wait for ongoing devlink removal jobs to terminate
> > > > + */
> > > > +void device_link_wait_removal(void)
> > > > +{
> > > > +       /*
> > > > +        * devlink removal jobs are queued in the dedicated work queue.
> > > > +        * To be sure that all removal jobs are terminated, ensure that any
> > > > +        * scheduled work has run to completion.
> > > > +        */
> > > > +       drain_workqueue(fw_devlink_wq);  
> > >
> > > Is there a reason this needs to be drain_workqueu() instead of
> > > flush_workqueue(). Drain is a stronger guarantee than we need in this
> > > case. All we are trying to make sure is that all the device link
> > > remove work queued so far have completed.
> > >  
> >
> > Yeah, I'm also using flush_workqueue().
> >  
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > +
> > > >  static struct class devlink_class = {
> > > >         .name = "devlink",
> > > >         .dev_groups = devlink_groups,
> > > > @@ -4085,9 +4100,14 @@ int __init devices_init(void)
> > > >         sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
> > > >         if (!sysfs_dev_char_kobj)
> > > >                 goto char_kobj_err;
> > > > +       fw_devlink_wq = alloc_workqueue("fw_devlink_wq", 0, 0);
> > > > +       if (!fw_devlink_wq)  
> > >
> > > Fix the name appropriately here too please.  
> >
> > Hi Saravana,
> >
> > Oh, was not aware of this series... Please look at my first patch. It already has a
> > review tag by Rafael. I think the creation of the queue makes more sense to be done
> > in devlink_class_init(). Moreover, Rafael complained in my first version that
> > erroring out because we failed to create the queue is too harsh since devlinks can
> > still work.  
> 
> I think Rafael can be convinced on this one. Firstly, if we fail to
> allocate so early, we have bigger problems.
> 
> > So, what we do is to schedule the work if we have a queue or too call
> > device_link_release_fn() synchronously if we don't have the queue (note that failing
> > to allocate the queue is very unlikely anyways).  
> 
> device links don't really work when you synchronously need to delete a
> link since it always uses SRCUs (it used to have a #ifndef CONFIG_SRCU
> locking). That's like saying a code still works when it doesn't hit a
> deadlock condition.
> 
> Let's stick with Herve's patch series since he send it first and it
> has fewer things that need to be fixed. If he ignores this thread for
> too long, you can send a revision of yours again and we can accept
> that.

I don't ignore the thread :)

Hope I could take some time in the near future to send a v2 of this
series.

Hervé

