Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5570C793857
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbjIFJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbjIFJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2551982
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:32:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso154972866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693992769; x=1694597569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RFjlJFCPC0cFB7nl+UKfpa8lGL9BW79DIGhjR08yhs=;
        b=gyzKwJveAEVFe0cbGdFaCQyJshgoim0oyRczPdJy2pnwBRIKKwWWuCJMFxnYXeruQ1
         bjAWiKfvyaJU5Bpw5xWQ6SBxuNE9DWOH/kV061icmq76ZPS+nu7iW9zKBMuM4tHBWsjl
         g4lkwWIkzwaSuPUM+8cTzm/iCfNa6UGwJLIyY8EafSJxNRXtBUkDc7nWss/I7P5Z13WO
         LS/0fiyfQTN/pyDXSKAWjpTJBr/JwCaop1CKziPeOxN8Mz7Iq62nDdoJ0Npn4irOo+sq
         Pw3CZnObd1a28ISoaatiMwPevAdxVoe9zJyoHSGSDEFypdRudPm3ftyOrh0OnA+25LLu
         tw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992769; x=1694597569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RFjlJFCPC0cFB7nl+UKfpa8lGL9BW79DIGhjR08yhs=;
        b=bbgVxX56e3LAL7djlsTO2ukDIOlq19mMgHJ+zMvlZ8xl7xl/rGx9ne6huqUUx89N3s
         zy9X7FfJUs5D3XXT9W9Mxzp8j6T6VX/pMUeOt9DqFQ4Yxn/MsMV+zgM7od5jHGG7jXLw
         faRa0loq2k6BbLKTy1S48CL68kqDhMyM0wXfZMau/Xjex4s6pUoZbbThrvu6/ExeExA1
         b7Mwf+ta7J8d4dzCe64YdnxF0yF1S1NKVC+RMDiff36ih2wsHDS8nM9aMe/Grf5ReSk5
         eZ7Kidug7G7ZdWxnqX8hhvc+9pUOq6DjsbNO0t4Wlpr5SpMZTlfEMi3ODg6HQglS9gfk
         sy0A==
X-Gm-Message-State: AOJu0YzG23XIkeMflLWWKHvYKUupPe2kvzIAnRjY3Z7HCQ2i2MZCmYOs
        CpI9Tej93Z2I+y8AttWIIQ40Ng==
X-Google-Smtp-Source: AGHT+IFH22HeZBUv9SCW8pQB0gqyGQb79qyXqVsMorJy10kXv88hv5Dm8psdOKRk4xCU6hyl04lIyQ==
X-Received: by 2002:a17:906:738f:b0:99c:5056:4e31 with SMTP id f15-20020a170906738f00b0099c50564e31mr2404848ejl.15.1693992769275;
        Wed, 06 Sep 2023 02:32:49 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b0099cc3c7ace2sm8901841ejj.140.2023.09.06.02.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:32:48 -0700 (PDT)
Message-ID: <fbad941f-232b-9f56-5de3-98a16a8c4d89@linaro.org>
Date:   Wed, 6 Sep 2023 11:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906092527.18281-1-macpaul.lin@mediatek.com>
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

On 06/09/2023 11:25, Macpaul Lin wrote:
> 1. Add compatible for MT8395.
> 2. Add bindings for the MediaTek mt8395-evk board, also known
> as the "Genio 1200-EVK".
> 
> The MT8195 and MT8395 belong to the same SoC family,
> with only minor differences in their physical characteristics.
> They utilize unique efuse values for differentiation.
> 
> The booting process and configurations are managed by boot
> loaders, firmware, and TF-A. Consequently, the part numbers
> and procurement channels vary.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> Changes for v2:
>  - add more detail description for mt8395.
>  - add bindings for mt8395, and mt8395-evk.
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index ae12b1cab9fb..d7a20df640d7 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -248,6 +248,11 @@ properties:
>            - enum:
>                - mediatek,mt8365-evk
>            - const: mediatek,mt8365
> +      - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)
> +        items:
> +          - enum:
> +              - mediatek,mt8395-evk
> +          - const: mediatek,mt8395


I don't understand. You said last time this is fully compatible with
mt8195, so why it's not here?


Best regards,
Krzysztof

