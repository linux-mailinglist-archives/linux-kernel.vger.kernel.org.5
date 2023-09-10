Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1932799E22
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbjIJMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 08:32:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812613D;
        Sun, 10 Sep 2023 05:32:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99cce6f7de2so440180066b.3;
        Sun, 10 Sep 2023 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694349121; x=1694953921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aHt2wJGVKYehW9g8eCfO0PCFN1e2YpLnVjYFEJ3Aw8=;
        b=jW6YkEDF2df+1Eek3nOMFGIH1DyDCCw8xkNCGUFWeE5+xWlUqeuUroukCbIu+suM+I
         N/URyo8v4qZwW+gj47RY4zRleCkDouiG2/9wMkA3UJNM7kYOy20vJ+1BgZZ8zdiMa8tY
         qxDiDYmNz5ACHfT9xGAYoVT1WPUups3JXnhBE+GKPhppwf/2DN+bMRQBT1TrJObarCQS
         bpFgcuYjIT7XZcFaO8iCuQcbfDaWT+KUa9RuNHf3NXDff4jdSIaQuuGw5dg9oXqYY6Jr
         HyP1t2TS172uU1dXpdPTi1rW2Mj7zRs/bD92UU4o/IMKNqgtBZ4vZuGhgCA5mi24hfZN
         8ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694349121; x=1694953921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aHt2wJGVKYehW9g8eCfO0PCFN1e2YpLnVjYFEJ3Aw8=;
        b=d65umNwNE6kllQOmCM0tjryWHL9Mi3PyLriZWUnDSMTgEaEEOaIPsBoSgf9UI8TDqb
         g2yVK57dpk/nbixSffxdH8R+t65jrW2U6zlwedFod3bAipIcyoUjqQKmWGDznS4SyqkA
         G+Lskk9ArVVhm7BC2llfgHUmKuDK2BA1eHYAcqHEH2yc0eNYqTvbRBO0TRM1t3ji7TC5
         0HSY0GssdZ9w1di1M0E0sK/03/Y4yrF2Megdm6yxYQmm7Bg657Re4bGea8pZFhJW2hfL
         P19iEejyskkgEawJ0awKym+fNl2562b/YUFluExj3iLmvwAGzBCKtaqYq/wzZmtm/LmK
         FA+g==
X-Gm-Message-State: AOJu0YyLV7OZhFiYZJu6K9V+uFnrPkMS7jzc6KPgYItKTQCW9+XKcujh
        vgvFdX93F+rwze+fGrZSQMI4xYaroXIgKwvO
X-Google-Smtp-Source: AGHT+IEJJ3M2264wERDzszL7hkM33Qm98hWsyXNTSgfiKm1hExK5tkshxwpkBuk6DeGQNZgUHi6sdQ==
X-Received: by 2002:a17:906:c:b0:9a6:75b7:ed49 with SMTP id 12-20020a170906000c00b009a675b7ed49mr5265434eja.77.1694349120998;
        Sun, 10 Sep 2023 05:32:00 -0700 (PDT)
Received: from [172.18.166.233] (ip-185-104-138-31.ptr.icomera.net. [185.104.138.31])
        by smtp.gmail.com with ESMTPSA id y5-20020a170906070500b0099bcbaa242asm3755510ejb.9.2023.09.10.05.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 05:31:59 -0700 (PDT)
Message-ID: <f3b675d0-721f-78f5-826e-26141150e655@gmail.com>
Date:   Sun, 10 Sep 2023 14:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: rtc: pcf2123: convert to YAML
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chris Verges <chrisv@cyberswitching.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907-topic-pcf2123_yaml-v1-1-40e82bed2066@gmail.com>
 <202309101217447eae4bc4@mail.local>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202309101217447eae4bc4@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 10.09.23 14:17, Alexandre Belloni wrote:
> On 10/09/2023 13:00:27+0200, Javier Carrasco wrote:
>> Convert the existing txt binding to the preferred YAML format.
>>
>> The pcf2123 node may contain SPI settings such as spi-cs-high and
>> spi-max-frequency, which keeps it from being added to the trivial-rtc
>> binding with its current definition. Add a reference to
>> spi-peripheral-props.yaml to account for that.
>>
>> The "interrupts" property was missing in the binding although it is
>> already supported. Add the missing property in the new binding.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/nxp,pcf2123.yaml       | 45 ++++++++++++++++++++++
>>  .../devicetree/bindings/rtc/nxp,rtc-2123.txt       | 17 --------
>>  2 files changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
>> new file mode 100644
>> index 000000000000..013e5e5dc0ae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2123.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/nxp,pcf2123.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP PCF2123 SPI Real Time Clock
>> +
>> +maintainers:
>> +  - Chris Verges <chrisv@cyberswitching.com>
> 
> Is Chris willing to maintain the binding?
> 
I added the driver's author as the binding's maintainer because I
thought it makes sense and it would be more consistent if the driver
gets new additions. But I did not consider that the driver's maintainer
might not be willing to be the driver binding's maintainer. If that is
the case, sorry for the assumption! I can add myself as a maintainer and
send a v2.
Chris is in cc as well so I will wait for his opinion.
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +  - $ref: rtc.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nxp,pcf2123
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        rtc@3 {
>> +            compatible = "nxp,pcf2123";
>> +            reg = <3>;
>> +            spi-cs-high;
>> +        };
>> +    };
>> +...
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
>> deleted file mode 100644
>> index 7371f525a687..000000000000
>> --- a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -NXP PCF2123 SPI Real Time Clock
>> -
>> -Required properties:
>> -- compatible: should be: "nxp,pcf2123"
>> -                      or "microcrystal,rv2123"
>> -- reg: should be the SPI slave chipselect address
>> -
>> -Optional properties:
>> -- spi-cs-high: PCF2123 needs chipselect high
>> -
>> -Example:
>> -
>> -pcf2123: rtc@3 {
>> -	compatible = "nxp,pcf2123"
>> -	reg = <3>
>> -	spi-cs-high;
>> -};
>>
>> ---
>> base-commit: 535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
>> change-id: 20230907-topic-pcf2123_yaml-2ce57f4e77d7
>>
>> Best regards,
>> -- 
>> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
> 
Best regards,
Javier Carrasco
