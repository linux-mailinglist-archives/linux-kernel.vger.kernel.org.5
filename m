Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74787F0D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKTIM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:12:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E18B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:12:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40a46ea95f0so15512855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700467972; x=1701072772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhDE2L7lEf7iSrI5yGHsZcxUh03VSqymUutwpX7Pffk=;
        b=cBqgxhA9sQEAskr3kHAocMz7SBrgnXarU+8VPRLcuMLPXWZxbWixRiANW81GcEitnB
         fnddjIsokQmdPbSkoMUxSIzfjObQpu+6S5S1C820Q4fASVnTPIBCmqJzlfewLwv1kWj+
         qQHDzEQSVPRnfBX6Eo+RVOMzOmFO0zeSslg0UEFie4K6fM+3KvZNBDwiluiRNo5Fenl8
         Re3+WNaoElcIyNSkSZDaSZGTCafBEjcpog2QNP7hESdUhdtemujr4LROENvicLz7XGR4
         pEAFPr7JM2HQMJP8jMQHn3NRQD68EMccfzmxh12pfV9Wz7/V36IjBr3jzxal0KlQ1H5P
         emZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700467972; x=1701072772;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhDE2L7lEf7iSrI5yGHsZcxUh03VSqymUutwpX7Pffk=;
        b=YFhV8cwdJOKzwzVCVMKj+iYgHf5MeF1aGmXNK+DtIohaAktmn3UyRpltcwAxkjjLE4
         j9Q3xBkRXs/AYhwBtqMs/pBeqnVHT4WQsSDbWFCKOSj5P7R75lzn8+KklWGwF48Lw5do
         auArbjmF6gdVY1jvn5Cvcw6ab+agEb+Vv817waaZaCuV4AeWETNiZ7okj2naC3IfjP+E
         qLsyisVxggOm93W6V/rkYBVqT2cYTg/CmaiO324reCu6VdrE5uqoPHp7Wm//d3udRCtL
         M1vSa/1YYmDLrkdHHZWlk47wKwCY820TM2vrpUe2VDS8yHMh2SmB8HidMAhwd3Zgx8vU
         x3rA==
X-Gm-Message-State: AOJu0Ywb1PMlkx2pSTih//yVL8qQXa8a0o+KxZmHJsepRSIgD+weWPVz
        OMM3LlBboAnsF+mHN4ta7NiCRA==
X-Google-Smtp-Source: AGHT+IHrq0UjXRbJljBpwtb0lzEnceeWLnHCRAYZRW1u9snHLGAYKYqf2iuRy7o2NGzzgKNs7DQf4w==
X-Received: by 2002:a05:600c:470a:b0:405:4a78:a892 with SMTP id v10-20020a05600c470a00b004054a78a892mr4497234wmo.9.1700467971857;
        Mon, 20 Nov 2023 00:12:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f04:f84b:d87d:1d06? ([2a01:e0a:982:cbb0:f04:f84b:d87d:1d06])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b0040841e79715sm12714341wmq.27.2023.11.20.00.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:12:51 -0800 (PST)
Message-ID: <46bcf9fe-d896-4a8d-90da-1f86711fd736@linaro.org>
Date:   Mon, 20 Nov 2023 09:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/8] arm64: dts: qcom: add initial SM8650 dtsi
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231106-topic-sm8650-upstream-dt-v2-0-44d6f9710fa7@linaro.org>
 <20231106-topic-sm8650-upstream-dt-v2-2-44d6f9710fa7@linaro.org>
 <5b1d2eff-d328-4bb2-b255-b5913e1700f5@linaro.org>
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
In-Reply-To: <5b1d2eff-d328-4bb2-b255-b5913e1700f5@linaro.org>
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

On 18/11/2023 01:21, Konrad Dybcio wrote:
> On 6.11.2023 09:39, Neil Armstrong wrote:
>> Add initial DTSI for the Qualcomm SM8650 platform,
>> only contains nodes which doesn't depend on interconnect.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Just a couple nits
> 
> [...]
> 
>> +		cpu2-bottom-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
>> +			thermal-sensors = <&tsens0 6>;
>> +
>> +			trips {
>> +				trip-point0 {
>> +					temperature = <90000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				trip-point1 {
>> +					temperature = <95000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				 cpu-critical {
> indentation
> 
>> +					temperature = <110000>;
>> +					hysteresis = <1000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +		};
> [...]
>> +
>> +		nsphmx-0-thermal {
>> +			polling-delay-passive = <10>;
>> +			polling-delay = <0>;
>> +			thermal-sensors = <&tsens2 8>;
>> +
>> +			trips {
>> +				thermal-engine-config {
>> +					temperature = <125000>;
>> +					hysteresis = <1000>;
>> +					type = "passive";
>> +				};
>> +
>> +				thermal-hal-config {
>> +					temperature = <125000>;
>> +					hysteresis = <1000>;
>> +					type = "passive";
>> +				};
> The two above nodes (which are repeated under many tzones) sound made up
> just to be consumed by a bunch of android binaries
> 
> Or at least the second one, maybe "thermal engine" is some hw/fw part?
> 
>> +
>> +				reset-mon-config {
> "reset mon" is not a very enticing name either..
> 
>> +					temperature = <115000>;
>> +					hysteresis = <5000>;
>> +					type = "passive";
>> +				};
>> +
>> +				junction-config {
> ...which leads me to believe only this one is meaningful
> 
> same goes for all tzones that have a similar mess :/
>> +					temperature = <95000>;
>> +					hysteresis = <5000>;
>> +					type = "passive";
>> +				};

I already did a big cleanep, will clean even further!

Thx,
Neil

> 
> Konrad

