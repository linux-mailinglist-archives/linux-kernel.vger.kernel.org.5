Return-Path: <linux-kernel+bounces-53100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21984A0A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CE21C21A49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52744C67;
	Mon,  5 Feb 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXW5J3TW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0347F55
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154031; cv=none; b=KZkYw51iCZdGEGapZqh3QFfcKBTVe6b0KxeRMcV1Kc8yBuheRaRc4rdAnJMrMY8eSQH0eGuV+DqFPXKDAYvjr9NU0inedvKjnZdoDIhowFxBuJdchkPcxx9bSRn+ipx4ChFxcsWrhtIvn83bX0RZHX7w/KIJsK3FLLf9Jbxg6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154031; c=relaxed/simple;
	bh=VMTW2beRlBbZDRiezbv2nYqJih165oy4DIL7xlmJ6QA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k31QnwtbyEbmHJyt52I9X9lxEEK0BE4J9qjFMu5wDyQHE+AFeShlgExUdOjqTUJ+JIre7RcEiWJcx2o2UI4m/FxOoGzQUW6b9eR0Hpo2TtEGBX/x1Ivb95XZc/UgqUuJzGKUFVKNtYUWdG0rAuPpjYaqNMIfLu8Pxnhj5y5W64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FXW5J3TW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so41725065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707154028; x=1707758828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMru6AidNjxHu9ibv3haOjJruYNOLtUg/L29w6bwKNE=;
        b=FXW5J3TWICk8pvzPKyT6RPPprOmJF1afeMfvHfmKE6tCuZwCuQVPDzi2PwRpi/dJDl
         TGwxfdnIxMVWyaxBiENoWAHCKKgmuZVmFjEjlJ85I3mHtHCkr2j8E1x1C+RqGTAWfZiz
         eEmuzZAnxlsUVd9cn/MXD1MxuTPQyyQEmehMV+UD8CVxgTZCtE93ijTDTYk61q5GOlGK
         jPsdPryf4c6ZeBaK+lwfBLTALTx8B/iveYgtlpPqkK8PY6Jt/KvkUbJLd4w5YVCg31xT
         PHOqz/ZlC3uYQxAmduESybda4gUaP15KhyQ2PIAhdxh8THYm1CASS8n9kn4mVmP1NMvl
         /Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154028; x=1707758828;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMru6AidNjxHu9ibv3haOjJruYNOLtUg/L29w6bwKNE=;
        b=K6yoE8Q6vNzCDuFHpQo/QTV4f0zmbbGVbxr/W0eaewZOsuiqawg9LIyTTfRnpEwdRS
         gCenzqY8W5lL9BcEG7EGxGvW4rsZ74UKIRbzr1tw8I45KpQ4gRzxzxiq0LGKg6RvE6Cp
         a07jE7HK2UoaO9OpdRSl8wPAsimhSTPvKGlbjDezLRG8AJyDOrZgzP5cMU2MjE04+349
         v8KFguIgjRUW+Ugq7kiIMwcnK9jgV/fYpTvV2ZsdHNBD6ki9afkHKKcOQ13FejWJPuTQ
         OAqxoi8gW9FOi/na37CM2d1kkuwpf33pymkP6dQkfxYygnswDFX5njUTHSPHtNCbhJEx
         Q8YQ==
X-Gm-Message-State: AOJu0Yy61foEDWo5dwQVC2eFoBe9pqk59AS4WsgReOqUv/QVoZE9DXQW
	+09vNyOhhAz2gwFR9QWXmWWfFDngI/m4fPLRYrhPWkOTpg/cD3Yt55lvMRGTDOk=
