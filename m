Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0F7807B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358841AbjHRJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358868AbjHRJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:00:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2230422E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:00:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523d2ef19e4so822616a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692349228; x=1692954028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heuC0cWplAK1NglFOzZDeC2xnlspFSMTnnYe2bM5vx4=;
        b=WKQw/chb9bV6bIGy1mPCcib2IlIQ2KwUyVDtuMDFuq6TsJGyuIDSGW3ytzeNGyZOBr
         ovHpTj5R1qhYzer006jAJ8LpHJ0547npQLiPQcRRWcbW48ENGSzaML7oJsDYV/xvFH7A
         Ei7ieAjF+fDfCVRC+QEp3uJetKW/JFvQfYCd+M7lNNaMS3GVR+8h+ar2HKIjsHLkx+qk
         0UJ1ZgprnHeTiNOxgZN7hRgkEE9afvfriSYTSUIs/r9onNv0fGzLdttcUs/fyf7Y7FN4
         dwZ56G5YBqgSflVmq4zbKuWmGRFf+JyZBb/r6R9EUWW1MpmDRc3CKcy+oZc9Ye48G1iC
         Dcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349228; x=1692954028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heuC0cWplAK1NglFOzZDeC2xnlspFSMTnnYe2bM5vx4=;
        b=fPNjNocUohon6EJgM+EpLHRaDuK03V0/Fr1cV8bedu24WmoCoIMj9udmyRnxO59XIB
         aydHdoZXgI8pTF9eUGu6fzhuvvK5smnpvgiaTa43CIDsSWTAqDcsV7VajGMrTmAgnF92
         y0HWN86vC7QKgUl/k2aX9jow0LpDLVgdMpsK/WxSQSX2e7ZroesXuqK9cP5zS/KZuHG8
         uwgph++6RZdy4agDOB2FKsR+9si+QplnzJQ3HMmslB8ujB67h/HUHF6OQnB55kudn8DE
         qIxfPQAcjoOgCLY6v7O2LU2pR7J93IWDK9TuJa+0nBGmrsDyeIgdx1qkgIvHYXPKn7EK
         mM4w==
X-Gm-Message-State: AOJu0YywRQtachjLoQ56AjAEfLL/+Ic82dXiH3/oeG137vYLyg59zKVR
        DLSGrwIqlNFtCjY9Qznd5PMrbw==
X-Google-Smtp-Source: AGHT+IFQaQZq9Fc0VhUMc133YKSkQkSJvNeHeV8yr8CPs9lQHjka9E2nS9HYaY4dQG57AxA96nPFGA==
X-Received: by 2002:aa7:d4da:0:b0:523:406a:5f6 with SMTP id t26-20020aa7d4da000000b00523406a05f6mr1676868edr.12.1692349228076;
        Fri, 18 Aug 2023 02:00:28 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7cf8c000000b005256d4d58a6sm848044edx.18.2023.08.18.02.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:00:27 -0700 (PDT)
Message-ID: <fa75415c-89fa-451b-2418-9f2fd6fab93f@linaro.org>
Date:   Fri, 18 Aug 2023 11:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: st,stpmic1: Add missing
 unevaluatedProperties for each regulator
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725123740.149559-1-krzysztof.kozlowski@linaro.org>
 <11b08764-87bd-1d9b-a1d2-603193231f40@linaro.org>
 <20230817115234.GC986605@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230817115234.GC986605@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 13:52, Lee Jones wrote:
> On Tue, 25 Jul 2023, Krzysztof Kozlowski wrote:
> 
>> On 25/07/2023 14:37, Krzysztof Kozlowski wrote:
>>> Each regulator node, which references common regulator.yaml schema,
>>> should disallow additional or unevaluated properties.  Otherwise
>>> mistakes in properties will go unnoticed.  unevaluatedProperties:false
>>> requires listing existing properties (present in example and in other
>>> regulators of this device).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>> index 97c61097f9e2..1a1ced489ef7 100644
>>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>> @@ -189,6 +189,16 @@ properties:
>>>  
>>>        "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
>>>          $ref: ../regulator/regulator.yaml
>>> +        unevaluatedProperties: false
>>> +
>>> +        properties:
>>> +          interrupts:
>>> +            maxItems: 1
>>> +
>>> +          st,mask-reset:
>>> +            description: mask reset for this regulator, the regulator configuration
>>> +              is maintained during pmic reset.
>>> +            $ref: /schemas/types.yaml#/definitions/flag
>>
>> After further testing I see this patch is wrong. There are already
>> buck[1-4] entries, so this is duplicating things. I will send v2.
> 
> Are you still planning on resending this set?
> 

I already did and you took it. Email subject was different, though:

https://lore.kernel.org/all/20230726065633.74924-1-krzysztof.kozlowski@linaro.org/
Best regards,
Krzysztof

