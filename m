Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843CC766920
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjG1JkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjG1JkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:40:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7171BD9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:39:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9891c73e0fbso399211066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690537195; x=1691141995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzOjDa/NiFfXAukG8EL/eyfE/m/LqMSufMn6fl5Fd5Q=;
        b=aELCmPUKOnOtKtdIdrm1ftrjdJY25iLwulcwpTSbyw3xoxyRfGgMUQLyqC/+aYAePg
         UvMPnLwyBdbseFNQ1JAylEiuzCN7CKvfl8ZkzseqD97oBAsgz04T6tTGgRB5gHsCsUQj
         P+dKNM6UY2calrABEpr42Ers0QQc/9Nh+0pO+h66YrLdJsZwnq7HELwOktlD3FcDth6P
         yTFQqrCIkJPWlUw5/b+qKo3REf2s+h+i/dyqmM1KtBAIhmhZfBW5k1cP5JuYaUO12oz/
         ILPMZsnUrJafM7hxQQHnh8972Qh64Od7CzZTM0AfVHQ0x2DcoZ7aXXbPL0BSD+kwXldV
         uwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690537195; x=1691141995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzOjDa/NiFfXAukG8EL/eyfE/m/LqMSufMn6fl5Fd5Q=;
        b=VJcpYdJwVqWQXmaxit6e2iaTCvZQANRsixptjSdg6n/6cAHvu3l/uMCkYd5k1Sxwqa
         7ZwIb0cPsbigT7s3k87M5HqUkUTGTTVH7e2eUlSwOqcG7v0/QG1yv0vYmzOo8qNzN8ZP
         2R/fsOKHSD17YYdyX2/EXjvW05U9xLRjVCw4HB1JpXgtzSpvRW6/vaR0vS2oa6R7lvE6
         On4rA0aP2r22V7AHYzIrqE7tB5nMeAdWHw9ldF4MjbaZ6cw/eFph88IVZv9vIVRKvom5
         2At0Y1tZ5WCarkf5zZfF5cx2aLRkpBOwZKgV1fSJrrYLDx8zG3NoGvrl62d8JcV220Ya
         L0ag==
X-Gm-Message-State: ABy/qLZFBrhCg6/DGMwzJBuUq4YJfVpMh3+/Q/bqB9t9br5AeqoANL3K
        gnOsXl3PvFtVolnO847jDd/pkgoMyKKqYN2dtfwsTg==
X-Google-Smtp-Source: APBJJlEzVY3nftGhMOjUKhGUDDP2LVoqOpi/EgmGWeNfXear+Hqdo+hio8an3wet4513dTrvaHivKQ==
X-Received: by 2002:a17:907:784d:b0:99b:50ea:2f96 with SMTP id lb13-20020a170907784d00b0099b50ea2f96mr1995415ejc.12.1690537195124;
        Fri, 28 Jul 2023 02:39:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id si15-20020a170906cecf00b00992e265495csm1860758ejb.212.2023.07.28.02.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:39:54 -0700 (PDT)
Message-ID: <f7df407e-1deb-f667-912c-81415fffcbfd@linaro.org>
Date:   Fri, 28 Jul 2023 11:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
 <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org>
 <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
 <be748338-987b-d474-d040-82af7cfb5f01@linaro.org>
 <CAPqJEFpYOgaEiSJ4HJwxMtpu1MZeUg9=tARTWa7hwTkjsQ3UAA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPqJEFpYOgaEiSJ4HJwxMtpu1MZeUg9=tARTWa7hwTkjsQ3UAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 11:04, Eric Lin wrote:
> On Fri, Jul 28, 2023 at 2:58 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 28/07/2023 08:01, Eric Lin wrote:
>>> Hi Krzysztof,
>>>
>>> On Fri, Jul 21, 2023 at 4:35 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 20/07/2023 15:51, Eric Lin wrote:
>>>>> This add YAML DT binding documentation for SiFive Private L2
>>>>> cache controller
>>>>>
>>>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>>>>> Reviewed-by: Zong Li <zong.li@sifive.com>
>>>>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
>>>>
>>>>
>>>> ...
>>>>
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - const: sifive,pl2cache1
>>>>
>>>> I still have doubts that it is not used in any SoC. This is what you
>>>> said last time: "is not part of any SoC."
>>>> If not part of any SoC, then where is it? Why are you adding it to the
>>>> kernel?
>>>>
>>>
>>> Sorry for the late reply. I didn't describe it clearly last time.
>>> Currently, we have two hardware versions of pl2cache: pl2cache0 and pl2cache1.
>>> The pl2cache0 is used in unmatched board SoC. The pl2cache1 is
>>> utilized in our internal FPGA platform for evaluation; it's our core
>>> IP.
>>
>> And why do you add bindings for some internal FPGA IP block which does
>> not interface with any SW?
>>
> 
> Hi Krzysztof,
> The pl2cache has mmio interface for SW. Thanks.

Then did you mean that FPGA represented some model of your SoC? If so,
what are other bindings for that FPGA components?

Best regards,
Krzysztof

