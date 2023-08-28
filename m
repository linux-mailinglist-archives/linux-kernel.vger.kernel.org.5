Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277AD78A656
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjH1HP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjH1HP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:15:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45510D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:15:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso360144566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206919; x=1693811719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJAzGXxVLZwUhvU/AbwqXIQG//zHq0gh5RxbohWoMzQ=;
        b=IAPS6RTDr+Uuos2iktTsV6YF4O0gf9AMecbKe0U1yvoJY+4RpFvnUKOeILUOzN9fZd
         bJwoaK97ve5ZzSZVaBaosV3ZEswi2I9AVBNzAdGbc3p4cMqN2ZhK6MRvgNcLVtJ+hSzD
         gE0vT4GkyZ/7FB6ZcoO8vnoE476dx1WQdvTuJHZ+Anz57RiGI1lPkcd0FSNGH2Hg5Qd+
         FQhS/I9Oww6456S5v4C1Kme9W3UZOusUXKv2KHtboGIp0y9t7w5lysWwhnIvnopFWWds
         WztDvXU+2dsWMOyjMom12SUquq71oEeatqwgRfmeOGtqnf1uUnIBdsrONQY58Aq5bDsb
         VRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206919; x=1693811719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJAzGXxVLZwUhvU/AbwqXIQG//zHq0gh5RxbohWoMzQ=;
        b=Q/JKRKaQ3ztOh9c2FKGL3mK/AMHRgLNlxOSHWYsZLowOlcLX4U0+KsHjaaXY8X5OSb
         oQi7+NwfywSFESNcWNMPH6+Gm9IKcKW0B4Bmq7WRFJ2L3eHZ8E6uC5P65hmvf799/qvf
         EBI/sjKbiBborBdnevq0OPFwbEJ9q3eR2z8oQ59lI0/HI9Qszr4XyfFQmlQVlcvURaJH
         HN+Dy8+Jv/flc0PFEjwco7wkeWJO9Qwr1rRmR6Ve+0lIx3YDaIW9LL3qOLaKeOWE6XOB
         XdyMOWrn6e5Yww4dlH5rgeOouuK3HCPFAu+/ndxM6FCwr/n6wUHSathBIWzPKEW02QSF
         BSqw==
X-Gm-Message-State: AOJu0Yz/as/AGAP3WulazkVhc4GQ6zmvnoQPnAtFJsvS5IpJu8Dc1qGb
        OtQ5ClvnVufooEZSMeVNLJeEcQ==
X-Google-Smtp-Source: AGHT+IGKvH+GBgAKQHWDhZZV09OE+zv1MgYwJxJsoDg2/XCIHmz1dXnuC31AHBwhEWMoUKUR5gkSfQ==
X-Received: by 2002:a17:906:5d:b0:9a5:846d:d823 with SMTP id 29-20020a170906005d00b009a5846dd823mr6109942ejg.45.1693206919659;
        Mon, 28 Aug 2023 00:15:19 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id fx13-20020a170906b74d00b00982be08a9besm4376385ejb.172.2023.08.28.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:15:19 -0700 (PDT)
Message-ID: <d6f796aa-c468-037c-3f53-d0c4306c8890@linaro.org>
Date:   Mon, 28 Aug 2023 09:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com>
 <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
 <c32130ab-27dc-e991-10fd-db0fba25cc97@linaro.org>
 <q7o7wqodz5epyjdj7vlryaseugr2fjhef2cgsh65trw3r2jorm@5z5a5tyuyq4d>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <q7o7wqodz5epyjdj7vlryaseugr2fjhef2cgsh65trw3r2jorm@5z5a5tyuyq4d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2023 23:01, Serge Semin wrote:
> Hi Krzysztof
> 
> On Sun, Aug 27, 2023 at 09:56:06AM +0200, Krzysztof Kozlowski wrote:
>> On 26/08/2023 23:04, Serge Semin wrote:
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: stmmaceth
>>>
>>>   clock-names:
>>>     const: stmmaceth
>>> ?
>>
> 
>> The existing syntax is correct. This is a string array.
> 
> Could you please clarify whether it's a requirement (always specify
> items: property for an array) or just an acceptable option (another
> one is suggested in my comment)? I am asking because:
> 1. In this case the "clock-names" array is supposed to have only one
> item. Directly setting "const: stmmaceth" with no items: property
> shall simplify it.
> 2. There are single-entry "clock-names" property in the DT-bindings
> defined as I suggested.
> 3. There is a "compatible" property which is also a string array but
> it can be defined as I suggested (omitting the items property).
> 
> so based on all of that using the "items:"-based constraint here seems
> redundant. Am I wrong to think like that? If so in what aspect?

Syntax is correct in both cases. However the single list compatible
*cannot grow*, while single list clock might, when developer notices
that the binding was incomplete. People add binding matching drivers,
not the hardware, thus having incomplete list of clocks is happening all
the time.

Best regards,
Krzysztof

