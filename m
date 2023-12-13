Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D981191E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378009AbjLMQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:21:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC15D91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:21:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso9299059a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484504; x=1703089304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1y0Kw2M6AclKKuX/NnPqhbtdzwBtWjX6oDFo/cd11E=;
        b=yT38vnfjPwgSVVD1or6DuC4ptJ/Cb5XHtjVZpFDc7Lwuq7JiFZBGJgOKN7uOoeACfs
         HUor5575NH3434fXrQ0jzC8sQy8JqhxWA97DBHvXfs4lunUVIzIXpn6oWDIKpLoGdeVe
         aogDpIpkazB/6MF6tqGNaqdoSITogjGIrmCVuU8qUejSITnED4ga2zbwnh1fwLcrruHQ
         VvglTv7aVnQJ3cl97f4P/iWgXM8u9CzFebmsLIO6pXXus3bk1oGZeJ/tf0uhzpk4NoK8
         wDHlU1F6EzZg/6s200soBkOiI+HBwlrynl2WRug+jKIudHajH15RVbUT52Zu+UUkQ89B
         fRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484504; x=1703089304;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1y0Kw2M6AclKKuX/NnPqhbtdzwBtWjX6oDFo/cd11E=;
        b=VE6yftwhySIVlD4TfmgLHBLc5jqD2YqWlewCJOsuFrUFcyG0jxDT+qeAJwJoPDDvID
         xAsE/Zo2uYfk1ip0DBvWx4zq7vt/99LNT6p5XGo3kuTI3z+HozxdArXWwE2Gwl5iMuD+
         k2fmgarZA/mVtlU+hkcTM5QLeKdyUMckw2ixA30XqVTRkCkgHOlhZVKu6oZX/qRITV+9
         noYM68bfzmWeUaCMpayuK5fmhGegPwnWqDidNyZBhoZ6e2b8ofWFu+lEoleRDNrP4BFu
         I8GMiBzNLlOXGx9NolfuWA1UIa544TGYWVaUjgLmQ6HoNwMn0SdXrT/ALHxIrlcK9OQ5
         fhXg==
X-Gm-Message-State: AOJu0YwCxCf4SuEH6TNxyt6M9baQgSHmTWHoLRdAOdIu6PyacChj63fH
        KjXKuVTjkWisun1xJ3ciZ0+RMw==
X-Google-Smtp-Source: AGHT+IGI6om1T8GUxq2wl7nod3bb2sPw+6mUMdRB+9pPu/5fysZ1XLl/E20kQJPzwlHUS0G3KYIJvA==
X-Received: by 2002:a17:907:94d5:b0:9b8:b683:5837 with SMTP id dn21-20020a17090794d500b009b8b6835837mr5318654ejc.46.1702484504531;
        Wed, 13 Dec 2023 08:21:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a1c522990ccsm8031034ejc.85.2023.12.13.08.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:21:44 -0800 (PST)
Message-ID: <daa14201-2027-4732-bbea-acbb2675e4b8@linaro.org>
Date:   Wed, 13 Dec 2023 17:21:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mailbox: add Versal IPI bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com,
        shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Levinsky, Ben" <ben.levinsky@amd.com>
References: <20231212230353.888714-1-tanmay.shah@amd.com>
 <d91a9278-f70e-4f0f-92c1-ce0bdac69ff5@linaro.org>
 <44052047-06c9-4b95-b040-2d4c7c1343d1@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <44052047-06c9-4b95-b040-2d4c7c1343d1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 17:18, Tanmay Shah wrote:


>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> I don't understand why this change is here. Previously you did not have
>> MMIO address space? If yes, then where do you restrict the old device to
>> disallow these?
> 
> 
> Hardware description is different between ZynqMP and Versal. And so, we have to design
> 
> new bindings for Versal. reg and reg-names for parent node, is only available for new devices.
> 
> The new device is checked with compatible string after "required" section.

Hm? What does that mean?

> 
> Should I add "unevaluatedProperties: false" after "additionalProperties: false" for parent node below [1] ?

No, you should disallow reg/reg-names for older device.

...

> 
>>> +        then:
>>> +          properties:
>>> +            reg:
>>> +              items:
>>> +                - description: Host agent request message buffer
>>> +                - description: Host agent response message buffer
>>> +                - description: Remote agent request message buffer
>>> +                - description: Remote agent response message buffer
>>> +
>>> +            reg-names:
>>> +              items:
>>> +                - const: local_request_region
>>> +                - const: local_response_region
>>> +                - const: remote_request_region
>>> +                - const: remote_response_region
>>> +        else:
>>> +          properties:
>>> +            reg:
>>> +              minItems: 1
>>> +              items:
>>> +                - description: Remote IPI agent control register
>>> +                - description: Remote IPI agent optional message buffer
>>
>> Were these described in old binding? If not, it's a separate change.
> 
> Okay, so I will split this in two patches:
> 
> 1) Clean up current bindings (like remove redundant descriptino, sort "required" property order etc..)

If you want to combine cleanup and functional changes, then this would
be two patches.

> 
> 2) Add versal platforms bindings doc. (This will add if else cases and Versal platform support)

> 
> 
>>> +
>>> +            reg-names:
>>> +              minItems: 1
>>> +              items:
>>> +                - const: ctrl
>>> +                - const: msg
>>
>> Blank line
>>
>>>  required:
>>>    - compatible
>>> -  - interrupts
>>>    - '#address-cells'
>>>    - '#size-cells'
>>> +  - interrupts
>>
>> Separate change with its own rationale. Trivial cleanups can be
>> organized in one patch, but should not be mixed with adding new devices.
> 
> Ack
> 
> 
>>>    - xlnx,ipi-id
>>>  
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - xlnx,versal-ipi-mailbox
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          items:
>>> +            - description: Host IPI agent control registers
>>> +            - description: Host IPI agent optional message buffers
>>> +
>>> +        reg-names:
>>> +          items:
>>> +            - const: ctrl
>>> +            - const: msg
>>> +
>>> +      required:
>>> +        - reg
>>> +        - reg-names
>>> +
>>> +additionalProperties: false
> 
> [1] Here, if I add unevaluatedProperties: false then is it enough for old device to disallow

No, you need reg:false

Best regards,
Krzysztof

