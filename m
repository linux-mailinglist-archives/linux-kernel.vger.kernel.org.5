Return-Path: <linux-kernel+bounces-125154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17F589213A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54071C25ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1439A85653;
	Fri, 29 Mar 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbY1KROb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B63D966
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728419; cv=none; b=drBKKeACHg9irWlOQL0qsR/6sp4hVu+86V2iw5qyVXVNrW8kfHc8lEOu+mkASbUlTf2EgR97lVJlnEqTr3fcPiCWogFX+jmGo6UGqLes2AnkEOTRywcLrHg0NdakHqX8SeHwTrVLuiXrftRMXtsefLUBXRgIDTXfm635MgGvXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728419; c=relaxed/simple;
	bh=NA5/TaT8vH2HUv4VRGCvYoGbcgqf+4IUw5+XIwYDjIY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ecsbjgkLdj5BnA0FbVIQHJaWbYlvnu8+Tj7rv/u6mJLo9b3lt+dgCQuweN3oCHE6RV5pn0MCN05h8irXFGWMZaLExaZJLzvM0jBQHUKg3XJotIzIaG3gUO4TrQgdKb1dBOlCOwczrETZ8cEo6ZFM6A8lGDlKdju0UnIGvyOcNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbY1KROb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4154464f150so10362755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711728414; x=1712333214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=910sYo/xx/qV+ioXaoBH98NDqB9jTlEs+LCNU9Jr8Vg=;
        b=KbY1KRObp6hIQdAZJf8fpflycn26F7xahFADKBZ86L+b52udLcGF3nv8g8oAaxx07X
         Fguy+c5Mv3lG3iV1XDgzCn97gkSwnw7bs6Bds/twhwHFD4JWl/wUw4OpMlm5b9Fv+AK9
         hB4QmOWUWuvRLTTjP43mWAOpJKxRkXYrEtHpGJwblhCYY+Xm53lFJ/C0jACWXT4zegjB
         QKq8Ci3QCyIC2W8qeBr+WD6szlEYJlJiMd5/XqdIkWotjoT4/WcFl3bm9qE68kKDB5jj
         RVoxYBCp3mQJmdJmAl2LHM2as6/+UfTG7dbwZdOnv22d9xL2wRfNchkwH7GbgtJtn02l
         X4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728414; x=1712333214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=910sYo/xx/qV+ioXaoBH98NDqB9jTlEs+LCNU9Jr8Vg=;
        b=JUHqpMGcPDZfKKk0SYEdfVYKXdiD2POnPGEpxMEH6MqcICAjSEGbz5DyNUleMwpGNn
         rnWVAaBiBHMz/swWm0/rmSSmzpi0QD1rh1DScVguhJdw9PWLEX5Yd8TkAUHM1JajbeE+
         Mgtt0ry2iR8u6+MUv1klXJKWhbzggyJIf12f6/TgOdUDJpnmxjtzuK1JAOWRA96jWZDH
         j2Qvb1+CHERtmZzAS+BkVdeKiNtaPYa/wUlh4T6DM/+MolVmvxvg4XLMINV87Wc+i0Tk
         tqRSSGRo6b6d96JOb7NniM7hTCPxnAFkc01gOgOClXUSUn4+kf3I5X2tJ3NcYmitCFVU
         IdKw==
X-Forwarded-Encrypted: i=1; AJvYcCXbShxSdgxFW5NFGO9z7Haqk53w6KxJ8UpkprjHN0HuyABNURodf432hljF7TaA22WEjAWx+GTYfnpxWw44+SjHvf4aoSNL8LqINlHw
X-Gm-Message-State: AOJu0YyZS9m4sORBWdcEofjapMz3TxxSWXMzWxMzCoKQtT4oGpfa01Tj
	YEBqUdzGo5osl6ZxItiO/oQKaBu/tOdJH3dEfbT9V5a0FJgcVMmpteIDsinJv2w=
X-Google-Smtp-Source: AGHT+IEUGFncxOKRlhWzHn6/3rGUasXsB6aBZluKSo+5RB0TvYX13ogX/YivIl/dkflWpGfRX1SW6A==
X-Received: by 2002:a05:600c:314b:b0:414:5e9b:804b with SMTP id h11-20020a05600c314b00b004145e9b804bmr5106212wmo.10.1711728413972;
        Fri, 29 Mar 2024 09:06:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3cd8:c97b:1468:c232? ([2a01:e0a:982:cbb0:3cd8:c97b:1468:c232])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0041550a32112sm1917639wmq.42.2024.03.29.09.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 09:06:53 -0700 (PDT)
