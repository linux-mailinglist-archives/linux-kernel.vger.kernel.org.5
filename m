Return-Path: <linux-kernel+bounces-70574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B1859957
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB41F21302
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F64745CB;
	Sun, 18 Feb 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+q9o/O/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326673183;
	Sun, 18 Feb 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289047; cv=none; b=Ls5hBauFVIF8bRQ63LABw/U2R4njri+tsJ7iWnzgBjPqy02F2eXSDMJlLEJKvbezaQaXf13in9FIxSaXBPbQj8A9bpR976rP7xy8tx2F1I3cQHpYOStEsMuAlmsGMxG/aI5SRGOlfE80Zk3Vwa0s8I56lAjn5kIYOn9lq7boFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289047; c=relaxed/simple;
	bh=p5ORb8oX+qE/djHJJBL+ZNcZv9f3KUTdFpnTFDG2t88=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j92l4s8filo2fda5JElCr8eMYBD6NcHOK/Xp6bSRPfb3IYKa86nwe8lbWsZsM8a/JExRDSxvEO32GmnYamZ630I6RR7TO9yCLPFMwVSfnlvEK1VW7IyZmn32GhEb+UmpU67SkEYgCMquvCcSP5ob+2f3Qeh3oYoY7RCG9QGNmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+q9o/O/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33cd57b7eabso1919484f8f.2;
        Sun, 18 Feb 2024 12:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708289043; x=1708893843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NDC0OtHeGnwCP7LZXlpdwmX/HcyCP1GbfLj1JZV6aQU=;
        b=T+q9o/O/EgOvDfRu8C5Ph2xhj6KCyivGWoS5R7FQDy0EKZnZaiU8RFYWpwiXrmAaUh
         zcU2Zc92Q5rhdvtf8ACX9w0YhjPnGq942RrgdsZ6LBDaxUdZ12pkCj2u2c1fnejEoby6
         LEP6EqlernZ0sQ278jl08YRxuAvB7ylv2Dt26sBRnEyOXR+6shCizkJbjkWmr+FBf59e
         7vyHEjxtWMOtBHC/Qq319fXC1N4x8DxnmneuBD2AcjLESN7b9bwkvqUc4V+o5omCZ80C
         WO7Rd4sa9pSJiLT+7j6nyzrqLL8bfAa8cw53f8PP2aojMPrwDvkPXPFEzMgseizDghpn
         YIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708289043; x=1708893843;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDC0OtHeGnwCP7LZXlpdwmX/HcyCP1GbfLj1JZV6aQU=;
        b=WEwRzUyrdcJ/D8af9tWqxkDSG/4BEQx4+gOfkiDChYVGjWAryT5ZwAm1wgPpzUP+BJ
         OeN2/qSPhlxjjcrbx4R+aNJ/y/lWzhdCZ5CQuCli5WPYG9PbdIDIxeEfGT0wwDtMJ24X
         7H+k1jgWEi2tNWEivOweYF1nSmko3u1iBdKAic9wbWzAW3MWN5o4D7WdaSkLViXbCg5D
         nLdJX/ejjbQgBJyjXLR04OjAJDuGChchjpfddgWW/9IiJP7Js1IOG7yXq4O+O6SCv2ds
         Mj39p3P/6cxtJo2lDP5sHXcM5VgJkOx4mHMFAXXjj2xKyXDO7QXg8NNeVYSVlT8WZP5w
         HhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjsooQLPnOTD+DLEgJwji1opITZa9x6rm+UhE83EU2DybSesb/rSvzsbs7NYybOZoiMPAZNjFDGxk/F8IWloZnPbQd0yjdNRssVzENij1sLBdS9mi6xobcSrnXmBxtTLLUZMqv
X-Gm-Message-State: AOJu0YzPICb7niD/RkVbcElnFtvVrCKAp6j6UgABPDxGBNbwhyctgQ33
	Wqp1IWcQIscb5dt7C9TqT7x/R17bzr4WkIFOyv8e/fPK9H7Q2sL0
