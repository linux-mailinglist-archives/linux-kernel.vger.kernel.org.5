Return-Path: <linux-kernel+bounces-158976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E388B27A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A007B20CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790314EC51;
	Thu, 25 Apr 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYeRQ5vz"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB743BBE6;
	Thu, 25 Apr 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066445; cv=none; b=gYRCF75dt8al89K48j3anw88tWxTTUnWltJ7So30jf9eAIhWhmUxl7p1uTOXW47GFzRMHSlQXBB1X82k/jbqSa/3iaxYMl0t5DkBqEeX2viKg7VaAgycw8yTYht6uNYojJuJNIvarGDhkl3+g1ROK0WOxOSHFXQnhnGnE51heqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066445; c=relaxed/simple;
	bh=mFHENVV6vhpMmnZt9+RJELuGt+rY1L4LZMOqsl7ey08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1kz83Q3OSGNE8G4RIqUZFIEyUWdzkKlU1pEwY6gy0XHJElWGmQ6uy68cigLJ8w4F4/Xq9iCTyHSgZvuLzWHBfFmkJC+YVuGzMIfDvFK/AkBdPjXtzbeHyV5KmFz460WQyfjNlrJgeyT6rY1gqlnnIFgvMTZ9MjgL1v+4lUobLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYeRQ5vz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5883518135so145185666b.3;
        Thu, 25 Apr 2024 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714066441; x=1714671241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo50ytJ6ZK8+zpSoUQ2gQuHrRRP6s/CTdF/t7IzIcyc=;
        b=mYeRQ5vzXJoJ69PtnQCqCW4YgFAfpykC5rW9jws97iXgq1Or6e7ZVMtwB0+KclGYN2
         6FDdgwfOEcaG68O7lHrRJYU1sz2ObvahnyW+qCyiOvqsTuqsrdFl0AOx1BjXgGpK7CaY
         CDQ9/WKXUkyuRI4qt/9bQtiXcIcXvOCM7KUf6T2LYTFTBgJ3OR5Bq6Bw+meE2bTDs0Vm
         RLhGta8lJrtwdIRKmRkbl/yQ//CCvRnIaJw+nx1n+Z+N9itM4TZ+/W08BA+V3KR/K2Ll
         LkHQs9AEKgPIGLcS6NRvLAYhq8/4w3MCEIVbBGb6HjUoNq0rumHT+q9GsA568sx7kvhk
         OxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714066441; x=1714671241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo50ytJ6ZK8+zpSoUQ2gQuHrRRP6s/CTdF/t7IzIcyc=;
        b=q5HwPojQa5MU1W/Xk4MzhFwDIgulihKJQiRpXMvt9tZETfle2tVYy9dhwJaweGz2fF
         b70TmRH0WRloerHYu7USpLJtTJU/X1Zh4pykw9exe/a4lG8MA3BJKFvHN0I72sARQ/+j
         SRRNK5HhZ0C/azSYMiZDMFkGTYxe7VL134sdYlfSSxPEvcSTwR6ayAsxM6aSsyC5kokS
         jIi+AeIGcaT+JKTPGV3+JSRcSQ6/KyrwAL9jYiXFHIWAUr1CeHLBJNbWd/S+BezxnjcO
         ROQz6kMtgTWqjJUzDM+1m0XP7phGsrpgLryLnZMvdD4qd8LdgTeyhBHtAqzStQpJw7EV
         VihQ==
X-Forwarded-Encrypted: i=1; AJvYcCUViTfCP1HYpkY7Ejxu3bSvbBkH4zCm4czC9YBBOTrL7Dour/xjal0KXO60FaAxlUNeO1vNxqFIJWCU1+4oG1ogWh8DTe44qGs0qFq5depVgTOmLgCBpRxjsFQsITTIpddRdqQypFyOfgmUAEWu/AS+9KQtIiwXagzBWSp5pppjTg==
X-Gm-Message-State: AOJu0YyrOZAYtGdfXPtgpdKUvVVZdHZh7S9PJ0k7NC4UkyOeYZTiF6xP
	e/Wgh0HMVf7UOsqv1qV3GZ56JeodN7nKcJSz11OuB7n9TOUjoWJV
