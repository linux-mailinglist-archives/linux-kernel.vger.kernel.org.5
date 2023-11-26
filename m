Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04BF7F9235
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKZKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:32:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA96E107
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:32:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b211b0296so1227662a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700994741; x=1701599541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYuuZJEK9h+1QpUeSaJ0pWshYzP5nx3LJhHVIw7CjL8=;
        b=yKbCN6J5NjvB3TrcvAjcHJ1Iu+sKQaU5iHleOSJrwZe390pMbTCF5/GPIqrzYkWubd
         C9FbgRJ+XD+aIZlOFHpoEH2KDWUglVXFH5lqNWQPcfkhgNHyell+z00yfX4kOxOx3hMZ
         RueEQwgvr7QeeRPYM6Ntza40VDrXQ3r35dtKeTHXI77f5IPpiwx/IH/GPQ4iTxU+VeKz
         9bZFeR+UTF6H1SqbF+VQcs4XvBd1LduJ4RTHjiVX5ESttmsY4bOHCM4PE0uxhyieVUAL
         vRy2Q+a+gdxTZa8cs54vu/JQNLYVUEi0u0u05QVb6cbfPXCcb3pY57vkNULl2g/XA8vC
         7i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700994741; x=1701599541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYuuZJEK9h+1QpUeSaJ0pWshYzP5nx3LJhHVIw7CjL8=;
        b=rMo1gyorZ1MgWI4J75m1N0JYbxg8eLTbHHd8FD1oCbma2FcJYXxQjonfrJHJorRrYY
         PRJdJiu0OI+NBt4/6+RHLiNUVyuoP12ShQbi0EywztWYTWxaTB4suuncC1ZxRnmzWJiY
         gTXSed7eJP30WysGw4FANsHL5gMURgmkkJ97U+v7P9IrTyG9+0adBvuQKYKecjH+o0cv
         34/OZNh+NKzlMX9O2xySPg3GR4luIfbAAPvqYHZqSDGqJux1RbfWSielIBg7qE7DZWzH
         7iZHYWt1pZDTRaccqWQtu2TiDflVUsxp13V/wL6VlQyFpurn+j4KlfFO6956BlzhDrtL
         8KYg==
X-Gm-Message-State: AOJu0Ywuo+FEQdG0xFy+txws2+xQPq2wDKI6W6/5BeiuaEt9S5wht/s2
        hVy9bBHpxJOFXJMVhGKU2KOW4g==
X-Google-Smtp-Source: AGHT+IFjGvEFzEll2yE7Qvfb3v0cQsEhtYSDvUL8zzh0hM12lFqj5HVQktvVboONFOsyaeOqWdsKpQ==
X-Received: by 2002:a17:906:297:b0:9ba:2fe3:c97e with SMTP id 23-20020a170906029700b009ba2fe3c97emr6326078ejf.11.1700994741387;
        Sun, 26 Nov 2023 02:32:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906285500b00a0179ebc25esm4426449ejc.85.2023.11.26.02.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:32:20 -0800 (PST)
Message-ID: <26f095ab-c47d-4bcb-9830-4493b1c0cc75@linaro.org>
Date:   Sun, 26 Nov 2023 11:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
 <20231125193737.GD7486@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231125193737.GD7486@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 20:37, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> Thank you for the patch.
