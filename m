Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58B47E3F47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjKGMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjKGMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:52:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174E45929
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:38:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo9272154a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 04:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699360698; x=1699965498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPGfSruBJgLSYw4TIGvl7IJRrntMu98wAh3JYdEPHTw=;
        b=OvyVx7LCpLCdHFNpAo4OiA4IEELNiciH5KbpT/s81b+XNkClMRUtDwuHo66TP9e7qt
         EMVXPdblbNY0WuWCiL87gjk0g60xG1kg05ljJIfXWsLELT4xjzYcfTOqQ7fu6G0UYHr+
         Hv1DY+bknDO23e/+Zkm9uZB3g5WUn46jJhlGuBjythv8A0iL1F+XJe2wzr2lmFptu5yj
         U/6EBIk3GRhazTi46fCiadKlQTSG4zvMbXYTjw0cOljuMz+3mm7VseSuqL+yEkEGhqbf
         dgZ+jO96n0w4DMQynbUS8ekBFWIbegnr4PklGxkTSIXkJGvQ0HnsYTgYa+dOh6pTjVsE
         IUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699360698; x=1699965498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPGfSruBJgLSYw4TIGvl7IJRrntMu98wAh3JYdEPHTw=;
        b=PbINau0IQKCGed+pj1/bBxBWscr1ZNr2Fpukuj/sUScGdBb7OtO7tyvjx5Giwqu6h0
         Id/b4vqULSliBEMzlDtTgfxh4ETraf+UNckj5u4hkX9r4xycujJ6dyO1cT75BOlhOpzW
         WHpwCS/zUKidMndh3ZWyBetdUPmuC6XSF7nQMthjF/EHhHNJgiv0j4UnEbIgam9n+9qU
         i8ijjno4KVkWKqGFLTDF2OAyMHCsusRK4V+EkiCmjd9iDYRugTezyUUya2UuWnKcSoIG
         YI7lfAdl+moL8XSmf+GUN6pWPKrvcQymhVd45dFKa8K4U1NXMU+UbmB8tYwqmszw7FvW
         8nKQ==
X-Gm-Message-State: AOJu0Yxb6VJSyN633iL+hT11qWt7WBLYP974w2/wr8739pXloV1KfctJ
        DX2bN2tDxr/mXyh9HWOCR99biA==
X-Google-Smtp-Source: AGHT+IG5yeN8OQBMRW8DhTHa+scnKpZxTfF/YJYQodnrPdQNY2aSPM/LO8/j1EEfKeglr0muI7Tc4g==
X-Received: by 2002:aa7:c454:0:b0:53e:1741:d76b with SMTP id n20-20020aa7c454000000b0053e1741d76bmr25262953edr.39.1699360697962;
        Tue, 07 Nov 2023 04:38:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id q7-20020a056402248700b00536ad96f867sm5303639eda.11.2023.11.07.04.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 04:38:17 -0800 (PST)
Message-ID: <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
Date:   Tue, 7 Nov 2023 13:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
 <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
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

On 07/11/2023 13:09, Michal Simek wrote:
> 
> 
> On 11/7/23 12:27, Krzysztof Kozlowski wrote:
>> On 07/11/2023 12:09, Michal Simek wrote:
>>>
>>>
>>> On 11/6/23 18:07, Conor Dooley wrote:
>>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>>>>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>>>>> It is hardware compatible with classic MicroBlaze processor. Processor can
>>>>> be used with standard AMD/Xilinx IPs including interrupt controller and
>>>>> timer.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>>    .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
>>>>
>>>> Bindings for SoCs (and by extension boards with them) usually go to in
>>>> $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
>>>> different?
>>>
>>> I actually found it based on tracking renesas.yaml which describes one of risc-v
>>> board. No problem to move it under bindings/riscv/
>>>
>>>>
>>>>>    1 file changed, 26 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/soc/amd/amd.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd.yaml b/Documentation/devicetree/bindings/soc/amd/amd.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..21adf28756fa
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd.yaml
>>>>> @@ -0,0 +1,26 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/soc/amd/amd.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: AMD Platforms
>>>>> +
>>>>> +maintainers:
>>>>> +  - Michal Simek <michal.simek@amd.com>
>>>>> +
>>>>> +description: |
>>>>> +  AMD boards with MicroBlaze V SOC
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    const: '/'
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - description: AMD MicroBlaze V
>>>>> +        items:
>>>>> +          - const: amd,mbv
>>>>
>>>> You don't actually list any boards here, but instead permit having only
>>>> the SoC compatible and no board one. The SoC compatible is also
>>>> incredibly generic. Personally I don't think this binding makes any
>>>> sense as it appears to exist as a catch all for anything using your
>>>> new cores in any combination.
>>>
>>> I think I need to define any string for compatibility because it is standard
>>> property. Because this is soft core it can be added to any board with AMD/Xilinx
>>> chip. I don't have really an option to list all boards.
>>
>> Why? Either there is a product with this soft-core or there is not. It
>> cannot be both.
> 
> I am doing basic enablement. I am not making product. Product will be done by 
> our customers using this core.
> There will be thousands of different configurations done by customers which will 
> have products with it. Also there could be hundreds configurations done on the 
> same board.

If this is the same board, then why there is compatible for it?

> 
> Does it make sense to have board related compatible string like this if this 
> evaluation board is used by a lot of customers?
> "amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"

I miss the point what is the hardware. Evaluation board is the hardware.
If someone changes it and makes a new product, it is a new product.

> 
> Or I can define qemu one.
> "amd,qemu-mbv", "amd,mbv"

QEMU is not hardware, so not.

> 
> I think customers should be adding their compatible string in front of generic one.

To what? To evaluation board? Why?

> 
> Years ago I have done the same thing with Microblaze where compatible is defined 
> as xlnx,microblaze only. 

Again, what is the use of such binding?

> When customer take this soft core, put IPs around and 
> create a product they should extend it to be for example like this.
> "xyz,my-product-1.0", "xlnx,microblaze";

So there is a product, not evaluation board.

> 
> And over all of years I have never seen any single customer to try to push dt 
> description for any Microblaze based product.
> 
>>>
>>> I am happy to change it to something else but not sure to what.
>>
>> Alone this compatible does not bring you anything.
> 
> I don't agree with it. It is standard property and I have to define it somehow.

The property is already defined, you do not have to define it. What you
define here is the value for compatible. Why do you need to define it
somehow? Who asks for that?

> If not, I get an error.
> .../xilinx-mbv32.dtb: /: 'compatible' is a required property

So you have a board? The patches must be linked to each other, e.g.
preferred way is to send them in one patchset.

> 
> And it tells me that this risc-v compatible core runs on AMD fpga and it is 
> compatible with it.


Best regards,
Krzysztof

