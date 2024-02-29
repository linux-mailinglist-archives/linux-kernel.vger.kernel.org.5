Return-Path: <linux-kernel+bounces-86916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D6186CCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC23284C76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A41419A6;
	Thu, 29 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p3HPaMpT"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F93137747;
	Thu, 29 Feb 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220187; cv=none; b=ZoiUNUGgKhUj5PyTdQ9+cka1bHXawlPly8lYHdBwH5444wBreE1M0xs31c9Ql4zJPfmnyP/QFNlg1kmBHU0yc78Pw0Q6uvsBqIE1sDpRVPfCZJwfyG4uvDYxCLvnfJ3OQFViY0w25X+YiULtBqS8ylKw1ONbN6CrIK5AgBkOtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220187; c=relaxed/simple;
	bh=FnJ5PRLHMbbCxiWolI/D484iJjQ+6LJl7Lv2B83l2e0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=uXs3c3w2zhV40ET0q+e3t5zpzWpJu/jeVHNap5J2UHZUaKxgsYdktD/LNEl1W8y10LFwD88p/qDsFdsnzoS1lzzmm5AG8gklEgy0Q/SUktX6092voopZcvTfRVx/UhoCSzWO7o3GlRFSpFxKyQ0fQSaaLsgeOR1Jp6jPQAC+Nnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p3HPaMpT; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0933FE0005;
	Thu, 29 Feb 2024 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709220183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5kXwCtNU0te2FYTDQ4q2dN9S7SUT7EeSjehv7fCtCk=;
	b=p3HPaMpTCeMnY+v+RhRzOMfYf1hJRqMHo3mDiIUesLh6hAPkP84BiA1/4vN1Np1RzhMxL8
	BJ1uJHxtM7AqiEI1cce7u4UVp8r8LqfZvNHOW/0j4W5wzAXLW6F+JhykK4QY9t9Zz3xTdl
	j5t56sDZpKxwbF01428OmZHp4O/tmvJKJ0i5CR2HNxmkDocrMQIwAQejdScrk0m5byvTF9
	3VIS/Y/t49hoiyd4lu007tVtJ6g4y9Fn8feOCpQ8S4JKVl9bXptA2rWgpgV5SSxF9IA8s4
	Cj1JmrOzfVw2vUNqgwV36ZYdpNXQ6AEMGdBx59t7Xj2S2jPkCVyDCR7zkbppIA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 16:23:01 +0100
Message-Id: <CZHNZJJ600CC.1WV7Q2520ZSKU@bootlin.com>
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
 <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
In-Reply-To: <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 29, 2024 at 2:48 PM CET, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 01:18:08PM +0100, Th=C3=A9o Lebrun wrote:
> > On Thu Feb 29, 2024 at 12:22 PM CET, Andy Shevchenko wrote:
> > > On Wed, Feb 28, 2024 at 06:04:47PM +0100, Th=C3=A9o Lebrun wrote:
> > > > On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> > > > > On Tue, Feb 27, 2024 at 03:55:25PM +0100, Th=C3=A9o Lebrun wrote:
>
> ...
>
> > > > > > +	priv->rcdev.of_node =3D np;
> > > > >
> > > > > It's better to use device_set_node().
> > > >=20
> > > > I don't see how device_set_node() can help? It works on struct devi=
ce
> > > > pointers. Here priv->rcdev is a reset_controller_dev struct. There =
are
> > > > no users of device_set_node() in drivers/reset/.
> > >
> > > No users doesn't mean it's good. The API is relatively "new" and take=
s
> > > care of two things:
> > > 1) it uses agnostic interface;
> > > 2) it doesn't require any firmware node direct dereference.
> > >
> > > The 2) is most important here as allows us to refactor (firmware node=
) code
> > > in the future.
> >=20
> > I think I get the point of device_set_node(). I still do not understand
> > how it could help me fill the ->of_node field in a reset_controller_dev
> > structure?
>
> Exactly why I put the above comment as recommendation. And then I elabora=
ted
> that entire reset framework should rather move towards fwnode.

OK now I get it. One question: would using fwnode abstractions make
sense for a driver that is devicetree-only, and will stay that way?

However this sounds out-of-scope of such a driver addition. I also am
not familiar enough (yet?) with the reset subsystem and/or fwnode to be
able to bring this kind of changes upstream.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


