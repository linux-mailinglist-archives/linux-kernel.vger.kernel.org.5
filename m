Return-Path: <linux-kernel+bounces-4777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F058181EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71222B24A85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9C111BE;
	Tue, 19 Dec 2023 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gzu/v4Wp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA118E25
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553729ee917so1890453a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702969138; x=1703573938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLIBia1/d/IaC1c6cAScL8pDuXaExKskc6Sm20oW1cU=;
        b=Gzu/v4WpoS6wEaaV8Fl+aw23JlhEIa3BosDoPBoACxwL8tYPJx92mUwz40qfDJXp2c
         oiHMMJ8Djnsm7cOnOLC6jTYhU6TsqdooXnSUEDkHH49tC1A7TXmIY/pK9wEvp7sADfy+
         /oloanXTv+JUes1ttNHmfzMZo2t2IdyVjG9ZAaKAWlO2392MuFhmBKjoCO+bitYR0ba6
         +0sJG8q9Pa0P+qhS8DqTbYWQu9c6Jy+swrz/vEtn/SH5qLVi+dzxRcGM8PItQef4AaSg
         ETX0+yUwvJy+CyeyaEYNQK7cyqztiKU4X/kv8HLkk3yc12kJ2LVQoJIvtykv9pIbuJit
         HROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702969138; x=1703573938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLIBia1/d/IaC1c6cAScL8pDuXaExKskc6Sm20oW1cU=;
        b=o3/9DQuugW2abrh/TW5p9HW+Z/iWOisusv4xu+/d0g+8tXBuQA2PjFOAsaeevY65g4
         0eVopB9uCit3ZOpz3J5cGUlUu8hQav1vkCLL0/EANpmJze5d9gJ3zf/Dz0PvkAADElqZ
         GglEShQgcmnnF/2+A/D79Wxi1bMQuSq4JCnP73qbt+zHtp0WkPYLEfXyclgHTN+nP95O
         iJh1aEwXy8uqcOAHGqZPAkFUgTHYkF2aTTecfFHTh1/Lrbut/a+SeXkkQ+l0I6tOZ5Mm
         /Y0c0/cn9zlf5zLRONGmL3S3MlqRd5Zgejp7564Ann7K+V5V8tyjq0/4MT57XxJ00H54
         QmqQ==
X-Gm-Message-State: AOJu0YyG4zbXNh2Nv51H5LOna4KUj7vgFw7Xc4fB5wmdT3jiyUA56jYa
	3hcPft1jMMUfyML+jFfnP1va/Q==
X-Google-Smtp-Source: AGHT+IFFrjYyQQNWYnR7SUFse7FkIt2/TvWVCYjloQPJbSRUVXTgyBVnNRHPtoMyHrdqSbPNJqSWTA==
X-Received: by 2002:aa7:c049:0:b0:54c:4837:93fc with SMTP id k9-20020aa7c049000000b0054c483793fcmr9966186edo.67.1702969137807;
        Mon, 18 Dec 2023 22:58:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005527c02c1d6sm4976746edb.50.2023.12.18.22.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 22:58:57 -0800 (PST)
Message-ID: <75f20b9a-f661-4c7f-8b7d-4a37ea790232@linaro.org>
Date: Tue, 19 Dec 2023 07:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20231219005007.11644-1-quic_tengfan@quicinc.com>
 <20231219005007.11644-7-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231219005007.11644-7-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2023 01:50, Tengfei Fan wrote:
> Add AIM300 AIoT board DTS support, including usb, serial, PCIe, and sound
> card functions support.
> 
> Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Co-developed-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 579 ++++++++++++++++++
>  2 files changed, 580 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 39889d5f8e12..fe54f4518165 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += qcs8550-aim300-aiot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> new file mode 100644
> index 000000000000..099f28b86559
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "qcs8550-aim300.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QCS8550 AIM300 AIOT";
> +	compatible = "qcom,qcs8550-aim300-aiot", "qcom,qcs8550-aim300", "qcom,qcs8550";

Missing fallback compatible. I think I was clear last time:
"using sm8550 fallback."


Best regards,
Krzysztof


