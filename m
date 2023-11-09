Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17B7E684E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjKIKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:37:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79F1FEA;
        Thu,  9 Nov 2023 02:37:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc131e52f1so14697965ad.0;
        Thu, 09 Nov 2023 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699526223; x=1700131023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4upJP2Fg5H/4Bb05iQ23yejvTGPnKm3BWZ8iv5K1f0=;
        b=M7JFx3736V4HxdvN4TkOORkzQ6fDLYCVClWwkYXS+xpKYxNVuK3r7WrV7TZzeYNZhY
         aRT0az6MiiC94pOVjeyHc+L1OhY4ySt+sXauH7+cOkGKYXyeNnQjHhp48imrrMRpVe2T
         xXIqtqXqSaVrapfozJMZ2m564qVFQ3E7wnPzZVFCjZMcidIG7XttXUPoEiJytLAdbZ4g
         aqMw+YJHWarjAWze1uryPiVki3KadP8+HcFQtUa1Cynl+Kq49ajnAewNk+byOIwcOkej
         tbrfsUkCwiCk8xthNXdbYeFvsYYLzIlvhmJgWO/QIL5OOHaf/8HTFrVN6kd8yoqGh+MR
         UcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526223; x=1700131023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4upJP2Fg5H/4Bb05iQ23yejvTGPnKm3BWZ8iv5K1f0=;
        b=F2D7a296ipVIyRWRWx/dXS3Y+JSaOMx67c0d7sa2XncqZANlPpHKB/RYTBLCNobPEF
         e3iVv7HyL+qRElKQP3T9VvCdpRMyBr3wi/p0cBK/lgC590mi7A7x2D+L6ruI6EmeZJc6
         8fTPt0ey782e26MiSP39JzsK0/ozEW9UOkobI6nWK90q4LFNOT5rirI/IIUfxaAU8H4y
         V8kKvs0uX85f74aINMJgyc1G1/uPMxIJqQORxSii714PgX5tLPqkX1cyfDT8E3/Q1etc
         7CI1/NVrr/MDTmL3MgpMTFeQXo52m5pYtAZRKbQmoLN0I/mKuzpOgFfY1qNUTrWTJuAt
         04pA==
X-Gm-Message-State: AOJu0YzSZw50Fr7OB5yFy+6HjSOIVy2zksa5MLRg+Mc4KMh4v6C+CIJk
        T4yt/XZ0D6po5dn6I7pT5YYx+pBk5jkTm/3Z
X-Google-Smtp-Source: AGHT+IEhHqHsa1Dl5340outMycvmGWx1r/7lCTKlGNoYQzJLvjRGNpI9+HJVQ4a2LrhxC0BzPLclFw==
X-Received: by 2002:a17:90a:7346:b0:280:735:bece with SMTP id j6-20020a17090a734600b002800735becemr1826896pjs.16.1699526222670;
        Thu, 09 Nov 2023 02:37:02 -0800 (PST)
Received: from [100.127.18.209] ([49.37.136.118])
        by smtp.gmail.com with ESMTPSA id w16-20020a17090a15d000b00280202c092fsm1079008pjd.33.2023.11.09.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:37:02 -0800 (PST)
Message-ID: <844937f1-b3f7-4156-b60a-e9e17d8aed6e@gmail.com>
Date:   Thu, 9 Nov 2023 16:05:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: add ltr390
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231109090456.814230-1-anshulusr@gmail.com>
 <f7fea4d1-c1ae-4ab5-bcbd-30683ad7a349@linaro.org>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <f7fea4d1-c1ae-4ab5-bcbd-30683ad7a349@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 11/9/23 15:57, Krzysztof Kozlowski wrote:
> On 09/11/2023 10:04, Anshul Dalal wrote:
>> Add binding for Lite-On LTR390 which is an Ambient/UV light sensor that
>> communicates over i2c with an address of 0x53.
>>
>> Datasheet:
>>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
>>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> 
>> +  interrupts:
>> +    maxItems: 1
>> +    description: |
>> +      Level interrupt pin with open drain output.
>> +      The sensor pulls this pin low when the measured reading is greater than
>> +      some configured threshold.
>> +
>> +  vdd-supply: true
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
>> +        light-sensor@53 {
>> +            compatible = "liteon,ltr390";
>> +            reg = <0x53>;
> 
> Please extend the example to be complete - interrupts and vdd-supply.

Could the following be used as a suitable example.

#include <dt-bindings/interrupt-controller/irq.h>

i2c {
    #address-cells = <1>;
    #size-cells = <0>;

    light-sensor@53 {
        compatible = "liteon,ltr390";
        reg = <0x53>;
        interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
        vdd-supply = <&vdd_regulator>;
    };
};

Thanks for the review.

Best regards,
Anshul
