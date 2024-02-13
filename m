Return-Path: <linux-kernel+bounces-63587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC98531D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F711F23C72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3F55C34;
	Tue, 13 Feb 2024 13:26:14 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0B55794;
	Tue, 13 Feb 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830774; cv=none; b=UL47pi05/OTwDEAneaaFi0wIgQZ/YJfNzbZStYa8+9o/Wa8atZ/RxufIEexhyzLF0SrSvhrCDaA/I1jje+g8snEBD5paAJst0yuFGpDx4ZrcUQd17giZwIkz9b5iQxHqnxHqK88FD8XIWOZ79hL3TRQ6I60LjSMKJoOkCCaVdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830774; c=relaxed/simple;
	bh=IMVwaUMIKgLbPZtYISG0lVDxsC9q5IHxqt3EbgePkN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEesNIl5ii0biBkC3QQ4UonYq99LXvdQrnxMN+EyCRzyCXnJ2npRzzQ6bcyEsfG7Xw8vhBxxZ6sdOC88cFqUG7exe9tcbg+jFsE8qgqs9mLepsr4KME1F34XakTeZ0ADIYkVqr2taD561zQcgLtX7545nq/Ifolg4PDfSaWqxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so753929866b.1;
        Tue, 13 Feb 2024 05:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830770; x=1708435570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSWwrZ/GJcDdaONc7v+8jDSkrPt6bx1El6Fj3mB8kz8=;
        b=dCf6WT1+T0tayAURl6c6H7uBetpxIw1iZb6RBjwHqyI44SpuZ8ac6dTQ943E8EBdKu
         jpJDga5kJ5tYly/fujhbaGNeWXafa8MBlhXD+wM+9GrQgyqDdi9qV7KJPASZMH9CxirI
         H/C4r7BwG2uQt5NzVsKfAmMyaKowpfrQ0kiZLM0GDViJtgrD/DkK6gdcwlO9yPUVqaFy
         0wx8Ht6EZIycS0IygMUo5SA70v+v+YGh16xvaSXw0uBX3xrHMkNeTT3uIL+5BSnMZeWb
         2Cgs4lNC6/UCLy/OCDB0JzNZ+yqK6d38286eGyQ6GJ80ZUFCgkpmRXvQx20DJCsCznmU
         RZbg==
X-Forwarded-Encrypted: i=1; AJvYcCUCcqngJq83T25Ekta9lj7z8avlRmRRewl1i8BoZrQbU2/94Vf3kYQLrNzY168jtSFlYRG4dtT2LzmbISxk5Np/d87cVZ/ezdIWzu0dDhuWweadqFKDjE0mc4wNeVSDynrYdUax
X-Gm-Message-State: AOJu0Yxe7mhhkr3nrV1X4LLJxyF/GohQhzoJKfGwgnFGftBwG8YdJohj
	3l5BW3q2us0m4qWBqo1305d/q/NYW6KfTOk8w9gHcik+/+gWEV8U
X-Google-Smtp-Source: AGHT+IEhaCD72Kvg5eKMGqZBOIOG+pGQD2NizQ654e+yDwFTNOXFnygIBSBb/SwLw0XzCPTOBWRTjg==
X-Received: by 2002:a17:906:f0d3:b0:a3c:8de7:3add with SMTP id dk19-20020a170906f0d300b00a3c8de73addmr1942016ejb.7.1707830770221;
        Tue, 13 Feb 2024 05:26:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/pXam7dF5FDnLt+I4eAlfZhyMxRQWXbe24qBP1rAwnGBKFNkvO+UnstcqyFg9rVAmV8MEHuOI+4NBuR/EjFn+oX5L2gT0ceoBynKCKPsbpb4sKwWz7G7DQxW5AoNj7OS7fZpy5VZJE0LrJpfnaGlGOc86f65sfZ+QQxNpreMWDvuh+b15JLUXDmMiaIMXUL48ci1/obTwiyS6erqgqfdoEt1mCrMSC6oM8kecU3fchVlWXAzOIE3lkXmV3KNox2WAlaAR7e/La5Guvoo46zaV1T/SeACueUgT1TFf/bMbEw==
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id tb20-20020a1709078b9400b00a3cf436af4fsm824277ejc.3.2024.02.13.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:26:09 -0800 (PST)
Date: Tue, 13 Feb 2024 05:26:07 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net 6/7] net: fill in MODULE_DESCRIPTION()s for
 mdio_devres
Message-ID: <Zctt74KR4lZ8CeV0@gmail.com>
References: <20240213112122.404045-1-leitao@debian.org>
 <20240213112122.404045-7-leitao@debian.org>
 <045f7cdb-7f99-4182-8c75-097be8a5a7d0@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045f7cdb-7f99-4182-8c75-097be8a5a7d0@lunn.ch>

On Tue, Feb 13, 2024 at 02:19:39PM +0100, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 03:21:21AM -0800, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the PHY MDIO helpers.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/phy/mdio_devres.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
> > index 69b829e6ab35..8921fa22bdbd 100644
> > --- a/drivers/net/phy/mdio_devres.c
> > +++ b/drivers/net/phy/mdio_devres.c
> > @@ -131,4 +131,5 @@ int __devm_of_mdiobus_register(struct device *dev, struct mii_bus *mdio,
> >  EXPORT_SYMBOL(__devm_of_mdiobus_register);
> >  #endif /* CONFIG_OF_MDIO */
> >  
> > +MODULE_DESCRIPTION("Network PHY MDIO devres helpers");
> 
> "Network MDIO bus devres helpers"
> 
> There is nothing PHY related in here, its all mdio bus.

Thanks. I will update!

