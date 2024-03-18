Return-Path: <linux-kernel+bounces-105770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075ED87E419
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590E6280CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5422EF8;
	Mon, 18 Mar 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="E0RZTrf/"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5A8814;
	Mon, 18 Mar 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747030; cv=none; b=h2KGF7pxVQzDA/OOQTXskGcXZAzcL/4nRih1jJfWF/wLwWq8aS0Jck2axaDhxyb+oan8mSc+ihQBcr8edd/mf5kjH0A7GzBlx51aYaIiumR7cs+JHer9qUqplPhA8nwiSe0RE6lzr7qqMJCE+XGN5TPZlCoJudSXR9jSwN+sXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747030; c=relaxed/simple;
	bh=YH92QyytgF2Vk+8Foxjm0IOmwgRxcwotGO1YJLK3bK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh/Kp2xGMHg6QqFqA2Jnh1ueyeityGGWHqXYB/5ptKkqgOVYmaY6f2zJ9ThchwQb4So4GA4h+SoDDPlU/F4Zxif/ee/K24MukY0Bs6qYb7yymQXJnU1icLynkb8MWL0z+xFQ8UarKQpEcey9JCFWh9HzfK5Er0HTfxnpgoYJlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=E0RZTrf/; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D250612000D;
	Mon, 18 Mar 2024 10:30:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D250612000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710747024;
	bh=N3H/ckGw4dmh0FQqoMcHKXAuQpg9auGFCjJHxuokWNQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=E0RZTrf/QZcLIXI6ypUnbSa8QRAUNEfZvaa4VKX/3sEwjD7lMApSMc0qZvA+9BmLT
	 sXFDrv4yiKntavgXxUJ8mLKEUeEBnqCRvO5Q2AQGaGXA4lpMdPE7nnCT+kpZHCZZ0U
	 ZJL/7g0DbvlSv6BpEMAiUjmP1F2yFUR9e4kJVT0o7bkwStrPQjDqaqkADskKaZpzmc
	 Uv4pOm1Mp96ppNy+D/8GE7IoXwvq9jHQsV8ARISc4bm1S2FDWoKRLYvAUEuWMfQqHm
	 A0YAgHIPXw5zoFbma9AD6JcTDUCFalTo5E1XjDE1+qQrci0XVNxV54b7RfCavno7us
	 swyzlNcDmWctg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 18 Mar 2024 10:30:24 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 10:30:24 +0300
Date: Mon, 18 Mar 2024 10:30:24 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH 00/25] Introduce support of audio for Amlogic A1 SoC
 family
Message-ID: <20240318073024.coeygkbjd5ada6we@CAB-WSD-L081021>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <4bb2fa50-0944-456d-b51b-449a2bd9bb69@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4bb2fa50-0944-456d-b51b-449a2bd9bb69@linaro.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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

Hello Neil,

On Fri, Mar 15, 2024 at 05:53:05PM +0100, Neil Armstrong wrote:
> Hi Jan!
> 
> On 15/03/2024 00:21, Jan Dakinevich wrote:
> > This series includes the following:
> > 
> >   - new audio clock and reset controller data and adaptation for it of existing
> >     code (patches 0001..0004);
> > 
> >   - adaptation of existing audio components for A1 Soc (patches 0005..0021);
> > 
> >   - handy cosmetics for dai-link naming (patches 0022..0023);
> > 
> >   - integration of audio devices into common trees (patch 0024);
> > 
> >   - audio support bring up on Amlogic ad402 reference board (patch 0025). This
> >     patch is not actually checked on real hardware (because all ad402 that we had
> >     were burned out). This patch is based on ad402's schematics and on experience
> >     with our own hardware (which is very close to reference board);
> 
> Thanks for your serie, it's nice you're working on upstreaming this feature.
> 
> In my opinion it's fine to have a "big" initial serie if you're not sure
> if your changes are ok, but next time add the RFC tag so we know it's not
> a final changeset and you seek advices.
> 
> Overall the code is clean and your patch order makes sense if they were meant
> to be applied by a single maintainer, but in this case it will be split
> into multiple subsystems so it's better to split them as Jerome explained
> to ease review and the maintainers process.
> 
> Don't hesitate discussing with us in the #linux-amlogic IRC channel
> on Libera.Chat, the goal is to reduce the number of patch version and
> ease the review and maintainance process.
> 
> Concerning the link-name property, I think it should be done afterwards
> since it's not necessary to support audio on A1, and I think it could
> be extended to other SoC boards (which would be a great feature).

If you don't mind, I will send this change in a separate patch series.
Although I don't have support for all boards in the linux-amlogic, I can
test it on some Khadas and Odroid boards on my side. I will prepare link
names for them.

