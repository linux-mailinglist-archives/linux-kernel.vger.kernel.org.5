Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018697F166E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjKTOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKTOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:54:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275453255
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:53:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so5672773a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700492011; x=1701096811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ET7XZBuYSIsGm9CmNHfDH0i0uNlWweXSO9s0Phl8jmQ=;
        b=G8KOGDNC2GPE4Oe5Ed8Rz72LIR+1xnWFJDYRi3KffyMW5Uej193i1DILprSIsLRvtF
         33bKUVpd11am5xY2IIuYjTJDKLQk5al9/4vUWT+XEwbQE7NQZY6IakIIoSz51pwsZJ1D
         60IJYAkNADXmII+Qw22z+bjiyX0/vzorJegrlqF7AyitpEB+7PRufL4cySZcxzf/JRej
         QEHGfpkcJ8NLiQxrVgMG6uS1KtjhTBo6oO7BrdE+cKHJj6ps7QCL9FSoVWNjtNl1AY1s
         Yf83fDi2kiiLHg0W6lfxNVBcp26Az8Q+LjHZGtTJKvC9oNesLQKMWQJfFrzswXNaAAMU
         dCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700492011; x=1701096811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET7XZBuYSIsGm9CmNHfDH0i0uNlWweXSO9s0Phl8jmQ=;
        b=ZWQ2ymMmeGeqr5drJw6BaeXafcV6nveJTrTmkMsJtLGkBjTQxTdUsETod2j0R7paHv
         pjip67cEqzzg4BYgZVMISNOQX7Zi+HcWHpfOhQB0/igMhGJiKv9pDepJoJxeONKaszA6
         WtfPmOQX5Q/kIjk/gV4Us9/06HqzxjUX6ZtOt94DZKoqkOJx9eG80xH66nFesAN8/CVi
         iOn9aUER8MOxiH2axBuxsN+v7XS5/noEDEqPjSBqExfXNU//ZMg7pXXRlGYlLSjf3KgF
         Pw3kNoejs7ADZfKRxp2v6jnckMt3WtE0gr2ADGkztFXlndFc3qsnD0uqbq2DVRXvz2iH
         9Cnw==
X-Gm-Message-State: AOJu0YyEHikOwoHg3do6ohBBt9/sqsuKAmluE9deGOJQpnkifn1mtODA
        AuB9jQYTjcFHWLKqgxMFjtxilA==
X-Google-Smtp-Source: AGHT+IEiFXQNRTpLbffWwIB/ESoK8FBLpW5+d9rBzMckIo8AyjTDOyxsOL6c6QHe60c5kV4WSWbqHA==
X-Received: by 2002:aa7:c588:0:b0:548:e8aa:dfc8 with SMTP id g8-20020aa7c588000000b00548e8aadfc8mr291110edq.32.1700492011605;
        Mon, 20 Nov 2023 06:53:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7cc03000000b0054847e78203sm3387002edt.29.2023.11.20.06.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:53:31 -0800 (PST)
Message-ID: <76fa8f61-fe31-4040-a38d-cc05be3f4f17@linaro.org>
Date:   Mon, 20 Nov 2023 15:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <19358871-009d-4498-9c13-90d5338b1e9f@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <19358871-009d-4498-9c13-90d5338b1e9f@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/11/2023 15:01, Michal Simek wrote:
> 
> 
> On 11/20/23 09:40, Krzysztof Kozlowski wrote:
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
> 
> device-tree specification v0.4. Chapter 2.2.1/Table 2.1 is describing much more
> valid characters for node names.
> It means above description is not accurate or DT spec should be updated.

Spec allows way to much. dtc doesn't. One thing is the spec, second
thing is coding style.

> 
> 
>> +
>> +2. Labels are allowed to use only:
>> +
>> +   * lowercase characters: [a-z]
>> +   * digits: [0-9]
>> +   * underscore: _
> 
> based on dt spec uppercase is also valid char in label.

Which we do not want in the DTS.

> 
> 
>> +
>> +3. Unit addresses should use lowercase hex, without leading zeros (padding).
>> +
>> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
>> +   part can be padded with leading zeros.
>> +
>> +Example::
>> +
>> +	gpi_dma2: dma-controller@800000 {
>> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
>> +		reg = <0x0 0x00800000 0x0 0x60000>;
> 
> Is 0x0 recommended or 0 is enough?

I don't want to impose any rule on that, because someone would like to
argue that hex should be also in SPI chip-select reg.

> 
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
>> +	// SoC DTSI
> 
> Same comment about /* */ as was mentioned in another thread.
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
> 
> Isn't the order already defined in DT spec in 2.3 in chapters?

Where is it defined as this is preferred order?

> compatible
> model
> status
> #address/size cells
> reg
> virtual-reg
> ranges
> dma-ranges
> dma-coherent
> dma-non-coherent
> 
> Again I am fine with whatever order but I think we should reflect it in the spec 

Spec is not a coding style.

> too. Especially status property is for my taste too low simply because you start 
> to read and then you will find that IP is disabled.

Which is exactly what you want. status is irrelevant for hardware
description, so should be the last item.

> 
> And are you describing all properties starting with # as standard properties?

Yes.

> 
> 
>> +
>> +The "status" property is by default "okay", thus it can be omitted.
>> +
>> +Example::
>> +
>> +	// SoC DTSI
> 
> 
> /* */
> 
>> +
>> +	usb_1_hsphy: phy@88e3000 {
>> +		compatible = "qcom,sm8550-snps-eusb2-phy";
>> +		reg = <0x0 0x088e3000 0x0 0x154>;
>> +		#phy-cells = <0>;
>> +		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +		status = "disabled";
>> +	};
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
>> +and DTS files into several files:
>> +
>> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
>> +   on the SoC).
>> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
>> +   entire System-on-Module).
> 
> DTS/DTSI - SOMs can actually run as they are that's why it is fair to say that
> there doesn't need to be DTS representing the board.

I have never seen a SoM which can run without elaborate hardware-hacking
(e.g. connecting multiple wires to the SoM pins). The definition of the
SoM is that it is a module. Module can be re-used, just like SoC.

Best regards,
Krzysztof