X-Google-Smtp-Source: AGHT+IGqsklbXdcarnxN/oePIcw2eHMQaP5PO315W+UnHaCzfnREsw03nS1Y5e21/Q6K0XmDyFQsww==
X-Received: by 2002:a05:600c:43c9:b0:40f:de25:f9b4 with SMTP id f9-20020a05600c43c900b0040fde25f9b4mr334103wmn.26.1707154027677;
        Mon, 05 Feb 2024 09:27:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoBk7xaDOAj/sPyYLWj9t+ELr5A3fttpi5QII/7M/c70qSFluxBCnl41i/l9ANS9wjBXyuHhV32eaF2hWhKptfmf3E7+Jm+xybKwXaeDJFqgRcyk8wJriY/bhnlQ8l3zzEQtzRydK6yoVjxRfl2OeFywHwFfL7DraNJQCExU6HbUJeRuZJj4JuER1+IOAV1/XDAV159usi1ehzHCWTErAeLEFPiLVmyRR2mtIOM24SD4jP2uBWFFQ2dNmyWNIrfw9XbdhSM2cx17FzIiGWlDYbURdDOs4iz5y2OnhSTelu570uDKhrlHGV6u5dNXljurmfjWaIM2Ohp797TfbZnqk9RNIWOD84Oa0D84SqAhDMXCC5pFAE8qzQjnujteB4ft+y3C39IUedBX8MbgOTmHhVnVGl6r9k4YGaspN94Rz4unPBzeaEUpYwUNeQwIXyZ4jdUd4XXQii3EFwxX0GEqSaK0HvmsN4sImIMv3DT+vjGTYVugJ1Z3WN9Dt96twXPAmDULePAAWSgubqIQOlFf7ZBqLmMUZ6Zis1CxXhWXgHxtCxWfpUi4BCG8GlW49epyUshNxRL6sdhkhv10x4y34f+Xn+29aiVPK2bBIGm8gnaA5sjK5WeaMUsfvG7dW/ovBjHTEYNblXIQbW6d6GIpTHZKz3fEoQFqvvJiOFT2PPfS0rB34VhtvcLYykSo/su4pUzAteF11xYKwm4F64vIODrxNAKQnW8LW+57WFTGEHC6dBzD8mRDcvVdmive9m3PrCsRzSpeGXdEhE0BVA34B22cIgz2Re21TjfK97wfUPGloHw+6TUhyntYehWP4m/vejsoLUIYH4NLCbLoLCISNDLGACDb8hoS9ymwZY5WM=
Received: from ?IPV6:2a01:e0a:982:cbb0:bbd9:ac3e:db1d:9662? ([2a01:e0a:982:cbb0:bbd9:ac3e:db1d:9662])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040e3635ca65sm9310508wmq.2.2024.02.05.09.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:27:06 -0800 (PST)
Message-ID: <9d7b3a35-6d21-4b7a-8669-cf3610467cad@linaro.org>
Date: Mon, 5 Feb 2024 18:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v9 07/12] clk: meson: add vclk driver
Content-Language: en-US, fr
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jagan Teki <jagan@amarulasolutions.com>, Nicolas Belin
 <nbelin@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Remi Pommarel
 <repk@triplefau.lt>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-7-95256ed139e6@linaro.org>
 <1j7cm7dx1b.fsf@starbuckisacylon.baylibre.com>
 <4e5e33c1-45d5-4c83-b647-bfb603347156@linaro.org>
 <1jfs0rywqi.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jfs0rywqi.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:24, Jerome Brunet wrote:
