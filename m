Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE147BA5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbjJEQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjJEQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD542B8B7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:48:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdcade7fbso189561166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696517320; x=1697122120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFTRJ9LOdKz1pzzjgzvYEInNLg2aiS47P3gxQj2muZ8=;
        b=IOdN25LSRDwkawAca9pwETDeZu8gPJZeK5pUFJg6Jhe1BtK9THg/FREjyiDQuGazbu
         dRLEDCdz6+NVUXw+hXJyF1RZDHv7N8oTeFEqCt/U8jcSuD5egrXstTjsJu6wXFc7s65F
         8CvUFWn2dx16fRuhk0GkmHMFa8HeSvbIIETCZCxv7GKDvlyS8V1NPgu4u4QA8+5jGsPc
         vI+wEJdH4zg3hR/9g53TjceNRCHx6wV/GC5A7rzt2839a3tN6TN1Y0Rkvc3reUmaqc3v
         CTKwXR9jcd6PWfBjHbJ59LJQfHnGJguHhM+t/PNXJzxxzpc6KGIxmT4kI0ydyTixZn8t
         RqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517320; x=1697122120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFTRJ9LOdKz1pzzjgzvYEInNLg2aiS47P3gxQj2muZ8=;
        b=H8EdUyHKS0tIJvENFg2CjZvoN6kwTCW8ocKsfJe9Mhi/yUvIOpYWrdkjFC2ZH4sCMY
         mIAw9Z/vpzJcBhztoTAsqAtQ7LoYUEMvfXCSiG3b0YBeUcDaIREtKhoZYEBbySGjIK2f
         sLTE3E5gcCl8LMxD0/pLyPUrtSlRu15++bYG4Vjjihyb/RXDc3FMHKtTGIzsl8YNo/lZ
         YrJZvISEQHr/7/FzO+YG2vJsKE1G673EFSkKqtegpi1DytZbzS8Ni/2SL0e/1JypXl/w
         soBcsEUFOOnJ+K3OzuXWIwTgTY6ByXeTO6juXXkNeYfdPOdWq6NydGjq1bJTN/MkOfM3
         Kn+Q==
X-Gm-Message-State: AOJu0YylG6WpN/ssCf9U7ezaXmmg8TE/X4D9w+tYeKi4WIcWcwGCIrvD
        eK8QU8epoCvPTP2C6/lD/yXKExwqmc1xaycRVUrmpg==
X-Google-Smtp-Source: AGHT+IELsNwmTzXQstm3rM2DoxIYAP4LMhTWlDdPyqUzM1Cky8jhsE+Tzt7ve/JJ6eUvfarm0Rcn8g==
X-Received: by 2002:a17:906:3f04:b0:9ae:5568:b6a8 with SMTP id c4-20020a1709063f0400b009ae5568b6a8mr5583845ejj.10.1696517320270;
        Thu, 05 Oct 2023 07:48:40 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b0098e34446464sm1312776ejb.25.2023.10.05.07.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:48:39 -0700 (PDT)
Message-ID: <b017d65e-35cc-4415-a5a1-ccf7d56bb3c7@linaro.org>
Date:   Thu, 5 Oct 2023 16:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add device tree for Xiaomi Mi 9
Content-Language: en-US
To:     ZeYan Li <qaz6750@outlook.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <SY7P282MB3787E3A1FE3DA22CC6701BFBB2CAA@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SY7P282MB3787E3A1FE3DA22CC6701BFBB2CAA@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 16:31, ZeYan Li wrote:
> This commit adds initial support for the Xiaomi Mi 9.
> 
> Signed-off-by: ZeYan Li <qaz6750@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8150-xiaomi-cepheus.dts   | 610 ++++++++++++++++++
>  2 files changed, 611 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d6cb840b7050..75e9657d7d57 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -214,6 +214,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-xiaomi-cepheus.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
> new file mode 100644
> index 000000000000..bc4f3533455a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Zeyan Li <qaz6750@outlook.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8150.dtsi"
> +#include "pm8150.dtsi"
> +#include "pm8150b.dtsi"
> +#include "pm8150l.dtsi"
> +
> +/*
> + * Delete following upstream (sm8150.dtsi) reserved
> + * memory mappings which are different in this device.
> + */
> +/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
> +/delete-node/ &rmtfs_mem;   /* moved to completely different address */
> +/delete-node/ &adsp_mem;    /* same start address, but larger size */
> +/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
> +/delete-node/ &venus_mem;   /* same size, shifted higher */
> +/delete-node/ &slpi_mem;    /* same size, shifted higher */
> +/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
> +/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
> +/delete-node/ &gpu_mem;     /* same size, shifted higher */
> +/delete-node/ &spss_mem;    /* same size, shifted higher */
> +/delete-node/ &cdsp_mem;    /* same size, shifted higher */
> +
> +/ {
> +	model = "xiaomi Mi 9";
> +	compatible = "xiaomi,cepheus", "qcom,sm8150";
> +	chassis-type = "handset";
> +	/* Required for bootloader to select correct board */
> +	qcom,board-id = <37 0>;
> +
> +	aliases {
> +		serial0 = &uart2;
> +		display0 = &framebuffer;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer: framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x9c000000 0 0x2400000>;
> +			status = "okay";
> +			width = <1080>;
> +			height = <2340>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			/*
> +			 * That's (going to be) a lot of clocks, but it's necessary due
> +			 * to unused clk cleanup & no panel driver yet (& no dispcc either)..
> +			 */
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&gcc GCC_DISP_SF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio_keys {

No underscores in node names.

gpio-keys
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ai_key_pin_a &vol_up_pin_a>;
> +
> +		vol_up {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

No, do not upstream junky DTS from some vendor stuff. That's not how it
works. You must choose decent, latest DTS and customize it per your
needs. There is little point to review and ask the same bugs we fixed
months or years ago.


Best regards,
Krzysztof

