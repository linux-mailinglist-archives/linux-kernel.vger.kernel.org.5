Return-Path: <linux-kernel+bounces-107862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B22E8802AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C32A1F24C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B33111B1;
	Tue, 19 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDAdaKJa"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609F101EB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866809; cv=none; b=XA7Or6Wr65gmEi/MwRhaE6Re2vbQyQ09Aq31avO48GUVf0cGQIVNrfOzFIe6O2CRLSLRqBrbODwrHPcM/djn/BRuFMa9mve+0zDrVSSNlWClcK7awFtToB8IjTvUzp2gvHitQ7nOF5EonKMstdXpefhla5whC36zasGeOCSRkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866809; c=relaxed/simple;
	bh=Bk966/7YvJhcNzWySUwU2Y7SkHjTq80cfm7tt5j4dTg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sLEeOGjq5wbSGlvxTNOEVyeY0I1xIFR0tf58FW1pCJTvJQoc1Wg1fEBV6W7UKQYW9Viblk4ujxokatv3UA2LTF0pEghe5NREAuBAr2EwjPt1GQ7Ra31F+hZLg9RBCdqyl5PfkG1MoM6ueU1A4FiW8V1HWO8QoZ5gKT06PHx8tE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDAdaKJa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so3442578f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710866806; x=1711471606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+68pdTiUjypEc+CyXNmTyy6qJ3QLO2R/oUhIUplT4hs=;
        b=oDAdaKJaCHo/YiDqNnrDwRwcICJG756r7qYVThNfym9SpBUJiVAu9qwyy9jS+082ek
         xGHgPIb9jAmxQcwj25qClqRPx1AcyjtjQ/d7vw29+gV1B1+c3CGFrwT4AQYlcGrfm5SU
         fPtxUW2DgKO9Rh/cCF2DUN1BL0lk7K+7ou1IdHUrAlbz3IXYdGS7DAus81QPJ5/icoGv
         dut3xR9PU0AC6v1RGHaksZlmM2R7BL0a+Yj4G/WGqezXb+yjV3cekge54De5fk7o/yZp
         MSKJkM7ekq5kKhGDh9BYwiPb3GJjr4T3hK4QBEGEVl6qgzhSVFBupDuz1oQ1VwoM/iqh
         fSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866806; x=1711471606;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+68pdTiUjypEc+CyXNmTyy6qJ3QLO2R/oUhIUplT4hs=;
        b=u5gvdCt1GFIVDS9iaHGLe3LGmYtCtxgxPckaT1Ck8NxmI5QF1Cec3c6nbUbotWSm0y
         pnpySrPmcvDcv0JW9Fd+89qDlbbF+e6ekqzgyupVslpPqeHdfm/Sd9dNrbzQ0ilZHE6M
         a3Zml2Z33vYSUeyYNCeRktdI/W8Dvf64d+LWRS6D4RPIuwCx3m1I8uE88r6PK8WzWRYd
         JtNK26V6LRFKPrVszK5jYJobXQq8ApQgXvd8dRdW8atrOC3QbsL4MyXMHa/wKtKIr1rc
         suDH/+zDXAsIQcYuQiEDN4LF2RsYhkmEwFBOhh3/QnzrKBx7bNWVxtKNS0vu8eshI7iP
         Z1lg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Pe+yMHmxi+mDtjmoX5/K17Sc32BkDN2OvvYTn/mOeK6QT+KrO6EhtfdrsLWFiQzuXTF3erXzQMPiYKg+JQhwGGAUxWsPfDpIL25E
X-Gm-Message-State: AOJu0Yw8SAtW+5NY43Cx3TiwVzAgs19bvJWS1WRdGwM86yTQYSF/8XYY
	9xv7TF0f1quPjVAalY2JQPFEuhXr9fJ/Vnt9Bo/8eProctqNDUTS260CtBP3SdQ=
X-Google-Smtp-Source: AGHT+IHTu1oSDWlL+VuhRsgqv1o6IplIZtVQKToCzyFcOwo5C+SJFvUd0M9a4mDLpg1v2GrCu3QdXw==
X-Received: by 2002:adf:e044:0:b0:33e:c974:1291 with SMTP id w4-20020adfe044000000b0033ec9741291mr9790057wrh.30.1710866805728;
        Tue, 19 Mar 2024 09:46:45 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:128f:e9ca:2e29:c91b:3cc4:4dc0? ([2a0d:e487:128f:e9ca:2e29:c91b:3cc4:4dc0])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0033ec8f3ca9bsm12715053wrj.49.2024.03.19.09.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:46:45 -0700 (PDT)
