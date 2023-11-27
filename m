Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6EB7FA25B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjK0OSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjK0OSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7B2D77
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:14:35 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c875207626so52624981fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701094474; x=1701699274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKy4amU8iTtG4c/87HNO+81MkT0IDMpCUf7Ez3DCBpo=;
        b=oSl9K6Bz2/Yx1KD1zH0lNRw2nFTQFM50RfR9QRIe1WWtFRDuehKSgs4qDzplagMVcS
         g9L8YvFZBnamWjrIXPOj9YnVHKX0D84PfZdmHn83Ptqxuzm0btchbUgOuttUfzBH9RI0
         qIIvUYpo6kT6x1aHL4jbQ9R9rZicbA4s6KJeImiV3d6MMwF/sWqcRZ8/4Nc79TTF0Mdl
         +txBmilhg3dTrPkVIX1mz8glRv7C1tOlPXQmQKkSiYhavwm5RgXEa9+HCHfOgtQcME7Q
         RawOySKG3Wtxe3mgqhkmPUYJ3tu8xT2sGPzBYKUhwlASnQfZN6XV8HRIn0F0KQ0UcoY5
         SU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094474; x=1701699274;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SKy4amU8iTtG4c/87HNO+81MkT0IDMpCUf7Ez3DCBpo=;
        b=qNZJMtYZIGUNLhZ1xPXO5TeB2GMSDoLQdoiZ6glgfN3MqO1MCecnNbGDlVkGQafnE9
         7tKU6kOq2xpgQeJXUrg/1pkZLWMZMr92FPnmZX6jeVFP454LPaOB4qfMYDMQxT8o7Lqs
         fnrxJG6byL/+R6VS+4Bd+TkuYkq9G0HhKgcUyxD/kYS1/ezhiyZqLs9J2/TPp5D0LonB
         88Ft7SRtK90kSvB7C6L+jAe9MXkRcMxb738SKO76f8/l4CbuFDgX/t72V6QchfD68z+j
         9+Z0aoJCfjpji1w7TD5N972l5/LVe8XDK3XA8qIFwvetg03NvhkHDdc5CL/K8slvIVpf
         0bXA==
X-Gm-Message-State: AOJu0Yyn6EwAmpAZ4phhlajbFfEUSQo4CkBnJTL5bsAUvZmU7rqSfkA3
        m5yg2vfcrUlpAlwp0fX0ec29Aw==
X-Google-Smtp-Source: AGHT+IEgW2j95zDOVf/FJ2L4dA2GNYqH5r60BaApgPyaI8kW0iwaiytQIfVMsNWUQBSCThijBUQYiQ==
X-Received: by 2002:a2e:b54d:0:b0:2c9:9982:69ed with SMTP id a13-20020a2eb54d000000b002c9998269edmr4192376ljn.22.1701094473958;
        Mon, 27 Nov 2023 06:14:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b0040b32edf626sm8416791wmo.31.2023.11.27.06.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:14:33 -0800 (PST)
Message-ID: <8a61e3e9-4139-4224-8c2b-1c2c40bad584@linaro.org>
Date:   Mon, 27 Nov 2023 15:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] interconnect: qcom: Introduce support for SM8650
Content-Language: en-US, fr
To:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
 <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>
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
In-Reply-To: <7fbe4090-94cd-4aaf-98b6-07f2a089d51a@kernel.org>
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

On 27/11/2023 15:08, Georgi Djakov wrote:
> On 23.11.23 15:32, Neil Armstrong wrote:
>> This covers the RPMh Network-On-Chip Interconnect bindings
>> and driver for the interconnect framework.
> 
> Thanks Neil!
> 
>> As reported for earlier Interconnect drivers, the IDs
>> for multi-rsc voting has been removed from this driver
>> so the proper solution can be developed without having
>> to remove entries later on.
>>
>> To easy Bjorn into merging the DT bits, would it be possible
>> to have an immutable branch with bindings shared with Bjorn once
>> this patchset have been properly reviewed and accepted ?
> 
> Hi Bjorn,
> 
> Here is a stable branch with the DT bindings header that might be needed
> for SM8650 dts patches.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8650
> 
> Thanks,
> Georgi

Thanks !

Neil

> 
>>
>> Dependencies: None
>>
>> For convenience, a regularly refreshed linux-next based git tree containing
>> all the SM8650 related work is available at:
>> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v2:
>> - Collected Reviewed-by
>> - Moved required block in bindings as requested by Krzysztof
>> - Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org
> 

