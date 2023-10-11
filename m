Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767697C5D52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbjJKTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjJKTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:00:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3298E5;
        Wed, 11 Oct 2023 12:00:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692c70bc440so86479b3a.3;
        Wed, 11 Oct 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050854; x=1697655654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgH80giGdocd0lWZvSZ+nxWXaTP5RcrQOuV73pIouaA=;
        b=dSt4g01mh0p3jsMk/yR3s+tnqBqWT/HFgRqGPjOJyxyj1TrzNPVXCzFLwGu1iCMzyJ
         q6ElQq323+Ac4tG5SI56Dbik7kgkKvQyGNE2KuC02bv802VTINXseKfYPCQsgVA+fWrC
         JW5Kpvi1Mg9tlWKSl0MeDrwKy9lwvg76qrg6vuARMKET2XY7IpJMk1JIxzVXuVUneayt
         MVVO5+sfjFrI7TO/O02zguo68kPm1EmkG+wMCKrR/gILR7/+V2aC/D1KiP+Q9j2Two9J
         LOok5ixJ92+WA4xALOzM9xsR1iyy3oB36fiHe+iI2/I6xK4cTLJ+DFe4USzwkv6CXJlV
         sp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050854; x=1697655654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgH80giGdocd0lWZvSZ+nxWXaTP5RcrQOuV73pIouaA=;
        b=wHHVpxH8DTAk/gn1CtKk5KlbpsHEV8SK+QYHvY9Rj5f9WBRTW7iOytOWy/FSu1JtV1
         JmQ5lu2h00DJkx9Ajv/9mt3bWfWmI++4iJ/MZA+U3TCk+M82ilaAfZoCGcgnWqEx4c9W
         +KB+al4TezL9Xs2leDY3YR/aIz5FpHY2xwylkG7nY+8T0T+zZmqruxqWdGHfFc80Ch8J
         SxW5Gpdr3f67OwrMzsvpGoYwyHHUv9lu7uAjudKuzEeQFbs5GeP9Y1fMQlpvBPywqoLp
         0GUO9SzB/tCFA0XT7wmDrxB0cEIdtSnEXw98QTaod0vSD+ACVkqezfn++EUCTbfLwh15
         WeCQ==
X-Gm-Message-State: AOJu0YykJrjN+2CxTRZZK/Pk5MuPeD5k5worS1Fcw89kXT0ezZSUAcBg
        xNEIB5qQO2clB0Org5mMRGE=
X-Google-Smtp-Source: AGHT+IHB87s15cez9sVKr6yfH1HSR+x0sakHHdwVAEYjQprXEksklIJbJPK0dnmo6MXrBEDLIsCFpQ==
X-Received: by 2002:a05:6a00:2e20:b0:68e:42c9:74e0 with SMTP id fc32-20020a056a002e2000b0068e42c974e0mr22999550pfb.3.1697050854108;
        Wed, 11 Oct 2023 12:00:54 -0700 (PDT)
Received: from [10.3.171.174] ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0069319bfed42sm10344972pff.79.2023.10.11.12.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:00:53 -0700 (PDT)
Message-ID: <f1796d1a-bcd0-414d-b4e1-806e93eb202b@gmail.com>
Date:   Thu, 12 Oct 2023 00:29:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231010184827.1213507-1-anshulusr@gmail.com>
 <20231011-powdering-recycled-71608e794eaa@spud>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <20231011-powdering-recycled-71608e794eaa@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/11/23 21:45, Conor Dooley wrote:
> Hey,
> 
> On Wed, Oct 11, 2023 at 12:18:23AM +0530, Anshul Dalal wrote:
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
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>> ---
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
>>  .../input/adafruit,seesaw-gamepad.yaml        | 59 +++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>> new file mode 100644
>> index 000000000000..e8e676006d2f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Adafruit Mini I2C Gamepad with seesaw
> 
> Binding mostly looks good to me. My main question is what is a seesaw?
> 

Seesaw is a universal framework that enables extending I/O capabilities
of the i2c master devices with a compatible breakout board. As it
relates to the binding, this gamepad uses an AVR ATtiny816
microcontroller that reads the data from the buttons and the joystick
and sends the data to the master over i2c using the Seesaw framework.

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
>> +  Product page: https://www.adafruit.com/product/5743
>> +  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
> 
> I'm not really sure what the arduino driver has to do with the binding.
> Why is a link to it more relevant than the freebsd driver, or the linux
> driver etc? Is there info about how the pad works in the arduino driver
> 
> Otherwise, this seems good to me.
> 
> Thanks,
> Conor.

The Arduino driver I linked was the only resource that had the
implementation of the seesaw framework as well as the example code
specific to this device:
https://github.com/adafruit/Adafruit_Seesaw/tree/master/examples/Mini_I2C_Gamepad_QT
On further thought, a link to the accompanying document from the
manufacturer (https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf)
might be more relevant for the binding which includes the hardware
description as well as links to the above-mentioned Arduino driver.

> 
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

Thanks for the review.

Best Regards,
Anshul
