Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECD7DBD55
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjJ3QCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJ3QCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:02:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7735CC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:02:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40806e40fccso31009325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698681759; x=1699286559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvcMoYkzxlHlBOVcPHB/eNx5ig0soooxsb0yzrw7Nw=;
        b=sEXQU/wsYUsnx7lXCbAwKmbQyeyHnpc9QdUHZxtpT8nKGf3+XUAN7X5/O6ZjfpSZoc
         JtWIUZeGF0NFDcEvhg+yqkJPVstP1L53ZPFER3lVsKeMENiqUZ/PyMw+ltqWJQ9zSrHC
         vysvHL1x7cvxmWdCvNvfFmQYgX7IlQnzkpJrIV8l0UlVRppWDbS+IoaG5PW2rGYOPRSK
         9wY1IQQHrP1BILNqHVtYEhRYQFEaGsooJLNKTjE6dTictPSvk4FCenkDh2yWLX/plZHC
         fWjj569K7nhBvd5O0/qbEiWjf18AFoOlm2YnsXUsdVXAt4cQY13Yjq9YzrH79LVPa19k
         HLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681759; x=1699286559;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVvcMoYkzxlHlBOVcPHB/eNx5ig0soooxsb0yzrw7Nw=;
        b=kYiJu/vSaffFxrOYWkniZKJabD6bd53yESV8F/jADuIi+HsEha+RfWJLEBQ+OGuF7H
         Hoa7I5xGeJaE56O78ZqE1QsmEDflYxA0qACvZC8P5rU0CHrw2xFOFRJBRy19IOnXvMFT
         qFxPrkSMRYix4Q1CsatboKb32SjSceRF4un/KDG86DQv9jFS+17wzjhMzQQrafa4cZEi
         8SdY4P5CSZobLx61CQZRHbqSXjVsbyLbRdv4++55A+Bmfbou4hYFo4OqsO4UQrTjcoha
         dHnWswrs4zWSEJKdHrvFuND21hfSjjdKdi+2NXNNZtruvYCRwMNZrbLufIlVqypfyx3Q
         nTlQ==
X-Gm-Message-State: AOJu0Yy7kmeLCAGJUUIMhSYQ4eAX2rD5brzqmcS3abgwrG79LNtU1hYw
        9BCIDmJLdclAfshfGyPsb4UpDA==
X-Google-Smtp-Source: AGHT+IG1ZBfAPdgT3Jfho4NUWM9LICqMhqAY+MKxWT//6P8N7hGkqhoVQfMAQO2HX4Hdh1crmbnzbw==
X-Received: by 2002:a05:600c:3594:b0:405:4daa:6e3d with SMTP id p20-20020a05600c359400b004054daa6e3dmr8364616wmq.39.1698681759249;
        Mon, 30 Oct 2023 09:02:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c068600b0040773c69fc0sm12878331wmn.11.2023.10.30.09.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 09:02:38 -0700 (PDT)
Message-ID: <7b30cb32-760a-4a73-8b89-3ac7bf26d3ca@linaro.org>
Date:   Mon, 30 Oct 2023 17:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI
 w1 host and MAINTAINERS entry
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Kris Chaplin <kris.chaplin@amd.com>
Cc:     thomas.delev@amd.com, michal.simek@amd.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231026093029.3122573-1-kris.chaplin@amd.com>
 <20231026093029.3122573-2-kris.chaplin@amd.com>
 <20231030154015.GA1141490-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231030154015.GA1141490-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 16:40, Rob Herring wrote:
> On Thu, Oct 26, 2023 at 02:28:41AM -0700, Kris Chaplin wrote:
>> Add YAML DT schema for the AMD AXI w1 host IP.
>>
>> This hardware guarantees protocol timing for driving off-board devices such
>> as thermal sensors, proms, etc using the 1wire protocol.
>>
>> Add MAINTAINERS entry for DT schema.
>>
>> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
>> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
>> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
>> ---
>>  .../bindings/w1/amd,axi-1wire-host.yaml       | 44 +++++++++++++++++++
>>  MAINTAINERS                                   |  7 +++
>>  2 files changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
>> new file mode 100644
>> index 000000000000..ef70fa2c0c5d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/w1/amd,axi-1wire-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD AXI 1-wire bus host for programmable logic
>> +
>> +maintainers:
>> +  - Kris Chaplin <kris.chaplin@amd.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amd,axi-1wire-host
> 
> Is there a device side implementation? I can't really imagine that 
> 1-wire would ever be implemented as firmware on the device side given 
> its limited nature. So adding 'host' doesn't make this any more 
> specific.

"host" here means "controller", to avoid the other naming "master/slave".

Best regards,
Krzysztof

