Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153437FB477
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjK1ImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjK1ImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:42:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6187F9D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:42:27 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso7821252e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160945; x=1701765745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Erf0gitB2S5rXXmcEeV/xkrurthBZdKYZBJso/PS/Ac=;
        b=Apc9CIzXM4rfC5ZSXd1ivVWekxUkRBkorcQrIfWg9UxFpW/kkcBW693lTkSMe0p91X
         dH+AGuEp8gSJLF8weWBEyByCMpOdvUUB36/gkLdXCoQBGOHS/mjf9YbfV3Td0OHKVNBF
         HCqKD2BP7JxUDZLWgKdyrr1NZ/0t3dkOC+ypfHUAjXVmQR32qUbxgfWxa6LXZ8FfyPOs
         5BxuNGFhc9VaGfA4/508bxDJBAy96WcsxAXF16v698Rn70cdDsrmcAx4kFZhQ/teflhB
         dUln7Gu116rsaKGhKstouo33XNVghztbLvvGfDcUfUodzNCsLSIo98m50zhV0h0gVU2h
         4KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160945; x=1701765745;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Erf0gitB2S5rXXmcEeV/xkrurthBZdKYZBJso/PS/Ac=;
        b=UuPTLvUMqiB0jUQAGaIhC8tvC1zTkuBQHDlfnRsils59ZVyBpIUWZ2c65rLvIn0+CM
         BNogOhfB0ytZAl07NPGmomoGiSClSYNNypUFpnHIjxUcIf9m+XiYdWwHTuSS8l0/sz7t
         YmzdRBU7MV2axoYGOLOxZVxZ9h3NV9sjNytpabb5Kd/Kh6X1jzU7zSqRc1YtygpOeY1U
         TfSN/erPbhDnTnjxuOz3EKVt7ABbkZ46XpYxPDAlvTapOGnbHazIZQH7KYlJtuqnqnmr
         noAytPs+qwXKMX2rFYAlm63/rK7k7D1cRzp+DLuqYSuuO4ln5TaSEfbyPPwXBMx7+X9v
         jdjw==
X-Gm-Message-State: AOJu0Yzwcwq4pPiCAsVLcWP4gyiHmGC5LLjDts7sCpNmslt8CLSbEs+S
        yWhCsslFmgbkBk72iiZowFHkiw==
X-Google-Smtp-Source: AGHT+IGpPMz6U7UlSZRGx1bf2JkG6T7mTur+DF+VvbtmPQO99UJytTF3JNBbD72JCUwE18GKibK6OA==
X-Received: by 2002:a05:6512:2244:b0:50b:bd7a:abbc with SMTP id i4-20020a056512224400b0050bbd7aabbcmr560068lfu.66.1701160945641;
        Tue, 28 Nov 2023 00:42:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id q19-20020a194313000000b0050a78dac3fasm1795027lfa.12.2023.11.28.00.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:42:25 -0800 (PST)
Message-ID: <9bb9b7e3-ba59-4c29-99b8-173b1e8f247a@linaro.org>
Date:   Tue, 28 Nov 2023 09:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
Content-Language: en-US, fr
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231128-topic-sm8650-upstream-bindings-pcie-v1-1-9c803b439952@linaro.org>
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
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-pcie-v1-1-9c803b439952@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 28/11/2023 09:36, Neil Armstrong wrote:
> Document the PCIe Controller on the SM8650 platform by using the
> SM8550 bindings as a fallback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Please ignore this resend, I forgot to add reviews.

Thanks,
Neil

> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..af537732ded6 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -41,6 +41,10 @@ properties:
>             - qcom,pcie-sm8450-pcie0
>             - qcom,pcie-sm8450-pcie1
>             - qcom,pcie-sm8550
> +      - items:
> +          - enum:
> +              - qcom,pcie-sm8650
> +          - const: qcom,pcie-sm8550
>         - items:
>             - const: qcom,pcie-msm8998
>             - const: qcom,pcie-msm8996
> 
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-pcie-56e90536c258
> 
> Best regards,

