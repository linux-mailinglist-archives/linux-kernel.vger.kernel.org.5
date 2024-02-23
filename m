Return-Path: <linux-kernel+bounces-78291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0275861177
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6134A1F21C91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29C7AE7F;
	Fri, 23 Feb 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZSQ/HTX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FE7AE78;
	Fri, 23 Feb 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691213; cv=none; b=OdrTM2kuD2TxOriE+0KUooVEZoTh59RjIDk+IGLQcP9eIXzfyWuY4yUuXLEakiGuzUr+wTWzqAaGnCRiSV7TmfmsZFZukSIwLfq48DEJsdxlYPu0Og0AAMMh+NUW9uXoG5hHTC6G1/QzwNfERVlC7bhGQoWVD719r/brFM4edNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691213; c=relaxed/simple;
	bh=m//cWAePIv4cTZDYri/URPe8qx3PAjrr8Fa4bEJ/jYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDvMr1CYg2iRmhgQQJpJsM7baarWswrpTbR6W3u+K6Wacdi2TzHaVghlyC9Z1/HfeS9LHCAthrqIyHcLbUmaqe/SgimNuz5CkyF/7axPgoN7gJag7W6F9365gyE8+q9yvVxL/23TJ3WEYVjJgJt0jmkjNeO6NzRjjJxIlWTpWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZSQ/HTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB87C433C7;
	Fri, 23 Feb 2024 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708691212;
	bh=m//cWAePIv4cTZDYri/URPe8qx3PAjrr8Fa4bEJ/jYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZSQ/HTX2hNdNLIy3vkQ2Mhcy7B3AcZ4GJzTIslwj7FQ9QGqb8MtlDta23N9Vwe3y
	 lrts2nTwptGS/hOtaF7+eA6l3i8xvLLu6d2mb9F1zdiv+n1cHntDc/nedbnOWYAeuB
	 01Ncv/gZk50JdISyyt5DYanwA69wt70ASDNE7D21By/0wkVq8FBhYVnPDaioShYGTT
	 ln5E16eNjwSVj0tLN6ftkdewOjFQZiPXKGfRPY3lmXnP/RZL27ltagxjwOgUiJUg0D
	 SOg1MY5nYbXlOq/NQKd0Zr7V5psWedQv0i0fHhCIfcRvzKR9DryEmp+ZWCkAftnTkP
	 jlPDUqkd21I/w==
Date: Fri, 23 Feb 2024 13:26:41 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: andy.shevchenko@gmail.com, George Stark <gnstark@salutedevices.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Aleksandr Mezin
 <mezin.alexander@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-gpio@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] devm-helpers: Add resource managed version of mutex
 init
Message-ID: <20240223132641.3e2ba16c@dellmb>
In-Reply-To: <Zde_s8iecR2ArKjC@surfacebook.localdomain>
References: <20240222145838.12916-1-kabel@kernel.org>
	<Zde_s8iecR2ArKjC@surfacebook.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 23:42:11 +0200
andy.shevchenko@gmail.com wrote:

> Thu, Feb 22, 2024 at 03:58:37PM +0100, Marek Beh=C3=BAn kirjoitti:
> > A few drivers are doing resource-managed mutex initialization by
> > implementing ad-hoc one-liner mutex dropping functions and using them
> > with devm_add_action_or_reset(). Help drivers avoid these repeated
> > one-liners by adding managed version of mutex initialization.
> >=20
> > Use the new function devm_mutex_init() in the following drivers:
> >   drivers/gpio/gpio-pisosr.c
> >   drivers/gpio/gpio-sim.c
> >   drivers/gpu/drm/xe/xe_hwmon.c
> >   drivers/hwmon/nzxt-smart2.c
> >   drivers/leds/leds-is31fl319x.c
> >   drivers/power/supply/mt6370-charger.c
> >   drivers/power/supply/rt9467-charger.c =20
>=20
> Pardon me, but why?
>=20
> https://lore.kernel.org/linux-leds/20231214173614.2820929-1-gnstark@salut=
edevices.com/
>=20
> Can you cooperate, folks, instead of doing something independently?

Thanks Andy for pointing to George's patch series.

I can drop the mutex_init() part and add just the debugfs part.

Marek

