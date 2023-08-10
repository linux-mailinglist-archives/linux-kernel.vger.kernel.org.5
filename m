Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF7776FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjHJGCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjHJGCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:02:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06453171D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:02:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d43so4721395e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691647339; x=1692252139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0arF/iWBLzW1L02POG+rJowN/h4IfW17SLxpjw2ewjw=;
        b=QSV0eLT/iq3CwscDlz3OiyAP4Pn4gIUFI72sUc9lTKNmrRRGHrlKrST+YVY4ZvPIah
         7U91SvkGYPiPc2DwQlMSeLYDfSectvojkZFlokTVRc9G1qo6UzZELR6K5g+0mhJvwiAB
         z6SNF88oKBDfA1mluG3Z1l3Fb756nTbQ8bUWKZkUKJR/y0HfTXbzZEVG3P4Kfxk28nRJ
         Dex6LJysH7ZgHWAUbJhMmcfyN5S9uRTmDXAuH2qSWtAMzK/JdWunyihcvaRfExnzAao/
         Th8F86tDNyfK5fsGu+Fdnlu3m1+cnzkrtu9WI6tB7K5GSfO9t7F8DvVSiyx8RFmUZnKl
         Gqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691647339; x=1692252139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0arF/iWBLzW1L02POG+rJowN/h4IfW17SLxpjw2ewjw=;
        b=VPocSmdNrJ4/T7b9QM9iOsYvWu4++X+gi6agqVYk3HD8o+3CMNVdOvte71vDnDiakE
         FqblF94+RCs02EO+TrTIi1x3tOAJ6c18ty+ThATxthZm2MHXziA8p6Xag/H+QZb6dzrs
         3p8QzocwEtTPJqbkViFVe62HLp8hxpeD7Srwg/DkPvaJPsj9U0syqq9c+5IbOQips6Sp
         E+ZBqS9DuyT2Hka3QjDDFJMZgZkPwsHrn9yIvXeyc/g8DqZHMngqltEr/aSgN3lBcETw
         UhG1VZOdxT8RdsNR9iCBktXBN0EFSdekkH934L4dt0majVAtLwSg9d+Yt/SU2e5vzMBr
         0OUw==
X-Gm-Message-State: AOJu0YwVUYL6mjsFgNaAzy5rFNdE3kFJT8BYN1ZefDdf0ERqsPXvmGSP
        1ruJs5ko8YEnc6pH4CoQTg6OSw==
X-Google-Smtp-Source: AGHT+IEQaR+rbDMkg9iXhsjJam5ZKVO+KloyOvkKiUGagtmV9+zhnWjnkCCIXrWWIU+0QgbO9iIJCw==
X-Received: by 2002:a05:600c:2258:b0:3f9:b748:ff37 with SMTP id a24-20020a05600c225800b003f9b748ff37mr1065550wmm.20.1691647339437;
        Wed, 09 Aug 2023 23:02:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003fc01189b0dsm963578wmh.42.2023.08.09.23.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 23:02:18 -0700 (PDT)
Message-ID: <3ff895eb-9675-9133-1b84-8d40b965e8da@linaro.org>
Date:   Thu, 10 Aug 2023 08:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 05/50] dt-bindings: clk: at91: add sam9x7 clock
 controller
To:     Varshini.Rajendran@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102350.265520-1-varshini.rajendran@microchip.com>
 <f7186a62-19a1-5d72-ee1b-255b81fb8abe@linaro.org>
 <f97b2698-f482-622b-5f9d-02c3113db546@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f97b2698-f482-622b-5f9d-02c3113db546@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 07:31, Varshini.Rajendran@microchip.com wrote:
on/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>>> index c1bdcd9058ed..ce0d99503645 100644
>>> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>>> @@ -43,6 +43,7 @@ properties:
>>>                 - atmel,sama5d4-pmc
>>>                 - microchip,sam9x60-pmc
>>>                 - microchip,sama7g5-pmc
>>> +              - microchip,sam9x7-pmc
>>>             - const: syscon
>>
>> Where is the change in allOf:if:then:? No need for it? Why? Where is the
>> driver change?
> 
> Hi Krzysztof,
> 
> This SoC has a new pmc driver and is not dependent on any other 
> compatible as a fallback. So I think adding it in the enum makes sense. 

This I did not question.

I was speaking about allOf:if:then: section.


Best regards,
Krzysztof

