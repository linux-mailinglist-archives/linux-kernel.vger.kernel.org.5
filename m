Return-Path: <linux-kernel+bounces-42887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD442840821
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A14290332
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BF1272AC;
	Mon, 29 Jan 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AESviUD4"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C474E24;
	Mon, 29 Jan 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537973; cv=none; b=JSepaynuB5dW2x0XQQaTHsKcu7tQmEEzeRGiRtix83AN2nR6xwZ0hsaZ+cL8Ma902J8EU7Xt8+UpAQD1bQxk/lnEjSZobXcvwxoSbPmNzpnQhAH+aJV9CLX/MKffF+vk4AtfbkgLf2c8hkQOFHwn4ycy4aLM28yuVWBZE56qgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537973; c=relaxed/simple;
	bh=DBI5+ltamoC/la8uCrx5/uRCiXV5fQOs4kMU6m6p4mU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSC74XP9e0WjrLkzf5o/msWtBLVFVgy0ldWbPQ/R7wgoBTwUwTruymvmk4d+3E8j3r6kBvOCTniLLoAXH5V0JiW48bPwGbZTGwHkxEuulFUBGy4aLZ3CAg4FM9f9NX5+CrML6bsjwWLkrJAxjnnzplDiFYHaDa2eX72IU/cHKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AESviUD4; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C0E1512000B;
	Mon, 29 Jan 2024 17:19:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C0E1512000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706537967;
	bh=7WNOpe9GGkirEoGdJnPDDhRmC2NQr+O7BpCO8Kgm7sg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=AESviUD4O3eGrdIku5y681V+0nXhIqPo6ib4DVOA5WzjLfnw4qG4g37A8J15lvlrN
	 DeQPg9hmUiQLUH/MLLLFgBrLrD6Kr4CF9cl9vyJ3G74PO/sBKTHqwCrLahinJ58HsL
	 tkezHI+c7RjKCvgfVzBebX16ZDMxsGSOCHGXkcigAiMfS1OV262ONaUS0/FXjWt7g+
	 YkT+kRwaXXYBHKqk2Sqgjqf27o31IlR7301Fg86SO3VAJRHywAipT/DQlGXu6Goduh
	 +98lVzKykUqOamwpUeq8F7kh6gqprLyqRM0TmCCCyTccltbez2c0VXmk6XNm/n8ufb
	 roGjhVL0aYvIg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 17:19:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:19:27 +0300
Date: Mon, 29 Jan 2024 17:19:27 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Lee Jones <lee@kernel.org>, Martin Kurbanov
	<mmkurbanov@salutedevices.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel@salutedevices.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240129141927.4shshli37fb3cwen@CAB-WSD-L081021>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <ZbQ-jKD_zhonHOCa@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbQ-jKD_zhonHOCa@ucw.cz>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183011 [Jan 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/29 10:45:00 #23482469
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Pavel,

On Sat, Jan 27, 2024 at 12:21:48AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This led-controller supports 3 pattern controllers for auto breathing or
> > > group dimming control. Each pattern controller can work in auto
> > > breathing or manual control mode. All breathing parameters including
> > > rising/falling slope, on/off time, repeat times, min/max brightness
> > > and so on are configurable.
> > > 
> > > Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > > ---
> > >  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> > >  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> > >  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> > >  3 files changed, 1031 insertions(+)
> > >  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > 
> > This interface is bananas.  Exposing an entire register interface to
> > sysfs does not sit will with me at all.  When we add support to a sysfs
> > class, we usually require it to be generic and work across all devices.
> > Adding device specific interfaces is generally decried and to be
> > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > ABI and we have to support it forever.
> 
> If you do git grep hw_pattern, you should get pointers to qcom-lpg
> driver that solves similar problem, with interface that should be
> acceptable.

Thank you for pointing that out. Yes, it's a very similar situation to
ours.

But I haven't observed the merging of this driver. Was it encountering
similar issues with the sysfs interface?

-- 
Thank you,
Dmitry

