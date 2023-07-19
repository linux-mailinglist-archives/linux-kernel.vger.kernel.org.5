Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8667599B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGSP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjGSP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:27:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00333132;
        Wed, 19 Jul 2023 08:27:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55ae51a45deso4374886a12.3;
        Wed, 19 Jul 2023 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689780443; x=1692372443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V0Lkx5Mu5pvkEv29AIHqZ8L4QB5hfUluGqCIAyC8ZJk=;
        b=HEAevr00LmMycArFzDSeYVZmLznbz5oEpFZxynb5wxEGGgUx5DJJmWJH6iWfzuKQ82
         j/q+V2GcYQdpuMBXbMONEd8GpEbKSfDPLqRmg25F/KkMg5eVxI2QOI8fQwIrDHopvaYa
         RFFOC3WSgYIEEEhEtjGRD3oloSPeIggnizN8qbo9JMtRoHmTIG9sXqPoerng0IgakYa8
         Qnwrqga1eh3CAoxK1uv8I2D8CXaBlmmWVOOLsi2ylOFH24sZRGbxmJF/JxVPuBjtCe+X
         V90YgF9sr/JH/b+mEkjIbeD1ndU79utRZ1u9+zT8aVpHfdbEN4vQTVf+z7cD3xPouQju
         lQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780443; x=1692372443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Lkx5Mu5pvkEv29AIHqZ8L4QB5hfUluGqCIAyC8ZJk=;
        b=hTU4fMAi2uHIYlzUO9RNa5gY5oyLx4kdRhHjge2vJKmSFpsIOd0suvcS3lgXqFU3zG
         MpqgMMT1T+CXELm5fE7Yb5MirTf8DbOWoYJ1XGSGXiDopoFC9as4WucEcaMFGRKH8eUD
         gaQhp8PTSEW2rkzyTP8tRUXJtSKYGUtPacF7QATK9nIT6MwxmpwVoG7fckI9QAOiHJGn
         N+IOQ4PR/X7SOgnH6f6aoWyTdPI7Ig7aaNy/g+eqg8p9D9Iaz0qJnnBMi7DDSdQjNg7r
         +oN3qiVJ4YNKVi3tM2/vVwUmWM+xrAX2Quf/rhZXBwmxtUM+cYZK2p+Kd65zSPaBm7cL
         q5vg==
X-Gm-Message-State: ABy/qLZt8bAkk5nxY8GuyaPrsKbe52sKM/kAwMxK5OsADOr4qS/AgleM
        Gt3BFrcTEnR2TxvN8OCNKNA=
X-Google-Smtp-Source: APBJJlG8RhFXCinyrxXOSUSkjZx9zIQBAyDQ7O8rOLEtG9KaFfrOU9qx2/9vGw940Tvo0EIke5wzEQ==
X-Received: by 2002:a17:90a:db03:b0:263:129e:80ac with SMTP id g3-20020a17090adb0300b00263129e80acmr2068279pjv.38.1689780443086;
        Wed, 19 Jul 2023 08:27:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id in23-20020a17090b439700b00262eccfa29fsm1303446pjb.33.2023.07.19.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 08:27:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b3e1208e-4b45-ad0a-25cf-941518357ebe@roeck-us.net>
Date:   Wed, 19 Jul 2023 08:27:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] dt-bindings: hwmon: add sht3x devicetree binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        JuenKit Yip <JuenKit_Yip@hotmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB6261295D96DCE88F712910B99229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <948211aa-2315-5ed6-4c04-f1a795045997@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <948211aa-2315-5ed6-4c04-f1a795045997@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 07:39, Krzysztof Kozlowski wrote:
> On 03/07/2023 16:08, JuenKit Yip wrote:
>> add sht3x devicetree binding files
>>
>> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
>> ---
>> v3:
>>    - fix wildcards problem
>>    - add vdd-supply property
> 
> No improvements in subject.
>>
>>   .../bindings/hwmon/sensirion,sht3x.yaml       | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
>> new file mode 100644
>> index 000000000000..bef2eb492a47
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,sht3x.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/sensirion,sht3x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sensirion SHT3x-DIS humidity and temperature sensor
>> +
>> +maintainers:
>> +  - JuenKit Yip <JuenKit_Yip@hotmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sensirion,sht30
>> +      - sensirion,sht31
>> +      - sensirion,sht35
>> +      - sensirion,sts30
>> +      - sensirion,sts31
>> +      - sensirion,sts35
> 
> Your driver change suggests these are compatible, so make them such with
> oneOf and a list.
> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: regulator that drives the VDD pin
> 
> Missing reset-gpios. It's the second ignored comment.
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 

To clarify from previous replies: the properties need to be described
(because the chip needs a supply voltage, and because it has a reset pin,
and bindings should be complete), but that doesn't mean that the driver
has to implement them.

Thanks,
Guenter

