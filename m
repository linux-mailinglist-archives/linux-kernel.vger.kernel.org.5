Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCA7C6B99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377851AbjJLKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343721AbjJLKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:55:25 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2E90;
        Thu, 12 Oct 2023 03:55:22 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so32496fac.0;
        Thu, 12 Oct 2023 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697108121; x=1697712921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x3KnRFbiMBM4MEwZD3vZNUeQUH1/byVeDQygOKbchgU=;
        b=WTxODGV7DWA8uTiweWgLbMsC/RtU3I8+C5Ko8KZy10od9GH/Up3PQXj8wT+wEA4kyN
         z54L/PgsInp/H1bHwm73wgN9jiO/4917R8VnSFDsgUHefvsdXmmIKIH5aPPnUmdcp3+P
         N//7krfuMAQbEzIgGtozZ3RMHajxzeqPEisVHz+CEfseBQkz8q/wSWL6r+UDnmC3h2uC
         9ri3SU4DE13qXnLbrFUKVq4SV1Le3RcPT+yagoLdd2VGps5kCuCTH6IFct8Ib2zdLTa/
         HAYfrnmd6BU7kpGBC2/BG6nFzrk85hnGHddX+LEuLshWcioxEnOIK0ym9v6/l3DBb0zj
         4q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697108121; x=1697712921;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3KnRFbiMBM4MEwZD3vZNUeQUH1/byVeDQygOKbchgU=;
        b=JjzegctEn9Wz8VYUgdYKaH3peE3aA96ZWDGmOuilH35IlR+kUcxgWMiH6JwadaHD1a
         ZetH2lSmdLCo1quLF13K3/8Vb1R9C3POMzhXp/XHpyhk47V+A/9hbi8BHHjNTCPnNX1T
         I05N27C1cHNmUeLrdKKS3bhZ9d23G0nNJyC/wjAee7FjLiIqJBzEY97gbnXPa24TUmMt
         dqRVyp8FH08UdiJD5IHNDLnvRNoTuk/DmH4ktRG2jQpfDtTYR+VgSaYAgtkl4/21vg+g
         0+S+wcNUsU2An2UeflfcNIKB25C6TIIzqNNFmEpSfGcrH7zvZ9JI71rRnjHZjjA95QXQ
         MNMQ==
X-Gm-Message-State: AOJu0YwHVJPG4Ya9l/RcmDFs/Xu4TCD5r6JCoGE6sjW6meKrrHGsbKpi
        5H3Wc2PXyXwwKmdk1J5efO8=
X-Google-Smtp-Source: AGHT+IHAoOJnsEI7SPBYfqlJ56NdhKD+FcQimx5Qlw3wyLT2TBtJDEUg0+ZXi811IaPilSrGm0fGZw==
X-Received: by 2002:a05:6870:671b:b0:1e9:8a35:863a with SMTP id gb27-20020a056870671b00b001e98a35863amr6155284oab.20.1697108120826;
        Thu, 12 Oct 2023 03:55:20 -0700 (PDT)
Received: from [10.5.253.103] ([103.4.220.252])
        by smtp.gmail.com with ESMTPSA id b8-20020a637148000000b00589b7a9ef01sm1456456pgn.36.2023.10.12.03.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 03:55:20 -0700 (PDT)
Message-ID: <27068b3a-50dd-4b24-8947-1329889efe89@gmail.com>
Date:   Thu, 12 Oct 2023 16:24:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Anshul Dalal <anshulusr@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231010184827.1213507-1-anshulusr@gmail.com>
 <7c570333-7334-435c-83cd-225817afc51c@linaro.org>
Content-Language: en-US
In-Reply-To: <7c570333-7334-435c-83cd-225817afc51c@linaro.org>
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

On 10/12/23 14:09, Krzysztof Kozlowski wrote:
> On 10/10/2023 20:48, Anshul Dalal wrote:
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
>> +
>> +properties:
>> +  compatible:
>> +    const: adafruit,seesaw-gamepad
> 
> I thought seesaw is a name of a device, but it is not, thus it is  quite
> a generic compatible. Are you sure device does not have its name?
> Looking at product page, it indeed might not have.
> 

I chose the title from the datasheet:
https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
It lists the product name as "Adafruit Mini I2C STEMMA QT Gamepad with
seesaw" with STEMMA QT being the name of the 4-pin i2c connector that
Adafruit uses on their products. That's the most specific name for the
product I could find.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Anshul
