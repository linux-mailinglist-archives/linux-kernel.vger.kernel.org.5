Return-Path: <linux-kernel+bounces-70571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B3859940
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640081C20C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729B71B59;
	Sun, 18 Feb 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WivrQ7/7"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEA1DFC6;
	Sun, 18 Feb 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288045; cv=none; b=jnMpSWtmk9sb0OU3SAvT2ybcxt6LKkDuQ9HoJd8jzIVyHOHMmlw7jyWOU94sA75OYGG/ms5V3SsRIduo40dm9JDxUdSDqcnwHZRdgOhUpgvyGL5OTJp1ts/yehg9e8TuHxMs7nK9+V8YqlGNElRr9FVH/Rd5bQhnyv9f98AOgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288045; c=relaxed/simple;
	bh=yENYDbT75RyD7/RWYGvSdxbo4mzQ2yvnyxTQhZB/GDY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6bHY/iKBu+2R/RJM165L3H1bXOq9eoCdad0nl7p9y084NyRPztrog8pMcQwlI3GwXjU3FJNbFSurRM71Pb6K8kSss6GYCxr6qwWas7azyELcrU67FQJeA6cFFsO9db1GuWxmgabFcVDV1eVNCgBnqS3cLVOeFhAv8/EeI4qhbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WivrQ7/7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d2710f3acso999321f8f.0;
        Sun, 18 Feb 2024 12:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708288043; x=1708892843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1IZHGDC014V+kvyaSiIF+Z+Xk16stYyyoVhUVVQCroE=;
        b=WivrQ7/7SYloG72m66ZAA58gb73wphsphRmCGVZ7/nfjGwI1Fh1iSTiVsusWvq4cM6
         XiBBrCoyvfRRMnjSxUowS8oZucGnrk+hueOikAk3U4lty5wU9+TKPalwRprw3aamgHl6
         20v2a3g/YF3sHheOekIfXalJeibZsWCzasQRD7me0ckULfxk+W3oAweH6tXYRH6F2Se0
         HKHKv6ewYkXeUeKmJPZxnKjz+NFfIxN3HhEXqcuoYrDfEkT06In0Goz3jCUtsJkYpT/w
         NAUklUm9h+mbSsDMMwNpGZSaMk2e/IRjYZnf8gi1GJU75GX7BTWTA17ODaog09qKuwdl
         F3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708288043; x=1708892843;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IZHGDC014V+kvyaSiIF+Z+Xk16stYyyoVhUVVQCroE=;
        b=FaDE1W2SXhQTO4+urZFatt8ByFa/jDaD9kRdI/c3/AFslNvXq1SlOm4eL54bpsPoRA
         1EEN7+RKeHnXwQqrrpKWRCkWYYAiMJ7MY8vM7biRcWPPVdMmbhpe63metFNgSVAs3CEH
         igVgEjPAr3C0FZK0c7B4KacWjuAS7sgz1i267FuX2iI+WZ2gzzKRGXzITTSU0ffs6mWp
         3GnCv0yNXZOAjIiFWscCzc4zg6mq1K205NU9X4hmWDwU5py5jrqAhnXprweyBk2nnDW5
         XiV1VDX0mAAze+CSbS3BD9GuOyXmmFjMHyqkiZcFu/bwc9ZAN09MDT5hG43LpbEqN87I
         x/5w==
X-Forwarded-Encrypted: i=1; AJvYcCUMSpPE9A97WnXq/muWLIi8bT6AY2WkUA+s7lhge1oku2fItmlEh77uK5aGjwXsza/QVsE/ck15PHEzJtSsQvh6kUNwpAoSqsbVqVbG4+sy7hoIYGIWx2MSrFBBwpXwxQoNfEtO
X-Gm-Message-State: AOJu0YwoCG1dLh/Opfc00Yduy06jZ37ylMhofFINLrhRw0/DbHnxotqm
	D5CoqiCbF5vhrkzPI0n9TP49hYGtvzVD8WjCMqUvqT/Tc/pfFkOS
X-Google-Smtp-Source: AGHT+IFm10FPB9b0cMW7RIvsOiqQHjGQ1Y1S1mp4zJsQ4kOsB4GVSdZzGFcpZZWO72Lw+8y+0sUieA==
X-Received: by 2002:a5d:4a88:0:b0:33d:7e9:9543 with SMTP id o8-20020a5d4a88000000b0033d07e99543mr8710084wrq.32.1708288042448;
        Sun, 18 Feb 2024 12:27:22 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d5184000000b0033b4f82b301sm8453080wrv.3.2024.02.18.12.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:27:22 -0800 (PST)
Message-ID: <65d2682a.5d0a0220.3fef2.efe4@mx.google.com>
X-Google-Original-Message-ID: <ZdJoKvPTkkn8wtq6@Ansuel-XPS.>
Date: Sun, 18 Feb 2024 21:27:22 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829f8c7d-c09b-4264-818a-3f7b047ec44f@lunn.ch>

On Sun, Feb 18, 2024 at 09:10:30PM +0100, Andrew Lunn wrote:
> > > > +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
> > > 
> > > Why this cast? Try to write code that doesn't need casts.
> > > 
> > 
> > This cast is needed to keep the dev_id const in the phy_device struct so
> > that other are warned to not modify it and should only be handled by
> > phy_probe since it's the one that fills it.
> > 
> > Alternative is to drop const and drop the warning.
> 
> Can you propagate the const. Make phy_dev_id point to a const?
>

Mhh not following, I tried changing to const struct mdio_device_id *phy_dev_id
but that results in memcpy complain (dest is void * not const) and
writing in read-only for the single PHY part (the else part)

An alternative might be to make dev_id a pointer in struct phy_device
and dynamically allocate a mdio_device_id for the case of single PHY
(else case). That effectively remove the need of this cast but I would
love to skip checking for -ENOMEM (this is why i made that local)

If it's OK to dynamically allocate for the else case then I will make
this change. I just tested this implementation and works correctly with
not warning.

-- 
	Ansuel

