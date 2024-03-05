Return-Path: <linux-kernel+bounces-92147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96026871BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A4C1C219AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522255E54;
	Tue,  5 Mar 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C91det1R"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A660894;
	Tue,  5 Mar 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634436; cv=none; b=Egmasq2nmTJM7jdjSj4UJzsC2a1n+uXQRiqvqIZmCDcC7eBGgA6q+hMXd49LiXqcD/wHzhm61MMO3QZgmafzmeud/wbWy8ffFdLyccQfkV8IpJfBUlX0r4TVshf46YxVbMpM+RPr5PvxjZf0DehHk4FH/nkXuI1O0WJnkf1whl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634436; c=relaxed/simple;
	bh=aKtRAzj53m7Y+xoPzUN+/chlWk+XhhIYKroBoInH6y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEC/6B09bbnKYbaXLMwejiPDGkBud66iJ/uOqjS7BkyZ6EQvAXK4S7+d+G/7BNoohYEcSgyFCUwqBztox0RTL34VpG/Sm2asd8Lx1sgYPvBr7GYg74gMj8uxorLGR3yasGLUmoxpyWgEUUNO6u2HN2/QUUCWyA7pzbWe5deJRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C91det1R; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5703C1C000B;
	Tue,  5 Mar 2024 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709634431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzUNvo9MHvjrK6rTGwUN8794Uo+JOuFFTjF2cKWa2S0=;
	b=C91det1R2rrRSNOy3fH6Cv9d7F+yyc+IaipnsM3DD+twINMGG2bOqfCrXeavFbDfuo3jpS
	lqvydsnjU3Jh+eWNd8EZ7ePEApLYwCcyuaT/EUEPcRYi3aHKsRKwQP27zAXYENlQJqsBX+
	TzN8nnICdmDo2F3bD3uGlIRG+cZtCBVHZLE/tvjK/BpSQYGaLFuNP5SRGcVke4CCpqZB7M
	eeJJwyaGvv4eyn5A7qXAafB4vnddLdjJievk3p5mGbB1hpRRXe6A6gLKupCNuroYnYx4Gr
	4F7E756/rbVY/KK6D+AETvooUlIrcTMXUIcZjRnpyux8mAhNfETSd+bVnjlozA==
Date: Tue, 5 Mar 2024 11:27:08 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Saravana Kannan
 <saravanak@google.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
Message-ID: <20240305112708.56869e4c@bootlin.com>
In-Reply-To: <2f497783da939f13d8c8faeab931cac0ef9c98eb.camel@gmail.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	<20240229105204.720717-3-herve.codina@bootlin.com>
	<acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
	<20240304152202.GA222088-robh@kernel.org>
	<20240304174933.7ad023f9@bootlin.com>
	<CAGETcx-tmyJA30GtdU_dO9tWFoK+rO5tm-On4tPR7oQotnMkqQ@mail.gmail.com>
	<2f497783da939f13d8c8faeab931cac0ef9c98eb.camel@gmail.com>
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

Hi Nuno, Saravana, Rob,

On Tue, 05 Mar 2024 08:36:45 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Mon, 2024-03-04 at 22:47 -0800, Saravana Kannan wrote:
> > On Mon, Mar 4, 2024 at 8:49 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > 
> > > Hi Rob,
> > > 
> > > On Mon, 4 Mar 2024 09:22:02 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > > 
> > > ...
> > >   
> > > > > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> > > > > > overlay_changeset *ovcs)
> > > > > >  {
> > > > > >   int i;
> > > > > > 
> > > > > > + /*
> > > > > > +  * Wait for any ongoing device link removals before removing some of
> > > > > > +  * nodes. Drop the global lock while waiting
> > > > > > +  */
> > > > > > + mutex_unlock(&of_mutex);
> > > > > > + device_link_wait_removal();
> > > > > > + mutex_lock(&of_mutex);  
> > > > > 
> > > > > I'm still not convinced we need to drop the lock. What happens if
> > > > > someone else
> > > > > grabs the lock while we are in device_link_wait_removal()? Can we
> > > > > guarantee that
> > > > > we can't screw things badly?  
> > > > 
> > > > It is also just ugly because it's the callers of
> > > > free_overlay_changeset() that hold the lock and now we're releasing it
> > > > behind their back.
> > > > 
> > > > As device_link_wait_removal() is called before we touch anything, can't
> > > > it be called before we take the lock? And do we need to call it if
> > > > applying the overlay fails?  
> > 
> > Rob,
> > 
> > This[1] scenario Luca reported seems like a reason for the
> > device_link_wait_removal() to be where Herve put it. That example
> > seems reasonable.
> > 
> > [1] - https://lore.kernel.org/all/20231220181627.341e8789@booty/
> >   
> 
> I'm still not totally convinced about that. Why not putting the check right
> before checking the kref in __of_changeset_entry_destroy(). I'll contradict
> myself a bit because this is just theory but if we look at pci_stop_dev(), which
> AFAIU, could be reached from a sysfs write(), we have:
> 
> device_release_driver(&dev->dev);
> ...
> of_pci_remove_node(dev);
> 	of_changeset_revert(np->data);
> 	of_changeset_destroy(np->data);
> 
> So looking at the above we would hit the same issue if we flush the queue in
> free_overlay_changeset() - as the queue won't be flushed at all and we could
> have devlink removal due to device_release_driver(). Right?
> 
> Again, completely theoretical but seems like a reasonable one plus I'm not
> understanding the push against having the flush in
> __of_changeset_entry_destroy(). Conceptually, it looks the best place to me but
> I may be missing some issue in doing it there?

Instead of having the wait called in __of_changeset_entry_destroy() and so
called in a loop. I could move this call in the __of_changeset_entry_destroy()
caller (without any of_mutex lock drop).

So this will look like this:
--- 8< ---
void of_changeset_destroy(struct of_changeset *ocs)
{
	struct of_changeset_entry *ce, *cen;

	device_link_wait_removal();

	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
		__of_changeset_entry_destroy(ce);
}
--- 8< ---

I already tested on my system and it works correctly with
device_link_wait_removal() only called from of_changeset_destroy()
as proposed.

Saravana, Nuno, Rob does it seems ok for you ?

..

> > 
> > In general I hate these kinds of sequences that release a lock and
> > then grab it again quickly. It's not always a bug, but my personal
> > take on that is 90% of these introduce a bug.
> > 
> > Drop the unlock/lock and we'll deal a deadlock if we actually hit one.
> > I'm also fairly certain that device_link_wait_removal() can't trigger
> > something else that can cause an OF overlay change while we are in the
> > middle of one. And like Rob said, I'm not sure this unlock/lock is a
> > good solution for that anyway.  
> 
> Totally agree. Unless we really see a deadlock this is a very bad idea (IMHO).
> Even on the PCI code, it seems to me that we're never destroying a changeset
> from a device/kobj_type release callback. That would be super weird right?

Convinced too.
I will drop the unlock/re-lock sequence in the next iteration of this series.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

