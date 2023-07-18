Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB8757EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGROGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjGROFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:05:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2DC1BCF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:04:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991ef0b464cso1458609666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689689092; x=1692281092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6RsDUtePE5yYmSNHxwgf3wpYrZvBFfHtoQUO0iomjA=;
        b=laiLAHTcKJZWXzarThny3O4524qd6vIrjWCNrqvkMqmvug7WWDpZ4I9siXHZFl8xBE
         HQGSJNGdqXsV2d4CFkSBjvc9GV5CmQ6tnJtXLxRxmuD2/Rj7yE1/FEpCQHBP81aIgGP2
         ffv9T01L61CMoE51RtD16aRSJEVRcKH4L9aan8MMhpLrrUWDHn7KqmxTbI6kzMDdnu9b
         3/tZUIWg/zosoRe0jfkvNwcp9rFRM1Kd/fAd/4wMgiAihBxa2urjxnznHU8mmYjmpmGi
         OgF9qUbhJJE3RCISp0eyXna64OOsnm+9uoQ7xQdeBsrx+E4u8VFHs59iqeUzQYG4wJtV
         rAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689689092; x=1692281092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6RsDUtePE5yYmSNHxwgf3wpYrZvBFfHtoQUO0iomjA=;
        b=M6N6NaHFrBMn/5nGQDswDcjqAdNwkVW12hXXb+GCQatZlQMsrswjAakBgttLsNSpE0
         on4s4r2TlExbJ4Zn25hLAOYibdoP3vmv30Ola8dzn5YXORrYYj0JrwEfbBlLuwKW6d3l
         8OFzOEJ4N0XppPJ+ZEjs7S2vli/dLy36/YE+iSQyUuxHlbJPA1R692f8nraNSjkJ2XFd
         PXBeplp5jI1+Qc645nQoAm2F1ytKs/xvWfcY9r0pdGsxS03/WH/UukTwWwrbbbJt4CSq
         FFePNXJMx3KYNkT7r4Yqc05H7M1ixjffwkP3kwqYU7dl5AQghhKSLpOYZICl3D010mmU
         3y0A==
X-Gm-Message-State: ABy/qLaauDSWbG2p3yxiWcQnZ7ftbpI42U3gvNSXL3Nrq4LOmGJlUh2L
        WQyAQ4SyHmCmCk/VNM2EXNOpOQ==
X-Google-Smtp-Source: APBJJlFc12/e9H+aNKu7RoV+lKTDzUFJMwWj4a79CijJz+3+/nkag6SKSn9mhmFj9SyGF00vcn8uRg==
X-Received: by 2002:a17:906:68c9:b0:989:450:e565 with SMTP id y9-20020a17090668c900b009890450e565mr14132620ejr.23.1689689091810;
        Tue, 18 Jul 2023 07:04:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gy11-20020a170906f24b00b009737b8d47b6sm1044691ejb.203.2023.07.18.07.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:04:51 -0700 (PDT)
Message-ID: <4c932cbf-19db-2c88-2558-aa42c5338598@linaro.org>
Date:   Tue, 18 Jul 2023 16:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
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
 <5df3e976-9fc2-19af-e6b4-e2bea0d64623@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5df3e976-9fc2-19af-e6b4-e2bea0d64623@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 16:01, Michal Simek wrote:
> 
> 
> On 7/18/23 15:20, Krzysztof Kozlowski wrote:
>> On 18/07/2023 15:11, Michal Simek wrote:
>>>>>
>>>>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>>>>> values it is up to code to handle them. Checking nr_pins against ID is done in
>>>>> core but it is up to drivers.
>>>>
>>>> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
>>>> and have representation in Linux driver. You do not need to define
>>>> anything virtual in the bindings.
>>>
>>> Not sure how you define ID itself. But HW doesn't know ID. HW knows only
>>> register which you can use to perform the reset. It is not really 128bit
>>> register where every bit targets to different IP.
>>>
>>> And this is SW-firmware interface like SCMI reset driver.
>>>
>>> Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
>>> Their Linux driver is asking for nr_reset via firmware call which can be
>>> different for different SOC and that's fine and I have no problem with it.
>>> But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different
>>> SCMI server implementation can map it differently.
>>
>> Sure, and all this points to: no need for bindings.
>>
>>>
>>>
>>>>> In our case that IDs are coming from firmware and driver itself is just matching
>>>>> them.
>>>>
>>>> So they are the same as if coming from hardware - no need for IDs.
>>>
>>> It is hard to say what hardware here exactly is. From my perspective and I am
>>> not advocating not using IDs from 0 to max, it is just a number.
>>>
>>> If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to
>>> reach my goal which is reset QSPI IP.
>>>
>>> If you think that we should use IDs from 0 to max NR I am happy to pass this
>>> message to PM team and we should extend any SW to do translation between.
>>
>> When we talk about IDs and bindings, we mean IDs meaningful to Linux.
>> Whatever is ignored by Linux and passed to anyone else - hardware or
>> firmware - is not a ID anymore from bindings point of view. It's just
>> some value.
> 
> Please correct me if I am wrong. Description about ID should be removed from 
> commit message because it is not necessary. And
> include/dt-bindings/reset/xlnx-versal-net-resets.h
> should be added when we merge also DT for versal-net SOC.

No, the binding header is needed only if driver is using it. Adding DTS
will not change that - still no kernel driver users. No benefits of such
binding. If there are no users and no benefits - don't make it a binding.

Best regards,
Krzysztof

