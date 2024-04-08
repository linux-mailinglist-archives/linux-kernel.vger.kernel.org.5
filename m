Return-Path: <linux-kernel+bounces-135838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEAC89CBF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C20A1F28954
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD0145B0B;
	Mon,  8 Apr 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="B9mKlpvx"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795D14535A;
	Mon,  8 Apr 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602069; cv=none; b=csG80/Xrn96BlYvbx4Shfay8ufY+oe/Y7QENWQz3Kg5At3CfwskAESGLhelYZSNzgWZiHZ1mq2+pcS8i2PbTk/O3J7EhHUurIzqQY2YDG6yLWVVi8GPfgibclUlMi1g8j/XmRWilfe84h5LjO+wi2g49I8rvtXXsOJAZ0WAE1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602069; c=relaxed/simple;
	bh=OzTz5vnhDu5Bd/u1q/Nnnkhy4wfxmnRV71V3HWJ9ckc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYugWYmUCtaZ3ZQD8I1Eb4ZniJNweeL8+g7jupKQthe+PiMPNYPY+44xGlQoREvk/um7wCGpxHA1M8MJjidq4FHOodsCp6ZVZP5FPUxrfMq7icdp/X+hvzbHwSmQumqtQl7/OOISYvrlTpCBNAFlFTGHgJ546hGQGoACsITASqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=B9mKlpvx; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1D9B9120023;
	Mon,  8 Apr 2024 21:47:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1D9B9120023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712602065;
	bh=j6Pvh7ii/4E5kEvtzQo/0jLzLa8anfIJuWpWiYdLJ2A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=B9mKlpvxUeWHck4G567ll5BTEaUMz9pFZsXNelEirg4PyMG5uJkEnYdaAanvUf+nV
	 6WCMxzEokm79CE0YIEUtmbJDUgxzKp7/UIbJe3N3cHLfmcuy0mdPKg9ppVaoRWqhlw
	 YlTyZK3577X4WOYhxk+PvYotKVjVWO1evfV+bXLujyw5A+S8lgx7WEb9z348XmoiCA
	 ydbSOZMkJaVcLo4PobcA6AkFWSFXY+dHn2lbdFiyLaj63etnIYVUO0ZGee3df+7eKV
	 q72udjpDPVnHAaNm1Aqh3zBYMu5h4+jFrpufz0+ljAhYgqTTU9HMPQsl27gyp5X4os
	 F5vG7OLtHgj+w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 21:47:44 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Apr
 2024 21:47:44 +0300
Date: Mon, 8 Apr 2024 21:47:44 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Mark Brown <broonie@kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>, <neil.armstrong@linaro.org>,
	<lgirdwood@gmail.com>, <conor+dt@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/2] ASoC: meson: implement link-name optional
 property in meson card utils
Message-ID: <20240408184744.nfktcppdqewurmgg@CAB-WSD-L081021>
References: <20240408164947.30717-1-ddrokosov@salutedevices.com>
 <20240408164947.30717-3-ddrokosov@salutedevices.com>
 <1j1q7fpv1n.fsf@starbuckisacylon.baylibre.com>
 <20240408184041.3jcav5tabxiblpn4@CAB-WSD-L081021>
 <51b39153-d1a4-4e7f-9b30-8c77fc4ee46f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51b39153-d1a4-4e7f-9b30-8c77fc4ee46f@sirena.org.uk>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184624 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/08 15:55:00 #24711186
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, Apr 08, 2024 at 07:45:00PM +0100, Mark Brown wrote:
> On Mon, Apr 08, 2024 at 09:40:41PM +0300, Dmitry Rokosov wrote:
> > On Mon, Apr 08, 2024 at 08:15:54PM +0200, Jerome Brunet wrote:
> 
> > > Userspace pcm, otherwise known as DPCM frontend, are merely that:
> > > frontends. What they do is entirely defined by the routing defined by
> > > the userspace (amixer and friends)
> 
> > > So naming the interface in DT (the FW describing the HW) after what the
> > > the userspace SW could possibly set later on is wrong.
> 
> > > Bottom line: I have mixed feeling about this change. It could allow all
> > > sort of bad names to be set.
> 
> > > The only way it could make sense HW wise is if the only allowed names
> > > where (fr|to)ddr_[abcd], which could help maps the interface and the
> > > kcontrol.
> 
> > The link-name is an optional parameter. Yes, you are right, it can be
> > routed in a way that it no longer functions as a speaker in most cases.
> > However, if you plan to use your board's dt for common purposes, you
> > should not change the common names for DAI links. But if you know that
> > you have a static setup for speakers, microphones, loopback, or other
> > references (you 100% know it, because you are HW developer of this
> > board), why not help the user understand the PCM device assignment in
> > the easiest way?
> 
> I would expect that the place to fix names based on the userspace
> configuration is in whatever userspace is using to define it's
> configurations, like a UCM config.
> 

Honestly, I have tried to find a way to rename the PCM device name or
mark it in some way (such as using a metainformation tag or any other
method), but unfortunately, my search has been unsuccessful.

> > Ultimately, it is the responsibility of the DT board developer to define
> > specific DAIs and name them based on their own knowledge about HW and
> > understanding of the board's usage purposes.
> 
> DT seems like the wrong abstraction layer here.

-- 
Thank you,
Dmitry

