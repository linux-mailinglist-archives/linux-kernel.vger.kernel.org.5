Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020CF803337
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjLDMk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjLDMkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:40:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E1C0;
        Mon,  4 Dec 2023 04:40:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bfe99b6edso255009e87.1;
        Mon, 04 Dec 2023 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701693648; x=1702298448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsvgyciOFfSmw/EJbODu9yWaFL86QzDmPatwDo6fAHA=;
        b=Fjf1Kq7/tv9oz7JTqV64win0IKsNL3NWQEfjpZuPkkNen0d5gINb3pV8wOq+e+5mE9
         DZrBIuu2sLrpbCtMNZRKTZJhqd37XsAO231t7gp9DTIKZmRj9937fS8h+631sirpirG7
         nIwiKrP6My4OMqzSeG+tUfUZYYR5j5+5veVnKFBvLeKaE4Ljdx/FGw+iMyRxevOauZhB
         peCYbW5pSDAALcqCr65/XJt9+5LouX8tlrVSHnSmGavqnVYUO2cTblRdnZ1q6fQYzNqF
         DewAQTP00qjTAM9t6Muq8v7DiwzvkmJzW19dJgXHwuJFCiP97fQ6eZZhUOtGBvhXZEOX
         qj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693648; x=1702298448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsvgyciOFfSmw/EJbODu9yWaFL86QzDmPatwDo6fAHA=;
        b=pjC29NF12R9rzw1BLisL6whKAz0JhBEtsgznK9Sci1O0OnZo+yHRh8iKPuFUMZyoXt
         J6Dyhae9VixBzH0jjTbB1e7JD+XB2Bw2VLFoU9woCqlt97R4ljUfKO5pVVGL4BfGg+1V
         3ZbmAGtg4AOubYxQhEAs6JlZ0tDLS9H14jqXu+HhQior/kA0QUbHQNbP0xeJAq51EfAt
         XWt6RXqeKXj5hmJOLk+HTjAiK5l/iai9p3K9TukuSNU5NLPDeTCZnljA+I6RjCOijReu
         lymXOTKEk/59FTLSEu8dxODzFWfoxrGOciWCSs8GIcIrkC/zNhjokXIHmw5UqYEPv2fS
         3ZsA==
X-Gm-Message-State: AOJu0YyEHL7/NCeg9dgr8UQ0eQq65Ey47lgDDe+rQMYqQOHzul2EU/PU
        u/wYyjW/S60S6X8x4qFfchE=
X-Google-Smtp-Source: AGHT+IGt7rvUqmjUimncGXW2IXVdDHVFAV2T7wKaPCUQGmJMe3Y29H7WiKNl0nj1VyY+oyfMrbTxdA==
X-Received: by 2002:ac2:560a:0:b0:50b:f041:e434 with SMTP id v10-20020ac2560a000000b0050bf041e434mr1055315lfd.70.1701693647568;
        Mon, 04 Dec 2023 04:40:47 -0800 (PST)
Received: from ?IPV6:2a02:2378:120d:1a46:8f76:bf32:c739:eb6e? ([2a02:2378:120d:1a46:8f76:bf32:c739:eb6e])
        by smtp.gmail.com with ESMTPSA id q3-20020ac246e3000000b004fb7848bacbsm1250826lfo.46.2023.12.04.04.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:40:47 -0800 (PST)
Message-ID: <0a035c62-9d35-4f85-b1f3-bcb7dea17d52@gmail.com>
Date:   Mon, 4 Dec 2023 14:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: input/touchscreen: Add compatible for
 IST3038B
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-3-karelb@gimli.ms.mff.cuni.cz>
 <20231203-outskirts-reformat-e0a833903841@spud>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20231203-outskirts-reformat-e0a833903841@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 12/3/23 13:20, Conor Dooley wrote:
> On Sat, Dec 02, 2023 at 01:48:33PM +0100, Karel Balej wrote:
>> From: Markuss Broks <markuss.broks@gmail.com>
>>
>> Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
>> add the compatible for it to the IST3038C bindings.
> This one is better, but would be well served by mentioning what
> specifically is different (register addresses or firmware commands?)

I don't think anyone knows this other than Imagis itself. I would guess 
it's different hardware, since register addresses are indeed different, 
but on the other hand, there is a possibility that firmware on the MCU 
could be responding to those commands. I suppose "... IST3038B is a 
hardware variant of ... IST3038" would be more correct.

The reason why I think it could be firmware-defined is because we have a 
lot of variants (30xxA, 30xxB, 30xxC, plain 30xx), and the numbers 
usually mean feature level/completeness, e.g. some don't support the 
touch pressure or touchkeys, and we don't know what A/B/C/none means.

>
> Cheers,
> Conor.
>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
>> ---
>>   .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
>> index 0d6b033fd5fb..b5372c4eae56 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
>> @@ -18,6 +18,7 @@ properties:
>>   
>>     compatible:
>>       enum:
>> +      - imagis,ist3038b
>>         - imagis,ist3038c
>>   
>>     reg:
>> -- 
>> 2.43.0
>>
- Markuss
