Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84498766C03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjG1LrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjG1Lq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:46:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D043AB6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:46:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so2710943a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544813; x=1691149613;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bicTEmA20kGYFXTbpbqy5uA1OeKR6hkby2ZwK7htZc=;
        b=bP9CWebw0nGNornjyAQacJRr0lD0PWRhFUu4NKQD6kJ6xR9eAFnPqEMkQUGJcpTHS5
         FvF65D3cZXKcR1q/qBnr9JWrDxg4qwbEQseYJvmAs+QgQB69PnrpzIYhwvWwbK5PjLen
         3GQkvvWyIV+7z9CMLlBVSF/NZEaga6fLuYgLbc0deePAdXbuRLhncr8ZxCUJmXsfSava
         rc6RODfUCfsgtW4EwWYNGgvCtExFFdan5QRenln+jvdoYjt0XSdtY50qyul04rUBmAzt
         DdbDruzn9N2fBykx+7h7xcMC0AL/2Xu4kh0jTeuMe7QfWTwobfJfiL7Xk3qV95rmKHbM
         cabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544813; x=1691149613;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bicTEmA20kGYFXTbpbqy5uA1OeKR6hkby2ZwK7htZc=;
        b=eXa9X5eOk5ya2vRyu+4tLvsuzN0jTt4UhsjYso1Ps4qDx+VqcaCNNX/7LVe/Lb/ALr
         GDigQ6XBj2pIUYpCfl8g5Z2JyvUH66A4axDooMBDaeOWI03QBbDFtFnTMjx/bazevWya
         SfdKFyAxb83Lv89JhA2RfE/9caYaRWWw38l1qv9LfuLmStpesZU+AUqY3FJWhLDkiRVA
         VzWrr6ng4JSWRJjwYGu0mog3atD2vc1yBcJZL+bVOQXeCtlB472d0Sa9fTHoUe68qwU7
         t4m8W1cBWRoohS4UFU5VO+dV0MvZo+OoHJ1PkgwToc6OgYeOAHkf60Fy9yu6ktxpSFDn
         irVg==
X-Gm-Message-State: ABy/qLZd0sINp/VXGitbuZGbbMS+5pJzSC2rtfzhXmmdQm+gCUzfgx4G
        j+EVe6PrQyV4TLR1qCdxg78Slw==
X-Google-Smtp-Source: APBJJlF4wX6IOyDsRHCOEf58T3NtRs74ijHx4d1kMWbOieFVhht66Yi45FbbkoL1b1Xdk3CUf6XDfg==
X-Received: by 2002:a17:907:7628:b0:978:928:3b99 with SMTP id jy8-20020a170907762800b0097809283b99mr1826331ejc.46.1690544813353;
        Fri, 28 Jul 2023 04:46:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lu20-20020a170906fad400b00993664a9987sm1961196ejb.103.2023.07.28.04.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:46:52 -0700 (PDT)
Message-ID: <46927d97-72a1-8815-38d3-828797c0f3dd@linaro.org>
Date:   Fri, 28 Jul 2023 13:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102350.265520-1-varshini.rajendran@microchip.com>
 <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
In-Reply-To: <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 13:40, Krzysztof Kozlowski wrote:
> On 28/07/2023 12:23, Varshini Rajendran wrote:
>> Add bindings for SAM9X7's pmc.
>>
>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>> ---
>>  .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml          | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>> index c1bdcd9058ed..ce0d99503645 100644
>> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>> @@ -43,6 +43,7 @@ properties:
>>                - atmel,sama5d4-pmc
>>                - microchip,sam9x60-pmc
>>                - microchip,sama7g5-pmc
>> +              - microchip,sam9x7-pmc
>>            - const: syscon
> 
> Where is the change in allOf:if:then:? No need for it? Why? Where is the
> driver change?
> 
> Please do not send huge series to 50 different people and subsystems.
> With your lack of threading it is so difficult to review.

You already got this comment and not much improved:
https://lore.kernel.org/all/f2f8cabf-ca4d-c6f3-5561-b24334be89d1@linaro.org/

Best regards,
Krzysztof

