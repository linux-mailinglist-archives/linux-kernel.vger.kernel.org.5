Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51277A618
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjHMLHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:07:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E491BD;
        Sun, 13 Aug 2023 04:07:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso449910966b.0;
        Sun, 13 Aug 2023 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691924870; x=1692529670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+JzoWKJWfDj4FguRZ7Oco2p7HgbsRYijC1lYv2wlZ+U=;
        b=kn7+miFpzqcrheYyIkdteTYanxmSe9imJRlF5Ticz8m+hZ8E8lV+DONipGiZfiaryb
         EJZw5xLfQZHLH9o45z+C4C804uHrYB8pMP8GhvbyNxrum4cq7chQEfgHayGivKdBbvV4
         cmXI1XxdGd6Dz5w5jWDGs9BEABnNOe+tBHn+EGvY/soTguXoYbkxdp275oVsLkuvRvvz
         qnRpQLHzrN5Oc8KR7x5BXSY1YrkKl64oteQPukRRcOwECrKUfccjS1OTE8cz/kq/Jbex
         gqBcQVz+QZisvO2Z61hnXlkd+b5txb2LSmU7eE3E7q/sKmc2iE5LIdzJnONqO7somYrw
         o0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924870; x=1692529670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JzoWKJWfDj4FguRZ7Oco2p7HgbsRYijC1lYv2wlZ+U=;
        b=N5kQWz8TUi8k1JYbVPBXY7ubeod4aFmgU1SFDvrJxPFoV/CC8VVsC3rWNOsP5tCJ4j
         mvh25umdK59NiNOAacjrNb8XTxZirwbRHqvikTbTepIdAaMKpdzs9sjeBTrMt5kbFIj2
         dSOnziwqJVbBYl3l4MgCZT9zgum7Ux5AkkCx6wKvu+TgHqB5/xde/E489J5NV+ylIFDw
         9D6tSbauHqKvpgJ1wKb7njYqI6odga166JG5iA5Jkv+u0UppdE/xM9F8UTbEV69OOqpA
         aKJQ8oVn+ttXyIAhAbXhtkbdia+Xs/xnzN2cM5S+p9k5M0eiFc1/Ob/EVISW2N9trffA
         gYvA==
X-Gm-Message-State: AOJu0Ywv4WW4AGKLGt8E2QwpJppRtkQTFd58IwO/8WepKX+PZDQq1zJS
        vttMe6eGZT+ekIgCvaclJ5A=
X-Google-Smtp-Source: AGHT+IGiBbzIr6xiUxTXEqiYjsMf2mnAhUrlkotMHGlTp3fQ8LNKaqiiDrm0mAkbHAIKUi8nhneRlQ==
X-Received: by 2002:a17:906:14e:b0:99b:f3d1:7735 with SMTP id 14-20020a170906014e00b0099bf3d17735mr5293600ejh.29.1691924870146;
        Sun, 13 Aug 2023 04:07:50 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906671100b0099bd8c1f67esm4453038ejp.109.2023.08.13.04.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 04:07:49 -0700 (PDT)
Date:   Sun, 13 Aug 2023 14:07:47 +0300
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
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: microchip,lan937x: add
 missing ethernet on example
Message-ID: <20230813110747.rvvsvte2t6pbe5j4@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230812091708.34665-2-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:17:05PM +0300, Arınç ÜNAL wrote:
> The port@5 node on the example is missing the ethernet property. Add it.
> Remove the MAC bindings on the example as they cannot be validated.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/net/dsa/microchip,lan937x.yaml           | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> index 8d7e878b84dc..49af4b0d5916 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> @@ -68,16 +68,6 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>  
> -    macb0 {
> -            #address-cells = <1>;
> -            #size-cells = <0>;
> -
> -            fixed-link {
> -                    speed = <1000>;
> -                    full-duplex;
> -            };
> -    };
> -
>      spi {
>              #address-cells = <1>;
>              #size-cells = <0>;
> @@ -138,6 +128,7 @@ examples:
>                                      phy-mode = "rgmii";
>                                      tx-internal-delay-ps = <2000>;
>                                      rx-internal-delay-ps = <2000>;
> +                                    ethernet = <&macb1>;

macb1 instead of macb0: was it intentional?

>  
>                                      fixed-link {
>                                              speed = <1000>;
> -- 
> 2.39.2
> 

