Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1E7E38F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjKGKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjKGKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:22:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6676B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:22:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso3302351f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699352557; x=1699957357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgkD9KjMbIvHP7PFDUS1/DyjvRf195jIz+HKg6SOAiY=;
        b=gWniZRjKIWhDEbvEAa2a7p1iXIXriugSmAA8HVu7J50a8/lwUi+s+ntMEnF2sdanXb
         LSp3K+i6Mr8dLpaqa8e9jkuPzCSgPpswyxVxVSly+SNqpAtRkCOHdH5xg3lNjiMjjLmi
         tm7pTLBzUZQzNuB70TSHMVrzu2ZPqsmqu776tCQZcU9ne/CAkQ9DayU2mcIr0IBZF4xx
         7iMF5ssrh25+NnCpycwKmGdsnWn9CczvsTB5tYsoLb1Awk6JtBPLQKl5kco42OTdxurN
         oXGKum0QTljP+Opf6KXZVEtjqIkhdvB6uRxpAT6z2jOgZ0m8S+/VgjIyqo6mPjIB8H7O
         Bseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699352557; x=1699957357;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GgkD9KjMbIvHP7PFDUS1/DyjvRf195jIz+HKg6SOAiY=;
        b=h17mVww6/WAkULZHnQ0zVDRDuNc5o2hPg8ldNwj7MM7LJCmSRNW7gUh2MFwwuwxvRE
         DauXgawiUNbQjdImoRTBWYzmrVdO9NEZpwiY1v5Zss4dvv2em093K7Z40Y3j6XXRgQCS
         VNTfvyHkwT6V1KhUgGoSaNL7rD0UQv6x2/E6his0toxZ+6MDrXkyQ7G1jAk8Q9AyX11k
         5dQYKqGLXmi9frxNBifJAhy77nDTgMqGcgXn9XefROYEgqr3ZpcrojU8RTx7IjOZ5HMo
         KEVJMcQ3GAn++5Ycvi+4Ae3npcuZ4VDdzcEMGQCx0NtS1I6HEEpZp9XieY76dHQwiU3L
         ln6A==
X-Gm-Message-State: AOJu0Yze0YPxBInFYdp2ka1Z4LgPAvTMdGFtW74dxdYON/+sqmYNIV0g
        lvUL6VU0F99UXD/+YU3cIRRSh97M2wVwPZyxVTOydKB9
X-Google-Smtp-Source: AGHT+IHX1Htx26C++tit9H0PRrvll/evX0tLA8Aiw2TOuvNVmhuEB1lzoPVQN2P1XXr4eJGaOJMyMg==
X-Received: by 2002:a5d:4950:0:b0:32d:a8bd:332a with SMTP id r16-20020a5d4950000000b0032da8bd332amr22903039wrs.30.1699352557094;
        Tue, 07 Nov 2023 02:22:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a5d:8c92:1477:cee7? ([2a01:e0a:982:cbb0:2a5d:8c92:1477:cee7])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4406000000b003196b1bb528sm1924781wrq.64.2023.11.07.02.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 02:22:36 -0800 (PST)
Message-ID: <f4256787-5f1e-4d19-9dbc-223504e55cd2@linaro.org>
Date:   Tue, 7 Nov 2023 11:22:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: correct Soundwire node name
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107102111.16465-1-krzysztof.kozlowski@linaro.org>
 <20231107102111.16465-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20231107102111.16465-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 11:21, Krzysztof Kozlowski wrote:
> Soundwire Devicetree bindings expect the Soundwire controller device
> node to be named just "soundwire":
> 
>    sm8250-xiaomi-elish-boe.dtb: soundwire-controller@3250000: $nodename:0: 'soundwire-controller@3250000' does not match '^soundwire(@.*)?$'
> 
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index da71de5e1a80..e18a18a9e767 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2557,7 +2557,7 @@ wsamacro: codec@3240000 {
>   			status = "disabled";
>   		};
>   
> -		swr0: soundwire-controller@3250000 {
> +		swr0: soundwire@3250000 {
>   			reg = <0 0x03250000 0 0x2000>;
>   			compatible = "qcom,soundwire-v1.5.1";
>   			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2623,7 +2623,7 @@ rxmacro: rxmacro@3200000 {
>   			#sound-dai-cells = <1>;
>   		};
>   
> -		swr1: soundwire-controller@3210000 {
> +		swr1: soundwire@3210000 {
>   			reg = <0 0x03210000 0 0x2000>;
>   			compatible = "qcom,soundwire-v1.5.1";
>   			status = "disabled";
> @@ -2670,7 +2670,7 @@ txmacro: txmacro@3220000 {
>   		};
>   
>   		/* tx macro */
> -		swr2: soundwire-controller@3230000 {
> +		swr2: soundwire@3230000 {
>   			reg = <0 0x03230000 0 0x2000>;
>   			compatible = "qcom,soundwire-v1.5.1";
>   			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
