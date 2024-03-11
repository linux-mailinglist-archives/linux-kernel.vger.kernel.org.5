Return-Path: <linux-kernel+bounces-98809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86313877FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9BAB20FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6882C3BBF2;
	Mon, 11 Mar 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="VtMkRhEH"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB533D0A3;
	Mon, 11 Mar 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159154; cv=none; b=enTuLry7kKOLm45kp6DFo8ZCARYN+fI5iVJsq5OSi5//SLRofIqHKbYfGLq9PVivIGpJyquSFPEgDhv/3uiQVDi2Rvcaj0fcilpSfRZwwV5wDhfBhDoN31g8Sm62oDW9slyI4oYNbRBO+PL3wc4OaRIUpz/omBqd9Y5z6mQlXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159154; c=relaxed/simple;
	bh=U3LEf9gcvb9qBbv5Ydgi8wGMo6Un0VZqLowtuSb4FXg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=UzcQFgCAQMxTuS583AJ62K5hWatLc1Ajoj/QN1gTNC596dsEvLkil0gbEUKxMdy674w9Lu6MfmH4ElI0CgnrZjiqHWGA+wrSHZEJd3QNF1C/WG7uCLraeezGK0rjSFrS05fUxZDxf/ySG9ZRliLsKeIfPASZq+fnLEW0cle1R04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=VtMkRhEH; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 306782846EE;
	Mon, 11 Mar 2024 13:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1710159142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f513oSfKIQNBl+NCiBkqWypTWrkqtfFoWPWTNimurcI=;
	b=VtMkRhEH7lirmCfZ6lq4ZfqNkpmbutYBTmxMKv7B6+8uy+PWmIJVGoz6aUTKckFA49V3Uk
	xVqZGtc6OGuS8HS+HgMFhiZtlj0iG+MVG56uUx5hgHXDPJI4HrXs9NorCIl7GCXZRkbOf5
	yrsggvESPQo1v7rVvqmYvy1Ueh/JOsQ=
