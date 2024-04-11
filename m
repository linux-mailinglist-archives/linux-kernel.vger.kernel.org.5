Return-Path: <linux-kernel+bounces-139699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157C8A069D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1580C287C64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA03713BAD0;
	Thu, 11 Apr 2024 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/9uXAvF"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087A23BF;
	Thu, 11 Apr 2024 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805503; cv=none; b=BhZCf+B3Ymls6g9cAIU0j5+KAIv8TcTQiDf5Uveu6Oc1FDMmZnlifUoOftKwMnmmqgg/6pl/d1euYSHs6J4AJTx2tBM3dVSg6oHRO0YDyMO8NIQwePWH9e5DW+ric5W8+RHnlT23eHpZ4OopF9wHyK8P4jFkAbrrrX8bLBc0RtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805503; c=relaxed/simple;
	bh=+7xkEcW33wSX8+FnWZmFFTo2qPCMzT+q4+dusj3+wc0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=reLim9ryfIoRiMTz2vcgQ5Ut4Xylggn/uuAoVklUqQWjZ9sNdOxaeVnva0BUJ/U3Fiz3PMNcM33mCrGmgsaNe/7kAR3p/g+QnRJcuke8GeZ00cw+PzhbO7Phq3feNQvkFRgYuQBRNSYR1y8OaXJxjXi5lPWWZwgCyyW6l/0Dc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/9uXAvF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78ebc7e1586so47731585a.1;
        Wed, 10 Apr 2024 20:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712805500; x=1713410300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g85EQHmsQg7ae69eB1wDElQi/dut+TsAUohIEriB58E=;
        b=c/9uXAvFW9Dy1FDd/2zLbfj/ksA77OIDf+jLBFv48yBI4Fko/zf4tCg9VbDPh2njM0
         D7G/PoaZh4QwYMqiqQtNV50JTHtyMnzKlklQziV/wLBAw9k+BsYW0sLwgK4DSq08Y13T
         7jXFzHjR7zXLDqYhrzTW33+hLkszDZtVvGGGxc4MD7GLGdLyLXbAOTqjEh/wugoJBa3e
         d10MrsJljm3264pu6xMoQf+SFjrhjnkuphp2d7u50pMAocuCsWdDTCEk8csnxjRfvVYl
         Vi3O1mSgWDDY6oxxQqp8/vOXgKrTS4exMYEII2+altWq1UOHyPTo3nETE1YODOKKOvRI
         6kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712805500; x=1713410300;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g85EQHmsQg7ae69eB1wDElQi/dut+TsAUohIEriB58E=;
        b=g3BkUdRxLuUiaOlYqNsSXAuBxoFl/ha3msk8P46txZm3Yx/hDWVEvfaMvhaKuSMn+g
         K5FSFM/1W3QVSDH2b6mx0WVZQR48uzbRCASUQEcdGlFBQIxnrerCUJboXIoGVM9zjSad
         045vI92FPnvqE9G8Jo7RxGHKhTj0i0wGbJ2UyVbSVWOaw5KS10bwd2DUxknWBmiipd9a
         rh7aaz2Z3AywUeUaoZ2YNinl9PMdHriW8w+36r87K1yjhpyZMaWa2r4+6qUW2vfxJmF4
         lCUs+ajkzbxHXGoeHMBJKufRbhhIDAGQdXy7rY+1LrN9lPnNOimWAwyY9Yyeo5bRHyZj
         nvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjt6W4ycQz6pxngWDy7KsaPrLgzNtuudaPrMMM9TqKxvtagfqhnsFMAokEDkWa+J1Oantw+IZwZ2+Q6MuclXFlVcDQYQtuYLtX1uMBltk+7bPrU2qtwTcOXqErtVusUcfCxRsVFLZFShL4t+amFOOyNJS7LCl1Y9/U6FSDKy2X
X-Gm-Message-State: AOJu0Yz1v+9ziryATpSlMweYLhGFYhm/tJx+NwBH4HcD5qX3swXFImhF
	H6wwIyzA5d6JRgwP4jMAb15HGuaKjmQ6kJDpNkBfWLKJRAhjd3CR
X-Google-Smtp-Source: AGHT+IH1QUIND02+HLkiS/nJ9FDDhSSNnMYuzw5KqYTpYmz54PSQ23FPhAPmZJROgTolMh3L0ybN7g==
X-Received: by 2002:ae9:e301:0:b0:78d:781c:d9f8 with SMTP id v1-20020ae9e301000000b0078d781cd9f8mr2562445qkf.25.1712805500334;
        Wed, 10 Apr 2024 20:18:20 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a124e00b0078d631f35c2sm437869qkl.24.2024.04.10.20.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 20:18:20 -0700 (PDT)
