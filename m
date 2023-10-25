Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E77D6AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbjJYMBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJYMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:01:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F78129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:00:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c54c8934abso78751331fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235256; x=1698840056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNgCQybAeaDPw8MRhe+EaoWqCuSQBipbolyjdBq0HvQ=;
        b=b2wuTPmc/CtObG5yZZ7z81g9xRQFn5HeA6zOyp1szLTnB+JHjaH717AVgpCLew/La/
         /b1AhlUMWPTwFRBxgJsGd6T7+bMlyaoWyy/DB/r3qYNiRJt02nCKHHvDSH26WwjyPvf4
         I3gGF6u8H5/t2VZ7MBeP6DSuflbcoc4kI/UxlJIILJcaLOMFIo7A3Qn7lcBXl1F3NVag
         Iy7O+3cgQMxzrM4NEhh3hFpT4Pniyi2fkGrtUuVqWJHxBgE0CPpMQpSa82g6FRiWqLqa
         oHLBgnKW2Emx0LW9LGWjpxAmQ9D5sR6hViKxHLAxeR4Q8QqOblVz1Ygs1yG3QehePIzI
         JpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235256; x=1698840056;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DNgCQybAeaDPw8MRhe+EaoWqCuSQBipbolyjdBq0HvQ=;
        b=IQy3yfNk884GoRC6q4YxoWpzT3vwbtPpRMPrZFOkRbA97DceC9wpgUYwwnXN/6tvwO
         //pmOr7fN/iVs5MDsqouCLtRWD9r1h5jU+5Fog5yLbhDQE44IRQCCYzYPjSz9ipKnZBw
         ZOkwvZDAgUEIj+5lVD6uOgd1sPt4xYWq72Yd+9k66IywzckN7wJAJbJyy1GTnfECav7Z
         tJrmjJUMpnNt1KlTf6rvwLGqyV/GAys6RYHv/HaZxLXag1UBFF0nWDtMoQzD5VyLpckJ
         hkzbb7Wmz+F0izJjTKj3+TBFhlnGNH8zCZWEqOS+fimLv4YA/7SRJVP6I57I/vUYUJgY
         1ocQ==
X-Gm-Message-State: AOJu0YzPyZpEqPOY3rD1lOmzVtiE7Ip3iDnlFe+P5FvD1HWKT0PzQ3EX
        u9s8jr/LoOC5BVm21cu/e0zmVQ==
X-Google-Smtp-Source: AGHT+IGuYVpJbsG7mwwHhRKd77IPAY88N7+uHsNMvKmjG5P9vwqO9AlGHUVL9kaPJGjVV2TSTjLJYw==
X-Received: by 2002:a2e:b044:0:b0:2c0:1c32:b4e1 with SMTP id d4-20020a2eb044000000b002c01c32b4e1mr10665572ljl.27.1698235256185;
        Wed, 25 Oct 2023 05:00:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4b03:ec74:6374:5430? ([2a01:e0a:982:cbb0:4b03:ec74:6374:5430])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b00406447b798bsm19400325wmb.37.2023.10.25.05.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:00:55 -0700 (PDT)
Message-ID: <be119e71-0456-4806-8c0a-e77732553f70@linaro.org>
Date:   Wed, 25 Oct 2023 14:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 10/10] clk: qcom: rpmh: add clocks for SM8650
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-10-c89b59594caf@linaro.org>
 <467bc514-1cff-4bc5-a553-fd1ef0886ee5@linaro.org>
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
In-Reply-To: <467bc514-1cff-4bc5-a553-fd1ef0886ee5@linaro.org>
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

On 25/10/2023 10:47, Konrad Dybcio wrote:
> 
> 
> On 10/25/23 09:32, Neil Armstrong wrote:
>> Add RPMH Clocks for the SM8650 platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> [...]
> 
>> +static struct clk_hw *sm8650_rpmh_clocks[] = {
>> +    [RPMH_CXO_CLK]        = &clk_rpmh_bi_tcxo_div2.hw,
>> +    [RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div2_ao.hw,
>> +    [RPMH_LN_BB_CLK1]    = &clk_rpmh_clk6_a2.hw,
>> +    [RPMH_LN_BB_CLK1_A]    = &clk_rpmh_clk6_a2_ao.hw,
>> +    [RPMH_LN_BB_CLK2]    = &clk_rpmh_clk7_a2.hw,
>> +    [RPMH_LN_BB_CLK2_A]    = &clk_rpmh_clk7_a2_ao.hw,
>> +    [RPMH_LN_BB_CLK3]    = &clk_rpmh_clk8_a2.hw,
>> +    [RPMH_LN_BB_CLK3_A]    = &clk_rpmh_clk8_a2_ao.hw,
>> +    [RPMH_RF_CLK1]        = &clk_rpmh_clk1_a1.hw,
>> +    [RPMH_RF_CLK1_A]    = &clk_rpmh_clk1_a1_ao.hw,
>> +    [RPMH_RF_CLK2]        = &clk_rpmh_clk2_a1.hw,
>> +    [RPMH_RF_CLK2_A]    = &clk_rpmh_clk2_a1_ao.hw,
>> +    /* missing RPMh resource address for clka3 */
> So, the downstream driver suggested it's there but CMD-DB disagrees?
> 
> Can we get a confirmation whether it should be there?

There's a clka3 on the PMK8550, but it's undeclared in CMD-DB since
unused/unconnected on the MTP & QRD platforms.

Neil

> 
> Konrad