Received: from localhost (koleje-wifi-0013.koleje.cuni.cz [78.128.191.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 0C223459710;
	Mon, 11 Mar 2024 13:12:22 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 13:12:58 +0100
Message-Id: <CZQWU0R0G7NS.3JP4FRKAPOLIY@gimli.ms.mff.cuni.cz>
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
 <CZQUKBQF1GZ9.3RSNW5WQBU9L6@gimli.ms.mff.cuni.cz>
 <ce1cac6f-afb9-4388-b709-bfaee0feb525@linaro.org>
In-Reply-To: <ce1cac6f-afb9-4388-b709-bfaee0feb525@linaro.org>

Krzysztof Kozlowski, 2024-03-11T11:41:53+01:00:
> On 11/03/2024 11:26, Karel Balej wrote:
> > Krzysztof Kozlowski, 2024-03-10T21:35:36+01:00:
> >> On 10/03/2024 12:35, Karel Balej wrote:
> >>> Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
> >>>> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
> >>>>> Dmitry,
> >>>>>
> >>>>> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> >>>>>> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> >>>>>>> From: Karel Balej <balejk@matfyz.cz>
> >>>>>>>
> >>>>>>> Marvell 88PM886 PMIC provides onkey among other things. Add clien=
t
> >>>>>>> driver to handle it. The driver currently only provides a basic s=
upport
> >>>>>>> omitting additional functions found in the vendor version, such a=
s long
> >>>>>>> onkey and GPIO integration.
> >>>>>>>
> >>>>>>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Notes:
> >>>>>>>     RFC v3:
> >>>>>>>     - Drop wakeup-source.
> >>>>>>>     RFC v2:
> >>>>>>>     - Address Dmitry's feedback:
> >>>>>>>       - Sort includes alphabetically.
> >>>>>>>       - Drop onkey->irq.
> >>>>>>>       - ret -> err in irq_handler and no initialization.
> >>>>>>>       - Break long lines and other formatting.
> >>>>>>>       - Do not clobber platform_get_irq error.
> >>>>>>>       - Do not set device parent manually.
> >>>>>>>       - Use input_set_capability.
> >>>>>>>       - Use the wakeup-source DT property.
> >>>>>>>       - Drop of_match_table.
> >>>>>>
> >>>>>> I only said that you should not be using of_match_ptr(), but you s=
till
> >>>>>> need to have of_match_table set and have MODULE_DEVICE_TABLE() for=
 the
> >>>>>> proper module loading support.
> >>>>>
> >>>>> I removed of_match_table because I no longer need compatible for th=
is --
> >>>>> there are no device tree properties and the driver is being instant=
iated
> >>>>> by the MFD driver.
> >>>>>
> >>>>> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe w=
hen
> >>>>> compiled as module? If that is the case, given what I write above, =
am I
> >>>>> correct that MODULE_DEVICE_TABLE(platform,...) would be the right t=
hing
> >>>>> to use here?
> >>>>
> >>>> Yes, if uevent generated for the device is "platform:<name>" then
> >>>> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MF=
D
> >>>> sets it up (OF modalias or platform), but you should be able to chec=
k
> >>>> the format looking at the "uevent" attribute for your device in sysf=
s
> >>>> (/sys/devices/bus/platform/...).=20
> >>>
> >>> The uevent is indeed platform.
> >>>
> >>> But since there is only one device, perhaps having a device table is
> >>> superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is mor=
e
> >>> fitting?
> >>
> >> Adding aliases for standard IDs and standard cases is almost never
> >> correct. If you need module alias, it means your ID table is wrong (or
> >> missing, which is usually wrong).
> >>
> >>>
> >>> Although I don't understand why this is even necessary when the drive=
r
> >>> name is such and the module is registered using
> >>> `module_platform_driver`...
> >>
> >> ID table and MODULE_DEVICE_TABLE() are necessary for modprobe to work.
> >=20
> > I think I understand the practical reasons. My point was that I would
> > expect the alias to be added automatically even in the case that the
> > device table is absent based solely on the driver name and the
> > registration method (*module*_*platform*_driver). Why is that not the
> > case? Obviously the driver name matching the mfd_cell name is sufficien=
t
>
> You mean add it automatically by macro-magic based on presence of
> id_table and/or of_match_table?

Yes, that plus: if id_table is present, use that for module aliases,
otherwise use driver name. In fact, I checked the platform core and it
seems to proceed in exactly this way when determining whether there is a
match. And while autoloading and probing are two different things, I
assume that we always want to consider a module for autoloading when we
know that it will probe because we have a compatible device.

> That's a good question. I cannot find answer why not, except that maybe
> no one ever wrote it...
>
>
> > for the driver to probe when it is built in so the name does seem to
> > serve as some identification for the device just as a device table entr=
y
> > would.
> >=20
> > Furthermore, drivers/input/serio/ioc3kbd.c does not seem to have an ID
> > table either, nor a MODULE_ALIAS -- is that a mistake? If not, what
> > mechanism causes the driver to probe when compiled as a module? It seem=
s
>
> You are now mixing two different things: probing of driver (so bind) and
> module auto-loading.

Yes, sorry, I meant autoloading.

> Probing is done also by driver name. Auto-loading,
> not sure, maybe by name as well?

Well probably not, otherwise it would work here too, no? Unless there
are some fundamental differences in this between PCI and platform
drivers. But the input driver is platform too and is required through
the MFD cell, so I think it should be the same scenario.

> However it is also likely that
> auto-loading is broken. Several drivers had such issues in the past.

OK, I see, thank you. I think this was the main source of my confusion
because I looked at other drivers for reference when trying to
understand which properties (name/device table) are necessary for what
action (probing/autoloading).

> Best regards,
> Krzysztof

Thank you again, kind regards,
K. B.

