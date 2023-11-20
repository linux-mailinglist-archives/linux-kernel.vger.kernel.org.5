Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91D7F0CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjKTHT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjKTHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:19:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AFA2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:19:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso5687429a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700464792; x=1701069592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hg+bpY74pcdJD4VqD9iJjZ8EPmhWBj00aMuwTv1+jZU=;
        b=uMjtz1YCTUFyadjjBshiuxPOTSu9jA7z0rsCz3vWZsJeg9P1Vw6lYXBdB2O6Jorq6n
         z23tQggDECSk4RB2jOEqL1LUd5L4CxsMa8u1mV7XvzVs0slVppBpxsrISR7ASHNyCqD8
         mqsFMgsoG/ikUj4mcqrobIj3HOrRZyGoi/snCcwdx1/LmaFMAcwjQDT80M8rq9/9klzc
         0ZDvXgSLReSMjXxE5lGZU7aHYzpK5hUj4tm5F0xfaPJE+KOI+Gn7ZkCec6kFHEwMkEbt
         rMr43aB+MK8WNXD+xDhz33xxaV+O5ks7R5fb8JoJVbXrQ0VgpV4J1muvm4CGG6ZUEUxR
         bAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464792; x=1701069592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg+bpY74pcdJD4VqD9iJjZ8EPmhWBj00aMuwTv1+jZU=;
        b=qve0EyeZy96uxf1FUZszKVOjFiohvAtlF/RPWkkogUCujcOmyKfaWAh1H0YruEza4T
         xtozsYkLSsxRoIawPoTs0/pARX8MbjVJuXk2iw0VSND9eO4RWsrESo3tLjmCWLYD1iJd
         8X4rFqaK7T/sz41y6x8jvtqTXSJdX8idKRTa0m6szp165eSM69myIvmLBBzRh5MlRjSE
         6G1QeJhJrcI6czwvSzKvup8IGaLc8VWwRRRIDcjlJ0HF2rWePdMmQlT1luVdjWZLUr0Y
         6zSoo9IA2YEPdGyLTaVIq0U8WIUlmVudKGMaK1We6m1kf44fks4Xf2db/9LINWgI8TjS
         5D/g==
X-Gm-Message-State: AOJu0Yy4V4jHdOOJOmwyDS4+fnAk/kPXn8uII4ze3srX2G6wLmUkhq7+
        wRiHLZ4PZ4KiMAA2TaZF9p7cFQ==
X-Google-Smtp-Source: AGHT+IEQODGwM8mZ2iNoyNdarB1zO6/0jkoy5Ew/n+x9SohD56JZb4gN0hKqkRFXByT2EFGXA9YJkw==
X-Received: by 2002:aa7:d68f:0:b0:548:92fb:d3bd with SMTP id d15-20020aa7d68f000000b0054892fbd3bdmr3335621edr.16.1700464792056;
        Sun, 19 Nov 2023 23:19:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id s24-20020a056402165800b00548ab1abc75sm1120332edx.51.2023.11.19.23.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 23:19:50 -0800 (PST)
Message-ID: <0080b7cb-c23a-48b1-8e5e-02c80baf00e7@linaro.org>
Date:   Mon, 20 Nov 2023 08:19:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqLxKWXVXp6+-yNxvHifZHEDvMdQChR7AHD9STJw_S9UiA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAL_JsqLxKWXVXp6+-yNxvHifZHEDvMdQChR7AHD9STJw_S9UiA@mail.gmail.com>
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

On 16/11/2023 21:44, Rob Herring wrote:
>>
>> Merging idea: Rob/DT bindings
>> ---
>>  Documentation/devicetree/bindings/index.rst   |   1 +
>>  .../devicetree/bindings/writing-dts.rst       | 137 ++++++++++++++++++
>>  2 files changed, 138 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/writing-dts.rst
> 
> Perhaps dts-coding-style.rst

Ack

