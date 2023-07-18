Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1374757D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGRNWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjGRNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:21:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD7170A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:21:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992ca792065so788094866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689686495; x=1692278495;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwF5nt29KeS1cw4tYrs90/ypdLt4g+/snxj0mPn4a4E=;
        b=BFRlenQhfJIX52UbLFUtETcfgvF//qG+29HWTmgkAfexCR9ZKU8r5MPxALWsYdP+HW
         Uz4j5rANREmGEd18ysHiwW250+f5GDo/Gn2WLO51KmIJVGmGHKbxje3aXQzzKKdI292K
         OszLREp6bdktXiviFGA1/kn+9scDR4FjZNsVIy+cMxtvSnaoTl7ZAEbB+I4GmQApWqlA
         3UjpkJsbQk6UXjvC2+urQSZQhYYsjATLVIc0Z6NJtJz0wY9hj+9WtSBNKq/gAjvwREJM
         ft83kyivf0qU2ZJ2q0WBTBmBhrmWg2Y+Cg7FYT9g8WTABgEKqEj4uNhoT58NptgnTkdl
         Z56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686495; x=1692278495;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwF5nt29KeS1cw4tYrs90/ypdLt4g+/snxj0mPn4a4E=;
        b=NYujdal4jBj/wELrmOIVG5VFU+TV5dzplVgas+N2Cq3+UYpmDF09FXRmiB/ZugXmZZ
         hvKfmP+n610NgvDW8rwO9yPRrEjOwHhXl9Pik2GlCIhmOps9bTRReOQ10mpcPm9aFPbN
         J7VeUydxEcWSuzJXxFrEoo+cvSQf2zJkLqaWJqI73Zbl6JEHl4IXZOCaL+dnV+yfc8le
         wAdQtwsP9Uv+w3WXIOVVbXFr0QU55KCoHlPRnnTToACAtRhYZQgnLRP0DKSndzcXflPn
         OHjNQ6CsH0ew6RpjlblkUOqh7mSMvMm4Ce/gXtcoqOrTYSyymv+n2/taaUjY6C703NFn
         AhyQ==
X-Gm-Message-State: ABy/qLb5/gvNBMcwjwpIb5RtR9ETIencv0vnHV+DL8s9EpuhA9UKbO48
        6SQfXPdb5PEODLkgB6sUB88DYQ==
X-Google-Smtp-Source: APBJJlFqmJrrU9WIZr317LOsIPbVfVxrj+EVAOTkECgrzq6uxJ68OCzylVw6G0IuO6Et67gd/P6IYQ==
X-Received: by 2002:a17:907:506:b0:98c:df38:517b with SMTP id wj6-20020a170907050600b0098cdf38517bmr11868053ejb.33.1689686495700;
        Tue, 18 Jul 2023 06:21:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f27-20020a1709062c5b00b00992ca779f42sm1034020ejh.97.2023.07.18.06.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:21:35 -0700 (PDT)
Message-ID: <5c45d89b-00c5-a330-2e1f-b99043736527@linaro.org>
Date:   Tue, 18 Jul 2023 15:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
 <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
 <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
In-Reply-To: <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 15:20, Krzysztof Kozlowski wrote:
> On 18/07/2023 15:11, Michal Simek wrote:
>>>>
>>>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>>>> values it is up to code to handle them. Checking nr_pins against ID is done in
>>>> core but it is up to drivers.
>>>
>>> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
>>> and have representation in Linux driver. You do not need to define
>>> anything virtual in the bindings.
>>
>> Not sure how you define ID itself. But HW doesn't know ID. HW knows only 
>> register which you can use to perform the reset. It is not really 128bit 
>> register where every bit targets to different IP.
>>
>> And this is SW-firmware interface like SCMI reset driver.
>>
>> Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
>> Their Linux driver is asking for nr_reset via firmware call which can be 
>> different for different SOC and that's fine and I have no problem with it.
>> But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different 
>> SCMI server implementation can map it differently.
> 
> Sure, and all this points to: no need for bindings.
> 
>>
>>
>>>> In our case that IDs are coming from firmware and driver itself is just matching
>>>> them.
>>>
>>> So they are the same as if coming from hardware - no need for IDs.
>>
>> It is hard to say what hardware here exactly is. From my perspective and I am 
>> not advocating not using IDs from 0 to max, it is just a number.
>>
>> If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to 
>> reach my goal which is reset QSPI IP.
>>
>> If you think that we should use IDs from 0 to max NR I am happy to pass this 
>> message to PM team and we should extend any SW to do translation between.
> 
> When we talk about IDs and bindings, we mean IDs meaningful to Linux.
> Whatever is ignored by Linux and passed to anyone else - hardware or
> firmware - is not a ID anymore from bindings point of view. It's just
> some value.

And just some proofs:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-versal-resets.h?h=v6.5-rc2
$ git grep VERSAL_RST
Results: No users.

Best regards,
Krzysztof

