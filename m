Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF978C0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjH2IxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjH2Iww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:52:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE7B3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:52:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso34721865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693299168; x=1693903968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNhXpl+qbWZP0Q/ZEwXC9Lk1VYQguD8bp7eaIBk3ZWM=;
        b=dDJMKxGIA6s+Y487kJARRUpof0SSlz/vdN7ed+ET/Jx6zp/2/UTfc1LonRYICRjQX3
         SMDN+DdrFwIGebl192zLBo8+5V8kzo4q/SohxA3H82karB8MRaIQIrUkQCKL/9lZGy6O
         Frr95BA/2R2EALQxag2h1fXfc56hT/QhkEqiualEQY361agAFByqm/leHF+gDIbj6ihR
         WFjyPnb/urYUutL/PJ4AfxzJQ1jQdHo3WKgB1E0h7TzBUyhZlGcQnAYMJ5oQLnFPxhbQ
         mOxKJzbxV7P3SlxrtwgOFOe/tVCIgzjjV9GEiWRD3rXm6lqghAPL80OkGP4fM5hHacAP
         HuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693299168; x=1693903968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fNhXpl+qbWZP0Q/ZEwXC9Lk1VYQguD8bp7eaIBk3ZWM=;
        b=i/dF3qhBJGNwYlrK1pk0aZTc8NwPKMKg0ZYn9bm8A7iWeJudjEJ7hq/JM+nsLfbEhj
         +da0KgWtX7mo+jTo0xmqkAee1E+sEfdZZeH531NSDZGh9EonnvSoEqTjmMohm0w9SHDC
         Qjl5Ex3mds1+erINw260fkjGvyjtuKymjZxJOodg0DjLivet37yMaMMRFBHU7saseobK
         5ZPNw7FZGbNkoguowQYBBndw7nTbTlS52A9LwvG6DU3qqMYkQgBw5khyrF77pERiw9A5
         SC42/W/bIJjhuFpwhYRMOZ5vdybbgbShcPhlv8Xs+R/vFAtLM0JxoGhq49DwVl/ODLSQ
         Dwhw==
X-Gm-Message-State: AOJu0YyX+qmmq63D9aahEyUwNGT1nIra+VvBQAqbgOKIryKbq1oZhAUU
        LvvY3jtXJi0uY3/f0cNi5d4eWw==
X-Google-Smtp-Source: AGHT+IF8d+MI1gy+ust6Fw4OQMB7Sy46mkGSP+ZU3ErjIMBdGVrq9/9jbuUh1jY8Ww7o8v9H+nW8XA==
X-Received: by 2002:a1c:7508:0:b0:3fe:dc99:56ea with SMTP id o8-20020a1c7508000000b003fedc9956eamr21241041wmc.19.1693299167575;
        Tue, 29 Aug 2023 01:52:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8fd:3f8e:51f:e4f9? ([2a01:e0a:982:cbb0:c8fd:3f8e:51f:e4f9])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0acc00b003fee6f027c7sm16312441wmr.19.2023.08.29.01.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 01:52:47 -0700 (PDT)
Message-ID: <4fa3380a-6751-475f-9ac8-4fda78508766@linaro.org>
Date:   Tue, 29 Aug 2023 10:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] clk: qcom: rpmh: Add RPMH clocks support for SM4450
To:     Ajit Pandey <quic_ajipan@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824173410.550126-1-quic_ajipan@quicinc.com>
 <20230824173410.550126-3-quic_ajipan@quicinc.com>
 <71d1d748-133a-470b-986c-ece79f743aa4@linaro.org>
 <8d53a098-bf0d-1b40-45c0-264a42d6e72d@quicinc.com>
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
Organization: Linaro Developer Services
In-Reply-To: <8d53a098-bf0d-1b40-45c0-264a42d6e72d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 07:51, Ajit Pandey wrote:
> 
> 
> On 8/25/2023 7:31 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 24/08/2023 19:34, Ajit Pandey wrote:
>>> Add support for RPMH clocks for SM4450 platform.
>>>
>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/clk-rpmh.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>>> index 4c5b552b47b6..5d853fd43294 100644
>>> --- a/drivers/clk/qcom/clk-rpmh.c
>>> +++ b/drivers/clk/qcom/clk-rpmh.c
>>> @@ -350,6 +350,7 @@ DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2, "lnbclka3", 2);
>>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a4, "lnbclka1", 4);
>>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a4, "lnbclka2", 4);
>>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a4, "lnbclka3", 4);
>>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _g4, "lnbclkg2", 4);
>>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _g4, "lnbclkg3", 4);
>>> @@ -717,6 +718,25 @@ static const struct clk_rpmh_desc clk_rpmh_sdx75 = {
>>>       .num_clks = ARRAY_SIZE(sdx75_rpmh_clocks),
>>>   };
>>> +static struct clk_hw *sm4450_rpmh_clocks[] = {
>>> +    [RPMH_CXO_CLK]        = &clk_rpmh_bi_tcxo_div4.hw,
>>> +    [RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
>>
>> Are you sure about div4 here ?
>>
>> Kailua uses div2 because the CXO input gets used divided by 2
>> by PHYs and divided by 4 for GCC/DISPCC/...
>>
>> This is why we introduced a div2 clock in DT used to feed GCC/DISPCC/...
>>
>> Neil
> 
> Yes div4 is the correct divider only for sm4450 as CXO input get directly divided by 4 only. This is someting similiar to sm8450 and there is no in between div2 divider like Kailua.

Ack, thx for checking !

Neil

> 
>>
>>> +    [RPMH_LN_BB_CLK2]    = &clk_rpmh_ln_bb_clk2_a4.hw,
>>> +    [RPMH_LN_BB_CLK2_A]    = &clk_rpmh_ln_bb_clk2_a4_ao.hw,
>>> +    [RPMH_LN_BB_CLK3]       = &clk_rpmh_ln_bb_clk3_a4.hw,
>>> +    [RPMH_LN_BB_CLK3_A]     = &clk_rpmh_ln_bb_clk3_a4_ao.hw,
>>> +    [RPMH_RF_CLK1]        = &clk_rpmh_rf_clk1_a.hw,
>>> +    [RPMH_RF_CLK1_A]    = &clk_rpmh_rf_clk1_a_ao.hw,
>>> +    [RPMH_RF_CLK5]        = &clk_rpmh_rf_clk5_a.hw,
>>> +    [RPMH_RF_CLK5_A]    = &clk_rpmh_rf_clk5_a_ao.hw,
>>> +    [RPMH_IPA_CLK]        = &clk_rpmh_ipa.hw,
>>> +};
>>> +
>>> +static const struct clk_rpmh_desc clk_rpmh_sm4450 = {
>>> +    .clks = sm4450_rpmh_clocks,
>>> +    .num_clks = ARRAY_SIZE(sm4450_rpmh_clocks),
>>> +};
>>> +
>>>   static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>>>                        void *data)
>>>   {
>>> @@ -810,6 +830,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>>>       { .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
>>>       { .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
>>>       { .compatible = "qcom,sdx75-rpmh-clk",  .data = &clk_rpmh_sdx75},
>>> +    { .compatible = "qcom,sm4450-rpmh-clk", .data = &clk_rpmh_sm4450},
>>>       { .compatible = "qcom,sm6350-rpmh-clk", .data = &clk_rpmh_sm6350},
>>>       { .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
>>>       { .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
>>