X-Google-Smtp-Source: AGHT+IEmDItiAhHInVlm2t4+GhLVyfRh9JVcxAOxRoJNRewZGhelNZ44VMfOOqWxYRhRImmfWz4TrA==
X-Received: by 2002:a17:906:6ad3:b0:a58:9a74:5e6d with SMTP id q19-20020a1709066ad300b00a589a745e6dmr313324ejs.11.1714066441426;
        Thu, 25 Apr 2024 10:34:01 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:aab0:e3cb:ca44:d27])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090624d400b00a5575cde7cdsm9410001ejb.220.2024.04.25.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:34:00 -0700 (PDT)
Date: Thu, 25 Apr 2024 19:33:59 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <ZiqUB0lwgw7vIozG@eichest-laptop>
References: <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>

On Thu, Apr 25, 2024 at 05:30:50PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 25, 2024 at 05:51:57PM +0200, Stefan Eichenberger wrote:
> > On Thu, Apr 25, 2024 at 03:30:52PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Apr 25, 2024 at 01:24:51PM +0200, Stefan Eichenberger wrote:
> > > > I think it should also work for mvneta, at least
> > > > the code looks almost the same. I get the following for the Port
> > > > Auto-Negotiation Configuration Register:
> > > > 
> > > > For 1Gbit/s it switches to SGMII and enables inband AN:
> > > > Memory mapped at address 0xffffa0112000.
> > > > Value at address 0xF2132E0C (0xffffa0112e0c): 0xB0C6
> > > 
> > > So here the link is forced up which is wrong for inband, because then
> > > we have no way to detect the link going down.
> > 
> > Yes I also saw this and didn't understand it. When I clear the force bit
> > it will be set back to 1 again when AN is enabled. I thought this might
> > be a bug of the controller.
> 
> No it isn't, the hardware never changes the value in this register.
> The difference will be because of what I explained previously.
> 
> Because the mvneta and mvpp2 hardware is "weird" in that these two
> registers provide both PCS and MAC functions, we have to deal with
> them in a way that is split between the phylink PCS and MAC
> operations.
> 
> This code was written at a time when all we had was MLO_AN_* and
> none of the PHYLINK_PCS_NEG_* stuff. PCSes got passed the MLO_AN_*
> constants which were the same as what was passed via the MAC
> operations. This made the implementation entirely consistent.
> 
> However, that lead PCS implementers to go off and do their own
> things, so we ended up with a range of different PCS behaviours
> depending on the implementation (because the way people interpreted
> MLO_AN_INBAND, interface mode, and the Autoneg bit in the advertising
> mask was all different.
> 
> So to bring some consistency, I changed the PCS interface to what we
> have now, in the belief that it would later allow us to solve the
> 2500base-X problem.
> 
> However, I'd forgotten about the mvneta/mvpp2 details, but that was
> fine at the time of this change because everything was still
> consistent - we would only ever use PHYLINK_PCS_NEG_OUTBAND or
> PHYLINK_PCS_NEG_NONE for non-MLO_AN_INBAND modes, and
> PHYLINK_PCS_NEG_INBAND_* for interface modes that support inband
> when using MLO_AN_INBAND.
> 
> Now, when trying to solve the 2500base-X problem which needs us to
> use PHYLINK_PCS_NEG_OUTBAND in some situations, this means we can
> end up with MLO_AN_INBAND + PHYLINK_PCS_NEG_OUTBAND, and this is
> what is causing me problems (the link isn't forced up.)
> 
> Conversely, I suspect you have the situation where you have MLO_AN_PHY
> or MLO_AN_FIXED being passed to the mac_config() and mac_link_up()
> operations, but the PCS is being configured for a different mode.
> 
> I am wondering whether we should at the very least move the
> configuration of the control register 0 and 2 to the pcs_config()
> method so at least that's consistent with the PHYLINK_PCS_NEG_*
> value passed to the PCS and thus the values programmed into the
> autoneg config register. However, that still leaves a big hole in
> how we handle the link forcing - which is necessary if inband AN
> is disabled (in other words, if we need to read the link status
> from the PHY as is done in MLO_AN_PHY mode.)
> 

Now I got it, thanks a lot for the explanation. So the issue is that
MLO_AN_INBAND + PHYLINK_PCS_NEG_OUTBAND is happening in my use case and
therefore the link is not forced up because for that MLO_AN_PHY would be
needed. I will also try to think about it.

Thanks,
Stefan



