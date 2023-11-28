Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6976C7FC484
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjK1UAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1UAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:00:32 -0500
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E31988;
        Tue, 28 Nov 2023 12:00:36 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1701201632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wYb/GUEkDLuiWov3VEkZzczMRFikFDwiXekyYjTN0Dg=;
        b=W08pnFnq6t8Fg6T5gRh2If81BIdz3DBQ2lVK+iziXEuXroyeZk3d7wonvjnZkm0cSX+iKE
        jeJbyMJBVb42neg66WT/ouE/Uaxm0fK5SsoTf8X/siXVueTQb/HL7qVrR2EfAvyiZEYmW5
        XR3zERg/Zpp4Kx5J5SelvbsNpRRXsABWjU3EjNa2Hw7LZFaUrEyE/81P7dZQzuANeCHXQA
        RT5OATV5OwaDnpPEHMSD5Yxo1HDQu5S0PRIkttrrKSD/sJwL9HjdleQRf605jISsgO8ONi
        9vrlMJ+MDDIcG5h/zRpsQ5LU/AYbX0Pc1STb85bHQn9v14y/9zsH8WsGutW4Tw==
Date:   Tue, 28 Nov 2023 21:00:30 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
In-Reply-To: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
Message-ID: <63ec18b2758a9e385f446fb00b60ee69@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 2023-11-25 19:44, Krzysztof Kozlowski wrote:
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.
> 
> Cc: Andrew Davis <afd@ti.com>
> cc: Andrew Lunn <andrew@lunn.ch>
> Cc: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Chen-Yu Tsai <wens@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Merging idea: Rob/DT bindings
> 
> Changes in v3
> =============
> 1. should->shall (Angelo)
> 2. Comments // -> /* (Angelo, Michal)
> 3. Use imaginary example in "Order of Properties in Device Node"
>    (Angelo)
> 4. Added paragraphs for three sections with justifications of chosen
>    style.
> 5. Allow two style of ordering overrides in board DTS: alphabetically 
> or
>    by order of DTSI (Rob).
> 6. I did not incorporate feedback about, due to lack of consensus and 
> my
>    disagreement:
>    a. SoM being DTS without DTSI in "Organizing DTSI and DTS"

I went through the language of the entire patch, after the notice that 
the v4 would no longer accept language improvements.  My wording- and 
grammar-related suggestions are available inline below.

