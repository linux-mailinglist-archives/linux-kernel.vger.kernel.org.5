Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7D76FC46
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjHDIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHDIqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:46:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42C30F4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:46:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso17818795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138774; x=1691743574;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8/2epN71DffLwBWhZlwSr6qgtOgEJN1dllV/1/DX8b4=;
        b=T1rvrGSHsbHhc2NkBJrzGuI/Z2XJzkQP8vMpV2km3yg17tnd2qj4b4KVA8viOkVK4y
         UrqIIamqmT8WZmM9/H8KlAgYdCLWrwqfqyPNMMYfeRAojXhx1+dCLiYL/V/MpNaVNhxn
         PfpxG9VqMHldniAan8t8+DiCTMk3Irn7ygCipIp0vigjzDZn3h/dl+ECBVvUSCPdHtSx
         aXymiTv8WIxC0sW8TSNYy76XQFKlZRUhwpkeIyMzq8o7gBWnKgW8AJxHDRgmb2bjJnok
         d3PymPfj/qHb4w9NdhNc/1XZ5CMZAA6JeA0xl7oKlU38TL1YJfpxrTm1kQvn5NpJQYQ4
         aGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138774; x=1691743574;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/2epN71DffLwBWhZlwSr6qgtOgEJN1dllV/1/DX8b4=;
        b=RBZdnAXUhzDMUpn7dYZy7zQGPl76fGJin6XUSdiGwKE15QSR3ZAZKMWelwR4zSB46I
         UxMJseP1eLkyxCvndNHl9S/336XeU0YyBt39KAilBth+y9vzvQ96ZG96aZKwMFWLbj8l
         wDTaUNan8Lfnb8CQCC3jdwueqa8OAVMJ1uZCZCjUqoZDA+/+5gh8uJNevoudBiKR9WP9
         /OBIY7ky+NEpMx7Oq7E+cuxXLEOeo9XRDvWuccEzYutOVeO2lyqBNwTMgMdfcUbeNNMs
         7loiplQ+oUB9Ho94C8jUguHt7oiXu/dbeYfSQqGioByoO9NpzAtOKF2O2I5sodFX/RLi
         wqLw==
X-Gm-Message-State: AOJu0Yzd/JbMcMIAdZWxlRCLqRbrnjIeu7HuQ4X605BsC5mMHsAFaCd9
        w6jPHJF0OIV/7LxFeiHMhSiBmQ==
X-Google-Smtp-Source: AGHT+IEXfc2HyMKRUwROboiBvMsrvQ2EBr3c0K0nVutboAbfHnMsN4bJm+HSXSoaklbeeraThsaQxA==
X-Received: by 2002:a05:600c:208:b0:3fb:4055:1ddd with SMTP id 8-20020a05600c020800b003fb40551dddmr962143wmi.28.1691138774486;
        Fri, 04 Aug 2023 01:46:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id a25-20020a05600c225900b003fc00892c13sm1807034wmm.35.2023.08.04.01.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:46:13 -0700 (PDT)
Message-ID: <cdc50fd9-fbc8-81b2-18b9-94be60eda375@linaro.org>
Date:   Fri, 4 Aug 2023 10:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 3/9] clk: meson: add vclk driver
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
References: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
 <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-3-762219fc5b28@linaro.org>
 <1j5y5vp88v.fsf@starbuckisacylon.baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <1j5y5vp88v.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 09:33, Jerome Brunet wrote:
> 
> On Thu 03 Aug 2023 at 14:03, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The VCLK and VCLK_DIV clocks have supplementary bits.
>>
>> The VCLK has a "SOFT RESET" bit to toggle after the whole
>> VCLK sub-tree rate has been set, this is implemented in
>> the gate enable callback.
>>
>> The VCLK_DIV clocks as enable and reset bits used to disable
>> and reset the divider, associated with CLK_SET_RATE_GATE it ensures
>> the rate is set while the divider is disabled and in reset mode.
>>
>> The VCLK_DIV enable bit isn't implemented as a gate since it's part
>> of the divider logic and vendor does this exact sequence to ensure
>> the divider is correctly set.
> 
> Unless there is reason, I'd prefer if this driver was using 'struct
> parm', like the rest of amlogic custom clock drivers, for consistency.

Ack