X-Google-Smtp-Source: AGHT+IG8kLwsfXqd9+VdPpPTiHaKlo0kMwOtWqhD0Mtda4FmJeWD+7sUTqdsaB0lNtKMeQvRrJ59LA==
X-Received: by 2002:a5d:5182:0:b0:33d:1eea:4346 with SMTP id k2-20020a5d5182000000b0033d1eea4346mr4465564wrv.37.1708289043425;
        Sun, 18 Feb 2024 12:44:03 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id o18-20020adfcf12000000b0033b87c2725csm8366021wrj.104.2024.02.18.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:44:03 -0800 (PST)
Message-ID: <65d26c13.df0a0220.63f42.d8e6@mx.google.com>
X-Google-Original-Message-ID: <ZdJsE7d2GcQKTuAR@Ansuel-XPS.>
Date: Sun, 18 Feb 2024 21:44:03 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
 <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
 <65d2613d.170a0220.2eb48.a510@mx.google.com>
 <829f8c7d-c09b-4264-818a-3f7b047ec44f@lunn.ch>
 <65d2682a.5d0a0220.3fef2.efe4@mx.google.com>
 <ZdJpyGkFRiRufySw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdJpyGkFRiRufySw@shell.armlinux.org.uk>

On Sun, Feb 18, 2024 at 08:34:16PM +0000, Russell King (Oracle) wrote:
> On Sun, Feb 18, 2024 at 09:27:22PM +0100, Christian Marangi wrote:
> > On Sun, Feb 18, 2024 at 09:10:30PM +0100, Andrew Lunn wrote:
> > > > > > +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
> > > > > 
> > > > > Why this cast? Try to write code that doesn't need casts.
> > > > > 
> > > > 
> > > > This cast is needed to keep the dev_id const in the phy_device struct so
> > > > that other are warned to not modify it and should only be handled by
> > > > phy_probe since it's the one that fills it.
> > > > 
> > > > Alternative is to drop const and drop the warning.
> > > 
> > > Can you propagate the const. Make phy_dev_id point to a const?
> > >
> > 
> > Mhh not following, I tried changing to const struct mdio_device_id *phy_dev_id
> > but that results in memcpy complain (dest is void * not const) and
> > writing in read-only for the single PHY part (the else part)
> > 
> > An alternative might be to make dev_id a pointer in struct phy_device
> > and dynamically allocate a mdio_device_id for the case of single PHY
> > (else case). That effectively remove the need of this cast but I would
> > love to skip checking for -ENOMEM (this is why i made that local)
> > 
> > If it's OK to dynamically allocate for the else case then I will make
> > this change. I just tested this implementation and works correctly with
> > not warning.
> 
> Why do we need memcpy() etc - as I demonstrated in my proposal, it's
> not necessary if we introduce a mdio_device_id within struct phy_driver
> and we can just store a const pointer to the mdio_device_id that
> matched. That was very much an intentional decision in my proposal to
> make the code simple.
>

With the allocated mdio_devic_id it would result in this snipped

	const struct mdio_device_id *driver_dev_id;
	struct mdio_device_id *dev_id;
	int err = 0;

	phydev->drv = phydrv;
	/* Fill the mdio_device_id for the PHY istance.
	 * If PHY driver provide an array of PHYs, search the right one,
	 * in the other case fill it with the phy_driver data.
	 */
	if (phy_driver_match(phydrv, phydev, &driver_dev_id) && driver_dev_id) {
		/* If defined, overwrite the PHY driver dev name with a
		 * more specific one from the matching dev_id.
		 */
		phydev->dev_id = driver_dev_id;
		if (driver_dev_id->name)
			drv->name = driver_dev_id->name;
	} else {
		dev_id = kzalloc(sizeof(*phydev->dev_id), GFP_KERNEL);
		if (!dev_id) {
			err = -ENOMEM;
			goto out;
		}
		dev_id->phy_id = phydrv->phy_id;
		dev_id->phy_id_mask = phydrv->phy_id_mask;
		dev_id->name = phydrv->name;
		phydev->dev_id = dev_id;
	}

Is it ok? (in phy.h the thing is const struct mdio_device_id *ids)
I don't really like modifying phy_driver too much.

-- 
	Ansuel