Date: Wed, 10 Apr 2024 23:18:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, 
 Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
Message-ID: <6617567bd4da7_2dcc3c294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <66175265992c8_2d6bc6294d8@willemb.c.googlers.com.notmuch>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
 <20240409-feature_ptp_netnext-v10-8-0fa2ea5c89a9@bootlin.com>
 <66175265992c8_2d6bc6294d8@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next v10 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Kory Maincent wrote:
> > Prepare for future hardware timestamp selection by adding source and
> > corresponding pointers to ptp_clock structure. Additionally, introduce
> > helpers for registering specific phydev or netdev PTP clocks, retrieving
> > PTP clock information such as hwtstamp source or phydev/netdev pointers,
> > and obtaining the ptp_clock structure from the phc index.
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > 
> > Change in v8:
> > - New patch.
> > 
> > Change in v10:
> > - Add get and put function to avoid unregistering a ptp clock object used.
> > - Fix kdoc issues.
> > ---
> >  drivers/ptp/ptp_clock.c          | 114 +++++++++++++++++++++++++++++++++++++++
> >  drivers/ptp/ptp_private.h        |   5 ++
> >  include/linux/ptp_clock_kernel.h | 104 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 223 insertions(+)
> > 
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index c56cd0f63909..f962f460ec9d 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -512,6 +512,120 @@ void ptp_cancel_worker_sync(struct ptp_clock *ptp)
> >  }
> >  EXPORT_SYMBOL(ptp_cancel_worker_sync);
> >  
> > +struct ptp_clock *netdev_ptp_clock_register(struct ptp_clock_info *info,
> > +					    struct net_device *dev)
> > +{
> > +	struct ptp_clock *ptp;
> > +
> > +	ptp = ptp_clock_register(info, &dev->dev);
> > +	if (IS_ERR(ptp))
> > +		return ptp;
> > +
> > +	ptp->phc_source = HWTSTAMP_SOURCE_NETDEV;
> > +	ptp->netdev = dev;
> > +
> > +	return ptp;
> > +}
> > +EXPORT_SYMBOL(netdev_ptp_clock_register);
> > +
> > +struct ptp_clock *phydev_ptp_clock_register(struct ptp_clock_info *info,
> > +					    struct phy_device *phydev)
> > +{
> > +	struct ptp_clock *ptp;
> > +
> > +	ptp = ptp_clock_register(info, &phydev->mdio.dev);
> > +	if (IS_ERR(ptp))
> > +		return ptp;
> > +
> > +	ptp->phc_source = HWTSTAMP_SOURCE_PHYLIB;
> > +	ptp->phydev = phydev;
> > +
> > +	return ptp;
> > +}
> > +EXPORT_SYMBOL(phydev_ptp_clock_register);
> > +
> > +bool ptp_clock_from_phylib(struct ptp_clock *ptp)
> > +{
> > +	return ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB;
> > +}
> > +EXPORT_SYMBOL(ptp_clock_from_phylib);
> > +
> > +bool ptp_clock_from_netdev(struct ptp_clock *ptp)
> > +{
> > +	return ptp->phc_source == HWTSTAMP_SOURCE_NETDEV;
> > +}
> > +EXPORT_SYMBOL(ptp_clock_from_netdev);
> > +
> > +struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
> > +{
> > +	if (ptp->phc_source != HWTSTAMP_SOURCE_NETDEV)
> > +		return NULL;
> > +
> > +	return ptp->netdev;
> > +}
> > +EXPORT_SYMBOL(ptp_clock_netdev);
> > +
> > +struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp)
> > +{
> > +	if (ptp->phc_source != HWTSTAMP_SOURCE_PHYLIB)
> > +		return NULL;
> > +
> > +	return ptp->phydev;
> > +}
> > +EXPORT_SYMBOL(ptp_clock_phydev);
> 
> IMHO these four helpers just add a layer of indirection without much
> benefit.

Actually, ignore this. This is not important enough to revise when
we're alredy at v10. That also goes for the other points.

> Do we ever expect more than two sources? Else, the phc_source could be
> embedded as the least significant bit of the pointer in the union. In
> that case we would need helpers to return the pointer without that LSB.
> But space in struct ptp_clock is probably not so valuable that we need
> to play such games.
> 
> > +/**
> > + * netdev_ptp_clock_register() - register a PTP hardware clock driver for
> > + *				 a net device
> > + *
> > + * @info: Structure describing the new clock.
> > + * @dev:  Pointer of the net device
> > + */
> > +
> > +extern struct ptp_clock *
> > +netdev_ptp_clock_register(struct ptp_clock_info *info,
> > +			  struct net_device *dev);
> 
> No need for explicit extern?



