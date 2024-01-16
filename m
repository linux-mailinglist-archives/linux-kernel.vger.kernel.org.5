Return-Path: <linux-kernel+bounces-27509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E082F14A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B709A1C23559
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737AF1BF59;
	Tue, 16 Jan 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbbhGfWP"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920921BF4C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff59e0dd71so5511177b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705418439; x=1706023239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrwKbVNRhEgeHDKSmpjoAKnxq07pfI9REODSgijkOyE=;
        b=AbbhGfWPS0DAICDjNTCCDcMaf8vZk5/kChmRni1n2DLfsIDrqgHI+mmoskHu1fNN8S
         7XttLiLldjOggR2yU0NvyhBEa+QAkvDN77dWSFiHQC/4flMy7KwfBgHizh5YhYS37RJO
         znZQk07oOYpulqEGTQu6S+hDzunRK7ZhPVDlD4Uy+1t30k634hqsjmcomoeaMZhn84JY
         GpaotfEnVwX18Br4WLpIydB4draTC6ixUeRknaGYZHP6vlM7f5/WQekLP7FPA/QhmNF7
         /wo7zJAHO6h7c80AuvNUqwWbBcKuhfcruR6ReaSd2p/jsYuUQ9bqgks1khePZLysl7se
         ce6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418439; x=1706023239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrwKbVNRhEgeHDKSmpjoAKnxq07pfI9REODSgijkOyE=;
        b=QZaI2QWBRbTyu7prCW4s8YjJoSr44J+y/I8GzJc8LNSDm9UUz95e1HTW1E3EA5/nHd
         dX+IqFMlUNo8B0QeXjlg7WUu33uf/nAd7TPYKIHvElGPlEMKqhYRnDA2RpkMAZ4X8K+S
         R8el+SdjbTjgoRF9AdT86njGOL6w3zaXHzxX4ZXf4i/Avl267wZkyhXDu08dAxqD0j2r
         2/ZvdiHTsL5nflDoow8NyI7POQkZNCJ4nY5iC+lMq0kQiv5S+0eYBPUA8rkNN0qr80Js
         /9pLaRsfSrjz0QQmpuTy2ybYB7LH4Tmeqga3Bkd5phBA068dYMopJrlpyqJTp4ydV4ZQ
         lvXw==
X-Gm-Message-State: AOJu0YwiPTka1AEbDi47EWLbiIFDtWPaZJu0jnVqfdlVrd+8eis6of2H
	JITbVguij2gH2BJNLbQ/MdHIgGarHeXawg==
X-Google-Smtp-Source: AGHT+IEgXJX3n3ex0s2vYmfoj6P6qtQhbMJSiBihrluKGYSRM3LD4wtwYOI0wYHK7tC+C9Wvo1oeUA==
X-Received: by 2002:a0d:e6c6:0:b0:5ff:4545:f52b with SMTP id p189-20020a0de6c6000000b005ff4545f52bmr1564331ywe.22.1705418439468;
        Tue, 16 Jan 2024 07:20:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id x140-20020a0dd592000000b005ff48b0ffd5sm891059ywd.0.2024.01.16.07.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:20:39 -0800 (PST)
Message-ID: <107e9496-8b2f-4de2-9396-945a7c822493@linaro.org>
Date: Tue, 16 Jan 2024 16:20:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Content-Language: en-US
To: Dragan Cvetic <dragan.cvetic@amd.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, git@amd.com
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
 <20240116111135.3059-2-dragan.cvetic@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240116111135.3059-2-dragan.cvetic@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 12:11, Dragan Cvetic wrote:
> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
> dt-entries as well as any future additions to yaml.
> Conversion txt to yamal is done "one to one", no new changes in txt file
> has been made.
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>

Where? Please provide a link. Judging by amount of issues here, I have
some doubts, because I know Michal writes good schema. :)

> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>

All your patches were marked as spam. Please work with your IT to
resolve it, otherwise your future submissions might get ignored by me,
because I will just not see them.

> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
>  .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 132 ++++++++++++++++++
>  2 files changed, 132 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> 

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Looks like you either based it on some downstream tree (don't do this)
or used random list of recipients (also don't do this).

Please reach to other AMD folks to explain you how patches should be
submitted. There are a lot of experienced guys there, so use them.

> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> deleted file mode 100644
> index e3289634fa30..000000000000
> --- a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* Xilinx SDFEC(16nm) IP *
> -

..

> -	};
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> new file mode 100644
> index 000000000000..05bc01cb5075
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/xlnx,sd-fec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx SDFEC(16nm) IP
> +
> +maintainers:
> +  - Cvetic, Dragan <dragan.cvetic@amd.com>
> +  - Erim, Salih <salih.erim@amd.com>
> +
> +description: |
> +  The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> +  which provides high-throughput LDPC and Turbo Code implementations.
> +  The LDPC decode & encode functionality is capable of covering a range of
> +  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> +  principally covers codes used by LTE. The FEC Engine offers significant
> +  power and area savings versus implementations done in the FPGA fabric.
> +
> +properties:
> +  compatible:
> +    const: xlnx,sd-fec-1.1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: List of clock specifiers.

Drop description, it's obvious. Do you see it anywhere in existing code?

> +    additionalItems: true

Drop, you cannot have it.

> +    minItems: 2
> +    maxItems: 8

Drop maxItems, not needed.

> +    items:
> +      - description: Main processing clock for processing core.

Drop trailing full-stops.

> +      - description: AXI4-Lite memory-mapped slave interface clock.
> +      - description: Control input AXI4-Stream Slave interface clock.
> +      - description: DIN AXI4-Stream Slave interface clock.
> +      - description: Status output AXI4-Stream Master interface clock.
> +      - description: DOUT AXI4-Stream Master interface clock.
> +      - description: DIN_WORDS AXI4-Stream Slave interface clock
> +      - description: DOUT_WORDS AXI4-Stream Master interface clock
> +
> +  clock-names:
> +    additionalItems: true

Nope

> +    minItems: 2
> +    maxItems: 8

Nope

> +    items:
> +      - const: core_clk
> +      - const: s_axi_aclk
> +      - enum:
> +          - s_axis_ctrl_aclk
> +          - s_axis_din_aclk
> +          - m_axis_status_aclk
> +          - m_axis_dout_aclk
> +          - s_axis_din_words_aclk
> +          - m_axis_dout_words_aclk

Why order is not enforced?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  xlnx,sdfec-code:
> +    description:
> +      Should contain "ldpc" or "turbo" to describe the codes being used.

Useless description, you just copied schema. Instead say something
useful, e.g. the meaning.

> +    $ref: /schemas/types.yaml#/definitions/string-array

It's not an array, but string, is it?

> +    items:

How many items? Is it a string?

> +      enum: [ ldpc, turbo ]
> +
> +  xlnx,sdfec-din-width:
> +    description: |
> +      Configures the DIN AXI stream where a value of 1
> +      configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
> +      of "4x128b".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4 ]
> +
> +  xlnx,sdfec-din-words:
> +    description: |
> +      A value 0 indicates that the DIN_WORDS interface is
> +      driven with a fixed value and is not present on the device, a value of 1
> +      configures the DIN_WORDS to be block based, while a value of 2 configures the
> +      DIN_WORDS input to be supplied for each AXI transaction.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2 ]
> +
> +  xlnx,sdfec-dout-width:
> +    description: |
> +      Configures the DOUT AXI stream where a value of 1 configures a width of "1x128b",
> +      2 a width of "2x128b" and 4 configures a width of "4x128b".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4 ]
> +
> +  xlnx,sdfec-dout-words:
> +    description: |
> +      A value 0 indicates that the DOUT_WORDS interface is
> +      driven with a fixed value and is not present on the device, a value of 1
> +      configures the DOUT_WORDS to be block based, while a value of 2 configures the
> +      DOUT_WORDS input to be supplied for each AXI transaction.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2 ]
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - xlnx,sdfec-code
> +  - xlnx,sdfec-din-width
> +  - xlnx,sdfec-din-words
> +  - xlnx,sdfec-dout-width
> +  - xlnx,sdfec-dout-words
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sd-fec@a0040000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "xlnx,sd-fec-1.1";
> +        reg = <0xa0040000 0x40000>;
> +        clocks = <&misc_clk_2>, <&misc_clk_0>, <&misc_clk_1>, <&misc_clk_1>,
> +                 <&misc_clk_1>, <&misc_clk_1>;
> +        clock-names = "core_clk", "s_axi_aclk", "s_axis_ctrl_aclk",
> +                      "s_axis_din_aclk", "m_axis_status_aclk",
> +                      "m_axis_dout_aclk";
> +        interrupts = <1 0>;

If 0 is a flag, use proper defines. Then think twice whether NONE is
really a correct type of interrupt.



Best regards,
Krzysztof


