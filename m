Return-Path: <linux-kernel+bounces-52441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3C849831
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD22866F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF517C96;
	Mon,  5 Feb 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JxsSb2xb"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE217BA9;
	Mon,  5 Feb 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130651; cv=none; b=DFt9u6r14nsfuDGXkRJSWGCOGH/Xzj48tjfNYna2xhsDs3s/oRNyqxNifdOPOTXeQ20bAt9TPJ1Onx9fMAD0upQdvpDAEiDbTnbX3WJmF5PAeZaY22uSUT1j2l6VNQImkAgGbzhbYwEpp8qYT7gaiH+gmvj9CSWpPqXeUY85b3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130651; c=relaxed/simple;
	bh=s50ruUjCLjDoCApuaIt2AiNVIvfod/Xls9C5WgsTrrA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDt0kYPCYzdm7otzZ0gzIarps2BGJBqDL7upvZy1kaGkrhGb3bBFvxLN47ZtlVJz6XqtcfxA95+zOAEhctAtcE71Pv+vFr00ZgxdmTXsdeBCN5pd7A6djp+yw6mVDsTXOUcKszTk8TfTYXMUrXVzWBJCaOJJ/YEA91ONxGyEbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JxsSb2xb; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 39230100008;
	Mon,  5 Feb 2024 13:57:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 39230100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707130638;
	bh=Kk4OP6bjX2Ro+Tz1j4gEBP3C3ivNG1Xu1oZHy2OISkk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=JxsSb2xbm18N2P6xmCd1vozFfehPaX5S8DxhYbVzNEqPOHE4z24OjZODHtQgdwpSc
	 txRBCuJo+W92a74xLdxarVPueDtgZl/NcORaEaJ1101FL9KuDeXAKYdI/OaLqQzWQF
	 gsUbbbRi7ZYpRw6xZnjl+1SFb/5LMT2/YrtqoDBtOyDDVMWYPT4vU+shhcce9LTPKW
	 Q6RbB1UpUEv1Kud4EG/9muI2D8ZNWMI1uYl9z8PWFxhmFPI+UYtBEO2JBbvBb9yQJW
	 1dVETUf0ngX0hDALBo3v2dwNqta91qCMixH4It3Az0UIpEERDMep9N3Q3+Cnm+dl1g
	 bjhBfTpVELCpw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 13:57:18 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 13:57:17 +0300
Date: Mon, 5 Feb 2024 13:57:17 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones
	<lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
