Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5294763E48
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjGZSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGZSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:19:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59149B;
        Wed, 26 Jul 2023 11:19:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-78358268d1bso1931639f.3;
        Wed, 26 Jul 2023 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690395555; x=1691000355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/oiMZ3nM+eoY03UlmzmtvCU+X4kjpJCTaAiEoMbtWRw=;
        b=TTYB51D/NfVxcpJZ50QX69jPp5RnP66HP+Mm1y+cHh8S73VhSbF2CSbf9WBWTbJYw7
         Q9mq79frCZWI3Am7inEscZObXOCvoAPXu7lsR+p6nddLFd61Cs7hs9VclrB0NH6NjILd
         xcBkPblHdydQbFO1Gj6XXq638+Sf9Eq2ZnfqjAJK+5cfLVpUkOTTPqLa0nxKdg+Me0MK
         Bq53UZWoKZFJUTjp3Auo9rnjUODLo0Utj9obPeOLXQUuvSOfze5vZy1qw+sNIWJXwa9a
         XT0Wm7S815b8ewCfQxzi/va8z/dQHRnoiUmu9P6DaPOkUSKXr4cQrewysIdP/pYAZW9c
         r3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690395555; x=1691000355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oiMZ3nM+eoY03UlmzmtvCU+X4kjpJCTaAiEoMbtWRw=;
        b=Ohnerji/J5sES6mIekWfnXF0ymU0+SW1zkNQ+kxjuJsgqQfbZYE9djC4ecCmaXLj9W
         DTtCExr9VWJdk99Lb2fyCewO18281ZW/EYDBllbzpuxCWBBDRl4DSKMK9GBUdVzHyUAV
         VO6+nEvlnx/oQQVkjUm29t3tqcXt/JuAlxLwpPr+W0WABWdtX67CRNI6KaXWv2Rzz31V
         y/pq5nhKIXsWMOGYm2AfLTv2wxD8MrAUXPdtwP5/O07rH5aoothndxPnTAwcBzj8YFJC
         DrvVH2nV8vSk9hE0xG0vFCcFhvpjLAtFXoYfwLBgU4/3eUq6fqrxd8YbEFzcWztRanTJ
         4kUQ==
X-Gm-Message-State: ABy/qLYA8dKD6IhAQoVLJW4VtAzs5Q/M+5X9hOOSnwkWSWDiCm0a4iGq
        PWvs8CaZfqx1SELNO2Atk6c=
X-Google-Smtp-Source: APBJJlHNp4dH2bfTxrRyc4ibGTHNazCtS0BOD5yQy3CrePzCW13/b6S6HKoZ1gLC73MoWpKjDyWNfw==
X-Received: by 2002:a5e:c006:0:b0:77a:c741:b749 with SMTP id u6-20020a5ec006000000b0077ac741b749mr2700865iol.1.1690395554980;
        Wed, 26 Jul 2023 11:19:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b004182f88c368sm4472081jas.67.2023.07.26.11.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:19:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4105d77e-e011-8df7-35bf-bbfca0b640da@roeck-us.net>
Date:   Wed, 26 Jul 2023 11:19:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 09:14, Krzysztof Kozlowski wrote:
> On 26/07/2023 17:22, Carsten Spieß wrote:
>> Add dt-bindings for Renesase ISL28022 power monitor.
>>
>> Signed-off-by: Carsten Spieß <mail@carsten-spiess.de>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
>>   .../bindings/hwmon/renesas,isl28022.yaml      | 67 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
>> new file mode 100644
>> index 000000000000..5ecf892db269
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
> 
> No blank line.
> 
>> +$id: http://devicetree.org/schemas/hwmon/renesas,isl28022.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Renesas ISL28022 power monitor
>> +
>> +maintainers:
>> +  - Carsten Spieß <mail@carsten-spiess.de>
>> +
>> +description: |
>> +  The ISL28022 is a power monitor with I2C interface. The device monitors
>> +  voltage, current via shunt resistor and calculated power.
>> +
>> +  Datasheets:
>> +    https://www.renesas.com/us/en/www/doc/datasheet/isl28022.pdf
>> +
>> +Required properties:
>> +  compatible:
>> +    enum:
>> +      - renesas,isl28022
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +Optional properties:
> 
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
> 
> These are "properties"
> 
>> +  shunt-resistor-micro-ohms:
>> +    description:
>> +      Shunt resistor value in micro-Ohm
>> +      defaults to <0> when not set
>> +      monitoring of current and power not supported when <0>
>> +
>> +  shunt-gain:
> 
> 1. Missing vendor prefix (does not look like generic property)
> 2. -microvolt
> 
>> +    description:
>> +      Shunt gain to scale maximal shunt voltage to
>> +      40mV, 80mV, 160mV, 320mV
>> +      defaults to <8> (320mV) when not set
> 
> And then enum is for 40, 80, 160 and 320.
> 
>> +    enum: [1, 2, 4, 8]
>> +
>> +  average:
>> +    description: |
>> +      Number of samples to be used to report voltage, current and power values.
>> +      defaults to <0> when not set
>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]
> 
> I am sure hwmon has some property for this. Are you sure it is called
> "average"?
> 

Something with samples. adi,power-sample-average is similar. Others
use average-samples, qcom,avg-samples, touchscreen-average-samples.

Guenter

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
> 
> 
> Best regards,
> Krzysztof
> 

