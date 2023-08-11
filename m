Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A7779AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjHKXGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbjHKXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:04:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87DA44A8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:02:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso3862290e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691794940; x=1692399740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sT1uR+cf7e1evx8m1N53/kqWjqSw5gEDum8c1pesGBE=;
        b=G+9TuSqPsKMfTgDJ6Oy763ox7t2rbvrj0Xj4oypFCf75GKespz953IqRpOh3Rxp9FE
         9VY+JO1iWTV2udUjr0g9lp/BUb+SB0FnPa4Il5jnYjjx7yY2EHii9k4tNRljsesIXKH5
         VeXNHQpXEeVBdwj8V9HNbUQvF3msVjFRFdTsv3fPRlFpH3xXqSOlMLc6S+IGsIHl40fx
         PiFksdsRtcQtrRG0lZ5itFXQWLjs13iVuZlBq0xnBNwJvQz4Mp94J4n5xvz28/1g0xdt
         gaqQhYUC39XLT7rEmtK5C/+aeA6AM+P4FuTG4K2xkTksXr5mOR5AvSeUjSbj0XDTOvuT
         Afrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794940; x=1692399740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT1uR+cf7e1evx8m1N53/kqWjqSw5gEDum8c1pesGBE=;
        b=YCf4bItfR8Izw+S6RxQ7HAHVxMXax2mRRtixEuTQ/pjmEzKn/mZfgTkSkMXfhT6PK8
         XpKTSJ0FvEoHTnHohxgUvfylFDOslVWJSOmR4JdjdydKafeMcCSXYnofVgovHUuIkTDv
         chIEtFxZnHvBSInNKJhqja2APvwlqKbub7lxIqRHKzuhOMuWiiVGersFzJX07hqbWUz0
         tfTa6989g3eJaShnE3j0lRo23hro+cokaLjxKLqT2Oty/kwQNQWarto2UMYAn1vcIOQI
         1tuq8ddyKb+lrptjftY1kjU49ukZ3+hC08mLiP4vi03mou9rBuXOHzbn99WaRbvRQeFd
         NDtA==
X-Gm-Message-State: AOJu0Yz974mts025T4uodtRMHPOAWVYKap6DB5sJOx/2xSiSWwLAilqG
        6otAMMdwyXLVi5dSw8uGb2NHqA==
X-Google-Smtp-Source: AGHT+IFdyKA/K8FtlyVqffYc8nEeW+KRP+PJ4MSdP6VA1xBuAPT/TEUDZ9YnaoZmP7BekLNDDkPYxw==
X-Received: by 2002:a05:6512:ea9:b0:4fb:cc99:4e90 with SMTP id bi41-20020a0565120ea900b004fbcc994e90mr3270700lfb.37.1691794939907;
        Fri, 11 Aug 2023 16:02:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b004fe3512e26dsm884105lff.291.2023.08.11.16.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:02:19 -0700 (PDT)
Message-ID: <5077fd56-c1af-4b1b-be4c-8a7396824e94@linaro.org>
Date:   Sat, 12 Aug 2023 01:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ARM: dts: qcom: add common device tree for
 MSM8x26-based Lumia phones
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
References: <20230811213728.23726-1-rayyan@ansari.sh>
 <20230811213728.23726-3-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230811213728.23726-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 23:35, Rayyan Ansari wrote:
> Add a common device tree for Lumias based on the Qualcomm MSM8x26
> family of chipsets.
> 
> Currently supports:
> - Framebuffer
> - Touchscreen
> - Keys
> - Regulators
> - MMC
> - USB
> - UART
> 
> Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Co-authored-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
Would be really nice if you could squash it with patch 3 so that
this code is immediately compilable.

[...]

> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_active>;
property-n
property-names

[...]

> +	reserved-memory {
> +		ranges;
That's already there in soc dtsi

> +
> +		smem_region: smem@fa00000 {
Swap the subnodes to keep the nodes ordered by unit address
> +			reg = <0xfa00000 0x100000>;
> +			no-map;
> +		};
> +
> +		display_reserved: framebuffer@3200000 {
> +			reg = <0x3200000 0x800000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&blsp1_i2c5 {
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
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_on>;
ditto

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
[...]

> +
> +&tlmm {
> +	gpio_keys_active: gpio-keys-active {
Run `make CHECK_DTBS=1 qcom/msm8226-something-lumia` and fix the warnings
before Krzysztof gets angry :D

Konrad
