Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C366779FE58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjINI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjINI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:28:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA51FD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:28:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so609480f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694680096; x=1695284896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHW5r8LR+WAyIi5BD2PrwXnZMmsz7ZEjh1uFnYSDxlE=;
        b=twW7rwwGzQm2BvZQHwntEXdU8qKmJUrUeZWasXxgZIgSH/cLZvMckmnVBKaTXOpJpM
         dfIBXEB3M1ZUK3bldc2wF4/m8/0PuvVQVn8lSsl16L2kCmP7uxfcB6gJ1yBYI7V1+BtN
         jVbJXYFfLubC1vxuZoInx4/O/kmBKQu3am8EeIpT6ReKJ1F2QCWckDCOUiwmVMplFvh8
         QdeQdXbCScBQ34hhAJBN+A4Demf+pOql/XU72OEYyVyZ+p8ex9z0Tb8XtZqRY17s0fwv
         cSsPxcd06wpUFu47MroXSGmU4lz0yNT6Jkth4USYBQAQlFe7krUnF8LPhntNIvKL+dv2
         e4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680096; x=1695284896;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHW5r8LR+WAyIi5BD2PrwXnZMmsz7ZEjh1uFnYSDxlE=;
        b=ZEi5TBQFfqxHyidQJOVd2Vkxu2sAiarbkU3pMkcqn6LE0ERRtzSLjunTdE2X/A/GMB
         nJ02U71Mbge0mejtHa20K+VlP5lRcioIz8DhjRgvRArOfeJKp9WaUUcphGvvGJ2Qzce6
         nQ4jy3WtM8UvcCy7MGjuB8SBLr8JQuwEHPrB4EIHQXyEuw1K6HrvSkhja/JOp6lNPmHo
         s4zV2THHHJ3BhLs8ZStxbIt0Lk8q3yiKt2IAQ+BqdhPW3bIqWFApkoE6ZK3mcaZt4vyj
         Xoy2cTe9b70BNMDuSrqqbootJZvGHy0CIret+kilpGfrP4pqoniV9Y2DSeu/NzrUMCTA
         mUAA==
X-Gm-Message-State: AOJu0Yz9PicMLjBnC4ZXpKeRDo6FeFxZQ3sYGb/cZGZSllWsHEDT+qaP
        oJ9845n5jn1CygKPVRsO6ixDhw==
X-Google-Smtp-Source: AGHT+IE4GF+ezJ4C5tBv6gDdM3b8UUoEbEk298f97Goesf+jrwKSkQe1atXr0Y20EjzVrjz/XkE62Q==
X-Received: by 2002:a5d:5610:0:b0:315:a043:5e0a with SMTP id l16-20020a5d5610000000b00315a0435e0amr3811773wrv.56.1694680096456;
        Thu, 14 Sep 2023 01:28:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494? ([2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003141a3c4353sm1091493wrn.30.2023.09.14.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:28:15 -0700 (PDT)
Message-ID: <96f5caac-c717-4cbc-a9c4-8708eb4327e5@linaro.org>
Date:   Thu, 14 Sep 2023 10:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 3/3] arm64: dts: amlogic: add reset controller for
 Amlogic C3 SoC
Content-Language: en-US, fr
To:     zelong dong <zelong.dong@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        yonghui.yu@amlogic.com, kelvin.zhang@amlogic.com,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
References: <20230914064018.18790-1-zelong.dong@amlogic.com>
 <20230914064018.18790-4-zelong.dong@amlogic.com>
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
In-Reply-To: <20230914064018.18790-4-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 08:40, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add the reset controller device of Amlogic C3 SoC family
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index 998f5050795c..d086bfab3228 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -6,6 +6,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/reset/amlogic,c3-reset.h>
>   
>   / {
>   	cpus {
> @@ -81,6 +82,12 @@ apb4: bus@fe000000 {
>   			#size-cells = <2>;
>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>   
> +			reset: reset-controller@2000 {
> +				compatible = "amlogic,c3-reset";
> +				reg = <0x0 0x2000 0x0 0x98>;
> +				#reset-cells = <1>;
> +			};
> +
>   			periphs_pinctrl: pinctrl@4000 {
>   				compatible = "amlogic,c3-periphs-pinctrl";
>   				#address-cells = <2>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
