Return-Path: <linux-kernel+bounces-42864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC138407EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3550528504E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D3965BB5;
	Mon, 29 Jan 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rtRT37vg"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CF65BA2;
	Mon, 29 Jan 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537634; cv=none; b=p8Ohe9wkMFhFiTQuDaWyWoAkb9Pw3e9DTJKhwZpU6rDnAOmv81XsTU2utHm8+EzM4ESDAoZILw/G33tihiQgbXYfH4HD4yOD9hhSLu1keqxupgNk5oNyBu0iFIE1fxYuOFJHF0WMg56qvJH/Pz46GCZejTYLC+IQXiOedVOiADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537634; c=relaxed/simple;
	bh=uYTX+9ICWcOaNpLPJTcnkqigRDCQty6rU2i5SFicHLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQMSQPV7Rt4Z3cbUO7SJ/8w3kJep511RVeb1ZP6F9LqNUPHNCI9+KjqzV8NCRWQd3KhHfIWnEOb/OZEGb6hk8kEVbujz34Q4RFTvmhQCTIDjgHC75ho1MpH81/4eN7hCaVba6IGmXAnAwWF/D3kCnybuhgiQbIFvDgb9sebOBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rtRT37vg; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 559FC120009;
	Mon, 29 Jan 2024 17:13:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 559FC120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706537620;
	bh=/957594gdU7RsdUlFl6RPQN0cjXpCHV3IADhbxYhBI0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=rtRT37vgnlB1HkZnN7T+DsixqgqsWHEjiEvWPA6JjJAKl6r8lxy5Wl1NKJeOTr94B
	 4NnoqDL4XYeRG2JJDPx/aGqA1GVgfWyzmDArESTHLPU6W0+xtBpeis+iPsft7fvGM9
	 8Um1Ts5nZNQACRf2xaX97T1XSvooMOhMdOgTOBxuIeCcidOL2yaExXzndp3SYAOUwV
	 eaagkRimlx9MW7diCYvwtdCVpNkS5rs+H/ulkhNMfT6J9kYE37nLbmhRW2b6kyS7df
	 KBwwFJEpNU206Kj2owFbXn8VtXzrxtUa3oq3izob3GZgmIbYSU8wvX+iR8XZDFNTSH
	 6hzveKhrcsB4Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 17:13:40 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:13:39 +0300
Date: Mon, 29 Jan 2024 17:13:39 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Lee Jones <lee@kernel.org>, Martin Kurbanov
	<mmkurbanov@salutedevices.com>, Jacek Anaszewski
	<jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240129141339.vvqi5z7ta7jkhvxy@CAB-WSD-L081021>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
 <20240125130049.GF74950@google.com>
 <20240126122310.hrs37vybo2wnxto3@CAB-WSD-L081021>
 <2024012643-safeness-stipulate-153f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024012643-safeness-stipulate-153f@gregkh>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
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
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/29 10:45:00 #23482469
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Greg,