> Changes in v2
> =============
> 1. Hopefully incorporate entire feedback from comments:
> a. Fix \ { => / { (Rob)
> b. Name: dts-coding-style (Rob)
> c. Exceptions for ordering nodes by name for Renesas and pinctrl 
> (Geert,
>    Konrad)
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
> Cc: workflows@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
>  .../devicetree/bindings/dts-coding-style.rst  | 194 ++++++++++++++++++
>  Documentation/devicetree/bindings/index.rst   |   1 +
>  2 files changed, 195 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/dts-coding-style.rst
> 
> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst
> b/Documentation/devicetree/bindings/dts-coding-style.rst
> new file mode 100644
> index 000000000000..e374bec0f555
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> @@ -0,0 +1,194 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _dtscodingstyle:
> +
> +=====================================
> +Devicetree Sources (DTS) Coding Style
> +=====================================
> +
> +When writing Devicetree Sources (DTS) please observe below guidelines. 
>  They

The sentence above should be replaced with: "The following guidelines 
are to be followed when writing Devicetree Source (DTS) files."

> +should be considered complementary to any rules expressed already in 
> Devicetree
> +Specification and dtc compiler (including W=1 and W=2 builds).

A definite article ("the") should be added before "Devicetree 
Specification" and "dtc".  Also, "Specification" in "Devicetree 
Specification" should be capitalized.

> +
> +Individual architectures and sub-architectures can add additional 
> rules, making
> +the style stricter.

"Sub-architectures" should be replaced with "subarchitectures".  "Can 
add" should be replaced with "can define".   "Style" should be replaced 
with "coding style".

> +
> +Naming and Valid Characters
> +---------------------------
> +
> +Devicetree specification allows broader range of characters in node 
> and
> +property names, but for code readability the choice shall be narrowed.

The definite article ("the") should be added before "Devicetree 
Specification", and "specification" should be capitalised.  As already 
suggested, "broader range" should be replaced with "a broad range".  
"But for code readability the choice shall be narrowed" should be 
replaced with "but this coding style narrows the range down to achieve 
better code readability".

> +
> +1. Node and property names are allowed to use only:

"Are allowed to" should be replaced with "can".  After "only", "the 
following characters" should be added.

> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * dash: -

List items should be capitalized, i.e. "Lowercase characters" should be 
used instead of "lowercase characters", etc.

> +
> +2. Labels are allowed to use only:

"Are allowed to" should be replaced with "can".  After "only", "the 
following characters" should be added.

> +
> +   * lowercase characters: [a-z]
> +   * digits: [0-9]
> +   * underscore: _

List items should be capitalized, i.e. "Lowercase characters" should be 
used instead of "lowercase characters", etc.

> +
> +3. Unit addresses shall use lowercase hex, without leading zeros 
> (padding).

"Lowercase hex" should be replaced with "lowercase hexadecimal digits".

> +
> +4. Hex values in properties, e.g. "reg", shall use lowercase hex.  The 
> address
> +   part can be padded with leading zeros.

"Hex values" should be replaced with "Hexadecimal values".  "Lowercase 
hex" should be replaced with "lowercase hexadecimal digits".

> +
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
> +1. Nodes within any bus, thus using unit addresses for children, shall 
> be

"Within" should be replaced "on".

> +   ordered incrementally by unit address.

Should be replaced with "ordered by unit address in ascending order".

> +   Alternatively for some sub-architectures, nodes of the same type 
> can be
> +   grouped together (e.g. all I2C controllers one after another even 
> if this
> +   breaks unit address ordering).

"Sub-architectures" should be replaced with "subarchitectures".  The 
"(e.g. ...)" form should be replaced with ", e.g. ...".

> +
> +2. Nodes without unit addresses shall be ordered alpha-numerically by 
> the node
> +   name.  For a few types of nodes, they can be ordered by the main 
> property
> +   (e.g. pin configuration states ordered by value of "pins" 
> property).

"Alpha-numerically" should be replaced with "alphabetically".  "Types of 
nodes" should be replaced with "node types".  The "(e.g. ...)" form 
should be replaced with ", e.g. ...".

> +
> +3. When extending nodes in the board DTS via &label, the entries shall 
> be
> +   ordered either alpha-numerically or by keeping the order from DTSI 
> (choice
> +   depending on sub-architecture).

"Alpha-numerically" should be replaced with "alphabetically".  
"Sub-architecture" should be replaced with "subarchitecture".  "(Choice 
depending on sub-architecture)" should be replaced with ", where the 
choice depends on the subarchitecture".

> +
> +Above ordering rules are easy to enforce during review, reduce chances 
> of
> +conflicts for simultaneous additions (new nodes) to a file and help in
> +navigating through the DTS source.

"Above" should be replaced with "The above-described".  "(New nodes)" 
should be replaced with "of new nodes".

> +
> +Example::
> +
> +	/* SoC DTSI */
> +
> +	/ {
> +		cpus {
> +			/* ... */
> +		};
> +
> +		psci {
> +			/* ... */
> +		};
> +
> +		soc@ {
> +			dma: dma-controller@10000 {
> +				/* ... */
> +			};
> +
> +			clk: clock-controller@80000 {
> +				/* ... */
> +			};
> +		};
> +	};
> +
> +	/* Board DTS - alphabetical order */
> +
> +	&clk {
> +		/* ... */
> +	};
> +
> +	&dma {
> +		/* ... */
> +	};
> +
> +	/* Board DTS - alternative order, keep as DTSI */
> +
> +	&dma {
> +		/* ... */
> +	};
> +
> +	&clk {
> +		/* ... */
> +	};
> +
> +Order of Properties in Device Node
> +----------------------------------
> +
> +Following order of properties in device nodes is preferred:

"Following" should be replaced with "The following".

> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. Standard/common properties (defined by common bindings, e.g. 
> without
> +   vendor-prefixes)
> +5. Vendor-specific properties
> +6. status (if applicable)
> +7. Child nodes, where each node is preceded with a blank line
> +
> +The "status" property is by default "okay", thus it can be omitted.
> +
> +Above order follows approach:

The last sentence should be replaced with "The above-described ordering 
follows this approach:".

> +
> +1. Most important properties start the node: compatible then bus 
> addressing to
> +   match unit address.
> +2. Each node will have common properties in similar place.
> +3. Status is the last information to annotate that device node is or 
> is not
> +   finished (board resources are needed).
> +
> +Example::
> +
> +	/* SoC DTSI */
> +
> +	device_node: device-class@6789abc {
> +		compatible = "vendor,device";
> +		reg = <0x0 0x06789abc 0x0 0xa123>;
> +		ranges = <0x0 0x0 0x06789abc 0x1000>;
> +		#dma-cells = <1>;
> +		clocks = <&clock_controller 0>, <&clock_controller 1>;
> +		clock-names = "bus", "host";
> +		vendor,custom-property = <2>;
> +		status = "disabled";
> +
> +		child_node: child-class@100 {
> +			reg = <0x100 0x200>;
> +			/* ... */
> +		};
> +	};
> +
> +	/* Board DTS */
> +
> +	&device_node {
> +		vdd-supply = <&board_vreg1>;
> +		status = "okay";
> +	}
> +
> +Indentation
> +-----------
> +
> +1. Use indentation according to :ref:`codingstyle`.
> +2. For arrays spanning across lines, it is preferred to align the 
> continued
> +   entries with opening < from the first line.
> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO 
> addresses)
> +   shall be enclosed in <>.

The "(e.g. ...)" form should be replaced with ", e.g. ...,".

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
> +The DTSI and DTS files shall be organized in a way representing the 
> common
> +(and re-usable) parts of the hardware.  Typically this means 
> organizing DTSI

The "(and re-usable)" form should be replaced with ", reusable".  "The 
hardware" should be replaced with "hardware".  A comma should be added 
after "Typically".

> +and DTS files into several files:
> +
> +1. DTSI with contents of the entire SoC (without nodes for hardware 
> not present
> +   on the SoC).
> +2. If applicable: DTSI with common or re-usable parts of the hardware 
> (e.g.
> +   entire System-on-Module).
> +3. DTS representing the board.

The "(...)" forms should be replaced with ", ...".  Periods at the ends 
of list items should be deleted, because those aren't real, complete 
sentences.

> +
> +Hardware components which are present on the board shall be placed in 
> the

"Which" should be replaced with "that".

> +board DTS, not in the SoC or SoM DTSI.  A partial exception is a 
> common
> +external reference SoC-input clock, which could be coded as a 
> fixed-clock in

"SoC-input" should be replaced with "SoC input".

> +the SoC DTSI with its frequency provided by each board DTS.
> diff --git a/Documentation/devicetree/bindings/index.rst
> b/Documentation/devicetree/bindings/index.rst
> index d9002a3a0abb..cc1fbdc05657 100644
> --- a/Documentation/devicetree/bindings/index.rst
> +++ b/Documentation/devicetree/bindings/index.rst
> @@ -4,6 +4,7 @@
>     :maxdepth: 1
> 
>     ABI
> +   dts-coding-style
>     writing-bindings
>     writing-schema
>     submitting-patches
