Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7397B756E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGQUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGQUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:47:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E31A6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:47:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fdb856482fso3044650e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689626876; x=1692218876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0o8ckZBUZuUaMhooSth+n6+S+US/RZWlBGdRuFJcW8E=;
        b=oVHLqHD6B9siyR8qNsDpRZJsNGZyeh9TN2wzGKfYdl10D55MvOWqT9Qjw22KFxtFy3
         olT26wyF5wwSEe/e1pDasBKFm4rSgfNYZ7P2Jjv2U/ubLhzk+ExSLGr8/zcbCrZH+sBg
         F/XaFTUJyhCbjYM9A6ZbS+QzV59AmZbXjPkl6URO6mrowW7xdgMeLmtdxQ6iMH2H4Mtu
         Hhu0+FOLekw9qsk+9erbLaTqi+YhfdvaTgA1q72G4mKqAER0oa1aALlAaUMO32KfdE0H
         CD7IilKyhVIybp5ei3f2gruo/s0qZu6vmN+PBIS96eqgsyZXPsxYteSYuFRakS9ICW0c
         VwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626876; x=1692218876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0o8ckZBUZuUaMhooSth+n6+S+US/RZWlBGdRuFJcW8E=;
        b=DIAxGjwLfoLKY091ppAfLmIlEwwd/d9WGN48vwf+3y4BYFljw56GKt8mNZmSLsXqYs
         w3aiuf5UiS3veXKDaGWy61Z5EHIOZMuuLCeEn8Wo3J8i9lOl7urMhKR/4LSrcRnU7i3n
         ejGpuF4lDmF3aLL+N5ZzfziG5ShTtUAc4PBs7iqNUVw57Kd9Ld6b52Jcdp9dy05p4PWa
         78+sbgP0VS1LbJEciGnFzURyhtd1ccPkKo+Ao2ststmotlcAwH/99X3RxtiYZXGh4loe
         jvu4k39AzSP3LVLr+NE3FZco1QORg11EeJS/upEZh4sks2xhG8e3UqQQYl6BrnP6kd8O
         KEGQ==
X-Gm-Message-State: ABy/qLZz4wxy6YbsI9ExyQZsZN8JVjGXCo3XQmhMGbTpG88rTnQ+aB5J
        wrrDitQwE6UDO3FcShjUw9Fnew==
X-Google-Smtp-Source: APBJJlFALZDQq5DOa2yxPMX33d+1cHKLT9pUDzNAnNYlfepByUkKnpdlix9l3gU/Sm2a6teyqVFjxw==
X-Received: by 2002:a05:6512:23a7:b0:4fd:c771:ed76 with SMTP id c39-20020a05651223a700b004fdc771ed76mr1595068lfv.38.1689626876309;
        Mon, 17 Jul 2023 13:47:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i19-20020aa7dd13000000b0051de3c6c5e5sm107992edv.94.2023.07.17.13.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:47:55 -0700 (PDT)
Message-ID: <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
Date:   Mon, 17 Jul 2023 22:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, michal.simek@amd.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717-explode-caucus-82c12e340e39@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 20:40, Conor Dooley wrote:
> On Mon, Jul 17, 2023 at 04:53:47PM +0530, Piyush Mehta wrote:
>> Added documentation and Versal-NET reset indices to describe about
>> Versal-Net reset driver bindings.
>>
>> In Versal-NET all reset indices includes Class, SubClass, Type, Index
>> information whereas class refers to clock, reset, power etc.,
>> Underlying firmware in Versal have such classification and expects
>> the ID to be this way.
>> [13:0] - Index bits
>> [19:14] - Type bits
>> [25:20] - SubClass bits
>> [31:26] - Class bits.
> 
> Riight.. I'm not sure that describing these as "indices" is really all
> that valid, given only 13:0 are actually the index.
> I'd be inclined to say that the type/class/subclass stuff should not be
> part of the dt-bindings, and instead looked up inside the driver
> depending on the index.
> 
> Hopefully Rob or Krzysztof can comment further.

This confuses me as well. I don't understand why do you need it in the
bindings. Nothing uses these values, so storing them as bindings seems
pointless.
> 
> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>> ---
>>  .../bindings/reset/xlnx,zynqmp-reset.yaml     |   4 +
>>  .../reset/xlnx-versal-net-resets.h            | 127 ++++++++++++++++++
>>  2 files changed, 131 insertions(+)
>>  create mode 100644 include/dt-bindings/reset/xlnx-versal-net-resets.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
>> index 0d50f6a54af3..b996fc1d4e53 100644
>> --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
>> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
>> @@ -27,11 +27,15 @@ description: |
>>    For list of all valid reset indices for Versal
>>    <dt-bindings/reset/xlnx-versal-resets.h>
>>  
>> +  For list of all valid reset indices for Versal-NET
>> +  <dt-bindings/reset/xlnx-versal-net-resets.h>
>> +
>>  properties:
>>    compatible:
>>      enum:
>>        - xlnx,zynqmp-reset
>>        - xlnx,versal-reset
>> +      - xlnx,versal-net-reset
>>  
>>    "#reset-cells":
>>      const: 1
>> diff --git a/include/dt-bindings/reset/xlnx-versal-net-resets.h b/include/dt-bindings/reset/xlnx-versal-net-resets.h
>> new file mode 100644
>> index 000000000000..b3e7d5e4c33e
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/xlnx-versal-net-resets.h
>> @@ -0,0 +1,127 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_VERSAL_NET_RESETS_H
>> +#define _DT_BINDINGS_VERSAL_NET_RESETS_H
>> +
>> +#define PM_RST_PMC_POR                          (0xc30c001U)

IDs start from 0 and are incremented by 1.

Best regards,
Krzysztof

