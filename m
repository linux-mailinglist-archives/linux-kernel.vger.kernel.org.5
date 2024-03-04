Return-Path: <linux-kernel+bounces-90954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE572870781
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290EC1C21182
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83D4DA1C;
	Mon,  4 Mar 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rcy2SEZ6"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500120323;
	Mon,  4 Mar 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570979; cv=none; b=MIpPqPdKk5XhQmJMf2IE/7NC03n0E26LC7Pw0g8DjDwqRi1GUGjcZlfMZPSv70PJzNI5Tcw6IXOaTJaSSRKx3wlDzhaWXXt7wjwwm8LXJtoy6twOViSOhlp4NbGHa6Aan+VlZdcwiXQXpJWK06Em8M1RVaOoZ0vjgIWOPOrTkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570979; c=relaxed/simple;
	bh=DthIDebhc9oRYRMRr+A3AN2PQCmUqSXLow3JcSS2AFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPNjmnskVwPdasOjiOXKBwOWjj/8a4ZPtgYxpnxLd+1+Og6ClSEgrySD2fN1WZ1UNJM/KrKGL0GUUPlQYF7Hzh+cgeYMHIv2fLCXxS6UVeJFrD0lRW5g+MLA7Ciki+bRfsPtXFlUYyXh6EnHt5vvQxxrG+mXqZdQy8dmME8Bd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rcy2SEZ6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42D621C0005;
	Mon,  4 Mar 2024 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709570975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nFz0hedyTLHASYMUFC14BfBNjbRjwJUmoXNnUghM5I=;
	b=Rcy2SEZ6t1Mu02zbdb+Mh7xqcRqdUDkoyGA7N+WeuN6VIt4goMj5qZh/JLn9U2JCqKkfCf
	2KSfnM92Rkjl5T6+BIHlsPI3Z3/mfWbGbe4NfsnM4rGsB19M1U8SrvI8FFVPtPgUNmxhHX
	Ucwtijg1XCjPB4m9ouUrtruYcUBlbx8qFDeELKaZmRN7kPGPxzstlGt8D6tWsUeY5QXZEg
	XSlXAZ0DGSoiLXrY4Hse1c2d/Bu4pKD0Eo9lwthvJY4Mz7cI8RFrVkvezLqmTIaJMV6BNA
	c3ZklZKOhY96HEoT4+bKnAHD9IhiGqcKpGFpWu3xQhgZSnAZsBvMNZpTYkBS8A==
Date: Mon, 4 Mar 2024 17:49:33 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max
 Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano
 Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, Saravana Kannan
 <saravanak@google.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
Message-ID: <20240304174933.7ad023f9@bootlin.com>
In-Reply-To: <20240304152202.GA222088-robh@kernel.org>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	<20240229105204.720717-3-herve.codina@bootlin.com>
	<acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
	<20240304152202.GA222088-robh@kernel.org>
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

Hi Rob,

On Mon, 4 Mar 2024 09:22:02 -0600
Rob Herring <robh@kernel.org> wrote:

..

> > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> > > overlay_changeset *ovcs)
> > >  {
> > >  	int i;
> > >  
> > > +	/*
> > > +	 * Wait for any ongoing device link removals before removing some of
> > > +	 * nodes. Drop the global lock while waiting
> > > +	 */
> > > +	mutex_unlock(&of_mutex);
> > > +	device_link_wait_removal();
> > > +	mutex_lock(&of_mutex);  
> > 
> > I'm still not convinced we need to drop the lock. What happens if someone else
> > grabs the lock while we are in device_link_wait_removal()? Can we guarantee that
> > we can't screw things badly?  
> 
> It is also just ugly because it's the callers of 
> free_overlay_changeset() that hold the lock and now we're releasing it 
> behind their back.
> 
> As device_link_wait_removal() is called before we touch anything, can't 
> it be called before we take the lock? And do we need to call it if 
> applying the overlay fails?
> 

Indeed, having device_link_wait_removal() is not needed when applying the
overlay fails.

I can call device_link_wait_removal() from the caller of_overlay_remove()
but not before the lock is taken.
We need to call it between __of_changeset_revert_notify() and
free_overlay_changeset() and so, the lock is taken.

This lead to the following sequence:
--- 8< ---
int of_overlay_remove(int *ovcs_id)
{
	...
	mutex_lock(&of_mutex);
	...

	ret = __of_changeset_revert_notify(&ovcs->cset);
	...

	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE);
	...

	mutex_unlock(&of_mutex);
	device_link_wait_removal();
	mutex_lock(&of_mutex);

	free_overlay_changeset(ovcs);
	...
	mutex_unlock(&of_mutex);
	...
}
--- 8< ---

In this sequence, the question is:
Do we need to release the mutex lock while device_link_wait_removal() is
called ?

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

