Return-Path: <linux-kernel+bounces-75085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324685E2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33C61C2199E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42CB81733;
	Wed, 21 Feb 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vw0WIITt"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668C4CE0E;
	Wed, 21 Feb 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532203; cv=none; b=tN/N+OO4pEOYeze8PbAMJFzCyJjYEwlSXHh1LCoOPDMkDsBWRYkgO9zOhY9OzskJMDMqXwbu95r2aWMGuxB7chZ9PZA4qMBhLnzZUOlIV2WZVx2zJdFK0AIexgejc1kY91BgipZ2t/BZqB57uhthdyHzf1he1y139Ngu1L/aAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532203; c=relaxed/simple;
	bh=SfjXLF9CcUYhZpdXGuPrETqrHrwNnYqmqkrWT36qZr8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=bl+6wP2i8iwt5UR4hB/nPVhIwItVEAYGyHe6TY/VDZopiA9ncI3Fy5SbDibrjWKFH9HajvkXxrlILumPcpf1A2Yb/031BODUjY1y4S/VsJprDE4fzhVQ8UNMKwyuk4pjz1czNQUNx3zxj4vuJC4ceSpHGVW2CQV7eEqZ5zPm5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vw0WIITt; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0827FF809;
	Wed, 21 Feb 2024 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708532198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfjXLF9CcUYhZpdXGuPrETqrHrwNnYqmqkrWT36qZr8=;
	b=Vw0WIITtZAeGyPdq1kuLO5+JMGS1Pc9S4KP53/apTfqdSgOK/ZU7m+qt2kX7JtQW0KaTrI
	DKoxei4zq3KptDQmqSRT1nHjcd6meHUdnXurjkKAIWzdyLRl5SBgqV7vk9Dpchymp5LxCa
	iWFvrX9gRjqwMEHdfq74+Fg1vLDvGT/3i7ndocHuH1ZtD92NDvM2iN1u2r0UC1CVg9XiHN
	36Coszbl2zQNpCOKYigmycKlQ+lu/nrSY1aHc44myxQ5362+GvB4Hmp6UfpLE2GHiMH2A4
	iAnQRjv4/0Eo4fEEx5H1KfeDWuHvdLrav2KBMumc0rGXIH+aJabB8vuE5GSJwA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 17:16:36 +0100
Message-Id: <CZAW47LJHQVD.1Z9GFT8UENYXT@bootlin.com>
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
Subject: Re: [PATCH 18/23] gpio: nomadik: support mobileye,eyeq5-gpio
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-18-f88c0ccf372b@bootlin.com>
 <CACRpkdYLBGsphNkmWyPXQZvFaO2hHGHGTMt1eqz-HAa2k5F3bg@mail.gmail.com>
In-Reply-To: <CACRpkdYLBGsphNkmWyPXQZvFaO2hHGHGTMt1eqz-HAa2k5F3bg@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 3:31 PM CET, Linus Walleij wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > We create a custom compatible for the STA2X11 IP block as integrated
> > into the Mobileye EyeQ5 platform. Its wake and alternate functions have
> > been disabled, we want to avoid touching those registers.
> >
> > We both do: (1) early return in functions that do not support the
> > platform, but with warnings, and (2) avoid calling those functions in
> > the first place.
> >
> > We ensure that pinctrl-nomadik is not used with this STA2X11 variant.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> When testing I noticed that this patch breaks Ux500 (up until patch 17
> all works fine!).
>
> But I don't know why.
>
> Trying to figure it out...

Can I help in the debugging process?

Reading the code once again I'd guess
of_device_get_match_data(&gpio_pdev->dev) could be the root cause. We
are accessing match data for the GPIO device while probing the pinctrl
device. Maybe something isn't initialised properly yet? The rest looks
rather harmless, I've checked all conditional expressions.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

