Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27681789BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjH0H4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjH0H4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:56:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E77106
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:56:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500913779f5so3507009e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693122969; x=1693727769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtCfEv+4MKM7AB9nOhBJNz/fOo34fqcluKuKRBYbD48=;
        b=qD7V+/1eeqflk5HBX6g3KX3146dEBk/Xkv8nuSU+gc3hnO6r9ofzuLGMPcc8Dn7C2e
         GKlBdiZ2qE5uIrVHiTtm9JGCOOrTPB6mU9ujnBbMsXK1WVwupwtgLBNFxtBZiqvjaQyD
         PdZrJzydTmbJlB+zh+djrY96msG3m1kA998NMjMmH+ugM569oMQCwSK03EFEx49Lhxtd
         lVEVI6GG1tCWtccwwbwmN0/6vKwbixgoMys0rMT+EZp16KSvz5VxiTH1rr+FZDIDcOzR
         PyyjxQ6Hp4+5N7egiFOWCMcHc9jbnIlMDtyzPyssB7v6CNdwRVdT6/nTEbCEDyAb5Dy7
         +rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693122969; x=1693727769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtCfEv+4MKM7AB9nOhBJNz/fOo34fqcluKuKRBYbD48=;
        b=edfE1PswKh3xxTJdyFfCT7n1F9LYlCnqXHdKw6s8vn+WHrhZs1PoQbuBVQFXhUvkGD
         Pqqik1daNejY1f0PVTq1DsC5bSNCiuvq3TmCfQ7xNuJx7V2elgx+OXn7uLqx1ZQEQ7/q
         rXgzYTTsUKW3eTx7p4XP3IZe3jFYrnQf0S5NTr2JSbMujKP4RFTQn9bcf/QOoC3ikl4G
         TYlb5Y3EwB1heGWgQGS8mxyAVQs6cVE9Qs67OKXB5JSzdxaOw7lpb25hKNo8M1KWQN9A
         mTpLQEdvK0C6tesmXlB6mlef8o/UeyvpemUzvBw4PaFYuDD5YcktabHhFMitIo7ea6o8
         vC5Q==
X-Gm-Message-State: AOJu0YxLyz0lQIr3V+6DB+hkKqinZowO0cfQduXE65+pQA8EDgm10kXI
        7UlpHqDUbfVwWDtAd148UYzxYg==
X-Google-Smtp-Source: AGHT+IH+qv/LoraiYPu/y8KAOtXrIZc0aV8VyRf3SodaZ97qiCkEX4ZtlRNINc81TgAvCPpw8+aRAw==
X-Received: by 2002:a05:6512:3e08:b0:500:b872:7899 with SMTP id i8-20020a0565123e0800b00500b8727899mr351076lfv.62.1693122968433;
        Sun, 27 Aug 2023 00:56:08 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id rn14-20020a170906d92e00b00992afee724bsm3136783ejb.76.2023.08.27.00.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 00:56:07 -0700 (PDT)
Message-ID: <c32130ab-27dc-e991-10fd-db0fba25cc97@linaro.org>
Date:   Sun, 27 Aug 2023 09:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
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

On 26/08/2023 23:04, Serge Semin wrote:
>> +  clock-names:
>> +    items:
>> +      - const: stmmaceth
> 
>   clock-names:
>     const: stmmaceth
> ?

The existing syntax is correct. This is a string array.

> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
> 
>> +  interrupt-names:
>> +    items:
>> +      - const: macirq
> 
>   interrupt-names:
>     const: macirq
> ?

As well.

> 
>> +
>> +  loongson,ls1-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the syscon containing some extra configurations
>> +      including PHY interface mode.
>> +
> 
>> +  phy-mode:
>> +    items:
>> +      - enum:
>> +          - mii
>> +          - rmii
> 
>   phy-mode:
>     enum: ...
> ?

Here indeed, this is a string, not a list, so items are wrong.



Best regards,
Krzysztof

