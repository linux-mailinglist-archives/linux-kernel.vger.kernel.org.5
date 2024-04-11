Return-Path: <linux-kernel+bounces-140157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E811D8A0C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F571C22730
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942B14431D;
	Thu, 11 Apr 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="URwAt6z3"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7C143C77;
	Thu, 11 Apr 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827183; cv=none; b=QFIenWgid5p5lTB9+styEmi3+nL3L66oh93O4UTbMzL/KzuMFrZDTqz2tXtMd+UFo3NIV9Y/wSLVZB5GCTRCAhOs5DYzR47Yng6bgyYOgS86O3v5YoAjD22QZSvORYKtn4Ka6CmBUMkv4X/6NT/fuiTX0FCWHdH8rWdkeAuArpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827183; c=relaxed/simple;
	bh=7YIPbLNqcKNJR0M74cGCjmsO4y8qKvenM6vaUuW0EUo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=svRIJntm/0yeVdLSctx33Em4YFhO8gq5pZEfkftfquhevK3cumxN+hPFyKGz5xmgSa7gYIBT/WkVqEJXYTjxeb9c9RKw87xZz63jYo0Ld06mU5IbGamNCNCUErGqjKvkBZGW3ZXSjpP/jiVsup6KLBIuADGnlJZY2PeMQ6Mkqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=URwAt6z3; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 833E54000E;
	Thu, 11 Apr 2024 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712827173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTHzKHKeglXiJiU4uLpJ6nerHMO6Rg9h+b3qg4QPbo=;
	b=URwAt6z35/hrriUSTvLg+KFe1NEQgQ6qkGAv5W7gPQfEDD9kZqVIJTH7NxAHzz8lt3nFTe
	aI5x8yFCOXlD91hFPPPb8QZzGfq+C1kSKBWur583kk54jyDrjobWVt52GP4gtrLgLRLxg0
	gymGYojmf40kwq7A2pc/0uGwxLuTGuxEa3JiYvZvy+RAnxszopEFHpLzU5BWWZA7tTQ+ye
	1cRps1M0C1bZ70rN/E14V/onA74ZxuZ4ztEsJ2rdDULbsWC5zK6kTx3LSXjamP9Gw8gcOq
	5KAiowpb/iTZESiw77Fgp0+/D8HTnIVotYKBDQfTlhWLBqhVA8Iy3yWQyS5DzA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 11:19:32 +0200
Message-Id: <D0H6K479VPHU.2WARS2K8B2SFL@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 01/11] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Cc: "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-gpio@vger.kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Stephen Boyd" <sboyd@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <linux-mips@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Linus
 Walleij" <linus.walleij@linaro.org>
To: "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com>
 <171277513936.883835.18187305941709008733.robh@kernel.org>
In-Reply-To: <171277513936.883835.18187305941709008733.robh@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Apr 10, 2024 at 8:52 PM CEST, Rob Herring wrote:
> On Wed, 10 Apr 2024 19:12:30 +0200, Th=C3=A9o Lebrun wrote:
> > Add documentation to describe the "Other Logic Block" syscon.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 125 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 126 insertions(+)
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:

[...]

I made the mistake of putting an EyeQ6H example inside
Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml

I will remove it to get this error fixed. Else there would be
dependencies on clk and reset patches from this series:

   dt-bindings: clock: mobileye,eyeq5-clk: add EyeQ6L and EyeQ6H
   dt-bindings: reset: mobileye,eyeq5-reset: add EyeQ6L and EyeQ6H

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


