Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731537FEBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjK3JRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:17:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516789D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:17:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b54261442so5533235e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701335873; x=1701940673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeZ6OItO2v/+irq7fXSANezODRCbCXw1O9xexHjxpGs=;
        b=jd93ApiU/V7Vjv4W5ZLuqJkANznd05nOZcndbjCZYmbXV7xfTAxXfeFA4NnPUah3zd
         OoFtAVKmoYJXIVGISuNcYjqKgWyEEYVtMDsIqbjuxoQAyVpJIWcIWSLH3x5QUcMKSEoO
         jR4gw/2GbBeLad4XH7jU0fuLpxdJ6yYil5jgIVnTKVDR1wcjWVO1DOoUfRXm21lH9TJO
         Y99jv3ClXi1+bAAcibt5HhoEox6Dew6mBEmWk72SRt5JdGUL7JPk09aVS1jYhLAPqd4H
         +/JnNvI9PsZb6h70eREPXF68xT+qPcc7mz8ob5WBOyK19t+20pAy6xf7ajtHMU3qgbFw
         QJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335873; x=1701940673;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VeZ6OItO2v/+irq7fXSANezODRCbCXw1O9xexHjxpGs=;
        b=BsXSoTj63Gf4v7e9iCori+PwmJZvtFHcDqv1JFXhZnQPQ9b7h2dZMJkpjQcX3wX7Xh
         YWNZIjr3rRVb8RAsMfRe5vhkyk48+PaAkt5t7PCen90L+ySbpvrf5nIJbiJRPFb0WyMY
         Z5w93ytVxupbCanJsnvq8PV43oFDrFl3K4/VMZhwafGHhO90i4qGGOjkT2HnlKLSw+UI
         U29HEzxW3b4MxYXo7s242vPvCPWCKaYnsJfU3E9gferdtbx3NBMoGXG1hjWOtKEV/Pir
         ZIjURKyimjnA9tzehoOj4WRSJoxI/JfgOMN7OoiNaokMVU0F10+35xDS7Sp+EQTvjNir
         raRQ==
X-Gm-Message-State: AOJu0YwGu840fRYWNI1Ax9cVd4UmX/VHS6DA1gotdsJW5cFZ1XBTrT1/
        WlVy8zsjzbrAU/0lQYCAgWTrag==
X-Google-Smtp-Source: AGHT+IF7F+Ox76Mk5MdBX3EddwafkOTZ+g/sw2OdCsSCCYfJAVPIblk5QtryuvpJDHF7WNQuPw34WQ==
X-Received: by 2002:a05:600c:4f8a:b0:40b:4520:45af with SMTP id n10-20020a05600c4f8a00b0040b452045afmr8599599wmq.23.1701335872699;
        Thu, 30 Nov 2023 01:17:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id v9-20020adfe4c9000000b0032d9f32b96csm963177wrm.62.2023.11.30.01.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:17:52 -0800 (PST)
Message-ID: <1450d89c-9c86-4930-b976-c50724cf13df@linaro.org>
Date:   Thu, 30 Nov 2023 10:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: correct TX Soundwire clock
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
 <20231129140537.161720-2-krzysztof.kozlowski@linaro.org>
 <3ec70fd9-11a3-4bd3-bd8c-a73c3d44dcde@linaro.org>
 <0be610ed-ac95-4de1-9639-d634cf979359@linaro.org>
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
In-Reply-To: <0be610ed-ac95-4de1-9639-d634cf979359@linaro.org>
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

On 30/11/2023 09:06, Krzysztof Kozlowski wrote:
> On 29/11/2023 15:35, Konrad Dybcio wrote:
>> On 29.11.2023 15:05, Krzysztof Kozlowski wrote:
>>> The TX Soundwire controller should take clock from TX macro codec, not
>>> VA macro codec clock, otherwise the clock stays disabled.  This looks
>>> like a copy-paste issue, because the SC8280xp code uses here correctly
>>> clock from TX macro.  The VA macro clock is already consumed by TX macro
>>> codec, thus it won't be disabled by this change.
>>>
>>> Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
>>> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> Interestingly, downstream 8550 has
>>
>> qcom,use-clk-id = <VA_CORE_CLK>;
>>
>> which doesn't seem to be used in techpack
> 
> In which node? I see it in the va-macro node, not the tx-macro.

Same I only see this in the va_macro.

Neil

> 
> Best regards,
> Krzysztof
> 

