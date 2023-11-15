Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507857EC80D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjKOQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjKOQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:01:01 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A7519B;
        Wed, 15 Nov 2023 08:00:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso751808b3a.1;
        Wed, 15 Nov 2023 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700064056; x=1700668856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsQDT2w0FjShhzuIz0BGJBYesGwhop9/GhNrCvVLr2Q=;
        b=PniLYnzsOhDEQktpGugQb1CkHpwKBZcTsEBtusrxQkUruzwczUbESnSkm3siquj9T9
         2qxBhLYnLdcDvKlD5pRI7AGjxdsxMA8cr8Wop6ri4qEj10eKKg/D9ONBpCUIwaHwj7pz
         1/RGxEVcADZde9lyWIy2gDcD3DcmQfPnKYKEZyLnXgE79VPFPGZbZYk2eT7I9EORkuhh
         Di34LB6loGdDk+Rqw2BfAxrlNbRXi329/AqVlFH6vQQZrgPH/jU3q+p7kjTRf4B0gYpO
         bpPGQ1T2sKjP17qHyhzWSRpkpHi7ys6UhpxgQ+b5IVWAetJDMUHRkNa70K7Wn7m+jZl0
         +sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064056; x=1700668856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsQDT2w0FjShhzuIz0BGJBYesGwhop9/GhNrCvVLr2Q=;
        b=PeIEcNp8QvpB3HyC8roWhBvX3STXiWFUcmOyQFfU3AKrKN5U/FVK8fMRph9puhhORr
         DI0AO7vo2vM03+WjiK/8sWyr8GrqONZBV4J01ZxCnB2ylFiPY7+MT5pjJxELLfFaq45/
         nt4snT9N8iKgiHZDWuqDJveYVtqR9j4QUBWfFIE+WtRYyjkAOPAKX+MlKP1qY/O5rd2U
         5s9URs5K6zhc0gLL6umLyILfzrtm5khyw64KKkJWR1QKJVGP6c19WxlQBSWvhUIaOyeC
         soioWr7G0A8Ql4xguAYVpk1JlzyU1g+DtIWE3rj8iXc7XSPUJK59tbS84LGFoA9Oj0qP
         eZww==
X-Gm-Message-State: AOJu0YyeQ1BYHL4BKppmJ2kH6DAI+yklITTYu4tr1zTQFWRuxAvgC019
        BuH6dJuXK3y8DaegZpXieE8=
X-Google-Smtp-Source: AGHT+IErQoAlZrZcHWhp4ZkLm0PXKuCT9RSh1Z01Cc4NXpJxtkY2vJXfxyBL4/jbcb3YpioGTdSvwQ==
X-Received: by 2002:a05:6a20:e108:b0:187:962d:746b with SMTP id kr8-20020a056a20e10800b00187962d746bmr669389pzb.9.1700064055825;
        Wed, 15 Nov 2023 08:00:55 -0800 (PST)
Received: from [10.5.169.250] ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id h21-20020a056a00219500b006c046a60580sm2943372pfi.21.2023.11.15.08.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:00:55 -0800 (PST)
Message-ID: <9b1674d7-c41d-4d8b-bb28-09ed201c72cd@gmail.com>
Date:   Wed, 15 Nov 2023 21:29:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: add aosong,ags02ma
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20231115125810.1394854-1-anshulusr@gmail.com>
 <20231115125810.1394854-2-anshulusr@gmail.com>
 <20231115-stability-arrive-e0458f6f7b0f@squawk>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <20231115-stability-arrive-e0458f6f7b0f@squawk>
Content-Type: text/plain; charset=UTF-8
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

On 11/15/23 20:08, Conor Dooley wrote:
> On Wed, Nov 15, 2023 at 06:28:07PM +0530, Anshul Dalal wrote:
>> Add bindings for Aosong AGS02MA TVOC sensor.
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
>>
>> Changes for v2:
>> - Removed device from trivial-devices
> 
> Your $subject still says "trivial-devices" though, so please fix that in
> your next submission.
> 
>> - Added standalone binding with vdd-supply property
>> ---
>>  .../bindings/iio/chemical/aosong,ags02ma.yaml | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
>> new file mode 100644
>> index 000000000000..4a0278c6318c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Aosong AGS02MA VOC Sensor
>> +
>> +description: |
>> +  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with default
>> +  address of 0x1a.
>> +
>> +  Datasheet:
>> +    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
>> +
>> +maintainers:
>> +  - Anshul Dalal <anshulusr@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - aosong,ags02ma
>> +      - asair,ags02ma
> 
> Why do you have two compatibles for the same device? Please document and
> use only one of these. The aoson website says:
> "Guangzhou ASAIR Electronic Co., Ltd"

I'm sorry but I couldn't find any reference to such name on
http://www.aosong.com/en/
In the contact page (http://www.aosong.com/en/article-34.html),
I could only find references to "Guangzhou Aosong Electronic Co., Ltd."

> so I suspect "asair" is a more apt vendor prefix.
> 

Asair is the brand name under which Guangzhou Aosong Electronics sells
their products [0]. After a prior discussion with Krzysztof [1], I
thought it would be the best to go with Aosong instead.

The rationale being since a vendor can only have a single prefix, if
Aosong were to sell some new product under the name Aosong, it would
then have to have the same vendor-prefix as other products under the
Asair brand.

[0]: https://www.linkedin.com/company/asairsensor/
[1]:
https://lore.kernel.org/lkml/1f62ab04-1679-44b1-b95e-e3954afbfa88@linaro.org/
Best regards,
Anshul
