Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83043786A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjHXIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjHXIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:32:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F460173F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:32:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fee8af9cb9so42924565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865938; x=1693470738;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0r8DEwY1PL1OuTOZ7tvgpDOHdne9h/bxPfKsrxbUUJk=;
        b=eAVRbdqdZrdGb6bDiWW4/F9weqyJ0Nz65cNPzoubXk4rdR0qVe1c42q4ZrTtf3OcjI
         oMdKSJZrvyKvcFEZa/TXATUVjvErhuDR//+w6bteukoJgGRFP3zKPviDVaXO4rxcUlVV
         QReqllyGSX2iXm2ZFWeWO1Ms6VOF1l5rrb6RQHoK/PJBfKg/C96sIo2kcTV9RCIwdZCq
         J2LTeWh6dKONxrPdXuUbEgMCtGgEbpkalIbT8R1KrDefOikk4crQ3+fXn4la4mZoDIAJ
         CbYJdJ4Xl9kE6iG8dz6/nr1seHKKuGrsjC5AvDohpRmOqpEev47uCuXHCbuZ710GOpPL
         Z3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865938; x=1693470738;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0r8DEwY1PL1OuTOZ7tvgpDOHdne9h/bxPfKsrxbUUJk=;
        b=F5NR1rtan4GsspjqAFJdSv+AciykqbKwIqCrlgCtzc9FJEAVUNbX6vZosDYYWO6STa
         wv+G/AyuZ18t3Bjep8MUQDzegqiwqfziNJRXMfpxriHLSl9e7yTD//rfE0oZf2+z8Tg7
         kULEJXJleeAsBc2x34bzX0AcCj6+7pL0H7WipOIanSBMi76dfuO1K88HY9yc/StmIJ6b
         sF1zbmyO2r/wiaUwISTfHtZ8f0tj9Ylj1JXczM4Om8dYeFFJLOG/W0uNffH2fI+ewDAg
         fDE/+r0f5wC2feWDd3v8oJAZ0/3A9Bf6f8ChJbtqroKwDVuj1jE9MWfo1x7FX355XTkX
         CFgw==
X-Gm-Message-State: AOJu0YxT+1yZ9Aps2lfiKHNm41h3ecQjhmTQ+yU/yutu1ZyqAREC9GGB
        Fml/qaSpl8naU1uzANARBbGrzQ==
X-Google-Smtp-Source: AGHT+IH1VcA2QnzPPWLkTP9JwJh+JjblnSC6qFKnGsaiLGfaw8iIz/QaQELIAMpS5KBRBEwImagIgg==
X-Received: by 2002:a1c:770f:0:b0:3fa:96ad:5d2e with SMTP id t15-20020a1c770f000000b003fa96ad5d2emr11438461wmi.19.1692865938371;
        Thu, 24 Aug 2023 01:32:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b? ([2a01:e0a:982:cbb0:e6d5:d4d4:f3a1:e44b])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c22d600b003fbd9e390e1sm1907393wmg.47.2023.08.24.01.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:32:17 -0700 (PDT)
Message-ID: <27e55b16-065b-4a16-ab05-dded04f2c705@linaro.org>
Date:   Thu, 24 Aug 2023 10:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 6/6] arm64: dts: add support for T7 power domain
 controller
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-7-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20230824055930.2576849-7-xianwei.zhao@amlogic.com>
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

On 24/08/2023 07:59, Xianwei Zhao wrote:
> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
> 
> Enable power domain controller for Amlogic T7 SoC
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: None
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 1423d4a79156..23cdad1b425b 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/amlogic,t7-pwrc.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -118,6 +119,11 @@ psci {
>   
>   	sm: secure-monitor {
>   		compatible = "amlogic,meson-gxbb-sm";
> +
> +		pwrc: power-controller {
> +			compatible = "amlogic,t7-pwrc";
> +			#power-domain-cells = <1>;
> +		};
>   	};
>   
>   	soc {

Please change the subject to:
arm64: dts: amlogic: t7: add power domain controller node

With that:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
