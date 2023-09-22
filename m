Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB87AB722
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjIVRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:23:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A080A83;
        Fri, 22 Sep 2023 10:23:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2749ce1aa37so2902946a91.0;
        Fri, 22 Sep 2023 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695403392; x=1696008192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Q8CChFA1gPR0oSMAjUHL0l/N1n5hJouJgvhk0SX0HM=;
        b=ara8H0kTRfbjbRnD5NZdopeA2Ecn8R9+11A8lZGopMLn8jtS5R7Cs3RYtrYqpO5x2P
         8PLOBHRViIq+KV/dEMznwQJd7YEJeXaNNoZUYb4P0lcYHHBX+PH1Bf7f3HfNaKCTA0Eo
         c1XuA5y9eI89NZz3V2dvw0DtXxMa4W+87v/mSaBMQ5VGHcCeM+WO/5ubhMtsW8FjEpAw
         AVjIxR08FZ97chRW7YRpXDhz2WDuArq89KbF4XvafVs62eD76i5Vz0WStkb1yS3JFmV5
         O4jB/STcZLN0P9VnYHCclh73r4MzenkwfWPiy15/0Y/iIxsLNSFKWnyuBVCgMVmb18iU
         7EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403392; x=1696008192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q8CChFA1gPR0oSMAjUHL0l/N1n5hJouJgvhk0SX0HM=;
        b=JtLkFEBESdx6719U39QT+WJgLqXwGL9sQALbEl48a1RBOKXovjQhQkxY8zW1wwFz/M
         KuEuJVyC7oO+4TAqfFm1TUCzF9Jt/JrlKFmqAbP8b2czvxzc3SHhk27dzxonkSGuILZr
         /x8mWzx9oZwGHCBWJCTMTmxzISsxT3BA/NeOhVrOL23q9sQtYpHd13FttcGJbinMrIa/
         rrljeXI8esghljlrD/wL3EmKyU4uw5N2mJFqvQ0df/hUw3cp8JfEk/mcSqDGg5nMXuVO
         07o2Wg4f1atpM49xeN3mlZBHgSwfhPMe5FsvB5DK5wL7lg/lPV/Pdq1hd/jva0VL7sa5
         pO4w==
X-Gm-Message-State: AOJu0Yza7aFCcpRGRqSW50jTOpHr8/MlmigNAEDs/h7pzGsVQ+DB+EXJ
        uyyfAFmEAewyDTO1tTKA6ZIZJDEVR4c=
X-Google-Smtp-Source: AGHT+IFKqNHWSe5J9acMcbHNulonofEyqJ5zlmXdE1wEO/aZhwCZU1j3TahVjUV/1V+3hFwkBQvtVw==
X-Received: by 2002:a17:90a:be07:b0:273:e090:6096 with SMTP id a7-20020a17090abe0700b00273e0906096mr448684pjs.11.1695403391984;
        Fri, 22 Sep 2023 10:23:11 -0700 (PDT)
Received: from [192.168.31.134] ([122.172.81.240])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a019900b0026b70d2a8a2sm3834224pjc.29.2023.09.22.10.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 10:23:11 -0700 (PDT)
Message-ID: <c6f795f1-2832-c282-5819-f8f402a312bd@gmail.com>
Date:   Fri, 22 Sep 2023 22:53:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] ASoC: dt-bindings: tfa9879: Convert to dtschema
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230921183313.54112-1-bragathemanick0908@gmail.com>
 <20230922-unmindful-anyplace-f1da73ab168c@spud>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20230922-unmindful-anyplace-f1da73ab168c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/09/23 20:56, Conor Dooley wrote:
> On Fri, Sep 22, 2023 at 12:03:13AM +0530, Bragatheswaran Manickavel wrote:
>> Convert the tfa9879 audio CODEC bindings to DT schema
>> No error/warning seen when running make dt_binding_check
>>
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> Changes:
>> V1 -> V2: Fixed DT syntax errors and doc warning
> These should be under the --- line, not above it.
> Perhaps Mark will change it on application.
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.

Hi Conor,
Thanks for reviewing it.
Do I need to send a new patch by addressing the above comments ?

>
>> ---
>>   .../bindings/sound/nxp,tfa9879.yaml           | 44 +++++++++++++++++++
>>   .../devicetree/bindings/sound/tfa9879.txt     | 23 ----------
>>   MAINTAINERS                                   |  2 +-
>>   3 files changed, 45 insertions(+), 24 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/sound/tfa9879.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
>> new file mode 100644
>> index 000000000000..df26248573ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/nxp,tfa9879.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP TFA9879 class-D audio amplifier
>> +
>> +maintainers:
>> +  - Peter Rosin <peda@axentia.se>
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nxp,tfa9879
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
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c1 {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       amplifier@6c {
>> +          compatible = "nxp,tfa9879";
>> +          reg = <0x6c>;
>> +          pinctrl-names = "default";
>> +          pinctrl-0 = <&pinctrl_i2c1>;
>> +          #sound-dai-cells = <0>;
>> +       };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/sound/tfa9879.txt b/Documentation/devicetree/bindings/sound/tfa9879.txt
>> deleted file mode 100644
>> index 1620e6848436..000000000000
>> --- a/Documentation/devicetree/bindings/sound/tfa9879.txt
>> +++ /dev/null
>> @@ -1,23 +0,0 @@
>> -NXP TFA9879 class-D audio amplifier
>> -
>> -Required properties:
>> -
>> -- compatible : "nxp,tfa9879"
>> -
>> -- reg : the I2C address of the device
>> -
>> -- #sound-dai-cells : must be 0.
>> -
>> -Example:
>> -
>> -&i2c1 {
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&pinctrl_i2c1>;
>> -
>> -	amp: amp@6c {
>> -		#sound-dai-cells = <0>;
>> -		compatible = "nxp,tfa9879";
>> -		reg = <0x6c>;
>> -	};
>> -};
>> -
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a4c30221eb30..569303daf9b4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15476,7 +15476,7 @@ NXP TFA9879 DRIVER
>>   M:	Peter Rosin <peda@axentia.se>
>>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>>   S:	Maintained
>> -F:	Documentation/devicetree/bindings/sound/tfa9879.txt
>> +F:	Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
>>   F:	sound/soc/codecs/tfa9879*
>>   
>>   NXP-NCI NFC DRIVER
>> -- 
>> 2.34.1
>>
