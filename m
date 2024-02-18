Return-Path: <linux-kernel+bounces-70572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832E859942
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C70281054
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914D6F53A;
	Sun, 18 Feb 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N6WJbVIn"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C51DFC6;
	Sun, 18 Feb 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288482; cv=none; b=iRjOMDl3yi1U2fYzmV3TG6YbrKsEw9UFBu85eq7nnGfJMcjPaCiVI2TU6jLoul3XrhozuRY7r0SN/lyERxILVte2ZaoR2qYIyOvm8RqVIAwgjZBsSswHoEBiuDUBXANc7mFbFhTsITnWXRtlHpBXRsXnmdqUUO/ba5+plR4xuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288482; c=relaxed/simple;
	bh=VQonj/4n6YOIyDcqAu/3JWAnqoTmC0Luv7Gtzb6tJw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odoSTav3w96mYdOFg70EkWuUu7iM6lvMbOp8pCoR2hrbMQWQbYXVucL1YtL0gw298Sd9RNb08qA+TpfpAfHtDnIPkCMfKIph5EISi04mHytNhqW0dL5CQppALRnyqUeb0wA8dBv+uXUVME14CPILdeQ7vvxFB3iO2m7izjv4NqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N6WJbVIn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/rftamFRRBAUT1z8uCrB/9+p1y/ghilxwuwlwd17RCE=; b=N6WJbVInqWOizdsWAtbf+qsW5M
	1ERWmkSIvBU0SPEwRTnZFqGKGCcGu+nf/UfEYQGpshmc1xro50gvk4UAVt3amEIYEJyG5xptdC3h9
	RFoP/pRHFn6Y8of7feDKeGrzGGU6eGkmIODW2KCP2d7RPiuGjSDm1S3xFhn+FgMvQpzH6QcqoUp6+
	wb4s/KyKtWGQu8ZtWSVB69JJYFlxVi57bxTJcGq5kR9dhOYX77z5jmJ+xPlRchLln5LVYapU2VYlU
	Syt4BMqzV/cGdePvc3KmLGY+rguAdZ/RXdz8MQS3NNyuxIKTyJ0QZcE2vXKTJ/UMEJGqaTPC2hUz7
	ft4FlwjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59058)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rbnrg-0003eJ-1o;
	Sun, 18 Feb 2024 20:34:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rbnrc-0007i9-Ds; Sun, 18 Feb 2024 20:34:16 +0000
Date: Sun, 18 Feb 2024 20:34:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] net: phy: add support for defining
 multiple PHY IDs in PHY driver
Message-ID: <ZdJpyGkFRiRufySw@shell.armlinux.org.uk>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
 <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
 <65d2613d.170a0220.2eb48.a510@mx.google.com>
 <829f8c7d-c09b-4264-818a-3f7b047ec44f@lunn.ch>
 <65d2682a.5d0a0220.3fef2.efe4@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d2682a.5d0a0220.3fef2.efe4@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 18, 2024 at 09:27:22PM +0100, Christian Marangi wrote:
> On Sun, Feb 18, 2024 at 09:10:30PM +0100, Andrew Lunn wrote:
> > > > > +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
> > > > 
> > > > Why this cast? Try to write code that doesn't need casts.
> > > > 
> > > 
> > > This cast is needed to keep the dev_id const in the phy_device struct so
> > > that other are warned to not modify it and should only be handled by
> > > phy_probe since it's the one that fills it.
> > > 
> > > Alternative is to drop const and drop the warning.
> > 
> > Can you propagate the const. Make phy_dev_id point to a const?
> >
> 
> Mhh not following, I tried changing to const struct mdio_device_id *phy_dev_id
> but that results in memcpy complain (dest is void * not const) and
> writing in read-only for the single PHY part (the else part)
> 
> An alternative might be to make dev_id a pointer in struct phy_device
> and dynamically allocate a mdio_device_id for the case of single PHY
> (else case). That effectively remove the need of this cast but I would
> love to skip checking for -ENOMEM (this is why i made that local)
> 
> If it's OK to dynamically allocate for the else case then I will make
> this change. I just tested this implementation and works correctly with
> not warning.

Why do we need memcpy() etc - as I demonstrated in my proposal, it's
not necessary if we introduce a mdio_device_id within struct phy_driver
and we can just store a const pointer to the mdio_device_id that
matched. That was very much an intentional decision in my proposal to
make the code simple.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

