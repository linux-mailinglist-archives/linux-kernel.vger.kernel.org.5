Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9A79D73F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbjILRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjILRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:09:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A510D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:09:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-403004a96eeso38918455e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694538559; x=1695143359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uD1Ca+RUYioup923VGezU5fchcg9QSe17tPdEKx+0kY=;
        b=BFghJfmFnpzFk1kb10LFYgled4HAef1PH/4hddXSNV5X06UKp9PUpGS0t/H4fmePQk
         rSzRWgYFYJyMUYaCuOqdCJgXYGMu3LUk0NWMWREtqbLNSIovx3yC98eODxR0tDJcFoMq
         /WH782S+QO2q0RgSSrvQU8FG6l9p6TV3R0Ur9nNKjzpygZVD2alVQ+Bn+/B7y3B+Yw6M
         MpSOG15xSS7zAvMkzDwo5zhkkKQgfwwa7+Nwj1UMxyZAjjkJtj5sMnHAhPty3fdF0AoY
         f/b9IozzTwYxapKcw4+d3TWSPZP2CXjz2Iu7+gjDapwZzbjGIhi3sqH59moYsLOmIRMW
         fO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538559; x=1695143359;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uD1Ca+RUYioup923VGezU5fchcg9QSe17tPdEKx+0kY=;
        b=C51PaVpsGv2svPm8fH69V24SMS/715BO9X5zfvnEJoP8GNm4f6Jr6Gm43J54BA1bCY
         /zh9kb6pKYEgGYtNxCdEEEA414DrYE3i68seK48BNMP9LOO52fF3kz046EbVuJjQIXXz
         iY/bTWwbqv91/TNQDatSQAcVsx0LAbEUQQkEsleKOk1brO/lbRdxIHV4fp1Vc5vW8p9D
         Qy795U6R2b7uJCu3cOmifWrx+f5wbwtR1a6D9/K+O5+1hjo+eJJZD3YloCl34wMrUSGU
         JJbD0hVf7fPy0EfpeDK2oboYUbPI5Ii6p9yi7mXNdvuLoWjJzHQbZkfpB86sNvrxJJf6
         Tj7A==
X-Gm-Message-State: AOJu0YypEmYu5Z3Ix4eu91OGpm7AFWFHGmk7VKaj5okPCNQ0JOsjCuYa
        LRKsDI3PiG037mZs+lsql7j5og==
X-Google-Smtp-Source: AGHT+IEuHBXQsXDgEW9jCvnkx8iHXnH3kKixmS4a4dQCHPoxVkRWnnp+dMgVQhQGCe0yUGRkXG2plg==
X-Received: by 2002:a5d:68d1:0:b0:319:8dcf:5c0f with SMTP id p17-20020a5d68d1000000b003198dcf5c0fmr112298wrw.16.1694538559092;
        Tue, 12 Sep 2023 10:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ece0:7069:fcbc:d9f9? ([2a01:e0a:982:cbb0:ece0:7069:fcbc:d9f9])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc84a000000b003fee0741b8csm16655198wml.23.2023.09.12.10.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 10:09:18 -0700 (PDT)
Message-ID: <3bbfa2b1-4e2f-4c96-9f85-652e8fe08160@linaro.org>
Date:   Tue, 12 Sep 2023 19:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sm8450: Add missing interconnect
 paths to USB HC
Content-Language: en-US, fr
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230602062016.1883171-1-abel.vesa@linaro.org>
 <20230602062016.1883171-6-abel.vesa@linaro.org>
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
In-Reply-To: <20230602062016.1883171-6-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/06/2023 08:20, Abel Vesa wrote:
> The USB HC node is missing the interconnect paths, so add them.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> 
> Changes since v1:
>   * Added Konrad's R-b tag
> 
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 11560ec9f182..5cd7296c7660 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -4306,6 +4306,10 @@ usb_1: usb@a6f8800 {
>   
>   			resets = <&gcc GCC_USB30_PRIM_BCR>;
>   
> +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>   			usb_1_dwc3: usb@a600000 {
>   				compatible = "snps,dwc3";
>   				reg = <0 0x0a600000 0 0xcd00>;

Since this commit, this happens on hdk8450:
[    0.280395] usb30_prim_gdsc status stuck at 'off'


# bad: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
# good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
git bisect start 'v6.5' 'v6.4'
# good: [b775d6c5859affe00527cbe74263de05cfe6b9f9] Merge tag 'mips_6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good b775d6c5859affe00527cbe74263de05cfe6b9f9
# bad: [56cbceab928d7ac3702de172ff8dcc1da2a6aaeb] Merge tag 'usb-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad 56cbceab928d7ac3702de172ff8dcc1da2a6aaeb
# bad: [b30d7a77c53ec04a6d94683d7680ec406b7f3ac8] Merge tag 'perf-tools-for-v6.5-1-2023-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next
git bisect bad b30d7a77c53ec04a6d94683d7680ec406b7f3ac8
# bad: [313c22bb31953c5ac7f3be94279126307dd5865c] Merge tag 'arm-soc/for-6.5/devicetree' of https://github.com/Broadcom/stblinux into soc/dt
git bisect bad 313c22bb31953c5ac7f3be94279126307dd5865c
# good: [60c2f542a7ada6bce82ce8e9d50e05eea74fe472] Merge tag 'qcom-arm64-for-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
git bisect good 60c2f542a7ada6bce82ce8e9d50e05eea74fe472
# good: [af3c684721cf69ff662c53a58f02261fa2f8efbe] Merge tag 'ti-k3-dt-for-v6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
git bisect good af3c684721cf69ff662c53a58f02261fa2f8efbe
# bad: [f07c96511d00138171130d43a50a377489cd87de] Merge tag 'v6.4-next-dts32' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into soc/dt
git bisect bad f07c96511d00138171130d43a50a377489cd87de
# good: [abc49a7c6035c57ece0642811f70a7a3892badb6] dt-bindings: arm: qcom: Add Samsung Galaxy Express
git bisect good abc49a7c6035c57ece0642811f70a7a3892badb6
# bad: [e47a7f571d57d383f345e85c47a05ef1801b278c] arm64: dts: qcom: sm8250: rename labels for DSI nodes
git bisect bad e47a7f571d57d383f345e85c47a05ef1801b278c
# bad: [add687cbfc3482ca74949b91b251e76792d25652] dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 family
git bisect bad add687cbfc3482ca74949b91b251e76792d25652
# good: [fd62fd1cf9e7fb7ef761e411d37cb5d06769954b] arm64: dts: qcom: sm8250: Add missing interconnect paths to USB HCs
git bisect good fd62fd1cf9e7fb7ef761e411d37cb5d06769954b
# bad: [90c8c4eb4bbb5e2e241fd5286bd43dd30a850b9d] arm64: dts: qcom: qdu1000: Add SDHCI node
git bisect bad 90c8c4eb4bbb5e2e241fd5286bd43dd30a850b9d
# bad: [b5b0649d5be4c82d09489492c121a7823323fc4a] arm64: dts: qcom: sm8450: Add missing interconnect paths to USB HC
git bisect bad b5b0649d5be4c82d09489492c121a7823323fc4a
# good: [8b51dc863baf1447e9ab52411c5bed7ef9a56d80] arm64: dts: qcom: sm8350: Add missing interconnect paths to USB HCs
git bisect good 8b51dc863baf1447e9ab52411c5bed7ef9a56d80
# first bad commit: [b5b0649d5be4c82d09489492c121a7823323fc4a] arm64: dts: qcom: sm8450: Add missing interconnect paths to USB HC

Neil
