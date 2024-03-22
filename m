Return-Path: <linux-kernel+bounces-111320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E224886AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B231F218EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE03D0D9;
	Fri, 22 Mar 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiVvjJoG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1A224F2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104314; cv=none; b=qMCedZ8HAN9jpndY7omSm93yprB8oitBaPxwGuFHNdB/eEqr0R6mCxuwrjO0SXPSRTvPpUlS5FoqYv02/I2nYRh0a63iIomGxAnI+nmRxF9JLJ9UKcdStKS7tcjTSXKFZOpI+XuSQ/zLzDBTaP+Rg9vNq75Y+I/YvW29ZwcUvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104314; c=relaxed/simple;
	bh=jWRuh7EGPZi+az7Aq33aapOL1INFIF3xUm8yZfIfKMU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jwj3mx/5og+bBrzXEJoXcZLYp7evl/8MtQR11JZh2aLkflWcpxTeWbZrbyhNWjH+M1ynUl95iJ+cen7gAYI8olOjHZz054SH5HEoGXkGghmeCtZGXB4vJgxiXyrxY1Vj5pLmIa2C1o5GGpVMkFCc+rA/vzdKnN1B7ewHBiTRrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiVvjJoG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1021915f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711104310; x=1711709110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ijz4cnwmta4DwRjOoVv/yS9+lUjTkF7NKjIpyzpOrv4=;
        b=aiVvjJoG80jSLyFxRYRywfwVzM2t3cEK6wFW+rDlM7+Kb8C25AtGPLDwfBaEgXQ2KL
         Te7NM0ap/2sD4j9y3TiEuCvF1luJuEdWqYK0Jk4igM2//0uxmcdLQLVRSo/X+I/eDaSs
         rpYue8vOhFCbn7wlKcrTcES3gD8JzLHAwLEgGiAiCsWY1fz+YE7jGQakTcua6QaxwOyC
         Vlogzmrv2+x4gHOl4VspPwGL/VTD0Z8W5WHonXDE2Ig+rDOvYUYy5tHT6Y3CLFzctct7
         IXmgzNSr7mT2cSlKePOR1YvAEQICy08BqoqzCTnORko+nBOPRfcgvmF1zBoNl32NpPxR
         gulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104310; x=1711709110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ijz4cnwmta4DwRjOoVv/yS9+lUjTkF7NKjIpyzpOrv4=;
        b=YRfuzaFfbW5F8DH80J78kHIUvHw6ZeyJc5bEG8ZY0kQMVVJ8FVZ/pWNf2/Zfbkl8s0
         RpzmYAnbuC93OCls9kvNd7R89OkY1JdBP8BHyRiTdE/iWjSFlBUPOcHbNUp661UpZSt0
         +Go5FDZDpbVdztzn+axWQ28HF6IV+S9qXfUu8egmzMxqFTkKZj0oiQkx45UjJHJMtGay
         lTEZxVPP4grR0yADLzCtgM2dMF3Y98WfcwLpHIYQHbX1PMukDlKFGlVFYfYKBetZxJyw
         +S8lD0Y4cJm5uEgdaaZxOlkR+WnnaaA9MLhGX6UlDIHeMapXSirYwHFWsIFU1Vm9GQtd
         FwnA==
X-Forwarded-Encrypted: i=1; AJvYcCWIAHaOHYTeGDdL78OIFl11e1ox+6T5+8U2HkpJM0nRS8Th155BowD7dbzmNel5wM4VyP/CUqfNwm2xp+t/DGOjF0lTBksm8HvrHl0S
X-Gm-Message-State: AOJu0YwZPUL8Mcy1n60mYbLSbexd6v+DBGayNhAEqC1PPF1ajkU3guzg
	LwXyPZXnNnOhCNpTYGv/vWamuRtWN5UJqrpc1UbpsOWWmDfRg7lrJhvx7sNvD5qJjENGgnY72Vo
	r8+Y=
X-Google-Smtp-Source: AGHT+IE0h2NuaEVe60IzMpflYy6JouB/v/PcDVSKl0vyEQEKhI77w54WnPoVuNyW77f1ZSy4VjO1Wg==
X-Received: by 2002:a5d:69d0:0:b0:33e:7f51:c2f9 with SMTP id s16-20020a5d69d0000000b0033e7f51c2f9mr1268500wrw.49.1711104309609;
        Fri, 22 Mar 2024 03:45:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7? ([2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7])
        by smtp.gmail.com with ESMTPSA id j1-20020adff001000000b0033e7e9c8657sm1778124wro.45.2024.03.22.03.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:45:09 -0700 (PDT)
