Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F83800A51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378696AbjLAMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378656AbjLAMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:03:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583D172C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:03:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so19198435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701432212; x=1702037012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVOc56kK2zwGkd3fAlYzj1nsVh5HFurnhiz0R/5JgWY=;
        b=E2HKkmH+ea26CqJLlHj0oOH3idoHq/7/HPLLWu22E0hv217z6QyuXsVI9CYEE9bas/
         gEUB4xD14echWcFqAin9y6MlU7/xF//+Jiq3o/gSScQPY4BFxBkbL0INWiH9HUSnXFrF
         xm5cGOi1FTFvWdf8k/mlUmOil9RULRhOe33PmgHQPq3pxNiAH8qNxZqW728n5NNXxxYO
         Bws4431JK4Rb01KJNi5fSZM1xFYj0aw0nPIqQczpU8ri6IemkoEXy0/yBNW5ENIMEDVQ
         si8spmbYyzFdk3xIxDcZPQxbfhNMbEOyRbaolaJlzMkrY2ll44KiJkhLTC8iAWdg50O6
         bCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432212; x=1702037012;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVOc56kK2zwGkd3fAlYzj1nsVh5HFurnhiz0R/5JgWY=;
        b=FX6JU9WXth7NA8FCmIFleA+OJHzLYAi+7MUQ3Bs4J2yJnyjlcZdE5FZDeVmd3I6vGS
         277vOKCR9G/CU4AoJ2qkjtS2uzww89aHMHAk7AnVFB0XbdbZly5QQc7a18OWJkb7E6BC
         f/4t5fSO1NBYTY45QPP6J8xXnPUlxWkvOANsz8uH4ItGAZquLIJx7lwgJ47XukfqItFx
         uq0vo9H94MGgV4g5IWLq+XmX3nSG/qWnwwuJP7+DMwxwqzBw6GiywlJYyHCVgXrPjD5Z
         m3Epq2a5FKQDZhclGzr5JPdgKSzA7ocGgN8ayE8h4icf2k7nprxGw1vMt2HHrnK36PN+
         T45g==
X-Gm-Message-State: AOJu0YxMdzovwbbLjhgC26W8YGPmVwUCLo81sFm1LseTCVzDKJDKR2d1
        CWDyuekpOOr7yMRYdKLG1izRJw==
X-Google-Smtp-Source: AGHT+IG3Pslut9pT2LA34/RAuijW/6/8jO9jlPv7SsfwSwTgtx3jeXsxbnu+DV6Sa1Y9i9WlNzdSTA==
X-Received: by 2002:a05:6000:228:b0:333:2be8:b3e2 with SMTP id l8-20020a056000022800b003332be8b3e2mr722153wrz.62.1701432212145;
        Fri, 01 Dec 2023 04:03:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id cg16-20020a5d5cd0000000b003332656cd73sm3390392wrb.105.2023.12.01.04.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 04:03:31 -0800 (PST)
Message-ID: <d98ed844-b5d0-42d6-81e8-19a0048db3a4@linaro.org>
Date:   Fri, 1 Dec 2023 13:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/22] dt-bindings: mips: cpus: Sort the entries
Content-Language: en-US
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
 <20231201111512.803120-16-gregory.clement@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231201111512.803120-16-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 12:14, Gregory CLEMENT wrote:
> The entries were nearly sorted but there were still some entries at
> the wrong places. Let's fix it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mips/cpus.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

