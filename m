Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C875927D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGSKPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGSKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:15:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA83E1FEC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:14:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso2556119e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689761692; x=1690366492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS7bHViFDzF/1y1TtNUTdaoGie9q5q1n+sh+m1326rI=;
        b=F8Cddg9CJk59OzTyY1Sc7/9eOgDo8hSf2vo1Lv06kHKLcwF3yP1v9ByUO5AK8OWKRR
         2Kn9gUrlmmte3WI53b/nNXzsgvpzXuRrOmAyQt+uDaKCkq4n7wEYTY1Y8z/zQDSUIUyN
         4t1R/me2QUxNwKzBScxfk2bj16biqNOeQUgdZyRQw434RBh7vevcVzUr0EMYSL5o2Xx7
         ygucrjfOtRr4Pjdr/RQ+117hGzQoZ6o/+xIl/yJ0KGrtsRgZdTxPCwfxtlE15X33eEy+
         g//wgPmzIgwCi+DdZRDeAofViA/HAW33XU0NRBBMa5SoACI1/oDX8wE+3uJxhjA/9fsD
         up6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761692; x=1690366492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gS7bHViFDzF/1y1TtNUTdaoGie9q5q1n+sh+m1326rI=;
        b=Fyttgf6tZJWipJUsgJQ9LVV4vmLjXRLfnbjiSPENUaIYdBbpHU9J7fBF5BqTz3ESt3
         q/OA2ea5c0B7tnGfWoi4bqJy6HegmSFxkSltMLu5VmxFjNVRdJbV4W/aGTcMJpXaD4tM
         AI8ectX1Rs9ZOmz7SNrfq2rtta9sU0iMz4C3GH/waspFsA0fHh/QR7M4ILj+KkcKUsNM
         sIaHhGMX+SnM7D2AmWIShMpdPRMtLZ8ndorIpMXNfVcG89+TU13D19PAAKQqHP1WZgTY
         taYeCbP5AuW3tQg+gfdjdi0oOsXXZp6DfGCU/0y1cTBOz7BOnPuS0Vc6CLK0uj2aLpVV
         3GOg==
X-Gm-Message-State: ABy/qLZ38GXtOEObhPkA4rumeIzhQe8KpNT57ZLeUneQPdduv8pgYDat
        5+Jyqe4KOY3tLnshHwylmTzUlQ==
X-Google-Smtp-Source: APBJJlGtMCG5W22C3p7BE7TaCuf2XLm3T9Jmhoz8nBJspkXHr3h2zXAJjhhDXavcUjUfHcwc3F/rJw==
X-Received: by 2002:a19:3858:0:b0:4fb:c693:c73b with SMTP id d24-20020a193858000000b004fbc693c73bmr1321303lfj.64.1689761691997;
        Wed, 19 Jul 2023 03:14:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l24-20020a19c218000000b004fb7359ab83sm876199lfc.80.2023.07.19.03.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:14:51 -0700 (PDT)
Message-ID: <7b9bdd6c-6c76-06a9-ccce-f120c80c5860@linaro.org>
Date:   Wed, 19 Jul 2023 13:14:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] arm64: dts: qcom: Add base SM4450 DTSI
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-2-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230719100135.21325-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 13:01, Tengfei Fan wrote:
> This add based DTSI for SM4450 SoC and includes base description of
> CPUs and interrupt-controller which helps to boot to shell with
> console on boards with this SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 435 +++++++++++++++++++++++++++
>   1 file changed, 435 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> new file mode 100644
> index 000000000000..ab14aecbdcea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -0,0 +1,435 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	clocks{
> +		xo_board: xo_board {

no underscores in node names.

> +			compatible = "fixed-clock";
> +			clock-frequency = <76800000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;

empty lines before child nodes, please (here and further in the patch).

> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
> +					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_100>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_100: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_200>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_200: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_300>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_300: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_400>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_400: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_500>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_500: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x600>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_600>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_600: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x700>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_700>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			#cooling-cells = <2>;
> +			L2_700: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +
> +				core4 {
> +					cpu = <&CPU4>;
> +				};
> +
> +				core5 {
> +					cpu = <&CPU5>;
> +				};
> +			};
> +
> +			cluster1 {

If this SoC implements Dynamiq architecture, you don't need separate 
clusters.

> +				core6 {
> +					cpu = <&CPU6>;
> +				};
> +
> +				core7 {
> +					cpu = <&CPU7>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "silver-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000004>;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <750>;
> +				min-residency-us = <4090>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "gold-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000004>;
> +				entry-latency-us = <600>;
> +				exit-latency-us = <1550>;
> +				min-residency-us = <4791>;
> +				local-timer-stop;
> +			};
> +		};
> +
> +		domain-idle-states {
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000044>;
> +				entry-latency-us = <1050>;
> +				exit-latency-us = <2500>;
> +				min-residency-us = <5309>;
> +			};
> +
> +			CLUSTER_SLEEP_1: cluster-sleep-1 {
> +				compatible = "domain-idle-state";
> +				idle-state-name = "cluster-power-collapse";
> +				arm,psci-suspend-param = <0x41003344>;
> +				entry-latency-us = <1561>;
> +				exit-latency-us = <2801>;
> +				min-residency-us = <8550>;
> +			};
> +		};
> +	};
> +
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-sm4450", "qcom,scm";
> +			#reset-cells = <1>;

Does the SCM need the core clock?

> +		};
> +	};
> +
> +	memory@a0000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0xa0000000 0x0 0x0>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD2: power-domain-cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD3: power-domain-cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD4: power-domain-cpu4 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD5: power-domain-cpu5 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD6: power-domain-cpu6 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD7: power-domain-cpu7 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CLUSTER_PD: power-domain-cpu-cluster0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +		compatible = "simple-bus";
> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sm4450-pdc", "qcom,pdc";

Missing binding update

> +			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
> +			qcom,pdc-ranges = <0 480 94>, <94 494 31>, <125 63 1>;
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
> +		intc: interrupt-controller@17200000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +			reg = <0x0 0x17200000 0x0 0x10000>,     /* GICD */
> +				<0x0 0x17260000 0x0 0x100000>;    /* GICR * 8 */

Please align vertically.

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
> +
> +			frame@17421000 {
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +						<GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;

Please align vertically.

> +				reg = <0x17421000 0x1000>,
> +					<0x17422000 0x1000>;
> +			};
> +
> +			frame@17423000 {
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17423000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17425000 {
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17425000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17427000 {
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17427000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17429000 {
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17429000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@1742b000 {
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x1742b000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@1742d000 {
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x1742d000 0x1000>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,

Please align vertically.

> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;
> +	};
> +};

-- 
With best wishes
Dmitry

