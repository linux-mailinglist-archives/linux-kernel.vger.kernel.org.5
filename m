Return-Path: <linux-kernel+bounces-126357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7F893596
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2651B20FF0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BF1474A7;
	Sun, 31 Mar 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ecs2lM11"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4B9463;
	Sun, 31 Mar 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711913178; cv=none; b=Tu1edD/hQKA+78BZ0Dma0yf5u1WjbfR0ts9PIWKgR8IbTRkT2hfeJjRlylSamywkESmLCa1na6mRaZ4AdKUM2/WsiXxPrN1Z3R/XcjM/m9TAdb2cIzXhUeN93qUmleFwlptRGVDTTnvoCHUiQKnoQEOmOzlr/HvNs9WWDCftVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711913178; c=relaxed/simple;
	bh=dVGI4PXbtwTJFjzEZ3HAN8Hb3XzHs5lYXx8qi9A2SzQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KoDkYyMfgBgTbM+hQRUos/akQCrnhYjMEW4IwXxEt6yBUouslb1UtzOE2wgaAUY/ncPakXjAlTWp0LkK5X/UhWH1aH1VV8iwDdS9RHnKqMJ2ctHXtTKelJmJj6UBuvr4/d3AgymmvEIl52h8iVuVScG+qHrPg8KIaXuOFuJaVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ecs2lM11; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711913173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/SBcQHePB6X2sjFpLhBcuid5NUt0sikNKWyPFfmhVU=;
	b=ecs2lM11X8MT5cuXi5A+xnG/HO3hjwJ51ns6Z2JAzDAWG3UmONoZywxty90Usai3phig9C
	GBIrpvbQqhPXsjgiYR5vWW+kxQSSLA+I/+Kkkgv/6nElXk9ilfODtmoTn4Su6lf78mN3p9
	m4V4APeRlG8w1x5oATdwB2tp4aS+9uj+karBXQS4EIQjzkVVwlZtzAa11aQHKEPZumr4xo
	mGsj6ZDyosbVmbZ6qkIcObeSbCuJQ8HcNxve1YZ10KQh9I0jRkLtD4/Rqxi7ClgaNmdNh9
	e2n4lPT99v8uwoK6QCoBdiT4VY9oBBmCr5bWAwx/oOug6fHkI1JFxcx7163kAA==
Date: Sun, 31 Mar 2024 21:26:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, dev@folker-schwesinger.de, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Christopher Obbard <chris.obbard@collabora.com>, Doug Anderson
 <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Jensen
 Huang <jensenhuang@friendlyarm.com>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
In-Reply-To: <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
 <20240326-tactical-onlooker-3df8d2352dc2@spud>
 <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>
Message-ID: <46d0b87e704ed5a7a0fcc9dcfdbeec2e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alban,

On 2024-03-28 18:00, Alban Browaeys wrote:
> Le mardi 26 mars 2024 à 19:46 +0000, Conor Dooley a écrit :
>> On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via B4
>> Relay wrote:
>> > From: Folker Schwesinger <dev@folker-schwesinger.de>
>> > -	if (of_property_read_bool(dev->of_node, "rockchip,enable-
>> > strobe-pulldown"))
>> > -		rk_phy->enable_strobe_pulldown =
>> > PHYCTRL_REN_STRB_ENABLE;
>> > +	if (of_property_read_bool(dev->of_node, "rockchip,disable-
>> > strobe-pulldown"))
>> > +		rk_phy->enable_strobe_pulldown =
>> > PHYCTRL_REN_STRB_DISABLE;
>> 
>> Unfortunately you cannot do this.
>> Previously no property at all meant disabled and a property was
>> required
>> to enable it. With this change the absence of a property means that
>> it
>> will be enabled.
>> An old devicetree is that wanted this to be disabled would have no
>> property and will now end up with it enabled. This is an ABI break
>> and is
>> clearly not backwards compatible, that's a NAK unless it is
>> demonstrable
>> that noone actually wants to disable it at all.
> 
> But the patch that introduced the new default to disable the pulldown
> explicitely introduced a regression for at least 4 boards.
> It took time to sort out that the default to disable pulldown was the
> culprit but still.
> Will we carry this new behavor that breaks the default design for
> rk3399 because since the regression was introduced new board definition
> might have expceted this new behavior.
> 
> Could the best option be to revert to énot set a default enable/disable
> pulldown" (as before the commit that introduced the regression) and
> allow one to force the pulldown via the enable/disable pulldown
> property?
> I mean the commit that introduced a default value for the pulldown did
> not seem to be about fixing anything. But it broke a lot. ANd it was
> really really hard to find the description of this commit to understand
> that one had to enable pulldown to restore hs400.

Quite frankly, I think it's better to leave the default as-is, and
to fix the dts files for the boards that have been (or will be) tested
to work as expected and reliably in the HS400 mode.  Perhaps this is
also a good opportunity to revisit the reliability of the HS400 mode
on various boards.

In other words, it could be that some boards now rely on the pull-down
being disabled by default, so enabling it by default might actually
break such boards.  I know, the troublesome commit that disabled the
pull-down caused breakage, but fixing that might actually cause more
breakage at this point.

> In more than 3 years, only one board maintainer noticed that this
> property was required to get back HS400  and thanks to a user telling
> me that this board was working I found from this board that this
> property was "missing" from most board definitions (while it was not
> required before).

A couple of years ago I've also spent some time debugging HS400 not
working on a Rock 4, but ended up with limiting the speed to HS200 as
a workaround, so I agree about the whole thing being a mess.

> I am all for not breaking ABI. But what about not reverting a patch
> that already broke ABI because this patch introduced a new ABI that we
> don't want to break?
> I mean shouldn't a new commit with a new ABI that regressed the kernel
> be reverted?
> 
> Mind fixing the initial regression 8b5c2b45b8f0 "phy: rockchip: set
> pulldown for strobe line in dts" does not necessarily mean changing the
> default to the opposite value but could also be reverting to not
> setting a default.
> Though I don't know if there are pros to setting a default.
> 
> 
>> If this patch fixes a problem on a board that you have, I would
>> suggest
>> that you add the property to enable it, as the binding tells you to.
>> 
>> Thanks,
>> Conor.
> 
> 
> Regards,
> Alban
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

