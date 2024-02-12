Return-Path: <linux-kernel+bounces-62093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46481851B59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B217AB2601E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA663D994;
	Mon, 12 Feb 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KW9yYVlc"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1F3D998
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758790; cv=none; b=ViDxXosb9+sdf/7E/ulE4b7lgSPQ8CHZH7sj3EdtI96DGvLXL/yqWRFJRru9wmd4ubiopDxurKuL4xAsWLV4/nqDrxPgF3hRaOPVIefy4h9TFVoj9Pm47Bv1CooBwx9hM5exYr5FGiJYRPxHi+PcdEYAwLW4tjfvA/eWv3wMKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758790; c=relaxed/simple;
	bh=zBRQ2L3YSqKZCX6QoGtUVNjjBN/0fESkwN55NmvyBrc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=epT0fQkmoe2Mr/UURJsdlDjN0N6InbUbulUIAbu+xTUMID+fPykCl82s45CWZVGl0BJ95Fgj9nPE7wwFQeRHgbES8BjnjyID4IZwz7EXoz7BFGcgk9Jo8CcF0mi44qJtvJiDmf7foOTDMPZN2y1Wg4BCWhEFC2cWArilH98y5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KW9yYVlc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4116650a345so5067935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707758786; x=1708363586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qTYop8QJp36+jtIGblbi7k/WDzukfUFb0T7VOK2lcU=;
        b=KW9yYVlciCU4sAD+p+Z47yEQ0QmsOldtnq2DpSRyY9pkV40IfmEBmy/L5u7agnP0PN
         Qi1ja4Tzwdp1AwS+PgkQmYYDpRc9uZd5KH2BWFdpahjWwukZTrWplT7Np/pYQ5X4KJ1g
         ynflWJ0/mM7qRSN9fDIwFVfblvIZxkj03XaUHd8HJtVSGhZ5m6jbUmxrO7RMTI1A8pTX
         ZGghWeRij179YUd7GW1RexbSd6U7/45Y18zFr9vZbF0l2nPYp8hGkV+PAJisc7jFRUG9
         7AQ3yf3NaAu9WIEIjmOCd7FhalMVfmoYzrwCG6vw42Mv35auRZLNiTkGNIPvcrE8FNeD
         Sx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758786; x=1708363586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qTYop8QJp36+jtIGblbi7k/WDzukfUFb0T7VOK2lcU=;
        b=p52bliCDrFTQ7Fy5NHzuKgIH3MAiD6v6iTwVc9UZBVdjQ2+KnnI9LQtSEpOcljJ1QY
         aur5HiZKdQ9YPna0YpkhftRPiXnsiScR8+7jrAiLX0WOeIippix+5XLJu0ZkOHCRPniH
         VqWMwYWBLU3EgG1EjBmXLE0q9tIlOEkg8yxUPmTdWjSKAg3/JIEdh1RS1VRIizrnq6g1
         /wjevDo1z4pVb1pri89Na+9e8gIMyDCmQPj2QWbYthnSQ3pmvW3zFVFBx/fnsXFQJaeO
         RsIWLW4gm7YQopf8NaLVEf/7Cp+gmPGMEoPeHCQMd96BUXocnCl7lJ8hKImjQTqrlbtj
         VopQ==
X-Gm-Message-State: AOJu0YzaZTzDQT1Qtax9/TpnYuN809NX3knvS9wRXyRFmdXM1esE12Wn
	A2+bROGZfBpe1NeHeNSyINEyRz2haMX21sPYRqc6tEBXKYkDvWjbCTCW4Jl9hAI=
