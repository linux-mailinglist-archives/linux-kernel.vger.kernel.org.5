Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC87FEC49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjK3JyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:54:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ACB19AE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:54:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b474c925bso4505285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701338047; x=1701942847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFnK2W1R2fhcw00BqzFHQ4o1k7qynf7VtO0VZ35BT6I=;
        b=JeH+rs34eKDJrK4HSjaCddAyYFF0L/cQpDuNv+AO0an3MwfJ2nPgxin4Zs7YWpnheN
         bEIZKA5siKq/yI0Xpbee3g9DEkkE6/xk41fKa72VwhpxW4qxxONM8F9GoOHI4TKeLzxb
         ZYWHRzDm3BqrZmd88r3AGmhbG2bAMRvBhwSq4MYWggDDjivyE+ICrrI6mgnNO2HQ0joc
         dlamnsN2MIiQ4TGWoqYRJwEfry+m61UUs1ryC6WkpCBZcVrHcWJqDerf1/GGtDrvYTKW
         Vd5+TupBjhctDYl+/9K2TksZVo4oJqM5Unx1T2NXnK3UupyWcW+rVkZUXZBvvJQxMchq
         z3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338047; x=1701942847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oFnK2W1R2fhcw00BqzFHQ4o1k7qynf7VtO0VZ35BT6I=;
        b=TQSal0A7shY69y+3e3h1qtK+ZjnoHjJUaI7+VG8OJ47xTVkdIb5lw/UxSU+Ot91njv
         P8FAhOsxhGJJwQi7dFQ6In+wbbx1IZ050ZsZLfxt4tTE7zWxlkzb/97WdUwE2vc3Wj/U
         hIKn/HXYblqQ1tIx/CZNYaquEiZ66jUnRdbmaNP9oIyiW88Q2aKzUJ74Txi3H5vg7CfV
         KpmUDqYTEjHJ20hnWUfXJR6MpHMda5q8EPGmAmhJBhLiRV5YZke8WlBnW1tf8D5RX78U
         nh4rRQBerMvVx2YNDv4kke8N+lFyGzzGbzqZs6itJd3W9+Dz2K2BpckdA2IQwOh8gvo3
         266A==
X-Gm-Message-State: AOJu0YxeVDz1EoayAgNwKtcKaZuear31yPmIV61QZO97ncimwxmCZVlT
        uyKWuDPy2NDrY3Qt+pjEw6YQAA==
X-Google-Smtp-Source: AGHT+IERbAR5kCEXoFWKv930fgPayDnjMttXIi85mFVhsgzWECqO8UigNd0v3U/lwOMValdiRaGRQA==
X-Received: by 2002:a05:600c:1c1c:b0:40b:37eb:900c with SMTP id j28-20020a05600c1c1c00b0040b37eb900cmr13788686wms.6.1701338046906;
        Thu, 30 Nov 2023 01:54:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b0040b478da760sm1358964wms.48.2023.11.30.01.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:54:06 -0800 (PST)
Message-ID: <690b7dbd-3165-4aa5-af85-1a1eaa12d176@linaro.org>
Date:   Thu, 30 Nov 2023 10:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
 <20231127-topic-a7xx_dt-v1-6-a228b8122ebf@linaro.org>
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
In-Reply-To: <20231127-topic-a7xx_dt-v1-6-a228b8122ebf@linaro.org>
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

On 27/11/2023 17:20, Konrad Dybcio wrote:
> Enable the GPU and provide a path for the ZAP blob.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 20153d08edde..a20d5d76af35 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -580,6 +580,14 @@ &dispcc {
>   	status = "okay";
>   };
>   
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		firmware-name = "qcom/sm8450/a730_zap.mbn";
> +	};
> +};
> +
>   &i2c9 {
>   	clock-frequency = <400000>;
>   	status = "okay";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
