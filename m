Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852677A620
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHMLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:15:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15031E71;
        Sun, 13 Aug 2023 04:15:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso453107666b.1;
        Sun, 13 Aug 2023 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691925339; x=1692530139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffQwIT8DtQciacgmcGYmh0gcVi8vW0sLMlcRipYUMb0=;
        b=lv+4s+abJJwmmA2QoTwzpHZqaGoE2Yx5q0hKU0hCe8ogbB3gAwMna3KPgse6NS2xb1
         eZ0Tt/z1tA9YMmPcqp1Sc7BGWBE7v9XIbBMcmQ7LIV3rZKZL7YObIo3IHn083S0G3Y5e
         zwOyOpUABJ+N48A1Utcrk7xpfR+QTjN/A6T6tC1U2v+Ardn3F6ZwxUZBSmby2PJcmYSh
         Ba3TxtfAEuD76QhCda2K/l49ES8jyAZ2+Mf0K/GGe1sdFDaSFrGRgKQs3dLyTp+sWgSs
         pZJrFyQYLwxxqB9bHolzDjAnQ2uRDf3HnYmqSGdhRqbd9mF713kBohK/zye1L0D57yKC
         Xmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691925339; x=1692530139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffQwIT8DtQciacgmcGYmh0gcVi8vW0sLMlcRipYUMb0=;
        b=H8wBHalrOulXsQBBYESlO7XqHcddyEo4poF002xcmfC2DxEiE23XRo60Q2Uh1sgK6C
         VQl5kDTeJHgWrXi0Qf5VYsFSiCHT8x6wMgFSq/LnCo3+3lf2Dr6lOcqw/tgX23+E5mEj
         OKrTiAnsVSssr+yUZArUndcSYMeQsko9VHFScBnwk4udJ0yJi1J4XTV1qWFTdeq6gkNC
         BDM3QDYmgOfOvU7Qm6ouUkl7cwfdcpPt/ELJkJBddrhaqUPunaoTkbqM15W8mIljTngG
         CadO9XzUHEuaTJr5wjh2G3dnUas5pTUVn6f/iHofd/qS40dDgUoihmulMv6AUaFNmLYe
         EJxg==
X-Gm-Message-State: AOJu0YzJ/PG/Oq3aqiCQaIAr4X+d1uADxRx8sfz4u6uZB1ceWW/2/Bif
        FxHUb2yicD0I+0EnhCMknxU=
X-Google-Smtp-Source: AGHT+IHbnnUzjq58IVRQ5OmTqhgJH3jrLO72zDiXsRXFG194sdp3hZNNtscLtOLq+nFZ5yAA6LXkOQ==
X-Received: by 2002:a17:907:7886:b0:994:54af:e282 with SMTP id ku6-20020a170907788600b0099454afe282mr6411319ejc.10.1691925339304;
        Sun, 13 Aug 2023 04:15:39 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm4474034ejq.190.2023.08.13.04.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 04:15:38 -0700 (PDT)
Date:   Sun, 13 Aug 2023 14:15:36 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230813111536.xzmxytghjzxhzmq7@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230812091708.34665-3-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:17:06PM +0300, Arınç ÜNAL wrote:
> Add the schema to document the internal MDIO bus. Adjust realtek.yaml
> accordingly.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/net/dsa/dsa.yaml      | 18 +++++
>  .../devicetree/bindings/net/dsa/realtek.yaml  | 66 +++++++++----------
>  2 files changed, 50 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> index ec74a660beda..03ccedbc49dc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> @@ -31,6 +31,24 @@ properties:
>        (single device hanging off a CPU port) must not specify this property
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>  
> +  mdio:
> +    description: The internal MDIO bus of the switch
> +    $ref: /schemas/net/mdio.yaml#
> +
> +if:
> +  required: [ mdio ]
> +then:
> +  patternProperties:
> +    "^(ethernet-)?ports$":
> +      patternProperties:
> +        "^(ethernet-)?port@[0-9]+$":
> +          if:
> +            not:
> +              required: [ ethernet ]

To match only on user ports, this must also exclude DSA ports ("required: [ link ]").

> +          then:
> +            required:
> +              - phy-handle

No. The only thing permitted by the slave_mii_bus is to do something meaningful
when phylink bindings ("phy-handle", "fixed-link" or "managed") are absent. But
the presence of slave_mii_bus does not imply that user ports have a required
phy-handle. They might be SerDes ports or xMII ports. So they might use "managed"
or "fixed-link". The only thing that you can enforce is that, if the slave_mii_bus
has an OF presence, then user ports must have phylink bindings.

> +
>  additionalProperties: true
>  
>  $defs:
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index cfd69c2604ea..ea7db0890abc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Realtek switches for unmanaged switches
>  
> -allOf:
> -  - $ref: dsa.yaml#/$defs/ethernet-ports
> -
>  maintainers:
>    - Linus Walleij <linus.walleij@linaro.org>
>  
> @@ -95,37 +92,38 @@ properties:
>        - '#address-cells'
>        - '#interrupt-cells'
>  
> -  mdio:
> -    $ref: /schemas/net/mdio.yaml#
> -    unevaluatedProperties: false
> -
> -    properties:
> -      compatible:
> -        const: realtek,smi-mdio
> -
> -if:
> -  required:
> -    - reg
> -
> -then:
> -  $ref: /schemas/spi/spi-peripheral-props.yaml#
> -  not:
> -    required:
> -      - mdc-gpios
> -      - mdio-gpios
> -      - mdio
> -
> -  properties:
> -    mdc-gpios: false
> -    mdio-gpios: false
> -    mdio: false
> -
> -else:
> -  required:
> -    - mdc-gpios
> -    - mdio-gpios
> -    - mdio
> -    - reset-gpios
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +  - if:
> +      required: [ mdio ]
> +    then:
> +      properties:
> +        mdio:
> +          properties:
> +            compatible:
> +              const: realtek,smi-mdio
> +
> +  - if:
> +      required:
> +        - reg
> +    then:
> +      $ref: /schemas/spi/spi-peripheral-props.yaml#
> +      not:
> +        required:
> +          - mdc-gpios
> +          - mdio-gpios
> +          - mdio
> +
> +      properties:
> +        mdc-gpios: false
> +        mdio-gpios: false
> +        mdio: false
> +    else:
> +      required:
> +        - mdc-gpios
> +        - mdio-gpios
> +        - mdio
> +        - reset-gpios
>  
>  required:
>    - compatible
> -- 
> 2.39.2
> 