> 
> On Mon 27 Nov 2023 at 17:14, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 24/11/2023 15:41, Jerome Brunet wrote:
>>> On Fri 24 Nov 2023 at 09:41, Neil Armstrong <neil.armstrong@linaro.org>
>>> wrote:
>>>
>>>> The VCLK and VCLK_DIV clocks have supplementary bits.
>>>>
>>>> The VCLK has a "SOFT RESET" bit to toggle after the whole
>>>> VCLK sub-tree rate has been set, this is implemented in
>>>> the gate enable callback.
>>>>
>>>> The VCLK_DIV clocks as enable and reset bits used to disable
>>>> and reset the divider, associated with CLK_SET_RATE_GATE it ensures
>>>> the rate is set while the divider is disabled and in reset mode.
>>>>
>>>> The VCLK_DIV enable bit isn't implemented as a gate since it's part
>>>> of the divider logic and vendor does this exact sequence to ensure
>>>> the divider is correctly set.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/clk/meson/Kconfig  |   5 ++
>>>>    drivers/clk/meson/Makefile |   1 +
>>>>    drivers/clk/meson/vclk.c   | 141 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    drivers/clk/meson/vclk.h   |  51 ++++++++++++++++
>>>>    4 files changed, 198 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index 29ffd14d267b..59a40a49f8e1 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -30,6 +30,10 @@ config COMMON_CLK_MESON_VID_PLL_DIV
>>>>    	tristate
>>>>    	select COMMON_CLK_MESON_REGMAP
>>>>    +config COMMON_CLK_MESON_VCLK
>>>> +	tristate
>>>> +	select COMMON_CLK_MESON_REGMAP
>>>> +
>>>>    config COMMON_CLK_MESON_CLKC_UTILS
>>>>    	tristate
>>>>    @@ -140,6 +144,7 @@ config COMMON_CLK_G12A
>>>>    	select COMMON_CLK_MESON_EE_CLKC
>>>>    	select COMMON_CLK_MESON_CPU_DYNDIV
>>>>    	select COMMON_CLK_MESON_VID_PLL_DIV
>>>> +	select COMMON_CLK_MESON_VCLK
>>> This particular line belong in the next patch
>>>
>>>>    	select MFD_SYSCON
>>>>    	help
>>>>    	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index 9ee4b954c896..9ba43fe7a07a 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
>>>>    obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
>>>>    obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
>>>>    obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
>>>> +obj-$(CONFIG_COMMON_CLK_MESON_VCLK) += vclk.o
>>>>      # Amlogic Clock controllers
>>>>    diff --git a/drivers/clk/meson/vclk.c b/drivers/clk/meson/vclk.c
>>>> new file mode 100644
>>>> index 000000000000..47f08a52b49f
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/vclk.c
>>>> @@ -0,0 +1,141 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include "vclk.h"
>>>> +
>>>> +/* The VCLK gate has a supplementary reset bit to pulse after ungating */
>>>> +
>>>> +static inline struct clk_regmap_vclk_data *
>>>> +clk_get_regmap_vclk_data(struct clk_regmap *clk)
>>>> +{
>>>> +	return (struct clk_regmap_vclk_data *)clk->data;
>>>> +}
>>>> +
>>>> +static int clk_regmap_vclk_enable(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
>>>> +
>>>> +	meson_parm_write(clk->map, &vclk->enable, 1);
>>>> +
>>>> +	/* Do a reset pulse */
>>>> +	meson_parm_write(clk->map, &vclk->reset, 1);
>>>> +	meson_parm_write(clk->map, &vclk->reset, 0);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void clk_regmap_vclk_disable(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
>>>> +
>>>> +	meson_parm_write(clk->map, &vclk->enable, 0);
>>>> +}
>>>> +
>>>> +static int clk_regmap_vclk_is_enabled(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
>>>> +
>>>> +	return meson_parm_read(clk->map, &vclk->enable);
>>>> +}
>>>> +
>>>> +const struct clk_ops clk_regmap_vclk_ops = {
>>>> +	.enable = clk_regmap_vclk_enable,
>>>> +	.disable = clk_regmap_vclk_disable,
>>>> +	.is_enabled = clk_regmap_vclk_is_enabled,
>>>> +};
>>>> +EXPORT_SYMBOL_GPL(clk_regmap_vclk_ops);
>>> s/clk_regmap_vclk/meson_vclk at least for what is exported, ideally most
>>> all the code.
>>> I get clk_regmap_ comes from code copied from clk_regmap.c.
>>> The reason the this part is different (and not using parm) if that when
>>> I converted amlogic to regmap, I hope we could make this generic,
>>> possibly converging between aml and qcom (which was the only other
>>> platform using regmap for clock at the time). This is why clk_regmap.c
>>> is a bit different from the other driver.
>>> For the aml specific drivers, best to look at the mpll or cpu-dyndiv one.
>>>
>>>> +
>>>> +/* The VCLK Divider has supplementary reset & enable bits */
>>>> +
>>>> +static inline struct clk_regmap_vclk_div_data *
>>>> +clk_get_regmap_vclk_div_data(struct clk_regmap *clk)
>>>> +{
>>>> +	return (struct clk_regmap_vclk_div_data *)clk->data;
>>>> +}
>>>> +
>>>> +static unsigned long clk_regmap_vclk_div_recalc_rate(struct clk_hw *hw,
>>>> +						     unsigned long prate)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>>>> +
>>>> +	return divider_recalc_rate(hw, prate, meson_parm_read(clk->map, &vclk->div),
>>>> +				   vclk->table, vclk->flags, vclk->div.width);
>>>> +}
>>>> +
>>>> +static int clk_regmap_vclk_div_determine_rate(struct clk_hw *hw,
>>>> +					      struct clk_rate_request *req)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>>>> +
>>>> +	return divider_determine_rate(hw, req, vclk->table, vclk->div.width,
>>>> +				      vclk->flags);
>>>> +}
>>>> +
>>>> +static int clk_regmap_vclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
>>>> +					unsigned long parent_rate)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>>>> +	int ret;
>>>> +
>>>> +	ret = divider_get_val(rate, parent_rate, vclk->table, vclk->div.width,
>>>> +			      vclk->flags);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	meson_parm_write(clk->map, &vclk->div, ret);
>>>> +
>>>> +	return 0;
>>>> +};
>>>> +
>>>> +static int clk_regmap_vclk_div_enable(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>>>> +
>>>> +	/* Unreset the divider when ungating */
>>>> +	meson_parm_write(clk->map, &vclk->reset, 0);
>>>> +	meson_parm_write(clk->map, &vclk->enable, 1);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void clk_regmap_vclk_div_disable(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>>>> +
>>>> +	/* Reset the divider when gating */
>>>> +	meson_parm_write(clk->map, &vclk->enable, 0);
>>>> +	meson_parm_write(clk->map, &vclk->reset, 1);
>>>> +}
>>>> +
>>>> +static int clk_regmap_vclk_div_is_enabled(struct clk_hw *hw)
>>>> +{
>>>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>>>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>>>> +
>>>> +	return meson_parm_read(clk->map, &vclk->enable);
>>>> +}
>>>> +
>>>> +const struct clk_ops clk_regmap_vclk_div_ops = {
>>>> +	.recalc_rate = clk_regmap_vclk_div_recalc_rate,
>>>> +	.determine_rate = clk_regmap_vclk_div_determine_rate,
>>>> +	.set_rate = clk_regmap_vclk_div_set_rate,
>>>> +	.enable = clk_regmap_vclk_div_enable,
>>>> +	.disable = clk_regmap_vclk_div_disable,
>>>> +	.is_enabled = clk_regmap_vclk_div_is_enabled,
>>>> +};
>>>> +EXPORT_SYMBOL_GPL(clk_regmap_vclk_div_ops);
>>>> +
>>>> +MODULE_DESCRIPTION("Amlogic vclk clock driver");
>>>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/clk/meson/vclk.h b/drivers/clk/meson/vclk.h
>>>> new file mode 100644
>>>> index 000000000000..4f25d7ad2717
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/vclk.h
>>
>> Is vclk.c/h ok ? clk-vclk doesn't look pretty, but I can switch to it to
>> keep files organized.
> 
> I don't have a strong opinion about it.
> I would have suggested vclk-div.c/h - like sclk ... but you do have gate
> ops in there, so ... :/
> 
> This made me realize that one does not really go without the other.
> It is more a coherent block, isn't it ?
> Would it make more sense to have these 2 merged in a single clk_ops ?

No those a 2 separate blocks, one is for VCLK clock input and the other is for the DIV
block, and the reset isn't used in the same way so I can't merge them.

> 
> It's bit late to point this out, sorry about that.
> 
> I let you decide whether to merge the ops or not and which name to pick.
> 
> If you keep them separated, meson_vclk_gate_ops instead of just
> meson_vclk_ops, to make things clear.

Ack

> 
>>
>> Neil
>>
>>>> @@ -0,0 +1,51 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>>>> + */
>>>> +
>>>> +#ifndef __VCLK_H
>>>> +#define __VCLK_H
>>> This is too generic.
>>> Please add the MESON prefix like the other clock driver please.
>>>
>>>> +
>>>> +#include "clk-regmap.h"
>>>> +#include "parm.h"
>>>> +
>>>> +/**
>>>> + * struct clk_regmap_vclk_data - vclk regmap backed specific data
>>>> + *
>>>> + * @enable:	vclk enable field
>>>> + * @reset:	vclk reset field
>>>> + * @flags:	hardware-specific flags
>>>> + *
>>>> + * Flags:
>>>> + * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
>>>> + */
>>>> +struct clk_regmap_vclk_data {
>>>> +	struct parm enable;
>>>> +	struct parm reset;
>>>> +	u8 flags;
>>>> +};
>>>> +
>>>> +extern const struct clk_ops clk_regmap_vclk_ops;
>>>> +
>>>> +/**
>>>> + * struct clk_regmap_vclk_div_data - vclk_div regmap back specific data
>>>> + *
>>>> + * @div:	divider field
>>>> + * @enable:	vclk divider enable field
>>>> + * @reset:	vclk divider reset field
>>>> + * @table:	array of value/divider pairs, last entry should have div = 0
>>>> + *
>>>> + * Flags:
>>>> + * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
>>>> + */
>>>> +struct clk_regmap_vclk_div_data {
>>>> +	struct parm div;
>>>> +	struct parm enable;
>>>> +	struct parm reset;
>>>> +	const struct clk_div_table *table;
>>>> +	u8 flags;
>>>> +};
>>>> +
>>>> +extern const struct clk_ops clk_regmap_vclk_div_ops;
>>>> +
>>>> +#endif /* __VCLK_H */
>>>
> 
> 


