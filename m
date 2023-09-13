Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16579E5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbjIMLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjIMLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:04:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED511726;
        Wed, 13 Sep 2023 04:04:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso835943766b.0;
        Wed, 13 Sep 2023 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694603047; x=1695207847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XWMdnJsx2d8fiBGvmqe7qu7qVNHb4jJy8Zu53A7Ws4A=;
        b=SCf0LhkSU0USfus5vVpfJOi54WNnFg+IjBO8vD37nfAIr9B9FAyXYEE4EH+TBw7xw1
         Q0UK8bqbMPxBxTjfM19Xj4Bs4vYV5+FxqaHV8xICrX2qcNiidfYQEaHhpAnD4XUIU5ED
         ttIXQk943CWO+OE6z91MSducuzhsTTjlYmWuZMI0ZuCH1/3f2nt4BfiJjPguFhBpbGe8
         Op9TZy/M+OlXTQM8GufMSJQoridmIGQhxWvEGGQm/YaLYZz99X6/K5x6XiaTJRuyXj1f
         BbJiwg6HD4S0lnb79kR5EEtBFGY4Bhx4ve7GQpmcCGhnAT6FK2aW3pzNfBabX+VsMZVf
         MELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603047; x=1695207847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWMdnJsx2d8fiBGvmqe7qu7qVNHb4jJy8Zu53A7Ws4A=;
        b=mxYwBQ+CX1TYPGAUHpNN6HHrg4nmnjEClBx2O+tGCR8hP5QRhYW9M1s9+ZIb/5vO//
         ylxLqHO5OmG8RdbyvVpwlCGh9hehnoSSfCJb3SzLpuhspJqGjtIZUiiSQOZxaCDz4yLx
         f0kDxrKpiDxrY67VgYvpCfPm4p9QdW04R+lr38m2ubnDOs+BqN2MbM9k+BTmTJAte7Iu
         CkfPiDx3kX0ldj0r4OoyWJgLmKfkWAwRFpbkg+tTqonNAbYNKbg11eX6fVC536XI8fas
         vxWinQ8FJCKyU+YCXX3/HqY1/cBczBTy4xHVO+cFP9IbAXkUK55HgLTfS6LAWqwYf+jr
         DONw==
X-Gm-Message-State: AOJu0YylWRqlEfAItmyC+4HaVojkU4UcWK+x3vpgQpVme8if3xUyeopC
        /7RWBtrWDg1f9qy2p5cAaIE=
X-Google-Smtp-Source: AGHT+IENQYSCb1bqP3F1jbQeEwYGGwYsGuq575to5BfuhYNjZDfJ9D1qKsoXbdaMDic7mOraJMeKMA==
X-Received: by 2002:a17:906:18a2:b0:99d:f0e8:5623 with SMTP id c2-20020a17090618a200b0099df0e85623mr1572105ejf.54.1694603047218;
        Wed, 13 Sep 2023 04:04:07 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id qb1-20020a1709077e8100b009ad89697c86sm2352992ejc.144.2023.09.13.04.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:04:06 -0700 (PDT)
Date:   Wed, 13 Sep 2023 14:04:04 +0300
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
Message-ID: <20230913110404.co7earmnbzf6hhoe@skbuf>
References: <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
 <20230913074231.5azwxqjuv2wp5nik@skbuf>
 <89c9b84c-574c-4071-9524-9207597a3f0a@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c9b84c-574c-4071-9524-9207597a3f0a@arinc9.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:59:17PM +0300, Arınç ÜNAL wrote:
> If I understand correctly, these phylink rules are for switch ports. The
> fixed-link, phy-handle, and managed properties are described on
> ethernet-controller.yaml so I thought it would make sense to define the
> rules there and refer to them where they're needed.
> 
> Example:
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> index 480120469953..7279ab31aea7 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> @@ -65,16 +65,8 @@ if:
>      - required: [ ethernet ]
>      - required: [ link ]
>  then:
> -  allOf:
> -    - required:
> -        - phy-mode
> -    - oneOf:
> -        - required:
> -            - fixed-link
> -        - required:
> -            - phy-handle
> -        - required:
> -            - managed
> +  $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink-switch
> +  required: [ phy-mode ]
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index e532c6b795f4..742aaf1a5ef2 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -179,6 +179,15 @@ required:
>    - compatible
>    - reg
> +if:
> +  required: [ mdio ]
> +then:
> +  patternProperties:
> +    "^(ethernet-)?ports$":
> +      patternProperties:
> +        "^(ethernet-)?port@[0-9]+$":
> +          $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink-switch
> +
>  $defs:
>    mt7530-dsa-port:
>      patternProperties:
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 9f6a5ccbcefe..d7256f33d946 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -284,6 +284,21 @@ allOf:
>              controllers that have configurable TX internal delays. If this
>              property is present then the MAC applies the TX delay.
> +$defs:
> +  phylink-switch:
> +    description: phylink bindings for switch ports
> +    allOf:
> +      - anyOf:
> +          - required: [ fixed-link ]
> +          - required: [ phy-handle ]
> +          - required: [ managed ]
> +
> +      - if:
> +          required: [ fixed-link ]
> +        then:
> +          not:
> +            required: [ managed ]
> +
>  additionalProperties: true
>  ...
> 
> Arınç

I don't think they're for switch ports only. Any driver which uses
phylink_fwnode_phy_connect() or its derivatives gets subject to the same
bindings. But putting the sub-schema in ethernet-controller.yaml makes
sense, just maybe not naming it "phylink-switch".