> 
> After adding writing-schema, I realized the difference between
> writing-schema and writing-bindings isn't all that clear. I never got
> around to renaming things.
> 
>>
>> diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
>> index d9002a3a0abb..975449be4862 100644
>> --- a/Documentation/devicetree/bindings/index.rst
>> +++ b/Documentation/devicetree/bindings/index.rst
>> @@ -5,5 +5,6 @@
>>
>>     ABI
>>     writing-bindings
>> +   writing-dts
>>     writing-schema
>>     submitting-patches
>> diff --git a/Documentation/devicetree/bindings/writing-dts.rst b/Documentation/devicetree/bindings/writing-dts.rst
>> new file mode 100644
>> index 000000000000..10c477ec1eed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/writing-dts.rst
>> @@ -0,0 +1,137 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. _writingdts:
>> +
>> +===================================================
>> +Writing Devicetree Sources (DTS) - DTS Coding Style
>> +===================================================
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
>> +   * lowercase characters:: [a-z]
>> +   * digits:: [0-9]
>> +   * dash:: -
>> +
>> +2. Labels are allowed to use only:
>> +
>> +   * lowercase characters:: [a-z]
>> +   * digits:: [0-9]
>> +   * underscore:: _
>> +
>> +3. Unit addresses should use lowercase hex, without leading zeros (padding).
> 
> Strictly speaking, the unit-address is whatever a bus defines, but
> yes, by default, that is the format.
> 
>> +
>> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  Any address
>> +   part can be padded with leading zeros.
>> +
>> +Example::
>> +
>> +       gpi_dma2: dma-controller@800000 {
>> +               compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
>> +               reg = <0x0 0x00800000 0x0 0x60000>;
>> +       }
>> +
>> +Order of Nodes
>> +--------------
>> +
>> +1. Nodes within any bus, thus using unit addresses for children, shall be
>> +   ordered incrementally by unit address.
>> +
>> +2. Nodes without unit addresses should be ordered alpha-numerically.
>> +
>> +3. When extending nodes in board DTS via &label, the entries should be ordered
>> +   alpha-numerically.
> 
> Or matching the original node definition order?

If there is any sub-arch using such style, then sure, why not. Otherwise
if we do not have such examples, I find that a bit tricky to implement:
for patches adding new board, one needs to check the original DTSI for
order.

> 
>> +
>> +Example::
>> +
>> +       // SoC DTSI
>> +
>> +       \ {
> 
> / {
> 
>> +               cpus {
>> +                       // ...
>> +               };
>> +
>> +               psci {
>> +                       // ...
>> +               };
>> +
>> +               soc@ {
>> +                       dma: dma-controller@10000 {
>> +                               // ...
>> +                       };
>> +
>> +                       clk: clock-controller@80000 {
>> +                               // ...
>> +                       };
>> +               };
>> +       };
>> +
>> +       // Board DTS
>> +
>> +       &clk {
>> +               // ...
>> +       };
>> +
>> +       &dma {
>> +               // ...
>> +       };
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
> 
>> +4. All properties with values
>> +5. Boolean properties
> 
> I make this like schemas, standard/common properties first, then
> vendor specific properties.

Sure.

> 
>> +6. status (if applicable)
>> +7. Child nodes
>> +
>> +The "status" property is by default "okay", thus it can be omitted.
>> +
>> +Example::
>> +
>> +       // SoC DTSI
>> +
>> +       usb_1_hsphy: phy@88e3000 {
>> +               compatible = "qcom,sm8550-snps-eusb2-phy";
>> +               reg = <0x0 0x088e3000 0x0 0x154>;
>> +               #phy-cells = <0>;
>> +               resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +               status = "disabled";
>> +       };
>> +
>> +       // Board DTS
>> +
>> +       &usb_1_hsphy {
>> +               clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
>> +               clock-names = "ref";
>> +               status = "okay";
>> +       };
>> +
>> +
>> +Indentation
>> +-----------
>> +
>> +1. Use indentation according to :ref:`codingstyle`.
>> +2. For arrays spanning across lines, preferred is to align the continued
>> +   entries with opening < from first line.
>> +
>> +Example::
>> +
>> +       thermal-sensor@c271000 {
>> +               compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
>> +               reg = <0x0 0x0c271000 0x0 0x1000>,
>> +                     <0x0 0x0c222000 0x0 0x1000>;
> 
> You should cover the <> style too, meaning <> around each logical entry.

Ack.



Best regards,
Krzysztof

