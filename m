Return-Path: <linux-kernel+bounces-104242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA187CB20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00DF1F215ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12EE182DB;
	Fri, 15 Mar 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nLMlJDBy"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F01862E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497203; cv=none; b=YS0tqMgiHD7v3KBI4Id7AErQivlpqYbn0aajsE7EZbFVOpn0nVAMnlRQQ8yCZ/rh/6kTiTkfHObDAeK7JvN8wQqw+pvQg7wpL9KOMFxGpWwnRPa+du5QPLcj6eo5ovgPZ3B9dB3FeIPW1y/82YUpOxYXQ9m5dX9n1pwFZTDGvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497203; c=relaxed/simple;
	bh=GDNqvSo5A1b6QVZYerImyy1Y8dstVX31OYMYR2BPJXQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=mY2hwGpm0Ma9YuYnmUhHdszRHNThBY0rchBraGXgdCXBwT/XhX5pDkR5z2dlViRgqC2fmm9n0uBEx8OWjWYmDLd3Ft1o8dL+Psnw4juKXffwvgiCZN/2cOfsZnxI1FszYuvqp47VCgNhAw0gDaxPN8filK0TlzbYF2QYPT4j+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nLMlJDBy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413eee86528so12641805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710497199; x=1711101999; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=JSJDar4M2yUm4D8l+v7Mwxi0TV8x67pqYTNsZ2PsayQ=;
        b=nLMlJDByNJqt3drEYZ4fiJPaUipNBjjtwp8O1ajHUtc4Yn3qCV1rrwV+eX9HN725iA
         SzWvBp8bu0akrR0wL7hrTUgauGk4br0tQWUuJMvG0R5HsBHiuueY4Q8K+9UR1thkV6Oz
         EjqoADxCWavpTuhcR1iEaSNfqyRRfeYU4gpkt2I0XRhoehqSoDlJ+M0VJFPqmLJ99Ew/
         wBI8ZHOXXVHrL2HFmNiTwYv4wQo/l5dZB3qttHjACLjWl0arpNZTrZ1ZT6qUPNa9VVye
         S3A2dsDsWdA7SOrmUr+76dSpWNEav3dI8vqsjbHO2WaAe2U3lv3jSm+XspkVmIwSx3FO
         y5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710497199; x=1711101999;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSJDar4M2yUm4D8l+v7Mwxi0TV8x67pqYTNsZ2PsayQ=;
        b=EKeE/avRNjgfF6Vbb/4mvreJyGf0QH+D1W3Eb9k6Vxw+VPHNCkq4BVtfNC+r7f1cQW
         wEMgTF5gccuk/LoUVngwHs1CosYiDlKgw8raLoABAPjzvjKlSFByg0xfyFs9+I0J7/Cr
         aObvVy0DjZGLoriG+keN0khcIBa9P6Us4AypkdDnQEDBy4Vh9UPYSABYuLh78dxVMZxm
         7F0ONzTamM3qo77T8K03EmQ5V6wcvInTT4ukPGwPNvkrfr8FYhA07sTIxH9GV4YF23sL
         MbsrW+tMshp+Lpggb2cswcgumuI68LLgtvU7ymr3Vb5YWi8YVnzlhD0fKSZIH4BRzx3d
         H5vg==
X-Forwarded-Encrypted: i=1; AJvYcCU72O9ZwwmSJJ82Jsemi41e98qLdebB1NHNqdlOLz5eevwGAsKA64eaIkeu8b0dVGmj6vFohdm9jWMm2jTZTZ4Qq95Kvw03Dd3qBFYF
X-Gm-Message-State: AOJu0Yzw2T3VGm9BB63EbQ+XSFlUNao9Zs3f2kpFIKTAwqtcrjHwL8wS
	I7JnGLHKOqxYHm0nn5ePxn2zteidoEqplqfEiRk5A1IlUhs2+rl08+K78B4lpY4=
X-Google-Smtp-Source: AGHT+IFei/VwSLVdZGr+j7usNgdM6Q0VdRkbBr81xPcXXnlj2dvPsRezr8PqGBRTcMb21KM9bWZ5bQ==
X-Received: by 2002:a05:600c:4fc8:b0:412:f4b4:2717 with SMTP id o8-20020a05600c4fc800b00412f4b42717mr3308624wmq.26.1710497198823;
        Fri, 15 Mar 2024 03:06:38 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:8151:4d0a:14d8:1124])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b00413ebaf0055sm5294640wms.7.2024.03.15.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 03:06:38 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, Michael  Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob  Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin
 Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH 00/25] Introduce support of audio for Amlogic A1 SoC family
Date: Fri, 15 Mar 2024 11:01:57 +0100
In-reply-to: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Message-ID: <1jv85nhkr6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

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

I'm sorry but a 25 patches series is just way too big, especially when
spamming multiple sub systems.

Please try to make one series per sub systems and general topic, I see
at least
* A1 audio clocks
* G12 acodec fix
* Acodec rework
* PDM
* pinctrl
* arm64

I did not review all but I think I've made enough comments to keep you
busy for a while

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


-- 
Jerome

