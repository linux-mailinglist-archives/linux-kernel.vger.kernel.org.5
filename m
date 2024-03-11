Return-Path: <linux-kernel+bounces-98696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5408877E12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EA71F21C87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2662D781;
	Mon, 11 Mar 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="fZEQPrZM"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372617577;
	Mon, 11 Mar 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152747; cv=none; b=GdKRtljvJ9Ds5vPAggOc/tLUadJrgqjkFKQtgoSgjoApKsBJesuNCMqj9haH4RnbqzA68pRxblNFY8ag42X8fZHDMBGuw6nShxsSTC/PsT9ELDOJCMgQT8EIM49PQIqIioRMBxtkYMSlJvuZlbkr234U4xyYNBT2agLa1rcfLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152747; c=relaxed/simple;
	bh=Z7zEDmtLcGezCOC/ZaSnA49BYLacuUO+5ZVKZot6wSQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=Sef7hXX8KS0HhwiqJyaMY2ChHAWIXs0cE4qb3TfJZp5HQBIOwfBU/Be4ST2tBgS61F+8h4TjwxDSZG8QNrFjm4S3argLZobePO1LGzwdDjEWNGTaudMzXkKL5KdjqmEciGMk3HHvYY/AHjvmkc/ds4BlGTWU8y4qntSmxAcGDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=fZEQPrZM; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 9CE062846D9;
	Mon, 11 Mar 2024 11:25:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1710152740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H//5iIeYe7oQRy/0AyjUfWh+gF2wOrcp5xlLc4v3Q74=;
	b=fZEQPrZMk4AgF+2d7bv0M/4Uyp/cv8UvfL7w2ytblEIuziBl5U9idaSh+7WVs+zUka3q67
	IPh9PjeXSPww1ZF3qlW929xPMl6uW3s0haBQ02NuCFngt5VLAyDpViSpiuzhjVKn6tqANh
	zt1j6r7ji8bV6rvH0lecqrF7BWf6nEc=
Received: from localhost (unknown [213.235.133.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 5B8F5457B68;
	Mon, 11 Mar 2024 11:25:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 11:26:16 +0100
Message-Id: <CZQUKBQF1GZ9.3RSNW5WQBU9L6@gimli.ms.mff.cuni.cz>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
 <ZeZxI_spu4vwxrs7@google.com>
 <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
 <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>
In-Reply-To: <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>

Krzysztof Kozlowski, 2024-03-10T21:35:36+01:00:
> On 10/03/2024 12:35, Karel Balej wrote:
> > Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
> >> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
> >>> Dmitry,
> >>>
> >>> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> >>>> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> >>>>> From: Karel Balej <balejk@matfyz.cz>
> >>>>>
> >>>>> Marvell 88PM886 PMIC provides onkey among other things. Add client
> >>>>> driver to handle it. The driver currently only provides a basic sup=
port
> >>>>> omitting additional functions found in the vendor version, such as =
long
> >>>>> onkey and GPIO integration.
> >>>>>
> >>>>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>>     RFC v3:
> >>>>>     - Drop wakeup-source.
> >>>>>     RFC v2:
> >>>>>     - Address Dmitry's feedback:
> >>>>>       - Sort includes alphabetically.
> >>>>>       - Drop onkey->irq.
> >>>>>       - ret -> err in irq_handler and no initialization.
> >>>>>       - Break long lines and other formatting.
> >>>>>       - Do not clobber platform_get_irq error.
> >>>>>       - Do not set device parent manually.
> >>>>>       - Use input_set_capability.
> >>>>>       - Use the wakeup-source DT property.
> >>>>>       - Drop of_match_table.
> >>>>
> >>>> I only said that you should not be using of_match_ptr(), but you sti=
ll
> >>>> need to have of_match_table set and have MODULE_DEVICE_TABLE() for t=
he
> >>>> proper module loading support.
> >>>
> >>> I removed of_match_table because I no longer need compatible for this=
 --
> >>> there are no device tree properties and the driver is being instantia=
ted
> >>> by the MFD driver.
> >>>
> >>> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe whe=
n
> >>> compiled as module? If that is the case, given what I write above, am=
 I
> >>> correct that MODULE_DEVICE_TABLE(platform,...) would be the right thi=
ng
> >>> to use here?
> >>
> >> Yes, if uevent generated for the device is "platform:<name>" then
> >> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
> >> sets it up (OF modalias or platform), but you should be able to check
> >> the format looking at the "uevent" attribute for your device in sysfs
> >> (/sys/devices/bus/platform/...).=20
> >=20
> > The uevent is indeed platform.
> >=20
> > But since there is only one device, perhaps having a device table is
> > superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is more
> > fitting?
>
> Adding aliases for standard IDs and standard cases is almost never
> correct. If you need module alias, it means your ID table is wrong (or
> missing, which is usually wrong).
>
> >=20
> > Although I don't understand why this is even necessary when the driver
> > name is such and the module is registered using
> > `module_platform_driver`...
>
> ID table and MODULE_DEVICE_TABLE() are necessary for modprobe to work.

I think I understand the practical reasons. My point was that I would
expect the alias to be added automatically even in the case that the
device table is absent based solely on the driver name and the
registration method (*module*_*platform*_driver). Why is that not the
case? Obviously the driver name matching the mfd_cell name is sufficient
for the driver to probe when it is built in so the name does seem to
serve as some identification for the device just as a device table entry
would.

Furthermore, drivers/input/serio/ioc3kbd.c does not seem to have an ID
table either, nor a MODULE_ALIAS -- is that a mistake? If not, what
mechanism causes the driver to probe when compiled as a module? It seems
to me to effectively be the same setup as with my driver and that does
not load automatically (because of the missing alias).

> Just run `modinfo`.

Thank you very much,
K. B.

