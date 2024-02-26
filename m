Return-Path: <linux-kernel+bounces-80617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D4C866A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6261C217BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5871BDCE;
	Mon, 26 Feb 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqdwiVI/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0E1BC40
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931122; cv=none; b=DQXqPr3TKWmcpxtPzQ6Kewi5TvoE579d2zwJhjkfs6gyC5qtYZ1Gs2tMA2xjqaMDAoTmISWeGyysYAlHGjh3Jga4lK1hAlWCbQoTJHDvVark/EWg1rOO+HUv/Z4Y5fuVc8q5xbqImO9UeIBo8pwBDTrRlS9JBUC/3arXzt4fjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931122; c=relaxed/simple;
	bh=nYgb0HWRu8YyT74BAkDx/Un2/2W4bfQcIXn1jyX5dhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZDEDIrkwbFEgbgtIETKGQGa8/xfTvDAfww1P2DR4d9xuQ05HYXsR8QFMWi318uXy0AchnpeLfSD6SFv6IrXLyehsL2nmw2v8jHQpgjRXsnttvV4eE0xOmbT36o5FwVpvai+2oB1GML81JlO1V/00sCk9PTk1JtkhuCQ40GZ/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vqdwiVI/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so4093435a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708931119; x=1709535919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zYlFi0LHJsAlgLIGIcShBABCv/yjhadsmMI/Fg1bJc4=;
        b=vqdwiVI/1DJk7LGizjcFH5cs6ouJiV9eMSTxMDadht7qUSLjsgiN5hdNykkihzzx+d
         lu2kERgqS5s5TnQd/1JhcF7IZUxLSGf5/u2Mvuh6jh4/PkXVaJbNiYhMgfb47ztR5+2d
         etdb81nLd6C22nb/hfFJO8rVYFRAeg2TC4N4IDsdQzSYNaSm6Q7ZyuCi0jEEyzuGzOgj
         MtA3MM4VLR1x6j6kRRL5RK4rFBgHJzmTkqepKFjyHcdAPW1mx6LNDWj16OGy4DHYvIfJ
         mo8LvXCDLtIGztiEYgKQDU1HYrI3Ir3vrn06OCVqbxTaZvPtP1wOjVBFQpveZdVbn6GV
         XDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708931119; x=1709535919;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYlFi0LHJsAlgLIGIcShBABCv/yjhadsmMI/Fg1bJc4=;
        b=J7A6PwlwcxR8Lr7p+E8feL7lPU9diOeUjtYmo7egmSTSjMA2Z4HCg/L8btcBkuf8C/
         DUG+h/jZb8fexCQpNJp/gAXjtgjV2nXsciKaKo9OOmi5lPiDDKp6zsr9dTtsnuiV4Lg8
         nYnWLM0T44hzjhsWa7z9FqNoffIJTwlUMzkLyYIv2fa5WwVMfdqymIUhkK/nhqsGUsoo
         8ydGrOQvoYKAA6OUEot2kAyJgxegv3UgtIP4+TTb9JHy53gy2kVs9QVp8SKqSBZ4dOW4
         3Q6tG5fBXPvSzhRWjciV2V5xLNCZpV6IsMN2+z0Cf0+/1GdkoZio4GaqDwlp7qWeBo01
         +UtA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZgAOSgbylDYIZ5S5GLgjnuZwUZeeCipc20St6PKyieRPi+CIEp/zzJR67xUbvlyKxlohnLNC9/Po7GHNP+8dxX2ljLNJDTBaPMfZ
X-Gm-Message-State: AOJu0Ywgas4eysgF9ObGrzSBUcCiWg8Xkkz+C5f6mZqJtyk6rD37tulV
	BLkEdTTwmP8y6W3xtUXOofZ4G+4rWmxEyT31oEsb0lsjNnxXpLCNQUEJubAfv40=
X-Google-Smtp-Source: AGHT+IGIUhAHxmHdb5Nr/f680qAPCsRQZ4ihTdSW0wFJ2SVbK0DFLJ2t/Vzjxxd1NO9R08tbikOw7Q==
X-Received: by 2002:a17:906:c34b:b0:a42:f194:9cd6 with SMTP id ci11-20020a170906c34b00b00a42f1949cd6mr3273335ejb.7.1708931119395;
        Sun, 25 Feb 2024 23:05:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vi17-20020a170907d41100b00a43215bff13sm1269633ejc.117.2024.02.25.23.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 23:05:18 -0800 (PST)
Message-ID: <a762f756-1a92-4d82-be38-098bacaf25dc@linaro.org>
Date: Mon, 26 Feb 2024 08:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8953-lenovo-kuntao: Add initial
 device tree
To: Raihan Ahamed <raihan1999ahamed@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 06:55, Raihan Ahamed wrote:
> Lenovo P2 is a handset using the MSM8953 SoC released in 2016
> 
> Add a device tree for with initial support for:
> 
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - WCNSS (WiFi/BT)
> - Regulators
> 
> Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8953-lenovo-kuntao.dts   | 240 ++++++++++++++++++
>  2 files changed, 241 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 39889d5f8e12..aebfb1ae728c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-lenovo-kuntao.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts b/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> new file mode 100644
> index 000000000000..2fd6345bbe15
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024, Raihan Ahamed <raihan1999ahamed@gmail.com>
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/delete-node/ &qseecom_mem;
> +
> +/ {
> +	model = "Lenovo P2";
> +	compatible = "lenovo,kuntao", "qcom,msm8953";

Missing bindings.

Best regards,
Krzysztof


