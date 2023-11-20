Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B537E7F1686
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjKTO50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjKTO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:57:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F405D10F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:57:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54366784377so6160323a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700492238; x=1701097038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQdmwJggkH5N5H7bleDZIaCxHcp1ZmwZnDUsdCqchNc=;
        b=kyCoYEkufDTe+kFpqhgMv00qbQIJt8Tr/6F/sO2XFZEE8q15L9waF3Bd2p8AODBYDA
         /PYm6oljdMls8LTPeWAu2T05W20ICKgxvr1qpqoUCNWVIJR9aKJHDNkR4c559VoMiisd
         Zt416RVgJLUDqC13cGGbBvRE6L8pGuIwUxRJXJzC95I5CfGjXSA2mWTbRymRIcIBaIJo
         //XiiZjVCsW9Qsx93vNED42H1cvIlTIuMG9dQgReqmAx364U7tksBpbSf6x+itEowKhi
         zeShj9Wr4MtqjJ2SY8gTYduiOBoSnfBtTeDU2OwZ+J4Zvc2uKhE6sWd+LGckgWKSPDVR
         OTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700492238; x=1701097038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQdmwJggkH5N5H7bleDZIaCxHcp1ZmwZnDUsdCqchNc=;
        b=suBlX+mSslPGQIQJQOf50n3RL0CZtvhzWzUMTbWob+mokPcXNXL1BkrmpAB+hPOTTP
         NoeAYfkdA14SZHXtINt/uvTsYClRLjd9anUM0qgwBJHFx5JJUEgUFPReDaXd5zSoCt0V
         I6UXiGhJHuh4VWzcYSWsahqM3sfmsljXOMLE8HTdf9/soD3QDZiyb9BBftCBS3JDxJNk
         QI8OX5zOYi56dZhqN0kvvmIFgEFx/fF7CT5CKD25ErOUz1fRd2amBA3XZjWHo1HS2Rwz
         1dVHlFGqtQ44WlOgP6MWPnrOEarm6HFAjFUJ5eoL2+idmQ2n2tt53/bIrQsDB9jDT45d
         ygLQ==
X-Gm-Message-State: AOJu0Yxt0tS/zgw8aJeyQl4PHxh5X020un5POHMcYpz0bSO4ZcXA5iqh
        Poz/ZnlduFxjeVNMcwdyq0MQhA==
X-Google-Smtp-Source: AGHT+IGKTCAQ89cSgrdtj41saGZa0eHlqo9fZTfHzsMIgXBpffdgBrR+YTLmJkRQLTrSUGi72DsZPA==
X-Received: by 2002:a17:907:6d0a:b0:9a5:b878:7336 with SMTP id sa10-20020a1709076d0a00b009a5b8787336mr6347418ejc.7.1700492238455;
        Mon, 20 Nov 2023 06:57:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id me23-20020a170906aed700b009e5c644e34dsm3899105ejb.82.2023.11.20.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:57:17 -0800 (PST)
Message-ID: <e8483375-cace-473c-aba7-1cd60feae242@linaro.org>
Date:   Mon, 20 Nov 2023 15:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <92cf3bcc-18e7-40ba-a082-1b8b6bea0dee@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <92cf3bcc-18e7-40ba-a082-1b8b6bea0dee@collabora.com>
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

