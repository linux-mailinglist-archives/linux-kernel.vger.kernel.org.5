Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C07BEC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378166AbjJIVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:04:15 -0400
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C7FA;
        Mon,  9 Oct 2023 14:04:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 4993C82857C4;
        Mon,  9 Oct 2023 16:04:07 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z7CCEeCb38Ia; Mon,  9 Oct 2023 16:04:06 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 5CA888285979;
        Mon,  9 Oct 2023 16:04:06 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 5CA888285979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1696885446; bh=ZQNCGn0ZDX59gKnFkH//6GHOgDpANzRTRpSPuZxiaU0=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=UprhLkhPFIv5BHPXCjXxxn5O09gJq/B5ymWeQG/lvwbjsf8cqLfJQOHL7tpJwtErb
         XBjWzvxgCmKR/RBma+/gFAqD0KkQMz0E1+uIyw93J4KYIF09MJSqQ48IQ9OpY9Wa84
         ImTsOeYAjNlKZpq78KSMWbxaWhRCJSsjczKrNjZo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 25ekiDGmw4Ns; Mon,  9 Oct 2023 16:04:05 -0500 (CDT)
Received: from [10.11.0.3] (5.edge.rptsys.com [23.155.224.38])
        by mail.rptsys.com (Postfix) with ESMTPSA id 9185482857C4;
        Mon,  9 Oct 2023 16:04:05 -0500 (CDT)
Message-ID: <75446d81-449d-b8c9-3e1c-2d9ef8d61e28@raptorengineering.com>
Date:   Mon, 9 Oct 2023 16:04:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] dt-bindings: mfd: sie,cronos-cpld: Add initial DT
 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, lee@kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696285339.git.sanastasio@raptorengineering.com>
 <8b014f8b302f8b41c45c4f6fb114cf18e84a76fa.1696285339.git.sanastasio@raptorengineering.com>
 <7ed841ee-765b-47a6-8a28-3c4df6b21185@linaro.org>
From:   Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <7ed841ee-765b-47a6-8a28-3c4df6b21185@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 4:22 AM, Krzysztof Kozlowski wrote:
> On 03/10/2023 00:32, Shawn Anastasio wrote:
>> The SIE Cronos Platform Controller CPLD is a multi-purpose platform
> 
> What is SIE? Vendor prefix says sony.
>

(Repeated from my response to your reply to patch 1)
Sony Interactive Entertainment is a separate corporate entity and it's
the one that created the hardware to which this driver pertains.

> What is Cronos?
>

Sorry, I'll amend the description to clarify this. Cronos is an x86
server platform developed and deployed by SIE.

> 
>> controller that provides both a watchdog timer and an LED controller. As
>> both functions are provided by the same CPLD, a multi-function device is
>> exposed as the parent of both functions.
> 
> A nit, subject: drop second/last, redundant "DT binding". The
> "dt-bindings" prefix is already stating that these are bindings.
>

Will do.

>>
>> Add a DT binding for this device.
>>
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> 
> Except that this was clearly no tested...
> 

My apologies, it seems I didn't have all of the required dependencies
installed locally to enable dt binding validation. Will fix.

>> ---
> 
> ...
> 
>> +properties:
>> +  compatible:
>> +    const: sie,cronos-cpld
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
> 
> Why do you need it?
>
>> +
>> +  '#size-cells':
>> +    const: 1
> 
> Also looks unneeded.
>

These were inherited from an existing dt binding in the tree that I used
as a reference. I'll drop them both at your request.

>> +
>> +  leds:
>> +    type: object
>> +    description: Cronos Platform Status LEDs
> 
> Missing additionalProperties:false... but anyway this is just empty. No
> resources? Drop the node.
>

Having nodes for the leds and the watchdog allows the two independent
functions to be enabled/disabled in the device tree by adding/removing
the relevant object. Would it be more idiomatic to instead introduce
properties to the parent sie,cronos-cpld object to toggle these
functions?

>> +
>> +    properties:
>> +      compatible:
>> +        const: sie,cronos-leds
>> +
>> +  watchdog:
>> +    type: object
>> +    description: Cronos Platform Watchdog Timer
>> +
>> +    properties:
>> +      compatible:
>> +        const: sie,cronos-watchdog
> 
> No resources? Drop the node.
> 

Same question as above.

> Best regards,
> Krzysztof

Thanks,
Shawn
