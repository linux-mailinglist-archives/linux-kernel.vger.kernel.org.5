Return-Path: <linux-kernel+bounces-95516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98946874EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEB2842AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C1129A93;
	Thu,  7 Mar 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WDWhx17d"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4C129A77;
	Thu,  7 Mar 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813799; cv=none; b=IYVQShlJVOTpTb+DkOXd/PUtj+MmMwbBZzk9Sxl6jG7Njegs59RzKNz3qADM55QqeknsvjyKOekEV3f9cjVraLcEba2kTaollSOXHXvs0fGYSStJDz79QrDE01BdNqm/z6fT/TRcJN4AbyzblpRWfSB5rMmOwx28t71gxN8L/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813799; c=relaxed/simple;
	bh=KWgfXMPIGtA9jZVnBTSIrLNOsC7THayA4/vdwyZmhkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0mBQ6VKAw9nl0wMIUDbnxE9WvuC7LzjsGw9HqeDCHwW46qEh5qG2MQq42ikjyY/Vh49KIms7cnf2vgFdun1k1b2pXfT2T4U/5MpbYv8PA2rn0jkV61Xq8+odhpqbWUj/weTz4YyVd7cva4cYLlf/Jzq5zvSAisgvTnJ93OdZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WDWhx17d; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16F7A240009;
	Thu,  7 Mar 2024 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709813787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqBrgQVQ9FvM/GqR9CCaRL1K+LM764H8ixcND3N3l0o=;
	b=WDWhx17dIRtElrHicmsg00kmcnRh5bBcWVMSPwcJUru0HdeHjZXqMsYzvjTChDa/yhvtdk
	X+htnSu9lJmEDRVpSaFmGVWEBpLmElgQkJJqrTJ5To8j3eiau/pb8LYKo6IxI4r1au8T6o
	LVhY2K9htiDEDzZqoVEW1mmQvaH99Y8fFHEfzvDP1712f07iTfslRXOBxPDR9TdxUMd3VA
	94Obpy4t78knc4GoNkNI4SoDpyuCMW4TcrcJ3D/PJUJ1Fz1fONgwwzwiWCGR52TVafim+q
	0N4vWgA+pS9LjOI33KISC8jLoFzMN/fA4JcE9FguGkhW9nS1Y2mDwPjrK+REeg==
Date: Thu, 7 Mar 2024 13:16:23 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/2] driver core: Introduce
 device_link_wait_removal()
Message-ID: <20240307131623.467e1def@bootlin.com>
In-Reply-To: <94997e8720bc0a68afa85be3ef521c8844d0f0a0.camel@gmail.com>
References: <20240307111036.225007-1-herve.codina@bootlin.com>
	<20240307111036.225007-2-herve.codina@bootlin.com>
	<94997e8720bc0a68afa85be3ef521c8844d0f0a0.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Nuno,

On Thu, 07 Mar 2024 12:50:52 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> Hi Herve,
> 
> 
> On Thu, 2024-03-07 at 12:10 +0100, Herve Codina wrote:
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices used
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> > 
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> > 
> > For instance, in the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> > 
> > During the step 1, devices are released and related devlinks are removed
> > (jobs pushed in the workqueue).
> > During the step 2, OF nodes are destroyed but, without any
> > synchronisation with devlink removal jobs, of_overlay_remove() can raise
> > warnings related to missing of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2
> > 
> > Indeed, the missing of_node_put() call is going to be done, too late,
> > from the workqueue job execution.
> > 
> > Introduce device_link_wait_removal() to offer a way to synchronize
> > operations waiting for the end of devlink removals (i.e. end of
> > workqueue jobs).
> > Also, as a flushing operation is done on the workqueue, the workqueue
> > used is moved from a system-wide workqueue to a local one.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  include/linux/device.h |  1 +
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d5f4e4aac09b..48b28c59c592 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> >  static void __fw_devlink_link_to_consumers(struct device *dev);
> >  static bool fw_devlink_drv_reg_done;
> >  static bool fw_devlink_best_effort;
> > +static struct workqueue_struct *device_link_wq;
> >  
> >  /**
> >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *dev)
> >  	/*
> >  	 * It may take a while to complete this work because of the SRCU
> >  	 * synchronization in device_link_release_fn() and if the consumer or
> > -	 * supplier devices get deleted when it runs, so put it into the "long"
> > -	 * workqueue.
> > +	 * supplier devices get deleted when it runs, so put it into the
> > +	 * dedicated workqueue.
> >  	 */
> > -	queue_work(system_long_wq, &link->rm_work);
> > +	queue_work(device_link_wq, &link->rm_work);
> >  }
> >  
> > +/**
> > + * device_link_wait_removal - Wait for ongoing devlink removal jobs to terminate
> > + */
> > +void device_link_wait_removal(void)
> > +{
> > +	/*
> > +	 * devlink removal jobs are queued in the dedicated work queue.
> > +	 * To be sure that all removal jobs are terminated, ensure that any
> > +	 * scheduled work has run to completion.
> > +	 */
> > +	flush_workqueue(device_link_wq);
> > +}
> > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > +
> >  static struct class devlink_class = {
> >  	.name = "devlink",
> >  	.dev_groups = devlink_groups,
> > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> >  	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
> >  	if (!sysfs_dev_char_kobj)
> >  		goto char_kobj_err;
> > +	device_link_wq = alloc_workqueue("device_link_wq", 0, 0);  
> 
> My rb tag was with the assumption this is moved into devlink_class_init(). IIUC,
> Saravana also agreed with that [1]. But it looks like he missed that we are
> allocating the queue in devices_init() and not in devlink_class_init().
> 
> I'm also not sure if this is in line with what Rafael wanted for ccing stable. How do
> we know the next patch depends on this one?
> 
> [1]: https://lore.kernel.org/lkml/CAGETcx_gNWOTsSZMaZu+XU1-5Z60WEcMhw08t4Sn_-YgkCCUmA@mail.gmail.com/
> 

We discussed that point and I understood that you were ok to do that on your
side:
  https://lore.kernel.org/linux-kernel/f42ceee61ddb8b50c347589649d4131476ab5d81.camel@gmail.com/

Sorry if I misunderstood.

I am going to wait for other comments on this current series before re-sending
with our 'Reviewed-by' removed if needed. Let me know.

Best regards,
Hervé

