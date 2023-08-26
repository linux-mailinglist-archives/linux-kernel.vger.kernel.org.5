Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A24789887
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHZR7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHZR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:59:39 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9BCF1;
        Sat, 26 Aug 2023 10:59:36 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99df431d4bfso248122066b.1;
        Sat, 26 Aug 2023 10:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693072775; x=1693677575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hg3oMggEQHd+gc6q9L9POT/lEfSR5eoXULrpzdbLklk=;
        b=C5I/rbP/qFjXL69nJBxyh7k4rhibPBW4Jai10JwwoxhdYXo9WU/pHfC6Qmv9hUUfi8
         l5PpsGvOZ3gFDCHnFWJtmJBGV5s55cG4ZcKCOABHtr6rhtaSqIKdO9hQ7vTgTAFCyVqT
         bJcEQXLRz1QF9+qk9E43hX6jye18TuzCumK0s/UXvi3Q4PsR98FBcaSl/bqqg3bBrEno
         HEjdMz5vg0g1voSB8RjFqszbwuIncJAbZakeQ50ftF3pTs+PEYMkCvBQe9SgI4yD3ibA
         fEzyt/dpUjqRFGwdr0QSa5CEkKSGR5PX/kP8ttjMhisE70GG8wBSTGObnFNOKRVQACMC
         4+DA==
X-Gm-Message-State: AOJu0YyxoocBMYo6kFl4zqS1lQnhALKVOq+pv+qU1Mr7ywmUJuRrKbJn
        oFbrIN70nL7nBz3uL2SQu5Rk0CIf7WnQ8g==
X-Google-Smtp-Source: AGHT+IGNOsWCDsUL5pZ0AiktNOZC7/JBxYAG4tbCmHfyMbugl7QB2wYm9fg1FEO7P/fQ6KOucMjekw==
X-Received: by 2002:a17:907:7757:b0:9a1:aede:edfb with SMTP id kx23-20020a170907775700b009a1aedeedfbmr10817032ejc.12.1693072774840;
        Sat, 26 Aug 2023 10:59:34 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b0099d45ed589csm2434635ejf.125.2023.08.26.10.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 10:59:34 -0700 (PDT)
Message-ID: <099b2b17-b236-4fd5-89a7-8ecbfbc9c323@linux.com>
Date:   Sat, 26 Aug 2023 18:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/6] arm64: dts: add support for T7 power domain
 controller
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>, neil.armstrong@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-7-xianwei.zhao@amlogic.com>
 <27e55b16-065b-4a16-ab05-dded04f2c705@linaro.org>
 <56c0b78a-b9dd-de6d-7d7e-654fc5dd8e1b@amlogic.com>
Content-Language: en-US
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <56c0b78a-b9dd-de6d-7d7e-654fc5dd8e1b@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-2023 09:51, Xianwei Zhao wrote:
> Hi Neil,
>     Thanks for your reply.
>
> On 2023/8/24 16:32, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 24/08/2023 07:59, Xianwei Zhao wrote:
>>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>>>
>>> Enable power domain controller for Amlogic T7 SoC
>>>
>>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
>>> ---
>>> V1 -> V2: None
>>> ---
>>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi 
>>> b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>> index 1423d4a79156..23cdad1b425b 100644
>>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>> @@ -4,6 +4,7 @@
>>>    */
>>>
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/power/amlogic,t7-pwrc.h>
>>>
>>>   / {
>>>       interrupt-parent = <&gic>;
>>> @@ -118,6 +119,11 @@ psci {
>>>
>>>       sm: secure-monitor {
>>>               compatible = "amlogic,meson-gxbb-sm";
>>> +
>>> +             pwrc: power-controller {
>>> +                     compatible = "amlogic,t7-pwrc";
>>> +                     #power-domain-cells = <1>;
>>> +             };
>>>       };
>>>
>>>       soc {
>>
>> Please change the subject to:
>> arm64: dts: amlogic: t7: add power domain controller node
>>
> Will do.
>> With that:
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Tested with Vim4 and all works fine.

Tested-by: Lucas Tanure <tanure@linux.com>

