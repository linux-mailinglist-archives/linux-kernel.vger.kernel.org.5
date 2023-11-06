Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0B7E1D28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjKFJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:26:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44141E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:26:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084095722aso32830455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699262808; x=1699867608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNMrL//ufF3IVIJkNoygI3qKns7bPW7N2J4mliKhUow=;
        b=z6GZrXXuoHlEU6KQujMHJ+GN2t6vPm2Ehh6OVbw3G9o/sEbctRUbV64xQsEaKw+Fmy
         lGA1hKitq2UT9EeRNgNiXM5cDSpuF/l9YEEjMumrvairsLmrMPHkGf8DT6z7sa2QJD+5
         wdBEEK16nbGWxbXPdsV+ef/8S9Q6J78Mo8lBSPyCpai3Qa5pUXKna4mfqVSazuhnY1h2
         JsWruc1wnz0SbJJcfoep8RQfj7WhPuRFBKiQHW6RMPhTSaSwbN+3jSBO+PgMZmVA0SaJ
         2K2Scc7fAyn+HrHsVP0mhuDi3JRo7ojeDRsvq29hxCDCDs3HmdqcOdsK/Rgkl9a9iPpj
         p2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699262808; x=1699867608;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNMrL//ufF3IVIJkNoygI3qKns7bPW7N2J4mliKhUow=;
        b=wwCJvk4NqTL9Z61RpMGkj0rspk+yJNk0eqWmsubmmeQIrWyxeMITKYtFU0t+Hcf4wB
         qKmXkcmOzGBVOQD1MGsxAwqBMdK8CnDiS+nQXwP0zgyfPYQZU3eYgbrcx5FIM6TQxEbZ
         UfB7D0tx1s5snAqcKFvV3ddSc9GAt0cUhdXCAcz34wy1MakVTS/ZGKcUxxYG3SQxac/2
         pmRvMMayPKxJkF2sTZhvE1C8LJ3Wd2LfqSp9Q4qcplPzjxQXpFuqV9GQ4YbTv+6YVwNm
         OGVz3M2PK0dOHqfAvpBJgOM7qI4r85CaomE5dBxPHrWLPK5YxXGRUf4JAh4V7NQhsEKs
         XEzA==
X-Gm-Message-State: AOJu0YynHP8woBLGLFw4SpCKcPnEsN3yjb7kBteeLc/ABE7GLnlZ/g4k
        EOpefMKpgLaGzOSpciUDJ9Z+tQ==
X-Google-Smtp-Source: AGHT+IFB5D/MB+A9Df6YvuC5v141ODVPI7Hcwf+eULv+lIgNOuMUDA4MMWb9MgKsjXqWN4qL8ChVgw==
X-Received: by 2002:a05:600c:46d1:b0:405:3a3d:6f53 with SMTP id q17-20020a05600c46d100b004053a3d6f53mr23317637wmo.3.1699262807625;
        Mon, 06 Nov 2023 01:26:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7a54:34e:8001:fb7d? ([2a01:e0a:982:cbb0:7a54:34e:8001:fb7d])
        by smtp.gmail.com with ESMTPSA id je3-20020a05600c1f8300b004083bc9ac90sm11609349wmb.24.2023.11.06.01.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 01:26:47 -0800 (PST)
Message-ID: <569e39a0-b91c-46f1-b55d-c9324d66339b@linaro.org>
Date:   Mon, 6 Nov 2023 10:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND] arm64: dts: VIM3: Set the rates of the clocks for
 the NPU
Content-Language: en-US, fr
To:     Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
References: <20231106092202.11127-1-tomeu@tomeuvizoso.net>
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
In-Reply-To: <20231106092202.11127-1-tomeu@tomeuvizoso.net>
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

On 06/11/2023 10:22, Tomeu Vizoso wrote:
> Otherwise they are left at 24MHz and the NPU runs very slowly.
> 
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index ff68b911b729..9d5eab6595d0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2502,6 +2502,9 @@ npu: npu@ff100000 {
>   		clocks = <&clkc CLKID_NNA_CORE_CLK>,
>   			 <&clkc CLKID_NNA_AXI_CLK>;
>   		clock-names = "core", "bus";
> +		assigned-clocks = <&clkc CLKID_NNA_CORE_CLK>,
> +				  <&clkc CLKID_NNA_AXI_CLK>;
> +		assigned-clock-rates = <800000000>, <800000000>;
>   		resets = <&reset RESET_NNA>;
>   		status = "disabled";
>   	};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
