Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05849789597
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjHZJx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHZJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:53:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490BD1BE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:53:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007f3d3235so2574290e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693043595; x=1693648395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxT0u5ag8dXMl0rBiE83QPDzaQ4lBfHYgvTwi16o0do=;
        b=bGi+63scwQrXV3sKXQkfHUDbDO/oYtlJTHrURTsIjevz4rubZgBW2uEsCwQSmqiDEC
         E3Src3l81hUvoicLKtbCc35bkI4o6BIW7be9LyIZUKj1Y2WTY/EpUXwOwsItOx+f40+2
         MxTtkGdfvw8V5PnQOpf5K3On/eOXAJvHKkUU2hU/ynJVSOPfw8ZEKICYAp82L7eBto1B
         ZJRnZakzTJXgXWaz/Jx4gG6VEpUTPvvl8LdaW4EpCkEt6GlS9BjUBw8tEzKNO4il0hXX
         5QPeH1aMN02RTp7cyq+N/JBY6QQKx2BzVDTz0xZ+WQNf2JzWhZCRf8v7GwISlQqq1isl
         BQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693043595; x=1693648395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxT0u5ag8dXMl0rBiE83QPDzaQ4lBfHYgvTwi16o0do=;
        b=LMGoWtJvhRcNNvGLXb6XURBhvnoU3FidcVRFqfBpofmeIGZ/MYBe08F4BxbDs/limS
         A8Un2sFXH1on4L6i/G77r/3KeszQxfkydAKH59oITp8v83yRR+eDJELJIiDJOSGNZA3z
         ucBEedymqI+ACPEu0Wth0TL88fRrzpJ8BJxiXz68JfBwo1TLUqYP6Dm2uhrIxJ8gLqwg
         2wopMePy6/Nn6r1w/Y4eiIhOxLL1UaUGyqoWE0pWZqPqy/WKoFMLp5cSiJFeEarBQHyv
         6qLgvfP/Dmx6vm1eTOl0I2GSfjDeXb7LKHOE95xwXh7KvP9sKy6YIFUkFq48pw8Gly8W
         suOg==
X-Gm-Message-State: AOJu0YxCZMGoeb4HmQZkBRdlxrIULhOqCPuyUY22nXKb+80COLbLkNI+
        T1I1nTSjQUEl7dqa7TjPvA3eJA==
X-Google-Smtp-Source: AGHT+IFVw25TED1aPUwqZVGvr4oXEBWUL0cmH8qxm/6LTB0SP8LMxC3ZNHs15rhHtloIZ4dsNI/MDQ==
X-Received: by 2002:ac2:4c0f:0:b0:500:ac0b:8d51 with SMTP id t15-20020ac24c0f000000b00500ac0b8d51mr1945997lfq.37.1693043595562;
        Sat, 26 Aug 2023 02:53:15 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id u8-20020ac25188000000b00500a44e158csm649584lfi.235.2023.08.26.02.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:53:15 -0700 (PDT)
Message-ID: <c85f884a-cfa0-4769-a8fe-4f1b1638d188@linaro.org>
Date:   Sat, 26 Aug 2023 11:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ARM: dts: qcom: add device tree for Nokia Lumia
 735
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        Jack Matthews <jm5112356@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20230813152623.64989-1-rayyan@ansari.sh>
 <20230813152623.64989-6-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230813152623.64989-6-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2023 17:23, Rayyan Ansari wrote:
> Add an initial device tree for the Nokia Lumia 735, codenamed
> "superman-lte".
> 
> Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Co-authored-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom/Makefile               |  1 +
>  .../qcom-msm8926-microsoft-superman-lte.dts   | 52 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-superman-lte.dts
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index 487e0a5987ce..7982620ec9f9 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-msm8916-samsung-e7.dtb \
>  	qcom-msm8916-samsung-grandmax.dtb \
>  	qcom-msm8916-samsung-serranove.dtb \
> +	qcom-msm8926-microsoft-superman-lte.dtb \
>  	qcom-msm8960-cdp.dtb \
>  	qcom-msm8960-samsung-expressatt.dtb \
>  	qcom-msm8974-lge-nexus5-hammerhead.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-superman-lte.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-superman-lte.dts
> new file mode 100644
> index 000000000000..e612d752f2b9
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-superman-lte.dts
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Jack Matthews <jm5112356@gmail.com>
> + * Copyright (c) 2023, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> + * Copyright (c) 2023, Dominik Kobinski <dominikkobinski314@gmail.com>
> + * Copyright (c) 2023, Rayyan Ansari <rayyan@ansari.sh>
> + */
> +
> +/dts-v1/;
> +
> +#include "qcom-msm8226-microsoft-common.dtsi"
> +
> +/ {
> +	model = "Nokia Lumia 735";
> +	compatible = "microsoft,superman-lte", "qcom,msm8926", "qcom,msm8226";
> +	chassis-type = "handset";
> +};
> +
> +&blsp1_i2c3 {
> +	status = "okay";
> +
> +	touchscreen@4b {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x4b>;
> +
> +		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
> +		vdd-supply = <&pm8226_l15>;
> +		vio-supply = <&pm8226_l6>;
> +
> +		pinctrl-0 = <&touchscreen_default>;
> +		pinctrl-names = "default";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x01>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f11@11 {
> +			reg = <0x11>;
> +			syna,sensor-type = <1>;
> +		};
> +	};
> +};
> +
> +&blsp1_i2c5 {
> +	status = "disabled";
> +
> +	/delete-node/ touchscreen@4b;
use /delete-node/ &touchscreen (need to add a label in common dt),
it's less error-prone

Konrad
