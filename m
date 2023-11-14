Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63957EB10F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjKNNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKNNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:43:21 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092DB1B6;
        Tue, 14 Nov 2023 05:43:18 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so2936375a34.0;
        Tue, 14 Nov 2023 05:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969397; x=1700574197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKwkP963gOr3zzH+sOtigbWk+LV0roLBXICZMNqn3/c=;
        b=Pedb4DlB6o4guja5i4OpHgJwFRUJBvUAg19e5OiIFbwz+WD1WHlOnph8hUlsxkPaT+
         r4MWDlLr/qqn0JjUwft3Wt5hZBIZv6GbOR/VCyE21lvy27xdrviqWTOj99Utw2gHijDh
         j5zHhcQej0NZAyvEC6b0MqSWiZg6nVBxAXqWtAJhQ4IEOs0D6kVolXJNuXkzID18adZJ
         ZtfpISGSrM+tTYoInf8B1UgK8qUkafmcUWn5WmXRYIMptGW/nUkiFdJnZt/JWINmckmL
         jYH17SBnqdfJ8SbPs19RULS80/4G3a7ib5iDZtu/vv71lc9QRjjSbjSL1j2LmmEkpzLe
         nupA==
X-Gm-Message-State: AOJu0YyV8SurvfmM6p4I6gIJR95IwVTIa3A8iGOXGPjWPLpShX20WM0Z
        sWYYrUi/eMmsMQIdZ3oJ+w==
X-Google-Smtp-Source: AGHT+IEewtgCzuIB1eQL3luUwxLZaGnVSFEKF90crdWiR8BoDUsAFfrvOT5VpkzrnZyuSj/5tJismw==
X-Received: by 2002:a05:6870:c1d1:b0:1e9:c18b:b2da with SMTP id i17-20020a056870c1d100b001e9c18bb2damr13151127oad.18.1699969397286;
        Tue, 14 Nov 2023 05:43:17 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o7-20020a9d7647000000b006bf0f95f702sm199993otl.64.2023.11.14.05.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:43:16 -0800 (PST)
Received: (nullmailer pid 1650336 invoked by uid 1000);
        Tue, 14 Nov 2023 13:43:15 -0000
Date:   Tue, 14 Nov 2023 07:43:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 1/8] dt-bindings: phy: mediatek,xfi-pextp: add new
 bindings
Message-ID: <20231114134315.GA1645963-robh@kernel.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 09:50:55PM +0000, Daniel Golle wrote:
> Add bindings for the MediaTek PEXTP Ethernet SerDes PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/phy/mediatek,xfi-pextp.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml b/Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
> new file mode 100644
> index 0000000000000..948d5031af1e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,xfi-pextp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek XFI PEXTP SerDes PHY
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description: |

Don't need '|' here.

> +  The MediaTek XFI PEXTP SerDes PHY provides the physical SerDes lanes
> +  used by the MediaTek USXGMII PCS.
> +
> +properties:
> +  $nodename:
> +    pattern: "^phy@[0-9a-f]+$"
> +
> +  compatible:
> +    const: mediatek,mt7988-xfi-pextp
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XFI PHY clock
> +
> +  resets:
> +    items:
> +      - description: PEXTP reset
> +
> +  mediatek,usxgmii-performance-errata:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      USXGMII0 on MT7988 suffers from a performance problem in 10GBase-R
> +      mode which needs a work-around in the driver. The work-around is
> +      enabled using this flag.
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt7988-clk.h>
> +    #include <dt-bindings/reset/mediatek,mt7988-resets.h>
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      xfi_pextp0: phy@11f20000 {

Drop unused labels.

> +        compatible = "mediatek,mt7988-xfi-pextp";
> +        reg = <0 0x11f20000 0 0x10000>;
> +        clocks = <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
> +        resets = <&watchdog MT7988_TOPRGU_XFI_PEXTP0_GRST>;
> +        mediatek,usxgmii-performance-errata;
> +        #phy-cells = <0>;
> +      };
> +    };
> +
> +...
> -- 
> 2.42.1
