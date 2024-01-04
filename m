Return-Path: <linux-kernel+bounces-17256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C79824A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36121F24723
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE42C85A;
	Thu,  4 Jan 2024 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB8/pL+x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B52C69B;
	Thu,  4 Jan 2024 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so9606355e9.0;
        Thu, 04 Jan 2024 13:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704405101; x=1705009901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bas+YdPjRljGtlJX4ssRIxTCAw0axobXiWVL+eDf96Y=;
        b=NB8/pL+xT5xrGmhKGUlzACK277QDPDMFmQWriCDUQSLbghBALZiAzAg/bukhqgMjtc
         l0zSVxsoGw9Flb2OmsXsSl9nbJN9w82CLGpEc/IGXqawCeLtuE0t9yp+caVSqM8u6NyQ
         acgblUtmUMGSw7nyq/3tMNa6M5zUsLT20DP9f6YAGsQAa7L7VUmTM8z9qPXu/2lt12P/
         0SZxpRKG0dnxz4p29VsESksTADS7mDAEUOONVaBvl0s2YDHXumuzqifImphsSChuLaxK
         FFd3M1+PB3dt8oIsqa3oM9kbPAnKbZsa/SjYZDXqhtyZPfxzPHxeCtFWMGoaejrm75S5
         KTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405101; x=1705009901;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bas+YdPjRljGtlJX4ssRIxTCAw0axobXiWVL+eDf96Y=;
        b=ArKXxRVFaHqze4JS245DOkhizCBG8hrm+KCSlpvRU425ic0aCl/SthZBfuz2+v8+wM
         L/oFG/cFn8taZ+bJ9fiespgXFARt9zQjCjaujEhPRnnfzv2xKsQkv2hFcw6eGPedKMnq
         zPF5NxumX8Y3U+6quW60qfaRZo1+QcMXRIkjon6wPBkAJquOBlTdftqaXEdHLIhZJyW3
         JR4R1A7X6I1tY0H90Qk/4lr4RFRYXrkEI0dCSjSyd9xk7zXAPmezia5ligwoVfj+Xax9
         VTcLBC/4xEXm3Leto9MxPt3XLP1xs1fqntPhvhNEwSrk8sY4xKlMLBVkjA3R73S24EvH
         5djw==
X-Gm-Message-State: AOJu0YyzHdo7JV2jOWRpEA3xGsHtBw1Q1PH/xBueU8utvbzzMqShXj20
	Rm8VflvuC1Hl/okuPE05hPo=
X-Google-Smtp-Source: AGHT+IHZyjHBUN0jDo/92RJRPvzGHGPyqBLjQ4NZE1nxbAPYeJtwdJ1AmotGhClp5OzXnm8VlOE/Fg==
X-Received: by 2002:a05:600c:3acd:b0:40d:5b0d:b105 with SMTP id d13-20020a05600c3acd00b0040d5b0db105mr754745wms.117.1704405101029;
        Thu, 04 Jan 2024 13:51:41 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c139200b0040d5ae2905asm426374wmf.30.2024.01.04.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:51:40 -0800 (PST)
Message-ID: <6597286c.050a0220.4684a.182e@mx.google.com>
X-Google-Original-Message-ID: <ZZcmP1GVBR1Taj0U@Ansuel-xps.>
Date: Thu, 4 Jan 2024 22:42:23 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v8 3/5] net: phy: add support for PHY LEDs
 polarity modes
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
 <20240104110114.2020-4-ansuelsmth@gmail.com>
 <47f18def-d34f-4224-9de2-6e0ae7122a52@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f18def-d34f-4224-9de2-6e0ae7122a52@lunn.ch>

On Thu, Jan 04, 2024 at 02:20:45PM +0100, Andrew Lunn wrote:
> > +	if (phydev->drv->led_polarity_set) {
> > +		if (of_property_read_bool(led, "active-low"))
> > +			set_bit(PHY_LED_ACTIVE_LOW, &modes);
> > +		if (of_property_read_bool(led, "inactive-high-impedance"))
> > +			set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
> > +
> > +		err = phydev->drv->led_polarity_set(phydev, index, modes);
> > +		if (err)
> > +			return err;
> > +	}
> 
> I think we should return an error if asked to set the mode, but its
> not implemented by the driver. Something like:
> 
> 	if (of_property_read_bool(led, "active-low"))
> 		set_bit(PHY_LED_ACTIVE_LOW, &modes);
> 	if (of_property_read_bool(led, "inactive-high-impedance"))
> 		set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
> 
> 		
> 	if (mode)
> 		if (phydev->drv->led_polarity_set) {
> 			return -EINVAL;
> 		} else {
> 			err = phydev->drv->led_polarity_set(phydev, index, modes);
> 			if (err)
> 				return err;
> 		}
> 	}
> 
> > +	/**
> > +	 * @led_polarity_set: Set the LED polarity if active low
> 
> The 'if active low' is not ouw of date, since it is used for more than
> that.
> 
> > +	 * @dev: PHY device which has the LED
> > +	 * @index: Which LED of the PHY device or -1
> > +	 * @modes: bitmap of LED polarity modes
> > +	 *
> > +	 * Configure LED with all the required polarity modes in @modes
> > +	 * to make it correctly turn ON or OFF.
> 
> index == -1 should be explained.
>

If you are referring to the special way of setting the LED globally,
that is not a thing anymore. Rob pointed out that having the double
reference in DT is problematic and PHY driver should handle that
internally.

> > +	 *
> > +	 * Returns 0, or an error code.
> > +	 */
> > +	int (*led_polarity_set)(struct phy_device *dev, int index,
> > +				unsigned long modes);
> 
> 
>     Andrew
> 
> ---
> pw-bot: cr

-- 
	Ansuel

