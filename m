Return-Path: <linux-kernel+bounces-47504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAF844EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED2429642D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074CB4A26;
	Thu,  1 Feb 2024 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Ep9W07WW"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF4468C;
	Thu,  1 Feb 2024 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751602; cv=none; b=ZFQPVnNYAcGM1fKFlS423gpcxKeoKe04QvhS23VRcXnyck+FWL5Mw4sxVf81iZDwiA1YPzfQV6iG+O/wl4e6gC+2T9kpSMlUwgpqbLQ2lFZ9u7G73iewFf9Mgqdao+xGWQmkORHp0CbEhbhutrWvpWmYTwPp+KujY7MvLn0YeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751602; c=relaxed/simple;
	bh=A1tlK4TCfugZCxh7cLUfiJUk8o8OrnE6yG6ljGcq44Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMzMF+zxNbmVfTvZkjxP2kkcKJRFL+f5/6TcQIOpg/sbg7BZjqYFvlHlW+lY+P2TnDwx9Xx2Qu3VjhcwauxtxK5TQgnPoYdQGnguNWvv0ZV5i7+tRD0cft1vmmWTV8MBzi7fJR0Gttmzv4BHtYqiSudelKfq8MAhLAGX/BDeKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Ep9W07WW; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 5B8EE4661F;
	Thu,  1 Feb 2024 01:39:59 +0000 (UTC)
Date: Wed, 31 Jan 2024 20:39:56 -0500
From: Aren <aren@peacevolution.org>
To: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc: linux-kernel@vger.kernel.org, Miles Alan <m@milesalan.com>, 
	Ondrej Jirman <megi@xff.cz>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] leds: rgb: leds-group-multicolor: allow leds to stay
 on in suspend
Message-ID: <oq4zwh56l5zzhvrrvpqrhhb3ghuo5trnezkxhgb63wquhjkhhx@wajib2nwytxf>
References: <20240128204740.2355092-1-aren@peacevolution.org>
 <05f9c78d-b398-420e-bc0f-fb642e76efdc@traphandler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f9c78d-b398-420e-bc0f-fb642e76efdc@traphandler.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706751599;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=JvMjCBUVrGXFZC2qljDPyvrEKH7rhB/lZvFad/K9Txk=;
	b=Ep9W07WWq+0q3pQf2pSI2/+aGXd0oDYAPpOc0EeqMYqf252JhapEb5w9zLMEeUs4KZ3yji
	stCVVU0MaTX5dwR/RE1fEHviKDdWLsdDPpgiF7HBMbW53oizPQFBHBRb3bkNlWGaymfqhz
	DLknk7eakjbRtcG90+DzjsXfoBxlV5I=

On Wed, Jan 31, 2024 at 08:39:01AM +0100, Jean-Jacques Hiblot wrote:
> 
> 
> On 28/01/2024 21:45, Aren Moynihan wrote:
> > If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
> > shouldn't need to set it here. This makes it possible to use multicolor
> > groups with gpio leds that enable retain-state-suspended in the device
> > tree.
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> > ---
> > 
> >   drivers/leds/rgb/leds-group-multicolor.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
> > index 39f58be32af5..194c6a33640b 100644
> > --- a/drivers/leds/rgb/leds-group-multicolor.c
> > +++ b/drivers/leds/rgb/leds-group-multicolor.c
> > @@ -69,7 +69,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
> >   	struct mc_subled *subled;
> >   	struct leds_multicolor *priv;
> >   	unsigned int max_brightness = 0;
> > -	int i, ret, count = 0;
> > +	int i, ret, count, common_flags = 0;
> 
> count is not initialized anymore. Isn't it a problem ?

Yes, good catch, thanks!

I'm not sure how I missed that when I tested this, I must've gotten
(un)lucky with the value that was in ram before.

 - Aren

> >   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >   	if (!priv)
> > @@ -91,6 +91,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
> >   		if (!priv->monochromatics)
> >   			return -ENOMEM;
> > +		common_flags |= led_cdev->flags;
> >   		priv->monochromatics[count] = led_cdev;
> >   		max_brightness = max(max_brightness, led_cdev->max_brightness);
> > @@ -114,12 +115,15 @@ static int leds_gmc_probe(struct platform_device *pdev)
> >   	/* Initialise the multicolor's LED class device */
> >   	cdev = &priv->mc_cdev.led_cdev;
> > -	cdev->flags = LED_CORE_SUSPENDRESUME;
> >   	cdev->brightness_set_blocking = leds_gmc_set;
> >   	cdev->max_brightness = max_brightness;
> >   	cdev->color = LED_COLOR_ID_MULTI;
> >   	priv->mc_cdev.num_colors = count;
> > +	/* we only need suspend/resume if a sub-led requests it */
> > +	if (common_flags & LED_CORE_SUSPENDRESUME)
> > +		cdev->flags = LED_CORE_SUSPENDRESUME;
> > +
> >   	init_data.fwnode = dev_fwnode(dev);
> >   	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev, &init_data);
> >   	if (ret)

