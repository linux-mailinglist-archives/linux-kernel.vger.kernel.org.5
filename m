Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED175C322
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGUJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:35:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D630CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:35:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-993d1f899d7so277816466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932135; x=1690536935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ql7ZNyTbSD91XZUyFRFCemVfKn9u5GYIu7fO320K/g=;
        b=t3EFQ62nndSy0qs9kIB+KM+woCzjSMNfeZE6j3fiTQnd47YV41l8PzP+6amNVaIFuY
         z6UYocPWUMod2nVz9UqeiIXs8JqY6CofmfqZncuJtpg6AA3yO4OTRsL6z2VX3sGl9ebs
         BJxQtLOyy85nZFJ6Ht9UbRX/Wyl0fNIAC1snif+D8TThnjlhEJcMq0beKFxhxLiqxjUI
         Qf8Efmc5sGJhvHdjTD4y5yBbEHiiKe/CIEmkN436m/DZW8q/tYiv6soRoGRwSRNr6GmE
         Wu0UA4N7Zdm718uAFObeZroLE3LR5OaNDpuEgTW5LX8TKu+dS/Dv3DUpuXruZhWWXXAG
         39Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932135; x=1690536935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ql7ZNyTbSD91XZUyFRFCemVfKn9u5GYIu7fO320K/g=;
        b=ks41BMZyxekhQppY7gWQ3XtZMzCvBmtnJwTDz3lO9RcZMHiNDD/XL1iz9hFtg75gmZ
         Q7P2DrkaykYzHFlnmDZTGqzOD5jq+Rb3uusQVVGgYgJ1oFwov+IngNfV81e38XufIgT0
         His8mxHe7E7DYshs+TH9ptny8r0kwaSA9Osv4fUn99hIGcvJqduZ4LQo54Irg1Ow9CpY
         VpblMait+xWO2XwG2kHbh7SngZZvoTBXN/JdmEECP8PKLs3b2pZZ/ZlwD1nxWkNIzHgM
         0zLofdSshIhqStCQQElViNBsR+V1cR7Km2k/VZoaoY778M/sItWBKpBC3YhFNWXq+V/f
         gWAA==
X-Gm-Message-State: ABy/qLax7KpFCiZMb6Njd8O2AxKEr2qbfTEzYyRHMInrDKT22vCu8Jkk
        e8qwkdOKiQiPYKSFRbe2bteSrg==
X-Google-Smtp-Source: APBJJlF5YQ3zc9aRPJTOcCSRzgrhwPUz+vi9AXKTTu/usZrQ9xj6euBjw8InEmnF44Zib7kYvrA4Tg==
X-Received: by 2002:a17:906:8475:b0:988:aeb7:2a37 with SMTP id hx21-20020a170906847500b00988aeb72a37mr1045989ejc.33.1689932135276;
        Fri, 21 Jul 2023 02:35:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm1876999eja.121.2023.07.21.02.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:35:34 -0700 (PDT)
Message-ID: <b4b56478-ac36-7fad-f771-8d545c022f57@linaro.org>
Date:   Fri, 21 Jul 2023 11:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Content-Language: en-US
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
 <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
 <PH0PR11MB51918208B7FE0413548F2DE5F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <846fad90-04b1-53e7-0f9d-1c243bbc6e92@linaro.org>
 <PH0PR11MB5191D789F87D7C9546F192D0F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB5191D789F87D7C9546F192D0F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
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

On 21/07/2023 11:29, Li, Meng wrote:
>>>>>> NAK, don't fake reviews. This very impolite and destroys entire trust.
>>>>>> The model of upstream collaboration depends on the trust, which is
>>>>>> now gone for Windriver.
>>>>>>
>>>>>
>>>>> No! I don't fake a tag.
>>>>
>>>> Really? Then I ask second time - from where did you get it? Provide a link.
>>>>
>>>
>>> https://lore.kernel.org/lkml/20230718030851.2014306-1-Meng.Li@windrive
>>> r.com/T/
>>
>> So where is it? You pointed to your email. Where is the tag?
>>
> 
> Sorry! Maybe I have wrong understanding about TAG.
> From my perspective, If reviewers ask question or give some advices to the patch, I need to add the tag to v2.

This is some crazy idea. So you want to sprinkle some tags, just because
someone disagrees with your patch and explicitly gives you a NAK, which
means NOT-Ack, Not-acknowledge, not accepted, not in good shape.

I actually wonder why adding an acknowledging tag for the patch, if I
disagreed and gave you NAK. Following your logic, this should be a NAK
tag. This I could understand. But giving acknowledge when I clearly said
patch is wrong?

Read all process documents before submitting new patches:
https://www.kernel.org/doc/html/latest/process/

> If it is not allowed, I apologize for that.

Best regards,
Krzysztof