On 20/11/2023 12:43, AngeloGioacchino Del Regno wrote:
> Il 20/11/23 09:40, Krzysztof Kozlowski ha scritto:
>> Document preferred coding style for Devicetree sources (DTS and DTSI),
>> to bring consistency among all (sub)architectures and ease in reviews.
>>
>> Cc: Andrew Davis <afd@ti.com>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Merging idea: Rob/DT bindings
>>
>> Changes in v2
>> =============
>> 1. Hopefully incorporate entire feedback from comments:
>> a. Fix \ { => / { (Rob)
>> b. Name: dts-coding-style (Rob)
>> c. Exceptions for ordering nodes by name for Renesas and pinctrl (Geert,
>>     Konrad)
>> d. Ordering properties by common/vendor (Rob)
>> e. Array entries in <> (Rob)
>>
>> 2. New chapter: Organizing DTSI and DTS
>>
>> 3. Several grammar fixes (missing articles)
>>
>> Cc: linux-rockchip@lists.infradead.org
>> Cc: linux-mediatek@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-amlogic@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-arm-msm@vger.kernel.org
>> ---
>>   .../devicetree/bindings/dts-coding-style.rst  | 163 ++++++++++++++++++
>>   Documentation/devicetree/bindings/index.rst   |   1 +
>>   2 files changed, 164 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst
>>
>> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
>> new file mode 100644
>> index 000000000000..cc7e3b4d1b92
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>> @@ -0,0 +1,163 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. _dtscodingstyle:
>> +
>> +=====================================
>> +Devicetree Sources (DTS) Coding Style
>> +=====================================
>> +
>> +When writing Devicetree Sources (DTS) please observe below guidelines.  They
>> +should be considered complementary to any rules expressed already in Devicetree
>> +Specification and dtc compiler (including W=1 and W=2 builds).
>> +
>> +Individual architectures and sub-architectures can add additional rules, making
>> +the style stricter.
>> +
>> +Naming and Valid Characters
>> +---------------------------
>> +
>> +1. Node and property names are allowed to use only:
>> +
>> +   * lowercase characters: [a-z]
>> +   * digits: [0-9]
>> +   * dash: -
>> +
>> +2. Labels are allowed to use only:
>> +
>> +   * lowercase characters: [a-z]
>> +   * digits: [0-9]
>> +   * underscore: _
>> +
>> +3. Unit addresses should use lowercase hex, without leading zeros (padding).
> 
> This is imperative, so: s/should/shall/g

Sure, fine.

> 
>> +
>> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
>> +   part can be padded with leading zeros.
>> +
> 
> Same here, I'd say.... :-)
> 
>> +Example::
>> +
>> +	gpi_dma2: dma-controller@800000 {
>> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
>> +		reg = <0x0 0x00800000 0x0 0x60000>;
>> +	}
>> +
>> +Order of Nodes
>> +--------------
>> +
>> +1. Nodes within any bus, thus using unit addresses for children, shall be
>> +   ordered incrementally by unit address.
>> +   Alternatively for some sub-architectures, nodes of the same type can be
>> +   grouped together (e.g. all I2C controllers one after another even if this
>> +   breaks unit address ordering).
>> +
>> +2. Nodes without unit addresses should be ordered alpha-numerically by the node
>> +   name.  For a few types of nodes, they can be ordered by the main property
>> +   (e.g. pin configuration states ordered by value of "pins" property).
>> +
>> +3. When extending nodes in the board DTS via &label, the entries should be
>> +   ordered alpha-numerically.
>> +
>> +Example::
>> +
> 
> Hmm, comments!
> 
>> +	// SoC DTSI
> 
> ....speaking of commenting, should we at least suggest to use C-style comments?
> 
> 	/* SoC DTSI */

I can switch it to C-style in the example, but we are going with Linux
Coding Style which soon will allow // judging by Linus' statements.

> 
>> +
>> +	/ {
>> +		cpus {
>> +			// ...
>> +		};
>> +
>> +		psci {
>> +			// ...
>> +		};
>> +
>> +		soc@ {
>> +			dma: dma-controller@10000 {
>> +				// ...
>> +			};
>> +
>> +			clk: clock-controller@80000 {
>> +				// ...
>> +			};
>> +		};
>> +	};
>> +
>> +	// Board DTS
>> +
>> +	&clk {
>> +		// ...
>> +	};
>> +
>> +	&dma {
>> +		// ...
>> +	};
>> +
>> +
>> +Order of Properties in Device Node
>> +----------------------------------
>> +
>> +Following order of properties in device nodes is preferred:
>> +
>> +1. compatible
>> +2. reg
>> +3. ranges
>> +4. Standard/common properties (defined by common bindings, e.g. without
>> +   vendor-prefixes)
>> +5. Vendor-specific properties
>> +6. status (if applicable)
>> +7. Child nodes, where each node is preceded with a blank line
>> +
>> +The "status" property is by default "okay", thus it can be omitted.
>> +
>> +Example::
>> +
>> +	// SoC DTSI
>> +
>> +	usb_1_hsphy: phy@88e3000 {
>> +		compatible = "qcom,sm8550-snps-eusb2-phy";
>> +		reg = <0x0 0x088e3000 0x0 0x154>;
>> +		#phy-cells = <0>;
>> +		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +		status = "disabled";
>> +	};
> 
> Since this describes vendor-specific properties and vendor prefixes as well
> as standard properties, I think it would be clearer if we use something more
> complex that actually contains those as an example.
> 
> There's a few. One is MediaTek:
> 
> 	vdo1_rdma0: dma-controller@1c104000 {
> 		compatible = "mediatek,mt8195-vdo1-rdma";
> 		reg = <0 0x1c104000 0 0x1000>;
> 		#dma-cells = <1>;
> 		clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
> 		interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
> 		iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
> 		power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> 		mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x4000 0x1000>;
> 	};
> 
> ...or other one can be nVidia:
> 
> 	mipi: mipi@700e3000 {
> 		compatible = "nvidia,tegra210-mipi";
> 		reg = <0x0 0x700e3000 0x0 0x100>;
> 		clocks = <&tegra_car TEGRA210_CLK_MIPI_CAL>;
> 		clock-names = "mipi-cal";
> 		power-domains = <&pd_sor>;
> 		#nvidia,mipi-calibrate-cells = <1>;
> 	};
> 
> ...or we could make an example out of fantasy, which could work even better
> as far as describing goes.
> 
> 	/* SoC DTSI */
> 
> 	device_node: device-class@6789abc {
> 		compatible = "vendor,device";

Yep. I'll use this, unless checkpatch complains about undocumented
compatible. :) This allows to show the child node.

> 		reg = <0 0x06789abc 0 0xa123>;
> 		ranges = <0 0 0x6789abc 0x1000>;
> 		#dma-cells = <1>;
> 		clocks = <&clock_controller SOC_CLOCK>;
> 		clock-names = "dev-clk";
> 		#vendor,custom-cells = <2>;
> 		status = "disabled";
> 
> 		child_node: child-class@100 {
> 			reg = <0x100 0x200>;
> 			/* ... */
> 		};
> 	};
> 
> 	/* Board DTS */
> 
> 	&device_node {
> 		device-supply = <&board_vreg1>;
> 		status = "okay";
> 	}
> 
>> +
>> +	// Board DTS
>> +
>> +	&usb_1_hsphy {
>> +		clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
>> +		clock-names = "ref";
>> +		status = "okay";
>> +	};
>> +
>> +
>> +Indentation
>> +-----------
>> +
>> +1. Use indentation according to :ref:`codingstyle`.
>> +2. For arrays spanning across lines, it is preferred to align the continued
>> +   entries with opening < from the first line.
>> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
>> +   should be enclosed in <>.
>> +
>> +Example::
>> +
>> +	thermal-sensor@c271000 {
>> +		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
>> +		reg = <0x0 0x0c271000 0x0 0x1000>,
>> +		      <0x0 0x0c222000 0x0 0x1000>;
>> +	};
>> +
>> +Organizing DTSI and DTS
>> +-----------------------
>> +
>> +The DTSI and DTS files should be organized in a way representing the common
>> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
> 
>                                          ^^^^
> There's a double space here, it was probably unintentional.

I think I used everywhere double-spaces. At least this was my intention,
so I will fix single-spaces :)


Best regards,
Krzysztof

