Return-Path: <linux-kernel+bounces-83776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD31869E58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE01C235A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB74EB4A;
	Tue, 27 Feb 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j8zkpGOh"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8014E1DD;
	Tue, 27 Feb 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056450; cv=none; b=B2ytG3VCa5q90C6mYi7RHlKPc3j7Dqc32eiuRlOUvLwWfrlZkHRgEhn6zgolWhhYKXccbfk0csCwQLp+jD53N/SHxMdR2aQqxyjZUd7iq3uGObQWWsGchBYBu6nmJwdnaDFXZuOnPBQR/mjwrCYtAUUhwMTqGtzOJ7n+maEj41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056450; c=relaxed/simple;
	bh=1etYNDmLTWxNyg10zfJWNbs2cfMwZwiwQn+hYpS/F+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g76QOGph1M7G/+CuIQs8zOMEGgX8DPWpgOJjuu44Rnck1lTUugwZ6FXjWHIuBYWIooBoq9FHUOmMVxIG0ZzVeL8GYX5tAFTP2vVUbt6VHYckC1Gv3xhDBkUpHSLSfvTd7Monrf1vnk8K1LKkvESoC43uRkx2XoMPFw8sJXVATjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j8zkpGOh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2071E000B;
	Tue, 27 Feb 2024 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709056444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21cuP1kPkHgR667NVftezAjAjOqX7I5o+V+rsAaRLm8=;
	b=j8zkpGOhPoabixKtsBz4NwB8zrF8LSq98jzjlfJDYVLRQk5g4KdhPQ3rNj5koxQ0eU5ZMa
	C6hpiGriiyg0c926yW3Wsu5MlBaHQortZ83A9jDgtQ962j9nyQebonjxrH2dky5jNNczzt
	IbDWEKPMaWkZM3nEDDOimLvhoGvLbujKx19P+PiWawGRiNMLmd7XE7rVHuQAVM+/jSxWU3
	ZnrDBR1NKYMQK4au/qJbGtKTU8O7RKhMm8sj5TRsZSWdKN8TktBfaHc9M0dotj5votzekZ
	4iHz6BNY8c76T4iVTkz0BZ7LrL+Ppx5JqQMROVNF2/7RtINNGipd7DTclxnfYA==
Date: Tue, 27 Feb 2024 18:54:02 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Saravana Kannan  <saravanak@google.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Nuno Sa  <nuno.sa@analog.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
Message-ID: <20240227185402.57a3b924@bootlin.com>
In-Reply-To: <86f2262d059db84070745e299d96dde3e6078220.camel@gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231130174126.688486-3-herve.codina@bootlin.com>
	<CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
	<20240227162422.76a00f11@bootlin.com>
	<86f2262d059db84070745e299d96dde3e6078220.camel@gmail.com>
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

