Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB74A75116A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGLTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGLTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:41:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7A1FE1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:40:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so18274f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689190857; x=1691782857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sn10iQHpwGY+eYGAiAUXJ1C6Kcrs3fREJAIA3a7Sc2c=;
        b=Q/P8GG+cWA78JR5k1cstSyKnHaJzP4ItRvLyr0QhJPyoiEfzasZanFiDqRzttm+7Tw
         DQrHTrZBRun235hJiz+Gt4q3gHHCqY0H21jaAudNhs0XhM9ecTUVY9iUSrFSBxY3GclX
         ohuZPJSyuzoWqGGXYc+j7pQJGB87T+IYqZn6SxSYicbwvI0Rb5D/nYTug5yM/505fNKK
         pkhlEvOxp2wAF0SF75lPXX72uKYU266GkavjhsDJQIly+mjtGPQJ/nj43Ebe04ZSO/ql
         ObaUoQVHKvQm29NWnWGNQJC5q8EcRzUziCTYD+Pp0RwdBGcok6YKq1Y81e6SbAdZkoM7
         vORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190857; x=1691782857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sn10iQHpwGY+eYGAiAUXJ1C6Kcrs3fREJAIA3a7Sc2c=;
        b=Xuy49R05PqTFq75VfmwYs7LysY+mHB8zelQkzNBGseMQVpogPQ7Oz/zM2X+FOlO2vi
         Jfkn3Btc9f84zIu0oAmSiS0NoT/HUSJ2Rgi2VsWMzKxvY6egOBJdQBm9tTB90+EpLJ5v
         6rv4wN/v4sw7kskzqBkEhbLI2e5YMwLCLeGToQyFhx5jDN28q8fpyeepk1U3HNPcPuFD
         bFF+nN7PfL+g6OaiLs1MF2FEishNqzMCziGN0voBh4e9BxUXfwJf32uY7HNyz6VB0BES
         o6RzoJw/5IIEIF9PeWKU5XRQ7tEsiD4YOCtLBGdMlBs7CtZPO9Y4unQ/69sZ5VW15QNg
         ymFA==
X-Gm-Message-State: ABy/qLZshPTD22VN0H3m1XLew0HOOCoW2uplM69HWJNsQHIo6vx34lJs
        9WJyUEELABf1JEEBOEOAu9YmEw==
X-Google-Smtp-Source: APBJJlFo2j+JdHiM2R3wbxMQhoIkgOQ4zvhrGZ02phohM7r1Y1i+edtFEiZsiP/0XTEBiWS2HjMbSA==
X-Received: by 2002:adf:e7c2:0:b0:313:f07b:8025 with SMTP id e2-20020adfe7c2000000b00313f07b8025mr17795819wrn.47.1689190857663;
        Wed, 12 Jul 2023 12:40:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7d9d6000000b0051bfc85afaasm3180698eds.86.2023.07.12.12.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:40:57 -0700 (PDT)
Message-ID: <a1ddbc5c-0e41-84b2-4281-7303cc3040f8@linaro.org>
Date:   Wed, 12 Jul 2023 21:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch RESEND 1/4] memory: tegra: sort tegra234_mc_clients table
 as per register offsets
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     bbasu@nvidia.com, talho@nvidia.com,
        Dmitry Osipenko <digetx@gmail.com>,
        Ashish Mhetre <amhetre@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-2-sumitg@nvidia.com>
 <abdff39a-5306-b431-ae28-1e1a03c0a555@linaro.org>
 <ac9e9e2a-00b8-c9e7-00c7-215cba139a39@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ac9e9e2a-00b8-c9e7-00c7-215cba139a39@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 18:48, Sumit Gupta wrote:
> 
> 
> On 10/07/23 15:38, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 21/06/2023 15:43, Sumit Gupta wrote:
>>> Sort the MC client entries in "tegra234_mc_clients" table as per the
>>> override and security register offsets. This will help to avoid
>>> creating duplicate entries.
>>
>> If person cannot search for existing symbol before adding new entry, I
>> doubt that sorting would solve it. OTOH, this patch makes backporting
>> changes trickier, so I don't think this is good approach. Are all other
>> Tegra files ordered in this matter?
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> They are in order for previous T194 SoC.
> For T234 also, initially the entries were in order.

OK. This has an impact on backports, thus I would be happy to see some
acks or reviews from other developers of this code, that this change
actually helps them by making code more readable and maintainable.

Best regards,
Krzysztof

