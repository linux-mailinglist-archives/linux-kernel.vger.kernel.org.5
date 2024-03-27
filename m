Return-Path: <linux-kernel+bounces-121466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EC88E844
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8641F32BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2B14A0BF;
	Wed, 27 Mar 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="McxRSbE/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904314A0AB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550794; cv=none; b=O//XWCRSVywFby9Hfa0RIaJvA3hun5Tb6wLM02KUmIUNWMqZo0cNMVXsm0asNW3yoqjdrLDj7MJjltOsbQKLCQwXzyZV71kxjzgUTpH1a406Axo3u+rPPEP1dZWcJu4wV4j0zMbBDFqpCX0QZq/+rt1HQemTbavW+ybauzAjCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550794; c=relaxed/simple;
	bh=Z7bnjw80XJdxhegF6zB0UBsfZFtZoP739I4QPh1CE+0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=eu5oAhH/aSLWFd/dog+yJnFG8oxzWiFoknvX5uVU0fcPUZy43Xt6ZH/DTsFOnUY8ZujsP419tB7CvnRe3sJB8Ye82LHMacck9CXwxGU9chUaMDTDYhwNGxLqySxmT9jiBiHFJ8sReuCH+8lkGCwjC7U//NbQGtI5rcUt25pmXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=McxRSbE/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4149571d4b6so5434375e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711550789; x=1712155589; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=4ot++PM95Ay3K0nVbT5oEGMO2n7sVLmjubfWbm+sO+Y=;
        b=McxRSbE/d+YqXVqDnLHFI2Ngh1mskimgqjOZ93IOni/Jx4xVkWO68/FlpyPSt8/a0k
         kNMLpzDxj6OwJXPldOVbOR+nKDR+hpfshuEzQOOf+pYECMdRDzXLr8cHEPkwP5UC1A2p
         CAVKWacm4ZOE6Jyx+gimcVMfOyOUubdRbb0ZciWED5dCMtC0oT/ie0OUvoM2GTNYKC1P
         lW7SzA0409M+qMQ3I0WhkSrWRV4MEsw6yq4tXIF2YLAPSGXvkNj1W81L1q5WD7ZzOkJQ
         Zfvq7+Xk8YUi544FNsBLb1TXjQan1aUNfbGKsPq/zKBdGEIphzvxpHzFmmgNMPy/fQXw
         wlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550789; x=1712155589;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ot++PM95Ay3K0nVbT5oEGMO2n7sVLmjubfWbm+sO+Y=;
        b=bcR6fvCUaKVgP6JiXOROPtlAhwzndk8iy31ubOXBv8hZ+E0I+GVggN7Z9HAFV4Za4u
         ITzVGoL0IDJREXtXxDsucSdYSYN1wRFlS9+eDZxWobDva5RNNWW6+tSaTRnZtbZ2tAkX
         ZXmvXtRaksoF0Rb19keYQ6/OnQXJY7jGmhAfOGcWnqp1nkEz3SYbxyT+Ii7/t+kEGmsN
         18sdPeGDzF0QvT7H7RbEzWi7A4MZm1i4KLlwjIaocQbLhrT+ir6idaB6xLaBjE+g7Uph
         ep0T90SAidnw4ZbcJ1pvFFlnUPZC3EbkYSAPv+F6Te5mqI5QIUz7GlMQJ/3ZZgHgwI/8
         wGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Nj8lhkAYq0GrdKp7T+2lX0FJvQXnuKcYDjbEJgGZjtiy7VVAxvtNDelkv8ivN6f9jD78MVVkSP0O3TBiWxMQRXTCImXszOoBZ6Yn
X-Gm-Message-State: AOJu0YyX8RkOqUs4p5RyW5CS4qlHq/M3XLT05EwjYjqeJmTn9WI3d53B
	AHBVlVp2jE1AtqctNOJ6FBzE+t8LxfNX9ggRrVLQvAU1p26mUTWvDozPJkdr5gg=
X-Google-Smtp-Source: AGHT+IEMd0j7wSOwiXfrA6lDZ4xMHvpDrYjBo1WIiPdOMJ2ssKEbwg+9fgPOhjvRa4EqRXBHF8I1Dg==
X-Received: by 2002:a05:600c:358f:b0:414:24d:7f9 with SMTP id p15-20020a05600c358f00b00414024d07f9mr262318wmq.1.1711550788450;
        Wed, 27 Mar 2024 07:46:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e2f0:34bb:2ffe:1a3b])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm644139wmq.12.2024.03.27.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:46:27 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-5-jan.dakinevich@salutedevices.com>
 <1j4jd7izx4.fsf@starbuckisacylon.baylibre.com>
 <6c129ee2-f08c-4575-a95f-667cc6472578@salutedevices.com>
 <1jo7bafv90.fsf@starbuckisacylon.baylibre.com>
 <0f4b2ec3-204f-44ea-a1b2-e47ea05def1f@salutedevices.com>
 <1jy1a580g0.fsf@starbuckisacylon.baylibre.com>
 <dc4ed700-623d-4823-9a41-de9be78afa64@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
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
Subject: Re: [PATCH 04/25] clk: meson: a1: add the audio clock controller
 driver
Date: Wed, 27 Mar 2024 13:57:17 +0100
In-reply-to: <dc4ed700-623d-4823-9a41-de9be78afa64@salutedevices.com>
Message-ID: <1j8r23ag1o.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 26 Mar 2024 at 21:44, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> On 3/26/24 18:26, Jerome Brunet wrote:
>> 
>> On Sat 23 Mar 2024 at 21:02, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>> 
>>> Jerome, I have reworked my driver reusing axg-audio code as most as I
>>> could and now I have one more question. Lets see on this definition from
>>> axg-audio:
>>>
>>> #define AUD_MST_MUX(_name, _reg, _flag)				\
>>> 	AUD_MUX(_name##_sel, _reg, 0x7, 24, _flag,		\
>>> 		mst_mux_parent_data, 0)
>>>
>>> #define AUD_MST_MCLK_MUX(_name, _reg)				\
>>> 	AUD_MST_MUX(_name, _reg, CLK_MUX_ROUND_CLOSEST)
>>>
>>> CLK_SET_RATE_PARENT is not set here. But why? It means, that topmost pll
>>> clock will not be reconfigured at runtime to satisfy the rate that was
>>> requested from axg-tdm.
>>>
>> 
>> Yes, that is by design. It is another area where mainline audio differs
>> greatly from AML vendor code. The PLLs are expected be to fixed and the
>> audio master clock will reparent to the most adequate PLL source
>> depending on the use case.
>> 
>> This is how we manage to satisfy all audio interfaces with a very
>> limited number of PLLs
>> 
>> On AXG/G12 there is at most 6 concurrent interfaces (3 FRDDR/TODDR) - 8
>> on sm1 - and we can satisfy on that with 3 PLLs. That would not be
>> possible if interfaces were having their way with the PLLs, reseting it
>> everytime a stream is started.
>> > The PLL rate should be carefully chosen so it can be derived easily. On
>> AXG/G12/SM1 that is:
>>  * one PLL per rate family, to maximize clock precision
>>  * x24 x32: to handle different sample sizes
>>  * x2 until we reach the PLL limits to allow higher rates such as 384kHz
>>    or even higher
>> 
>
> Thank you. Now it has become much clearer.
>
>> If you have less PLLs on A1, you'll have to make compromises, like a less
>> precise clock to support multiple family with one PLL.
>> This is why the PLLs are set for each platform in DT because that choice
>> may depend on the platform use case.
>> 
>
> Unfortunately, on A1 we have only one PLL.
>

