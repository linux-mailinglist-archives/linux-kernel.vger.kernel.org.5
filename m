Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0B7F603B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjKWN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbjKWN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:28:04 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D12D50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:28:10 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so10843451fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746089; x=1701350889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhSFvfpy9cWyHElc04KrxbfIPOEzDLJiSvaFpWPfAfo=;
        b=NXjAOvlBFNIh3j3Y6gjEGmojHA7eM6dJIbagt8cmFtqCc9qr7NWz1Q09hqwNvpATZm
         IgZXb1BC80EhLCUdKy0kcK0+xVIG1pXpwb4wivejqb10nNJ2yCQCC6eiMQFb1aobe77d
         l/rZBuc/wRPIdwBJoVJCNCJnsFe0MgbvQ92idiCcM5DcIG4GNNu4LzRHOQwodpkC+pVc
         deYTvuFVBdtiXgjv/6woEM8g7PdX1p3CV8LUebOUdjHym1htG8N0F98HE0VhMOMDZ7w7
         qMpDdMdse7iozmcfGIC9o0RoM+kxlRGnGZ4flxXrV3VPkolm3zOdQ1z0jDFMbyA2RiIw
         G6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746089; x=1701350889;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GhSFvfpy9cWyHElc04KrxbfIPOEzDLJiSvaFpWPfAfo=;
        b=VTkRPoFUjBoxq+YkQY2THYWL8fcvjjfgj6FhGR1ayWU3jMG0Dp6bUwCuOUoDuiZmPT
         jxkMHLflEomK99gTuJ7AC7CyDsLpZJ7cnfsZ4DYPheywMUbmKgpENjMk91VmXmSlf+wv
         VJyb9gWQuKwG8k89CYw1Wy9vBr5FxjdP/4DIPb5rK9GCc/uj8JlMACQMsO8rATIvE1tF
         ctGPeBVBtOctdIt6AUYUaAXdTN4l4Qon2O+nJ2rzS63JE3pYr7kotoC0iGISLc7p5sI4
         DPxqEA5/Qkx0PtmsQeemuCK/SevWRXcfeEqhPMFxVnwNBcISlTm/NMFryYhEaU+PIj1A
         EIPA==
X-Gm-Message-State: AOJu0YxdyeZMfwVAiQ7jo+2LmvJrwibSyh5KC1elO6jyc/KV3qg+gLVY
        Kk7KYjNOYwee7W75Y8H13eJIDw==
X-Google-Smtp-Source: AGHT+IHikJAtF8fot11Zw3aw5ER+K4IPY0RS05vwoBfLABFNx3Sc1soHRMEF9M+GtzObWJNcO79SQg==
X-Received: by 2002:a2e:a4c6:0:b0:2c8:33a6:4df4 with SMTP id p6-20020a2ea4c6000000b002c833a64df4mr3649796ljm.38.1700746088838;
        Thu, 23 Nov 2023 05:28:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba? ([2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba])
        by smtp.gmail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm2666744wms.44.2023.11.23.05.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:28:08 -0800 (PST)
Message-ID: <26da5c1d-e285-4036-9661-4018f977452f@linaro.org>
Date:   Thu, 23 Nov 2023 14:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/8] arm64: dts: qcom: add initial SM8650 dtsi
Content-Language: en-US, fr
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
 <20231121-topic-sm8650-upstream-dt-v3-2-db9d0507ffd3@linaro.org>
 <dbf10516-d927-4665-8471-c3126c72454e@quicinc.com>
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
In-Reply-To: <dbf10516-d927-4665-8471-c3126c72454e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 09:07, Krishna Kurapati PSSNV wrote:
>> +
>> +        usb_1: usb@a6f8800 {
>> +            compatible = "qcom,sm8650-dwc3", "qcom,dwc3";
>> +            reg = <0 0x0a6f8800 0 0x400>;
>> +
>> +            interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>> +                          <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
>> +                          <&pdc 15 IRQ_TYPE_EDGE_RISING>,
>> +                          <&pdc 14 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "hs_phy_irq",
> 
> Hi Neil,
> 
>   This GIC_SPI 130 is actually pwr_event IRQ, not hs_phy_irq.

Thanks,
Will fix in v4

Neil

> 
>> +                      "ss_phy_irq",
>> +                      "dm_hs_phy_irq",
>> +                      "dp_hs_phy_irq";
>> +
> 
> Regards,
> Krishna,

