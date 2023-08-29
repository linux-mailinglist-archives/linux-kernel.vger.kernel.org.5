Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6578C194
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjH2JeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjH2Jdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:33:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F937CC5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:33:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so37591345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693301617; x=1693906417;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmXmTeZOGSI3b5lA5oPEysnY4x8I3eOzPsGVTbbhx+k=;
        b=ew/e3E1nAbXC6pxsHVO/PfkUXwe88ot+GAtFeOUlwFHFBDYDQdeqebXeObxxxVuiJh
         NuvJSiLDwbieixJkaWEKjahxwIbscBkmp3QojYMwlKPQOA0xyzCh3eoyZ5a6bst09NQS
         YFt2EwVr4WtYcrINE1XkzijK11x/JDRs5J0o7prfmhJZ9ZPw19DwzAGZ9fsllr3049jc
         gFG86GYBASdNyfrlbXomTZjc1uXsMxYstTvTtlu6Ux+LKax/ZVcIOfBE1+gjowm8LwYa
         mGnJ3MvQu/JrYqqJXDECQH609bviaO28wrZ5SeezRSrbWlH690OifUTQMMTSeCF6KyR0
         DfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301617; x=1693906417;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LmXmTeZOGSI3b5lA5oPEysnY4x8I3eOzPsGVTbbhx+k=;
        b=E7aGtvr5yNYolM2Px1lNYUfMOgTJuVum37jxEMyPyxLIBWUeMvXjyTPKaWo5U7vy9m
         K0RcrpoR1/J3czPktk/yFmBVG6yw7Cu3f8uz2jQ2yzw7LIYiCuXic2ypQOoLDdm11aAz
         K/d54kXlkGWzgYkYg1cAPejiVXAAmSsKP9Gw2Ts+Hv1HtpH6/tEK2nt9kIkcNx5hKTtz
         7ZtMEW3v6i2hDmlxaW6QZ48DAnRVJPo3fTF4RDt0g5vNiNJGYucDl6BKy1bidPufgqcw
         ITLX1YjPfXJoEhOaU8CHcIdZTNboqMpH5c+1VMzqFH8LWCYfZk8vtwYWPb3H07v6Wj0s
         xoLg==
X-Gm-Message-State: AOJu0YxsJVNeR2ABa8s4zovU/LO/w408XHDo14N6QFW1gImTz0xtYslK
        4LoLu5Bb/7fPpSEbSCRyZZdOmPS5odux5Pji3hTnxGtr
X-Google-Smtp-Source: AGHT+IEjklv9yGkm+ZkRAY9Czgg5ihM5Zol4gXQcQJLXuPh1jWTr21hSInQPihNYZxA7H2l0CP+AXg==
X-Received: by 2002:a7b:cd98:0:b0:401:6800:703c with SMTP id y24-20020a7bcd98000000b004016800703cmr10787045wmj.21.1693301616898;
        Tue, 29 Aug 2023 02:33:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8fd:3f8e:51f:e4f9? ([2a01:e0a:982:cbb0:c8fd:3f8e:51f:e4f9])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b003fbb25da65bsm13394169wmi.30.2023.08.29.02.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:33:36 -0700 (PDT)
Message-ID: <88747080-238d-4498-8ad2-370091e1f681@linaro.org>
Date:   Tue, 29 Aug 2023 11:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8150: extend the size of the
 PDC resource
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230829092119.1017194-1-dmitry.baryshkov@linaro.org>
 <20230829092119.1017194-3-dmitry.baryshkov@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20230829092119.1017194-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 11:21, Dmitry Baryshkov wrote:
> Follow the example of other platforms and extend the PDC resource region
> to 0x30000, so that the PDC driver can read the PDC_VERSION register.
> 
> Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 380712aee977..38c5d6dbd0d7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3923,7 +3923,7 @@ dispcc: clock-controller@af00000 {
>   
>   		pdc: interrupt-controller@b220000 {
>   			compatible = "qcom,sm8150-pdc", "qcom,pdc";
> -			reg = <0 0x0b220000 0 0x400>;
> +			reg = <0 0x0b220000 0 0x30000>;
>   			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
>   					  <125 63 1>;
>   			#interrupt-cells = <2>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
