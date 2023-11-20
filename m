Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAD7F1259
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjKTLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:43:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF783;
        Mon, 20 Nov 2023 03:43:17 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 271DA6601711;
        Mon, 20 Nov 2023 11:43:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700480596;
        bh=x4MLXpWO/aV1ogNe5RsuKzP1dqnIZbDxe0lhCiPQNfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BnVe493hgYdndPFbDTUozDRDDmiAT45LJkGDzvbyox3bTl5POLPTy/r0MVZKhn15m
         gWoMCo+N6Pn+qwxRVI9ChGCwPaH8X0L4BQ05z4zMQmLzzbZVLy9u6SbxhKm2/lHQa9
         0ASp9J1xveFvuhX7Of2bTQbG5YpBpMzadwgmdNhx2OJGnFh4RZko+Ezqqb4KqFQttw
         eRCkKpc1+A3ZoD/1Qu14IUY8pJ1azwa/c3qwfw4PcZbCoDaHu6J6Wom0E0sq1MJUSS
         H46h6POobMJaxHwi/QDziqB5/neK5zIVcVRGshPzNNQ/5cIqiochdmK6Kf6H15Y50y
         QrgyVzhRUmKqg==
Message-ID: <92cf3bcc-18e7-40ba-a082-1b8b6bea0dee@collabora.com>
Date:   Mon, 20 Nov 2023 12:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/11/23 09:40, Krzysztof Kozlowski ha scritto:
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.
> 
> Cc: Andrew Davis <afd@ti.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Merging idea: Rob/DT bindings
> 
> Changes in v2
> =============
> 1. Hopefully incorporate entire feedback from comments:
> a. Fix \ { => / { (Rob)
> b. Name: dts-coding-style (Rob)
> c. Exceptions for ordering nodes by name for Renesas and pinctrl (Geert,
>     Konrad)
> d. Ordering properties by common/vendor (Rob)
> e. Array entries in <> (Rob)
> 
> 2. New chapter: Organizing DTSI and DTS
> 
> 3. Several grammar fixes (missing articles)
> 
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> ---
>   .../devicetree/bindings/dts-coding-style.rst  | 163 ++++++++++++++++++
>   Documentation/devicetree/bindings/index.rst   |   1 +
>   2 files changed, 164 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst
> 
> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
> new file mode 100644
> index 000000000000..cc7e3b4d1b92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> @@ -0,0 +1,163 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _dtscodingstyle:
> +
> +=====================================
> +Devicetree Sources (DTS) Coding Style
> +=====================================
> +
> +When writing Devicetree Sources (DTS) please observe below guidelines.  They
> +should be considered complementary to any rules expressed already in Devicetree
> +Specification and dtc compiler (including W=1 and W=2 builds).
> +
> +Individual architectures and sub-architectures can add additional rules, making
> +the style stricter.
> +
> +Naming and Valid Characters
> +---------------------------
> +
> +1. Node and property names are allowed to use only:
> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * dash: -
> +
> +2. Labels are allowed to use only:
> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * underscore: _
> +
> +3. Unit addresses should use lowercase hex, without leading zeros (padding).

This is imperative, so: s/should/shall/g

> +
> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
> +   part can be padded with leading zeros.
> +

Same here, I'd say.... :-)

> +Example::
> +
> +	gpi_dma2: dma-controller@800000 {
> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
> +		reg = <0x0 0x00800000 0x0 0x60000>;
> +	}
> +
> +Order of Nodes
> +--------------
> +
> +1. Nodes within any bus, thus using unit addresses for children, shall be
> +   ordered incrementally by unit address.
> +   Alternatively for some sub-architectures, nodes of the same type can be
> +   grouped together (e.g. all I2C controllers one after another even if this
> +   breaks unit address ordering).
> +
> +2. Nodes without unit addresses should be ordered alpha-numerically by the node
> +   name.  For a few types of nodes, they can be ordered by the main property
> +   (e.g. pin configuration states ordered by value of "pins" property).
> +
> +3. When extending nodes in the board DTS via &label, the entries should be
> +   ordered alpha-numerically.
> +
> +Example::
> +

Hmm, comments!

> +	// SoC DTSI

....speaking of commenting, should we at least suggest to use C-style comments?

	/* SoC DTSI */

> +
> +	/ {
> +		cpus {
> +			// ...
> +		};
> +
> +		psci {
> +			// ...
> +		};
> +
> +		soc@ {
> +			dma: dma-controller@10000 {
> +				// ...
> +			};
> +
> +			clk: clock-controller@80000 {
> +				// ...
> +			};
> +		};
> +	};
> +
> +	// Board DTS
> +
> +	&clk {
> +		// ...
> +	};
> +
> +	&dma {
> +		// ...
> +	};
> +
> +
> +Order of Properties in Device Node
> +----------------------------------
> +
> +Following order of properties in device nodes is preferred:
> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. Standard/common properties (defined by common bindings, e.g. without
> +   vendor-prefixes)
> +5. Vendor-specific properties
> +6. status (if applicable)
> +7. Child nodes, where each node is preceded with a blank line
> +
> +The "status" property is by default "okay", thus it can be omitted.
> +
> +Example::
> +
> +	// SoC DTSI
> +
> +	usb_1_hsphy: phy@88e3000 {
> +		compatible = "qcom,sm8550-snps-eusb2-phy";
> +		reg = <0x0 0x088e3000 0x0 0x154>;
> +		#phy-cells = <0>;
> +		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		status = "disabled";
> +	};

Since this describes vendor-specific properties and vendor prefixes as well
as standard properties, I think it would be clearer if we use something more
complex that actually contains those as an example.

There's a few. One is MediaTek:

	vdo1_rdma0: dma-controller@1c104000 {
		compatible = "mediatek,mt8195-vdo1-rdma";
		reg = <0 0x1c104000 0 0x1000>;
		#dma-cells = <1>;
		clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
		interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
		iommus = <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
		power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
		mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x4000 0x1000>;
	};

...or other one can be nVidia:

	mipi: mipi@700e3000 {
		compatible = "nvidia,tegra210-mipi";
		reg = <0x0 0x700e3000 0x0 0x100>;
		clocks = <&tegra_car TEGRA210_CLK_MIPI_CAL>;
		clock-names = "mipi-cal";
		power-domains = <&pd_sor>;
		#nvidia,mipi-calibrate-cells = <1>;
	};

...or we could make an example out of fantasy, which could work even better
as far as describing goes.

	/* SoC DTSI */

	device_node: device-class@6789abc {
		compatible = "vendor,device";
		reg = <0 0x06789abc 0 0xa123>;
		ranges = <0 0 0x6789abc 0x1000>;
		#dma-cells = <1>;
		clocks = <&clock_controller SOC_CLOCK>;
		clock-names = "dev-clk";
		#vendor,custom-cells = <2>;
		status = "disabled";

		child_node: child-class@100 {
			reg = <0x100 0x200>;
			/* ... */
		};
	};

	/* Board DTS */

	&device_node {
		device-supply = <&board_vreg1>;
		status = "okay";
	}

> +
> +	// Board DTS
> +
> +	&usb_1_hsphy {
> +		clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +		clock-names = "ref";
> +		status = "okay";
> +	};
> +
> +
> +Indentation
> +-----------
> +
> +1. Use indentation according to :ref:`codingstyle`.
> +2. For arrays spanning across lines, it is preferred to align the continued
> +   entries with opening < from the first line.
> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
> +   should be enclosed in <>.
> +
> +Example::
> +
> +	thermal-sensor@c271000 {
> +		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> +		reg = <0x0 0x0c271000 0x0 0x1000>,
> +		      <0x0 0x0c222000 0x0 0x1000>;
> +	};
> +
> +Organizing DTSI and DTS
> +-----------------------
> +
> +The DTSI and DTS files should be organized in a way representing the common
> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI

                                         ^^^^
There's a double space here, it was probably unintentional.


Cheers,
Angelo

> +and DTS files into several files:
> +
> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
> +   on the SoC).
> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
> +   entire System-on-Module).
> +3. DTS representing the board.
> +
> +Hardware components which are present on the board should be placed in the
> +board DTS, not in the SoC or SoM DTSI.  A partial exception is a common
> +external reference SoC-input clock, which could be coded as a fixed-clock in
> +the SoC DTSI with its frequency provided by each board DTS.
> diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
> index d9002a3a0abb..cc1fbdc05657 100644
> --- a/Documentation/devicetree/bindings/index.rst
> +++ b/Documentation/devicetree/bindings/index.rst
> @@ -4,6 +4,7 @@
>      :maxdepth: 1
>   
>      ABI
> +   dts-coding-style
>      writing-bindings
>      writing-schema
>      submitting-patches

