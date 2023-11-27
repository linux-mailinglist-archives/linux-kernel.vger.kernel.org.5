Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF87F9BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjK0I2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjK0I2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:28:08 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B34124
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:28:12 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so50739651fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073691; x=1701678491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNor6MhI2r19lHXmK9Cl2a3n8UllkpTKoe82vmPJ1qM=;
        b=lZDdLyYyjHFpGRTKrDeiVLrejU0WCn+ahZi5KsNWtkZXhXCc8UYPdTohiwmtM82S6n
         DHMvgqojRflNnXF3z/MgUQwdtFOmPtvApu7vlGCEE1XUWeF1ozK2pYWDSFrM0Nnhh0Rt
         Abr2CSOoslcixovLPDLZppYwKZF9PB5llJ45+YOdg+fx9EE1tWeLXM4bLzCdM9SZYnw2
         VyTSZBX7Ah09JpD+qzou22k6BpjXGuFMg+1K/+6Y0quqgOWskh3YaGcQ/zLRCNGPidFF
         9Rar5igYaV3X/Wmx6ox8R2BN3IJFwh0JI/8eL549i3sOPFRK14iTBdqenJ1YBsPvCHTQ
         In2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073691; x=1701678491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNor6MhI2r19lHXmK9Cl2a3n8UllkpTKoe82vmPJ1qM=;
        b=HFAq8bdXmTbpklmLtJg6hS+cl6jBpxfy0VHbmRRVWuiWe7GecggHtuOY6zYwnzoiDh
         W299d0yH4/ltSHu5b78eVp/VQpO84UoNyWQ1eBD+zI6iLWYzKDSco/Ntve1BvEYfxZuG
         cAzhUXGXh7ufB9vF24ov8sAaOKKNxoe64zuYFKYX1OOFWFIJ8FQNm+7khn34A776xxV8
         oHdqrTrWOO1+dZjZXF6URwO6PLjmIE8E9Oz6zFAU654gNqUEeQPAQfALeIl1eBq4WuBl
         hF1Y+TGtEj4QbCFEAKrUmLmnHs4LrXwc9yHRtMP4toGYvl50b0A0Q3DDwZjD/sSkCBht
         hqNA==
X-Gm-Message-State: AOJu0Yxl0Jem6eyUy1rVvy0pXD7y4MQH2mancwxFL8lMTLbVIcD9DFsQ
        QPa5XvwgwXQsgIr5iBdYVYUccw==
X-Google-Smtp-Source: AGHT+IG6EbK/MN8HNqrYs2yFa5FCFSvRzgJm60fItddzlsWBGSlDfDY3GslYg/l8xy3DABG43nnzpg==
X-Received: by 2002:a2e:934f:0:b0:2c5:1e70:7d30 with SMTP id m15-20020a2e934f000000b002c51e707d30mr7229826ljh.30.1701073690709;
        Mon, 27 Nov 2023 00:28:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b004030e8ff964sm13760772wmb.34.2023.11.27.00.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:28:10 -0800 (PST)
Message-ID: <41a1246e-c885-460a-8208-16844e95e1ae@linaro.org>
Date:   Mon, 27 Nov 2023 09:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v9 08/12] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-8-95256ed139e6@linaro.org>
 <1jbkbjdxk8.fsf@starbuckisacylon.baylibre.com>
 <b23ddc3b-d995-4cd6-91f2-3efa59d345a5@linaro.org>
 <1j34wvdtux.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1j34wvdtux.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/11/2023 16:32, Jerome Brunet wrote:
