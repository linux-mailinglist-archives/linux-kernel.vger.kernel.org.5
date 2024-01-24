Return-Path: <linux-kernel+bounces-37419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF12383B03F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215AFB2EDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD186AC7;
	Wed, 24 Jan 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A9AwBggs"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3112AAFB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116983; cv=none; b=g2AabDBpg6KhLuZE3kdQNRSGlMR+q77wxl7qOeEe0Hz7v3MTpCiihC4vq8gbpDWcNmhVp6pWQbtIE8Tn5qHiLDejWNkgXIHwJQSDCWhCu8rVzFq03fpSAjshQsAgAwdiLTK80RkV1Gz+EmR3KFesCU+y5NLRfsKxrRRcm2OGb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116983; c=relaxed/simple;
	bh=1qsiuKA8J/U5HtTK7VX7ozeNvAKnJpMbUXqVOveYMK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSKM2MQnK5w9xOTaC2/a1kVpPBSort/cbRwE9Bmk5MBv3Qn8xSsiDK+mblHHUa7sqsP4XXsR74yBEbvYLXAf9b6XoNO7kX//1vWAZ8N2IE5CMDAMEAEyLYcHW9jgilv4jM/Qk9ZQZ0U0QFNGaKew+TRwOImQqMHJB+D0HRy2PMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A9AwBggs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F8F040003;
	Wed, 24 Jan 2024 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706116979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NR9X+f8hzi6LukUwFvLmWHpES6M8Hue32FNHn1qEfC8=;
	b=A9AwBggsTrv9qKpv6izgrNets4YClPaiv+ZV53LkzmNlflbQYEvLMKLE1SKOr5qUOF5uQn
	PRlSFVqNDppd2AyZmp3b5p0MEpw5b/3zahbcChm0Xe9JXLZ/E6EhuVN+4Aiej1kWHY+iif
	iP8YfZOGANGosY1RZJWV/6YyMYE4z6GeecvRyZOY8087BCntZNl+nzDyKcQ1Wzw3zOSe3c
	vr8uSTczAaTzRZephI0zvW1/z44Q08mlLywAagwm3BgmN9v9kiNXLhz2orkgIeKMyjoHNY
	ZXW+TSj0lWjoZ8WcPncTAd/lKaF7Fd5x+zVRyIhqYrUoBExodg1RlFQ2BxJALw==
Date: Wed, 24 Jan 2024 18:22:56 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, regressions@lists.linux.dev, =?UTF-8?B?UmFmYcWCIE1pxYJl?=
 =?UTF-8?B?Y2tp?= <rafal@milecki.pl>, Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev,
 Sven Peter <sven@svenpeter.dev>, Michael Walle <michael@walle.cc>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Message-ID: <20240124182256.776c164b@xps-13>
In-Reply-To: <20240122153442.7250-1-arnd@kernel.org>
References: <20240122153442.7250-1-arnd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Arnd,

arnd@kernel.org wrote on Mon, 22 Jan 2024 16:34:10 +0100:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc=
1 on
> Apple M1, which (in downstream dts files) has multiple nvmem cells that u=
se the
> same byte address. This causes the device probe to fail with

o_O	I didn't even know this was allowed...

> [    0.605336] sysfs: cannot create duplicate filename '/devices/platform=
/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
> [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                =
 6.8.0-rc1-arnd-5+ #133
> [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
> [    0.605362] Call trace:
> [    0.605365]  show_stack+0x18/0x2c
> [    0.605374]  dump_stack_lvl+0x60/0x80
> [    0.605383]  dump_stack+0x18/0x24
> [    0.605388]  sysfs_warn_dup+0x64/0x80
> [    0.605395]  sysfs_add_bin_file_mode_ns+0xb0/0xd4
> [    0.605402]  internal_create_group+0x268/0x404
> [    0.605409]  sysfs_create_groups+0x38/0x94
> [    0.605415]  devm_device_add_groups+0x50/0x94
> [    0.605572]  nvmem_populate_sysfs_cells+0x180/0x1b0
> [    0.605682]  nvmem_register+0x38c/0x470
> [    0.605789]  devm_nvmem_register+0x1c/0x6c
> [    0.605895]  apple_efuses_probe+0xe4/0x120
> [    0.606000]  platform_probe+0xa8/0xd0
>=20
> As far as I can tell, this is a problem for any device with multiple cell=
s on
> different bits of the same address. Avoid the issue by changing the file =
name
> to include the first bit number.

There is only one bit number right? We are talking about byte offsets
so this value can only range from 0 to 7? If we understand each other
correctly then why not, I'm fine with the extra ",0" thing.

> Fixes: 0088cbc19276 ("nvmem: core: Expose cells through sysfs")
> Link: https://github.com/AsahiLinux/linux/blob/bd0a1a7d4/arch/arm64/boot/=
dts/apple/t600x-dieX.dtsi#L156
> Cc: regressions@lists.linux.dev
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: asahi@lists.linux.dev
> Cc: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks,
Miqu=C3=A8l

