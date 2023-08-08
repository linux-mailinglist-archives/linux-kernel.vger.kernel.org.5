Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C496477417B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjHHRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjHHRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:21:59 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395A1F425;
        Tue,  8 Aug 2023 09:08:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40fd2de0ddcso45218321cf.2;
        Tue, 08 Aug 2023 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510905; x=1692115705;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48Zr0S4HamHQ25B/ZcGiUlOHiVUQn60xnNnJqEoGB1g=;
        b=JvkLENHhdLHitguTVndQo+Wr6y6smRZatMAMwb6JxbSV7NhD0CVj7kKkWmkzKyzgNa
         2PGV+DuFYf0sB0LR0/6M0iXTCJO5mhPDTfzuVQSrfH2k+JmZjh4w2mz6MZ9AV2YWtQUS
         i8jtN99Yliqz73z8K+g6cibuHQ7yQ/G10eLdBvoDbT2YzdgIkq2FWa9eQzIEIuAz+OYH
         sk7/q+MrZNNETDrlUVorLTbXBYM8XQ3xMBdtrOJN0AnFk3KtLZsC5dz6yQ/lL8vz+7Ak
         z6qp+FBNqiW7K046JYgY8orcbx1moP6ZnwdgY5dAEDWvCRnhR7X09OpuPbaLkrabRKwM
         zUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510905; x=1692115705;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48Zr0S4HamHQ25B/ZcGiUlOHiVUQn60xnNnJqEoGB1g=;
        b=iMja/yMh/xJHfH5Ixzd7sT4T2VH0bKQgaPWWTCLyzBSHMTOUXDLBdoYOxl6zegAaTl
         iUcO+Qm9eW7aX/rGheF0Zl5dFDLpN8veU5cQd7zh15zrBt7ntXA83EN/DqRPXVLZOmyB
         5cj38DdeVaV2JFYWPegvZPmJfolT256IgUyQbrPAIDRilqTaEpF1cgFRPUTRufBJghrO
         ULARfEezyXMx8xaPBH1htwMsBk4un01TIN5uKGteDQOEl8Lg9eZ1grItC4Dm1bqr9nbB
         ZAY9FEhSLJusOWyS6kI558xroJEYZtHuKJe2eOV3/nvBuszC+zCWtu6hBHPhvSTtzaOJ
         yg7w==
X-Gm-Message-State: AOJu0YyaK8aC3kFCG+9v0EZdLsErndg1If7n9TOW0vLH7qzWo+zv2SnB
        Fz0cFpp93stVclGoiKJk3LhZ9gAUMoU=
X-Google-Smtp-Source: AGHT+IESQe9cH3KsW8id9Jt2E6ZI5IOmRvTdvT6o7AOiAAijF/LX8I1T0u+zM/+wGnc7xY7smSLJ0g==
X-Received: by 2002:a05:6e02:156c:b0:345:8373:bf68 with SMTP id k12-20020a056e02156c00b003458373bf68mr16083383ilu.25.1691503810854;
        Tue, 08 Aug 2023 07:10:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gt23-20020a0566382dd700b0042b37dda71asm3097171jab.136.2023.08.08.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 07:10:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
Date:   Tue, 8 Aug 2023 07:10:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230808-stand-cheddar-b76b0b7509a0@spud>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
In-Reply-To: <20230808-stand-cheddar-b76b0b7509a0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 04:46, Conor Dooley wrote:
> On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> The TDA38640 chip has different output control mechanisms depending on
>> its mode of operation. When the chip is in SVID mode, only
>> hardware-based output control is supported via ENABLE pin. However, when
>> it operates in PMBus mode, software control works perfectly.
>>
>> To enable software control as a workaround in SVID mode, add the DT
>> property 'infineon,en-svid-control'. This property will enable the
>> workaround, which utilizes ENABLE pin polarity flipping for output when
>> the chip is in SVID mode.
> 
> Why do you need a custom property for this? How come it is not possible
> to determine what bus you are on?
> 

That is not the point. Yes, it can be detected if the control method is
PMBus or SVID. However, in SVID mode, SVID is supposed to control the
output, not PMBUs. This is bypassed by controlling the polarity of the
(physical) output enable signal. We do _not_ want this enabled automatically
in SVID mode. Its side effects on random boards using this chip are unknown.
Thus, this needs a property which specifically enables this functionality
for users who _really_ need to use it and (hopefully) know what they are
doing.

Guenter


> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../hwmon/pmbus/infineon,tda38640.yaml        | 51 +++++++++++++++++++
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
>>   2 files changed, 51 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>> new file mode 100644
>> index 000000000000..c5924ddf1b47
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
>> +
>> +maintainers:
>> +  - Naresh Solanki <naresh.solanki@9elements.com>
>> +
>> +description: |
>> +  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
>> +  Regulator with SVID and I2C designed for Industrial use.
>> +
>> +  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - infineon,tda38640
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  infineon,en-svid-control:
>> +    description: |
>> +      When enabled, it allows the chip to utilize workaround for
>> +      software control of output when operating in SVID mode where
>> +      hardware-based output control is the default behavior.
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        tda38640@40 {
>> +            compatible = "infineon,tda38640";
>> +            reg = <0x40>;
>> +        };
>> +    };
>> +
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 40bc475ee7e1..86c7d34f63bf 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -151,8 +151,6 @@ properties:
>>             - infineon,slb9645tt
>>               # Infineon SLB9673 I2C TPM 2.0
>>             - infineon,slb9673
>> -            # Infineon TDA38640 Voltage Regulator
>> -          - infineon,tda38640
>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>             - infineon,tlv493d-a1b6
>>               # Infineon Multi-phase Digital VR Controller xdpe11280
>>
>> base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
>> -- 
>> 2.41.0
>>

