Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44213776270
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjHIO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjHIO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:27:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD9D2108
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:27:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so42616645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691591269; x=1692196069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIeum1LY6S9oOWjrA1Hz1M/iI/HQL9yzxT92jLmRvy4=;
        b=HKuEWv2S3p0ryCE+P2Er85fOrWyumOVzBMb6xINWCp41dK3t68nBKR+B+iMKIGJ5Eo
         MEOJ+9XXbMmls/NfkWrvFnUIshwXEa4bsYJ9jWwYLUyxLz/v7JISdtz6FD1lZD8vww+i
         ZesbgngH8DiqPthHakl1RDVSv7tLru+r9Uo7VBJESjkzZhIVR40WLXuYlEDi5+n22XE5
         4TFyGe/QrdLsldg8veJ4ibTPeqBTQLaoVCrwXbVMQ0xnY7vjUbW3JJGsChLjeZ7k+AdL
         S8Pn29LRLWRPT3bEUSAyKbT1bReWDgsKYIfEsSXUAFsaZNQLGkTkEKdNfE2qL90hEKHF
         grBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591269; x=1692196069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIeum1LY6S9oOWjrA1Hz1M/iI/HQL9yzxT92jLmRvy4=;
        b=g3cklyjMDwDeEsmuUeFLS2VIuhWgx7bGPf3WDl6Uhs9nCkz8Zpg1TDnuhgn173fsmL
         5YWiNRkpeSGPQYnhwYRuk5/aLQA570aHmbcCwwNiyCzhg0ebVznp0cOia2Ryz8Gwm2+K
         vN/I6iBW8rT4bIy4NXlKmXDjdjbv+0d2Z71CmVDDPDwQ6sZXn/H97dH+W9QXTKE/wqap
         qH+onwp2I+4o2EyWtRuw9c1JD73zifco1l4PEunvWa96+P9VYbrGBrG7zqFVt01BTXrY
         O39GTdEf6P8WiRVYd+kMI9z9lQdRSWVaedIIvRkHSapxneNpwTJEFb0p4u2Z4pXEQAzy
         Ja/A==
X-Gm-Message-State: AOJu0Yx2SUNEHdlFTpMQp2dd2DbV7FSqozJ/h7oIbGwC2QIKmZEAU/Ww
        W/bKqCbCTmV+tYL7LFRI4InYHQ==
X-Google-Smtp-Source: AGHT+IFcvrF/0+48M5rEwvbGq8wkuT4jgAfdSLYdgNQCBWGh9/ZxwvF01V2txrU3jt8NvdClblnr4w==
X-Received: by 2002:a05:600c:219:b0:3fe:1deb:82 with SMTP id 25-20020a05600c021900b003fe1deb0082mr2306960wmi.7.1691591269368;
        Wed, 09 Aug 2023 07:27:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c029800b003fe2397c17fsm2124090wmk.17.2023.08.09.07.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 07:27:48 -0700 (PDT)
Message-ID: <893c3f40-3094-1939-833b-2edcd935c83c@linaro.org>
Date:   Wed, 9 Aug 2023 16:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: nuvoton: Add DT compatible
Content-Language: en-US
To:     Mia Lin <mimi05633@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230809095112.2836-1-mimi05633@gmail.com>
 <20230809095112.2836-2-mimi05633@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809095112.2836-2-mimi05633@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 11:51, Mia Lin wrote:
> Add DT compatible "nuvoton,nct3015y" to select
> 
> Signed-off-by: Mia Lin <mimi05633@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> index 4f9b5604acd9..67fc60fd395c 100644
> --- a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> @@ -15,7 +15,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: nuvoton,nct3018y
> +    enum:
> +      - nuvoton,nct3018y
> +      - nuvoton,nct3015y

Responding here, but based on your changelog and driver:
Why? Why do you need compatibles to verify the reported ID? Verifying ID
does not make sense. At all.

These are compatible devices, so you could have one more compatible
using old one as fallback. And no new entry in the driver.

Best regards,
Krzysztof

