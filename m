Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33A7FFF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377211AbjK3XC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjK3XC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:02:58 -0500
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F49194;
        Thu, 30 Nov 2023 15:03:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 539748285642;
        Thu, 30 Nov 2023 17:03:03 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0FjJotF92GqE; Thu, 30 Nov 2023 17:03:01 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id C66B582856D3;
        Thu, 30 Nov 2023 17:03:01 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com C66B582856D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1701385381; bh=ZpJbgFQ3mdlbdMzmJojwLkrCW5phxu5raWPOTJk0NC8=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=dzBfxqOp+tlY2NNmNLtywU3a1jrqlalYFaKM21/kouB+Lb2SHR9qfsGX1T1fBrLAZ
         XL4qJbVQSIEJ9J86VrGsqqkpQCXrRAmr3e/Ze/9zzwJ5DPYK8lGLUxykABgOEjvlT4
         icbL+lnY8iHkccQkgk47sH0jrpjNnOEMNc5VwF7I=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IpaV0MV63khI; Thu, 30 Nov 2023 17:03:01 -0600 (CST)
Received: from [10.11.0.3] (5.edge.rptsys.com [23.155.224.38])
        by mail.rptsys.com (Postfix) with ESMTPSA id 1A5188285642;
        Thu, 30 Nov 2023 17:03:01 -0600 (CST)
Message-ID: <eb29a877-8c71-498c-b5a1-320315b84cc7@raptorengineering.com>
Date:   Thu, 30 Nov 2023 17:03:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add sony,cronos-cpld
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>
References: <cover.1701203916.git.sanastasio@raptorengineering.com>
 <27ac3bf6e5fecd62918eb096a88503a13a1f0b9c.1701203916.git.sanastasio@raptorengineering.com>
 <c50e5224-7acd-4470-b18e-f223f150ba5b@linaro.org>
From:   Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <c50e5224-7acd-4470-b18e-f223f150ba5b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 3:23 AM, Krzysztof Kozlowski wrote:
> On 28/11/2023 22:00, Shawn Anastasio wrote:
>> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
>> controller that provides both a watchdog timer and an LED controller for
>> the Sony Interactive Entertainment Cronos x86 server platform. As both
>> functions are provided by the same CPLD, a multi-function device is
>> exposed as the parent of both functions.
>>
>> Add a DT binding for this device.
>>
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> ---
>> Changes in v2:
>>   - Change SIE to Sony to use the already-established prefix.
>>   - Clarify that Cronos is an x86 server platform in description
>>   - Drop #address-cells/#size-cells
>>   - Add missing additionalProperties to leds/watchdog objects
>>   - Add sony,led-mask property to leds object
>>   - Add sony,default-timeout property to watchdog object
>>   - Update example
>>
>>  .../bindings/mfd/sony,cronos-cpld.yaml        | 92 +++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>> new file mode 100644
>> index 000000000000..df2c2e83ccb4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2023 Raptor Engineering, LLC
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/sony,cronos-cpld.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sony Cronos Platform Controller CPLD multi-function device
>> +
>> +maintainers:
>> +  - Timothy Pearson <tpearson@raptorengineering.com>
>> +
>> +description: |
>> +  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
>> +  controller that provides both a watchdog timer and an LED controller for the
>> +  Sony Interactive Entertainment Cronos x86 server platform. As both functions
>> +  are provided by the same CPLD, a multi-function device is exposed as the
>> +  parent of both functions.
>> +
>> +properties:
>> +  compatible:
>> +    const: sony,cronos-cpld
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  leds:
>> +    type: object
>> +    description: Cronos Platform Status LEDs
> 
> Missing ref to LEDs common bindings.
>

Will fix.

>> +
>> +    properties:
>> +      compatible:
>> +        const: sony,cronos-leds
>> +
>> +      sony,led-mask:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> Why aren't you using LEDs bindings? A node for one property is otherwise
> quite useless. I already commented on this last time.
>

Our driver as-is doesn't support any of the properties in the LEDs
common bindings, but it doesn't seem like there's anything that would
preclude support in hardware, so this can be fixed.

Will use the LED bindings in v3.

>> +        minimum: 0x0
>> +        maximum: 0x7fff
>> +        description: |
>> +          A bitmask that specifies which LEDs are present and can be controlled
>> +          by the Cronos CPLD. Bits 0-5 correspond to platform Status LEDs, bits
>> +          6-10 correspond to Link LEDs, and bits 11-14 correspond to the Power
>> +          State LEDs. All other bits are unused. The default value is 0x7fff
>> +          (all possible LEDs enabled).
>> +
>> +    additionalProperties: false
>> +
>> +  watchdog:
>> +    type: object
>> +    description: Cronos Platform Watchdog Timer
> 
> 
>> +
>> +    properties:
>> +      compatible:
>> +        const: sony,cronos-watchdog
>> +
>> +      sony,default-timeout:
> 
> No, you must use existing bindings. Missing ref to watchdog and drop all
> duplicated properties like this one.
>

In this case the existing watchdog binding allows for arbitrary timeout
values to be set, but the hardware only tolerates one of a few fixed
values, enumerated below, which is why I felt it was appropriate to use
a vendor-specific binding that documents the supported values.

Would you still prefer we ref to watchdog and just handle unsupported
values in the driver by e.g. rounding or rejecting unsupported values?

>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: |
>> +          The default timeout with which the watchdog timer is initialized, in
>> +          seconds. Supported values are: 10, 20, 30, 40, 50, 60, 70, 80. All
>> +          other values will be rounded down to the nearest supported value.  The
>> +          default value is 80.
>> +
> 
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Shawn