X-Google-Smtp-Source: AGHT+IFg0NVPNFM5l0rC92f6lBNwnb2GJ+wbCi1upTvwnBA2YxnXHVtsK9iZZAP6HRMoOFnFFV1yyw==
X-Received: by 2002:adf:f709:0:b0:33b:640c:a7d2 with SMTP id r9-20020adff709000000b0033b640ca7d2mr5390324wrp.24.1707758786633;
        Mon, 12 Feb 2024 09:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvbjdJf7EnWY5OfIXA6faJ7b6TknrkFAmcqH3a7ILu+FC3dnOIKbNffShVRrSxo8p0tugA49APOWnKdJ/7kBIkftUwKsdYD7+LsGYVwgkE/ook6qdruSBqCLj1NuccDmWDxfAWMHycjuYDHy9+saDE3rkq5Z1xywcvXr0hbJqnqe/yPhTgrIGz/BhG8guIp5q14zoAAstrUiTE86b01ZxOKheJGdFn/aGzWZmvB/P/zQQchFi1Tppl/FE+Hg4oyTWNb9usojjxcHl0aMbtJJbR3c+quFStM2LGX511kwhKIk9IGyXQsq/gyhv62POQJmfd/nZjLNNLWVgwmfp9q3U9NLaneyNxFLFYpLCQhy/u2wY7g2MdxPY3iTMlMa5IGKSqaPVjP5nFHZhlVCfYpA/5XXaan/Hqpj/G1Kn+0d0xCMb96mrc0AY8gRTVsEipnawPS9mhnU/moFved7XtHZincYEZHw4OFmibBljFK/8IjJdN4PZoSNTlIYXqGHeoHpJjvvn9F7SSSW3cy0KsKa/z+K6L+lVlUpF6RWDvikyTTqzTwUHEPIovkBjZVT7rSdH5/bNFeVfA/j3OvuVGVC8xZUq74iZw/koEyH+Rlx6SfNLbHQe/LVfhVqwcFzG3Wf0C5wrQULE6hzgflcICX+YPheKN/HHcdGlXIQdWW1EqSXMMKdccdBlI5dkKcwPxnpPhDndstWTqgffNL27Kjz9yPEYrL1blUOOkYHQAcpFSYtEd02ZPmWTXQWE8evboKOZ3EgLPufzr9eoO2K0c2bds0Jfhsk4NuH75n1YHpg9BYvRt3j72DZFjAA==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id k14-20020a056000004e00b0033afc81fc00sm7266685wrx.41.2024.02.12.09.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:26:26 -0800 (PST)
Message-ID: <05e6f92c-388c-4bc6-a4cd-e9d981166d1c@linaro.org>
Date: Mon, 12 Feb 2024 18:26:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: Add SM8550 Xperia 1 V
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
 <20240210-topic-1v-v1-7-fda0db38e29b@linaro.org>
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
In-Reply-To: <20240210-topic-1v-v1-7-fda0db38e29b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:10, Konrad Dybcio wrote:
> Add support for Sony Xperia 1 V, a.k.a PDX234. This device is a part
> of the SoMC SM8550 Yodo platform.
> 
> This commit brings support for:
> * Remoteprocs (sans modem for now)
> * Flash LED (the notification LED is gone :((((()
> * SD Card
> * USB (*including SuperSpeed*) + PMIC_GLINK (it's funky, requires a replug
>    with an cable flip sometimes..)
> * Most regulators
> * Part of I2C-connected peripherals (notably no touch due to a
> driver bug)
> * PCIe0 (PCIe1 is unused)
> 
> Do note display via simplefb is not supported, as the display is blanked
> upon exiting XBL.
> 
> To create a working boot image, you need to run:
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8550-sony-xperia-\
> yodo-pdx234.dtb > .Image.gz-dtb
> 
> mkbootimg \
> --kernel .Image.gz-dtb \
> --ramdisk some_initrd.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline "SOME_CMDLINE" \
> --dtb_offset 0x1f00000 \
> --header_version 2 \
> -o boot.img-sony-xperia-pdx234
> 
> Then, you need to flash it on the device and get rid of all the
> vendor_boot/dtbo mess:
> 
> // You have to either pull vbmeta{"","_system"} from
> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
> fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
> fastboot --disable-verity --disable-verification flash vbmeta_system \
> vbmeta_system.img
> 
> fastboot flash boot boot.img-sony-xperia-pdx234
> fastboot erase vendor_boot
> fastboot erase recovery
> fastboot flash dtbo emptydtbo.img
> fastboot erase init_boot // ? I don't remember if it's necessary, sorry
> fastboot continue
> 
> Where emptydtbo.img is a tiny file that consists of 2 bytes (all zeroes), doing
> a "fastboot erase" won't cut it, the bootloader will go crazy and things will
> fall apart when it tries to overlay random bytes from an empty partition onto a
> perfectly good appended DTB.


DTBc check reports:
arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property
        from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#

So you'll probably need:
&pcie_1_phy_aux_clk {
	status = "disabled";
};

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>   .../dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts    | 779 +++++++++++++++++++++
>   2 files changed, 780 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f7c5662213e4..9bbea531660d 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -237,6 +237,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-sony-xperia-yodo-pdx234.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
> new file mode 100644
> index 000000000000..85e0d3d66e16
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
> @@ -0,0 +1,779 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/firmware/qcom,scm.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/cs35l45.h>
> +#include "sm8550.dtsi"
> +#include "pm8010.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550b.dtsi"
> +#define PMK8550VE_SID 5
> +#include "pm8550ve.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +/* TODO: Only one SID of PMR735D seems accessible? */


What's reported by the cpuinfo pmic array  ?

<snip>

With the pcie thing fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