That where compromises comes in. Pick a rate known as 'audio friendly'
which match some rates and appromixate others, or use codec clock master.

> Yes, for us it would be better to have hifi_pll with predefined rate.
> For instance it will allow to avoid that ugly workaround in PDM (sysrate
> property, etc).

That is another problem entirely. 
Krzysztof and I already covered what you should do for this.

The exact rate the PDM system clock does not matter at all because the
driver queries the actual rate of the clocks and adapts.

You have problems here only because you added CLK_SET_RATE_PARENT and
you are triggering the concurrent usage problem I explain below.

>
> But what whould be preferred for upstream? I can imagine a scenario
> where samples with different rate should be played, PDM attached to
> fclk_divN and there are no conflicts with TDM.

You are considering only PDM and 1 TDM. The SoC has 2 TDMs which could
be active concurrently a different rates.

> In this case
> reconfiguration of hifi_pll on demand could better satisfy somebody's
> requirements.

No this is not possible. Doing so does not allow all the interfaces to be
used concurrently. 

* If the PLL is not protected, existing streams get broken by new
  starting stream when the PLL is reconfigured
* If the PLL is protected, new stream effectively starve because no
  clock may provide a 'good enough' rate for them

This is why the reference rate must carefully chosen, something CCF
cannot do for you.

For example, a source of 12.288MHz (and its powers of 2) allows to match
48 and 32kHz sample rates and approximate 44.1kHz rates with an
acceptable drift.

