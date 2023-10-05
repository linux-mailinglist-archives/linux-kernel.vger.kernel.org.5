Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4E7B9DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjJEN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjJENzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:55:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA7D21D28
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:49:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b2cee55056so143732066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696499370; x=1697104170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=304anSfwqLSHuPbwL+O6zq/i1q6oajRX8tZCmgiyxgc=;
        b=TBixo3kycz0Xk8GXALJ9Wt3Wps0JwbUd67+0bN4NNqanvrjz2zdLe1vLfdDMtz9wsK
         c3UDCBpsDzbyycyqzHLqRgi+iMGWLXmbeJ+v88eoRBjq0Fc9YsgzQuZTnNFvIt1wW+Eq
         lsOdwO76ObV//PDA0qoFkmsNSnPA7XlR3igNMaZ/ME2vuReS/8kft/k1r+1PcW9IsWwk
         gzggtdk94O6WT412V2GecnKbAWZRcjiJtI9IQZtfvAQ3oSkhkILxF+3CHU94cMFrkvyh
         JDX65xuH/CmnWBrfLU9B6vOentSa6s82OdlyceBi2t8NMZeExcWX1BkY5nHwwfT45zNU
         jU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499370; x=1697104170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=304anSfwqLSHuPbwL+O6zq/i1q6oajRX8tZCmgiyxgc=;
        b=lIVA1ficP8BLA34NotQwcA7B0D91RkcQWSgkC6JAPfdNK9u13WHIFdcZ9WLVMG2WmV
         2FzOuZau9YAlSD1BsTwEWU1ABgwCAJxhrkLTYW6e8tf9gMqVWLFt5dXDgsjdoQf00Yze
         YOS8T8m6vMMBc140YiOg4IRH9BWSewJDAHNoqOzc71KmNfOs0uHMlvOwkoXQtz7EsF7+
         UHWHtoyTZJ163bQMEbUJWSc61cQVwoQvegKkZiieIJ/QiJr5ktV948MdvRSmlCswx7hK
         M1ePWt7f+K64M535B0YgNYuHYlGhYWd/IlqL1tLC1e1HLu2iDzwOb0gVFjze+MG8xdUB
         8Bbg==
X-Gm-Message-State: AOJu0YyBLxX98Odj669ZcF9Hb26UHj8vEzLfGmRWVyau+T33+c7kQjd2
        eIzGYxTrEZgN1v1d0TI5LoWSfJXdirWBhZgzx/dS/Q==
X-Google-Smtp-Source: AGHT+IEjcliXEdl2vxWBIqO8NySRUrNLbVAfzsp1aqSTMnHkRJ7kitxgiQc8mjJNRG2jSy3oZDdWIQ==
X-Received: by 2002:a17:906:8a67:b0:9ae:6648:9b67 with SMTP id hy7-20020a1709068a6700b009ae66489b67mr3907650ejc.1.1696499370377;
        Thu, 05 Oct 2023 02:49:30 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm883275ejb.185.2023.10.05.02.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 02:49:29 -0700 (PDT)
Message-ID: <89be9eb1-d5ef-4ff2-be94-6e7de6c74c1a@linaro.org>
Date:   Thu, 5 Oct 2023 11:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add overlay for NAND daughter card
Content-Language: en-US
To:     Nitin Yadav <n-yadav@ti.com>, nm@ti.com, vigneshr@ti.com,
        rogerq@ti.com
Cc:     kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231005093739.4071934-1-n-yadav@ti.com>
 <20231005093739.4071934-3-n-yadav@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231005093739.4071934-3-n-yadav@ti.com>
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

On 05/10/2023 11:37, Nitin Yadav wrote:
> Introduce k3-am62-lp-sk-nand.dtso overlay file to support
> the X8 NAND EXPANSION BOARD card (PROC143E1) for AM62x LP SK
> board. NAND has partitions for different boot components as
> below:
> 
> 0x000000000000-0x000000200000 : "NAND.tiboot3
> 0x000000200000-0x000000400000 : "NAND.tispl
> 0x000000400000-0x000000600000 : "NAND.tiboot3.backup
> 0x000000600000-0x000000a00000 : "NAND.u-boot
> 0x000000a00000-0x000000a40000 : "NAND.u-boot-env
> 0x000000a40000-0x000000a80000 : "NAND.u-boot-env.backup
> 0x000000a80000-0x000040000000 : "NAND.file-system
> 
> Disable mcasp1 node in DT to avoid pinmux conflict. Update
> Makefile to include k3-am62-lp-sk-nand.dtso.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   3 +-
>  .../arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 119 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index b3516419f95d..f6e3ff55f787 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -18,7 +18,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
> -dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
> +k3-am62-lp-sk-nand-dtbs := k3-am62-lp-sk.dtb k3-am62-lp-sk-nand.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
>  
>  # Boards with AM62Ax SoC
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
> new file mode 100644
> index 000000000000..0f4e26db534b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&mcasp1 {
> +	status = "disabled";
> +};
> +
> +&main_pmx0 {
> +	gpmc0_pins_default: gpmc0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x003c, PIN_INPUT, 0) /* (M25) GPMC0_AD0 */
> +			AM62X_IOPAD(0x0040, PIN_INPUT, 0) /* (N23) GPMC0_AD1 */
> +			AM62X_IOPAD(0x0044, PIN_INPUT, 0) /* (N24) GPMC0_AD2 */
> +			AM62X_IOPAD(0x0048, PIN_INPUT, 0) /* (N25) GPMC0_AD3 */
> +			AM62X_IOPAD(0x004c, PIN_INPUT, 0) /* (P24) GPMC0_AD4 */
> +			AM62X_IOPAD(0x0050, PIN_INPUT, 0) /* (P22) GPMC0_AD5 */
> +			AM62X_IOPAD(0x0054, PIN_INPUT, 0) /* (P21) GPMC0_AD6 */
> +			AM62X_IOPAD(0x0058, PIN_INPUT, 0) /* (R23) GPMC0_AD7 */
> +			AM62X_IOPAD(0x0084, PIN_OUTPUT, 0) /* (L23) GPMC0_ADVn_ALE */
> +			AM62X_IOPAD(0x0088, PIN_OUTPUT, 0) /* (L24) GPMC0_OEn_REn */
> +			AM62X_IOPAD(0x008c, PIN_OUTPUT, 0) /* (L25) GPMC0_WEn */
> +			AM62X_IOPAD(0x0090, PIN_OUTPUT, 0) /* (M24) GPMC0_BE0n_CLE */
> +			AM62X_IOPAD(0x00a8, PIN_OUTPUT, 0) /* (M21) GPMC0_CSn0 */
> +			AM62X_IOPAD(0x0098, PIN_INPUT, 0) /* (U23) GPMC0_WAIT0 */
> +		>;
> +	};
> +};
> +
> +&gpmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpmc0_pins_default>;
> +	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
> +	#address-cells = <2>;
> +	#size-cells = <1>;

You have these two in DTSI.

> +
> +	nand0_0: nand@0,0 {
> +		compatible = "ti,am64-nand"

Best regards,
Krzysztof

