Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD24758E38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGSG6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGSG6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:58:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95736197
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:58:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991da766865so895342166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689749897; x=1692341897;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiQ1ya2Vx/jvZEdWpDejEV/ueqVWa0CUVCzYMuLpt3A=;
        b=ih2pfbdbHahkCjOs6AGDGXaKH2QHQeoM4569JR82H8ay75NwvkFSKO9x0g/lW87nVN
         Zw3o2JHEeBXn5eKaFj7J3wKwfefJBXWIQ9WS1GD8CjF69diQkyx8UbMvSGzI4XHbAJT6
         oJuZxxyxlCivu7gJ66knmDOeZ5blHGfX4mZA+r0I506ypPh4XzqqKDaygLwuoADFaGzo
         mJKWNB3xNxVgISqvzYONh+l0JMSj7zlY2pSPdNIxPZebTcy/KWq7m1Inl1P+SeWvDzV9
         cZmTvSWbq+T+5I6TsybJd3rCrUhe6JQnGLfv/iW5FspFfpypr5HMxYhxv/c4aSJNckve
         v9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749897; x=1692341897;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiQ1ya2Vx/jvZEdWpDejEV/ueqVWa0CUVCzYMuLpt3A=;
        b=ONIP/cE/2JGpTApV7m+FD29mOJ8Qeu+QzYQmyXtQ85oW6F/MX4aiuqKm7aur5ZY4i+
         ZH2XiYHFiJBy66HHreYY2Xn/R4Z9u0pYzotsTWwR3uNegFxhxJzt4N+Eh5SBZqLCkno5
         S8LL94t7QEavKyQBkFDEMAyulRoq53Zwm25hsC6Qs7/zcvu4QyRtLHlkTJWwMY/cmTo+
         Pbbb+1bqUHEhUW4n34g9A9IqdUpoQcGNK9Wwj7OBipUFjEu4lxEpuRYAIOp3ozdXeeDC
         OZBx0MIhyMSMn1SqNOGgelHTR5Yhehk4oG/e2IeLm6IvHzgjwKMFRM2/SMI/W8wCGcTI
         xkrQ==
X-Gm-Message-State: ABy/qLYMT2x+j2+o373WG69c7fRtUbT3qNuZrklZKx/RFWSNtneMXSwq
        QMBLDCdO9lZ5rcJ6MbTGCj4/WQ==
X-Google-Smtp-Source: APBJJlE5ZgBavnvlZCV3/u4bBdrjFGWaL2d7i/P3Md+EUmM54ETrgEpbPWbD7g1htS6tzyI3vE71KA==
X-Received: by 2002:a17:906:739b:b0:993:ffcb:ad55 with SMTP id f27-20020a170906739b00b00993ffcbad55mr1645449ejl.9.1689749896922;
        Tue, 18 Jul 2023 23:58:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b009925cbafeaasm1909898ejb.100.2023.07.18.23.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:58:16 -0700 (PDT)
Message-ID: <2a4bca2f-15e5-1705-b6d2-8c250bf470ea@linaro.org>
Date:   Wed, 19 Jul 2023 08:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <cover.1689714290.git.daniel@makrotopia.org>
 <584b459ebb0a74a2ce6ca661f1148f59b9014667.1689714291.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <584b459ebb0a74a2ce6ca661f1148f59b9014667.1689714291.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 23:30, Daniel Golle wrote:
> Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> 10 Gigabit/sec supported by 2 packet processor engines for
> offloading tasks.
> The first MAC is hard-wired to a built-in switch which exposes
> four 1000Base-T PHYs as user ports.
> It also comes with built-in 2500Base-T PHY which can be used
> with the 2nd GMAC.
> The 2nd and 3rd GMAC can be connected to external PHYs or provide
> SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> 5GBase-KR or 10GBase-KR.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 74 +++++++++++++++++--
>  1 file changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index 38aa3d97ee234..ae2062f3c1833 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -24,6 +24,7 @@ properties:
>        - mediatek,mt7629-eth
>        - mediatek,mt7981-eth
>        - mediatek,mt7986-eth
> +      - mediatek,mt7988-eth
>        - ralink,rt5350-eth
>  
>    reg:
> @@ -61,6 +62,12 @@ properties:
>        Phandle to the mediatek hifsys controller used to provide various clocks
>        and reset to the system.
>  
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon node that handles the path from GMAC to
> +      PHY variants.
> +
>    mediatek,sgmiisys:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1
> @@ -229,11 +236,7 @@ allOf:
>              - const: sgmii_ck
>              - const: eth2pll
>  
> -        mediatek,infracfg:
> -          $ref: /schemas/types.yaml#/definitions/phandle
> -          description:
> -            Phandle to the syscon node that handles the path from GMAC to
> -            PHY variants.
> +        mediatek,infracfg: true

Did it mean that it was defined only here? Then this "true" is not
really needed.

You should however disallow it ("false") in other variants).



Best regards,
Krzysztof

