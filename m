Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7A7D6A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjJYL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjJYL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:56:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA413D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:56:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084de32db5so46955575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235003; x=1698839803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntZ1JpiCH0v861EMwiiZzKp1eCEOCRwWhzRC0rD+sjU=;
        b=q10paYoDIv2nf/ax2UvnFmK+diqyx4zZrT5XhtLcmQt+zCX29pNxOhGnzdMESPNxO7
         3PQ6uewYkDTmK4F5GKLrO8piIhDEXMhqPVJM6Qqv6ivSZOLUE0y5mffsyWSrVj9IGi2g
         TovZa/NVKlHo/5cBGa9FUgndbb4v6sRCaxAM+izgaprTT55QtmdgwXOvAMV+oIE1GAfO
         LbHcsbHHwyJfS8Ka5ljjosxAJ11T4t8KELIbsTp6H1diDkG+2aDQiixXDnLf31ip0Hmt
         l1zZBlKe3oH21SEP74bU9mzIUFA3/UcdYwzBjucdq6EIRiXrRZiqk+FE2sAur6tT0ZoE
         gSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235003; x=1698839803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ntZ1JpiCH0v861EMwiiZzKp1eCEOCRwWhzRC0rD+sjU=;
        b=W0gYMs7196/NxbeAhDsY3ik1Mk78meGiXxqaly6q3OTw5Xg+7sbrrliylf/ZoEJlUj
         FdW/56ApHwCNmatfVXS87bFEvtATwdpwQgw9NfppHRPUGb+S5CeE1xiSnwwMH6lf6yHZ
         /ha9ioYwQc3vNiPaX3RKKnVNb18uEELLqTl27tg7VZWsJJNoXedsXqxw0kT0xqm7cVHo
         qjwzgPAVBS3SITF5wm4zhoMLnhn0qIsya9c/X2IyYn9P7pi2u5S3GqnPlEtaEFnItRJz
         pyEIkaXYZolpQoJUKxIIAlj0AoPaN7Wa/eEZZVGKlQhvait/EFu5/utcW6Ue2BcOCs8i
         ys4g==
X-Gm-Message-State: AOJu0YxIZc/w/CP+nWb6tywqJsHZNzyA/hxjPQNBwICs1DEVXYoHpv4z
        DCrbIRqvUVPmLqha8aX8y3ByKQ==
X-Google-Smtp-Source: AGHT+IHX2FpNSPui81nBWrWZlfjK7IPn3Gl11Lt3FKEXEZcYYE4ZqQ/og+64TR5FVWtIiB6N05U0Bg==
X-Received: by 2002:a5d:500b:0:b0:324:8239:2873 with SMTP id e11-20020a5d500b000000b0032482392873mr10403313wrt.37.1698235002980;
        Wed, 25 Oct 2023 04:56:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4b03:ec74:6374:5430? ([2a01:e0a:982:cbb0:4b03:ec74:6374:5430])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d49cd000000b003176c6e87b1sm11797593wrs.81.2023.10.25.04.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 04:56:42 -0700 (PDT)
Message-ID: <7202ad7c-5568-4abd-9fde-e374428225ab@linaro.org>
Date:   Wed, 25 Oct 2023 13:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 07/10] clk: qcom: add the SM8650 TCSR Clock Controller
 driver
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
 <20231025-topic-sm8650-upstream-clocks-v1-7-c89b59594caf@linaro.org>
 <c9aa685b-b746-4901-a374-4e9d4d5b6cfb@linaro.org>
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
In-Reply-To: <c9aa685b-b746-4901-a374-4e9d4d5b6cfb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 10:43, Konrad Dybcio wrote:
> 
> 
> On 10/25/23 09:32, Neil Armstrong wrote:
>> Add TCSR Clock Controller support for SM8650 platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> [...]
> 
>> +static int tcsr_cc_sm8650_probe(struct platform_device *pdev)
>> +{
>> +    struct regmap *regmap;
>> +
>> +    regmap = qcom_cc_map(pdev, &tcsr_cc_sm8650_desc);
>> +    if (IS_ERR(regmap))
>> +        return PTR_ERR(regmap);
>> +
>> +    return qcom_cc_really_probe(pdev, &tcsr_cc_sm8650_desc, regmap);
> qcom_cc_probe?

Ack, missed this one.

Neil

> 
> Konrad

