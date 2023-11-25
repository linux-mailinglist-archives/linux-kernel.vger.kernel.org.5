Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9967F8E31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjKYTsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjKYTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:48:03 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2391B3;
        Sat, 25 Nov 2023 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4nRmKJdjQImKVKvkDXekyzERU99Y30X50Uk5jPOijCY=; b=bUmqga52u5ZN8KifEwNMhDyiPA
        /TFQjbAbx8fGQdVoi5rxm3COj3rEclulLj+6FXL2nSiYCSRdIJATu8HKoN1nlR6IkXp7sCExgIBLI
        hFkayCNKWWXkftJV69lR8n3hiDzcRi5PHnunbIvWKayKCR9g0p4/sDxM6C9tR4lEehPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6yd5-001Czk-9T; Sat, 25 Nov 2023 20:47:51 +0100
Date:   Sat, 25 Nov 2023 20:47:51 +0100
From:   Andrew Lunn <andrew@lunn.ch>
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
        Arnd Bergmann <arnd@arndb.de>,
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
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Message-ID: <a3b65c90-afc9-4caf-8744-112369a838d2@lunn.ch>
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It would be nice to add a pointer where such rules are documented.

> +Naming and Valid Characters
> +---------------------------
> +
> +Devicetree specification allows broader range of characters in node and
> +property names, but for code readability the choice shall be narrowed.
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
> +3. Unit addresses shall use lowercase hex, without leading zeros (padding).
> +
> +4. Hex values in properties, e.g. "reg", shall use lowercase hex.  The address
> +   part can be padded with leading zeros.
> +
> +Example::
> +
> +	gpi_dma2: dma-controller@800000 {

Not the best of example. Upper case 8 does not exist, as far as i
known. 

> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
> +		reg = <0x0 0x00800000 0x0 0x60000>;

Maybe introduce some [a-f] in the example reg?

> +Order of Nodes
> +--------------
> +
> +1. Nodes within any bus, thus using unit addresses for children, shall be
> +   ordered incrementally by unit address.
> +   Alternatively for some sub-architectures, nodes of the same type can be
> +   grouped together (e.g. all I2C controllers one after another even if this
> +   breaks unit address ordering).
> +
> +2. Nodes without unit addresses shall be ordered alpha-numerically by the node
> +   name.  For a few types of nodes, they can be ordered by the main property
> +   (e.g. pin configuration states ordered by value of "pins" property).
> +
> +3. When extending nodes in the board DTS via &label, the entries shall be
> +   ordered either alpha-numerically or by keeping the order from DTSI (choice
> +   depending on sub-architecture).

Are these sub-architecture choices documented somewhere? Can you
include a hint which they are?

> +Example::
> +
> +	/* SoC DTSI */
> +
> +	/ {

Dumb question. Does this open { indicate the start of a bus?

> +		cpus {
> +			/* ... */
> +		};
> +
> +		psci {
> +			/* ... */
> +		};

If that does indicate a bus, the nodes above are ordered
alpha-numerically, according to 2).

> +
> +		soc@ {

This has a unit address, even if its missing, so should be sorted by
1).

Should there be something in the coding style that 2) comes before 1)
on the bus? And if that is true, don't you think it would make sense
to swap 1) and 2) in the description above?

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

Do you imaging there will ever be a checkpatch for DT files? The
second alternative seems pretty difficult to check for with tools. You
need to include all the .dtsi files to determine the ordered tree,
then flatten it to get the properties order. Should we discourage this
alternative?

> +Indentation
> +-----------
> +
> +1. Use indentation according to :ref:`codingstyle`.
> +2. For arrays spanning across lines, it is preferred to align the continued
> +   entries with opening < from the first line.
> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
> +   shall be enclosed in <>.
> +
> +Example::
> +
> +	thermal-sensor@c271000 {
> +		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> +		reg = <0x0 0x0c271000 0x0 0x1000>,
> +		      <0x0 0x0c222000 0x0 0x1000>;
> +	};

I'm not sure i understand this. Is this example correct?

                gpio-fan,speed-map = <0    0
                                      3000 1
                                      6000 2>;

It exists a lot in todays files.


> +The DTSI and DTS files shall be organized in a way representing the common
> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
> +and DTS files into several files:
> +
> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
> +   on the SoC).

Maybe point out that SoC DTSI files can by hierarchical when there is
a family of SoCs. You often have one .DTSI file for all the common
parts of a family. And then each member of the family has a .dtsi file
which includes the core, and then adds properties for that member of
the family.

The word 'entire' probably gives the wrong idea about this.

    Andrew
