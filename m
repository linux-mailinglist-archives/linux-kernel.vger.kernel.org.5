Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6095875C2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGUJTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGUJTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:19:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812882D57
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:19:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so2763896e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689931145; x=1690535945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+evqHRZa/EDVG2dkah/XolQarw2tcnvQkPThjVkdgX4=;
        b=C9faln+8ZG+kepF1p2NkPiXas5l+aKMUeWPO7QYd8wXXtchbjPrJWW3zmNhPVpHMzL
         +1N+Tq+VM+uyeoezmTlQlZbPk82yHAQzUyNzo8oW4+uZHTLXCHeH9n3xhQxiOLK2z2Mb
         mlKq5/Y4M3JSc1phXYLqXPl+vFZCf8VBtsL2wrudICjAiuwn9DwDw9kz+9hOwQ8cXjie
         F9ZDfCKna7WTiu0k4Xw78nfrTlpeEMHhr5CW1gNW0pJYNM8hk/D1cFrItjlUajrj7tWf
         ufjYEZukg2/6/cZI8Oyol2TkIV08Icnyax8vI1YqYyTQinLvwqgy1HkErZ5U4DlYLUm+
         Ds4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931145; x=1690535945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+evqHRZa/EDVG2dkah/XolQarw2tcnvQkPThjVkdgX4=;
        b=Ew0vy6UL5ewNho7gYq9cNhdcY+J+Y2arDqcDq+OtHMRGX0FfAnxfF4cQUQQw+q5KVH
         a+G/vJ6wz0KzU/WCXzvX/dFmLGOPHKruLNDNGmcgFhv1MFYHi8rN75RYNBqw8QwGA76a
         XHHC8ZReDpZqbfVZWeqQDH3Bxuvjcr5RsK3I8wm8S4TRlEalzMsjdARyXQirw9+LFE7L
         gp0q07yzR2To672BzaiHeWpfOnGCZyhmiDnii1wnKeWqB0rEQ3fD4BY395HdcH+kYhY+
         adyeouhlVq5an5vq9ZTt6+L4DkDBg3xIMiKzxxvhjnUpr5bSCXZ+SuG/A6/HfQ7FRnqL
         n+Qg==
X-Gm-Message-State: ABy/qLauoQ3p6usuqog7Arb6bReNUOqGYTTT6VJMP1Ka8BJCl/U5KX0w
        4zcx68o2F524GwVPH41aUEgcEA==
X-Google-Smtp-Source: APBJJlGlK6Pe1Zp96sS0zm05WadvmEM2DpPWcOuBqKS52m6jHpx9Iq1Jm1dX1riJpkn11OIn0aFhcw==
X-Received: by 2002:ac2:58db:0:b0:4f8:7513:8cac with SMTP id u27-20020ac258db000000b004f875138cacmr870399lfo.48.1689931144728;
        Fri, 21 Jul 2023 02:19:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o15-20020adfeacf000000b00313de682eb3sm3647154wrn.65.2023.07.21.02.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:19:04 -0700 (PDT)
Message-ID: <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
Date:   Fri, 21 Jul 2023 11:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
To:     "Li, Meng" <Meng.Li@windriver.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
 <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
 <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 11:05, Li, Meng wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, July 21, 2023 4:54 PM
>> To: Li, Meng <Meng.Li@windriver.com>; dinguyen@kernel.org;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
>> SoCFPGA Stratix10 platform
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and
>> know the content is safe.
>>
>> On 21/07/2023 10:51, Krzysztof Kozlowski wrote:
>>> On 21/07/2023 10:38, Meng Li wrote:
>>>> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
>>>> the Stratix platform also does not support clock-gating. The commit
>>>> 3d8d3504d233("usb: dwc2: Add platform specific data for Intel's
>>>> Agilex") had fixed this issue. So, add the essential compatible to
>>>> also use the specific data on Stratix10 platform.
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> From where did you get it?
>>>
>>> Did you just fake a tag to pass the review?
>>
>> I just double checked my replies and this for sure never happened.
>>
>> NAK, don't fake reviews. This very impolite and destroys entire trust.
>> The model of upstream collaboration depends on the trust, which is now gone
>> for Windriver.
>>
> 
> No! I don't fake a tag. 

Really? Then I ask second time - from where did you get it? Provide a link.

Best regards,
Krzysztof

