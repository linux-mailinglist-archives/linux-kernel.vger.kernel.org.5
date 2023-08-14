Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEF77BC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjHNOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHNOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:53:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2554D1739;
        Mon, 14 Aug 2023 07:53:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so11334980a12.0;
        Mon, 14 Aug 2023 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692024787; x=1692629587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWKCUp2yq16ZBo58YuOZhMaFJTEXME++1KBwQF44Y3o=;
        b=BVMd15TcKSqiobpIdT/J/hWTHgjlmyGfcHaTZx5coE8RbvluwebBuuXc3FxtyC7kvB
         mgeoI9CwqQ1odg48P1swSA8Hc/dNSAZv9L4DSnNxzhvDKhMAI2/3639aPgKAZ0eKusn/
         Ap6oL5ddWZtM+V3c6WPE2t0YsMPA0Giws2twA+IhMCLFIddg/quuD46ccKmhqT4DflUo
         j9/ndUqGGk1LTzNS55e2NaCR87WIPIXCGBba1zFsBPNXEO6sGiDty2DJa7Ohbm4Wceky
         +pYsKLNabLxVBCNN/DgOtcYBNPfUZaZycVxiaBCMzz4/3dWaKHKve8A+yhIW4xEPesRB
         Nciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024787; x=1692629587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWKCUp2yq16ZBo58YuOZhMaFJTEXME++1KBwQF44Y3o=;
        b=k/ZQTJmEArEekCt0JoXaPIIeY0IDBPPVzNRoJ99/CJIWv+57MHkxzGHj9r44s4hI0/
         2T0WLXQfLDqLEWD3xkUki55dORo3zPaVSn7SASX4yeazLP1AbQlDJtpglT5lLbBoASnG
         YnI2z+OFuwQwQNyq+2C6qWmYc88vjt1sYbjUQb6E747Y+LRiha+Xz4DM8NpP44WHtLN5
         r3Kod3AuVBHgu7w1QpoyrLkwTil/lkfljx3UFaouwyO1b8FCvYAFzrfuaap4keNbstoN
         ShTzo2NaP+VtLj7K9H5OzHhqGWsOGu+g57EUxF1eUrJOVJcAlfm583ji64KNQRyHU7PN
         3Bcg==
X-Gm-Message-State: AOJu0YwKGK+0deasb3A/7SPNN3wzEFb884qe1OW2MO28h0i4hqw/sygB
        bIkHfoKAwb2TbD15j8hfumA=
X-Google-Smtp-Source: AGHT+IFtixjrdADMZKOEGkvAvBctiXAzgbQ0mso/IW2gdlLC49MP49+TS5aibY9BoUnf8wWiX5cTgg==
X-Received: by 2002:a17:907:9483:b0:99b:af5a:fc2c with SMTP id dm3-20020a170907948300b0099baf5afc2cmr14913956ejc.26.1692024787125;
        Mon, 14 Aug 2023 07:53:07 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id j19-20020a1709064b5300b00982a92a849asm5768751ejv.91.2023.08.14.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:53:06 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:53:03 +0300
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
Subject: Re: [PATCH 3/4] dt-bindings: net: dsa: realtek: require compatible
 property under mdio node
Message-ID: <20230814145303.bqiknvvi5urnpjgz@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-4-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230812091708.34665-4-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:17:07PM +0300, Arınç ÜNAL wrote:
> The compatible property must be defined under the mdio node. Enforce it.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  Documentation/devicetree/bindings/net/dsa/realtek.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index ea7db0890abc..f600e65fc990 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -103,6 +103,9 @@ allOf:
>              compatible:
>                const: realtek,smi-mdio
>  
> +          required:
> +            - compatible
> +
>    - if:
>        required:
>          - reg
> -- 
> 2.39.2
> 