> 
> On Fri 24 Nov 2023 at 16:15, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 24/11/2023 15:12, Jerome Brunet wrote:
>>> On Fri 24 Nov 2023 at 09:41, Neil Armstrong <neil.armstrong@linaro.org>
>>> wrote:
>>>
>>>> In order to setup the DSI clock, let's make the unused VCLK2 clock path
>>>> configuration via CCF.
>>>>
>>>> The nocache option is removed from following clocks:
>>>> - vclk2_sel
>>>> - vclk2_input
>>>> - vclk2_div
>>>> - vclk2
>>>> - vclk_div1
>>>> - vclk2_div2_en
>>>> - vclk2_div4_en
>>>> - vclk2_div6_en
>>>> - vclk2_div12_en
>>>> - vclk2_div2
>>>> - vclk2_div4
>>>> - vclk2_div6
>>>> - vclk2_div12
>>>> - cts_encl_sel
>>>>
>>>> vclk2 and vclk2_div uses the newly introduced vclk regmap driver
>>>> to handle the enable and reset bits.
>>>>
>>>> In order to set a rate on cts_encl via the vclk2 clock path,
>>>> the NO_REPARENT flag is set on cts_encl_sel & vclk2_sel in order
>>>> to keep CCF from selection a parent.
>>>> The parents of cts_encl_sel & vclk2_sel are expected to be defined
>>>> in DT.
>>>>
>>>> The following clock scheme is to be used for DSI:
>>>>
>>>> xtal
>>>> \_ gp0_pll_dco
>>>>      \_ gp0_pll
>>>>         |- vclk2_sel
>>>>         |  \_ vclk2_input
>>>>         |     \_ vclk2_div
>>>>         |        \_ vclk2
>>>>         |           \_ vclk2_div1
>>>>         |              \_ cts_encl_sel
>>>>         |                 \_ cts_encl	-> to VPU LCD Encoder
>>>>         |- mipi_dsi_pxclk_sel
>>>>         \_ mipi_dsi_pxclk_div
>>>>            \_ mipi_dsi_pxclk		-> to DSI controller
>>>>
>>>> The mipi_dsi_pxclk_div is set as RO in order to use the same GP0
>>>> for mipi_dsi_pxclk and vclk2_input.
>>> Could you explain a bit more this part of about the RO ops ?
>>> Maybe I'm missing something.
>>> You would be relying on the reset being always the way it. It is
>>> probable but not safe.
>>> A way to deal with the shared GP0 would be to:
>>> * cut rate propagation at mipi_dsi_pxclk_sel (already done) and
>>>     (vclk2_sel - TBD) ...
>>> * Set GP0 base rate through assigned-clock-rate (which you already in
>>>     patch 11)
>>> With this, I'm not sure anything needs to be RO for the rates to be set
>>> properly for each subtree.
>>> Also, with the subtree above and your example in patch 11, it looks odd
>>> that
>>> PXCLK is manually set through DT while ENCL is not. Both are input of
>>> dsi driver.
>>
>> So the deal is about dynamic setup of clocks for DSI bridges, not really
>> for panels where we can probably know in advance the clock setup.
>>
>> In this particular case, we need to keep a ratio between the vclk and the
>> DSI bitclk, the DSI bitclk is taken from mipi_dsi_pxclk and vclk is derived
>> from gp0 via vclk2.
>>
>> If we set the bitclk rate via mipi_dsi_pxclk, CCF will try to use mipi_dsi_pxclk_div
>> to achieve the rate,
> 
> If you have CLK_RATE_PARENT on mipi_dsi_pxclk_sel, I'm not surprised it
> does that, but you don't :/ I'm quite surprised it would do that, or
> even could.

Hmm, I need to recheck the clock tree again... seems I got lost in the
different revisions...

> 
>  From your example setting 96Mhz on both gp0 and mipi_dsi_pxclk, since
> you've proposed RO-OPS, I suppose the divider is assumed to be 1 and
> stay like that forever.
> 
> With rate propagation disabled mipi_dsi_pxclk_sel and GP0 is 96Mhz,
> CCF would have no choice but picking 1 as divider, so I don't understand
> how CCF would pick anything else and how RO-OPS help
> 
>> and it does it everytime I tried, breaking the vclk/bitclk ratio,
>> and we have no way to know the gp0 rate in this case.
> 
> If you really want to ensure the divider value is always 1, why not use a
> divider table allowing only 1 ? Adding a comment in the g12 clock driver
> would nice because this not obvious. It would be safer than relying on
> the reset value.

Indeed, will switch to that

