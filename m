Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D787E4AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjKGV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjKGV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:29:57 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66D10C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:29:54 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso84697931fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699392593; x=1699997393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ne2c9ju+9bn3Zice6izrVWXVkuEMpaweGZBq2tsOcY=;
        b=fqNvVEDfXZxqcyPv87zXIznJXrF3mxveQmvZprIvMJbT2M7248aj8QyLTcBZ/elw/g
         IXYb0OaVEqlvfM0/2ZKdfeaLOiP1IYnhExl1m4G+VwETExp75tIghsgtTIhUMYZ4rzIK
         KmJFxaEOJRtIVWwwke2nLGDncp8MBmO+/hXmgPCuj0oSDhnG9rKAsFHTSsi4VXO+Dn0b
         j/qVh8tpwxBN0ZWpFD8A7bA7GXPPPaD4SEEZDB4qh2bad1q6TuqpmVlb7y1yCqWtgnh8
         WWu/WxRgfhoUQfQ1dY+u1S4VQFuprUTGsj7WdCEsOn/HE4EapfvhXBkkrhEwBkKAbjZu
         +ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392593; x=1699997393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ne2c9ju+9bn3Zice6izrVWXVkuEMpaweGZBq2tsOcY=;
        b=YwqeuAh71EKEgU/dG31jQ50P2zlAbk1vsiHuzXEETTCotXOtcY5fra5wtzOddI/DYA
         XB3YkMUJc2hqfLYthqia0bVSrDTBV9PhdqeI+2ORrBJ3jUkz0Up+bWBuiVrtk/B0fEuO
         KJntMlVPFQ5cSdzTFxchSnknOhTLJgFBo/CwPc5ivxzITIfIjBLA31YaebJvKbwXKRJ+
         I6r/gG2qgiujTEmDBK4mAp7EvxZxpuyoV/Jf/YJyKX0WAMhOJRlC+T+sdIqLidJvcyX6
         THCh0bd3U3AlGHZUqs6BFu6zNxNt9UBkY0gLAd5nHKNvuuzI/KAvGQh0QU35mXmM40Ru
         HkNw==
X-Gm-Message-State: AOJu0YzVW2tqeAoi/Xwj4DQ4LeRQsDb1F0wZJp/yxQYJuyv4TwEUzOGL
        qHqVfs/CNBhIYuDtuoOIrkO97A==
X-Google-Smtp-Source: AGHT+IFItNos92G2Fef/m/cJIcLTaZPhUJCAiAccAcfKSmQhgxJraEQl0R/ly17xOKTTQlxmPAi/8Q==
X-Received: by 2002:a2e:3c05:0:b0:2c5:b3c4:7b17 with SMTP id j5-20020a2e3c05000000b002c5b3c47b17mr182193lja.38.1699392592906;
        Tue, 07 Nov 2023 13:29:52 -0800 (PST)
Received: from [172.30.205.109] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t4-20020a05651c148400b002b6daa3fa2csm1607587lje.69.2023.11.07.13.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:29:52 -0800 (PST)
Message-ID: <9c3dad0b-b5c9-4d73-8fea-1b3a44d89c62@linaro.org>
Date:   Tue, 7 Nov 2023 22:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: Add PM8937 PMIC
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
 <20231106-pm8937-v1-7-ec51d9eeec53@riseup.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231106-pm8937-v1-7-ec51d9eeec53@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 13:08, Dang Huynh wrote:
> The PM8937 features integrated peripherals like ADC, GPIO controller,
> MPPs, PON keys and others.
> 
> Add the device tree so that any boards with this PMIC can use it.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>   arch/arm64/boot/dts/qcom/pm8937.dtsi | 202 +++++++++++++++++++++++++++++++++++
>   1 file changed, 202 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
> new file mode 100644
> index 000000000000..6091d6938885
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
> + */
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +	thermal-zones {
> +		pm8937-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&pm8937_temp>;
> +
> +			trips {
> +				pm8937_trip0: pm8937-trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
Add a newline between the subnodes, please

[...]

> +			pm8937_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_VOLUMEDOWN>;
This keycode varies per-device, please move it out


> +			};
> +		};
> +
> +		pm8937_gpios: gpio@c000 {
> +			compatible = "qcom,pm8937-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pm8937_gpios 0 0 8>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pm8937_mpps: mpps@a000 {
> +			compatible = "qcom,pm8937-mpp", "qcom,spmi-mpp";
> +			reg = <0xa000>;

[...]

> +
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
This is probably IRQ_TYPE_EDGE_RISING

Konrad