Message-ID: <1dc187c1-2005-486f-a9dd-6648cf52ab70@linaro.org>
Date: Fri, 22 Mar 2024 11:45:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/7] phy: qcom: qmp-pcie: register second optional PHY
 AUX clock
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
 <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-3-3ec0a966d52f@linaro.org>
 <CAA8EJpoJWKZcZu3SY2P9dpYQ_KXkimRXNhAKfaOreCGZ1muYqw@mail.gmail.com>
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
In-Reply-To: <CAA8EJpoJWKZcZu3SY2P9dpYQ_KXkimRXNhAKfaOreCGZ1muYqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2024 11:41, Dmitry Baryshkov wrote:
> On Fri, 22 Mar 2024 at 11:43, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
>> add the code to register it for PHYs configs that sets a aux_clock_rate.
>>
>> In order to get the right clock, add qmp_pcie_clk_hw_get() which uses
>> the newly introduced QMP_PCIE_PIPE_CLK & QMP_PCIE_PHY_AUX_CLK clock
>> IDs and also supports the legacy bindings by returning the PIPE clock
>> when #clock-cells=0.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Small question below.
> 
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 78 ++++++++++++++++++++++++++++++--
>>   1 file changed, 75 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index e8da2e9146dc..6c9a95e62429 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -22,6 +22,8 @@
>>   #include <linux/reset.h>
>>   #include <linux/slab.h>
>>
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>> +
>>   #include "phy-qcom-qmp-common.h"
>>
>>   #include "phy-qcom-qmp.h"
>> @@ -2389,6 +2391,9 @@ struct qmp_phy_cfg {
>>
>>          /* QMP PHY pipe clock interface rate */
>>          unsigned long pipe_clock_rate;
>> +
>> +       /* QMP PHY AUX clock interface rate */
>> +       unsigned long aux_clock_rate;
>>   };
>>
>>   struct qmp_pcie {
>> @@ -2420,6 +2425,7 @@ struct qmp_pcie {
>>          int mode;
>>
>>          struct clk_fixed_rate pipe_clk_fixed;
>> +       struct clk_fixed_rate aux_clk_fixed;
>>   };
>>
>>   static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
>> @@ -3686,6 +3692,62 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
>>          return devm_clk_hw_register(qmp->dev, &fixed->hw);
>>   }
>>
>> +/*
>> + * Register a fixed rate PHY aux clock.
>> + *
>> + * The <s>_phy_aux_clksrc generated by PHY goes to the GCC that gate
>> + * controls it. The <s>_phy_aux_clk coming out of the GCC is requested
>> + * by the PHY driver for its operations.
>> + * We register the <s>_phy_aux_clksrc here. The gcc driver takes care
>> + * of assigning this <s>_phy_aux_clksrc as parent to <s>_phy_aux_clk.
>> + * Below picture shows this relationship.
>> + *
>> + *         +---------------+
>> + *         |   PHY block   |<<---------------------------------------------+
>> + *         |               |                                               |
>> + *         |   +-------+   |                      +-----+                  |
>> + *   I/P---^-->|  PLL  |---^--->phy_aux_clksrc--->| GCC |--->phy_aux_clk---+
>> + *    clk  |   +-------+   |                      +-----+
>> + *         +---------------+
>> + */
>> +static int phy_aux_clk_register(struct qmp_pcie *qmp, struct device_node *np)
>> +{
>> +       struct clk_fixed_rate *fixed = &qmp->aux_clk_fixed;
>> +       struct clk_init_data init = { };
>> +       int ret;
>> +
>> +       ret = of_property_read_string_index(np, "clock-output-names", 1, &init.name);
>> +       if (ret) {
>> +               dev_err(qmp->dev, "%pOFn: No clock-output-names index 1\n", np);
>> +               return ret;
>> +       }
>> +
>> +       init.ops = &clk_fixed_rate_ops;
>> +
>> +       fixed->fixed_rate = qmp->cfg->aux_clock_rate;
>> +       fixed->hw.init = &init;
>> +
>> +       return devm_clk_hw_register(qmp->dev, &fixed->hw);
>> +}
>> +
>> +static struct clk_hw *qmp_pcie_clk_hw_get(struct of_phandle_args *clkspec, void *data)
>> +{
>> +       struct qmp_pcie *qmp = data;
>> +
>> +       /* Support legacy bindings */
>> +       if (!clkspec->args_count)
>> +               return &qmp->pipe_clk_fixed.hw;
>> +
>> +       switch (clkspec->args[0]) {
>> +       case QMP_PCIE_PIPE_CLK:
>> +               return &qmp->pipe_clk_fixed.hw;
>> +       case QMP_PCIE_PHY_AUX_CLK:
>> +               return &qmp->aux_clk_fixed.hw;
> 
> Does the absence of the default case trigger a warning if compiled with W=1?

Nop it doesn't with GCC arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-linux-gnu + W=1 and with smatch and C=1

Neil

> 
>> +       }
>> +
>> +       return ERR_PTR(-EINVAL);
>> +}
>> +
>>   static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np)
>>   {
>>          int ret;
>> @@ -3694,9 +3756,19 @@ static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np
>>          if (ret)
>>                  return ret;
>>
>> -       ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &qmp->pipe_clk_fixed.hw);
>> -       if (ret)
>> -               return ret;
>> +       if (qmp->cfg->aux_clock_rate) {
>> +               ret = phy_aux_clk_register(qmp, np);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = of_clk_add_hw_provider(np, qmp_pcie_clk_hw_get, qmp);
>> +               if (ret)
>> +                       return ret;
>> +       } else {
>> +               ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &qmp->pipe_clk_fixed.hw);
>> +               if (ret)
>> +                       return ret;
>> +       }
>>
>>          /*
>>           * Roll a devm action because the clock provider is the child node, but
>>
>> --
>> 2.34.1
>>
>>
> 
> 


