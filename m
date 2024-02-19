Return-Path: <linux-kernel+bounces-72037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACF85AE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FE3284648
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE554F86;
	Mon, 19 Feb 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNLmKSE0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AF54BC4;
	Mon, 19 Feb 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380024; cv=none; b=p+Al7wJgdsorXWnJcjnfQKcWY+hAOtP2X09OdrGKLSqsvvVSaTtxgosUqnDPG6gZ/8O94IZQpfzFrTVFGD2UlR6XSKhAlu/LQ3iixBjR4Exg2m7DyXeR90txgqWSE28MYkHDiUm1ekcxtozBCYrvHk2TR5puUv0MJBBuginIl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380024; c=relaxed/simple;
	bh=fw5oMk12b6sKGky9DvgkTephCZSFGWUIKxz2RrQ1Zkw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLwHpqraErpK+H/gDknLR3to53ruQxRr8NWgTeuq4MdAVoDTMAMBsTYqT0lP16gBxn3LnLVI59R1yAJtOCRlqVR8hS7CL6Y4CNDVlYrTbJwVxEMfM+7arqgeHsJGV+xgh1nrdItmLzmcEL4Wx1QSf3h4ahsS3XdPQ5ghAla0pOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNLmKSE0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d01faf711so2824270f8f.1;
        Mon, 19 Feb 2024 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708380021; x=1708984821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2278RBf6sJSVFBupvFhSi4nEa2IVsni0dx6ym0qIDeM=;
        b=eNLmKSE04mZpRM6/De9QG7YReWFCgOM18UZ2A3Rh+WfeKmzUSdeDCDDH1W96zMSahu
         NwD3hzbpeeBY1vcD/PhFnzd+9S46sQF6hgN7MPPrDWXErAVLQkSWp/MtB6wcJTxs2HjD
         C/rl6sRniLtGsyHLrVcbe+MQgT5Ar5W/b5Ouu1rQkfgN75Llsd4G/pEb+rE4Cy6kWhAV
         3ung8XWz77eEfCWcBwbMrSi8fYH2QUK7SWYa39FrNYlC6LcOA96OwyeuC+t9Dk72Mw5Z
         G5tXXWqB6CiNUEizIwjwjigWm8+Cc0jbEJQE3utV/iFdWYghywHH8TTEerdi5Z06NdZv
         IcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708380021; x=1708984821;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2278RBf6sJSVFBupvFhSi4nEa2IVsni0dx6ym0qIDeM=;
        b=SSsGx5IHr+T4VfbiekGZQ6HrJkEsJKV0WExxx6fscWyn8X0lJLalXS2WJWdN0Fj0Hz
         l/6D9QxyLK+PFNdVhgVjV8fMWEg9xzM4U/itCaccfekhUrdgPGA/QeOhnnOkMdNON3hy
         XCgrD2VCF81Ac4ZKzPO26mG0+Kg4Lm80TE4hsO9E/OnfGK46R6Rqt3usRxABX1bFGKcN
         /yRr+Z0H7srX+EcU6iJqtf6DL8J8N6lCYduDsM6v2jugukS21Lfy6DaC5qEBtUFJo//s
         qtoXeD3QPGgQPWGkWEcHAO8TEz80rEQOLHGcdkc3XNko/EVgKg1bqrKqxPFJNqe39cQE
         vgew==
X-Forwarded-Encrypted: i=1; AJvYcCUffYS40beFuuiHXNCjxaJsQi4xKvDYKxldGV6nw8WeHvxwsC9MXx7ZvIP8ZTFJxPDS2Oaduknc3Yp9s99H5l1OisdG6xu2Z9ZOHlzqLZAS6r6vB1DOpr6LzAdjfD1JbV6jolpT
X-Gm-Message-State: AOJu0YxQtbQx6w0F15zLY7/2xqCfXkzxQ+n5Qrd9Z6EidtDij3tZ9q2n
	t69qJVKETvFnblpjGIjYmbt+fcqBvvgAEk3QteraJjDJfg28VFW/
X-Google-Smtp-Source: AGHT+IEK7/UbBoqyqJlOkj6Corskd+CzGi7jkhp0Di792t2csQagfyMFD6YuFNEkuNz6V7pjPqelYA==
X-Received: by 2002:a5d:5f4f:0:b0:33d:2154:960f with SMTP id cm15-20020a5d5f4f000000b0033d2154960fmr9345900wrb.23.1708380021083;
        Mon, 19 Feb 2024 14:00:21 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ch17-20020a5d5d11000000b0033d2ae84fafsm8784365wrb.52.2024.02.19.14.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:00:20 -0800 (PST)
Message-ID: <65d3cf74.5d0a0220.d09ba.de93@mx.google.com>
X-Google-Original-Message-ID: <ZdPPc7sXwyREFU3c@Ansuel-XPS.>
Date: Mon, 19 Feb 2024 23:00:19 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 6/6] net: phy: bcm7xxx: rework phy_driver
 table to new multiple PHY ID format
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-7-ansuelsmth@gmail.com>
 <6146eb3b-720a-4523-bcc7-8e2656aeafef@gmail.com>
 <65d384ab.7b0a0220.15279.bf48@mx.google.com>
 <a1f90d66-fee3-4c03-a04d-0d6c91ce5256@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f90d66-fee3-4c03-a04d-0d6c91ce5256@gmail.com>

On Mon, Feb 19, 2024 at 12:15:14PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/19/2024 8:41 AM, Christian Marangi wrote:
> > On Sun, Feb 18, 2024 at 08:26:29PM -0800, Florian Fainelli wrote:
> > > 
> > > 
> > > On 2/18/2024 11:00 AM, Christian Marangi wrote:
> > > > Rework bcm7xxx PHY driver table to new multiple PHY format
> > > > implementation to reduce code duplication and final size of the compiled
> > > > module.
> > > 
> > > I like the idea of sharing as much code as possible and creating a smaller
> > > module, however by changing the name, you are creating an user-space ABI
> > > change, we rely upon the exact PHY name being shown under
> > > /sys/class/mdio_bus/*/* and this change will break that.
> > > 
> > 
> > Thanks for putting this concern on the table but isn't that generated by
> > dev_set_name and PHY_ID_FMT? from bus->id and addr?
> > 
> > Can't find reference of the name entry in sysfs. Am I missing something?
> > The name seems to be used only by logging to print info/err/warn.
> 
> The name will appear under /sys/ like this:
> 
> ls -ls /sys/class/mdio_bus/unimac-mdio-0/unimac-mdio-0\:01/
> total 0
>      0 lrwxrwxrwx    1 root     root             0 Jan  4 21:27 attached_dev
> -> ../../../../net/eth0
>      0 lrwxrwxrwx    1 root     root             0 Jan  4 21:27 driver ->
> ../../../../../../../../bus/mdio_bus/drivers/Broadcom BCM7712
> 
> it might be OK to change the driver, but I can tell you this is going to be
> breaking a number of our scripts here...

Thanks for the command, yes I just notice the problem and yes it's
problematic... Starting to think that the only way to have this cleanup
is to detach ops from the phy_driver struct.

Not fiding a good way to handle the name problem...

-- 
	Ansuel

