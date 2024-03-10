Return-Path: <linux-kernel+bounces-98198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55787765D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07EF1F211A6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB4849C;
	Sun, 10 Mar 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="OJhxHYsv"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353C16423;
	Sun, 10 Mar 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070538; cv=none; b=FkiKJoeQRL2UJ6GsfOJIvuJbwZb8ewreubUAzSPJNdPbhrj9Vpo2lVLSa209hGHZWwVKoSixm/l3Kj17XlckOKhUlzpDRzSe1rQFoxAVrDpD2vtCJZndrv8gnESEqACRqqJJqDgbBfXRwHt+yMF599RcMk1BEqSXbrOniiENsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070538; c=relaxed/simple;
	bh=n5EDnnjn/8WbiExR8CbSSHP7vZizmbIbqamwg/8cr5g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=KstjSHOMXjh5oTCQqg4ZNZvuvkY4QSRIENajKi31HbIZ2G23teRjwGBEF1pvu+WntOng06BkZYLHG+2ppw6NkfBr+KKzs+4ikT5/yLiYFfksZk2I/Dc0HAhxbEmH+dX8gXbC5nmce9csgD+K/hnXwlhC7Ry3eUshqcBV6L3P/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=OJhxHYsv; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id E12C6284659;
	Sun, 10 Mar 2024 12:35:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1710070523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dcNviD5ZgwDoMqQvTqENMO5BtBuBgMmAr1iRCy6QkE=;
	b=OJhxHYsvOjwYHaN9j1okey1j0J6ZGm+TIaOrxSZbkm7tneHUB0S4cqvnGC1CHJrYwuWt9Q
	nDSlGJrs09LgAI/qUcwCp0E8lI+x/cB0p+a2AygG1N5DP8jfHR6Y928ZtiNxytGH8ohXgt
	mmokrLc+s2hH5TE/tvVRD3hBEyf6GK0=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id B6C034526FB;
	Sun, 10 Mar 2024 12:35:23 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 10 Mar 2024 12:35:23 +0100
Message-Id: <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
 <ZeZxI_spu4vwxrs7@google.com>
In-Reply-To: <ZeZxI_spu4vwxrs7@google.com>

Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
> > Dmitry,
> >=20
> > Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> > > On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> > > > From: Karel Balej <balejk@matfyz.cz>
> > > >=20
> > > > Marvell 88PM886 PMIC provides onkey among other things. Add client
> > > > driver to handle it. The driver currently only provides a basic sup=
port
> > > > omitting additional functions found in the vendor version, such as =
long
> > > > onkey and GPIO integration.
> > > >=20
> > > > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > > > ---
> > > >=20
> > > > Notes:
> > > >     RFC v3:
> > > >     - Drop wakeup-source.
> > > >     RFC v2:
> > > >     - Address Dmitry's feedback:
> > > >       - Sort includes alphabetically.
> > > >       - Drop onkey->irq.
> > > >       - ret -> err in irq_handler and no initialization.
> > > >       - Break long lines and other formatting.
> > > >       - Do not clobber platform_get_irq error.
> > > >       - Do not set device parent manually.
> > > >       - Use input_set_capability.
> > > >       - Use the wakeup-source DT property.
> > > >       - Drop of_match_table.
> > >
> > > I only said that you should not be using of_match_ptr(), but you stil=
l
> > > need to have of_match_table set and have MODULE_DEVICE_TABLE() for th=
e
> > > proper module loading support.
> >=20
> > I removed of_match_table because I no longer need compatible for this -=
-
> > there are no device tree properties and the driver is being instantiate=
d
> > by the MFD driver.
> >=20
> > Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
> > compiled as module? If that is the case, given what I write above, am I
> > correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
> > to use here?
>
> Yes, if uevent generated for the device is "platform:<name>" then
> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
> sets it up (OF modalias or platform), but you should be able to check
> the format looking at the "uevent" attribute for your device in sysfs
> (/sys/devices/bus/platform/...).=20

The uevent is indeed platform.

But since there is only one device, perhaps having a device table is
superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is more
fitting?

Although I don't understand why this is even necessary when the driver
name is such and the module is registered using
`module_platform_driver`...

Thank you, best regards,
K. B.