CC: Martin Kurbanov <mmkurbanov@salutedevices.com>, Jacek Anaszewski
	<jacek.anaszewski@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240205105717.bmppb3xalmmqapqg@CAB-WSD-L081021>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
 <20240125130049.GF74950@google.com>
 <20240126122310.hrs37vybo2wnxto3@CAB-WSD-L081021>
 <2024012643-safeness-stipulate-153f@gregkh>
 <20240129141339.vvqi5z7ta7jkhvxy@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240129141339.vvqi5z7ta7jkhvxy@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183184 [Feb 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/05 06:05:00 #23358488
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Greg, Lee and Pavel,

Apologies for the ping, but I would appreciate it if you could spare a
couple of minutes to decide on the next steps. From my perspective, the
problems I previously described persist, and we need to discuss the
possible solutions.

On Mon, Jan 29, 2024 at 05:13:39PM +0300, Dmitry Rokosov wrote:
> Hello Greg,
> 
> On Fri, Jan 26, 2024 at 06:09:43AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Jan 26, 2024 at 03:23:10PM +0300, Dmitry Rokosov wrote:
> > > Hello Lee,
> > > 
> > > On Thu, Jan 25, 2024 at 01:00:49PM +0000, Lee Jones wrote:
> > > > Looping in Jacek (LEDS) and Greg (SYFS) for some knowledgable input.
> > > > 
> > > > On Fri, 12 Jan 2024, Martin Kurbanov wrote:
> > > > > On 21.12.2023 19:10, Lee Jones wrote:
> > > > > > On Thu, 07 Dec 2023, Martin Kurbanov wrote:
> > > > > > 
> > > > > >> This led-controller supports 3 pattern controllers for auto breathing or
> > > > > >> group dimming control. Each pattern controller can work in auto
> > > > > >> breathing or manual control mode. All breathing parameters including
> > > > > >> rising/falling slope, on/off time, repeat times, min/max brightness
> > > > > >> and so on are configurable.
> > > > > >>
> > > > > >> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > > > > >> ---
> > > > > >>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> > > > > >>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> > > > > >>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> > > > > >>  3 files changed, 1031 insertions(+)
> > > > > >>  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > > > > > 
> > > > > > This interface is bananas.  Exposing an entire register interface to
> > > > > > sysfs does not sit will with me at all.  When we add support to a sysfs
> > > > > > class, we usually require it to be generic and work across all devices.
> > > > > > Adding device specific interfaces is generally decried and to be
> > > > > > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > > > > > ABI and we have to support it forever.
> > > > > > 
> > > > > > A far better approach would be to add support for this in userspace
> > > > > > instead  You can use the standard I2C character device API to achieve
> > > > > > the same result.  That way we don't have the same level of commitment
> > > > > > and is generally a much more flexible/future-proof.
> > > > > > 
> > > > > 
> > > > > I used sysfs similarly to other LED drivers (for example, leds-lm3533).
> > > > > Additionally, the controller has interrupts about the completion of the pattern,
> > > > > which is best to handle in the kernel. In the case of implementation in user
> > > > > mode, there may be synchronization problems, as the controller has several
> > > > > memory pages that can be switched by writing the page number to register 0xF0.
> > > > 
> > > > leds-lm3533 is a 12 year old legacy exception AND has less than half of
> > > > the sysfs exports proposed here.  What makes aw200xx so different it
> > > > needs to an incomparable interface to any other that we currently
> > > > support?
> > > 
> > > >From my point of view, direct I2C raw requests from userspace are not a
> > > good solution as well due to synchronization problems, as Martin
> > > mentioned in the previous message.
> > 
> > Sorry, I missed this, what is the synchronization problem?  This is an
> > led, shouldn't have any real specific performance issues.
> > 
> 
> By referring to the "synchronization problem," I am highlighting the
> following issue:
> 
> The LED controller incorporates PAGE registers for accessing multiple
> registers, which can be explained with the analogy of a "window." When
> the driver needs to update the brightness value or perform any other
> action, it must select the appropriate PAGE window to access the
> register offset. It is challenging to believe that the driver,
> responsible for adjusting brightness values, can be synchronized with
> raw userspace I2C transactions in any manner. However, synchronization
> is necessary because the hardware pattern employs the same PAGE
> registers used for brightness and other parameter setups.
> 
> In the kernel driver, this issue is addressed through the simple mutex
> usage.
> 
> > > We have honestly been attempting to integrate this functionality into
> > > the official LED pattern interface, but it cannot be achieved due to the
> > > absence of this interface's functionality:
> > > 1) Page-based access
> > > 2) Interrupts
> > 
> > I don't understand this, sorry.
> > 
> 
> The PAGE window registers, which I described a few lines earlier, are
> relevant. Regarding interrupts, the AW200XX LED controller incorporates
> a hardware pattern event based on a straightforward GPIO-connected
> interrupt line. It's advisable to asynchronously wait for the hardware
> pattern ending event using methods like poll() and to notify userspace
> using sysfs_notify().
> 
> > > HW patterns are very useful mechanism to draw animation faster without
> > > any interactions with CPU, so I think we need to find the best architect
> > > approach for its integration.
> > 
> > The CPU is totally involved here, that should be identical.
> > 
> 
> Currently, we have two methods for playing LED animations:
> 1) Direct sysfs access to the appropriate brightness node.
> 2) LED-triggered pattern with hrtimer.
> 
> The first method always runs a separate kworker on each access,
> resulting in slow performance and complete CPU involvement.  The second
> method is straightforward in terms of hardware pattern mechanism
> synchronization, but it lacks specific support for the appropriate
> hardware (as mentioned earlier). In this option, the CPU is not entirely
> engaged because we can free the CPU from the waiting task until the LED
> pattern is executed.
> 
> > > What is an alternative way to access such a hardware pattern interface?
> > > Debugfs? Or perhaps we should consider extending the LED pattern
> > > interface?
> > 
> > Or again, userspace.
> > 
> > debugfs is for debugging.
> > 
> > thanks,
> > 
> > greg k-h

-- 
Thank you,
Dmitry

