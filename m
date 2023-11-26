Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A217F924B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjKZKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:38:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057DF0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:38:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso2647773a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700995121; x=1701599921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SunkpNocYhKcmBWJYBXPU1CYyV/WEdO1+cjs6noOPVk=;
        b=m0yDPfgySKVAaSWOd+/xaQsmt7HhCsfJIfOhGxRmDg8AurRxT/oy3HUVxsn2jJmBJy
         d/vMd2M0k7BcANx5v6PAhBY2yfthTmFCKPwEegpeCX+ZgjLNyLgp+/OSpyW41jAWVbYd
         uk9GKAnWNtS2ohclNC/cwNhw8d48X/uXAnTmLwGMhKnPZJUVX2PrKIs8htjQu4FPa9d7
         zZ/HRmoIz5dGOtB+6vqP8XkKtGyuzJUFLmCaBkUN8lf1fk5H2uFmjhsciiEu4DLWtVs0
         sviIP5myVUxM3N1UQJmgrTElcUmwCSz90IjYnsk05xf+9lWvvE7/LAJop3ZC3lGUzLjP
         TJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700995121; x=1701599921;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SunkpNocYhKcmBWJYBXPU1CYyV/WEdO1+cjs6noOPVk=;
        b=KmTo5mXhLV/uJ7P+FHLkD7UT5tfWVpmcbYLHIVBHbSmSu+hWXpnNsTsynW2nx/niD2
         oGfLZnZrufDHihKVRE9qiHcEbW8quMCpOW40maXV/s44D0N8oxz9qjHrvPPyf2YorgVI
         QSL9amWiAti9XNWaZI6764+3PYBVHoMkD+6wLyUym2SfaaFqTwVxancT3ni1U6Q9Cxic
         hKZ37H7AOGwp2X3+IOqp2iD7PRJA+qoJbQ4qbvjuo5tKzzjXWvcu6vqmS1jIw7ZKr/wz
         HHQ4iuXHz7sAra4UTi+vG8TMvQyklJi0PIvHcVgiMFdR+B3UsDWdcfuJ/s2bC9Ym4cGb
         +5Cg==
X-Gm-Message-State: AOJu0Yxg3BLF+oQK/5BcvxBbS3OhNS/k4pfi1UWoQg08KNIYRkW/uqNu
        3TA5/0c8P+oa4ieZHrJKEgyOIg==
X-Google-Smtp-Source: AGHT+IHrPh5G7e3TFxgS8b3/GhZ1LZPgvLTAvhSKvbasTA3v/CblxXTWjqwkDSQtT6ryi9kh67z9lQ==
X-Received: by 2002:a17:906:1e8f:b0:9ff:aeea:89a7 with SMTP id e15-20020a1709061e8f00b009ffaeea89a7mr6281154ejj.39.1700995121063;
        Sun, 26 Nov 2023 02:38:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709063b5800b00a0bd5329d4dsm1719871ejf.214.2023.11.26.02.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:38:40 -0800 (PST)
Message-ID: <15292222-39b3-4e9e-a6c1-26fba8f5efcd@linaro.org>
Date:   Sun, 26 Nov 2023 11:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
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
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
 <a3b65c90-afc9-4caf-8744-112369a838d2@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a3b65c90-afc9-4caf-8744-112369a838d2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 20:47, Andrew Lunn wrote:
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
> 
> It would be nice to add a pointer where such rules are documented.

Subsystem profile or any other place. The generic doc should not point
to specific ones.

> 
>> +Naming and Valid Characters
>> +---------------------------
>> +
>> +Devicetree specification allows broader range of characters in node and
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
>> +
>> +4. Hex values in properties, e.g. "reg", shall use lowercase hex.  The address
>> +   part can be padded with leading zeros.
>> +
>> +Example::
>> +
>> +	gpi_dma2: dma-controller@800000 {
> 
> Not the best of example. Upper case 8 does not exist, as far as i
> known.

Sure, this was taken from DTS, but I can bring here some fake address to
illustrate :)

> 
>> +		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
>> +		reg = <0x0 0x00800000 0x0 0x60000>;
> 
> Maybe introduce some [a-f] in the example reg?
> 
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
> 
> Are these sub-architecture choices documented somewhere? Can you
> include a hint which they are?

This is a generic document, so it does not point to all possible
variations per each architecture or subarch. Just like Linux Coding
style does not cover all differences between subsystems.

> 
>> +Example::
>> +
>> +	/* SoC DTSI */
>> +
>> +	/ {
> 
> Dumb question. Does this open { indicate the start of a bus?
> 
>> +		cpus {
>> +			/* ... */
>> +		};
>> +
>> +		psci {
>> +			/* ... */
>> +		};
> 
> If that does indicate a bus, the nodes above are ordered
> alpha-numerically, according to 2).

They are ordered. c is before p. p  is before s.


> 
>> +
>> +		soc@ {
> 
> This has a unit address, even if its missing, so should be sorted by
> 1).

And it is sorted...

> 
> Should there be something in the coding style that 2) comes before 1)
> on the bus? And if that is true, don't you think it would make sense
> to swap 1) and 2) in the description above?

The root node is a bit special, but other than that mixing nodes with
and without unit address is discouraged practice.

> 
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
> 
> Do you imaging there will ever be a checkpatch for DT files? The
> second alternative seems pretty difficult to check for with tools. You

Rob pointed out that it is possible.

> need to include all the .dtsi files to determine the ordered tree,
> then flatten it to get the properties order. Should we discourage this
> alternative?

Please respond to Rob in v2 in such case.

> 
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
> 
> I'm not sure i understand this. Is this example correct?
> 
>                 gpio-fan,speed-map = <0    0
>                                       3000 1
>                                       6000 2>;
> 
> It exists a lot in todays files.

Depends on the binidng. Is it matrix? If yes, then it is not correct.

> 
> 
>> +The DTSI and DTS files shall be organized in a way representing the common
>> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
>> +and DTS files into several files:
>> +
>> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
>> +   on the SoC).
> 
> Maybe point out that SoC DTSI files can by hierarchical when there is
> a family of SoCs. You often have one .DTSI file for all the common
> parts of a family. And then each member of the family has a .dtsi file
> which includes the core, and then adds properties for that member of
> the family.

It's not really a coding style issue. We are going way to deep how
people should organize their source code. The only thing here I care is
to properly differentiate between SoC, SoM and board parts.

Best regards,
Krzysztof

