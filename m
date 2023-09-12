Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF16D79C953
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjILIIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjILIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:08:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7971712
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:08:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso6797761a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506098; x=1695110898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qZAQL11LZbXLvA1F+aakZmt21/i5A/PMcXmHMfBllE=;
        b=batt84eE6GM1IZEG8vEO2bnhQKRz+94B25oP27lyEs/zgqG5sEQXVsRPc8gllNTHuv
         z8vPJXeB2t5pEBTTF9K+LBaO9QmYbbPG3MXrvFDTkKn5bAiBTntsYrRx9UW6xazDabOJ
         uqjQ8ype7EybHdOZqcBOyVvuIvOWoE1O9DRZxfDm2UXFFIZ1g/HsguZsAtnMfMd8SD1g
         YAWo5Lem3id+C3Rqp6uMGnfikSRuSKuVoZB8X6AgjiAyBbwEze8Cy5/aaGicfe/jZ9Jx
         /+pQZTXl5/iCeIuPhUGq5QZwuJ2fW2THopd1ZmmQQZRqTbVyKYJdDgN/+PdF/HNH5a8c
         UvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506098; x=1695110898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qZAQL11LZbXLvA1F+aakZmt21/i5A/PMcXmHMfBllE=;
        b=WB4aSUODNOEl2fEBgipIwdM0T57W2EG6W+SdeQIpURCnpDqczGn2/6UwX6S3VvCHS9
         PUjjwt6OkqFiVLZEkNLGTBrOwLelsnuMFDMYw7nRTUZEqh5CaTZgnbdNWUsM6387ejog
         bQrhnGTovO/TS4xaDoCd7sr9CkXwOnjB4p2yF+JDi0tJXHS+b74+79Qkkb/CwvpVFROP
         gH3s1tGAsOgYAH0P6GBzAjvQrFNe2S3VfJm+wC2xqVMkIF4Fh/8LWUXer5RLWSbk6KIr
         Wtpm0GKTFp/lZvgQqZOsB/R3Rrel+OEGQDIuELkDsDT1e/O9Aq2/sGFAGqayyzazm0Da
         wlDw==
X-Gm-Message-State: AOJu0YxDNFHluT4BezQRX0C/voa8eC4XlUZlCTYG8A0cvPznYZyw27CB
        76l+sbrrsfXjwJxBU8lZRhDJWA==
X-Google-Smtp-Source: AGHT+IERPYwxvwxrtf7aXRvsNUYm+bKG63mo/Pw4/zuNJCPNP2RmbDeOAL+MxTrWlizGiTHGdWSVUg==
X-Received: by 2002:a17:906:328b:b0:9a9:ff11:9c60 with SMTP id 11-20020a170906328b00b009a9ff119c60mr8680971ejw.48.1694506097766;
        Tue, 12 Sep 2023 01:08:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b0099364d9f0e6sm6416648ejb.117.2023.09.12.01.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:08:17 -0700 (PDT)
Message-ID: <22805138-e42a-cdd0-bc96-5281f0e2c586@linaro.org>
Date:   Tue, 12 Sep 2023 10:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm64: dts: mediatek: mt8365-evk:
 update compatible
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230912072340.22862-1-macpaul.lin@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912072340.22862-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 09:23, Macpaul Lin wrote:
> Fix compatible of 'mediatek,mt8365-evk' from 'enum' to 'const'.

What is there to fix? There is no bug... please describe why you are
doing changes.

> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> change for v2:
>  - rebase this patch to follow the v5 patch set of mt8395.
>   - depends on https://lore.kernel.org/lkml/20230909132819.21626-2-macpaul.lin@mediatek.com/T/
>  - Fix description as a single board.
> 
> changes for v3:
>  - rebase this patch to follow the v6 patch set of mt8395.
>   - depends on https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
>  - drop "Fixes:" tag in commit message.
>  - drop platform description update for mt8365-evk (Genio 350-EVK).
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 2e8ad49c3479..bab4fa0e8199 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -245,7 +245,7 @@ properties:
>                - mediatek,mt8183-pumpkin
>            - const: mediatek,mt8183
>        - items:
> -          - enum:
> +          - const:

Obviously this was not tested... Please test before sending.

Best regards,
Krzysztof