>
>>>
>>> On 3/19/24 11:30, Jerome Brunet wrote:
>>>>
>>>> On Tue 19 Mar 2024 at 04:47, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>>>>
>>>>> Let's start from the end:
>>>>>
>>>>>> No - Looks to me you just have two clock controllers you are trying
>>>>> force into one.
>>>>>
>>>>>> Again, this shows 2 devices. The one related to your 'map0' should
>>>>> request AUD2_CLKID_AUDIOTOP as input and enable it right away.
>>>>>
>>>>> Most of fishy workarounds that you commented is caused the fact the mmio
>>>>> of this clock controller is divided into two parts. Compare it with
>>>>> axg-audio driver, things that was part of contigous memory region (like
>>>>> pdm) here are moved to second region. Is this enough to make a guess
>>>>> that these are two devices?
>>>>
>>>> I see obsolutely no reason to think it is a single device nor to add all the quirks
>>>> you have the way you did. So yes, in that case, 2 zones, 2 devices.
>>>>
>>>>>
>>>>> Concerning AUD2_CLKID_AUDIOTOP clock, as it turned out, it must be
>>>>> enabled before enabling of clocks from second region too. That is
>>>>> AUD2_CLKID_AUDIOTOP clock feeds both parts of this clock controller.
>>>>>
>>>>
>>>> Yes. I understood the first time around and already commented on that.
>>>>
>>>>>
>>>>> On 3/15/24 12:20, Jerome Brunet wrote:
>>>>>>
>>>>>> On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>>>>>>
>>>>>>> This controller provides clocks and reset functionality for audio
>>>>>>> peripherals on Amlogic A1 SoC family.
>>>>>>>
>>>>>>> The driver is almost identical to 'axg-audio', however it would be better
>>>>>>> to keep it separate due to following reasons:
>>>>>>>
>>>>>>>  - significant amount of bits has another definition. I will bring there
>>>>>>>    a mess of new defines with A1_ suffixes.
>>>>>>>
>>>>>>>  - registers of this controller are located in two separate regions. It
>>>>>>>    will give a lot of complications for 'axg-audio' to support this.
>>>>>>>
>>>>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>>>> ---
>>>>>>>  drivers/clk/meson/Kconfig    |  13 +
>>>>>>>  drivers/clk/meson/Makefile   |   1 +
>>>>>>>  drivers/clk/meson/a1-audio.c | 556 +++++++++++++++++++++++++++++++++++
>>>>>>>  drivers/clk/meson/a1-audio.h |  58 ++++
>>>>>>>  4 files changed, 628 insertions(+)
>>>>>>>  create mode 100644 drivers/clk/meson/a1-audio.c
>>>>>>>  create mode 100644 drivers/clk/meson/a1-audio.h
>>>>>>>
>>>>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>>>>> index d6a2fa5f7e88..80c4a18c83d2 100644
>>>>>>> --- a/drivers/clk/meson/Kconfig
>>>>>>> +++ b/drivers/clk/meson/Kconfig
>>>>>>> @@ -133,6 +133,19 @@ config COMMON_CLK_A1_PERIPHERALS
>>>>>>>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>>>>>>  	  controller to work.
>>>>>>>  
>>>>>>> +config COMMON_CLK_A1_AUDIO
>>>>>>> +	tristate "Amlogic A1 SoC Audio clock controller support"
>>>>>>> +	depends on ARM64
>>>>>>> +	select COMMON_CLK_MESON_REGMAP
>>>>>>> +	select COMMON_CLK_MESON_CLKC_UTILS
>>>>>>> +	select COMMON_CLK_MESON_PHASE
>>>>>>> +	select COMMON_CLK_MESON_SCLK_DIV
>>>>>>> +	select COMMON_CLK_MESON_AUDIO_RSTC
>>>>>>> +	help
>>>>>>> +	  Support for the Audio clock controller on Amlogic A113L based
>>>>>>> +	  device, A1 SoC Family. Say Y if you want A1 Audio clock controller
>>>>>>> +	  to work.
>>>>>>> +
>>>>>>>  config COMMON_CLK_G12A
>>>>>>>  	tristate "G12 and SM1 SoC clock controllers support"
>>>>>>>  	depends on ARM64
>>>>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>>>>> index 88d94921a4dc..4968fc7ad555 100644
>>>>>>> --- a/drivers/clk/meson/Makefile
>>>>>>> +++ b/drivers/clk/meson/Makefile
>>>>>>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>>>>>>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>>>>>>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>>>>>>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>>>>>> +obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
>>>>>>>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>>>>>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>>>>>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>>>>>> diff --git a/drivers/clk/meson/a1-audio.c b/drivers/clk/meson/a1-audio.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..6039116c93ba
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/clk/meson/a1-audio.c
>>>>>>> @@ -0,0 +1,556 @@
>>>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>>>>>>> + *
>>>>>>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/clk.h>
>>>>>>> +#include <linux/clk-provider.h>
>>>>>>> +#include <linux/init.h>
>>>>>>> +#include <linux/of_device.h>
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/regmap.h>
>>>>>>> +#include <linux/reset.h>
>>>>>>> +#include <linux/reset-controller.h>
>>>>>>> +#include <linux/slab.h>
>>>>>>> +
>>>>>>> +#include "meson-clkc-utils.h"
>>>>>>> +#include "meson-audio-rstc.h"
>>>>>>> +#include "clk-regmap.h"
>>>>>>> +#include "clk-phase.h"
>>>>>>> +#include "sclk-div.h"
>>>>>>> +#include "a1-audio.h"
>>>>>>> +
>>>>>>> +#define AUDIO_PDATA(_name) \
>>>>>>> +	((const struct clk_parent_data[]) { { .hw = &(_name).hw } })
>>>>>>
>>>>>> Not a fan - yet another level of macro.
>>>>>>
>>>>>>> +
>>>>>>> +#define AUDIO_MUX(_name, _reg, _mask, _shift, _pdata)			\
>>>>>>> +static struct clk_regmap _name = {					\
>>>>>>> +	.map = AUDIO_REG_MAP(_reg),					\
>>>>>>> +	.data = &(struct clk_regmap_mux_data){				\
>>>>>>> +		.offset = AUDIO_REG_OFFSET(_reg),			\
>>>>>>> +		.mask = (_mask),					\
>>>>>>> +		.shift = (_shift),					\
>>>>>>> +	},								\
>>>>>>> +	.hw.init = &(struct clk_init_data) {				\
>>>>>>> +		.name = #_name,						\
>>>>>>> +		.ops = &clk_regmap_mux_ops,				\
>>>>>>> +		.parent_data = (_pdata),				\
>>>>>>> +		.num_parents = ARRAY_SIZE(_pdata),			\
>>>>>>> +		.flags = CLK_SET_RATE_PARENT,				\
>>>>>>> +	},								\
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define AUDIO_DIV(_name, _reg, _shift, _width, _pdata)			\
>>>>>>> +static struct clk_regmap _name = {					\
>>>>>>> +	.map = AUDIO_REG_MAP(_reg),					\
>>>>>>> +	.data = &(struct clk_regmap_div_data){				\
>>>>>>> +		.offset = AUDIO_REG_OFFSET(_reg),			\
>>>>>>> +		.shift = (_shift),					\
>>>>>>> +		.width = (_width),					\
>>>>>>> +	},								\
>>>>>>> +	.hw.init = &(struct clk_init_data) {				\
>>>>>>> +		.name = #_name,						\
>>>>>>> +		.ops = &clk_regmap_divider_ops,				\
>>>>>>> +		.parent_data = (_pdata),				\
>>>>>>> +		.num_parents = 1,					\
>>>>>>> +		.flags = CLK_SET_RATE_PARENT,				\
>>>>>>> +	},								\
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define AUDIO_GATE(_name, _reg, _bit, _pdata)				\
>>>>>>> +static struct clk_regmap _name = {					\
>>>>>>> +	.map = AUDIO_REG_MAP(_reg),					\
>>>>>>> +	.data = &(struct clk_regmap_gate_data){				\
>>>>>>> +		.offset = AUDIO_REG_OFFSET(_reg),			\
>>>>>>> +		.bit_idx = (_bit),					\
>>>>>>> +	},								\
>>>>>>> +	.hw.init = &(struct clk_init_data) {				\
>>>>>>> +		.name = #_name,						\
>>>>>>> +		.ops = &clk_regmap_gate_ops,				\
>>>>>>> +		.parent_data = (_pdata),				\
>>>>>>> +		.num_parents = 1,					\
>>>>>>> +		.flags = CLK_SET_RATE_PARENT,				\
>>>>>>> +	},								\
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define AUDIO_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
>>>>>>> +	_hi_shift, _hi_width, _pdata, _set_rate_parent)			\
>>>>>>> +static struct clk_regmap _name = {					\
>>>>>>> +	.map = AUDIO_REG_MAP(_reg),					\
>>>>>>> +	.data = &(struct meson_sclk_div_data) {				\
>>>>>>> +		.div = {						\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_div_shift),				\
>>>>>>> +			.width = (_div_width),				\
>>>>>>> +		},							\
>>>>>>> +		.hi = {							\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_hi_shift),				\
>>>>>>> +			.width = (_hi_width),				\
>>>>>>> +		},							\
>>>>>>> +	},								\
>>>>>>> +	.hw.init = &(struct clk_init_data) {				\
>>>>>>> +		.name = #_name,						\
>>>>>>> +		.ops = &meson_sclk_div_ops,				\
>>>>>>> +		.parent_data = (_pdata),				\
>>>>>>> +		.num_parents = 1,					\
>>>>>>> +		.flags = (_set_rate_parent) ? CLK_SET_RATE_PARENT : 0,	\
>>>>>>
>>>>>> Does not help readeability. Just pass the flag as axg-audio does.
>>>>>>
>>>>>>> +	},								\
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define AUDIO_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
>>>>>>> +	_pdata)								\
>>>>>>> +static struct clk_regmap _name = {					\
>>>>>>> +	.map = AUDIO_REG_MAP(_reg),					\
>>>>>>> +	.data = &(struct meson_clk_triphase_data) {			\
>>>>>>> +		.ph0 = {						\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_shift0),				\
>>>>>>> +			.width = (_width),				\
>>>>>>> +		},							\
>>>>>>> +		.ph1 = {						\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_shift1),				\
>>>>>>> +			.width = (_width),				\
>>>>>>> +		},							\
>>>>>>> +		.ph2 = {						\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_shift2),				\
>>>>>>> +			.width = (_width),				\
>>>>>>> +		},							\
>>>>>>> +	},								\
>>>>>>> +	.hw.init = &(struct clk_init_data) {				\
>>>>>>> +		.name = #_name,						\
>>>>>>> +		.ops = &meson_clk_triphase_ops,				\
>>>>>>> +		.parent_data = (_pdata),				\
>>>>>>> +		.num_parents = 1,					\
>>>>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_DUTY_CYCLE_PARENT,	\
>>>>>>> +	},								\
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define AUDIO_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws,	\
>>>>>>> +	_pdata)								\
>>>>>>> +static struct clk_regmap _name = {					\
>>>>>>> +	.map = AUDIO_REG_MAP(_reg),					\
>>>>>>> +	.data = &(struct meson_sclk_ws_inv_data) {			\
>>>>>>> +		.ph = {							\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_shift_ph),				\
>>>>>>> +			.width = (_width),				\
>>>>>>> +		},							\
>>>>>>> +		.ws = {							\
>>>>>>> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
>>>>>>> +			.shift = (_shift_ws),				\
>>>>>>> +			.width = (_width),				\
>>>>>>> +		},							\
>>>>>>> +	},								\
>>>>>>> +	.hw.init = &(struct clk_init_data) {				\
>>>>>>> +		.name = #_name,						\
>>>>>>> +		.ops = &meson_sclk_ws_inv_ops,				\
>>>>>>> +		.parent_data = (_pdata),				\
>>>>>>> +		.num_parents = 1,					\
>>>>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_DUTY_CYCLE_PARENT,	\
>>>>>>> +	},								\
>>>>>>> +}
>>>>>>
>>>>>> All the above does essentially the same things as the macro of
>>>>>> axg-audio, to some minor differences. Yet it is another set to maintain.
>>>>>>
>>>>>
>>>>> Except one thing... Here I keep memory identifier to which this clock
>>>>> belongs:
>>>>>
>>>>>     .map = AUDIO_REG_MAP(_reg),	
>>>>>
>>>>> It is workaround, but ->map the only common field in clk_regmap that
>>>>> could be used for this purpose.
>>>>>
>>>>>
>>>>>> I'd much prefer if you put the axg-audio macro in a header a re-used
>>>>>> those. There would a single set to maintain. You may then specialize the
>>>>>>  included in the driver C file, to avoid redundant parameters
>>>>>>
>>>>>> Rework axg-audio to use clk_parent_data if you must, but not in the same
>>>>>> series please.
>>>>>>
>>>>>>> +
>>>>>>> +static const struct clk_parent_data a1_pclk_pdata[] = {
>>>>>>> +	{ .fw_name = "pclk", },
>>>>>>> +};
>>>>>>> +
>>>>>>> +AUDIO_GATE(audio_ddr_arb, AUDIO_CLK_GATE_EN0, 0, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_tdmin_a, AUDIO_CLK_GATE_EN0, 1, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_tdmin_b, AUDIO_CLK_GATE_EN0, 2, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_tdmin_lb, AUDIO_CLK_GATE_EN0, 3, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_loopback, AUDIO_CLK_GATE_EN0, 4, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_tdmout_a, AUDIO_CLK_GATE_EN0, 5, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_tdmout_b, AUDIO_CLK_GATE_EN0, 6, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_frddr_a, AUDIO_CLK_GATE_EN0, 7, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_frddr_b, AUDIO_CLK_GATE_EN0, 8, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_toddr_a, AUDIO_CLK_GATE_EN0, 9, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_toddr_b, AUDIO_CLK_GATE_EN0, 10, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_spdifin, AUDIO_CLK_GATE_EN0, 11, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_resample, AUDIO_CLK_GATE_EN0, 12, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_eqdrc, AUDIO_CLK_GATE_EN0, 13, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio_audiolocker, AUDIO_CLK_GATE_EN0, 14, a1_pclk_pdata);
>>>>>>               This is what I mean by redundant parameter ^
>>>>>>
>>>>>
>>>>> Yep. I could define something like AUDIO_PCLK_GATE().
>>>>>
>>>>>>> +
>>>>>>> +AUDIO_GATE(audio2_ddr_arb, AUDIO2_CLK_GATE_EN0, 0, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio2_pdm, AUDIO2_CLK_GATE_EN0, 1, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio2_tdmin_vad, AUDIO2_CLK_GATE_EN0, 2, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio2_toddr_vad, AUDIO2_CLK_GATE_EN0, 3, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio2_vad, AUDIO2_CLK_GATE_EN0, 4, a1_pclk_pdata);
>>>>>>> +AUDIO_GATE(audio2_audiotop, AUDIO2_CLK_GATE_EN0, 7, a1_pclk_pdata);
>>>>>>> +
>>>>>>> +static const struct clk_parent_data a1_mst_pdata[] = {
>>>>>>> +	{ .fw_name = "dds_in" },
>>>>>>> +	{ .fw_name = "fclk_div2" },
>>>>>>> +	{ .fw_name = "fclk_div3" },
>>>>>>> +	{ .fw_name = "hifi_pll" },
>>>>>>> +	{ .fw_name = "xtal" },
>>>>>>> +};
>>>>>>> +
>>>>>>> +#define AUDIO_MST_MCLK(_name, _reg)					\
>>>>>>> +	AUDIO_MUX(_name##_mux, (_reg), 0x7, 24, a1_mst_pdata);		\
>>>>>>> +	AUDIO_DIV(_name##_div, (_reg), 0, 16,				\
>>>>>>> +		AUDIO_PDATA(_name##_mux));				\
>>>>>>> +	AUDIO_GATE(_name, (_reg), 31, AUDIO_PDATA(_name##_div))
>>>>>>> +
>>>>>>> +AUDIO_MST_MCLK(audio_mst_a_mclk, AUDIO_MCLK_A_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio_mst_b_mclk, AUDIO_MCLK_B_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio_mst_c_mclk, AUDIO_MCLK_C_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio_mst_d_mclk, AUDIO_MCLK_D_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio_spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio_eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
>>>>>>> +
>>>>>>> +AUDIO_MUX(audio_resample_clk_mux, AUDIO_CLK_RESAMPLE_CTRL, 0xf, 24,
>>>>>>> +	a1_mst_pdata);
>>>>>>> +AUDIO_DIV(audio_resample_clk_div, AUDIO_CLK_RESAMPLE_CTRL, 0, 8,
>>>>>>> +	AUDIO_PDATA(audio_resample_clk_mux));
>>>>>>> +AUDIO_GATE(audio_resample_clk, AUDIO_CLK_RESAMPLE_CTRL, 31,
>>>>>>> +	AUDIO_PDATA(audio_resample_clk_div));
>>>>>>> +
>>>>>>> +AUDIO_MUX(audio_locker_in_clk_mux, AUDIO_CLK_LOCKER_CTRL, 0xf, 8,
>>>>>>> +	a1_mst_pdata);
>>>>>>> +AUDIO_DIV(audio_locker_in_clk_div, AUDIO_CLK_LOCKER_CTRL, 0, 8,
>>>>>>> +	AUDIO_PDATA(audio_locker_in_clk_mux));
>>>>>>> +AUDIO_GATE(audio_locker_in_clk, AUDIO_CLK_LOCKER_CTRL, 15,
>>>>>>> +	AUDIO_PDATA(audio_locker_in_clk_div));
>>>>>>> +
>>>>>>> +AUDIO_MUX(audio_locker_out_clk_mux, AUDIO_CLK_LOCKER_CTRL, 0xf, 24,
>>>>>>> +	a1_mst_pdata);
>>>>>>> +AUDIO_DIV(audio_locker_out_clk_div, AUDIO_CLK_LOCKER_CTRL, 16, 8,
>>>>>>> +	AUDIO_PDATA(audio_locker_out_clk_mux));
>>>>>>> +AUDIO_GATE(audio_locker_out_clk, AUDIO_CLK_LOCKER_CTRL, 31,
>>>>>>> +	AUDIO_PDATA(audio_locker_out_clk_div));
>>>>>>> +
>>>>>>> +AUDIO_MST_MCLK(audio2_vad_mclk, AUDIO2_MCLK_VAD_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio2_vad_clk, AUDIO2_CLK_VAD_CTRL);
>>>>>>> +AUDIO_MST_MCLK(audio2_pdm_dclk, AUDIO2_CLK_PDMIN_CTRL0);
>>>>>>> +AUDIO_MST_MCLK(audio2_pdm_sysclk, AUDIO2_CLK_PDMIN_CTRL1);
>>>>>>> +
>>>>>>> +#define AUDIO_MST_SCLK(_name, _reg0, _reg1, _pdata)			\
>>>>>>> +	AUDIO_GATE(_name##_pre_en, (_reg0), 31, (_pdata));		\
>>>>>>> +	AUDIO_SCLK_DIV(_name##_div, (_reg0), 20, 10, 0, 0,		\
>>>>>>> +		AUDIO_PDATA(_name##_pre_en), true);			\
>>>>>>> +	AUDIO_GATE(_name##_post_en, (_reg0), 30,			\
>>>>>>> +		AUDIO_PDATA(_name##_div));				\
>>>>>>> +	AUDIO_TRIPHASE(_name, (_reg1), 1, 0, 2, 4,			\
>>>>>>> +		AUDIO_PDATA(_name##_post_en))
>>>>>>> +
>>>>>>
>>>>>> Again, I'm not a fan of this many levels of macro. I can live with it
>>>>>> but certainly don't want the burden of reviewing and maintaining for
>>>>>> clock driver. AXG / G12 and A1 are obviously closely related, so make it common.
>>>>>>
>>>>>>> +#define AUDIO_MST_LRCLK(_name, _reg0, _reg1, _pdata)			\
>>>>>>> +	AUDIO_SCLK_DIV(_name##_div, (_reg0), 0, 10, 10, 10,		\
>>>>>>> +		(_pdata), false);					\
>>>>>>> +	AUDIO_TRIPHASE(_name, (_reg1), 1, 1, 3, 5,			\
>>>>>>> +		AUDIO_PDATA(_name##_div))
>>>>>>> +
>>>>>>> +AUDIO_MST_SCLK(audio_mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0, AUDIO_MST_A_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_a_mclk));
>>>>>>> +AUDIO_MST_SCLK(audio_mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0, AUDIO_MST_B_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_b_mclk));
>>>>>>> +AUDIO_MST_SCLK(audio_mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0, AUDIO_MST_C_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_c_mclk));
>>>>>>> +AUDIO_MST_SCLK(audio_mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0, AUDIO_MST_D_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_d_mclk));
>>>>>>> +
>>>>>>> +AUDIO_MST_LRCLK(audio_mst_a_lrclk, AUDIO_MST_A_SCLK_CTRL0, AUDIO_MST_A_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_a_sclk_post_en));
>>>>>>> +AUDIO_MST_LRCLK(audio_mst_b_lrclk, AUDIO_MST_B_SCLK_CTRL0, AUDIO_MST_B_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_b_sclk_post_en));
>>>>>>> +AUDIO_MST_LRCLK(audio_mst_c_lrclk, AUDIO_MST_C_SCLK_CTRL0, AUDIO_MST_C_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_c_sclk_post_en));
>>>>>>> +AUDIO_MST_LRCLK(audio_mst_d_lrclk, AUDIO_MST_D_SCLK_CTRL0, AUDIO_MST_D_SCLK_CTRL1,
>>>>>>> +	AUDIO_PDATA(audio_mst_d_sclk_post_en));
>>>>>>> +
>>>>>>> +static const struct clk_parent_data a1_mst_sclk_pdata[] = {
>>>>>>> +	{ .hw = &audio_mst_a_sclk.hw },
>>>>>>> +	{ .hw = &audio_mst_b_sclk.hw },
>>>>>>> +	{ .hw = &audio_mst_c_sclk.hw },
>>>>>>> +	{ .hw = &audio_mst_d_sclk.hw },
>>>>>>> +	{ .fw_name = "slv_sclk0" },
>>>>>>> +	{ .fw_name = "slv_sclk1" },
>>>>>>> +	{ .fw_name = "slv_sclk2" },
>>>>>>> +	{ .fw_name = "slv_sclk3" },
>>>>>>> +	{ .fw_name = "slv_sclk4" },
>>>>>>> +	{ .fw_name = "slv_sclk5" },
>>>>>>> +	{ .fw_name = "slv_sclk6" },
>>>>>>> +	{ .fw_name = "slv_sclk7" },
>>>>>>> +	{ .fw_name = "slv_sclk8" },
>>>>>>> +	{ .fw_name = "slv_sclk9" },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static const struct clk_parent_data a1_mst_lrclk_pdata[] = {
>>>>>>> +	{ .hw = &audio_mst_a_lrclk.hw },
>>>>>>> +	{ .hw = &audio_mst_b_lrclk.hw },
>>>>>>> +	{ .hw = &audio_mst_c_lrclk.hw },
>>>>>>> +	{ .hw = &audio_mst_d_lrclk.hw },
>>>>>>> +	{ .fw_name = "slv_lrclk0" },
>>>>>>> +	{ .fw_name = "slv_lrclk1" },
>>>>>>> +	{ .fw_name = "slv_lrclk2" },
>>>>>>> +	{ .fw_name = "slv_lrclk3" },
>>>>>>> +	{ .fw_name = "slv_lrclk4" },
>>>>>>> +	{ .fw_name = "slv_lrclk5" },
>>>>>>> +	{ .fw_name = "slv_lrclk6" },
>>>>>>> +	{ .fw_name = "slv_lrclk7" },
>>>>>>> +	{ .fw_name = "slv_lrclk8" },
>>>>>>> +	{ .fw_name = "slv_lrclk9" },
>>>>>>> +};
>>>>>>> +
>>>>>>> +#define AUDIO_TDM_SCLK(_name, _reg)					\
>>>>>>> +	AUDIO_MUX(_name##_mux, (_reg), 0xf, 24, a1_mst_sclk_pdata);	\
>>>>>>> +	AUDIO_GATE(_name##_pre_en, (_reg), 31,				\
>>>>>>> +		AUDIO_PDATA(_name##_mux));				\
>>>>>>> +	AUDIO_GATE(_name##_post_en, (_reg), 30,				\
>>>>>>> +		AUDIO_PDATA(_name##_pre_en));				\
>>>>>>> +	AUDIO_SCLK_WS(_name, (_reg), 1, 29, 28,				\
>>>>>>> +		AUDIO_PDATA(_name##_post_en))
>>>>>>> +
>>>>>>> +#define AUDIO_TDM_LRCLK(_name, _reg)					\
>>>>>>> +	AUDIO_MUX(_name, (_reg), 0xf, 20, a1_mst_lrclk_pdata)
>>>>>>> +
>>>>>>> +AUDIO_TDM_SCLK(audio_tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
>>>>>>> +AUDIO_TDM_SCLK(audio_tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
>>>>>>> +AUDIO_TDM_SCLK(audio_tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
>>>>>>> +AUDIO_TDM_SCLK(audio_tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
>>>>>>> +AUDIO_TDM_SCLK(audio_tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
>>>>>>> +
>>>>>>> +AUDIO_TDM_LRCLK(audio_tdmin_a_lrclk, AUDIO_CLK_TDMIN_A_CTRL);
>>>>>>> +AUDIO_TDM_LRCLK(audio_tdmin_b_lrclk, AUDIO_CLK_TDMIN_B_CTRL);
>>>>>>> +AUDIO_TDM_LRCLK(audio_tdmin_lb_lrclk, AUDIO_CLK_TDMIN_LB_CTRL);
>>>>>>> +AUDIO_TDM_LRCLK(audio_tdmout_a_lrclk, AUDIO_CLK_TDMOUT_A_CTRL);
>>>>>>> +AUDIO_TDM_LRCLK(audio_tdmout_b_lrclk, AUDIO_CLK_TDMOUT_B_CTRL);
>>>>>>> +
>>>>>>> +static struct clk_hw *a1_audio_hw_clks[] = {
>>>>>>> +	[AUD_CLKID_DDR_ARB]		= &audio_ddr_arb.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_A]		= &audio_tdmin_a.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_B]		= &audio_tdmin_b.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_LB]		= &audio_tdmin_lb.hw,
>>>>>>> +	[AUD_CLKID_LOOPBACK]		= &audio_loopback.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_A]		= &audio_tdmout_a.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_B]		= &audio_tdmout_b.hw,
>>>>>>> +	[AUD_CLKID_FRDDR_A]		= &audio_frddr_a.hw,
>>>>>>> +	[AUD_CLKID_FRDDR_B]		= &audio_frddr_b.hw,
>>>>>>> +	[AUD_CLKID_TODDR_A]		= &audio_toddr_a.hw,
>>>>>>> +	[AUD_CLKID_TODDR_B]		= &audio_toddr_b.hw,
>>>>>>> +	[AUD_CLKID_SPDIFIN]		= &audio_spdifin.hw,
>>>>>>> +	[AUD_CLKID_RESAMPLE]		= &audio_resample.hw,
>>>>>>> +	[AUD_CLKID_EQDRC]		= &audio_eqdrc.hw,
>>>>>>> +	[AUD_CLKID_LOCKER]		= &audio_audiolocker.hw,
>>>>>>> +	[AUD_CLKID_MST_A_MCLK_SEL]	= &audio_mst_a_mclk_mux.hw,
>>>>>>> +	[AUD_CLKID_MST_A_MCLK_DIV]	= &audio_mst_a_mclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_A_MCLK]		= &audio_mst_a_mclk.hw,
>>>>>>> +	[AUD_CLKID_MST_B_MCLK_SEL]	= &audio_mst_b_mclk_mux.hw,
>>>>>>> +	[AUD_CLKID_MST_B_MCLK_DIV]	= &audio_mst_b_mclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_B_MCLK]		= &audio_mst_b_mclk.hw,
>>>>>>> +	[AUD_CLKID_MST_C_MCLK_SEL]	= &audio_mst_c_mclk_mux.hw,
>>>>>>> +	[AUD_CLKID_MST_C_MCLK_DIV]	= &audio_mst_c_mclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_C_MCLK]		= &audio_mst_c_mclk.hw,
>>>>>>> +	[AUD_CLKID_MST_D_MCLK_SEL]	= &audio_mst_d_mclk_mux.hw,
>>>>>>> +	[AUD_CLKID_MST_D_MCLK_DIV]	= &audio_mst_d_mclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_D_MCLK]		= &audio_mst_d_mclk.hw,
>>>>>>> +	[AUD_CLKID_RESAMPLE_CLK_SEL]	= &audio_resample_clk_mux.hw,
>>>>>>> +	[AUD_CLKID_RESAMPLE_CLK_DIV]	= &audio_resample_clk_div.hw,
>>>>>>> +	[AUD_CLKID_RESAMPLE_CLK]	= &audio_resample_clk.hw,
>>>>>>> +	[AUD_CLKID_LOCKER_IN_CLK_SEL]	= &audio_locker_in_clk_mux.hw,
>>>>>>> +	[AUD_CLKID_LOCKER_IN_CLK_DIV]	= &audio_locker_in_clk_div.hw,
>>>>>>> +	[AUD_CLKID_LOCKER_IN_CLK]	= &audio_locker_in_clk.hw,
>>>>>>> +	[AUD_CLKID_LOCKER_OUT_CLK_SEL]	= &audio_locker_out_clk_mux.hw,
>>>>>>> +	[AUD_CLKID_LOCKER_OUT_CLK_DIV]	= &audio_locker_out_clk_div.hw,
>>>>>>> +	[AUD_CLKID_LOCKER_OUT_CLK]	= &audio_locker_out_clk.hw,
>>>>>>> +	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &audio_spdifin_clk_mux.hw,
>>>>>>> +	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &audio_spdifin_clk_div.hw,
>>>>>>> +	[AUD_CLKID_SPDIFIN_CLK]		= &audio_spdifin_clk.hw,
>>>>>>> +	[AUD_CLKID_EQDRC_CLK_SEL]	= &audio_eqdrc_clk_mux.hw,
>>>>>>> +	[AUD_CLKID_EQDRC_CLK_DIV]	= &audio_eqdrc_clk_div.hw,
>>>>>>> +	[AUD_CLKID_EQDRC_CLK]		= &audio_eqdrc_clk.hw,
>>>>>>> +	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &audio_mst_a_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_MST_A_SCLK_DIV]	= &audio_mst_a_sclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &audio_mst_a_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_MST_A_SCLK]		= &audio_mst_a_sclk.hw,
>>>>>>> +	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &audio_mst_b_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_MST_B_SCLK_DIV]	= &audio_mst_b_sclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &audio_mst_b_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_MST_B_SCLK]		= &audio_mst_b_sclk.hw,
>>>>>>> +	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &audio_mst_c_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_MST_C_SCLK_DIV]	= &audio_mst_c_sclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &audio_mst_c_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_MST_C_SCLK]		= &audio_mst_c_sclk.hw,
>>>>>>> +	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &audio_mst_d_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_MST_D_SCLK_DIV]	= &audio_mst_d_sclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &audio_mst_d_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_MST_D_SCLK]		= &audio_mst_d_sclk.hw,
>>>>>>> +	[AUD_CLKID_MST_A_LRCLK_DIV]	= &audio_mst_a_lrclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_A_LRCLK]		= &audio_mst_a_lrclk.hw,
>>>>>>> +	[AUD_CLKID_MST_B_LRCLK_DIV]	= &audio_mst_b_lrclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_B_LRCLK]		= &audio_mst_b_lrclk.hw,
>>>>>>> +	[AUD_CLKID_MST_C_LRCLK_DIV]	= &audio_mst_c_lrclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_C_LRCLK]		= &audio_mst_c_lrclk.hw,
>>>>>>> +	[AUD_CLKID_MST_D_LRCLK_DIV]	= &audio_mst_d_lrclk_div.hw,
>>>>>>> +	[AUD_CLKID_MST_D_LRCLK]		= &audio_mst_d_lrclk.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &audio_tdmin_a_sclk_mux.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &audio_tdmin_a_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &audio_tdmin_a_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_A_SCLK]	= &audio_tdmin_a_sclk.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_A_LRCLK]	= &audio_tdmin_a_lrclk.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &audio_tdmin_b_sclk_mux.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &audio_tdmin_b_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &audio_tdmin_b_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_B_SCLK]	= &audio_tdmin_b_sclk.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_B_LRCLK]	= &audio_tdmin_b_lrclk.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &audio_tdmin_lb_sclk_mux.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &audio_tdmin_lb_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &audio_tdmin_lb_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_LB_SCLK]	= &audio_tdmin_lb_sclk.hw,
>>>>>>> +	[AUD_CLKID_TDMIN_LB_LRCLK]	= &audio_tdmin_lb_lrclk.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &audio_tdmout_a_sclk_mux.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &audio_tdmout_a_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &audio_tdmout_a_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_A_SCLK]	= &audio_tdmout_a_sclk.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_A_LRCLK]	= &audio_tdmout_a_lrclk.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &audio_tdmout_b_sclk_mux.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &audio_tdmout_b_sclk_pre_en.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &audio_tdmout_b_sclk_post_en.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_B_SCLK]	= &audio_tdmout_b_sclk.hw,
>>>>>>> +	[AUD_CLKID_TDMOUT_B_LRCLK]	= &audio_tdmout_b_lrclk.hw,
>>>>>>> +
>>>>>>> +	[AUD2_CLKID_DDR_ARB]		= &audio2_ddr_arb.hw,
>>>>>>> +	[AUD2_CLKID_PDM]		= &audio2_pdm.hw,
>>>>>>> +	[AUD2_CLKID_TDMIN_VAD]		= &audio2_tdmin_vad.hw,
>>>>>>> +	[AUD2_CLKID_TODDR_VAD]		= &audio2_toddr_vad.hw,
>>>>>>> +	[AUD2_CLKID_VAD]		= &audio2_vad.hw,
>>>>>>> +	[AUD2_CLKID_AUDIOTOP]		= &audio2_audiotop.hw,
>>>>>>> +	[AUD2_CLKID_VAD_MCLK_SEL]	= &audio2_vad_mclk_mux.hw,
>>>>>>> +	[AUD2_CLKID_VAD_MCLK_DIV]	= &audio2_vad_mclk_div.hw,
>>>>>>> +	[AUD2_CLKID_VAD_MCLK]		= &audio2_vad_mclk.hw,
>>>>>>> +	[AUD2_CLKID_VAD_CLK_SEL]	= &audio2_vad_clk_mux.hw,
>>>>>>> +	[AUD2_CLKID_VAD_CLK_DIV]	= &audio2_vad_clk_div.hw,
>>>>>>> +	[AUD2_CLKID_VAD_CLK]		= &audio2_vad_clk.hw,
>>>>>>> +	[AUD2_CLKID_PDM_DCLK_SEL]	= &audio2_pdm_dclk_mux.hw,
>>>>>>> +	[AUD2_CLKID_PDM_DCLK_DIV]	= &audio2_pdm_dclk_div.hw,
>>>>>>> +	[AUD2_CLKID_PDM_DCLK]		= &audio2_pdm_dclk.hw,
>>>>>>> +	[AUD2_CLKID_PDM_SYSCLK_SEL]	= &audio2_pdm_sysclk_mux.hw,
>>>>>>> +	[AUD2_CLKID_PDM_SYSCLK_DIV]	= &audio2_pdm_sysclk_div.hw,
>>>>>>> +	[AUD2_CLKID_PDM_SYSCLK]		= &audio2_pdm_sysclk.hw,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct meson_clk_hw_data a1_audio_clks = {
>>>>>>> +	.hws = a1_audio_hw_clks,
>>>>>>> +	.num = ARRAY_SIZE(a1_audio_hw_clks),
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct regmap *a1_audio_map(struct platform_device *pdev,
>>>>>>> +				   unsigned int index)
>>>>>>> +{
>>>>>>> +	char name[32];
>>>>>>> +	const struct regmap_config cfg = {
>>>>>>> +		.reg_bits = 32,
>>>>>>> +		.val_bits = 32,
>>>>>>> +		.reg_stride = 4,
>>>>>>> +		.name = name,
>>>>>>
>>>>>> Not necessary
>>>>>>
>>>>>
>>>>> This implementation uses two regmaps, and this field allow to avoid
>>>>> errors like this:
>>>>>
>>>>> [    0.145530] debugfs: Directory 'fe050000.audio-clock-controller' with
>>>>> parent 'regmap' already present!
>>>>>
>>>>>>> +	};
>>>>>>> +	void __iomem *base;
>>>>>>> +
>>>>>>> +	base = devm_platform_ioremap_resource(pdev, index);
>>>>>>> +	if (IS_ERR(base))
>>>>>>> +		return base;
>>>>>>> +
>>>>>>> +	scnprintf(name, sizeof(name), "%d", index);
>>>>>>> +	return devm_regmap_init_mmio(&pdev->dev, base, &cfg);
>>>>>>> +}
>>>>>>
>>>>>> That is overengineered. Please keep it simple. Declare the regmap_config
>>>>>> as static const global, and do it like axg-audio please.
>>>>>>
>>>>>
>>>>> This only reason why it is not "static const" because I need to set
>>>>> unique name for each regmap.
>>>>>
>>>>>>> +
>>>>>>> +static int a1_register_clk(struct platform_device *pdev,
>>>>>>> +			   struct regmap *map0, struct regmap *map1,
>>>>>>> +			   struct clk_hw *hw)
>>>>>>> +{
>>>>>>> +	struct clk_regmap *clk = container_of(hw, struct clk_regmap, hw);
>>>>>>> +
>>>>>>> +	if (!hw)
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>> +	switch ((unsigned long)clk->map) {
>>>>>>> +	case AUDIO_RANGE_0:
>>>>>>> +		clk->map = map0;
>>>>>>> +		break;
>>>>>>> +	case AUDIO_RANGE_1:
>>>>>>> +		clk->map = map1;
>>>>>>> +		break;
>>>>>>
>>>>>> ... fishy
>>>>>>
>>>>>>> +	default:
>>>>>>> +		WARN_ON(1);
>>>>>>> +		return -EINVAL;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	return devm_clk_hw_register(&pdev->dev, hw);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int a1_audio_clkc_probe(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +	struct regmap *map0, *map1;
>>>>>>> +	struct clk *clk;
>>>>>>> +	unsigned int i;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	clk = devm_clk_get_enabled(&pdev->dev, "pclk");
>>>>>>> +	if (WARN_ON(IS_ERR(clk)))
>>>>>>> +		return PTR_ERR(clk);
>>>>>>> +
>>>>>>> +	map0 = a1_audio_map(pdev, 0);
>>>>>>> +	if (IS_ERR(map0))
>>>>>>> +		return PTR_ERR(map0);
>>>>>>> +
>>>>>>> +	map1 = a1_audio_map(pdev, 1);
>>>>>>> +	if (IS_ERR(map1))
>>>>>>> +		return PTR_ERR(map1);
>>>>>>
>>>>>> No - Looks to me you just have two clock controllers you are trying
>>>>>> force into one.
>>>>>>
>>>>>
>>>>> See the begining.
>>>>>
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * Register and enable AUD2_CLKID_AUDIOTOP clock first. Unless
>>>>>>> +	 * it is enabled any read/write to 'map0' hangs the CPU.
>>>>>>> +	 */
>>>>>>> +
>>>>>>> +	ret = a1_register_clk(pdev, map0, map1,
>>>>>>> +			      a1_audio_clks.hws[AUD2_CLKID_AUDIOTOP]);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +
>>>>>>> +	ret = clk_prepare_enable(a1_audio_clks.hws[AUD2_CLKID_AUDIOTOP]->clk);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>
>>>>>> Again, this shows 2 devices. The one related to your 'map0' should
>>>>>> request AUD2_CLKID_AUDIOTOP as input and enable it right away.
>>>>>>
>>>>>
>>>>> See the begining.
>>>>>
>>>>>>> +
>>>>>>> +	for (i = 0; i < a1_audio_clks.num; i++) {
>>>>>>> +		if (i == AUD2_CLKID_AUDIOTOP)
>>>>>>> +			continue;
>>>>>>> +
>>>>>>> +		ret = a1_register_clk(pdev, map0, map1, a1_audio_clks.hws[i]);
>>>>>>> +		if (ret)
>>>>>>> +			return ret;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	ret = devm_of_clk_add_hw_provider(&pdev->dev, meson_clk_hw_get,
>>>>>>> +					  &a1_audio_clks);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +
>>>>>>> +	BUILD_BUG_ON((unsigned long)AUDIO_REG_MAP(AUDIO_SW_RESET0) !=
>>>>>>> +		     AUDIO_RANGE_0);
>>>>>>
>>>>>> Why is that necessary ?
>>>>>>
>>>>>
>>>>> A little paranoia. Here AUDIO_SW_RESET0 is handled as map0's register,
>>>>> and I want to assert it.
>>>>>
>>>>>>> +	return meson_audio_rstc_register(&pdev->dev, map0,
>>>>>>> +					 AUDIO_REG_OFFSET(AUDIO_SW_RESET0), 32);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct of_device_id a1_audio_clkc_match_table[] = {
>>>>>>> +	{ .compatible = "amlogic,a1-audio-clkc", },
>>>>>>> +	{}
>>>>>>> +};
>>>>>>> +MODULE_DEVICE_TABLE(of, a1_audio_clkc_match_table);
>>>>>>> +
>>>>>>> +static struct platform_driver a1_audio_clkc_driver = {
>>>>>>> +	.probe = a1_audio_clkc_probe,
>>>>>>> +	.driver = {
>>>>>>> +		.name = "a1-audio-clkc",
>>>>>>> +		.of_match_table = a1_audio_clkc_match_table,
>>>>>>> +	},
>>>>>>> +};
>>>>>>> +module_platform_driver(a1_audio_clkc_driver);
>>>>>>> +
>>>>>>> +MODULE_DESCRIPTION("Amlogic A1 Audio Clock driver");
>>>>>>> +MODULE_AUTHOR("Jan Dakinevich <jan.dakinevich@salutedevices.com>");
>>>>>>> +MODULE_LICENSE("GPL");
>>>>>>> diff --git a/drivers/clk/meson/a1-audio.h b/drivers/clk/meson/a1-audio.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..f994e87276cd
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/clk/meson/a1-audio.h
>>>>>>> @@ -0,0 +1,58 @@
>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>>>>>>> + *
>>>>>>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef __A1_AUDIO_H
>>>>>>> +#define __A1_AUDIO_H
>>>>>>> +
>>>>>>> +#define AUDIO_RANGE_0		0xa
>>>>>>> +#define AUDIO_RANGE_1		0xb
>>>>>>> +#define AUDIO_RANGE_SHIFT	16
>>>>>>> +
>>>>>>> +#define AUDIO_REG(_range, _offset) \
>>>>>>> +	(((_range) << AUDIO_RANGE_SHIFT) + (_offset))
>>>>>>> +
>>>>>>> +#define AUDIO_REG_OFFSET(_reg) \
>>>>>>> +	((_reg) & ((1 << AUDIO_RANGE_SHIFT) - 1))
>>>>>>> +
>>>>>>> +#define AUDIO_REG_MAP(_reg) \
>>>>>>> +	((void *)((_reg) >> AUDIO_RANGE_SHIFT))
>>>>>>
>>>>>> That is seriouly overengineered.
>>>>>> The following are offset. Just write what they are.
>>>>>>
>>>>>
>>>>> This is all in order to keep range's identifier together with offset and
>>>>> then use it to store the identifier in clk_regmaps.
>>>>>
>>>>>> There is not reason to put that into a header. It is only going to be
>>>>>> used by a single driver.
>>>>>>>> +
>>>>>>> +#define AUDIO_CLK_GATE_EN0	AUDIO_REG(AUDIO_RANGE_0, 0x000)
>>>>>>> +#define AUDIO_MCLK_A_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x008)
>>>>>>> +#define AUDIO_MCLK_B_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x00c)
>>>>>>> +#define AUDIO_MCLK_C_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x010)
>>>>>>> +#define AUDIO_MCLK_D_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x014)
>>>>>>> +#define AUDIO_MCLK_E_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x018)
>>>>>>> +#define AUDIO_MCLK_F_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x01c)
>>>>>>> +#define AUDIO_SW_RESET0		AUDIO_REG(AUDIO_RANGE_0, 0x028)
>>>>>>> +#define AUDIO_MST_A_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x040)
>>>>>>> +#define AUDIO_MST_A_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x044)
>>>>>>> +#define AUDIO_MST_B_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x048)
>>>>>>> +#define AUDIO_MST_B_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x04c)
>>>>>>> +#define AUDIO_MST_C_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x050)
>>>>>>> +#define AUDIO_MST_C_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x054)
>>>>>>> +#define AUDIO_MST_D_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x058)
>>>>>>> +#define AUDIO_MST_D_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x05c)
>>>>>>> +#define AUDIO_CLK_TDMIN_A_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x080)
>>>>>>> +#define AUDIO_CLK_TDMIN_B_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x084)
>>>>>>> +#define AUDIO_CLK_TDMIN_LB_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x08c)
>>>>>>> +#define AUDIO_CLK_TDMOUT_A_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x090)
>>>>>>> +#define AUDIO_CLK_TDMOUT_B_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x094)
>>>>>>> +#define AUDIO_CLK_SPDIFIN_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x09c)
>>>>>>> +#define AUDIO_CLK_RESAMPLE_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x0a4)
>>>>>>> +#define AUDIO_CLK_LOCKER_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x0a8)
>>>>>>> +#define AUDIO_CLK_EQDRC_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x0c0)
>>>>>>> +
>>>>>>> +#define AUDIO2_CLK_GATE_EN0	AUDIO_REG(AUDIO_RANGE_1, 0x00c)
>>>>>>> +#define AUDIO2_MCLK_VAD_CTRL	AUDIO_REG(AUDIO_RANGE_1, 0x040)
>>>>>>> +#define AUDIO2_CLK_VAD_CTRL	AUDIO_REG(AUDIO_RANGE_1, 0x044)
>>>>>>> +#define AUDIO2_CLK_PDMIN_CTRL0	AUDIO_REG(AUDIO_RANGE_1, 0x058)
>>>>>>> +#define AUDIO2_CLK_PDMIN_CTRL1	AUDIO_REG(AUDIO_RANGE_1, 0x05c)
>>>>>>> +
>>>>>>> +#include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
>>>>>>> +
>>>>>>> +#endif /* __A1_AUDIO_H */
>>>>>>
>>>>>>
>>>>
>>>>
>> 
>> 


-- 
Jerome

