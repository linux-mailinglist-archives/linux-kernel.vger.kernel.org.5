Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4174755C06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGQGnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:43:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C811B8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:43:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992acf67388so519981366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576221; x=1692168221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9Ume/qTRfngrnyWbD+BRJS3/e2BWmcYqf3mdPXfSMQ=;
        b=cjZeXkVU6Pk6nF2snpWM2Mj6uikGUWkkeFnF8CZ86VOUjvH2prV0v9Hnd+TbPRR4H0
         2iXmJ2dg2PR4uHWEAe8j3TggGHcmd+LWqlF2NYhDxVcQWoilhH8lEMi3UBqvEqx4KErX
         UkKlxBPeuMwIwoDq0CLSGFm1cejon3fgLl/miymqlGDIcQ8lgOK4hcfsfsas6Yl69hTz
         ZnQ3ekP/zzWtdWMo2BhdMDervZM+scIP3a568xKL4ogZrpf5Z599ix04F3aqeth6iRId
         aaQ1DLRAaKqdCbfIVc2yGMc6svibja7UHDX6HQ0+BZOovxTYg7D5Fxnnr2x5T/UId8dA
         C/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576221; x=1692168221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Ume/qTRfngrnyWbD+BRJS3/e2BWmcYqf3mdPXfSMQ=;
        b=AvsBjcJCIpVlwGnOfixQDWtnYijA7tpeUylNKKosB8yPpLC67G3zfBexVQJrVjHpuJ
         VXlax8hcvCNy1w3b7Py3gCwmqPueoYFV/ER2OFy3neuNMNHdoLsutr07vYlru8PH+PzG
         MJIFYXCscnqNe0BdN+WnnSjuvuSlUEwrjgrozvSEnG9MdXnfj7Swfp53U8bDbhTYoCK3
         iuI+lKjVjFZy6NPhV1UH5KPjg3vx8ejiYSBT7C8PPhjS8oP22W7LjOxVHcfLt2VuKLBg
         VolbnkPH1Xe5l49/2adB3TwykljK1HiuPWYt8z1Lcf9H+Cu3/OVUGcVMmKKhc2ovItMD
         VfuA==
X-Gm-Message-State: ABy/qLZ5ndjPC/PzqPkUFlgkosqRkoti6/tA+IXHp5yQDmnVpnbuOJmc
        +CAyMs50SPGfsrArI6/c5FatdQ==
X-Google-Smtp-Source: APBJJlGR/Ol29HxtOvmYMnrVhmgGMv1ul3W+ZJjHfrbgeyHhp5GcsB6SnEqFlu9Iz5t8zfTpaSWIGA==
X-Received: by 2002:a17:906:20d6:b0:994:4e9c:30c6 with SMTP id c22-20020a17090620d600b009944e9c30c6mr3619450ejc.57.1689576221485;
        Sun, 16 Jul 2023 23:43:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b0098884f86e41sm8679105ejz.123.2023.07.16.23.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:43:41 -0700 (PDT)
Message-ID: <c266f810-6fb3-2fcd-1c44-163f9b0a0dbc@linaro.org>
Date:   Mon, 17 Jul 2023 08:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Content-Language: en-US
To:     "Li, Hua Qian" <HuaQian.Li@siemens.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
 <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
 <e57e5d8efc3107b5f2c4e66492650b9d0c17b898.camel@siemens.com>
 <625a92b8-b629-a4ef-6176-635e1b7885db@linaro.org>
 <b82847f51ec00d873a38eab21b7ada885593aeb8.camel@siemens.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b82847f51ec00d873a38eab21b7ada885593aeb8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 08:34, Li, Hua Qian wrote:
> On Mon, 2023-07-17 at 08:27 +0200, Krzysztof Kozlowski wrote:
>> On 17/07/2023 08:24, Li, Hua Qian wrote:
>>> On Mon, 2023-07-17 at 08:16 +0200, Krzysztof Kozlowski wrote:
>>>> On 17/07/2023 06:07, huaqian.li@siemens.com wrote:
>>>>> From: Li Hua Qian <huaqian.li@siemens.com>
>>>>>
>>>>> The watchdog hardware of TI AM65X platform does not support
>>>>> WDIOF_CARDRESET feature, add a reserved memory to save the
>>>>> watchdog
>>>>> reset cause, to know if the board reboot is due to a watchdog
>>>>> reset.
>>>>>
>>>>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>>>>> ---
>>>>> Changes in v4:
>>>>> - Fix the coding style.
>>>>> - Add usage note for the reserved memory.
>>>>> - Link to v3:
>>>>>  
>>>>> https://lore.kernel.org/linux-watchdog/20230713095127.1230109-1-huaqian.li@siemens.com
>>>>
>>>> Much more changed. You added example in the bindings which no one
>>>> asked
>>>> for. Then you added multiple fake review tags to all the patches.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Hi,
>>>
>>> Sorry for the wrong statement. I missed some key information and
>>> missunderstood `Reviewed-by`, I treated `Reviewed-by` as `Who
>>> has reviewed`.
>>
>> But you don't have even that information who has reviewed! Where do
>> you
>> see any reviews coming from me for patch #2? Where do you see reviews
>> from Rob for patch #3?
>>
>> Best regards,
>> Krzysztof
>>
> I got these information from my email thread. Anyway I made a stupid
> mistake, sorry for wasting your time.
> 
> By the way, when you wrote the following in '[PATCH v3 1/3] dt-
> bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET', you
> were kind of saying that it looks good to you if I remove the extra
> empty line, right?
> 
> In any case:
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This was patch 1. But you added my review to patch 2 also. Why then not
adding to patch 3? What logic is driving this?

Best regards,
Krzysztof

