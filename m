Return-Path: <linux-kernel+bounces-76235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4185F497
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789451F21CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B92BB0C;
	Thu, 22 Feb 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HoxynaFw"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895017F3;
	Thu, 22 Feb 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594647; cv=none; b=Ki/RVzI8k6k5jLqDjq1mr/8PgFkTxRlfq6w/6yZt83bEi3Z4Ra/jr27Ykt9llczfFGqemlRgBQUdekobPK4K+nE5qvu5aqlM63JA1cQ5DxH2ZFc81nbK2KukJpgg7sD66PmPWIAFOq37FWU3+rAVhr/tyW+/IJ4pprPYv8dcBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594647; c=relaxed/simple;
	bh=RtpS10nroKrcjNGLR+XIwHm6KuoDQ2zN2AhYjSQtQ/0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fJnMjaYAu/UnUbWclLb6It2ZL8F+g9odZ5rea2Mb+p0aS6aA2+s/82VX4pDTHlGHAwJ4B1+z4jKsyK4hR83oF5djzoGrnI+ecCUsCn/iGJHcgZax12fqvTivBHcrgMLKFfIyPNN1dXYqob3H3ME/abaRic6gUFkPe2+3GOFdc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HoxynaFw; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38A54FF809;
	Thu, 22 Feb 2024 09:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708594642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtpS10nroKrcjNGLR+XIwHm6KuoDQ2zN2AhYjSQtQ/0=;
	b=HoxynaFwGBjgKqM3kaCHwq/Y4pT/rSyw1Hz7J/pn8wj94own9puofpBHibT2bUW9syI43e
	9xij4loTsECllDsOAotsurK3oTO4xwc0g7o/mf2RdWT1OOxhnesgytZW11JZb0FOyXszQ+
	QUk6vkkF9F4XJu+XQ7Sb3YH7/aKy8MvP8tQNIBXXhIK+7QRX1UTGr15r6OZQXGFrK7KRX0
	2CO8q88AiaPVrnz01yceCpouuymaTkhShbCQGNK7ACt9mWa/39o7nz5Plamn65gwrOcv4g
	p3579NftsvVpsWGVsdHfaezX5GV8MKBjpHLCT5SJb1ZE03o2ejOsJjJEGvo0pw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Feb 2024 10:37:18 +0100
Message-Id: <CZBI90SFODAR.TZ3L2XO2F8IF@bootlin.com>
Subject: Re: [PATCH 18/23] gpio: nomadik: support mobileye,eyeq5-gpio
Cc: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-18-f88c0ccf372b@bootlin.com>
 <CACRpkdYLBGsphNkmWyPXQZvFaO2hHGHGTMt1eqz-HAa2k5F3bg@mail.gmail.com>
 <CZAW47LJHQVD.1Z9GFT8UENYXT@bootlin.com>
 <CACRpkdZQ9LEqKvugDCMEXPPLMCUJ-f9rYQOpmsSEJhtW0zjNsg@mail.gmail.com>
In-Reply-To: <CACRpkdZQ9LEqKvugDCMEXPPLMCUJ-f9rYQOpmsSEJhtW0zjNsg@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 8:36 PM CET, Linus Walleij wrote:
> On Wed, Feb 21, 2024 at 5:16=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > > Trying to figure it out...
> >
> > Can I help in the debugging process?
>
> Nah, I found it :)
>
> > Reading the code once again I'd guess
> > of_device_get_match_data(&gpio_pdev->dev) could be the root cause. We
> > are accessing match data for the GPIO device while probing the pinctrl
> > device. Maybe something isn't initialised properly yet? The rest looks
> > rather harmless, I've checked all conditional expressions.
>
> Yep spot on. The nmk_gpio_populate_chip() is sometimes called from
> the pinctrl driver before the gpio probe() has been called, so the match
> data is NULL and we crash.
>
> This looks like it does for historical reasons and there could be better
> ways to fix it now that Saravana Kannan has fixed up the probe ordering
> code.
>
> The following is one way to fix it for now using device_is_compatible()
> (illustrating some other changes I did as well):

Thanks for the debugging and the proposed fix. Indeed matching on
compatible to avoid match data for a bool makes sense.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