> 
> On Sat, Nov 25, 2023 at 07:44:22PM +0100, Krzysztof Kozlowski wrote:
>> Document preferred coding style for Devicetree sources (DTS and DTSI),
>> to bring consistency among all (sub)architectures and ease in reviews.
>>
>> Cc: Andrew Davis <afd@ti.com>
>> cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Chen-Yu Tsai <wens@kernel.org>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Rafał Miłecki <zajec5@gmail.com>
>> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Merging idea: Rob/DT bindings
>>
>> Changes in v3
>> =============
>> 1. should->shall (Angelo)
>> 2. Comments // -> /* (Angelo, Michal)
>> 3. Use imaginary example in "Order of Properties in Device Node"
>>    (Angelo)
>> 4. Added paragraphs for three sections with justifications of chosen
>>    style.
>> 5. Allow two style of ordering overrides in board DTS: alphabetically or
>>    by order of DTSI (Rob).
>> 6. I did not incorporate feedback about, due to lack of consensus and my
>>    disagreement:
>>    a. SoM being DTS without DTSI in "Organizing DTSI and DTS"
>>
>> Changes in v2
>> =============
>> 1. Hopefully incorporate entire feedback from comments:
>> a. Fix \ { => / { (Rob)
>> b. Name: dts-coding-style (Rob)
>> c. Exceptions for ordering nodes by name for Renesas and pinctrl (Geert,
>>    Konrad)
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
>> Cc: workflows@vger.kernel.org
>> Cc: linux-doc@vger.kernel.org
>> ---
>>  .../devicetree/bindings/dts-coding-style.rst  | 194 ++++++++++++++++++
>>  Documentation/devicetree/bindings/index.rst   |   1 +
>>  2 files changed, 195 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst
>>
>> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
>> new file mode 100644
>> index 000000000000..e374bec0f555
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>> @@ -0,0 +1,194 @@
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
>> +Devicetree specification allows broader range of characters in node and
> 
> s/Devicetree specification/The Devicetree specification/
> s/broader range/a broad range/

Ack, but I really expect people finish with grammar and style fixes at
v3. Please point the language things now or just let it go.

> 
>> +property names, but for code readability the choice shall be narrowed.
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
>> +3. Unit addresses shall use lowercase hex, without leading zeros (padding).
> 
> I'm curious, what's the reason for this ? I think it makes the sources
> less readable. If the rule is "just" because that's how DT sources are
> written today and it would be too complicated to change that, that's
> fine with me.

Warning (unit_address_format): /cpus/cpu@0100: unit name should not have
leading 0s

And we fixed all or most of DTS some time ago.

> 
>> +
>> +4. Hex values in properties, e.g. "reg", shall use lowercase hex.  The address
>> +   part can be padded with leading zeros.
>> +
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
>> +2. Nodes without unit addresses shall be ordered alpha-numerically by the node
>> +   name.  For a few types of nodes, they can be ordered by the main property
>> +   (e.g. pin configuration states ordered by value of "pins" property).
>> +
>> +3. When extending nodes in the board DTS via &label, the entries shall be
>> +   ordered either alpha-numerically or by keeping the order from DTSI (choice
>> +   depending on sub-architecture).
>> +
>> +Above ordering rules are easy to enforce during review, reduce chances of
>> +conflicts for simultaneous additions (new nodes) to a file and help in
>> +navigating through the DTS source.
>> +
>> +Example::
>> +
>> +	/* SoC DTSI */
>> +
>> +	/ {
>> +		cpus {
>> +			/* ... */
>> +		};
>> +
>> +		psci {
>> +			/* ... */
>> +		};
>> +
>> +		soc@ {
>> +			dma: dma-controller@10000 {
>> +				/* ... */
>> +			};
>> +
>> +			clk: clock-controller@80000 {
>> +				/* ... */
>> +			};
>> +		};
>> +	};
>> +
>> +	/* Board DTS - alphabetical order */
>> +
>> +	&clk {
>> +		/* ... */
>> +	};
>> +
>> +	&dma {
>> +		/* ... */
>> +	};
>> +
>> +	/* Board DTS - alternative order, keep as DTSI */
>> +
>> +	&dma {
>> +		/* ... */
>> +	};
>> +
>> +	&clk {
>> +		/* ... */
>> +	};
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
>> +Above order follows approach:
>> +
>> +1. Most important properties start the node: compatible then bus addressing to
>> +   match unit address.
>> +2. Each node will have common properties in similar place.
>> +3. Status is the last information to annotate that device node is or is not
>> +   finished (board resources are needed).
>> +
>> +Example::
>> +
>> +	/* SoC DTSI */
>> +
>> +	device_node: device-class@6789abc {
>> +		compatible = "vendor,device";
>> +		reg = <0x0 0x06789abc 0x0 0xa123>;
>> +		ranges = <0x0 0x0 0x06789abc 0x1000>;
>> +		#dma-cells = <1>;
>> +		clocks = <&clock_controller 0>, <&clock_controller 1>;
>> +		clock-names = "bus", "host";
>> +		vendor,custom-property = <2>;
>> +		status = "disabled";
>> +
>> +		child_node: child-class@100 {
>> +			reg = <0x100 0x200>;
>> +			/* ... */
>> +		};
>> +	};
>> +
>> +	/* Board DTS */
>> +
>> +	&device_node {
>> +		vdd-supply = <&board_vreg1>;
>> +		status = "okay";
>> +	}
>> +
>> +Indentation
>> +-----------
>> +
>> +1. Use indentation according to :ref:`codingstyle`.
>> +2. For arrays spanning across lines, it is preferred to align the continued
>> +   entries with opening < from the first line.
>> +3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
>> +   shall be enclosed in <>.
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
>> +The DTSI and DTS files shall be organized in a way representing the common
>> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
>> +and DTS files into several files:
>> +
>> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
>> +   on the SoC).
>> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
>> +   entire System-on-Module).
>> +3. DTS representing the board.
>> +
>> +Hardware components which are present on the board shall be placed in the
>> +board DTS, not in the SoC or SoM DTSI.  A partial exception is a common
>> +external reference SoC-input clock, which could be coded as a fixed-clock in
>> +the SoC DTSI with its frequency provided by each board DTS.
> 
> I'm looking forward to discussing how to organize overlays. That
> discussion should be separate though, or this patch will never get
> merged :-)
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks

Best regards,
Krzysztof

