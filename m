Return-Path: <linux-kernel+bounces-94103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DE873A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DFB28BE61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4F135408;
	Wed,  6 Mar 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Diub9Vs8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62313473B;
	Wed,  6 Mar 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737269; cv=none; b=mkHqAOzMEGbgb/6V4ucK5wjlJVeu9WEhuztTZyDaP4GiiHBwZ7dLtf16m6AisaHmpi6QviV/9DgmVr64OmWdNSgey0emraSjiecw56Ngz0JWUswrO5CuxmRGzr06VhJ2ClLp4LOWpXcaNId3QJwtPELy9mzNclkfpzcizH//090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737269; c=relaxed/simple;
	bh=p5Z3Q6RIYQmwH9W/ZIoGnyeT1rKzJM+Geblbu0rvw84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcpoXrPxbB8hhEvpbvDZZHyjzO/Kd6TSpctHPBJz5J+LrE+YSy4X7J5dbpHAQ8AyjHnqcVPryU5QDxXqj9sbVbrZnHUB25MJEg32KUmA/RnLnPH4tzGxD1PAtrcmbXuv8adyBqChjPWhyL3qMKv7CPjSISnzL01Fd5ojiO/575w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Diub9Vs8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9FCB24000B;
	Wed,  6 Mar 2024 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709737264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+foT+JzMpkZ+qs4nuYW7kwD/p65OO/iMpozXg8yy+i0=;
	b=Diub9Vs89qkCeYZKoSN24ddM/+DA8ul0SaqXYF//ZQRBxJUkRsY3Kl7871YO8yEdagWVST
	p7u8TCrqmlNdmFC4c2eCRQA0nmeHxG2zYsPOGwziJlr/ZXUZ+ubbArZ1qDbvNzdmJBhB2H
	QCi1BCN5waghCny5y8+ZXSm+MsOq2cnahQi3FWLjAFrRQPtWRz4ZxiFW8z3548IibJrpAn
	WApPJLU9Ua5GVTCE8sd3Pzhk4IPynFURL41a2RUdtdTIRy1eh0SWOpBuyC+9XFh2Y6TeLy
	Df/DPuBQGSek/iHHkHkSFXehm3Z4mmSHrHhYrQ2yoP6rl1oH+tasATU5bHvZ/A==
Date: Wed, 6 Mar 2024 16:01:01 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Frank
 Rowand <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] driver core: Introduce
 device_link_wait_removal()
Message-ID: <20240306160101.25b45335@bootlin.com>
In-Reply-To: <86a0f91675197a00bbd921d6e57d2f3c57796e68.camel@gmail.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	<20240306085007.169771-2-herve.codina@bootlin.com>
	<1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
	<CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
	<ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
	<CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
	<ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
	<CAJZ5v0iMUOJmm99H6SgfP9179hBsLdyC+1ixJwBxSP0b18V6XA@mail.gmail.com>
	<86a0f91675197a00bbd921d6e57d2f3c57796e68.camel@gmail.com>
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

On Wed, 06 Mar 2024 15:50:44 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

..
> > > > > 
> > > > > That makes sense but then the only thing I still don't fully get is why
> > > > > we
> > > > > have
> > > > > a separate devlink_class_init() initcall for registering the devlink
> > > > > class
> > > > > (which can also fail)...  
> > > > 
> > > > Well, I haven't added it. :-)
> > > >   
> > > > > What I take from the above is that we should fail the
> > > > > driver model if one of it's fundamental components fails so I would say
> > > > > we
> > > > > should merge devlink_class_init() with device_init() otherwise it's a
> > > > > bit
> > > > > confusing (at least to me) and gives the idea that it's ok for the
> > > > > driver
> > > > > model
> > > > > to exist without the links (unless I'm missing some other reason for the
> > > > > devlink
> > > > > init function).  
> > > > 
> > > > +1
> > > > 
> > > > Feel free to send a patch along these lines, chances are that it will
> > > > be popular. ;-)  
> > > 
> > > I was actually thinking about that but I think I encountered the reason why
> > > we
> > > have it like this... devices_init() is called from driver_init() and there
> > > we
> > > have:
> > > 
> > > ...
> > > 
> > > devices_init();
> > > buses_init();
> > > classes_init();
> > > 
> > > ...
> > > 
> > > So classes are initialized after devices which means we can't really do
> > > class_register(&devlink_class) from devices_init(). Unless, of course, we
> > > re-
> > > order things in driver_init() but that would be a questionable change at the
> > > very least.
> > > 
> > > So, while I agree with what you've said, I'm still not sure if mixing
> > > devlink
> > > stuff between devices_init() and devlink_class_init() is the best thing to
> > > do
> > > given that we already have the case where devlink_class_init() can fail
> > > while
> > > the driver model is up.  
> > 
> > So why don't you make devlink_class_init() do a BUG() on failure
> > instead of returning an error?  IMO crashing early is better than
> > crashing later or otherwise failing in a subtle way due to a missed
> > dependency.  
> 
> Well, I do agree with that... Maybe that's something that Herve can sneak in
> this patch? Otherwise, I can later (after this one is applied) send a patch for
> it.

Well, I don't thing that this have to be part of this current series.
It is an other topic and should be handled out of this current series.

Hervé

