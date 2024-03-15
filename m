Return-Path: <linux-kernel+bounces-104595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1EF87D0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FB1B223B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19040BEE;
	Fri, 15 Mar 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cATWngLj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91464596F;
	Fri, 15 Mar 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517843; cv=none; b=rBnz6FyxgNgdd8SBCNKzZ+iQXatubItz3A3PamDq9oX7014/QeOCk9LyfpbBZaQKAqol6HgQiAncBz3kbg4LIcW5D8/KEa/8Nx2vFou7I2HgbwyUnfDa7yzUtA1b9bDOvOY5xkEnJ5kukPIKAqaiy/MKpPuG/o+H0t0KMjSLZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517843; c=relaxed/simple;
	bh=6q19b+fiofsjhkT1rQDSO2sq7lO0s2NotCj9IMtQRaY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZZVmVLglcs6EOApVXFDeGyFJ2mH7rdeJntokn+CyWQWUIYFEIHyVJSsotYL8/QbM0AYpoKpy/CJwfpkzQC5SPzIGVqPkyb4DN41a9zVNiG9cOmaVCbJe7iiP2n20JNP7xV5FPZNK05Tp5UQ0tWxGFdKXtfb4qUHAnQQhZ34R2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cATWngLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D25C433C7;
	Fri, 15 Mar 2024 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517842;
	bh=6q19b+fiofsjhkT1rQDSO2sq7lO0s2NotCj9IMtQRaY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cATWngLj0V0uBL2vyvNEcza3aKIZ7Np98iE1Fp7ZewG/iAYpswJuJuFe9bH49wWaX
	 mnvcdWiUR04/OvSJJ21K3bFM+mpakZDyZjGqOPSAQ1b0njzLjfININ6Qws+lc5B5vR
	 itjqzDy9xjSTZuK3QOQ9I5yeawb4tbQjD5kCOKlSC5G2luE04THVWHO8dM498VfzAJ
	 eLxGeBJfdwLQL6jCw2mcOTrOv8k22gs2tbX8UCHfeGLpnoionHOqrxLElqkflT3IWG
	 FlXaVPlrwuMW0SCEcsynOuS5r9l44wpHCWu3QSG/0OOu0kTEm4j2X9qNt+w2NdnLcK
	 zT4mBoBAl07Lw==
Date: Fri, 15 Mar 2024 09:50:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, alsa-devel@alsa-project.org, 
 Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, 
 linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 Mark Brown <broonie@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 kernel@salutedevices.com, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 linux-gpio@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Message-Id: <171051663959.1379925.16000374378934819942.robh@kernel.org>
Subject: Re: [PATCH 00/25] Introduce support of audio for Amlogic A1 SoC
 family


