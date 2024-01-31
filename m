Return-Path: <linux-kernel+bounces-46302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A607843DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFF31C2677E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7878676;
	Wed, 31 Jan 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDj5lO2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E978668;
	Wed, 31 Jan 2024 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698997; cv=none; b=B7zcySlfimTUkQ8TV0LCDnlAfGU90K/7y/fnZ/eryA1779aT5kdyhSeqN/azEchXuO5yV4a3aM0wmC2ft9zUPFilPnPRtvHm8ubKV6/7NHLOw8aZhSp1SU6I9sSH/HdFgTvCHVgIHHD+xn7pD1mYsf20iU3TzKgfKYnR5AFKEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698997; c=relaxed/simple;
	bh=wz8mZeMJ4lXkzfi7C4k08g/FeXlGD7xz3n4JSrz6JM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVwOE9D7BIY8CTQjF6u1KRyKQDaim6Am+t/qw+sD5821LYBWPiRwuxnoXKDvBClorZMyBsn61h7vaJXOzaqUh2JGfEZzEnZHAjPmWi12PzyYjm4knkEXPqRMTtSI/Sb0Du0HUScf3P4I8zlFI/yYHLvJc9nN0q3cetCibn61Y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDj5lO2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD09C433F1;
	Wed, 31 Jan 2024 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698997;
	bh=wz8mZeMJ4lXkzfi7C4k08g/FeXlGD7xz3n4JSrz6JM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDj5lO2yzopiyTwlLyrOIyt/IcDQW50EfY9T4oLgxD6kWFpEVVfwxHBNfDHfQ6lpu
	 kMnirpZfHTX425I0j/MEXYwhu7m5QtjeA+RTZnJl6BGgPnwgn51W5nS8n6GSjrD6JF
	 NiRIp8+Lj+10XqHrQUmq+JdQvpz57RnfqzgLAZ3dnvvaiUyAIcaAGDn8dZylaTVmmW
	 wN1aX0/visHzvJL4U8eRjHJ86HjrQt1AuGIBF2GRiQlnPebJ9IA+T+JuMD9Fg2NxPI
	 5zB966/YiXtEUv9UElq7jUKfE4zQn+FCdtkrKH/IFPzLwZoL6VDfY6oMwGNJOJNYsX
	 um8hvs7GgY+bg==
Date: Wed, 31 Jan 2024 11:03:11 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] mfd: add 88pm88x driver
Message-ID: <20240131110311.GI8551@google.com>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
 <20240125122634.GE74950@google.com>
 <CYQ8MEQRJELE.2GB9316NZA998@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYQ8MEQRJELE.2GB9316NZA998@gimli.ms.mff.cuni.cz>

On Sun, 28 Jan 2024, Karel Balej wrote:
> > > +	/* GPIO1: DVC, GPIO0: input */
> > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),
> >
> > Shouldn't you set these up using Pintrl?
> 
> You mean to add a new MFD cell for the pins and write the respective
> driver? The downstream implementation has no such thing so I'm not sure
> if I would be able to do that from scratch.

This is not a Pinctrl driver.

Isn't there a generic API you can use?

> > > +	/* GPIO2: input */
> > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL2, 0x00),
> > > +	/* DVC2, DVC1 */
> >
> > Please unify all of the comments.
> >
> > They all use a different structure.
> >
> > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL3, 0x44),
> > > +	/* GPIO5V_1:input, GPIO5V_2: input */
> > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL4, 0x00),
> > > +	/* output 32 kHz from XO */
> > > +	REG_SEQ0(PM88X_REG_AON_CTRL2, 0x2a),
> > > +	/* OSC_FREERUN = 1, to lock FLL */
> > > +	REG_SEQ0(PM88X_REG_BK_OSC_CTRL1, 0x0f),
> > > +	/* XO_LJ = 1, enable low jitter for 32 kHz */
> > > +	REG_SEQ0(PM88X_REG_LOWPOWER2, 0x20),
> > > +	/* OV_VSYS and UV_VSYS1 comparators on VSYS disabled, VSYS_OVER_TH : 5.6V */
> > > +	REG_SEQ0(PM88X_REG_LOWPOWER4, 0xc8),
> > > +	/* set the duty cycle of charger DC/DC to max */
> > > +	REG_SEQ0(PM88X_REG_BK_OSC_CTRL3, 0xc0),
> >
> > These all looks like they should be handled in their respective drivers?
> >
> > "patch"ing these in seems like a hack.
> 
> To be honest, I don't really know why these are required and what effect
> they have -- the comments above taken from the downstream version are
> the only thing I have to go by. I might try removing them to see if
> there is any noticable change and whether they could be added only later
> with the respective drivers.

If you don't know that they are or what they do and you haven't tested
them, they should not be submitted upstream.

> > > +static struct mfd_cell pm88x_devs[] = {
> > > +	{
> > > +		.name = "88pm88x-onkey",
> > > +		.num_resources = ARRAY_SIZE(onkey_resources),
> > > +		.resources = onkey_resources,
> > > +		.id = -1,
> > > +	},
> > > +};
> >
> > It's not an MFD if it only supports a single device.
> 
> As I have noted above with respect to the IRQ enum and also in the
> commit message, I have so far only added the parts which there is
> already use for. I intend to add the other parts along with the
> respective subdevice drivers, please see my regulator series [1] for an
> example.
> 
> I thought this approach would make for shorter and simpler patches and
> also would allow me to make more informed decisions as I familiarize
> myself with the downstream subdevice drivers more closely one by one.

One device doesn't warrant an MFD.  Please add more devices.

-- 
Lee Jones [李琼斯]

