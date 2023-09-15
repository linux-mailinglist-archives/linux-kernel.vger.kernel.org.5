Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB837A1743
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjIOHZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjIOHY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:24:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569E1BCA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:24:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so27385841fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762685; x=1695367485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRVUxrzWSNf4X4G5XhrnO7+YTsERSGVJqcBKf82PDow=;
        b=wuXq56X/7R0rorv4p7eJ18zrkwxBN4wVhb166mNFCxH5ra8veLmLUriAlJirjVMMTH
         Kg67D6QY5YBdAzZTaOa7proveCJJKNCgl1XF0kD1EcY6gJP7gThwnFWVg3uUrLCTbdc3
         RHnrCCHbiOdvoCZWJR1AlYREBWr330H8RaseikEaYZWvZL/OYmVAHkiFQQ4zWiP2zHBp
         sq75EjgeL1NY9lljo8dbHnb/FHQWoMM36S8UzEkX3FTuYyBDqIr7bYWm78jrx2TDIycA
         Anw4/OCOJL63f2R435dt3E3aRbBUb1GQq8zoySUCJ4ho8GsA4IeHhtoNVA430craQE4h
         cFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762685; x=1695367485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRVUxrzWSNf4X4G5XhrnO7+YTsERSGVJqcBKf82PDow=;
        b=a6qek25SdeGgjh6xuMllvR5rcvRag8gLAmGjRu98GvkZ1oG1QX/KtoOnttO7k/dUj1
         dnFs5vKTmYRNQKbrGm8ghXVeXw1BESu8YymE3di+h6wW3y9UxjWvmX5GidJJqubmIOAc
         GUkV3x5myyDy9OKTltT+Gwf8Oc5Wgvgvj+hCQufcsYGZg5/iOWwwZNzutVlPXl5JU76l
         QP1bp0TcLQ9LSoWKVCS3cvFve2iEswfiTs6lHz7cSEYuJLE/m0xnDI1/0dAmVB5joimz
         EdjVlRMcT83sRl0ZoJFCFQY9FDLJc7rxgdd8qmQnX48+++96wt5UHp+YoAaXPtnUgTE6
         vlQw==
X-Gm-Message-State: AOJu0YxsHBcujRQJsLMEuwrDdKpgzkBlTDjWCoP8/OqCG2ZsX8oMUp/z
        mLLBxFHkNdE/SXkom495V5HIsw==
X-Google-Smtp-Source: AGHT+IGsyFGl3ShsoIVQDC6tL2uthtFYR1zLnmKmxUvMkJKuE45n7hu3NNEjQ1tFcwkD+8okp5gr2A==
X-Received: by 2002:a2e:a285:0:b0:2bc:f4ee:ca57 with SMTP id k5-20020a2ea285000000b002bcf4eeca57mr704099lja.48.1694762685121;
        Fri, 15 Sep 2023 00:24:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id fi26-20020a170906da1a00b0099bc8db97bcsm1995609ejb.131.2023.09.15.00.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:24:44 -0700 (PDT)
Message-ID: <c199fb5e-927c-aa39-ff3a-3a7906fadec0@linaro.org>
Date:   Fri, 15 Sep 2023 09:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and
 resets definitions
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Cc:     Claudiu <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
 <20230912160330.GA864606-robh@kernel.org>
 <CAMuHMdWxKFrTi7c0Df0cHLrVFt3=a7UOy0jnKxsG8PEuD=15Pg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWxKFrTi7c0Df0cHLrVFt3=a7UOy0jnKxsG8PEuD=15Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 17:26, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Sep 12, 2023 at 6:03 PM Rob Herring <robh@kernel.org> wrote:
>> On Tue, Sep 12, 2023 at 07:51:41AM +0300, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
>>> clocks and resets.
>>
>> This is part of the binding, so it can be squashed with the previous
>> patch. The ack there still stands.
> 
> Usually we keep it as a separate patch, to be queued in an immutable
> branch, as it is included by both the clock driver and by DTS, but
> not by the yaml bindings file.

Binding also should be shared, so you get compatible documented in both
places (thus lack of checkpatch warnings). It still should be one patch.

Best regards,
Krzysztof