thx,
Neil

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/clk/meson/Kconfig  |   5 ++
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/vclk.c   | 146 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/vclk.h   |  68 +++++++++++++++++++++
>>   4 files changed, 220 insertions(+)
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 135da8f2d0b1..83f629515e96 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -30,6 +30,10 @@ config COMMON_CLK_MESON_VID_PLL_DIV
>>   	tristate
>>   	select COMMON_CLK_MESON_REGMAP
>>   
>> +config COMMON_CLK_MESON_VCLK
>> +	tristate
>> +	select COMMON_CLK_MESON_REGMAP
>> +
>>   config COMMON_CLK_MESON_CLKC_UTILS
>>   	tristate
>>   
>> @@ -140,6 +144,7 @@ config COMMON_CLK_G12A
>>   	select COMMON_CLK_MESON_EE_CLKC
>>   	select COMMON_CLK_MESON_CPU_DYNDIV
>>   	select COMMON_CLK_MESON_VID_PLL_DIV
>> +	select COMMON_CLK_MESON_VCLK
>>   	select MFD_SYSCON
>>   	help
>>   	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index cd961cc4f4db..6efeb8c7bd2a 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
>> +obj-$(CONFIG_COMMON_CLK_MESON_VCLK) += vclk.o
>>   
>>   # Amlogic Clock controllers
>>   
>> diff --git a/drivers/clk/meson/vclk.c b/drivers/clk/meson/vclk.c
>> new file mode 100644
>> index 000000000000..0df84403b17f
>> --- /dev/null
>> +++ b/drivers/clk/meson/vclk.c
>> @@ -0,0 +1,146 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include "vclk.h"
>> +
>> +/* The VCLK gate has a supplementary reset bit to pulse after ungating */
>> +
>> +static int clk_regmap_vclk_enable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
>> +
>> +	regmap_set_bits(clk->map, vclk->offset, BIT(vclk->enable_bit_idx));
>> +
>> +	/* Do a reset pulse */
>> +	regmap_set_bits(clk->map, vclk->offset, BIT(vclk->reset_bit_idx));
>> +	regmap_clear_bits(clk->map, vclk->offset, BIT(vclk->reset_bit_idx));
>> +
>> +	return 0;
>> +}
>> +
>> +static void clk_regmap_vclk_disable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
>> +
>> +	regmap_clear_bits(clk->map, vclk->offset, BIT(vclk->enable_bit_idx));
>> +}
>> +
>> +static int clk_regmap_vclk_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
>> +	unsigned int val;
>> +
>> +	regmap_read(clk->map, vclk->offset, &val);
>> +
>> +	return val & BIT(vclk->enable_bit_idx) ? 1 : 0;
>> +}
>> +
>> +const struct clk_ops clk_regmap_vclk_ops = {
>> +	.enable = clk_regmap_vclk_enable,
>> +	.disable = clk_regmap_vclk_disable,
>> +	.is_enabled = clk_regmap_vclk_is_enabled,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_regmap_vclk_ops);
>> +
>> +/* The VCLK Divider has supplementary reset & enable bits */
>> +
>> +static unsigned long clk_regmap_vclk_div_recalc_rate(struct clk_hw *hw,
>> +						     unsigned long prate)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_read(clk->map, vclk->offset, &val);
>> +	if (ret)
>> +		/* Gives a hint that something is wrong */
>> +		return 0;
>> +
>> +	val >>= vclk->shift;
>> +	val &= clk_div_mask(vclk->width);
>> +
>> +	return divider_recalc_rate(hw, prate, val, vclk->table, vclk->flags,
>> +				   vclk->width);
>> +}
>> +
>> +static int clk_regmap_vclk_div_determine_rate(struct clk_hw *hw,
>> +					      struct clk_rate_request *req)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>> +
>> +	return divider_determine_rate(hw, req, vclk->table, vclk->width,
>> +				      vclk->flags);
>> +}
>> +
>> +static int clk_regmap_vclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
>> +					unsigned long parent_rate)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = divider_get_val(rate, parent_rate, vclk->table, vclk->width,
>> +			      vclk->flags);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	val = (unsigned int)ret << vclk->shift;
>> +	return regmap_update_bits(clk->map, vclk->offset,
>> +				  clk_div_mask(vclk->width) << vclk->shift, val);
>> +};
>> +
>> +static int clk_regmap_vclk_div_enable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>> +
>> +	/* Unreset the divider when ungating */
>> +	regmap_clear_bits(clk->map, vclk->offset, BIT(vclk->reset_bit_idx));
>> +
>> +	return regmap_set_bits(clk->map, vclk->offset, BIT(vclk->enable_bit_idx));
>> +}
>> +
>> +static void clk_regmap_vclk_div_disable(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>> +
>> +	/* Reset the divider when gating */
>> +	regmap_clear_bits(clk->map, vclk->offset, BIT(vclk->enable_bit_idx));
>> +
>> +	regmap_set_bits(clk->map, vclk->offset, BIT(vclk->reset_bit_idx));
>> +}
>> +
>> +static int clk_regmap_vclk_div_is_enabled(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
>> +	unsigned int val;
>> +
>> +	regmap_read(clk->map, vclk->offset, &val);
>> +
>> +	return val & BIT(vclk->enable_bit_idx) ? 1 : 0;
>> +}
>> +
>> +const struct clk_ops clk_regmap_vclk_div_ops = {
>> +	.recalc_rate = clk_regmap_vclk_div_recalc_rate,
>> +	.determine_rate = clk_regmap_vclk_div_determine_rate,
>> +	.set_rate = clk_regmap_vclk_div_set_rate,
>> +	.enable = clk_regmap_vclk_div_enable,
>> +	.disable = clk_regmap_vclk_div_disable,
>> +	.is_enabled = clk_regmap_vclk_div_is_enabled,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_regmap_vclk_div_ops);
>> +
>> +MODULE_DESCRIPTION("Amlogic vclk clock driver");
>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/clk/meson/vclk.h b/drivers/clk/meson/vclk.h
>> new file mode 100644
>> index 000000000000..90786552a7f3
>> --- /dev/null
>> +++ b/drivers/clk/meson/vclk.h
>> @@ -0,0 +1,68 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>> + */
>> +
>> +#ifndef __VCLK_H
>> +#define __VCLK_H
>> +
>> +#include "clk-regmap.h"
>> +
>> +/**
>> + * struct clk_regmap_vclk_data - vclk regmap backed specific data
>> + *
>> + * @offset:		offset of the register controlling gate
>> + * @enable_bit_idx:	single bit controlling vclk enable
>> + * @reset_bit_idx:	single bit controlling vclk reset
>> + * @flags:		hardware-specific flags
>> + *
>> + * Flags:
>> + * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
>> + */
>> +struct clk_regmap_vclk_data {
>> +	unsigned int	offset;
>> +	u8		enable_bit_idx;
>> +	u8		reset_bit_idx;
>> +	u8		flags;
>> +};
>> +
>> +static inline struct clk_regmap_vclk_data *
>> +clk_get_regmap_vclk_data(struct clk_regmap *clk)
>> +{
>> +	return (struct clk_regmap_vclk_data *)clk->data;
>> +}
>> +
>> +extern const struct clk_ops clk_regmap_vclk_ops;
>> +
>> +/**
>> + * struct clk_regmap_vclk_div_data - vclk_div regmap back specific data
>> + *
>> + * @offset:	offset of the register controlling the divider
>> + * @shift:	shift to the divider bit field
>> + * @width:	width of the divider bit field
>> + * @enable_bit_idx:	single bit controlling vclk divider enable
>> + * @reset_bit_idx:	single bit controlling vclk divider reset
>> + * @table:	array of value/divider pairs, last entry should have div = 0
>> + *
>> + * Flags:
>> + * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
>> + */
>> +struct clk_regmap_vclk_div_data {
>> +	unsigned int	offset;
>> +	u8		shift;
>> +	u8		width;
>> +	u8		enable_bit_idx;
>> +	u8		reset_bit_idx;
>> +	const struct clk_div_table      *table;
>> +	u8		flags;
>> +};
>> +
>> +static inline struct clk_regmap_vclk_div_data *
>> +clk_get_regmap_vclk_div_data(struct clk_regmap *clk)
>> +{
>> +	return (struct clk_regmap_vclk_div_data *)clk->data;
>> +}
>> +
>> +extern const struct clk_ops clk_regmap_vclk_div_ops;
>> +
>> +#endif /* __VCLK_H */
> 

