Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D377AC3F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjIWReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:34:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E741100
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:34:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32008e339adso3758966f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695490450; x=1696095250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8e4WOeV3uP0Avl4Q9o2tfB8fRCYhZPCMlDY4X+oryg=;
        b=qXuhAV2rOIAwHcKLt/EiVugltt9sNos2IzIFcYeAKX3zpewWJrXsbVE/SdhwpHRKkW
         6XeV8nszUQ7HMQxkJNcgDtVge9iY3/8tnsKXYInX7xWT+l9jibsh1+FJCVoGdUBUGf7J
         JDAanN4S5th2E1KqzI/CrURkOqfpLcECgbpWByv9uRygaRAu0wqra5sEx2PU4TFt1bnP
         CxnvacEbrxNAOQL4SWs0+CXA0nbYFjz1Y6nYIvJv3iRn1OMiLKP2HLGxKRgorLe8KNIP
         YWsAOcrnUd0UtpBs4dXHrmMR24wP4P5iA6Nr6su6t2TmJoHEqD/WmUIxHyy4qIFR3hpS
         d97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695490450; x=1696095250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8e4WOeV3uP0Avl4Q9o2tfB8fRCYhZPCMlDY4X+oryg=;
        b=Mv58Sd+yADp/EythfxG9DcRR77Cz3N+QBwjl+AYMXXTl/nAB8RXMgiAnLBWk6Rup0f
         /h/m7Vpfq2wSZpUiV4G+VJ0QPKp4EgSQVXsmtgpuRlOQfR9ZQa7WokUR3pTezkqwCsvM
         TKbc0LSGyqGvA8uh3I9EZ7vM4r6p90fTkwwhlLgL8pIXAItmkpRYsV4fJfJyHmHFxBlz
         5UnSw8Nmy9kuiOZw5MsnJZX1d2MQpPht9ya+ykxRsHd4s6GcFze7WXLuODAUPsivkykG
         lfPPffVfA/5bHtjKsiDB9b6IaMcEOVD6Ks+CkpJg9oTT+V20Mhu25s+5+Fu3gpAU0ZMt
         Tzww==
X-Gm-Message-State: AOJu0YwQhw2dmNhLcgG45RdSmXuerU2BsL8/bOlPohvxhwWAZm2GYieL
        Z/SlS4+PH7kHkUKXEnWm5QEYZQ==
X-Google-Smtp-Source: AGHT+IGywFoLRHTpFCviFneYTV3hIVt1uqS6WEMAUjyo6HuW9R7DnOeXATYbyZiXoF0+vDPukj7PRg==
X-Received: by 2002:a5d:44ca:0:b0:31f:fdd8:7d56 with SMTP id z10-20020a5d44ca000000b0031ffdd87d56mr2347231wrr.12.1695490450364;
        Sat, 23 Sep 2023 10:34:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b00321673de0d7sm7374280wrw.25.2023.09.23.10.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 10:34:09 -0700 (PDT)
Message-ID: <948a37c4-2237-8ec8-270d-8a704c8c4835@linaro.org>
Date:   Sat, 23 Sep 2023 19:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 10/16] dt-bindings: media: mediatek: mdp3: add
 component TDSHP for MT8195
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-11-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230922072116.11009-11-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 09:21, Moudy Ho wrote:
> Add the fundamental hardware configuration of component TDSHP,
> which is controlled by MDP3 on MT8195.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-tdshp.yaml   | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
> new file mode 100644
> index 000000000000..0ac904cbc2c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-tdshp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Media Data Path 3 TDSHP
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Moudy Ho <moudy.ho@mediatek.com>
> +
> +description:
> +  One of Media Data Path 3 (MDP3) components used to improve image
> +  sharpness and contrast.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-mdp3-tdshp
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of display function block to be set by gce. There are 4 arguments,
> +      such as gce node, subsys id, offset and register size. The subsys id that is
> +      mapping to the register of display function blocks is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1

NAK. So you ignored all the review. Brilliant.

I am getting fed up with Mediatek's approach. It's not the first time.

Best regards,
Krzysztof

