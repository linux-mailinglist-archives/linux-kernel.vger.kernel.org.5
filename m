Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB5E75A850
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGTHzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGTHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:55:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FF2684
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:54:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9352ff1aeso6478861fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689839696; x=1690444496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMsjUWowRy8zKBSAJP6wn0qq1G6KFKnLr6lTl1pPej0=;
        b=PLietxZtWFOiphSV35vnt3bAUhDz95CaER1UXv5dnv5tehCcCCGp231Nw47PSZfMK7
         90y9sci2IMud7Z9gvdmD51vVa+yfBVBJ5yCTNU1XxU9NgPx0caGGdGO5HglNrR3bUhlG
         elQ8i3f59lo6jc8SERRW4Mi+8LwFN9Rox2fjHAeFywVvw8YdCcZ1YhINoPSckVegPgAV
         70h8In3RspMOp/qYz7L7QWV7fbqFZXD05rnC1cVyrAQlgUWws5AXbiXhn6HGpu4fMEP7
         oFqSv/WB0POOTyOdYkpxBGEDG/uo8U5jiBQfBFKEXYn4HXeqha+wMeL2JtXTkhv0ITbl
         9EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839696; x=1690444496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMsjUWowRy8zKBSAJP6wn0qq1G6KFKnLr6lTl1pPej0=;
        b=bOEJPeEHnlEsoE8wP1BLTmBFoRIe5wXl0E1rPwjuPmeL41YEnEXLzZJyQv++vUpLdR
         CI3+GLtr4eYQd3VzsE7037qy8HTnKwq9vINDD3Nto5UPCizKdFKMvAE6rYyGopjiBVqx
         T+IrqWZ+afe20YtOqawz+UeV3QuJLkvzEi0fRZr7iHZZKnCdJCL2tNvM035xqy0DZjJ0
         4sv038QunDjqLw69v7ZO+JUR9naIkG3CngV7OoFludYKGNehmfjH/gUimjGJ3Z9g8m41
         PE1TqlxG0gGO3PbWo2XQY+/6u0bRzOCcQWjlvV+VGyhi31AhHl3TbaDy3v8x6cOqPk2A
         0s3A==
X-Gm-Message-State: ABy/qLYn81iInWJj0zYgJ+//L88Pkc+OE+wI0vMAWqgLxEkkoDFXGSU0
        OKiMvs2qhx/0Cung1vnqwJ6OyQ==
X-Google-Smtp-Source: APBJJlG0kcI53zpRV5P9as4Otvi33KsvvfpVxNrk9OMVkotY1nf9ZrjCJ7f7IDEN1UM2R8uNVjC+ig==
X-Received: by 2002:a2e:854f:0:b0:2b6:d838:1931 with SMTP id u15-20020a2e854f000000b002b6d8381931mr1354414ljj.30.1689839696134;
        Thu, 20 Jul 2023 00:54:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id r17-20020a2eb611000000b002b6daa3fa2csm112641ljn.69.2023.07.20.00.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 00:54:55 -0700 (PDT)
Message-ID: <a590f1c3-dc8b-ca12-9323-df195244a87f@linaro.org>
Date:   Thu, 20 Jul 2023 09:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: Add base SM4450 DTSI
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-2-quic_tengfan@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230719100135.21325-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 12:01, Tengfei Fan wrote:
> This add based DTSI for SM4450 SoC and includes base description of
> CPUs and interrupt-controller which helps to boot to shell with
> console on boards with this SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
[...]

> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/gpio.h>
Please sort them alphabetically

> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
[...]

> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
Please post dmesg | grep '\[', this is probably a standard ARM core.

> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_0: l2-cache {
Missing a newline before subnodes

> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
Ditto

> +					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
> +				};
> +			};
> +		};
[...]

> +
> +		intc: interrupt-controller@17200000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
> +				<0x0 0x17260000 0x0 0x100000>;    /* GICR * 8 */
Misasligned

also, please move reg and interrupts after compatible

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +
> +		timer@17420000 {
> +			compatible = "arm,armv7-timer-mem";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0x20000000>;
> +			reg = <0x0 0x17420000 0x0 0x1000>;
> +			clock-frequency = <19200000>;
Drop clock-frequency

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
Misaligned

> +		clock-frequency = <19200000>;
Drop

Konrad
> +	};
> +};
