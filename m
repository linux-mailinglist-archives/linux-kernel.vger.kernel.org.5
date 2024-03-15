Return-Path: <linux-kernel+bounces-104655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D587D194
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCD72834C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E24F1FE;
	Fri, 15 Mar 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGtmjUhV"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058704AEF9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521591; cv=none; b=SyXCdHvzsixsQBihKJBr6LQx3wbNzjIk8jLS7FtKQ9vTS6v+8FpxeZhDNV4XscwFytqvirBmdPY8kRZhSX7nUs9AGLsOzPVwYY6IDBtKJ24SKdpfvI111UZqJ47B5Q7RDhxiARJ7mFTS1hUeZi88Q7jHyXi4XQLmwdl+mriysHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521591; c=relaxed/simple;
	bh=J/mesTovEYtNSpXC1b7Hu6rWx3dBemBmXwuP4LpnTNA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=abqJ/ZVGubA/V+u276/tTIsBnhncXrtLzG0Y+ihgxxGI1FB2aiujKlzPkT7xMC61SXaPHs4aekHtowUTLps15QJf5Kv5blVNLt9uElQDNl1rHQHvmLKVV1yC2WZLVL9uKXMfeUNUQczOMh38UO1DR/yGOIne9WyDiHRV83GGS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGtmjUhV; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512ed314881so1987667e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710521587; x=1711126387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52kT8RCFGC7okKDqG5Bcwj1POjAaTduZrpTnpA9FpD0=;
        b=xGtmjUhVLcFIizD+FSyC4kCsz9O5thWI1Dk7kHFeizhjYqe6UfqwurcdyQkDx5OBzG
         Ur7ogOT0gWUa8aD5uQkc6EyLD1Krlii+c0vDE+BfEYazwhbfKcZnwTGVZOjFJgJM34Tz
         lngeVOA4OBjbNuGVN4s+NJaOCV7c57T06TQ0DiH/cAO7BzXgbHKtRqNJmQfpb9M+kx5s
         YdOGERXgtbm2Gga/lkCftJABMtiCKp6ck8S3yIxpCzvkhIPa4A/9LnSKcC80RkBfqiY8
         QN+l0LBLkAEBHLOl2ekAh1ATiMX9bLTWLLlv0FnDg23U7O8/cY8qCLI/ar8MfR6nRVCZ
         XoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521587; x=1711126387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52kT8RCFGC7okKDqG5Bcwj1POjAaTduZrpTnpA9FpD0=;
        b=nkySiHockc6Hny5ap25zGDJPsq++CG44KTbkLqm1SV9DvY8UYxzAlt/KQq5tHzy5Lz
         UB37ioDKKt/ZLcCe42C/lyDELEF0mw6yGQj+B+A/b3ZvM+ydbcKN6dssjZt9pj/W6c3/
         S9PIryhUGBYqfmXS6YmIfa+Wo7dcpKgrZZxl8OCrrfiJdz9hT7h+SVHt9P7aE4n/VP+A
         DuuN8pntrnfLUA8DjJDDXggNUNzirix/Ak8VvV6OMxHq3thVJzXkx0MSFrzbwNfKrfaJ
         5V7JQe7Mk1AhPLdLh+57R3c/MYa6RxWT0g7AkBGzsivWnjeQ3Lqfi/R3ocg79OUzHprd
         uytw==
X-Forwarded-Encrypted: i=1; AJvYcCX/jlKIC3yvHCdBcXRWy7yf1qgWsFWdwrJOfsvh4ly4NR9fXpsmeFAQuHrYda13RH2CCH8x3TlJmVLo7G9aOjpRPM8UDrQlcam+yPaU
X-Gm-Message-State: AOJu0YzYJ5p/klX5W2XfJ8HFTp8ETHBdvz2SzwdeToIAdms4H1LBE2Fj
	bDS7zqd41K6M1h1Bc0WzXl/bYo08p9wfn7UbzRH90U5ttq3dliCOihGY1//Yn0g=
X-Google-Smtp-Source: AGHT+IHLfd0FUA2LIoNuC9vV0UbukiLHlnyaISY5TaECNKl/ARlCMBUC7tn6mgNu/CU8tNB0bzSEnQ==
X-Received: by 2002:a19:911e:0:b0:513:d24f:6455 with SMTP id t30-20020a19911e000000b00513d24f6455mr3304106lfd.29.1710521587073;
        Fri, 15 Mar 2024 09:53:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3? ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b00413e6a1935dsm6359144wms.36.2024.03.15.09.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:53:06 -0700 (PDT)
Message-ID: <4bb2fa50-0944-456d-b51b-449a2bd9bb69@linaro.org>
Date: Fri, 15 Mar 2024 17:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/25] Introduce support of audio for Amlogic A1 SoC
 family
Content-Language: en-US, fr
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: kernel@salutedevices.com
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan!

On 15/03/2024 00:21, Jan Dakinevich wrote:
> This series includes the following:
> 
>   - new audio clock and reset controller data and adaptation for it of existing
>     code (patches 0001..0004);
> 
>   - adaptation of existing audio components for A1 Soc (patches 0005..0021);
> 
>   - handy cosmetics for dai-link naming (patches 0022..0023);
> 
>   - integration of audio devices into common trees (patch 0024);
> 
>   - audio support bring up on Amlogic ad402 reference board (patch 0025). This
>     patch is not actually checked on real hardware (because all ad402 that we had
>     were burned out). This patch is based on ad402's schematics and on experience
>     with our own hardware (which is very close to reference board);

