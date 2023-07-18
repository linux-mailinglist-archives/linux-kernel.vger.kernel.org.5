Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D910757D36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGRNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGRNUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:20:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2423011C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:20:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so7705584a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689686426; x=1692278426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWOtIA2FOFVa8PRRZ9oT4YgXxX5Q0c4ZWH1V2fHFko8=;
        b=tuCv5nNpIgNZNOk9InN3JuvIrDKEMvTFVXBhXyPskz8m/khI6AYxDlmAvvbwlMYeRO
         ZQq0+SnvDnXAIxwUeskNXgZB2AEMQf/Ge2t10snnrlfjD530P+xx3ZRqNeS9XzMEeedz
         T+AEKGFrwYJQQT4pgUzKmKXVw/pPXKurgcdhDpZ4ZJw/o1BRb5diEiGFgeBmTPia0D8c
         UMEHbm19zUUF5FNb192xqmCkGSGjTeAm8oQ353MQoVXSzx8kOO2EbwO5GBAtBlfGEZoS
         kSQ+X9qxyWYGn0itaFOuy2fsSXqlbDPoa6Bj/X/V7VpdHlobyxnZaaHxF8F/eHqMMbIo
         eFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686426; x=1692278426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWOtIA2FOFVa8PRRZ9oT4YgXxX5Q0c4ZWH1V2fHFko8=;
        b=ed8NAArz8TfRn3lkeHB8bf6xNxBCdgipZwAKW/sszlCl3CgCHvTcyQ2owoirCenNno
         Ht7QV+nBiWeEG1K7dzXZdkJFYHTEdKwfTTU2h2KxGTaFa5WFQXCKj/u6Lt7YQqwL+emE
         S/zgkKC1+C2jWLirmc1q9UxTeok3Ux6lIWrxprP5/XIhXyOCWW2AEXzEIze+QiyTn/h7
         +st4UQNpahkHKlqca6V5yj6vXlLjBQAuIEpWFmqITt8YTheHYE/TjLqGR2NOiZI0FSjP
         eXxaHMYyddNA5c/uOSXE+JtFaEm4yHMrXQ2Rwe/WNSzliCegaaqZrf0L6sLf7wBVqMr3
         QKyw==
X-Gm-Message-State: ABy/qLafPpvOiK28/DC8cYa1UEML2WNZnYTA6S4xX8uTMjEslYbJWl6W
        uLKAgviBrFlNalo/U+S3Lk2pkg==
X-Google-Smtp-Source: APBJJlGmSDTqKT1bqClQ7VNG9peQWayYbYAKzZ52ByeEncXh9CsvydwFEyqgGiZGFAQdygdkc8BpqA==
X-Received: by 2002:aa7:da51:0:b0:51e:22dd:5e90 with SMTP id w17-20020aa7da51000000b0051e22dd5e90mr11657748eds.4.1689686426505;
        Tue, 18 Jul 2023 06:20:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b00514a5f7a145sm1232174eds.37.2023.07.18.06.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:20:25 -0700 (PDT)
Message-ID: <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
Date:   Tue, 18 Jul 2023 15:20:24 +0200
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
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

On 18/07/2023 15:11, Michal Simek wrote:
>>>
>>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>>> values it is up to code to handle them. Checking nr_pins against ID is done in
>>> core but it is up to drivers.
>>
>> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
>> and have representation in Linux driver. You do not need to define
>> anything virtual in the bindings.
> 
> Not sure how you define ID itself. But HW doesn't know ID. HW knows only 
> register which you can use to perform the reset. It is not really 128bit 
> register where every bit targets to different IP.
> 
> And this is SW-firmware interface like SCMI reset driver.
> 
> Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
> Their Linux driver is asking for nr_reset via firmware call which can be 
> different for different SOC and that's fine and I have no problem with it.
> But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different 
> SCMI server implementation can map it differently.

Sure, and all this points to: no need for bindings.

> 
> 
>>> In our case that IDs are coming from firmware and driver itself is just matching
>>> them.
>>
>> So they are the same as if coming from hardware - no need for IDs.
> 
> It is hard to say what hardware here exactly is. From my perspective and I am 
> not advocating not using IDs from 0 to max, it is just a number.
> 
> If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to 
> reach my goal which is reset QSPI IP.
> 
> If you think that we should use IDs from 0 to max NR I am happy to pass this 
> message to PM team and we should extend any SW to do translation between.

When we talk about IDs and bindings, we mean IDs meaningful to Linux.
Whatever is ignored by Linux and passed to anyone else - hardware or
firmware - is not a ID anymore from bindings point of view. It's just
some value.

Best regards,
Krzysztof