> 
>>
>> I suspect mipi_dsi_pxclk_div was added to achieve fractional vclk/bitclk ratios,
>> since it doesn't exist on AXG. Not sure we would ever need it... and none
>> of the other upstream DSI drivers supports such setups.
>>
>> The main reasons I set only mipi_dsi_pxclk in DT is because :
>> 1) the DSI controller requires a bitclk to respond, pclk is not enough
>> 2) GP0 is disabled with an invalid config at cold boot, thus we cannot
>> rely on a default/safe rate on an initial prepare_enable().
>> This permits setting initial valid state for the DSI controller, while
>> the actual bitclk and vclk are calculated dynamically with panel/bridge
>> runtime parameters.
> 
> Nothing against setting rate in DT when it is static. Setting it then
> overriding it is not easy to follow.

Yup, would be simpler to only have parenting set in DT, since it must
stay static, I'm fine trying to move rate setup to code.

> 
> To work around GP0 not being set, assuming you want to keep rate
> propagation as it is, you could call clk_set_rate() on cts_encl (possibly w/o
> enabling it) to force a setup on gp0 then clk_prepare_enable() on
> pxclk. You'd get a your safe rate on GP0 and the clock you need on pxclk.
> 
> It is a bit hackish. Might be better to claim gp0 in your driver to
> manage it directly, cutting rate propagation above it to control each
> branch of the subtree as you need. It seems you need to have control over
> that anyway and it would be clear GP0 is expected to belong to DSI.

Controlling the PLL from the DSI controller seems violating too much layers,
DSI controller driver is not feed directly by the PLL so it's a non-sense
regarding DT properties.

Setting a safe clock from the DSI controller probe is an idea, but again I
don't know which value I should use...

I'll review the clk parenting flags and try to hack something.

Thanks,
Neil


