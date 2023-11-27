Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7437E7F9E43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjK0LOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjK0LOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:14:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A79184
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:14:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507975d34e8so5626439e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701083645; x=1701688445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmbmBmRRdKxpX6icnQb8EoGEatT9K1QsmoojXY70vRs=;
        b=qGm6aBoRhWoWlTCx9X4WyaoJPVaNWCCnY///vPFoQiim2v4caZ8nzvXMg91JGyJ71I
         B2nT76g9s41BdgMdVLqMvE5XVw2Mh5CTLFo2f4GJqlPyudDhPkPGwfGgZ1g65r57veQB
         DLZ9JiJDNBp/238wA0rZuutMncEZct6vcw7V6DJT1CjqeYaP9NK4i5CaYzVbcCmwqbLo
         f9MvsXjPSAPyFI+Lc0OLXtoG4bfoH+pJq/3+iJWd4kHG97RkaHLagldWRi7oqneNsqY6
         MscaxDxZlWAhWShn43Qn/Mzq/gRxxKOPyRGEQlP90QtMQTWZ7LGtwqLlzyVoRZQZP1OX
         Socw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701083645; x=1701688445;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmbmBmRRdKxpX6icnQb8EoGEatT9K1QsmoojXY70vRs=;
        b=OITCbTRzhUCcHHbnNL4/0jA4VO00AE438NJYc5md+Oxvhqj5+PVCXp9fE8A0LQ/m2r
         JnIfXJQGGLRfts0BZv9muQ1Z9ns9rewruMxIDTAsA46IXqNYeBKSLnx0NFZjJogQLvce
         cYnuzIJdbFlt/nqI4izbagDqqaenxa6gPtqhSw2kMzf2BiF0IxTXYgWKLSnWklG0xr28
         vH8tPRN5tCwBglljxh5tFRaZnTsv02RWI6iyoc8HkBIzfI9O1wp7/XsOZJfB3487V1mS
         NpcigjNXc6JFfv6kWo6BQJtwPTcWOX4wtLWqwovlsXTm0LUF4wR1EUXdKLb1jEk9oB+C
         K5Yg==
X-Gm-Message-State: AOJu0YxmX3JDikVAywr4GAama+exPZIypZeyumlXkE4LUqdVI6GOPauf
        W9+P+s+0dFNXodhaHMIS1jTDRA==
X-Google-Smtp-Source: AGHT+IFRj8knH6GfgaWHI+KGJP+wSNIDn1kOEjrcPBY5sjtNKeumJ0oOv2DOepgjLxkE14Mc3R1ELQ==
X-Received: by 2002:a05:6512:6c6:b0:503:fee:5849 with SMTP id u6-20020a05651206c600b005030fee5849mr10155461lff.53.1701083645039;
        Mon, 27 Nov 2023 03:14:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b003316b38c625sm11715511wro.99.2023.11.27.03.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 03:14:04 -0800 (PST)
Message-ID: <9a6eb36d-fba7-4b8a-8571-4823720f7a27@linaro.org>
Date:   Mon, 27 Nov 2023 12:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: enable IPA on sm8550
Content-Language: en-US, fr
To:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org
Cc:     mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231124181718.915208-1-elder@linaro.org>
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
In-Reply-To: <20231124181718.915208-1-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 19:17, Alex Elder wrote:
> Add the basic DTS information for supporting IPA on the Qualcomm
> SM8550 SoC.  Enable IPA on the SM8550 QRD platform; GSI firmware is
> loaded by the AP in this case.
> 
> 					-Alex
> 
> Alex Elder (2):
>    arm64: dts: qcom: sm8550: add IPA information
>    arm64: dts: qcom: sm8550-qrd: enable IPA
> 
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts |  7 +++++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi    | 39 +++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD

Thanks,
Neil
