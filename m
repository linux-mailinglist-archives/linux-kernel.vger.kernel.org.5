Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF0C7E55D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjKHL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:56:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B01BD7;
        Wed,  8 Nov 2023 03:56:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc5916d578so61308295ad.2;
        Wed, 08 Nov 2023 03:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699444585; x=1700049385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYbvOLurRN2/BOw0AFji1VhZFNjdDiIJj9UJ87sPrXY=;
        b=bflg9W72WMfD25UhftPsnTDuDFOhi9roAAkl3JoX2S5FzWtXTev4SqzocSE/5JQSOe
         Z6LTi7c6kpzg4NImBjdhrvlfumlf/aiytJob1GPZIN/4gF50QQcO4xXEw1e5Tg70hQ4U
         XUYOF0IQLh4PWcwLBeDq8CQksdw+x/o/R4TQ5Xp+JIuV9KzBvNTQdRrVupHWVVp6RIXE
         Mtnd0Zn5BshlCXb769Hrph3lCBW26wTF0fO5P/vNMryqurG+lTvK9MOqEyc3EY7erOpg
         1ytZUj9p3OoVBy3lQwORPLjQlzAdlFiwjZRKjSypRi8WtL4qLNfKefBp7Y6D+l1QVfyZ
         DH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699444585; x=1700049385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYbvOLurRN2/BOw0AFji1VhZFNjdDiIJj9UJ87sPrXY=;
        b=RCE2M8iCYuDDrrUYcHJlTN0gbsSxX5jMsVlN/80mX2BrwCaLQZw9skN2/SXTOVSNmj
         /x2MQa0ch9D/gQ3nTqdp78sKyq1yuFroWtgpoOg4+UPDUaVUPbaK5FxFyGdVrrxrpjLv
         rBYRSPytUSFUO+eDtRkEi+KVpOf0t+eyJRqr59qEPLpIA+5vItByf45DRYffUntZnHFz
         ravBppPXb4ZN05XoIDcBIYFv+FdnwPnVqPm9gHXI/uWfDh7WJiyI56yESn4tgDAxtLQ8
         JiAKF5hLqj9+PYOotBkwRLlEI56Bs+T7n+zgcYgey7QYG5FIp/9Vk4fkfY7qrkkpFcwY
         /1/Q==
X-Gm-Message-State: AOJu0YzLsvDqyl/MNaNeHBWY7H0H3eSIWmyNDmz6LLv1t9PGDdKYThw/
        JDSzqoP8/kZJlacQndPng9O2CJ3m4bKYstrUgLI=
X-Google-Smtp-Source: AGHT+IHOd6LPtQEWQHjx/4sw4zdHg3cUPlqo8agp+i1omFqB+neRAFxtaqz37Fedc2P08oT3QqZs1g==
X-Received: by 2002:a17:902:f688:b0:1cc:5c8f:4056 with SMTP id l8-20020a170902f68800b001cc5c8f4056mr1759221plg.42.1699444585194;
        Wed, 08 Nov 2023 03:56:25 -0800 (PST)
Received: from ?IPV6:2401:4900:2353:8963:b940:1ac0:2fbc:6b6? ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001cc307bcdbdsm1583627plg.211.2023.11.08.03.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 03:56:24 -0800 (PST)
Message-ID: <90cacd34-4812-4792-9bf0-362200431452@gmail.com>
Date:   Wed, 8 Nov 2023 17:24:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: add asair,ags02ma
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231107173100.62715-1-anshulusr@gmail.com>
 <20231107173100.62715-2-anshulusr@gmail.com>
 <1d5d1357-0b53-4639-add9-2b3f38aae744@linaro.org>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <1d5d1357-0b53-4639-add9-2b3f38aae744@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Krzysztof,

On 11/7/23 23:17, Krzysztof Kozlowski wrote:
> On 07/11/2023 18:30, Anshul Dalal wrote:
>> Add bindings for Asair AGS02MA TVOC sensor to trivial devices.
>>
>> The sensor communicates over i2c with the default address 0x1a.
>> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>>
>> Datasheet:
>>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
>> Product-Page:
>>   http://www.aosong.com/m/en/products-33.html
>>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index cd58179ae337..9cd67b758a88 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -47,6 +47,8 @@ properties:
>>            - adi,lt7182s
>>              # AMS iAQ-Core VOC Sensor
>>            - ams,iaq-core
>> +            # TVOC (Total Volatile Organic Compounds) i2c sensor
>> +          - asair,ags02ma
> 
> I think you miss VDD supply.

I am sorry but I'm not sure what you meant. Are you referring to the
addition of some information in the commit description?

Best regards,
Anshul