On Fri, Jan 26, 2024 at 06:09:43AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Jan 26, 2024 at 03:23:10PM +0300, Dmitry Rokosov wrote:
> > Hello Lee,
> > 
> > On Thu, Jan 25, 2024 at 01:00:49PM +0000, Lee Jones wrote:
> > > Looping in Jacek (LEDS) and Greg (SYFS) for some knowledgable input.
> > > 
> > > On Fri, 12 Jan 2024, Martin Kurbanov wrote:
> > > > On 21.12.2023 19:10, Lee Jones wrote:
> > > > > On Thu, 07 Dec 2023, Martin Kurbanov wrote:
> > > > > 
> > > > >> This led-controller supports 3 pattern controllers for auto breathing or
> > > > >> group dimming control. Each pattern controller can work in auto
> > > > >> breathing or manual control mode. All breathing parameters including
> > > > >> rising/falling slope, on/off time, repeat times, min/max brightness
> > > > >> and so on are configurable.
> > > > >>
> > > > >> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > > > >> ---
> > > > >>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> > > > >>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> > > > >>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> > > > >>  3 files changed, 1031 insertions(+)
> > > > >>  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > > > > 
> > > > > This interface is bananas.  Exposing an entire register interface to
> > > > > sysfs does not sit will with me at all.  When we add support to a sysfs
> > > > > class, we usually require it to be generic and work across all devices.
> > > > > Adding device specific interfaces is generally decried and to be
> > > > > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > > > > ABI and we have to support it forever.
> > > > > 
> > > > > A far better approach would be to add support for this in userspace
> > > > > instead  You can use the standard I2C character device API to achieve
> > > > > the same result.  That way we don't have the same level of commitment
> > > > > and is generally a much more flexible/future-proof.
> > > > > 
> > > > 
> > > > I used sysfs similarly to other LED drivers (for example, leds-lm3533).
> > > > Additionally, the controller has interrupts about the completion of the pattern,
> > > > which is best to handle in the kernel. In the case of implementation in user
> > > > mode, there may be synchronization problems, as the controller has several
> > > > memory pages that can be switched by writing the page number to register 0xF0.
> > > 
> > > leds-lm3533 is a 12 year old legacy exception AND has less than half of
> > > the sysfs exports proposed here.  What makes aw200xx so different it
> > > needs to an incomparable interface to any other that we currently
> > > support?
> > 
> > >From my point of view, direct I2C raw requests from userspace are not a
> > good solution as well due to synchronization problems, as Martin
> > mentioned in the previous message.
> 
> Sorry, I missed this, what is the synchronization problem?  This is an
> led, shouldn't have any real specific performance issues.
> 

By referring to the "synchronization problem," I am highlighting the
following issue:

The LED controller incorporates PAGE registers for accessing multiple
registers, which can be explained with the analogy of a "window." When
the driver needs to update the brightness value or perform any other
action, it must select the appropriate PAGE window to access the
register offset. It is challenging to believe that the driver,
responsible for adjusting brightness values, can be synchronized with
raw userspace I2C transactions in any manner. However, synchronization
is necessary because the hardware pattern employs the same PAGE
registers used for brightness and other parameter setups.

In the kernel driver, this issue is addressed through the simple mutex
usage.

> > We have honestly been attempting to integrate this functionality into
> > the official LED pattern interface, but it cannot be achieved due to the
> > absence of this interface's functionality:
> > 1) Page-based access
> > 2) Interrupts
> 
> I don't understand this, sorry.
> 

The PAGE window registers, which I described a few lines earlier, are
relevant. Regarding interrupts, the AW200XX LED controller incorporates
a hardware pattern event based on a straightforward GPIO-connected
interrupt line. It's advisable to asynchronously wait for the hardware
pattern ending event using methods like poll() and to notify userspace
using sysfs_notify().

> > HW patterns are very useful mechanism to draw animation faster without
> > any interactions with CPU, so I think we need to find the best architect
> > approach for its integration.
> 
> The CPU is totally involved here, that should be identical.
> 

Currently, we have two methods for playing LED animations:
1) Direct sysfs access to the appropriate brightness node.
2) LED-triggered pattern with hrtimer.

The first method always runs a separate kworker on each access,
resulting in slow performance and complete CPU involvement.  The second
method is straightforward in terms of hardware pattern mechanism
synchronization, but it lacks specific support for the appropriate
hardware (as mentioned earlier). In this option, the CPU is not entirely
engaged because we can free the CPU from the waiting task until the LED
pattern is executed.

> > What is an alternative way to access such a hardware pattern interface?
> > Debugfs? Or perhaps we should consider extending the LED pattern
> > interface?
> 
> Or again, userspace.
> 
> debugfs is for debugging.
> 
> thanks,
> 
> greg k-h

-- 
Thank you,
Dmitry

