Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D27867DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbjHXGwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbjHXGwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:52:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844EEE59
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:52:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a19bf6ab66so479702766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859950; x=1693464750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tec2kZ0UKM8W+HhApP5ewEurz9N6NjLpNOz2ZhRdTI0=;
        b=y4ZL8J/hT/4lhwdW1JUK1rVUuPaCA6ziZUrBMqPLtCfiko/o1x47nAFofn/Sf2FQV3
         a9VCbPYrOpgf+5G5PRLhYyUVkv2853dYRke2aAFL0kQayHW5iyUlBmZccAZKv5ZCuQYp
         vPZ0N0daHWZ0InXx6Y53eIqCD41jxKMvz5b51jxcn+y5h0Ti9QCH3c0UEZyVpjJyySna
         vQRs2DAQFEmQwOA2L8GViFdF+1khWa3P5r3FGjmFlQACnBhrNtRHw9W590aNoaaX+G1o
         8HXxJfX3msHrqRJyILRE7S3ahy5TNH237lEO3Fvf1JWx67xJDML9yqD6yA2MgjVRXdN8
         GjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859950; x=1693464750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tec2kZ0UKM8W+HhApP5ewEurz9N6NjLpNOz2ZhRdTI0=;
        b=i1P28QowZyguSLW7KecYC2i5LXm4wEuDJYYlSs+HrejcZl1Sj3X2TukXb8YNa1YIjC
         7xsyAVcswEXKqw0r81NDP78b1wMAIgkB6XvotXYFIx0CMmC1CpbpU7huBzsBQxJua2Yu
         1QEaARD6qkKSgz1N8BfXNsHHpp55UmWWS+x42Rj8GacYEEOpIrBzUfYnnSocq3urk7NH
         8MgBm3/7C1RK6e8Pbrt7Pfe5+NGQ9m0mc7NQL3hvmWYiT2o99BWNIGNNG6xWFRrCh5sg
         cNW+uc3J8767YjWkXD+0hmEdkkAHY0oFmi33XyY9cbdpt9q9gNm6btmf04ycZc3TMiVV
         gTVw==
X-Gm-Message-State: AOJu0Yz8bFQ8cRJ8Ur3/2LMRZdo83wRcjwtPBKkGddPgZRn53y/NeEsm
        JFjRfn8W2EfpSnDN9zvCxHXYVA==
X-Google-Smtp-Source: AGHT+IF8mGk66KD1/hFdUuDrD7JYFjxRsc7Z6C/GO3AEZx1GBNE0jZUAwcxYLUKpOcCH3vti2NmJAA==
X-Received: by 2002:a17:906:2219:b0:9a1:c3ae:b014 with SMTP id s25-20020a170906221900b009a1c3aeb014mr4417705ejs.20.1692859949947;
        Wed, 23 Aug 2023 23:52:29 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090628d900b0098963eb0c3dsm10564592ejd.26.2023.08.23.23.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:52:29 -0700 (PDT)
Message-ID: <97445129-3cb6-d0bb-b1f8-dea997408ac4@linaro.org>
Date:   Thu, 24 Aug 2023 08:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 2/5] dt-bindings: net: Add IEP property
 in ICSSG
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-3-danishanwar@ti.com>
 <1326776f-2592-f231-2056-a231729da50a@linaro.org>
 <78d315b9-f8b1-0012-ceb9-5c3c5034c7dc@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <78d315b9-f8b1-0012-ceb9-5c3c5034c7dc@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 08:51, Md Danish Anwar wrote:
> On 24/08/23 12:15 pm, Krzysztof Kozlowski wrote:
>> On 23/08/2023 13:32, MD Danish Anwar wrote:
>>> Add IEP property in ICSSG hardware DT binding document.
>>> ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
>>> of ethernet packets, PTP and PPS.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Where? Please provide link.
>>
> 
> https://lore.kernel.org/all/20230814-quarters-cahoots-1fbd583baad9@spud/
> 
>>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>>
>> Where? Please provide link.
> 
> https://lore.kernel.org/all/5d077342-435f-2829-ba2a-cdf763b6b8e1@kernel.org/
> 
>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>> Where? Please provide link.
> 
> https://lore.kernel.org/all/ZN9aSTUOT+SKESQS@vergenet.net/
> 
>>
>> Otherwise all of them look like fake ways to sneak patches into the
>> kernel. Our work here depends a lot on the trust. Trust once lost, is
>> tricky to get back.
>>
> 
> It's not fake. They provided they RB tags, after that while preparing next
> revision I use b4 to get all the tags and apply to applicable patches. I know
> trust is important and I won't do such things like faking tags. They gave their
> tags in v4 and v5, you must have missed those probably.
> 

Yes, I missed that while searching. Sorry for the noise and questions.
Thank you for providing the links.

Best regards,
Krzysztof

