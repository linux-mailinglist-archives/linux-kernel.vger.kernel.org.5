Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E931D79BA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348914AbjIKVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbjIKJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:49:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF6E40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11393220a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425759; x=1695030559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyK3BidgXxixuZrAM9KK/EHXaa+kHXgf2/8oda8qsKE=;
        b=iLAiwuDSCvts7mrGqXO1HaN3T/wHAR/hA+uqQL3szngNPoLaVp4X5GVvCfZUB78laM
         hCR353TtOAC2dNHRiSOd3348PfwYSA3d2bc9SL2jxyMcosI9AIFyvEhcneC3hsv+TdeZ
         zZwToAZbAzfMVkJFX0FfAoaQ1S9lD6OS7wbq2Bi1sVgZhdsL3ozGN1MrJ6JI9zbb6IUv
         04o/68DEsdqz1+56HibXC2b136fRi4wVYBoasmsLLmMJsvF3T2M3gQPWIHMW7Ibz8nlz
         6quejvSm8kUeXVd9EDh9VLH0aY1OoosML6T9LddzomOH+UMMzrjFMThxmzxDI0fSPMfA
         32Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425759; x=1695030559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyK3BidgXxixuZrAM9KK/EHXaa+kHXgf2/8oda8qsKE=;
        b=b0zzUslRf4CmpxTE2ZrTU3vd+UDOX7BYumPTwOn1fVPwIUh7k+z8I8VyWnRRBuKPUq
         rW34r7j8WB1vus76+b2fRS5nvkTnTynn3g4uStY2ShiqKPh+gVgWgR2tTQRk9fb59zh9
         /x8E7ZQLdTrTTrAzxbqtJwjZ/aEbvlGjPdLVPfJqR4zFx++Bt6c9EpGHxWtL6Ft74iMM
         eriBrROQbT8O8Vcwl8K6cfR3aNxvGdRlFIACAreMFUGKQjWeyQOczCM4Bkr2Lp8ekkTr
         qaXwzkC6eovUAxtRc3aAAPFSrkr2OoAiF7aMlE5bY8kceIC3UHY8V0wwjGA9xx7IdKwG
         lPPg==
X-Gm-Message-State: AOJu0YwU1iErF/OA5lxuTiRsiS5s6zLpgYbvukI3aonckT4YTKD5Aofv
        dsdEoK3IbCyG65K7g7nWiaXXgw==
X-Google-Smtp-Source: AGHT+IF0eAg3rbqM0cYf1GKEx/klkn6QYNhBM5luwQhzQPxpsJHoR2ZDxfOVJVSwtzNPJyCgxfVVkg==
X-Received: by 2002:a17:906:32c3:b0:9a1:b33a:e464 with SMTP id k3-20020a17090632c300b009a1b33ae464mr14227042ejk.31.1694425759428;
        Mon, 11 Sep 2023 02:49:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709060e0f00b0099bcd1fa5b0sm5067137eji.192.2023.09.11.02.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:49:18 -0700 (PDT)
Message-ID: <53cd72f7-5a8d-ee9e-4d8a-f5159cafb3e7@linaro.org>
Date:   Mon, 11 Sep 2023 11:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] dt-bindings: arm64: dts: mediatek: add description for
 mt8365-evk board
Content-Language: en-US
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
References: <20230911081126.18463-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911081126.18463-1-macpaul.lin@mediatek.com>
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

On 11/09/2023 10:11, Macpaul Lin wrote:
> Fix the missing description for MediaTek mt8365-evk board.
> 
> Fixes: 4f5fc078ac6f ("dt-bindings: arm64: dts: mediatek: Add mt8365-evk board")

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> change for v2:
>  - rebase this patch to follow the v5 patch set of mt8395.
>   - depends on https://lore.kernel.org/lkml/20230909132819.21626-2-macpaul.lin@mediatek.com/T/
>  - Fix description as a single board.
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 2e8ad49c3479..b163995e32d5 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -244,7 +244,8 @@ properties:
>            - enum:
>                - mediatek,mt8183-pumpkin
>            - const: mediatek,mt8183
> -      - items:
> +      - description: MediaTek Genio 350 Board (Genio 350 EVK)

Drop, no need, redundant (copies the compatible) and your other entries
do not have it.

> +        items:
>            - enum:

This is still confusing. Why do you have enum here with such description.


Best regards,
Krzysztof