> > 
> > Dmitry Rokosov (2):
> >    ASoC: dt-bindings: meson: introduce link-name optional property
> >    ASoC: meson: implement link-name optional property in meson card utils
> > 
> > Jan Dakinevich (23):
> >    clk: meson: a1: restrict an amount of 'hifi_pll' params
> >    clk: meson: axg: move reset controller's code to separate module
> >    dt-bindings: clock: meson: add A1 audio clock and reset controller
> >      bindings
> >    clk: meson: a1: add the audio clock controller driver
> >    ASoC: meson: codec-glue: add support for capture stream
> >    ASoC: meson: g12a-toacodec: fix "Lane Select" width
> >    ASoC: meson: g12a-toacodec: rework the definition of bits
> >    ASoC: dt-bindings: meson: g12a-toacodec: add support for A1 SoC family
> >    ASoC: meson: g12a-toacodec: add support for A1 SoC family
> >    ASoC: meson: t9015: prepare to adding new platforms
> >    ASoC: dt-bindings: meson: t9015: add support for A1 SoC family
> >    ASoC: meson: t9015: add support for A1 SoC family
> >    ASoC: dt-bindings: meson: axg-pdm: document 'sysrate' property
> >    ASoC: meson: axg-pdm: introduce 'sysrate' property
> >    pinctrl/meson: fix typo in PDM's pin name
> >    ASoC: dt-bindings: meson: meson-axg-audio-arb: claim support of A1 SoC
> >      family
> >    ASoC: dt-bindings: meson: axg-fifo: claim support of A1 SoC family
> >    ASoC: dt-bindings: meson: axg-pdm: claim support of A1 SoC family
> >    ASoC: dt-bindings: meson: axg-sound-card: claim support of A1 SoC
> >      family
> >    ASoC: dt-bindings: meson: axg-tdm-formatters: claim support of A1 SoC
> >      family
> >    ASoC: dt-bindings: meson: axg-tdm-iface: claim support of A1 SoC
> >      family
> >    arm64: dts: meson: a1: add audio devices
> >    arm64: dts: ad402: enable audio
> > 
> >   .../bindings/clock/amlogic,a1-audio-clkc.yaml |  83 +++
> >   .../reset/amlogic,meson-axg-audio-arb.yaml    |  10 +-
> >   .../bindings/sound/amlogic,axg-fifo.yaml      |   8 +
> >   .../bindings/sound/amlogic,axg-pdm.yaml       |   5 +
> >   .../sound/amlogic,axg-sound-card.yaml         |  12 +-
> >   .../sound/amlogic,axg-tdm-formatters.yaml     |  22 +-
> >   .../bindings/sound/amlogic,axg-tdm-iface.yaml |   6 +-
> >   .../bindings/sound/amlogic,g12a-toacodec.yaml |   1 +
> >   .../bindings/sound/amlogic,gx-sound-card.yaml |   6 +
> >   .../bindings/sound/amlogic,t9015.yaml         |   4 +-
> >   .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 126 ++++
> >   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 471 +++++++++++++++
> >   drivers/clk/meson/Kconfig                     |  18 +
> >   drivers/clk/meson/Makefile                    |   2 +
> >   drivers/clk/meson/a1-audio.c                  | 556 ++++++++++++++++++
> >   drivers/clk/meson/a1-audio.h                  |  58 ++
> >   drivers/clk/meson/a1-pll.c                    |   8 +-
> >   drivers/clk/meson/axg-audio.c                 |  95 +--
> >   drivers/clk/meson/meson-audio-rstc.c          | 109 ++++
> >   drivers/clk/meson/meson-audio-rstc.h          |  12 +
> >   drivers/pinctrl/meson/pinctrl-meson-a1.c      |   6 +-
> >   .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++
> >   .../reset/amlogic,meson-a1-audio-reset.h      |  29 +
> >   .../dt-bindings/sound/meson-g12a-toacodec.h   |   5 +
> >   sound/soc/meson/axg-pdm.c                     |  10 +-
> >   sound/soc/meson/g12a-toacodec.c               | 298 ++++++++--
> >   sound/soc/meson/meson-card-utils.c            |  12 +-
> >   sound/soc/meson/meson-codec-glue.c            | 174 ++++--
> >   sound/soc/meson/meson-codec-glue.h            |  23 +
> >   sound/soc/meson/t9015.c                       | 326 +++++++++-
> >   30 files changed, 2394 insertions(+), 223 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
> >   create mode 100644 drivers/clk/meson/a1-audio.c
> >   create mode 100644 drivers/clk/meson/a1-audio.h
> >   create mode 100644 drivers/clk/meson/meson-audio-rstc.c
> >   create mode 100644 drivers/clk/meson/meson-audio-rstc.h
> >   create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
> >   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> > 
> 

-- 
Thank you,
Dmitry

