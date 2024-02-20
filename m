Return-Path: <linux-kernel+bounces-73014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0933585BC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4131F233F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BC69317;
	Tue, 20 Feb 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPSM3YHc"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB062692E6;
	Tue, 20 Feb 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432131; cv=none; b=sRSlEdFCm2b8tN0YFht36WECPUkuDua5TR++l/sXFOtCym7sD+VOh3DKH1kBMIiQLWTetCdlT+YjjAyKbP98VC8LfN6kNgde5xSvwtGpFlnS8q73cm2Yv6LOOXYObpYBGJL09LnE7rvyVah32gYeFt340OOHyGlcYQ0RxeDKcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432131; c=relaxed/simple;
	bh=r8QqN47qRi91jsH0wIkGa3g4GltqYUwA5TqWyyelcXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2zAuNtG2TwfeNpirNu0nKOznYnVmSSKkjzhXzTl9m2usl3DPLo/F8luLx0FqGgJbJufQQcimhyj2DMzI/QhzrAd13KjomSwjMAnJ+iwsZfkeS7wKZzET5YhzQaKd+IZr4RLd0E9nChl86mjxNGgqANz8CIV1qOnMm+wPRxkAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPSM3YHc; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d6a85586e3so2545770241.2;
        Tue, 20 Feb 2024 04:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708432129; x=1709036929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aiQTzceFpJVhyzyIE+RmD0TpAMXT5KcbC8jdpGnhkc=;
        b=WPSM3YHckS+UX6Rthh8SWyXdb1SGIhvZhDGXxqE96lMq4opo15++/TVatAwXKHOTbH
         nv7ktcpldhWYUputrZI9OD9Jq8C8+uEgeWLI9otavwqJnC9itMAhX0/YTvImuW6J+7Ab
         wuHJUh3Xg0zjCOJBmuTwBaYyzm0f/35I7RbMswrGpE4d/5YfSCzyQVD+Wg9cMb8DJGKJ
         O+MdcVDVMHbvaUUhEveFwitc7WhdsZ+MosGc27+/HOs9ZHgLvKX4N/hJs+hP/A1LnMIy
         WqkZAylJatOxEyvZzEwydM5/8xcbpW69CuqimQebuJozBmaY5duY/q4C97JxgTPSCjmo
         VvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708432129; x=1709036929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aiQTzceFpJVhyzyIE+RmD0TpAMXT5KcbC8jdpGnhkc=;
        b=Be4SECqH1UUQxyFeyeujh23ugf1eyJpqUcwN+2aAORDEuhpeeXYNUx+w8nyrNtvETF
         orM7ZUWnk8u6xprXMJATHvCAAGa40O5yvSkMeOIGoCiqs9wlbnwvKSX+PD6/lyZ/rnRd
         m4SIP7P+yy0Kd1InQb1UL6R0lRrnS2UewsHjJYMbVwRju5AURGftZDa5x3Epq5mqFWTJ
         2zoHeEJuYPcUn6znKSy0HMyRCs6zuYH1owy4qC1ycCxVA1yrk0V/ZF6xRw6+6TQ3Cx3d
         kDq7qRUgX10odiCj5q3M5etp8i4pDN9UrYEKxBPZLsZ0IFPF41agDldJv6V+ilLyVk1L
         czjw==
X-Forwarded-Encrypted: i=1; AJvYcCVbfT6MSXYd5BHBCSBt2x4rr+MZbub0TCHYkHKMTF+wo52KB88vP/qjg/8H9CR7UEdRAnqKDm7VVx8c6fg0eifs5L93Pr98A5WaxjDoNQwsQWhjrXEeqaTfktEY6r5zA1/cd+Kt
X-Gm-Message-State: AOJu0Yx897ZRzuapYprZaSAkdkRsZxtI2L6ygpIdHNMaG3gsTRg32oXs
	m8dozkQPRUAwhH5fznClTX3M97F8Wu22xwL1nfL9i5Pj77Wrofbh4KdeyHLDTItIasFOr7z0i9I
	xat82X8betmkqXNlwRpSikHstzY0=
X-Google-Smtp-Source: AGHT+IHwF30bfGk9916HJb5yDfWumiVA0uNVSaYeMQ5DCb40KQGNw9eOj8D8lwggmW3cnt65RSM9JA16qoblaYVbCz4=
X-Received: by 2002:a1f:e207:0:b0:4cb:fc25:7caa with SMTP id
 z7-20020a1fe207000000b004cbfc257caamr4078533vkg.14.1708432128652; Tue, 20 Feb
 2024 04:28:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-3-paweldembicki@gmail.com> <6db0fd10-556d-47ec-b15a-d03e805b2621@gmail.com>
 <CAJN1Kkz9NPMuoKsm4XdmGS=Y9=SkYM-_EZhqxBojfGZycegtjw@mail.gmail.com> <20240215000427.jdivtxc5jxolmi5q@skbuf>
