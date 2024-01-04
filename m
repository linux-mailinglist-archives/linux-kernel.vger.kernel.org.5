Return-Path: <linux-kernel+bounces-16689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C082427A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1595D2878D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0722330;
	Thu,  4 Jan 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5v08M9Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472C2137A;
	Thu,  4 Jan 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336755f1688so416462f8f.0;
        Thu, 04 Jan 2024 05:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704373874; x=1704978674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mD0BtoavTOP3v/vUfEDahgNoFQu6hqlrFVAdzIefsBU=;
        b=b5v08M9YYnBj6Qrzj+Dou/kwsZ2wz5ITrusa37x2RuzvRED09bH6q+7g8zOGVrRMKh
         lY7cKVAvzj4Mf37PefxR0az2LtIfc/MXG+OAydP8ZF0Y63B8N5NmMm22mBABYGrBcfxI
         cDRQlRmVjgBBKaJEKS8YzbQy4boDKNy1qndfrjdukhZRN1oCedIVqkyCjWtILgqPMmgx
         xTGEjkxBcpBnSG7yEdX9gvQWf+gSF0WZT6oxkca03jQ2gdpYOxXGqLvuZFEa5QxocrYA
         YjexV6aF1+TykL5NXoRJK9Eznsn86FFyvmMFdmNR63eKlHF+FAYWZSdG0J7/y6z2oVNl
         o2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373874; x=1704978674;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD0BtoavTOP3v/vUfEDahgNoFQu6hqlrFVAdzIefsBU=;
        b=gJ/hnUQK23zNWaevDsip4cPapXMY3/4D8vPJJezMSg/yDyecaTlM9N+vw6fJ+2G+41
         aWDR7NuFeWwWvtUxKT8eu7Kx2+zJQzDFlCCUZdVz5WBfLCy9kBXWSPZUwOaMSZs0KBCz
         1DO+jjplVAxt+TMB4CbtVGu7qkvfKC9x1LLWEZ3cRoAp/kg9NxWvzc7lYWOrmH9S6Scw
         yXiQmClByy9hhjLKfgkVxmnlf2BFpJVvQdpC9oeIDv4erxd3MYma3/1JzstXPryB6nNW
         H/HwxF1zHLIRejJuIGes+DIF3YYubJmWvtP2IhhCBtEEsoE+YkdJBo7yr0hcoWwbVyf1
         XEkg==
X-Gm-Message-State: AOJu0YwW7y4CwL3osk8twZl9Ykim2C0DpDXQLRMD7UNfGo52blIh1oXh
	xJsDNS47bqHingEB68SBbws=
X-Google-Smtp-Source: AGHT+IG0LMhhU/gfhoVr7LAviwbZXPweDz/CGpAVxscjxDW2uQY6VEjT58wBpBcmJBrbK9LEtlPxUA==
X-Received: by 2002:a5d:4004:0:b0:336:8664:54b4 with SMTP id n4-20020a5d4004000000b00336866454b4mr376338wrp.132.1704373873447;
        Thu, 04 Jan 2024 05:11:13 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b00333359b522dsm33187913wrm.77.2024.01.04.05.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:11:13 -0800 (PST)
Message-ID: <6596ae71.df0a0220.a153a.6407@mx.google.com>
X-Google-Original-Message-ID: <ZZaubwO3TR6Emo8L@Ansuel-xps.>
Date: Thu, 4 Jan 2024 14:11:11 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v8 5/5] net: phy: at803x: add LED support for
 qca808x
References: <20240104110114.2020-1-ansuelsmth@gmail.com>
 <20240104110114.2020-6-ansuelsmth@gmail.com>
 <20240104124805.1b0ba142@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104124805.1b0ba142@device-28.home>

On Thu, Jan 04, 2024 at 12:48:05PM +0100, Maxime Chevallier wrote:
> Hello Christian,
> 
> On Thu,  4 Jan 2024 12:01:12 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Add LED support for QCA8081 PHY.
> > 
> > Documentation for this LEDs PHY is very scarce even with NDA access
> > to Documentation for OEMs. Only the blink pattern are documented and are
> > very confusing most of the time. No documentation is present about
> > forcing the LED on/off or to always blink.
> > 
> > Those settings were reversed by poking the regs and trying to find the
> > correct bits to trigger these modes. Some bits mode are not clear and
> > maybe the documentation option are not 100% correct. For the sake of LED
> > support the reversed option are enough to add support for current LED
> > APIs.
> 
> I have one small comment below :
> 
> > +static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
> > +				 unsigned long *delay_on,
> > +				 unsigned long *delay_off)
> > +{
> > +	int ret;
> > +	u16 reg;
> > +
> > +	if (index > 2)
> > +		return -EINVAL;
> > +
> > +	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
> > +
> > +	/* Set blink to 50% off, 50% on at 4Hz by default */
> > +	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
> > +			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
> > +			     QCA808X_LED_BLINK_FREQ_256HZ | QCA808X_LED_BLINK_DUTY_50_50);
> 
> The comment (4Hz) and the blink frequency (256Hz) don't match, is that
> right ? because I see there exists a QCA808X_LED_BLINK_FREQ_4HZ
> definition, shouldn't it be used ?
>

Thanks for checking this, oversight by me! Will fix. (the blink
frequency was discovered only lately)

-- 
	Ansuel