Message-ID: <15e637ee-e72d-494c-bc0e-fc30921e9285@linaro.org>
Date: Fri, 29 Mar 2024 17:06:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v11 3/7] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Nicolas Belin <nbelin@baylibre.com>, Jagan Teki
 <jagan@amarulasolutions.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
References: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
 <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-3-04f55de44604@linaro.org>
 <1jv8558b11.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <1jv8558b11.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/03/2024 13:35, Jerome Brunet wrote:
> 
> On Mon 25 Mar 2024 at 12:09, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> In order to setup the DSI clock, let's make the unused VCLK2 clock path
>> configuration via CCF.
>>
>> The nocache option is removed from following clocks:
>> - vclk2_sel
>> - vclk2_input
>> - vclk2_div
>> - vclk2
>> - vclk_div1
>> - vclk2_div2_en
>> - vclk2_div4_en
>> - vclk2_div6_en
>> - vclk2_div12_en
>> - vclk2_div2
>> - vclk2_div4
>> - vclk2_div6
>> - vclk2_div12
>> - cts_encl_sel
>>
>> vclk2 and vclk2_div uses the newly introduced vclk regmap driver
>> to handle the enable and reset bits.
>>
>> In order to set a rate on cts_encl via the vclk2 clock path,
>> the NO_REPARENT flag is set on cts_encl_sel & vclk2_sel in order
>> to keep CCF from selection a parent.
>> The parents of cts_encl_sel & vclk2_sel are expected to be defined
>> in DT or manually set by the display driver at some point.
>>
>> The following clock scheme is to be used for DSI:
>>
>> xtal
>> \_ gp0_pll_dco
>>     \_ gp0_pll
>>        |- vclk2_sel
>>        |  \_ vclk2_input
>>        |     \_ vclk2_div
>>        |        \_ vclk2
>>        |           \_ vclk2_div1
>>        |              \_ cts_encl_sel
>>        |                 \_ cts_encl	-> to VPU LCD Encoder
>>        |- mipi_dsi_pxclk_sel
>>        \_ mipi_dsi_pxclk_div
>>           \_ mipi_dsi_pxclk		-> to DSI controller
>>
>> The mipi_dsi_pxclk_div is set as bypass with a single /1 entry in div_table
>> in order to use the same GP0 for mipi_dsi_pxclk and vclk2_input.
>>
>> The SET_RATE_PARENT is only set on the mipi_dsi_pxclk_sel clock so the
>> DSI bitclock is the reference base clock to calculate the vclk2_div value
>> when pixel clock is set on the cts_encl endpoint.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/clk/meson/Kconfig |  1 +
>>   drivers/clk/meson/g12a.c  | 72 ++++++++++++++++++++++++++++++++++-------------
>>   2 files changed, 53 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 8a9823789fa3..59a40a49f8e1 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -144,6 +144,7 @@ config COMMON_CLK_G12A
>>   	select COMMON_CLK_MESON_EE_CLKC
>>   	select COMMON_CLK_MESON_CPU_DYNDIV
>>   	select COMMON_CLK_MESON_VID_PLL_DIV
>> +	select COMMON_CLK_MESON_VCLK
>>   	select MFD_SYSCON
>>   	help
>>   	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index 90f4c6103014..083882e53b65 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -22,6 +22,7 @@
>>   #include "clk-regmap.h"
>>   #include "clk-cpu-dyndiv.h"
>>   #include "vid-pll-div.h"
>> +#include "vclk.h"
>>   #include "meson-eeclk.h"
>>   #include "g12a.h"
>>   
>> @@ -3165,7 +3166,7 @@ static struct clk_regmap g12a_vclk2_sel = {
>>   		.ops = &clk_regmap_mux_ops,
>>   		.parent_hws = g12a_vclk_parent_hws,
>>   		.num_parents = ARRAY_SIZE(g12a_vclk_parent_hws),
>> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>>   	},
>>   };
>>   
>> @@ -3193,7 +3194,6 @@ static struct clk_regmap g12a_vclk2_input = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_sel.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>   	},
>>   };
>>   
>> @@ -3215,19 +3215,32 @@ static struct clk_regmap g12a_vclk_div = {
>>   };
>>   
>>   static struct clk_regmap g12a_vclk2_div = {
>> -	.data = &(struct clk_regmap_div_data){
>> -		.offset = HHI_VIID_CLK_DIV,
>> -		.shift = 0,
>> -		.width = 8,
>> +	.data = &(struct meson_vclk_div_data){
>> +		.div = {
>> +			.reg_off = HHI_VIID_CLK_DIV,
>> +			.shift   = 0,
>> +			.width   = 8,
>> +		},
>> +		.enable = {
>> +			.reg_off = HHI_VIID_CLK_DIV,
>> +			.shift   = 16,
>> +			.width   = 1,
>> +		},
>> +		.reset = {
>> +			.reg_off = HHI_VIID_CLK_DIV,
>> +			.shift   = 17,
>> +			.width   = 1,
>> +		},
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>>   	},
>>   	.hw.init = &(struct clk_init_data){
>>   		.name = "vclk2_div",
>> -		.ops = &clk_regmap_divider_ops,
>> +		.ops = &meson_vclk_div_ops,
>>   		.parent_hws = (const struct clk_hw *[]) {
>>   			&g12a_vclk2_input.hw
>>   		},
>>   		.num_parents = 1,
>> -		.flags = CLK_GET_RATE_NOCACHE,
>> +		.flags = CLK_SET_RATE_GATE,
>>   	},
>>   };
>>   
>> @@ -3246,16 +3259,24 @@ static struct clk_regmap g12a_vclk = {
>>   };
>>   
>>   static struct clk_regmap g12a_vclk2 = {
>> -	.data = &(struct clk_regmap_gate_data){
>> -		.offset = HHI_VIID_CLK_CNTL,
>> -		.bit_idx = 19,
>> +	.data = &(struct meson_vclk_gate_data){
>> +		.enable = {
>> +			.reg_off = HHI_VIID_CLK_CNTL,
>> +			.shift   = 19,
>> +			.width   = 1,
>> +		},
>> +		.reset = {
>> +			.reg_off = HHI_VIID_CLK_CNTL,
>> +			.shift   = 15,
>> +			.width   = 1,
>> +		},
>>   	},
>>   	.hw.init = &(struct clk_init_data) {
>>   		.name = "vclk2",
>> -		.ops = &clk_regmap_gate_ops,
>> +		.ops = &meson_vclk_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3339,7 +3360,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3353,7 +3374,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3367,7 +3388,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3381,7 +3402,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3395,7 +3416,7 @@ static struct clk_regmap g12a_vclk2_div12_en = {
>>   		.ops = &clk_regmap_gate_ops,
>>   		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>   		.num_parents = 1,
>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3461,6 +3482,7 @@ static struct clk_fixed_factor g12a_vclk2_div2 = {
>>   			&g12a_vclk2_div2_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3474,6 +3496,7 @@ static struct clk_fixed_factor g12a_vclk2_div4 = {
>>   			&g12a_vclk2_div4_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3487,6 +3510,7 @@ static struct clk_fixed_factor g12a_vclk2_div6 = {
>>   			&g12a_vclk2_div6_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3500,6 +3524,7 @@ static struct clk_fixed_factor g12a_vclk2_div12 = {
>>   			&g12a_vclk2_div12_en.hw
>>   		},
>>   		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> @@ -3561,7 +3586,7 @@ static struct clk_regmap g12a_cts_encl_sel = {
>>   		.ops = &clk_regmap_mux_ops,
>>   		.parent_hws = g12a_cts_parent_hws,
>>   		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
>> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>>   	},
>>   };
>>   
>> @@ -3717,15 +3742,22 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
>>   		.ops = &clk_regmap_mux_ops,
>>   		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
>>   		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
>> -		.flags = CLK_SET_RATE_NO_REPARENT,
>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>   	},
>>   };
>>   
>> +/* Force as bypass by forcing a single /1 table entry, and not rely of boot value */
> 
> The comment here is not entirely accurate.
> 
> The table below will actually force to only use a 1 divider on
> .set_rate(), not on boot, AFAICT.
> 
> The boot value will stay in the register until the first call to set_rate().
> 
> Considering this is quite fragile as it is, It would be nice to prefix
> the updated comment with "FIXME"

Ack

> 
>> +static const struct clk_div_table g12a_mipi_dsi_pxclk_div_table[] = {
>> +	{ .val = 0, .div = 1 },
>> +	{ /* sentinel */ },
>> +};
>> +
>>   static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
>>   	.data = &(struct clk_regmap_div_data){
>>   		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
>>   		.shift = 0,
>>   		.width = 7,
>> +		.table = g12a_mipi_dsi_pxclk_div_table,
>>   	},
>>   	.hw.init = &(struct clk_init_data){
>>   		.name = "mipi_dsi_pxclk_div",
> 
> 


