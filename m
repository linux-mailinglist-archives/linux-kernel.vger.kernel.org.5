Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0057EB7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjKNUcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjKNUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:32:20 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622BF7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:32:16 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so3573247a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993935; x=1700598735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B76Bj7QSkdqe5RgWuzmisGli3L6/dGQzU+oDX8ILkao=;
        b=rfC8INpkqLDIhdYdUFKoqh5gsBtjsRb2337Gzk4LUe91OQ0YBZZBd0mjlL+HmENbyu
         HPU5KtHRpiNjZu44rGKqoia2Z4zgJzSItmhLlZ02s4pWbKrg5gK1m6Trl/I2BSt4Y3fH
         Yg1mkbnv/Nh48Wbww9ivNQ+DE07zjVXutDkOJwNETgnUxOfkkOoy+fDBhAklJN52swEG
         rXnBByEBxThUTADR+6na/61PfQ7zn5EbSf1KTyQjS9yZLD3qvxgbIERiF+I/M+kl3N7N
         +NHQIVtb8l4bhcRKVXvuFwUwaX5oW0ThPEu2p4SknQLHHucq0TNR/Yj985PZVZk2ACxm
         oeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993935; x=1700598735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B76Bj7QSkdqe5RgWuzmisGli3L6/dGQzU+oDX8ILkao=;
        b=XwxhSjZ9wFh0nfsmOGPNaz16lzGrn0e8ncI8gQkrUZzouN+S2vhjNRbttnXAxUFNAW
         OF8XXwFNRFGgTlOTMxTCCmuR7BFKdaVZdJe5lTe2beIG5GnXB703NNpwrvcZzfs3HHY9
         lqgve/ubqKLrUpDHqAdd3NgPqtf5TVm7tXPp972bONFOVgDjbsSz+hZdXETbaxLo2U3I
         Tqg43oyMEu+nvfmRh05Nf1sOPbf783bh32dqFDXI9kSV/mH4g5YOX0eOPbidh2dZ3HtO
         O5cFMfIfVK29fB11HYPWr6j/tgExAL/3IGsS+iqFA2ZHXJxQU8tG+O59HU2Hv+LOjjQB
         umPA==
X-Gm-Message-State: AOJu0Yz1a6tPfQaDoLhj5d2hYTprIiUPPar+U0YwNIqzAoVMjU76l0LD
        wKIKb3iIHtr+CPwkApgkIw8Y2A==
X-Google-Smtp-Source: AGHT+IHWuJowqXdwedX9Bz2Qb/ucm0pdfbQO5Zy4r7Im9oftuEVjqUAp1mE8lMHliIP5TnecnFZjZQ==
X-Received: by 2002:a05:6830:18fc:b0:6d3:2960:c49 with SMTP id d28-20020a05683018fc00b006d329600c49mr3456703otf.26.1699993935462;
        Tue, 14 Nov 2023 12:32:15 -0800 (PST)
Received: from [172.25.83.73] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a0ceecd000000b00671b009412asm3132110qvs.141.2023.11.14.12.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 12:32:14 -0800 (PST)
Message-ID: <f8c3910a-ee05-4478-aeff-6f6bf6e1c6a4@linaro.org>
Date:   Tue, 14 Nov 2023 21:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231108005337.45069-1-anshulusr@gmail.com>
 <0defc0e3-dc15-459d-9e71-64f3c38a6931@t-8ch.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0defc0e3-dc15-459d-9e71-64f3c38a6931@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 20:20, Thomas Weißschuh wrote:
> On 2023-11-08 06:23:35+0530, Anshul Dalal wrote:
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
>> ---
>>
>> Changes for v8:
>> - no updates
>>
>> Changes for v7:
>> - no updates
>>
>> Changes for v6:
>> - no updates
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
>> ---
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
> 
> I don't really have any clue about devicetree, but shouldn't the actual
> driver have an id-table for this "compatible"?

It should, why was it dropped?

> 
> It had one up to v5 of the patchset.
> 
> Jeff had some comments about the OF aspect [0], but to me the state now
> seems incorrect.
> Maybe the DT can be dropped completely?
> 
> Jeff, could you advise?
> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
> 
> Interrupts are not supported yet by the driver.
> Should the property be there already?

Bindings describe the hardware, no the driver. If the hardware has
interrupt line, it should be described here.


Best regards,
Krzysztof

