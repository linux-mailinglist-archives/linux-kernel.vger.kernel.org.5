Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1560D75C1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGUIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGUIfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:35:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDF2D51
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:35:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so14568225e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689928501; x=1690533301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfWHeKXxdljDCCbveTdkfTSWL918u+rujXW3upEByxo=;
        b=vICzUJEdl187a4x5LHvpasldNbhxzirbPPz5HPQejNW23jy0jidV9o3JhBQhxGtrue
         B0nLY18UA2ldSIxjJ3Ev9jcD99CQEcHufdAj7VuTmFPwt/hb1j/pazkunNMFpwuV2pLa
         UJtA7zIQt+nEO5AZbqOXTBTF+Q3OMj2Gx2Pco4GA3prLLvEXqv6ZwXSzl7+Cv7Zf8F4E
         cCdmn5G2xJh38gQUuZueQDTVtRPjhCKkBZC3Svjo6BABK1flkiptnQFZoH6B5tM6L9wZ
         y96zoBCsDUmydL+x3121VUFPGzRYz+JepWS+ZaTEBQzLwBVfhh9/pu9lw+gcDYvAROJp
         bkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928501; x=1690533301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfWHeKXxdljDCCbveTdkfTSWL918u+rujXW3upEByxo=;
        b=DnIUhD0un1VbdUjoWLf4ixWDakZ2/LvJBZHqIGnCv5coKj49ctC7X1nV6qTORrnHhB
         /0i2HsVIINP6DJja6ceIJne9u9IbUHqH9AnfoJiMjA4NT/pfLcBFRRodfiNOLQ3O8HWJ
         cspOiC63IHD4hWkP/uWDFiuDS91EL+M/4rDdH7MBToRo2lHLsvv74afaD8QRnkNjvwch
         2hhu0Tqhxo+OFanAcGnvWr+iQlEy+SlmHvmBa1R/Gc/8/JRqAfmdrKTnaFUT+YkJzhoM
         A/KU2Bvb9GcmlKch1HiIrYosgAokehWuSGLtbDbROOZEy98+gCySJdbGSF2qY/JX1z6/
         g4fQ==
X-Gm-Message-State: ABy/qLZmtB8YK7QnZ+aGRFymuNL6i7HFhEdp/0ctSDbcvWsj4wYPd0RN
        SGvYqQWqr6K/8Ba9Q8tJWzIuSg==
X-Google-Smtp-Source: APBJJlHxQZeso3Ce5snQYO18JDiDnjDDsD9NlH8hQO3bcs+U0hcwKO22ylgUQNNAOIQi7NUacJupkA==
X-Received: by 2002:a05:600c:ac6:b0:3fc:5606:c243 with SMTP id c6-20020a05600c0ac600b003fc5606c243mr944572wmr.13.1689928501284;
        Fri, 21 Jul 2023 01:35:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x2-20020adff642000000b0031444673643sm3512256wrp.57.2023.07.21.01.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:35:00 -0700 (PDT)
Message-ID: <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org>
Date:   Fri, 21 Jul 2023 10:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, will@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de, peterz@infradead.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Nick Hu <nick.hu@sifive.com>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720135125.21240-2-eric.lin@sifive.com>
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

On 20/07/2023 15:51, Eric Lin wrote:
> This add YAML DT binding documentation for SiFive Private L2
> cache controller
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>


...

> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,pl2cache1

I still have doubts that it is not used in any SoC. This is what you
said last time: "is not part of any SoC."
If not part of any SoC, then where is it? Why are you adding it to the
kernel?



> +      - const: cache
> +
> +  cache-block-size: true
> +  cache-level: true
> +  cache-sets: true
> +  cache-size: true
> +  cache-unified: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  next-level-cache: true
> +
> +required:
> +  - compatible
> +  - cache-block-size
> +  - cache-level
> +  - cache-sets
> +  - cache-size
> +  - cache-unified
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cache-controller@10104000 {
> +        compatible = "sifive,pl2cache1","cache";

Missing space.

> +        cache-block-size = <64>;
> +        cache-level = <2>;
> +        cache-sets = <512>;
> +        cache-size = <262144>;
> +        cache-unified;
> +        reg = <0x10104000 0x4000>;

reg is after compatible.

> +        next-level-cache = <&L4>;
> +    };

Best regards,
Krzysztof

