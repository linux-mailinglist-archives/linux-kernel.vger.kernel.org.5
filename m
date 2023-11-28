Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC07FC136
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbjK1PB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346428AbjK1PB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:01:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFE10E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:02:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b479b9c35so15467225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183722; x=1701788522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkWu2ySemNB+dH9OL9BeVvXo61wInQDnE0WqBxTBfkI=;
        b=HIOQlGW1QxdmrClYbNjwPRnpecuU3Sm1WIvTgc5p9LLB0upiteqAqu2U8Y5/thqsMB
         pYE0IstAsyI9Ges8ooWajBXuup21LbU/z+nvDLRjOOVtBvZNH4y5PNyf/ogrdJS7NlzG
         nuN4nHAJKOgmou7YClQedbjjy0zrgwxeQEy+zuX+JGs4IIp0JMYHLsup21ea7Nb11oJC
         jfykXjVLfTLVtfxFavlSTs98xdFqAxiLiBBYrurNTh8zh2o6xPhpni0Ia0c2USTq1XS2
         JMSQllQWx5Po5ZgYqiHoPUZCLm3PnWz1zTGufxXb6RgD4qjqO38HB6kEO62OoIeIbbKg
         h+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183722; x=1701788522;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkWu2ySemNB+dH9OL9BeVvXo61wInQDnE0WqBxTBfkI=;
        b=Lipk2OzZ8A5BIPWTJSFGHvz0X9ttbYcjiEiLJxl9QW1tq3VXWBkunBhTN16SD/KztM
         qqY+WhVlI8uCYYGWlOhXWBW+B0sHBeY1RP28zjw6zs6DWpHMI9OjOMqaX7cKUGIxpYbH
         jezyTniSECyyU+Vtn1x4Qof13RA9mXa0pWuh7Pqt6zld4tOCheeW2z6Y5V4uQ6qIjmMJ
         OVlWlZdqABWhps8vbOjEMI+qf20hzx0R1HARGPrmd7bXo8hb0KLhrxCFud88lcWabbZx
         WRo4tsm9qg+QQStJuP72nHU4z3A5Wmcc8N4G48337210OOJ2sQczGHMHzCej+Tnzd1XZ
         Zymw==
X-Gm-Message-State: AOJu0YwpLsH09FsM6Zm1mcx1zUS7LeScCTOVXiKnFRLx7arQ9bdgL8LN
        YHj6Y3UvJUBcn9AGu0We9AZvlg==
X-Google-Smtp-Source: AGHT+IGVOUpmvb94Jr5diQ87yRJsgTUXl7a1KEj86KCsuk0xkpDAakMyWxHFifx04mdoT3ggOA6w5Q==
X-Received: by 2002:a05:600c:1d17:b0:401:eb0:a974 with SMTP id l23-20020a05600c1d1700b004010eb0a974mr12639457wms.3.1701183721458;
        Tue, 28 Nov 2023 07:02:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id fa20-20020a05600c519400b0040b3e26872dsm12773310wmb.8.2023.11.28.07.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 07:02:00 -0800 (PST)
Message-ID: <42a6f6e0-2846-4cdc-8702-493fadbafb98@linaro.org>
Date:   Tue, 28 Nov 2023 16:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/5] ASoC: codecs: Add WCD939x Codec driver
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
 <ad9a7c4b-82f4-4347-b4dd-a394e4ba95f0@linaro.org>
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
In-Reply-To: <ad9a7c4b-82f4-4347-b4dd-a394e4ba95f0@linaro.org>
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

On 25/11/2023 13:07, Konrad Dybcio wrote:

<snip>

>> +
>> +static int wcd939x_io_init(struct snd_soc_component *component)
>> +{
>> +	snd_soc_component_write_field(component, WCD939X_ANA_BIAS,
>> +				      WCD939X_BIAS_ANALOG_BIAS_EN, 1);
> All of these values are BIT()s or 2-4 ORed BIT()s, can you check what they
> mean?
> 
> Same for almost all other snd_soc_component_ write/modify functions

It uses snd_soc_component_write_field() with is the same as
regmap_write_bits(REGISTER, REGISTER_MASK,
                   FIELD_PREP(REGISTER_MASK, value);

So the 1 mean write in enable mask in this case, and mask is single bit,
read it exactly like if it was using FIELD_PREP(), but even for BITs.

I did check every single snd_soc_component_write_field() so far to check
it matches.

Or it's another question ?

Neil

> 
> [...]
> 

<snip>

> 
> 
> Konrad

