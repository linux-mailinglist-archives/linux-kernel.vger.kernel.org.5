Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCF7823AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHUGXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjHUGXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:23:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CEFA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:23:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso388360666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692598981; x=1693203781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcCNA6Gfamy94/pLxijVh0qctBGX2/2bPxB/4YNlhrY=;
        b=MWto6spuOBnOh8QA0ql8wvzvvCrNr6DVv1N3pl6egZdE3UBfK/YKmcvtP0NCLkRWOt
         7tVWzFoXA+rUKLR1P2kkAQ/P1zljLzJIJREw0kVIAEofLZ7eYNMlJjCDEMvkeWG7MWAl
         OUofupmN7uR55nG0mY3d0gqk6v6/5F4JtfB2LM+AmsuuQr+vTheSuewniR3Ztsrju7ag
         ZJwxa6yBbGViuIxEEaMs4dU2+4McVT/qSAMnuid4pmi/t4J3ERIYZ/kXM9WX8jNWGPyy
         IVfljFeqVXapoJM5EkfgleGUbH73V1lJhZ0eQmudbUzWIucf/t7tPtYUjII9v2xTKPtP
         nmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692598981; x=1693203781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcCNA6Gfamy94/pLxijVh0qctBGX2/2bPxB/4YNlhrY=;
        b=MMRuOMpAG8Pc19qu7UbKtGCvekdwfw/pfj5G72ouhRXHp/x8ckguLGChmHH/UWoU8O
         K3EYxcvqq/V8PDmHNhr8FScDomE60rSvPuNFTIurwdB3tLCZSZP8Wp5sRZAXFLu25U6+
         iA0PPm8wrQdlqhhLZ/l5kfXJ1DMz5KWpzt89H0iJD+XCUA1vtxXPShzKd8zhGVvBnW8c
         WQGwnoD4FzdwXT5vZFCKFyRZyS1cnwr4jcvhHCG36C8uud2gZqF8mVZR2xtVwxw5J9qC
         z0RAlikzmIyet7uvZ/NB7DRVCjOZ+szfPHq8gOr1YdagGFoBWEe8lt8FtkC4JBK7oY+A
         QDrw==
X-Gm-Message-State: AOJu0Yz0zMrA86zmKVDIwO6evWTTvm+DypkzaQUn4Z51+/3Pi8iSb96o
        1wbIYdRBmCRjeSWn55FcPbuycA==
X-Google-Smtp-Source: AGHT+IEYVmZ6aoUBBlNkEHfxtQ+b+xqMdy9bNDFQoDfMSE4A8BLuV0STpbMFSDD76wDRmJyL8evZhg==
X-Received: by 2002:a17:906:20de:b0:99e:f3c:2249 with SMTP id c30-20020a17090620de00b0099e0f3c2249mr4087672ejc.71.1692598980839;
        Sun, 20 Aug 2023 23:23:00 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709064f1000b0099297c99314sm5028208eju.113.2023.08.20.23.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:23:00 -0700 (PDT)
Message-ID: <3a413a63-4e07-94ff-4e49-da7b1e3dd613@linaro.org>
Date:   Mon, 21 Aug 2023 08:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: snps,dwmac: allow
 dwmac-3.70a to set pbl properties
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230820120213.2054-1-jszhang@kernel.org>
 <20230820120213.2054-2-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230820120213.2054-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 14:02, Jisheng Zhang wrote:
> snps dwmac 3.70a also supports setting pbl related properties, such as
> "snps,pbl", "snps,txpbl", "snps,rxpbl" and "snps,no-pbl-x8".
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index a916701474dc..7626289157df 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -659,6 +659,7 @@ allOf:
>                - qcom,sa8775p-ethqos
>                - qcom,sc8280xp-ethqos
>                - snps,dwmac-3.50a
> +              - snps,dwmac-3.70a

You might need to rebase your patch, because line number is quite
different, but anyway looks fine:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

