Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335B2783D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjHVJwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjHVJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:52:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC01AD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:52:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee51329feso17298355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692697962; x=1693302762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjKHM/3nTdg/5cBvMx2i82IFUKKtAE2HhZHSgd2Fouc=;
        b=ydIg0uRypgM1MGYRqZ+tWcf4A4xiFMcft91t6sRqWIRT5i8Q+97CBoDBx2w/uOPQnC
         FMubL7Hh5acZF48SNAzLIsx4KX4whdEVTd+9ZxlzL4JUM5jZexcrgO0j+YunQsjAm2Zp
         VgC3qM64xKXYnqv10FwBEi0PCNaINWLvisXHx5xlQYPwYvh06nJyQRzJmI8hoyBOrlta
         CYsRtf5mSvL035wUwBhK+psKljTb5BYC0YeBJY+VXJMIdD4/DnZMZTCcd/+6m6aiY+cq
         KVNBaNmdxMHoTiGRZ4IdpDROyRsU+NfE4fUY6GcCcdIO3LpcgQx9djdm9SA3WlpkwyOq
         UcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697962; x=1693302762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EjKHM/3nTdg/5cBvMx2i82IFUKKtAE2HhZHSgd2Fouc=;
        b=Ndz8wku2XRa2Sm0spx1bGbGLcgix42w1jUrds5Xj0gcZuABGVs51NMMQP0aM+WgGkJ
         cCcSmIisjNUAJabSJZtp1jpadzFeGQWBjWbiY/F8myW3M17WiKXcerdSdQOV2fQVII+O
         dS53divsFUZOu/zWWGPGaMj9+0fTZlt6BUgfqQL1EKKtuEfxdTw5FRu5SqM2VM4Hbd7X
         QvudyBUpTxgEvANDEhi3A7JwW0EKy/f0HKIQH5R+lNEbY9Q5gk/UXkZ5pc9jfiHgutji
         D5ma92QHteO/gWYlDMycdFKeMlT9He3f9lmmjCeh6//WFkZVQKBQ6dKi++Wnmrmque0f
         fy8g==
X-Gm-Message-State: AOJu0Yw7qUhebNtU0ihZP6gygLztEAhPPDVPxcyG30hFZ9A/aV7siDg7
        PM6oTkRhRBXIhhMKoG7mE6+OXA==
X-Google-Smtp-Source: AGHT+IFaNk+7kF4LVYKeFPLWbhi7rfUWZKJ8Ay7swTLvqMHnd69JpAB+C5tRUltLl8N7zV9JF4SAaQ==
X-Received: by 2002:a05:600c:690e:b0:3fb:c257:9f48 with SMTP id fo14-20020a05600c690e00b003fbc2579f48mr6818240wmb.16.1692697962088;
        Tue, 22 Aug 2023 02:52:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:8390:46ac:a6ce:2040? ([2a01:e0a:cad:2140:8390:46ac:a6ce:2040])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c2a4100b003fe1630a8f0sm18771964wme.24.2023.08.22.02.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 02:52:41 -0700 (PDT)
Message-ID: <35f3aac5-7b8b-4cc7-9572-adf3d93e7a67@linaro.org>
Date:   Tue, 22 Aug 2023 11:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: regulator: qcom,rpmh-regulator: allow i and
 j as RPMh resource name suffix
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v1-1-23fda17f81f7@linaro.org>
 <6f324696-1648-461a-a3ac-20f0b76e41f0@linaro.org>
 <a322acf6-b1e9-4203-9cb4-fc2adea88f64@linaro.org>
 <af07578e-2d31-4b26-931d-aeb0833db267@linaro.org>
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
In-Reply-To: <af07578e-2d31-4b26-931d-aeb0833db267@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/08/2023 11:42, Konrad Dybcio wrote:
> On 22.08.2023 11:29, Konrad Dybcio wrote:
>> On 22.08.2023 11:28, Konrad Dybcio wrote:
>>> On 22.08.2023 11:27, Neil Armstrong wrote:
>>>> Add "i" and "j" to the allowed subffix list as they can be used as RPMh
>>>> resource name suffixes on new platforms.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>> Also 'n' and 'm' for 8550
>> Correction, the PMICs are indexed 'n' and 'm' but looks
>> like there are no RPMh-managed regulators on there
> Correction of the correction ;) there are some

Indeed, you're right, let's for for i, j, n & m then !

Neil

> 
> Konrad