Message-ID: <3141e539-67f9-4a90-abf7-0cc8d95f7396@linaro.org>
Date: Tue, 19 Mar 2024 17:45:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/7] phy: qcom: qmp-pcie: register second optional PHY AUX
 clock
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-3-926d7a4ccd80@linaro.org>
 <CAA8EJpoJ0rUd8aY6xpXyL3Obg66XtOebso_AUUxKmg1CWNykJA@mail.gmail.com>
 <85d67f3f-2b01-44c0-ace3-5e7cb48a9431@linaro.org>
 <090e306c-0bfc-4374-83ed-e883d73a0f0a@linaro.org>
 <CAA8EJpovp1S9MYb3ByeoR7WmjPgUmqicqs_fQo_OoL5_NTNPJw@mail.gmail.com>
 <c799b110-978f-412f-b50e-87a4215a17cf@linaro.org>
 <CAA8EJpp2pVnKh4J0TnGy_s_GB60P58xEW7OtmzReGVTF-1Ax-g@mail.gmail.com>
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
In-Reply-To: <CAA8EJpp2pVnKh4J0TnGy_s_GB60P58xEW7OtmzReGVTF-1Ax-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2024 17:05, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 17:15, <neil.armstrong@linaro.org> wrote:
>>
>> On 19/03/2024 15:46, Dmitry Baryshkov wrote:
>>> On Tue, 19 Mar 2024 at 16:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>> On 19/03/2024 11:59, Neil Armstrong wrote:
>>>>> On 19/03/2024 11:55, Dmitry Baryshkov wrote:
>>>>>> On Tue, 19 Mar 2024 at 12:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>>>
>>>>>>> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
>>>>>>> add the code to register it for PHYs configs that sets a aux_clock_rate.
>>>>>>>
>>>>>>> In order to get the right clock, add qmp_pcie_clk_hw_get() which uses
>>>>>>> the newly introduced QMP_PCIE_PIPE_CLK & QMP_PCIE_PHY_AUX_CLK clock
>>>>>>> IDs and also supports the legacy bindings by returning the PIPE clock.
>>>>>>>
>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>> ---
>>>>>>>     drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 70 ++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 70 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>>>>> index 079b3e306489..2d05226ae200 100644
>>>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>>>>> @@ -22,6 +22,8 @@
>>>>>>>     #include <linux/reset.h>
>>>>>>>     #include <linux/slab.h>
>>>>>>>
>>>>>>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>>>>>>> +
>>>>>>>     #include "phy-qcom-qmp-common.h"
>>>>>>>
>>>>>>>     #include "phy-qcom-qmp.h"
>>>>>>> @@ -2389,6 +2391,9 @@ struct qmp_phy_cfg {
>>>>>>>
>>>>>>>            /* QMP PHY pipe clock interface rate */
>>>>>>>            unsigned long pipe_clock_rate;
>>>>>>> +
>>>>>>> +       /* QMP PHY AUX clock interface rate */
>>>>>>> +       unsigned long aux_clock_rate;
>>>>>>>     };
>>>>>>>
>>>>>>>     struct qmp_pcie {
>>>>>>> @@ -2420,6 +2425,7 @@ struct qmp_pcie {
>>>>>>>            int mode;
>>>>>>>
>>>>>>>            struct clk_fixed_rate pipe_clk_fixed;
>>>>>>> +       struct clk_fixed_rate aux_clk_fixed;
>>>>>>>     };
>>>>>>>
>>>>>>>     static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
>>>>>>> @@ -3681,6 +3687,62 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
>>>>>>>            return devm_clk_hw_register(qmp->dev, &fixed->hw);
>>>>>>>     }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * Register a fixed rate PHY aux clock.
>>>>>>> + *
>>>>>>> + * The <s>_phy_aux_clksrc generated by PHY goes to the GCC that gate
>>>>>>> + * controls it. The <s>_phy_aux_clk coming out of the GCC is requested
>>>>>>> + * by the PHY driver for its operations.
>>>>>>> + * We register the <s>_phy_aux_clksrc here. The gcc driver takes care
>>>>>>> + * of assigning this <s>_phy_aux_clksrc as parent to <s>_phy_aux_clk.
>>>>>>> + * Below picture shows this relationship.
>>>>>>> + *
>>>>>>> + *         +---------------+
>>>>>>> + *         |   PHY block   |<<---------------------------------------------+
>>>>>>> + *         |               |                                               |
>>>>>>> + *         |   +-------+   |                      +-----+                  |
>>>>>>> + *   I/P---^-->|  PLL  |---^--->phy_aux_clksrc--->| GCC |--->phy_aux_clk---+
>>>>>>> + *    clk  |   +-------+   |                      +-----+
>>>>>>> + *         +---------------+
>>>>>>> + */
>>>>>>> +static int phy_aux_clk_register(struct qmp_pcie *qmp, struct device_node *np)
>>>>>>> +{
>>>>>>> +       struct clk_fixed_rate *fixed = &qmp->aux_clk_fixed;
>>>>>>> +       struct clk_init_data init = { };
>>>>>>> +       int ret;
>>>>>>> +
>>>>>>> +       ret = of_property_read_string_index(np, "clock-output-names", 1, &init.name);
>>>>>>> +       if (ret) {
>>>>>>> +               dev_err(qmp->dev, "%pOFn: No clock-output-names index 1\n", np);
>>>>>>> +               return ret;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       init.ops = &clk_fixed_rate_ops;
>>>>>>> +
>>>>>>> +       fixed->fixed_rate = qmp->cfg->aux_clock_rate;
>>>>>>> +       fixed->hw.init = &init;
>>>>>>> +
>>>>>>> +       return devm_clk_hw_register(qmp->dev, &fixed->hw);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static struct clk_hw *qmp_pcie_clk_hw_get(struct of_phandle_args *clkspec, void *data)
>>>>>>> +{
>>>>>>> +       struct qmp_pcie *qmp = data;
>>>>>>> +
>>>>>>> +       /* Support legacy bindings */
>>>>>>> +       if (!clkspec->args_count)
>>>>>>> +               return &qmp->pipe_clk_fixed.hw;
>>>>>>> +
>>>>>>> +       switch (clkspec->args[0]) {
>>>>>>> +       case QMP_PCIE_PIPE_CLK:
>>>>>>> +               return &qmp->pipe_clk_fixed.hw;
>>>>>>> +       case QMP_PCIE_PHY_AUX_CLK:
>>>>>>> +               return &qmp->aux_clk_fixed.hw;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return ERR_PTR(-EINVAL);
>>>>>>> +}
>>>>>>
>>>>>> Can we use of_clk_hw_onecell_get() instead? I think it even should be
>>>>>> possible to use onecell for both cases, it will look at the first arg,
>>>>>> which will be 0 in case of #clock-cells equal to 0.
>>>>>
>>>>> Let me investigate if it's possible
>>>>
>>>> Ok, it would work but it would require building a clk_hw_onecell_data a runtime,
>>>> while we could simply provide this qmp_pcie_clk_hw_get() and avoid runtime 2 allocations.
>>>>
>>>> I'm not sure it's worth it.
>>>
>>> Single allocation (or even 0 allocations if you embed it into struct
>>> qmp_pcie) for the sake of using standard helpers.
>>
>> And I just recall I tried the same for Amlogic clocks, but the clk_hw_onecell_data hws
>> field is a flexible array member you can't set at runtime, if you try you'll get:
>> drivers/phy/qualcomm/phy-qcom-qmp-pcie.c:3753:38: error: invalid use of flexible array member
>>    3753 |                 qmp->clk_hw_data.hws = qmp->clk_hws;
> 
> Yes, so it's either
> devm_kzalloc(dev, struct_size(data, hws, 2), GFP_KERNEL);
> or
> struct qmp_pcie {
> ...
>    struct {
>      struct clk_hw_onecell_data clk_data;
>      struct clk_hw clocks[2];
>    };
> };

I won't go down this path because of that mess and using of_clk_hw_onecell_get() would need
to still add a custom getter before calling of_clk_hw_onecell_get() to handle the
#clock-cells=0 legacy case.

Neil

> 
>>
>> Neil
>>
>>>
>>>
>>>
>>
> 
> 


