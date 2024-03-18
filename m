Return-Path: <linux-kernel+bounces-105769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75B87E414
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3309028170D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB0224CE;
	Mon, 18 Mar 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="VnGw2EO2"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56E12B76;
	Mon, 18 Mar 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746859; cv=none; b=lInWxP3wftOTYg2snWNa/8Yle7EEVDtrSgfCG+lWUA1esmxQ2rmctfJYve1RP8KwaDNWu3fX+quCZ0O/pHof+XnK6WgGSlCd0B5d1H2/IskisdjLE8Z//4BPtTJLyMrs5j4Zkrx7ZTO/ztMob60GJ/IRJHjAtxLeECF4muULCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746859; c=relaxed/simple;
	bh=ue+ngYpZQczjaWjC2/97iH40jedNa6xc3uMbfjw4jjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqqp62cx3usEnHpVkqT6XF03/rASpoAvrTwUpQhlDDz6OsMSCbaYoy6c9xvsZReF84PHbYlH4yGczDyE3Stxj+D+mZlMo4/pTvBDgpgGGiv8+DF6S7OItBHBuQXoTrWDXoSQbdgq3kD2fwIU/5w7CaYAphHjFZCRLWrXKgamzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=VnGw2EO2; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 51C11100003;
	Mon, 18 Mar 2024 10:27:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 51C11100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710746851;
	bh=6eBBMkMfZ38/VKvG5K/FQSiHY3xSbVnH219JcM7xg+0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=VnGw2EO2nPizTbHONIIGLX+5hzjAt0tn586YH2n+Nhjyhclw+v5sfCXXWLvEo7/6y
	 bd7RztKrqxLrZBw8CXY7FvdpzSlm9desv11YzbjzOS0KgMPCfL6f5J7lol/3zBQsVg
	 3FdNsw1eHzOXUOH8P2/eqVz95tneJYyiygr5588ZrluwFkgV7TX0aLL39RhD1/cV3M
	 hhhRl+onDEkQL7iEWHG/Mi7W1cqNFCeDg10qCyYLiYiis1rLwaUlt4RVGRAbvxw3aO
	 EUcR2aghhldiuGJqtEl+/bF2hdTYPZLd4Fx7WVU91rwjgVIkxvFkr6swtw+VfYjwS+
	 E9oPwXGgWH5Gw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 18 Mar 2024 10:27:31 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 10:27:30 +0300
Date: Mon, 18 Mar 2024 10:27:30 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Rob Herring <robh@kernel.org>
CC: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman
	<khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<kernel@salutedevices.com>
Subject: Re: [PATCH 22/25] ASoC: dt-bindings: meson: introduce link-name
 optional property
Message-ID: <20240318072730.3u4qbwxijreyduwi@CAB-WSD-L081021>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-23-jan.dakinevich@salutedevices.com>
 <20240317194534.GA2093375-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240317194534.GA2093375-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Rob,

On Sun, Mar 17, 2024 at 01:45:34PM -0600, Rob Herring wrote:
> On Fri, Mar 15, 2024 at 02:21:58AM +0300, Jan Dakinevich wrote:
> > From: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > 
> > The 'link-name' property is an optional DT property that allows for the
> > customization of the name associated with the DAI link and PCM stream.
> > This functionality mirrors the approach commonly utilized in Qualcomm
> > audio cards, providing flexibility in DAI naming conventions for
> > improved system integration and userspace experience.
> > 
> > It allows userspace program to easy determine PCM stream purpose, e.g.:
> >     ~ # cat /proc/asound/pcm
> >     00-00: speaker (*) :  : playback 1
> >     00-01: mics (*) :  : capture 1
> >     00-02: loopback (*) :  : capture 1
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> This needs your S-o-b as well.

I will send this change in the separate patch series, as Neil suggested
in the cover letter reply.

-- 
Thank you,
Dmitry

