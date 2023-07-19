Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260E8758E97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGSHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGSHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:16:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD01FF1;
        Wed, 19 Jul 2023 00:15:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C08E56606F57;
        Wed, 19 Jul 2023 08:15:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689750954;
        bh=iewCcJUfElKKyjKf+NtkxBXYK+aTi5ddhmCEGbtXwRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CM02QOPvcLxFcvDvKyuF+x7VBYLxDtdnZm3Em+Bksi1sPDcNkt/XxQZ4hiJR7jRqy
         TkKx+HXvjGq/V1CIeYfoyQbKbAe57STrM6IeCXHpu45xzhJRic4prMgktjJewSYRTa
         LKMOS2vo8jeQby3ka1XLMt/D004KpXLXiBrFEmnvr9gBiv8KlM0U9e48FmLJlTHAOL
         DrcgsmaS7mbINDeUziq/ecF1pL0HkU2u5VS+76uzig/1Pf007F4ndac0eajmEj9M1i
         3pV66jrFxzVUYxUxoYrCCQYMz723TP8lVwRF8s+/wnm3RpVlo0Oush32HclBZ+iFSr
         L6tkPq7uOnayw==
Message-ID: <ae40d54a-1599-a954-b18f-263196766a2d@collabora.com>
Date:   Wed, 19 Jul 2023 09:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/4] dt-bindings: soc: mediatek: pwrap: Modify
 compatible for MT8188
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230718110947.13426-1-jason-ch.chen@mediatek.com>
 <20230718110947.13426-4-jason-ch.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230718110947.13426-4-jason-ch.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 18/07/23 13:09, Jason-ch Chen ha scritto:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> The reason for changing the patch was that while MT8188 uses the same
> pwrap as MT8195, the original code was only applicable to 'compatible =
> "mediatek,mt8188-pwrap"'. To resolve the DTBS check warning that
> '['mediatek,mt8188-pwrap', 'mediatek,mt8195-pwrap', 'syscon'] is too
> long', it is necessary to modify the code.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>

The original binding allowed only "mediatek,mt8188-pwrap", while we need
to specify

compatible = "mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap", "syscon";

for this node, as MT8188's PWRAP is fully compatible with MT8195 as it is
the very same IP, hence:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo

> ---
>   .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml    | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> index a06ac2177444..4737e5f45d54 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -41,7 +41,6 @@ properties:
>                 - mediatek,mt8173-pwrap
>                 - mediatek,mt8183-pwrap
>                 - mediatek,mt8186-pwrap
> -              - mediatek,mt8188-pwrap
>                 - mediatek,mt8195-pwrap
>                 - mediatek,mt8365-pwrap
>                 - mediatek,mt8516-pwrap
> @@ -50,6 +49,11 @@ properties:
>                 - mediatek,mt8186-pwrap
>                 - mediatek,mt8195-pwrap
>             - const: syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pwrap
> +          - const: mediatek,mt8195-pwrap
> +          - const: syscon
>   
>     reg:
>       minItems: 1


