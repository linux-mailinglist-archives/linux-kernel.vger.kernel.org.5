Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798A768C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGaG4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGaG42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:56:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D511C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:56:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8700943a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690786585; x=1691391385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+CfR0bQL2f6+lX0xcgogwy4lwpWoaSnfppJn89aXWk=;
        b=GUWEp9EcVvFYEpYWiL5hR0u5tRun0bBc6gdFUvEBr2ca3dLBFSo6wwuoZiXMZyYcGD
         toPpNRTJmFbjOdjqrqdN9KUbye/dlF3PdTH+hVVWddJ3NQm+3YemGfRml6CO3sQZz0AJ
         k40y+yRttCxEEBZfU6nPOUUuRJb1y3VSgGEDu3AEyi/ON0hOWEvwOpeBRdXfZP1dY5hN
         iIfhwvprSpoM5NNiKDagcfVcEz/9BE6EQQqPaByg1RwYmcjw+R3zzMI0VuCQhPL+y3w1
         di6R+PU9hprzInMd9hTptP6RBthie/K7BbO0a2lbPIAlHveUdJqQN2yfVh77ZhR7hJi7
         hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690786585; x=1691391385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+CfR0bQL2f6+lX0xcgogwy4lwpWoaSnfppJn89aXWk=;
        b=FoAVOLJ5Kfwp1lFSpEEr0i7RN4tKWSOGb5bjuoQIVS+2DoDhds+23MmOpm8GgktIOf
         yZ+Q5FEaoXG8yWAzOPd+xNmZ9sHOWHF8puPyD7e/gKAl/P32iG7VfKNqe/XJ0cBAjZiN
         cIM11St/unZzlexu/SkEg07Ym67YXG868139O4/LKk3FL5DgAPZFc8SZaWpgDSwRpZ9Y
         kpdzuR8qSBJFtxQQzjFeytMfYg2h0c09lYxMj5mk+LgJ0ALct3Usu5k5cswTfQxN79VS
         4pXcqFV1coEC01mREWeSO2uyCOgHedIvCHoge2iv+cCUsoIKtuF43U3oI9j1sYDiHLyP
         GqxQ==
X-Gm-Message-State: ABy/qLZJxPm4djUuhRbnkJzX6zHvVGkSgXd0bj1qh2tdlwinei8Pribn
        d4Y0/36d579MgDgZ8M8mPM0xQQ==
X-Google-Smtp-Source: APBJJlGCJK+vLRByTvuO6krg5VsOL4GRQzkfn6Akp0lQsgEeTOlxYlC1pqxpSpG6aT11G5ROzBnjWg==
X-Received: by 2002:aa7:c84b:0:b0:51d:95ac:22ed with SMTP id g11-20020aa7c84b000000b0051d95ac22edmr9574982edt.1.1690786584828;
        Sun, 30 Jul 2023 23:56:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b0051bfc85afaasm5011296edx.86.2023.07.30.23.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:56:24 -0700 (PDT)
Message-ID: <bdd0b66a-2741-9140-ea1d-14caf938da38@linaro.org>
Date:   Mon, 31 Jul 2023 08:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 07/17] MIPS: loongson32: Convert UART platform device to
 DT
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-8-keguang.zhang@gmail.com>
 <2ee2336c-d54f-6fb7-0142-8d0e08cce25b@linaro.org>
 <CAJhJPsXbW-JkzPTH+fHW3PD9J9+s0_F3Fbs3sb44tC12iTCk-Q@mail.gmail.com>
 <CAJhJPsXT+T7z4Av6tsQX00CAh8p6r-2ypggY+_iDufZhxToAWQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsXT+T7z4Av6tsQX00CAh8p6r-2ypggY+_iDufZhxToAWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 05:32, Keguang Zhang wrote:
> On Mon, Jul 31, 2023 at 11:04 AM Keguang Zhang <keguang.zhang@gmail.com> wrote:
>>
>> On Sun, Jul 30, 2023 at 4:26 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 29/07/2023 15:43, Keguang Zhang wrote:
>>>> Add UART device nodes for Loongson-1 boards,
>>>> and drop the legacy platform devices and data accordingly.
>>>>
>>>> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>>>> ---
>>>>  arch/mips/boot/dts/loongson/loongson1.dtsi    | 54 +++++++++++++++++++
>>>
>>> Same problem - DTS is always separate. It seems you made this mistake
>>> everywhere, so entire patchset needs to be fixed. Keep all DTS - your
>>> base board and extending it - at the end of the patchset and squash it.
>>> There is little point to add new DTS in steps (e.g. first add incomplete
>>> broken DTS and then immediately fix it... no, instead just add correct
>>> and complete DTS).
>>>
>> Sorry. I thought it would be easier to review for split patches.
>> Thanks for the explanation.
>> Will send v2 with one complete DTS.
> 
> Hello Thomas,
> May I ask your opinion about the way to delete the obsolete platform devices?
> Should I delete them in one patch? Or in separated patches?

subsystem patches are split per subsystem. arch-code can be either
together or also split per type of driver. Removal of code is
incremental. Just add extending it, but your patch was not extending
DTS, but adding new one.

Best regards,
Krzysztof

