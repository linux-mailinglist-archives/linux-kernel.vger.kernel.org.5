Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC47B2EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjI2JNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjI2JNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:13:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22261180;
        Fri, 29 Sep 2023 02:13:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d2e13074so11197406b3a.1;
        Fri, 29 Sep 2023 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695978780; x=1696583580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMzgtdATq8nkLfhv47mw706RFHa0ZIrxQHeGa+lkj7k=;
        b=Yto6fDiyjludk1fjD/cNRtCTcKraVSFCPFsT6YNwq+vKdwj6TLvlpH0jQobATLKceH
         cMkmNDD+Em8xLtJPapjop92C2C2i1vlFU/Fs1gk3AblEpM5/OZbfWeBb/LKH6/BSzSgp
         4Qe31vZWGRZK1CJwCWzdiMqARzv1YAGGwzWspVaB94Fj8ksm6mY9DbE34oJYnXjoDOIT
         lHyIPaV4qLH75+UQjEa9vUnC0vqlwnG7nRTepX9shXu/hsMhrg381rE4J1aVhM/VnugR
         knOupxzdg0JFQw3TXg6L4uxbqAj2bgjizda9iKw53ArwUOhKRoSZ03aK/BRvFvoTYaYc
         GHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695978780; x=1696583580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMzgtdATq8nkLfhv47mw706RFHa0ZIrxQHeGa+lkj7k=;
        b=XKIBhmPA9XzpVvTQ84b2p9qZhsrwHsOBFulczhVnkEvxudIH6kwWPzEfQkpFydalxt
         hffKuWSpCNjvfbxEL5tSo3BtFxuTxROARAqXi/JleLVKrqxVy5XfySnCSgsGm7G96oFE
         hLnVsMjF6OMKVhdPypdKdgp2wpUdq5Wx8/Qj4qRFGMt3V/Odqc+ec070xD2kBhQf8VZQ
         p1Rl6llVclGhgGuXY3cNwH8IfrbWDXl6fniz8c9RwbH26BYu+Wls2VJzkS3plmVIm7az
         uOgd29/LoEJFMPqeLveDM/ZtnSl2VRDM5qVNhK9TYAZ8nqjCA94q+ZCKn/uikU70YC7E
         Z55g==
X-Gm-Message-State: AOJu0YzLRsFGFnHusfVLsYf+yPdimzUAKW7TfKBiAHkAEawr0ciPjpMz
        iGXe+dYzbuW2egJI8bYqDsA=
X-Google-Smtp-Source: AGHT+IEB+jijyjzjeJxWsqp/5aNhkEGBJsxmCXCXlmxoBOh5HwKSEoY3n75i/LSpexrsKEG4td2FRw==
X-Received: by 2002:a05:6a21:329a:b0:137:e595:830f with SMTP id yt26-20020a056a21329a00b00137e595830fmr4166577pzb.57.1695978780486;
        Fri, 29 Sep 2023 02:13:00 -0700 (PDT)
Received: from [192.168.31.134] ([27.4.138.218])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001a5260a6e6csm3844611plk.206.2023.09.29.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 02:13:00 -0700 (PDT)
Message-ID: <11a44e95-d29d-d892-6473-3d8d858b9d04@gmail.com>
Date:   Fri, 29 Sep 2023 14:42:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: dt-bindings: rt5616: Convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230925165715.34883-1-bragathemanick0908@gmail.com>
 <20230928161931.GA713974-robh@kernel.org>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20230928161931.GA713974-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/09/23 21:49, Rob Herring wrote:
> On Mon, Sep 25, 2023 at 10:27:15PM +0530, Bragatheswaran Manickavel wrote:
>> Convert the rt5616 audio CODEC bindings to DT schema
>> No error/warning seen when running make dt_binding_check
> No need to say that. That's the assumption and it should never get
> applied if not.
>
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
>>   .../bindings/sound/realtek,rt5616.yaml        | 53 +++++++++++++++++++
>>   .../devicetree/bindings/sound/rt5616.txt      | 32 -----------
>>   2 files changed, 53 insertions(+), 32 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
>> new file mode 100644
>> index 000000000000..00ff9b4e3c7e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/realtek,rt5616.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Realtek rt5616 ALSA SoC audio codec driver
>> +
>> +description: |
>> +  Pins on the device (for linking into audio routes) for RT5616:
>> +
>> +      * IN1P
>> +      * IN2P
>> +      * IN2N
>> +      * LOUTL
>> +      * LOUTR
>> +      * HPOL
>> +      * HPOR
>> +
>> +maintainers:
>> +  - Bard Liao <bardliao@realtek.com>
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: realtek,rt5616
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#sound-dai-cells'
> This was not in the original doc. Was that an error? If so, just state
> that in the commit msg.

Its was added by me. Will remove it

>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
> blank line
>
>> +        codec@1b {
> audio-codec@1b
>
>> +            compatible = "realtek,rt5616";
>> +            reg = <0x1b>;
>> +            #sound-dai-cells = <0>;
>> +        };
>> +    };


Will make these changes and send a new patch

Thanks,

Bragathe

