Return-Path: <linux-kernel+bounces-75077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31F85E2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200BB1F25776
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23A81722;
	Wed, 21 Feb 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pTK8jozu"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693217CF0F;
	Wed, 21 Feb 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531725; cv=none; b=L6gckjtGF/gPJrGToby9VZZqlJ3ftZUEpHEk5LAyGroMUChc4SEOHK+vd5GgAZEctE9bqWsoUeTS+/k+m5or0zL3oK5iy63DwhkpWk0AQTEr0hwfcrzAFXgNUC491JFa1IZ7PL1tnykZ9i7lDYZL7naWtzjrvTJbbVDv6RDZaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531725; c=relaxed/simple;
	bh=agprbSGbPZoCczSp1znYQDm8799YwPtnW91lWAItujs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aWCktr9xKenW+qd/MGpP3uXqIpMCB+8pb947m+JoOWBw2r9dJ9XFVN0krswwSNQrFWCpl/TUQy7ORMYpG/7fg6HsxIJDvLxpfDw14jFtxi0877Dwm1W7iysv4KqsWwljVZM5G0ZmYhHHWLQ0cZdnTUHHLvvcsRvwlXh0QDnFz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pTK8jozu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DC042000E;
	Wed, 21 Feb 2024 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708531721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agprbSGbPZoCczSp1znYQDm8799YwPtnW91lWAItujs=;
	b=pTK8jozu8k4/WDxcqFSdFKy72Usic303GcMiSwr16cFPMLB4CKL+kvRqhMFRfQo20IP6fZ
	2ndTzp11Lb7NnUbXTjPeRhb0M91Ac1ooojzwkzLBam7yCAbuuM00hravHyre2SQGe8MDYx
	9hE6/hKfkS03iSNnDUZWl8v6D0oq93X7HAf2K/ma1dKUY9ocLQgfcOOjjxR1QTxYPk01DZ
	eaLTkDn6on9itqPDS9x4WV85Ihm8dH71JsOo6ZXxGIppwx+pbPrM0wEkX+nQt2+AjTgBuT
	dG8xIa35ZuCAV9Lchrb/RjhQ5hoNN7AcCXqyRiuj2Da/Q7fgps/2SxZRlArYeA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 17:08:40 +0100
Message-Id: <CZAVY4NPY4H6.1KJI4UPRUM21C@bootlin.com>
Subject: Re: [PATCH v6 05/13] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl:
 add bindings
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>, "Rob Herring"
 <robh@kernel.org>
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
 <20240212-mbly-clk-v6-5-c46fa1f93839@bootlin.com>
 <CACRpkdYNe=2w10uB1mUgs2Lgg1TRiSF=bOa45OH5Lcz6+G6FEg@mail.gmail.com>
In-Reply-To: <CACRpkdYNe=2w10uB1mUgs2Lgg1TRiSF=bOa45OH5Lcz6+G6FEg@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 2:38 PM CET, Linus Walleij wrote:
> On Mon, Feb 12, 2024 at 2:44=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I tried to just apply the pin control patches to the pin control tree, bu=
t I
> can't because of all collisions in MAINTAINERS.
>
> If you move all MAINTAINERS business to the SoC-wide patch I can
> apply the pin control stuff directly, but maybe you wanna keep the
> series together and merge on an all-or-nothing basis?

I'm all in for making the series slimmer over time. MAINTAINERS changes
will be moved.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

------------------------------------------------------------------------


