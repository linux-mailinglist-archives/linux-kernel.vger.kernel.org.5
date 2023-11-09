Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E057E6628
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKIJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:04:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DE182
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:04:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084095722aso4045615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520685; x=1700125485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHnsQJ4XpMcktv/vRmuqIsVKlG0FfHcOCkAwJxWxXr4=;
        b=g/4vlLj2a7YW+1lZtF0N8VfhS0qioy3cTo0hblIRlUKdpVRSN1Waz+5BLIZx5U6ZmL
         C+0pFj3xGLqHnhlN5mYZvsqzxbc5mrz5rQIv0Ifc2TvNtq1LCOA246nSrcuuk9DIf5Il
         k0QgegpQ9NS476Q+SrUPl5S4qBp4mNZ61Q3v6Dhq066g3z+HORM3+hdDXFJVHwzDEahN
         d1YHXLDTXLoD6Lp8/g2209DKizg/YJeVT497f/U7gNBGpy6//6dzQ1ASvgvc4GGQXC8t
         mpvfetFJuQZROMmpU2JpL9v5Qv+VhVhcaKnUmGVM3t8UMQFwD1dL8R18RqdWiiXyi64b
         98Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520685; x=1700125485;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHnsQJ4XpMcktv/vRmuqIsVKlG0FfHcOCkAwJxWxXr4=;
        b=I24XXalORAhg1D4A/TaDIug735Po8kRHnl4QchkUejv4nze1PBV9c+KdrHwAO7lrzG
         uKpmeTg6kcDCnaD1XUvVTL8xdHbYv+zUuXohfWPNwo6xf6nJfyYNFU4wlY5zEJtMtrGV
         1NZa6zkC7khbwVplX+sJgE2ZZ7vZto5PpQcTU/PHen/jwcSZSNbgnQXm6czyd4oETviw
         bTq3CgjfeDf757HonXNn7K6WM3GGdCN42pzG9JChNdnMqkLo4CmtqKIYLRG0SzcdDU/l
         Mlhf+Ve4IIXlhpi1SZLEOvjSiQkdCe+Sgh4xTwcnvcJPKShVOgAh2UZJjmV/8el9sPCz
         wXaA==
X-Gm-Message-State: AOJu0Yy7ylNoscBkCedLgUct+c1T5X0+IT/RNTPIiyt0CGPC2ahl36Ez
        Nd8Ll3UJYDEpq+FGmKd+ZwBFRQ==
X-Google-Smtp-Source: AGHT+IG9gxOA4nD09dUm9a8mKZ++Oynr0aMFBrRI4R7rg4AWkBMr5Cz3hYVKfYWan2oKPYH73FN18g==
X-Received: by 2002:a05:600c:3513:b0:405:82c0:d9f3 with SMTP id h19-20020a05600c351300b0040582c0d9f3mr4018331wmq.30.1699520685274;
        Thu, 09 Nov 2023 01:04:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f4c:8054:506f:f04b? ([2a01:e0a:982:cbb0:8f4c:8054:506f:f04b])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b003fe1fe56202sm1409881wmf.33.2023.11.09.01.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 01:04:44 -0800 (PST)
Message-ID: <1468df75-3094-425b-b940-5c8297bd4067@linaro.org>
Date:   Thu, 9 Nov 2023 10:04:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V3 3/3] arm64: dts: Add watchdog node for Amlogic S4 SoCs
Content-Language: en-US, fr
To:     Huqiang Qin <huqiang.qin@amlogic.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231027104358.342861-1-huqiang.qin@amlogic.com>
 <20231027104358.342861-4-huqiang.qin@amlogic.com>
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
In-Reply-To: <20231027104358.342861-4-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 12:43, Huqiang Qin wrote:
> Add watchdog device.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index e0cfc54ebccb..2344b2d741c3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -92,6 +92,12 @@ apb4: bus@fe000000 {
>   			#size-cells = <2>;
>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>   
> +			watchdog@2100 {
> +				compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
> +				reg = <0x0 0x2100 0x0 0x10>;
> +				clocks = <&xtal>;
> +			};
> +
>   			periphs_pinctrl: pinctrl@4000 {
>   				compatible = "amlogic,meson-s4-periphs-pinctrl";
>   				#address-cells = <2>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
