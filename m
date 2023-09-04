Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580A179198C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjIDOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjIDOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:19:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B54ECFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:19:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2113937a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693837177; x=1694441977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efoW78Jywy267X61gDJ1HOjwLM0WPRkMQBGOt0l4Un0=;
        b=Ru0YZho3kgkXBKRgsQDC5nqvAOXzeSWLFuxdsX1BzA9ub1SEn1PoC9C2pFA6XUQKuU
         QD6j7ikPC5gZVId1xT23B1KoL1NQorRe6UwpBmaTYoJKsmaf0+/YqgwbtuqoV6RcQnsQ
         GhyVbUUn1c3euaonkvNJ/gtJZ4N9wsHy1xuDMPkJY/2C+V8Pzbgu0OrkfvLMRzYbkQzV
         1DvhBxdG/t3vHCMzNpZ1ZgxH/5H6rL9KgVflLHVhevi8GQpngxE7vh/XRZMBQdBYGZsG
         1t7vB9H0n6DaJLdj6W5U05agjwOgksJwqn7CUK8+7eDUA8FAvsKGEO3zSnJKQCTsE5pT
         Qqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693837177; x=1694441977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efoW78Jywy267X61gDJ1HOjwLM0WPRkMQBGOt0l4Un0=;
        b=QDSmOtwNCpJdRuxr5536BiNQXw8yVSF2Ts+hITvMQvzlwcyzME6e50r9acZ6ixYTPi
         s2pjBtzUgU4Y7OlcQhvmmWqbgS8+65ZldOt9HgE/WF2vfjHuMT7GQz3JVhP3N5E3n4nF
         rzgRTWkmqlSpaEoAibJFt16EX1pr/cdHd3h7C3NzAx7lfZGqhQD7A97Zxosowlr+OZ6L
         5guD/BG6YyuL8OqxAdtcbFeM1tQI5TTGHIpKoL+GWy3y7o6cPHky1XpgmvWFezu9Xzy4
         7EG8kVFUgnQAqneaeoE8j+dgIbbaoCPMY04KEfBSj3lLLGYQbntDiJAgs9PO3MGx93W0
         X/Pw==
X-Gm-Message-State: AOJu0YxkyEbqZE3ISA5bkZwMgcRPdjNwbg4ggty8fbf81b5J60gIvB3t
        mIkKvjkhaV1JJF1EFnZ4ENQA7A==
X-Google-Smtp-Source: AGHT+IHA2mhSNRsn94Q0AHR/BHUOnzMC2TMmLSs66HP8jgHuk6eAMhjdlBRg+G7Rq53geOa9TDPP3Q==
X-Received: by 2002:a05:6402:1482:b0:525:45dc:40b7 with SMTP id e2-20020a056402148200b0052545dc40b7mr6730929edv.17.1693837176987;
        Mon, 04 Sep 2023 07:19:36 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id d26-20020a50fb1a000000b0052574ef0da1sm5843996edq.28.2023.09.04.07.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 07:19:24 -0700 (PDT)
Message-ID: <a19f9b10-f65f-6719-635f-06bc10b79c61@linaro.org>
Date:   Mon, 4 Sep 2023 16:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 2/3] reset: Add th1520 reset driver support
Content-Language: en-US
To:     Kwanghoon Son <k.son@samsung.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jszhang@kernel.org, guoren@kernel.org,
        wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230904042559.2322997-1-k.son@samsung.com>
 <CGME20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1@epcas1p2.samsung.com>
 <20230904042559.2322997-3-k.son@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904042559.2322997-3-k.son@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 06:25, Kwanghoon Son wrote:
> This driver supports th1520 T-HEAD SoC reset platform device.
> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---
>  drivers/reset/Kconfig                    |  10 +++
>  drivers/reset/Makefile                   |   1 +
>  drivers/reset/reset-th1520.c             | 109 +++++++++++++++++++++++
>  include/dt-bindings/reset/th1520-reset.h |   9 ++

Bindings are always separate patches. In this case, all bindings should
be together. Also you clearly forgot one step:

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

