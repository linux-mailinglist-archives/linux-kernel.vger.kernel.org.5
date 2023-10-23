Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544EC7D35F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjJWL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjJWL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:59:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EEFD;
        Mon, 23 Oct 2023 04:59:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso3035582b3a.3;
        Mon, 23 Oct 2023 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698062360; x=1698667160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6JlAMQZhNgDG/MUNka90wVBdFQqbCnW3Dxoc9mKAi4=;
        b=bZdPPbCdjjINR3aVE+hIhzHp5U8fhku3oUQdZ8OyQtlipWHUPWgAonozhnoYaM2ANX
         mUfiolVFAWHtWkf1bkUXJLpAVgU6d/9zo27BoQNrte/0g18+SBSYEwr+sJAkCwZrFa0+
         HAL/cS/rBKTQl3hY6U2NWmQlNavrktKuWLLBb59JSapq60inYRPd7KPj1Mk3pvHmUd/I
         cVDp8cR9LEnRg3myqVwdstR3Xpp9dQsoRFByioMF4n0O0xf849csXyJIFByojH3wQt4H
         t5G4+8+oX5oeR/51yLiftdDFbXd/D9jniCdXl3W3Og21yth+xAKs8BylEtkqI3c98x64
         Exag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698062360; x=1698667160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6JlAMQZhNgDG/MUNka90wVBdFQqbCnW3Dxoc9mKAi4=;
        b=dCI8slcMZx0WYoARJ6zuio7poDs7gTZx9dXmoRBO/SBKkzONGNCas909Ggftq2dE/8
         U9NW9Wd3fw2NRkAnPpjZlP13LENDmgLHOee/Q/L3qVabbrixLzogddtiih6SvHIQb8OO
         a5Gft0bdxmlcSJjEDK9mbQq52XEuuTtfwIzLjYsmyUmDMaP/BxrYEBV2M6b+ACA9jWHj
         eObyWrxuwWH3kUznWdOIE/YVL0rPsZd/MXcVdQCYVktp2MMHkM1MApyj4Cozt2NdUk8k
         vsOM6//jU6hVANz+x/YVWPqIjRiAa0QkJU3W+K1On+C3IxOVb9Vq4YugtTKA2KX2H+x/
         7i2g==
X-Gm-Message-State: AOJu0YwOSISi7va+6Kgnr3FnPR4pBe9iJ4c6CHH0ERm/uLDEbi7cX3ys
        0YUaksWQxzojetekr2kAF+YYKEWruR+PIESo
X-Google-Smtp-Source: AGHT+IEXJ4bYW554Y1USLSlgYR6+LmpLGEpNPq/9gCTVmsxM35BqeiE0pvIzf7Q85QwCH14a5kGcVA==
X-Received: by 2002:a05:6a21:7185:b0:154:3f13:1bb7 with SMTP id wq5-20020a056a21718500b001543f131bb7mr10609574pzb.49.1698062360162;
        Mon, 23 Oct 2023 04:59:20 -0700 (PDT)
Received: from [10.3.171.174] ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id t63-20020a625f42000000b006bf84460e96sm2480162pfb.214.2023.10.23.04.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 04:59:19 -0700 (PDT)
Message-ID: <7ef752b4-915b-4f9d-8425-79df8195656b@gmail.com>
Date:   Mon, 23 Oct 2023 17:28:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231017034356.1436677-1-anshulusr@gmail.com>
 <ZTW0p2WG3/m1Tx+Z@nixie71>
Content-Language: en-US
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <ZTW0p2WG3/m1Tx+Z@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

On 10/23/23 05:17, Jeff LaBundy wrote:
> Hi Anshul,
> 
> On Tue, Oct 17, 2023 at 09:13:44AM +0530, Anshul Dalal wrote:
>> Adds bindings for the Adafruit Seesaw Gamepad.
>>
>> The gamepad functions as an i2c device with the default address of 0x50
>> and has an IRQ pin that can be enabled in the driver to allow for a rising
>> edge trigger on each button press or joystick movement.
>>
>> Product page:
>>   https://www.adafruit.com/product/5743
>> Arduino driver:
>>   https://github.com/adafruit/Adafruit_Seesaw
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> Perhaps this ship has sailed, but is there any reason this simple device
> cannot be added to Documentation/devicetree/bindings/trivial-devices.yaml
> as opposed to having its own binding?
> 
> It has no vendor-specific properties, and the only properties are the
> standard properties already understood by the I2C core. In case I have
> misunderstood, please let me know.
> 

The driver currently implements only a subset of the functionality in
the Adafruit Seesaw specification. I eventually plan on adding adding
full support for the Seesaw framework in the form of a driver for the
atsamd09 seesaw breakout board:
https://learn.adafruit.com/adafruit-seesaw-atsamd09-breakout

Then I think it would be better for this driver to use the newly exposed
seesaw APIs by the atsamd09 driver instead of relying on kernel's i2c APIs.

I would also like to add support for the provided interrupt pin later
down the line which is documented in the binding along with description
of the non-standard action button layout.

Above were my reasons for going for a standalone binding, please let me
know if you disagree.

>> ---
>>
>> Changes for v5:
>> - Added link to the datasheet
>>
>> Changes for v4:
>> - Fixed the URI for the id field
>> - Added `interrupts` property
>>
>> Changes for v3:
>> - Updated id field to reflect updated file name from previous version
>> - Added `reg` property
>>
>> Changes for v2:
>> - Renamed file to `adafruit,seesaw-gamepad.yaml`
>> - Removed quotes for `$id` and `$schema`
>> - Removed "Bindings for" from the description
>> - Changed node name to the generic name "joystick"
>> - Changed compatible to 'adafruit,seesaw-gamepad' instead of
>>   'adafruit,seesaw_gamepad'
>>
>>  .../input/adafruit,seesaw-gamepad.yaml        | 60 +++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>> new file mode 100644
>> index 000000000000..3f0d1c5a3b9b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Adafruit Mini I2C Gamepad with seesaw
>> +
>> +maintainers:
>> +  - Anshul Dalal <anshulusr@gmail.com>
>> +
>> +description: |
>> +  Adafruit Mini I2C Gamepad
>> +
>> +    +-----------------------------+
>> +    |   ___                       |
>> +    |  /   \               (X)    |
>> +    | |  S  |  __   __  (Y)   (A) |
>> +    |  \___/  |ST| |SE|    (B)    |
>> +    |                             |
>> +    +-----------------------------+
>> +
>> +  S -> 10-bit percision bidirectional analog joystick
>> +  ST -> Start
>> +  SE -> Select
>> +  X, A, B, Y -> Digital action buttons
>> +
>> +  Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
>> +  Product page: https://www.adafruit.com/product/5743
>> +  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
>> +
>> +properties:
>> +  compatible:
>> +    const: adafruit,seesaw-gamepad
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        joystick@50 {
>> +            compatible = "adafruit,seesaw-gamepad";
>> +            reg = <0x50>;
>> +        };
>> +    };
>> -- 
>> 2.42.0
>>
> 
> Kind regards,
> Jeff LaBundy

Thank you,
Anshul Dalal
