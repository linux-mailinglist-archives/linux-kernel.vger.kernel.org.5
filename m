Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BA7FB50B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbjK1I7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjK1I7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:59:22 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B1F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:59:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50abbb23122so6724083e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701161967; x=1701766767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YB9eXhdsuOiakznd6Lf5LJTFRBO3IbemXq2apHB2Dk=;
        b=n8c9aMM/vNV/jEDy5bV9qOFdlyu93LpCMms9ClVCP//CeHinQ6UFnLkfgbSaeAxRRV
         yX+yaqzBx+7tWvxu3MJNuv3yHXslJO1GCA3hvR5sWum0wQSGH0LZL6uyE5k5uWX8JpW0
         BJMJlOLw6KWqvK/t5VWKwkMPEIZiofzrucnI3VIhcqs5NHJ5U8xSiW7SGWCCiB2cQY+V
         MfEpvLK+Zdg951p1Q9jcn9S66M9AtXuLPypIm6e8cvVYEmBbHEPIctQ1Yy/GCUrUna4C
         pToFP5Kx46K/oylmi8lensPByrCVdJ6NsgcmCH31eGTnOlrRvQ+NduPsCFTqoVy++nj3
         JfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161967; x=1701766767;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8YB9eXhdsuOiakznd6Lf5LJTFRBO3IbemXq2apHB2Dk=;
        b=eGl8u40eE49b5UzOV1Xpxt+ewcoBjZIQtfm/iaPCE2FtrY3oTBR48jjT7nENhrAdpU
         I4lPmaSRaAUMgUik2NtEEOCH5d5PA2pW6DSWp5nmMp2GPor//jBz6MbyDG4e3tk9XjUw
         ERg8gUI9d0QZDFJMLSV8qIHu5Sh9KYYhMKdD0kEVQ5bmXKnP6uBLu3yeHR1Tp6zhlmG4
         KQyfqx0s29bZWz6SGtDMep19pu7to5U2/URpIwTJBzCIOV0jyvx019RXhR8IHOEqonCV
         R8bOalK8WIyLPPB5dVfUlmNmKk+gIKRD4q65Y/SEPJTfh5MKgqYJeNTFBEvEMjVLFals
         AKwQ==
X-Gm-Message-State: AOJu0Yz22CoJAAd9M5izSonMzpJBQZQZSASMVzPaKBlqktiDtc/7djOs
        ZZuglab33RP2aivb7wVmMMhJNg==
X-Google-Smtp-Source: AGHT+IFgtUElt6TEeq8N26GDHSRNCReIbvlh2U0u1SFwedLd+MAzHzMA+4u/+j6DCDvWt86KScuDBQ==
X-Received: by 2002:a05:6512:3a90:b0:50a:a242:b614 with SMTP id q16-20020a0565123a9000b0050aa242b614mr8577055lfu.2.1701161966447;
        Tue, 28 Nov 2023 00:59:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id o10-20020adfcf0a000000b00332cb5185edsm14233807wrj.14.2023.11.28.00.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:59:25 -0800 (PST)
Message-ID: <b637c287-93e5-4214-9275-80fac3c6181b@linaro.org>
Date:   Tue, 28 Nov 2023 09:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/5] ASoC: dt-bindings: document WCD939x Audio Codec
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-2-21d4ad9276de@linaro.org>
 <160fc6c4-b07d-49c5-976b-aa0fa35e4f0f@linaro.org>
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
In-Reply-To: <160fc6c4-b07d-49c5-976b-aa0fa35e4f0f@linaro.org>
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

On 24/11/2023 09:33, Krzysztof Kozlowski wrote:
> On 23/11/2023 15:49, Neil Armstrong wrote:
> 
>> +  Qualcomm WCD9390/WCD9395 Codec is a standalone Hi-Fi audio codec IC.
>> +  It has RX and TX Soundwire slave devices.
>> +  The WCD9390/WCD9395 IC has a functionally separate USB-C Mux subsystem
>> +  accessible over an I2C interface.
>> +  The Audio Headphone and Microphone data path between the Codec and the USB-C Mux
>> +  subsystems are external to the IC, thus requiring DT port-endpoint graph description
>> +  to handle USB-C altmode & orientation switching for Audio Accessory Mode.
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +  - $ref: qcom,wcd93xx-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,wcd9390-codec
>> +      - qcom,wcd9395-codec
> 
> 9395 should be compatible with 9390, so please express it with a list
> using fallback. I know that earlier wcd93xx do not follow that concept,
> but maybe we will fix them some point as well.

I don't get why this would be needed, yes their are compatible but still
two separate ICs with different internal capabilities.

It the first time I get such request for new documentation

> 
>> +
>> +  mode-switch:
>> +    description: Flag the port as possible handle of altmode switching
>> +    type: boolean
>> +
>> +  orientation-switch:
>> +    description: Flag the port as possible handler of orientation switching
>> +    type: boolean
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description:
>> +      A port node to link the WCD939x Codec node to USB MUX subsystems for the
>> +      purpose of handling altmode muxing and orientation switching to detecte and
>> +      enable Audio Accessory Mode.
>> +
>> +required:
>> +  - compatible
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    codec {
>> +        compatible = "qcom,wcd9390-codec";
>> +        reset-gpios = <&tlmm 32 0>;
> 
> Please define for the GPIO flag.

Ack

> 
>> +        #sound-dai-cells = <1>;
>> +        qcom,tx-device = <&wcd939x_tx>;
>> +        qcom,rx-device = <&wcd939x_rx>;
>> +        qcom,micbias1-microvolt = <1800000>;
>> +        qcom,micbias2-microvolt = <1800000>;
>> +        qcom,micbias3-microvolt = <1800000>;
>> +        qcom,micbias4-microvolt = <1800000>;
>> +        qcom,hphl-jack-type-normally-closed;
>> +        qcom,ground-jack-type-normally-closed;
>> +        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
>> +        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +    };
>> +
>> +    /* ... */
>> +
>> +    soundwire@3210000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x03210000 0x2000>;
>> +        wcd939x_rx: codec@0,4 {
>> +            compatible = "sdw20217010e00";
>> +            reg  = <0 4>;
> 
> Just one space before '='

Ack

> 
>> +            qcom,rx-port-mapping = <1 2 3 4 5 6>;
>> +        };
>> +    };
>> +
>> +    soundwire@3230000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x03230000 0x2000>;
>> +        wcd938x_tx: codec@0,3 {
>> +            compatible = "sdw20217010e00";
>> +            reg  = <0 3>;
> 
> Ditto

Ack

Thanks,
Neil

> 
> 
> Best regards,
> Krzysztof
> 

