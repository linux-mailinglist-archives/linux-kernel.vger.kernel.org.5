Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0580765562
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjG0NzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjG0NzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:55:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083230C5;
        Thu, 27 Jul 2023 06:55:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686bc261111so765489b3a.3;
        Thu, 27 Jul 2023 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690466112; x=1691070912;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3Po0omvXK6YUJhElyFcLqAqJdtl37m3A372EgjTzHo=;
        b=PfWoD63sdJYaSA2nS3oIjD7Xat16Vix77rVFQC+OJ+HaJIV6DPLOHYVrjdftiTybPd
         l0QqEKPjVfNsLBMGJbhGmouD/go48MO9puJC1kb98g6xYt9M5ulAZK6JDHYwuoFOvy1j
         e4QI3qp9VAOt9zW8TGqpHS4pSMUdsPWlnfWUILit+7qbCS0kLGpT3R4CioRN2rnyTXb+
         q3T9X939C7LmflraLbIAW/VOwGp6Zj91Mu517Q+/CnlBZf2IKhS9qtXTYyuny1P6cziG
         MK9SfDQaMmZDa830VJTqEP/q6B3LSzaNlZZcoRBYH/fGi0s3UuESTOTQqGHyLg7Uvf1W
         WZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466112; x=1691070912;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3Po0omvXK6YUJhElyFcLqAqJdtl37m3A372EgjTzHo=;
        b=IKWjRCcqwPt/Gzoj4jPtX//5hQ0DT4RMkH0FJ+FOCOodHC7iEn1xGHEfJxyF67ROta
         SoTqaOO2jnlqzfPOFW6x3pSjA3KOikWekPj0mrsYaYIgs1GHwYIRZKWjH0Y6CHkr3JAu
         3KqHm0Kwz/pbL7MSfvS6H3V2niIPwd2pqX3xLoI1zNvvonXNP2yfYoSvIHXMMvYjqLq8
         JDSdTeAC9KzUOjM8XQDYrkrhy5t8W9KYPTHyzsElQsfXJy//aDxCUoMjMi3UKsWc3adV
         fOLegG60Ww6zUi8alm2S0B2uuxtkFKobDMGjuEpPWRKHQ2q3ym1cneSQppJdLHESUyRQ
         DrSg==
X-Gm-Message-State: ABy/qLbp5CvHqWBKIuFPgZM6dJjSrq1wdz0Z+iKmlLTUNpU6SO4v4mZ2
        527p0GGc0qgLkslqHQwTaGw=
X-Google-Smtp-Source: APBJJlEIvEEPPjEafY3G0R4AT/HQzp4He1laUOk9HRa04VW2KCFQtJtIsC/KHnaHfOP+9ntBeW48ow==
X-Received: by 2002:a05:6a00:10c5:b0:677:bdc:cd6b with SMTP id d5-20020a056a0010c500b006770bdccd6bmr5701689pfu.19.1690466112318;
        Thu, 27 Jul 2023 06:55:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1-20020aa79001000000b00686940bfb77sm1515249pfo.71.2023.07.27.06.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 06:55:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5e78deea-b46b-0ecd-6bd6-6f10058e03b7@roeck-us.net>
Date:   Thu, 27 Jul 2023 06:55:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
 <20230727093528.594ce3a7.mail@carsten-spiess.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
In-Reply-To: <20230727093528.594ce3a7.mail@carsten-spiess.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 00:35, Carsten Spieß wrote:
> thanks all for your input.
> I conclude here in one answer:
> 
> On 7/26/23 18:14, Krzysztof Kozlowski wrote:
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
> sorry i missed that, fixed for [Patch v2].
> 
> 
> On 7/26/23 18:14, Krzysztof Kozlowski wrote:
>>> +  shunt-gain:
>> 1. Missing vendor prefix (does not look like generic property)
>> 2. -microvolt
>> And then enum is for 40, 80, 160 and 320.
> replaced with
>    renesas,shunt-range-milli-volts:
>      description: |
>        maximal shunt voltage range of 40mV, 80mV, 160mV or 320mV
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      default: 320
>      enum: [40, 80, 160, 320]
> 
> On 26/07/2023 18:16, Guenter Roeck wrote:
>>> +  shunt-resistor-micro-ohms:
>>> +    description:
>>> +      Shunt resistor value in micro-Ohm
>>> +      defaults to <0> when not set
>>> +      monitoring of current and power not supported when <0>
>> +
>> Should not default to 0 (disabled).
> When shunt resistor value is not known, current and power calculation can not be done,
> but the shunt voltage still can be measured.
> As the resistor is externaly connected to the ISL28022 chip there is no default.
> When i set default to any value (e.g 1000 micro Ohm), current and power calculation
> will give wrong results (except when the shunt _is_ 1000 micro Ohm)
> 

Just like many other hardware monitoring drivers do. That is why /etc/sensors3.conf
exists. That is not a valid argument and not a reason to effectively make the driver
useless on systems where devicetree or the matching ACPI data is not provided.

> On 26/07/2023 18:16, Guenter Roeck wrote:
>>> +  average:
>>> +    description: |
>>> +      Number of samples to be used to report voltage, current and power values.
>>> +      defaults to <0> when not set
>>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]
>> Should not default to 0 (disabled).
>  From datasheet table 6 on page 15 there are two similar ADC modes:
>    3 - without samples
>    8 - with one? sample
> I intended enum 0 to ADC mode 3, 1 to ADC mode 8,
> but i can live without ADC mode 3.
> 

Looking at the datasheet, 3 and 8 seem to be identical. There is actually no
"0 samples", which is why I assumed you wanted to use that to disable the sensor
(though, thinking about it, that doesn't really make sense). What is missing
is that 0..3 actually control the sensor accuracy (12..15 bit).

Guenter

