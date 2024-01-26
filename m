Return-Path: <linux-kernel+bounces-40088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3983DA17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F92B2242A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064EE18EB2;
	Fri, 26 Jan 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Z0nR0MNj"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FF13FEE;
	Fri, 26 Jan 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271800; cv=none; b=OaK32+v6MXUEKhu2OHnmon5jnO//OuXLdcPGVgyBHo91F45oZfaBO8BE+4qzHj+JSjuGKNRPE/I0xTkRmy76G00oSdTVDsNfgfJMxfU3Q6XC2nSmkda5Nu0EKtVdLspw2CpF/63OY7xa0iaBsNC+2hsRGFP50fmAnne1+BnrL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271800; c=relaxed/simple;
	bh=FUoOlA7SEsmZQCCCoAomLStIAwVpeVTQ+3yZ6glGOag=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZezjzom4pSsjmmcArYWuTBaClFxZPqch+Cew8YfIO1M4kSly3SvZtJQcg0Uni/e3o688+qc/mn6lAQCx2ZH62Leka0PSqlZde2fQPzPXjPt9FvMrs8tu5ZFMFGHTshpD5oaM65+b03nEnlb+WwJExYyTjOLiD5Nr4c4jvJXs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Z0nR0MNj; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4EE99100005;
	Fri, 26 Jan 2024 15:23:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4EE99100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706271791;
	bh=tbL6XxsbbaDgXHm9IcCy2M+iiWgJnoaXzmTqbl73lsg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Z0nR0MNjy5QzdW+OjnTMli4Go//StdjUKrraQJlAYKmizAXPkQiRrKEtz6ocHRkUn
	 GhiwAsT7wim6CTv+9n8TBwVrXFH0ZuN8diV8rqf2lOFmmKGRLy+pqBKc02NuU2ZEeS
	 /xRHveCCqugHRZ7BfO1XzKSlwoYY7iFctzQCjqjOIUrTbHIEcfQc2+g4TlbOVckxlA
	 THMCiWj9uEpsee3hZ+TtvnK6TBQO04+kaSskbEU2SO7lAlO1x20T2ERuL8e+DWHwXf
	 i6LpNXSoKcnQdn776cqxm9VcYvyip41gvWYySAKBEUoTsX3t3Sd3FfK8zt3ZO1RD1s
	 sedtki/W4lZlw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Jan 2024 15:23:11 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 15:23:10 +0300
Date: Fri, 26 Jan 2024 15:23:10 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Lee Jones <lee@kernel.org>
CC: Martin Kurbanov <mmkurbanov@salutedevices.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240126122310.hrs37vybo2wnxto3@CAB-WSD-L081021>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
 <20240125130049.GF74950@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125130049.GF74950@google.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182964 [Jan 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/26 07:16:00 #23429590
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Lee,

On Thu, Jan 25, 2024 at 01:00:49PM +0000, Lee Jones wrote:
> Looping in Jacek (LEDS) and Greg (SYFS) for some knowledgable input.
> 
> On Fri, 12 Jan 2024, Martin Kurbanov wrote:
> > On 21.12.2023 19:10, Lee Jones wrote:
> > > On Thu, 07 Dec 2023, Martin Kurbanov wrote:
> > > 
> > >> This led-controller supports 3 pattern controllers for auto breathing or
> > >> group dimming control. Each pattern controller can work in auto
> > >> breathing or manual control mode. All breathing parameters including
> > >> rising/falling slope, on/off time, repeat times, min/max brightness
> > >> and so on are configurable.
> > >>
> > >> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > >> ---
> > >>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> > >>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> > >>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> > >>  3 files changed, 1031 insertions(+)
> > >>  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > > 
> > > This interface is bananas.  Exposing an entire register interface to
> > > sysfs does not sit will with me at all.  When we add support to a sysfs
> > > class, we usually require it to be generic and work across all devices.
> > > Adding device specific interfaces is generally decried and to be
> > > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > > ABI and we have to support it forever.
> > > 
> > > A far better approach would be to add support for this in userspace
> > > instead  You can use the standard I2C character device API to achieve
> > > the same result.  That way we don't have the same level of commitment
> > > and is generally a much more flexible/future-proof.
> > > 
> > 
> > I used sysfs similarly to other LED drivers (for example, leds-lm3533).
> > Additionally, the controller has interrupts about the completion of the pattern,
> > which is best to handle in the kernel. In the case of implementation in user
> > mode, there may be synchronization problems, as the controller has several
> > memory pages that can be switched by writing the page number to register 0xF0.
> 
> leds-lm3533 is a 12 year old legacy exception AND has less than half of
> the sysfs exports proposed here.  What makes aw200xx so different it
> needs to an incomparable interface to any other that we currently
> support?

From my point of view, direct I2C raw requests from userspace are not a
good solution as well due to synchronization problems, as Martin
mentioned in the previous message.

We have honestly been attempting to integrate this functionality into
the official LED pattern interface, but it cannot be achieved due to the
absence of this interface's functionality:
1) Page-based access
2) Interrupts

HW patterns are very useful mechanism to draw animation faster without
any interactions with CPU, so I think we need to find the best architect
approach for its integration.

What is an alternative way to access such a hardware pattern interface?
Debugfs? Or perhaps we should consider extending the LED pattern
interface?

-- 
Thank you,
Dmitry

