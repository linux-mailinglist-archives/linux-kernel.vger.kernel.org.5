Return-Path: <linux-kernel+bounces-75091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2028885E2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE531B21C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81B7FBDB;
	Wed, 21 Feb 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ov4Qzcww"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8F3A1A2;
	Wed, 21 Feb 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532413; cv=none; b=oe51hKbJNcmUHyNtYTdBHRyVJ2AJz07cFAEBTkTkYGKfAnky4o2pM6wFUSpZ2VnJW46GxRo3TKLo5sFVEKi5PHCGZvnRQscuYqsQepNCFE3z9RVPMRH8hGNctxvUu3eTc1Wa+wLN5AhvX9PKM/Lg3M4yoBaIl0cc46dj0wMaN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532413; c=relaxed/simple;
	bh=Jv77BKBMeiG/2ccQEV5Y0hNVCO0qasm00dKSVctkfdE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=g8t9ZYMgQWwRaPgY33kGFInukqiSZ04tNeBQsQuYEUIF8hgaqJ5VXAchYaxpC81fhNRKSf8p/FhzllzLe4b2izCIEK54J8yH7o+YmD6LxXAE5DIXCHIJ2XUEFP+YqzTe8PytH8kyOIyMEt1aeYX5fMSc8Brub5zicE67B3Fwqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ov4Qzcww; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CEECFF80B;
	Wed, 21 Feb 2024 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708532408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iZaP2iqfKmtJsxgwYrLbSeh4l2Ui6y1YNvqMc6YgDU=;
	b=Ov4QzcwwK74DcmYrB3MfqOZ4uASvFg6MD+s8zyECgBZLyYUP9f2G/+dpfIe1WEggyXFgL0
	71rl6N7MPYeBf2tGwxmVgSbLQUFCWBZotLI7/7DsWGgUyRCqJ6VLgvBFXKXOnphqXI+3Rj
	oFQh77q/QB0NozZA6BsOXBsfWAIcWLg0NGjPuleJOcuYr9JB0d9w+QvZGEjXpKns+CXK1G
	4Lpo3FEOAHE9kpnb5xit/9HYCZdb2kco/HJGX+Y5sM7J6dGbAkoo/kXmaZeety1iS5p8hn
	PtW/GtuQi96SeBzKqJUN1OVUGkaKA6fS38pmPEbn2udjs5yeAMPZZEWif7BXfw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 17:20:03 +0100
Message-Id: <CZAW6UTMON6K.34LW7FDGNO1XC@bootlin.com>
Subject: Re: [PATCH 05/23] gpio: nomadik: extract GPIO platform driver from
 drivers/pinctrl/nomadik/
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
 <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
 <CACRpkdaSMJBFrmbTu+C1Ls8HkLH4FZsAQ6t7dC76+sVTXXHEyw@mail.gmail.com>
In-Reply-To: <CACRpkdaSMJBFrmbTu+C1Ls8HkLH4FZsAQ6t7dC76+sVTXXHEyw@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 3:37 PM CET, Linus Walleij wrote:
> just a quick note here:
>
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > +config GPIO_NOMADIK
> > +       bool "Nomadik GPIO driver"
> > +       depends on ARCH_U8500 || ARCH_NOMADIK || COMPILE_TEST
> > +       select OF_GPIO
> > +       select GPIOLIB_IRQCHIP
>
> Could you add:
>
> default PINCTRL_NOMADIK
>
> so it is turned on by default when we have that, since they are jitted to=
gether
> so closely.

Would that bring something more than what is currently present? I've set
PINCTRL_NOMADIK to select GPIO_NOMADIK. This means that if
PINCTRL_NOMADIK=3Dy then GPIO_NOMADIK=3Dy. If PINCTRL_NOMADIK=3Dn then
GPIO_NOMADIK is free to be whatever.

This behavior sounds similar to what would happen if adding "default
PINCTRL_NOMADIK".

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

