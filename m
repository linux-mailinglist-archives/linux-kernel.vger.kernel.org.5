Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA787E4E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjKHAfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjKHAfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:35:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBD1BD6;
        Tue,  7 Nov 2023 16:34:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ccce410660so22260135ad.3;
        Tue, 07 Nov 2023 16:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699403659; x=1700008459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bo+wNYvdH42XBot0MOWGC8vCva7jElVxl1Yf8J6aNZU=;
        b=UNqvd+IFDSjtEVdd4F99EVHEK84W6x8mMLmJQq7Ljt+OeEA4PYqx9DziNvJI5R4Uu0
         Dx6G6lJun7F0V91m0ebnDEA/0a54U4EQNWXT4/cy27/0PAofSEdPHlA8411L/P8jh/8t
         G+h5lS4l47mu1yUU3mrH74ptf0qNssYSNiP2aTgvr1pLP1R5hAlDx9Bqh6U4k1IJZMB+
         re5rdveirWHdCaufeb41jcD/IUipH3jLZ911W3lyhUSrWwhedNkSW3dZVKLLwfvUlbtJ
         EGqFU4YK92aMQ7pZMJnBvBVHk5j2iMDUQI0+QfB7fjvX23Akg09YpnqjPkygf2TVnL3X
         4BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403659; x=1700008459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo+wNYvdH42XBot0MOWGC8vCva7jElVxl1Yf8J6aNZU=;
        b=bYFD95thV+6K0G/TmmXBWHznwta2JcmZLeWHoR7UK+nfJGy2CWEDCgDWCu8cqbilYP
         ETcAv33JkuYuxuVRXurRCG0CwAS7zaYdesa+bDomCcyit0u089outJRyvUjIi16lANUy
         1rayU94sPndqPmg+jAAHxvG0+Frg87DOsFWT//DEyM4lYr/O8PqH2HsIFFnlMxAi6Sm1
         pBd+pDRZAbO3oA3u9TYbqnp64MSf2Wx2hz3/a0MlJFGD4uc6rLOLhhXjqzHlBiivOE7A
         lh9PheNfXM1UnZHRrhLAhKMjpKajEFbn47+R6XZgzg9qFUK3MwpYPdEAIMPaIwZMC2/y
         dpnA==
X-Gm-Message-State: AOJu0YwQCpw6dptGJIGJEQ2+FYteiYo3Ztnv42mRXXDKnYmeii94bgTd
        DIaI9hP+BHKgQ+l9EhrNETJEujguY4rzbY04
X-Google-Smtp-Source: AGHT+IFDPzQtLh6+yY5GKCHMN9W6XwtxJ90L36jbtGh9dSGXzUV4r7YpeRT7sM7ArPOdn2NSQT8ExQ==
X-Received: by 2002:a17:902:e9c5:b0:1cc:4ff3:c837 with SMTP id 5-20020a170902e9c500b001cc4ff3c837mr517996plk.68.1699403659132;
        Tue, 07 Nov 2023 16:34:19 -0800 (PST)
Received: from [10.3.171.174] ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id j24-20020a170902759800b001c47541ecd7sm396385pll.250.2023.11.07.16.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 16:34:18 -0800 (PST)
Message-ID: <f66cab34-266d-4e9f-b53f-26a2948f863f@gmail.com>
Date:   Wed, 8 Nov 2023 06:02:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add asair
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
 <87762a47-9caf-435a-9b73-397384660b11@linaro.org>
Content-Language: en-US
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <87762a47-9caf-435a-9b73-397384660b11@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 23:16, Krzysztof Kozlowski wrote:
> On 07/11/2023 18:30, Anshul Dalal wrote:
>> Aosong Electronic Co., LTD. is a supplier for MEMS sensors such as AHT20
>> temperature and humidity sensor under the name Asair
> 
> The name of the company is Aosong Electronic or Asair? What does Asair
> stands for? Sensors name? Then it is not a vendor prefix.
> 

Asair is the brand name under which Aosong Electronics sells their
products. I thought Asair would be the better choice since
all their products use that as the manufacturer name instead of Aosong
as well as all the retail suppliers of their sensors.

>>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 573578db9509..df3204f9dda6 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -143,6 +143,8 @@ patternProperties:
>>      description: Artesyn Embedded Technologies Inc.
>>    "^asahi-kasei,.*":
>>      description: Asahi Kasei Corp.
>> +  "^asair,.*":
>> +    description: Aosong Electronic Co., Ltd.
>>    "^asc,.*":
>>      description: All Sensors Corporation
>>    "^asix,.*":
> 
> Best regards,
> Krzysztof
> 
