Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE097DB496
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjJ3HsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjJ3HsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:48:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E7B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:48:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso6913259a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698652095; x=1699256895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NC9LdB6rOaJ1FTuQeMV3euxRWDgGo8XewT7yIfD9Ex4=;
        b=fgEh86kXdyp5z6OLmgY0Zzs8L9NyVq/UKvXiHBlMiPhgJaIspPCEml/ziX1kz0xoDt
         CsX1w0zheM7xvodvLFzDeVr1UVXN2hqDLu8DdavxDEPy5asUxysHrTqhUajkXtX7MCJ2
         mz0TlPLih74sgcixGX7HgDU0PS2coIraiG/0Xb2dEqyr4ZRldmrypWKonjLfphMutnXH
         XYcqMJpHqYV7j+NRYqPqDLRjaHGLj5w6BfprWeavLUtVmfL9fqoLKldf7sRr6t9liMVt
         M9g5twXPyljMTGo9H/dc+rzAZjcFvCgQcPA6lZ3uIDJTQHZzCsacPt4V0DAkbkwYcz1x
         O4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652095; x=1699256895;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NC9LdB6rOaJ1FTuQeMV3euxRWDgGo8XewT7yIfD9Ex4=;
        b=bXUbCH6sR28iIp5dnlRyUNZ28wNkr2iwDZh9pU0f88m1DIeTMrZ1VjxQTbQQQ03qR6
         wt3/OUDmfCujWts+4ln5djk0lOHQQuJ0eoXZum28n5dPKNdwDSkS9HlnMNRH+peOeWp/
         BNDUhmaWi4/TVVQsrISUjGHzUz+bia7Cig8wNadWNFkKofndYppSi0N24jjzzeY9txsN
         g12+YivFnTA01fMYJxIb1rr1zhZPHJx16TKg6BOQaq/shLDjC/B88ZPeaWONjXH2eXvI
         koohqoemBCzEbQ322pq1naxX584PwTzzqMnkO8IXG8M6QoH1Jjmp3LE9NnDe8D5qxCZU
         vwHQ==
X-Gm-Message-State: AOJu0YxBImH+9dmiAQt3U1oeld6vXYR2sgaE6NATfsjJu+e15q8dNzXt
        hC97WNFr5V+YPgG25Rey32CzBg==
X-Google-Smtp-Source: AGHT+IF1p3iuRLtvaydHkGC2t+41Fg73dm72nquHIT9LT1j8n7C6PgqClmc8pAje9B82b6aTErYBXQ==
X-Received: by 2002:aa7:cf1a:0:b0:53f:6ee5:2cea with SMTP id a26-20020aa7cf1a000000b0053f6ee52ceamr6838271edy.17.1698652095616;
        Mon, 30 Oct 2023 00:48:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id 16-20020a508750000000b00534e791296bsm5798173edv.37.2023.10.30.00.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 00:48:15 -0700 (PDT)
Message-ID: <0668589d-e986-4364-b27f-475013c961af@linaro.org>
Date:   Mon, 30 Oct 2023 08:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert
 txt to yaml
Content-Language: en-US
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh@kernel.org>
Cc:     Nik Bune <n2h9z4@gmail.com>, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, skhan@linuxfoundation.org,
        devicetree@vger.kernel.org, linux@roeck-us.net,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-watchdog@vger.kernel.org
References: <20230924181959.64264-1-n2h9z4@gmail.com>
 <169826359217.1053485.16654434281057363682.robh@kernel.org>
 <20231029162226.GC5887@www.linux-watchdog.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231029162226.GC5887@www.linux-watchdog.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2023 17:22, Wim Van Sebroeck wrote:
> Hi Rob,
> 
>>
>> On Sun, 24 Sep 2023 20:19:59 +0200, Nik Bune wrote:
>>> Convert txt file to yaml.
>>>
>>> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>
>>> Changes in v3:
>>> - Removed trailing whitespace in an element of the maintainers list.
>>>
>>> v2 patch: https://lore.kernel.org/linux-devicetree/20230924172004.59208-1-n2h9z4@gmail.com/
>>>
>>>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 33 +++++++++++++++++++
>>>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 -----
>>>  2 files changed, 33 insertions(+), 9 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
>>>
>>
>> It seems watchdog bindings aren't getting applied, so I've applied it. 
>> Wim, please take watchdog bindings in the future unless noted otherwise.
> 
> I was going to add them now, but since you allready applied them, I will leave them out this time.

Now is merge window and patches are supposed to be in next much before
the window (if possible).

Best regards,
Krzysztof