Thanks for your serie, it's nice you're working on upstreaming this feature.

In my opinion it's fine to have a "big" initial serie if you're not sure
if your changes are ok, but next time add the RFC tag so we know it's not
a final changeset and you seek advices.

Overall the code is clean and your patch order makes sense if they were meant
to be applied by a single maintainer, but in this case it will be split
into multiple subsystems so it's better to split them as Jerome explained
to ease review and the maintainers process.

Don't hesitate discussing with us in the #linux-amlogic IRC channel
on Libera.Chat, the goal is to reduce the number of patch version and
ease the review and maintainance process.

Concerning the link-name property, I think it should be done afterwards
since it's not necessary to support audio on A1, and I think it could
be extended to other SoC boards (which would be a great feature).

Neil

> 
> Dmitry Rokosov (2):
>    ASoC: dt-bindings: meson: introduce link-name optional property
>    ASoC: meson: implement link-name optional property in meson card utils
> 
> Jan Dakinevich (23):
>    clk: meson: a1: restrict an amount of 'hifi_pll' params
>    clk: meson: axg: move reset controller's code to separate module
>    dt-bindings: clock: meson: add A1 audio clock and reset controller
>      bindings
>    clk: meson: a1: add the audio clock controller driver
>    ASoC: meson: codec-glue: add support for capture stream
>    ASoC: meson: g12a-toacodec: fix "Lane Select" width
>    ASoC: meson: g12a-toacodec: rework the definition of bits
>    ASoC: dt-bindings: meson: g12a-toacodec: add support for A1 SoC family
>    ASoC: meson: g12a-toacodec: add support for A1 SoC family
>    ASoC: meson: t9015: prepare to adding new platforms
>    ASoC: dt-bindings: meson: t9015: add support for A1 SoC family
>    ASoC: meson: t9015: add support for A1 SoC family
>    ASoC: dt-bindings: meson: axg-pdm: document 'sysrate' property
>    ASoC: meson: axg-pdm: introduce 'sysrate' property
>    pinctrl/meson: fix typo in PDM's pin name
>    ASoC: dt-bindings: meson: meson-axg-audio-arb: claim support of A1 SoC
>      family
>    ASoC: dt-bindings: meson: axg-fifo: claim support of A1 SoC family
>    ASoC: dt-bindings: meson: axg-pdm: claim support of A1 SoC family
>    ASoC: dt-bindings: meson: axg-sound-card: claim support of A1 SoC
>      family
>    ASoC: dt-bindings: meson: axg-tdm-formatters: claim support of A1 SoC
>      family
>    ASoC: dt-bindings: meson: axg-tdm-iface: claim support of A1 SoC
>      family
>    arm64: dts: meson: a1: add audio devices
>    arm64: dts: ad402: enable audio
> 
>   .../bindings/clock/amlogic,a1-audio-clkc.yaml |  83 +++
>   .../reset/amlogic,meson-axg-audio-arb.yaml    |  10 +-
>   .../bindings/sound/amlogic,axg-fifo.yaml      |   8 +
>   .../bindings/sound/amlogic,axg-pdm.yaml       |   5 +
>   .../sound/amlogic,axg-sound-card.yaml         |  12 +-
>   .../sound/amlogic,axg-tdm-formatters.yaml     |  22 +-
>   .../bindings/sound/amlogic,axg-tdm-iface.yaml |   6 +-
>   .../bindings/sound/amlogic,g12a-toacodec.yaml |   1 +
>   .../bindings/sound/amlogic,gx-sound-card.yaml |   6 +
>   .../bindings/sound/amlogic,t9015.yaml         |   4 +-
>   .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 126 ++++
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 471 +++++++++++++++
>   drivers/clk/meson/Kconfig                     |  18 +
>   drivers/clk/meson/Makefile                    |   2 +
>   drivers/clk/meson/a1-audio.c                  | 556 ++++++++++++++++++
>   drivers/clk/meson/a1-audio.h                  |  58 ++
>   drivers/clk/meson/a1-pll.c                    |   8 +-
>   drivers/clk/meson/axg-audio.c                 |  95 +--
>   drivers/clk/meson/meson-audio-rstc.c          | 109 ++++
>   drivers/clk/meson/meson-audio-rstc.h          |  12 +
>   drivers/pinctrl/meson/pinctrl-meson-a1.c      |   6 +-
>   .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++
>   .../reset/amlogic,meson-a1-audio-reset.h      |  29 +
>   .../dt-bindings/sound/meson-g12a-toacodec.h   |   5 +
>   sound/soc/meson/axg-pdm.c                     |  10 +-
>   sound/soc/meson/g12a-toacodec.c               | 298 ++++++++--
>   sound/soc/meson/meson-card-utils.c            |  12 +-
>   sound/soc/meson/meson-codec-glue.c            | 174 ++++--
>   sound/soc/meson/meson-codec-glue.h            |  23 +
>   sound/soc/meson/t9015.c                       | 326 +++++++++-
>   30 files changed, 2394 insertions(+), 223 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-audio-clkc.yaml
>   create mode 100644 drivers/clk/meson/a1-audio.c
>   create mode 100644 drivers/clk/meson/a1-audio.h
>   create mode 100644 drivers/clk/meson/meson-audio-rstc.c
>   create mode 100644 drivers/clk/meson/meson-audio-rstc.h
>   create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> 