In-Reply-To: <20240215000427.jdivtxc5jxolmi5q@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Tue, 20 Feb 2024 13:28:37 +0100
Message-ID: <CAJN1Kkwzz_Q7LdWCJ3gGdHw+OdQxq2+_5Aacq0fvHaE9SOog1w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/15] net: dsa: vsc73xx: convert to PHYLINK
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linus.walleij@linaro.org, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 15 lut 2024 o 01:04 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(=
a):
>
> On Wed, Feb 14, 2024 at 01:56:10PM +0100, Pawe=C5=82 Dembicki wrote:
> > =C5=9Br., 14 lut 2024 o 00:19 Florian Fainelli <f.fainelli@gmail.com> n=
apisa=C5=82(a):
> > >
> > > On 2/13/24 14:03, Pawel Dembicki wrote:
> > > > This patch replaces the adjust_link api with the phylink apis that =
provide
> > > > equivalent functionality.
> > > >
> > > > The remaining functionality from the adjust_link is now covered in =
the
> > > > phylink_mac_link_* and phylink_mac_config.
> > > >
> > > > Removes:
> > > > .adjust_link
> > > > Adds:
> > > > .phylink_mac_config
> > > > .phylink_mac_link_up
> > > > .phylink_mac_link_down
> > >
> > > The implementation of phylink_mac_link_down() strictly mimics what ha=
d
> > > been done by adjust_link() in the phydev->link =3D=3D 0 case, but it =
really
> > > makes me wonder whether some bits do not logically belong to
> > > phylink_mac_link_up(), like "Accept packets again" for instance.
> > >
> > > Are we certain there was not an assumption before that we would get
> > > adjust_link() called first with phydev->link =3D 0, and then phydev->=
link
> > > =3D1 and that this specific sequence would program things just the wa=
y we
> > > want?
> >
> > Yes, it was the simplest conversion possible, without any improvements.
> >
> > Some part is implementation of datasheet (description of ARBEMPTY regis=
ter):
> >
> >         /* Discard packets */
> >         vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
> >                             VSC73XX_ARBDISC, BIT(port), BIT(port));
> >
> >         /* Wait until queue is empty */
> >         ret =3D read_poll_timeout(vsc73xx_read, err, err < 0 || (val & =
BIT(port)),
> >                                 1000, 10000, false, vsc, VSC73XX_BLOCK_=
ARBITER,
> >                                 0, VSC73XX_ARBEMPTY, &val);
> >         if (ret)
> >                 dev_err(vsc->dev,
> >                         "timeout waiting for block arbiter\n");
> >         else if (err < 0)
> >                 dev_err(vsc->dev, "error reading arbiter\n");
> >
> >         /* Put this port into reset */
> >         vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
> >                       VSC73XX_MAC_CFG_RESET);
> >
> >
> > I agree that VSC73XX_ARBDISC should be moved to phylink_mac_link_up.
>
> FWIW, ocelot_phylink_mac_link_down() also calls ocelot_port_flush()
> which is more or less the same procedure for a different piece of hw.
>
> By re-reading the commit message of eb4733d7cffc ("net: dsa: felix:
> implement port flushing on .phylink_mac_link_down"), I can find a good
> reason to flush the port on link down and not on link up. With flow
> control enabled, packets would remain in the queue system until there's
> link again if not flushed there, otherwise.
>
> Pawe=C5=82, maybe it is simply the case that you should move the procedur=
e
> from the datasheet into a more clearly named sub-function?
>

I will try to do it more clearly.

> > Other things could be optimised and it needs more care. (eg. This
> > implementation doesn't disable phy when the interface goes down.) I
> > plan to tweak it after the driver becomes usable. Please let me know
> > if it should be fixed in this patch.
>
> What do you mean by disabling the PHY when the interface goes down,
> exactly? Down as in administratively down, aka "ip link set swp0 down",
> not when the link drops?
>

I should be more precise.

> That's a thing for the PHY driver to handle, by implementing .suspend()
> and .resume(), I guess?
>

Yes, exactly.

> What driver do the internal PHYs use?

It is a PHY Vitesse VSC7385 from vitesse.c.

