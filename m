Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F37E661B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjKIJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjKIJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:02:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958730EB;
        Thu,  9 Nov 2023 01:02:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so898979a12.3;
        Thu, 09 Nov 2023 01:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699520526; x=1700125326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFgzL/6sj6J/PSXQXd7ZWOkRRMT4sjr7uqHixOgCTSY=;
        b=dduy8Bq/Cld48JBKp2rXnceHSlCd0h570VQNkyo4NWapvyeVkH0RfhMZGd3kMWlKtm
         qf0f8gfigTdLHkX2wVS7KrKFwV1hej/Xg4BXxavUhZmuPA2TW8eRKr7UZfBVz7gCvFp2
         V6AKESd6c06Bkh45xUfwykxbcvXmorscZ42tdPNB7dozQ8pLEQolZ3qkTHK+sqyW5EMA
         runfOQbax4rFKgoH7pug9DApRdxRVRRBvqHzKhwxSkaHbf95GCqZeYdg+ebCfppjjP3U
         eVSPRnsfCkVhMt00vS94E/RKJ7OAQBmTKvOHu1PtE4y6WnATS4x5BZOfbu6zTwsL+Olz
         R8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520526; x=1700125326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFgzL/6sj6J/PSXQXd7ZWOkRRMT4sjr7uqHixOgCTSY=;
        b=DlLiadLgpjzgz+ZqNoQ77UjyStkqVPZY29hlt+Cqe+fnLuh05lqRR3brbWzpCXbRXn
         pyQP5GWPEolHae1reYBgDX85SE8OMq1Wx4e0EWcByPyyH53RaKmTxD1prx0Mx+SrVJZA
         2QDmD9V6D8YBhdQ87uJRFN/uVKs16DYkNQXpohO0L1UBXahksUur6xJx/SLMx6Seqfev
         GGe1e01/8oghCvOmHr+ht49ZXGwXI+IKJCxIlF9L6lw+T2gXPcboDbVoaf5Ba++au0/c
         Cn07RyWDaa8BUXAzi+ADNJUgUNI4ThRJJ3qJgUHjO/Emhb3A/UyV8I0vLErS7VN5Tols
         YILQ==
X-Gm-Message-State: AOJu0YxBZAkHMLu5mSk54xb1vcLidm2ioGqaJN8IukajuW5H5KfTPOwn
        wQJLkguYzDf35hp29OYLqAo=
X-Google-Smtp-Source: AGHT+IGa1eJ55CvasVuWkVQ7UkHHP4de/wugisUnC2HF4D51CB6MlDYBN605hAjPaGsKX0KFqZP2Lw==
X-Received: by 2002:a17:907:98e:b0:9be:bf31:335f with SMTP id bf14-20020a170907098e00b009bebf31335fmr3653572ejc.46.1699520526182;
        Thu, 09 Nov 2023 01:02:06 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id gf23-20020a170906e21700b009920a690cd9sm2252892ejb.59.2023.11.09.01.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 01:02:05 -0800 (PST)
Message-ID: <0b103837-54e7-430f-8a01-94b620b84f89@gmail.com>
Date:   Thu, 9 Nov 2023 10:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dt-bindings: hwmon: Add Amphenol ChipCap 2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-4-f5c325966fdb@gmail.com>
 <008715d1-de4a-47dd-955c-e2fb7af36a25@linaro.org>
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <008715d1-de4a-47dd-955c-e2fb7af36a25@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.11.23 09:53, Krzysztof Kozlowski wrote:
> On 08/11/2023 16:37, Javier Carrasco wrote:
>> Add device tree bindings and an example for the ChipCap 2 humidity
>> and temperature sensor.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../bindings/hwmon/amphenol,chipcap2.yaml          | 68 ++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
>> new file mode 100644
>> index 000000000000..8bb6daa293d3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/amphenol,chipcap2.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/amphenol,chipcap2.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ChipCap 2 humidity and temperature iio sensor
>> +
>> +maintainers:
>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> +
>> +description: |
>> +  Relative humidity and temperature sensor on I2C bus.
>> +
>> +  Datasheets:
>> +    https://www.amphenol-sensors.com/en/telaire/humidity/527-humidity-sensors/3095-chipcap-2
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - amphenol,cc2dxx
>> +      - amphenol,cc2dxxs
>> +
> 
> Nothing improved.
> 
> Really, you just ignored the review.
> 
> Best regards,
> Krzysztof
> 
I am sorry if I missed something from your first review. I changed the
interrupt description to have one per item as you suggested and removed
the empty line. I did not change the compatible enum to add all part
numbers because it was still under discussion, but now that I know that
I have to add all of them, I will change for the next version.

Best regards,
Javier Carrasco