On Fri, 15 Mar 2024 02:21:36 +0300, Jan Dakinevich wrote:
> This series includes the following:
> 
>  - new audio clock and reset controller data and adaptation for it of existing
>    code (patches 0001..0004);
> 
>  - adaptation of existing audio components for A1 Soc (patches 0005..0021);
> 
>  - handy cosmetics for dai-link naming (patches 0022..0023);
> 
>  - integration of audio devices into common trees (patch 0024);
> 
>  - audio support bring up on Amlogic ad402 reference board (patch 0025). This
>    patch is not actually checked on real hardware (because all ad402 that we had
>    were burned out). This patch is based on ad402's schematics and on experience
>    with our own hardware (which is very close to reference board);
> 
> Dmitry Rokosov (2):
>   ASoC: dt-bindings: meson: introduce link-name optional property
>   ASoC: meson: implement link-name optional property in meson card utils
> 
> Jan Dakinevich (23):
>   clk: meson: a1: restrict an amount of 'hifi_pll' params
>   clk: meson: axg: move reset controller's code to separate module
>   dt-bindings: clock: meson: add A1 audio clock and reset controller
>     bindings
>   clk: meson: a1: add the audio clock controller driver
>   ASoC: meson: codec-glue: add support for capture stream
>   ASoC: meson: g12a-toacodec: fix "Lane Select" width
>   ASoC: meson: g12a-toacodec: rework the definition of bits
>   ASoC: dt-bindings: meson: g12a-toacodec: add support for A1 SoC family
>   ASoC: meson: g12a-toacodec: add support for A1 SoC family
>   ASoC: meson: t9015: prepare to adding new platforms
>   ASoC: dt-bindings: meson: t9015: add support for A1 SoC family
>   ASoC: meson: t9015: add support for A1 SoC family
>   ASoC: dt-bindings: meson: axg-pdm: document 'sysrate' property
>   ASoC: meson: axg-pdm: introduce 'sysrate' property
>   pinctrl/meson: fix typo in PDM's pin name
>   ASoC: dt-bindings: meson: meson-axg-audio-arb: claim support of A1 SoC
>     family
>   ASoC: dt-bindings: meson: axg-fifo: claim support of A1 SoC family
>   ASoC: dt-bindings: meson: axg-pdm: claim support of A1 SoC family
>   ASoC: dt-bindings: meson: axg-sound-card: claim support of A1 SoC
>     family
>   ASoC: dt-bindings: meson: axg-tdm-formatters: claim support of A1 SoC
>     family
>   ASoC: dt-bindings: meson: axg-tdm-iface: claim support of A1 SoC
>     family
>   arm64: dts: meson: a1: add audio devices
>   arm64: dts: ad402: enable audio
> 
>  .../bindings/clock/amlogic,a1-audio-clkc.yaml |  83 +++
>  .../reset/amlogic,meson-axg-audio-arb.yaml    |  10 +-
>  .../bindings/sound/amlogic,axg-fifo.yaml      |   8 +
>  .../bindings/sound/amlogic,axg-pdm.yaml       |   5 +
>  .../sound/amlogic,axg-sound-card.yaml         |  12 +-
>  .../sound/amlogic,axg-tdm-formatters.yaml     |  22 +-
>  .../bindings/sound/amlogic,axg-tdm-iface.yaml |   6 +-
>  .../bindings/sound/amlogic,g12a-toacodec.yaml |   1 +
>  .../bindings/sound/amlogic,gx-sound-card.yaml |   6 +
>  .../bindings/sound/amlogic,t9015.yaml         |   4 +-
>  .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 126 ++++
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 471 +++++++++++++++
>  drivers/clk/meson/Kconfig                     |  18 +
>  drivers/clk/meson/Makefile                    |   2 +
>  drivers/clk/meson/a1-audio.c                  | 556 ++++++++++++++++++
>  drivers/clk/meson/a1-audio.h                  |  58 ++
>  drivers/clk/meson/a1-pll.c                    |   8 +-
>  drivers/clk/meson/axg-audio.c                 |  95 +--
>  drivers/clk/meson/meson-audio-rstc.c          | 109 ++++
>  drivers/clk/meson/meson-audio-rstc.h          |  12 +
>  drivers/pinctrl/meson/pinctrl-meson-a1.c      |   6 +-
>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++
>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 +
>  .../dt-bindings/sound/meson-g12a-toacodec.h   |   5 +
>  sound/soc/meson/axg-pdm.c                     |  10 +-
>  sound/soc/meson/g12a-toacodec.c               | 298 ++++++++--
>  sound/soc/meson/meson-card-utils.c            |  12 +-
>  sound/soc/meson/meson-codec-glue.c            | 174 ++++--
>  sound/soc/meson/meson-codec-glue.h            |  23 +
>  sound/soc/meson/t9015.c                       | 326 +++++++++-
>  30 files changed, 2394 insertions(+), 223 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
>  create mode 100644 drivers/clk/meson/a1-audio.c
>  create mode 100644 drivers/clk/meson/a1-audio.h
>  create mode 100644 drivers/clk/meson/meson-audio-rstc.c
>  create mode 100644 drivers/clk/meson/meson-audio-rstc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y amlogic/meson-a1-ad402.dtb' for 20240314232201.2102178-1-jan.dakinevich@salutedevices.com:

arch/arm64/boot/dts/amlogic/meson-a1-ad402.dtb: audio-controller@4800: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/amlogic,t9015.yaml#
arch/arm64/boot/dts/amlogic/meson-a1-ad402.dtb: audio-controller@1000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-pdm.yaml#






