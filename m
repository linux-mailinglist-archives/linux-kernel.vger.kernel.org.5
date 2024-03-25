Return-Path: <linux-kernel+bounces-117022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3DF88A640
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7161C3C8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9315956E;
	Mon, 25 Mar 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0RqbUNoE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2A17C98;
	Mon, 25 Mar 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370339; cv=none; b=ZNJyhp2WT9qJkfNViP/IqydcXIZ9m1vleVGLW7KNYV809rj8N0wZ1nQ6uh9qCxKGVa4c5LDOW9zXoHNgNcWpltHym+kO3mPoq69URHNoBQyiu9moEX7YK8ytTkjRl5CbH5B3BFb8SA3bRbD6Ah/WjAQT0lRWvLM2qizBk9H6Pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370339; c=relaxed/simple;
	bh=95OfuHhtUR61PCdLT913r4p58jGY4g4ttdpsQZMIHKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeNcAgp5PLkSy/LFAP6gCKouRzNFPEJfUaq6i0cY/DiuI3uT3HKAljumb4rbnoR7AkeeCsdgP3I9yirEU+cswfJvsFpxnWYkzQrMGO/w14eU9Wsp0iLI+ZDIl3sj4+M9IAzf/HXbu+rfOxFKQ/cuAj716pQ+zeVg9YsaxgMHxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0RqbUNoE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OgU9ATmRZP6L3LpzuzX003fhjH7k0Ift0+MTIYapSoA=; b=0RqbUNoEE8/paq5vSzmjLbsA0Y
	sOt8eUVaYwOPNeHqtcx3KhS/x2x6blQy1CxPXXwerD+QVRpCR2vY1bl2ErUJo0rDFAKujo3WNBq8L
	tPTw/n0r3KsZNg36bUs3LCOML00kYdGPmsFxOIgWZikBEOgNmLUX5enm+rsx75xmJs9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rojb8-00B9Nd-5b; Mon, 25 Mar 2024 13:38:42 +0100
Date: Mon, 25 Mar 2024 13:38:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for
 rtl8366rb
Message-ID: <9ca3fc83-ef54-4080-bd77-b0f09eefc952@lunn.ch>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>
 <d064b1be-1004-487b-9944-b62d91b671c9@lunn.ch>
 <CAJq09z54+049aPL2LzAqAFigrvpchPhv_YQ6yJ5C9b9J7mngLQ@mail.gmail.com>
 <f76754f9-4141-4d48-81e8-f43aa2dfa90c@lunn.ch>
 <CAJq09z6ZYpwYiqo-XvLG1=_JZeCM2APmHqBjhD4rBSdRP3ERYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6ZYpwYiqo-XvLG1=_JZeCM2APmHqBjhD4rBSdRP3ERYA@mail.gmail.com>

> static int rtl8366rb_setup(struct dsa_switch *ds)
> {
>        (...)
>        if (priv->leds_disabled) {

         if (!priv->leds_disable)
	    return;
	    
Saves you one level of indentation.

or

static int rtl8366rb_setup_all_off(foo *priv)
{

>                /* Turn everything off */
>                regmap_update_bits(priv->map,
>                                   RTL8366RB_INTERRUPT_CONTROL_REG,
>                                   RTL8366RB_P4_RGMII_LED,
>                                   0);
> 
>                for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
>                        ret = rb8366rb_set_ledgroup_mode(priv, i,
>                                                         RTL8366RB_LEDGROUP_OFF);
>                        if (ret)
>                                return ret;
>                }
>         }
> }

This is what i meant by small helpers. And the function names replaces
the need for the comment.

This is part of the thinking behind the coding style. Function names
can replace comments. And the higher level functions becomes easier to
follow because you don't need to dig into the details to understand:

        if (priv->leds_disabled)
	     rtl8366rb_setup_all_off(priv);

     Andrew

