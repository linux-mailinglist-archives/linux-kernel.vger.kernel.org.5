Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012BC79D3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjILOgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjILOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:36:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58B10D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:36:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-403004a96a4so36667865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694529364; x=1695134164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63a3mA2Gm93WC1jW1PtjeC3GrBOcYzQQqgqOV2oqNY4=;
        b=HVjTcT7OXvtQSSe8V4QL6NgTx9fu8c9ZiP9LkPA1yrUk2vK4Nmlq1+frxTrHp152XK
         V0BhDhsiyoJ7sTcgvh5FhB0A1JuidC2ZEhVi9yYIUfSdErUaMQO7d3NHiuXRRi38vByX
         YFIqI473wuDMVl0iJiaX8rBEu7Nny320P6SY9nLP6wCN8AdEaPBb2k30SpxCMhsX/VX5
         M0b0gw54qkoGtBruRxPXSSl5TfY0gHew8kJCnFcCo3JwNXahMzImXXb+gmwhZIstcQwH
         lupwU85hLsZI/9xDKyRw1xmp5ajtjIK4HdHTQc1QSzSwes7RxMCtk2pbralDynfdE4L5
         kZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529364; x=1695134164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63a3mA2Gm93WC1jW1PtjeC3GrBOcYzQQqgqOV2oqNY4=;
        b=vuZzZ97A2IaRcPKq+DKnshCsoEZy+cJ8ZxBESNt9ptqoyz8qdq7lgDWN1u05c5DIcr
         62zaS9Uop1XS9Ya1Egcl8WPQU5hgXrRb7DWSH8kaZAifrm0dTt2dkVFXlLvoElDl7gGh
         HnEex66sIsbUGN7xs5PBRnDIGSLOelA2pu3JcW/MvsMIjX+ADTU9+6bHunMkOqBTRCFQ
         N4v4BEPRrnnGbzvbr3hvLnIpv5TMksI4YMkRTJmvbltTdLZrcilQsMtczxJaSh8y8NRG
         hBwZrP9BCIdWdO962S/qyknCvxISCL2GJ8AsVSeluf+RsiPTao/ka0USEIrXwNZpfMmA
         O/mw==
X-Gm-Message-State: AOJu0YyhxbgDjoDlJWn8gwYRzFs3jNQqXvXvrDnesiIB59bkwvquhBAg
        BNmWzk7K9rcwZmOlGhWAyWg/Tw==
X-Google-Smtp-Source: AGHT+IE7WN5e4H2gz+JyHLx0OAeAEwbWuRgiz9o8yiPITiOChVzW8ZB+w6eNBncRVidGP784GMnbGQ==
X-Received: by 2002:a05:600c:2205:b0:3ff:cadd:329b with SMTP id z5-20020a05600c220500b003ffcadd329bmr12297748wml.31.1694529363781;
        Tue, 12 Sep 2023 07:36:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id p7-20020a1c7407000000b003fe23b10fdfsm16254627wmc.36.2023.09.12.07.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 07:36:03 -0700 (PDT)
Message-ID: <8404a761-8d13-e2c7-1655-e465377867c4@linaro.org>
Date:   Tue, 12 Sep 2023 16:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
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
References: <20230911115717.26184-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911115717.26184-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 13:57, Macpaul Lin wrote:
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
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Changes for v2:
>  - add more detail description for mt8395.
>  - add bindings for mt8395, and mt8395-evk.
> 
> Changes for v3:
>  - add back bindings for mt8195 compatible.
> 
> Changes for v4:
> Changes for v5:
> Changes for v6:
>  - No change, update Reviewed-by tag only. Thanks.
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index ae12b1cab9fb..2e8ad49c3479 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -248,6 +248,12 @@ properties:
>            - enum:
>                - mediatek,mt8365-evk
>            - const: mediatek,mt8365
> +      - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)

Drop description. This is an entry for multiple boards, not only for
this one.

Best regards,
Krzysztof