> 
>>
>> For the record, the samsung-dsim used fixed rate set from DT, and they moved
>> from that in order to support more panel and bridges.
>>
>> But they're quite lucky because usually the DSI PLL is included in the PHY,
>> this makes the Amlogic design quite unusual (like most multimedia stuf...).
>>
>> Neil
>>
>>>
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/clk/meson/g12a.c | 68 +++++++++++++++++++++++++++++++++---------------
>>>>    1 file changed, 47 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>>>> index cadd824336ad..fb3d9196a1fd 100644
>>>> --- a/drivers/clk/meson/g12a.c
>>>> +++ b/drivers/clk/meson/g12a.c
>>>> @@ -22,6 +22,7 @@
>>>>    #include "clk-regmap.h"
>>>>    #include "clk-cpu-dyndiv.h"
>>>>    #include "vid-pll-div.h"
>>>> +#include "vclk.h"
>>>>    #include "meson-eeclk.h"
>>>>    #include "g12a.h"
>>>>    @@ -3165,7 +3166,7 @@ static struct clk_regmap g12a_vclk2_sel = {
>>>>    		.ops = &clk_regmap_mux_ops,
>>>>    		.parent_hws = g12a_vclk_parent_hws,
>>>>    		.num_parents = ARRAY_SIZE(g12a_vclk_parent_hws),
>>>> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>>> No sure CLK_SET_RATE_PARENT is wise here.
>>> What you manually set in DT for the GP0, is likely to change because of
>>> this, isn't it ?
>>>
>>>>    	},
>>>>    };
>>>>    @@ -3193,7 +3194,7 @@ static struct clk_regmap g12a_vclk2_input = {
>>>>    		.ops = &clk_regmap_gate_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_sel.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3215,19 +3216,32 @@ static struct clk_regmap g12a_vclk_div = {
>>>>    };
>>>>      static struct clk_regmap g12a_vclk2_div = {
>>>> -	.data = &(struct clk_regmap_div_data){
>>>> -		.offset = HHI_VIID_CLK_DIV,
>>>> -		.shift = 0,
>>>> -		.width = 8,
>>>> +	.data = &(struct clk_regmap_vclk_div_data){
>>>> +		.div = {
>>>> +			.reg_off = HHI_VIID_CLK_DIV,
>>>> +			.shift   = 0,
>>>> +			.width   = 8,
>>>> +		},
>>>> +		.enable = {
>>>> +			.reg_off = HHI_VIID_CLK_DIV,
>>>> +			.shift   = 16,
>>>> +			.width   = 1,
>>>> +		},
>>>> +		.reset = {
>>>> +			.reg_off = HHI_VIID_CLK_DIV,
>>>> +			.shift   = 17,
>>>> +			.width   = 1,
>>>> +		},
>>>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>>>>    	},
>>>>    	.hw.init = &(struct clk_init_data){
>>>>    		.name = "vclk2_div",
>>>> -		.ops = &clk_regmap_divider_ops,
>>>> +		.ops = &clk_regmap_vclk_div_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) {
>>>>    			&g12a_vclk2_input.hw
>>>>    		},
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_GET_RATE_NOCACHE,
>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>>>>    	},
>>>>    };
>>>>    @@ -3246,16 +3260,24 @@ static struct clk_regmap g12a_vclk = {
>>>>    };
>>>>      static struct clk_regmap g12a_vclk2 = {
>>>> -	.data = &(struct clk_regmap_gate_data){
>>>> -		.offset = HHI_VIID_CLK_CNTL,
>>>> -		.bit_idx = 19,
>>>> +	.data = &(struct clk_regmap_vclk_data){
>>>> +		.enable = {
>>>> +			.reg_off = HHI_VIID_CLK_CNTL,
>>>> +			.shift   = 19,
>>>> +			.width   = 1,
>>>> +		},
>>>> +		.reset = {
>>>> +			.reg_off = HHI_VIID_CLK_CNTL,
>>>> +			.shift   = 15,
>>>> +			.width   = 1,
>>>> +		},
>>>>    	},
>>>>    	.hw.init = &(struct clk_init_data) {
>>>>    		.name = "vclk2",
>>>> -		.ops = &clk_regmap_gate_ops,
>>>> +		.ops = &clk_regmap_vclk_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>>>>    	},
>>>>    };
>>>>    @@ -3339,7 +3361,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
>>>>    		.ops = &clk_regmap_gate_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3353,7 +3375,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
>>>>    		.ops = &clk_regmap_gate_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3367,7 +3389,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
>>>>    		.ops = &clk_regmap_gate_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3381,7 +3403,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
>>>>    		.ops = &clk_regmap_gate_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3395,7 +3417,7 @@ static struct clk_regmap g12a_vclk2_div12_en = {
>>>>    		.ops = &clk_regmap_gate_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>>>>    		.num_parents = 1,
>>>> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3461,6 +3483,7 @@ static struct clk_fixed_factor g12a_vclk2_div2 =
>>>> {
>>>>    			&g12a_vclk2_div2_en.hw
>>>>    		},
>>>>    		.num_parents = 1,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3474,6 +3497,7 @@ static struct clk_fixed_factor g12a_vclk2_div4 =
>>>> {
>>>>    			&g12a_vclk2_div4_en.hw
>>>>    		},
>>>>    		.num_parents = 1,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3487,6 +3511,7 @@ static struct clk_fixed_factor g12a_vclk2_div6 =
>>>> {
>>>>    			&g12a_vclk2_div6_en.hw
>>>>    		},
>>>>    		.num_parents = 1,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3500,6 +3525,7 @@ static struct clk_fixed_factor g12a_vclk2_div12
>>>> = {
>>>>    			&g12a_vclk2_div12_en.hw
>>>>    		},
>>>>    		.num_parents = 1,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3561,7 +3587,7 @@ static struct clk_regmap g12a_cts_encl_sel = {
>>>>    		.ops = &clk_regmap_mux_ops,
>>>>    		.parent_hws = g12a_cts_parent_hws,
>>>>    		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
>>>> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3717,7 +3743,7 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_sel
>>>> = {
>>>>    		.ops = &clk_regmap_mux_ops,
>>>>    		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
>>>>    		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
>>>> -		.flags = CLK_SET_RATE_NO_REPARENT,
>>>> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>>>>    	},
>>>>    };
>>>>    @@ -3729,7 +3755,7 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_div
>>>> = {
>>>>    	},
>>>>    	.hw.init = &(struct clk_init_data){
>>>>    		.name = "mipi_dsi_pxclk_div",
>>>> -		.ops = &clk_regmap_divider_ops,
>>>> +		.ops = &clk_regmap_divider_ro_ops,
>>>>    		.parent_hws = (const struct clk_hw *[]) {
>>>>    			&g12a_mipi_dsi_pxclk_sel.hw
>>>>    		},
>>>
> 