On Tue, 27 Feb 2024 17:55:07 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Tue, 2024-02-27 at 16:24 +0100, Herve Codina wrote:
> > Hi Saravana, Luca, Nuno,
> > 
> > On Tue, 20 Feb 2024 16:37:05 -0800
> > Saravana Kannan <saravanak@google.com> wrote:
> > 
> > ...
> >   
> > > > 
> > > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > > index a9a292d6d59b..5c5f808b163e 100644
> > > > --- a/drivers/of/overlay.c
> > > > +++ b/drivers/of/overlay.c
> > > > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > > >                 goto out;
> > > >         }
> > > > 
> > > > +       /*
> > > > +        * Wait for any ongoing device link removals before removing some of
> > > > +        * nodes
> > > > +        */
> > > > +       device_link_wait_removal();
> > > > +    
> > > 
> > > Nuno in his patch[1] had this "wait" happen inside
> > > __of_changeset_entry_destroy(). Which seems to be necessary to not hit
> > > the issue that Luca reported[2] in this patch series. Is there any
> > > problem with doing that?
> > > 
> > > Luca for some reason did a unlock/lock(of_mutex) in his test patch and
> > > I don't think that's necessary.  
> > 
> > I think the unlock/lock in Luca's case and so in Nuno's case is needed.
> > 
> > I do the device_link_wait_removal() wihout having the of_mutex locked.
> > 
> > Now, suppose I do the device_link_wait_removal() call with the of_mutex locked.
> > The following flow is allowed and a deadlock is present.
> > 
> > of_overlay_remove()
> >   lock(of_mutex)
> >      device_link_wait_removal()
> > 
> > And, from the workqueue jobs execution:
> >   ...
> >     device_put()
> >       some_driver->remove()
> >         of_overlay_remove() <--- The job will never end.
> >                                  It is waiting for of_mutex.
> >                                  Deadlock
> >   
> 
> We may need some input from Saravana (and others) on this. I might be missing
> something but can a put_device() lead into a driver remove callback? Driver code is
> not device code and put_device() leads to device_release() which will either call the
> device ->release(), ->type->release() or the class ->dev_release(). And, IMO, calling
> of_overlay_remove() or something like that (like something that would lead to
> unbinding a device from it's driver) in a device release callback would be at the
> very least very questionable. Typically, what you see in there is of_node_put() and
> things like kfree() of the device itself or any other data.

I think that calling of_overlay_remove() in a device release callback makes
sense. The overlay is used to declare sub-nodes from the device node. It
does not add/remove the device node itself but sub-nodes.

The use case is the use of DT overlays to describe PCI devices.
https://lore.kernel.org/all/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/
https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
--- 8< ---
The lan966x SoCs can be used in two different ways:

 - It can run Linux by itself, on ARM64 cores included in the SoC. This
   use-case of the lan966x is currently being upstreamed, using a
   traditional Device Tree representation of the lan996x HW blocks [1]
   A number of drivers for the different IPs of the SoC have already
   been merged in upstream Linux.

 - It can be used as a PCIe endpoint, connected to a separate platform
   that acts as the PCIe root complex. In this case, all the devices
   that are embedded on this SoC are exposed through PCIe BARs and the
   ARM64 cores of the SoC are not used. Since this is a PCIe card, it
   can be plugged on any platform, of any architecture supporting PCIe.
--- 8< ---

This quite long story led to DT overlay support for PCI devices and so the
unittest I mentioned:
  https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/of/unittest.c#L3946


So, I have a PCI driver that bind to the lan966x PCI board.
This driver loads an overlay at probe() and unload it at remove().
Also, this driver can be module. A simple rmmod leads to the remove() call.

This driver is not yet upstream because I haven't yet fixed all the issues I
encountered that's why of now, I can point only the unittest related to overlay
support for PCI.

> 
> The driver remove callback should be called when unbinding the device from it's
> drivers and devlinks should also be removed after device_unbind_cleanup() (i.e, after
> the driver remove callback).
> 
> Having said the above, the driver core has lots of subtleties so, again, I can be
> missing something. But at this point I'm still not seeing any deadlock...
> 

I gave a wrong example.
Based on Luca's sequence he gave in
  https://lore.kernel.org/all/20231220181627.341e8789@booty/

We can have the following: 

--- 8< ---
int of_overlay_remove(int *ovcs_id)
{
    ...

    device_link_wait_removal(); // proposed by this patch series

    mutex_lock(&of_mutex);

    ...

    ret = __of_changeset_revert_notify(&ovcs->cset);
    // this ends up calling (excerpt from a long stack trace):
    // -> of_i2c_notify
    // -> device_remove
    // -> devm_regulator_release
    // -> device_link_remove
    // -> devlink_dev_release, which queues work for
    //      device_link_release_fn, which in turn calls:
    //      -> device_put
    //      -> device_release
    //      -> {platform,regulator,...}_dev*_release
    //      -> of_node_put() [**]

    ...

    free_overlay_changeset(ovcs);
    // calls:
    // -> of_changeset_destroy
    // -> __of_changeset_entry_destroy
    // -> pr_err("ERROR: memory leak, expected refcount 1 instead of %d...
    // The error appears or not, based on when the workqueue runs

err_unlock:
    mutex_unlock(&of_mutex);

    ...
}
--- 8< ---

I think, on your side, you can have something similar.
I was wrong (sorry for my mistake). the problem is not device_put() but
device_remove().

In my deadlog example, s/device_put()/device_remove()/

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

