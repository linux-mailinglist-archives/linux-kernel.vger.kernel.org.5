Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D477E201
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbjHPMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245314AbjHPMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:54:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B498E1BFB;
        Wed, 16 Aug 2023 05:54:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso10192587e87.1;
        Wed, 16 Aug 2023 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692190479; x=1692795279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otC1BARuGKDrulb25sBJGAOkpbq1QL5ujMHgaPKF79w=;
        b=B7AYusGRFo5AuJWiBk+QxjiQPJZUfezxxKhyf1w7LVl2wley0BKeRCSkI4EAjq41wv
         msojDeLJ4ScpL4Jyn6lA9uJKtAtXIjNZU9sJHodJT/t2FQguMbmIIAbGMArDGu7DpW7a
         DCejtrDKPw6UdT3t1u/JhspF4S3bnKBlrLJNspfDzHYUXjsddnvrZGQr2sv1ifDKGuwk
         akTJKzUBkISX5OyvVUr2E7kP57wKifDfU5jA0sgK0h2CDbzRfgdzXmJThK4b5Sea5yRk
         057jlcLoVO58tBNfSVQnOxu5876qZI4twz/bEGDU8wYrVy1w2PPgOiWdL3gogzcWtll8
         cvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692190479; x=1692795279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otC1BARuGKDrulb25sBJGAOkpbq1QL5ujMHgaPKF79w=;
        b=BmSiL8Ze6SNR3EWUrp8TI+ru6V7s7tFBezEWUqWAXq2397es/TuX78rkkT8HDAg8je
         2cKwNe6QQTxcRRlHImm37IZdfcaLSTwOsMOrkkkhh4cztUDdSKdAv92ijtlSKSdnhVU8
         TkRnRFOTS9x+Ggg/mKKfJB9c6nJwnXqynGwB1JquVPfUEcZt1LE615GS/uDL1H0COlMT
         ak4cBQU9VR8jftFPGOOVshLXfr7WF5wdT7CyiWpCPx5qkjPsPxvljwlqj7JHcxWoh3qB
         b4ldigCIYYYWjkEZjvzsBsQ4cKZpvCSqvJFHvKO3cJ3+gDLhfFbekN841Eja9vRSCDuf
         SE0A==
X-Gm-Message-State: AOJu0Yzhkkm9lG2SiSQc/66lCFRYKwPfoSN37rEB8X0CE3ATd9yWblTR
        XOhj3z4V/bRrN0Fixj+DLZtrV3eOHAE=
X-Google-Smtp-Source: AGHT+IGYwSGmcuzLfNZH82E0Vs8+ENwke0+OUOh8o1/3HmUSps6AiORgdshjinFaUFj6evvdF2fWNw==
X-Received: by 2002:a05:6512:3112:b0:4fb:8c52:611 with SMTP id n18-20020a056512311200b004fb8c520611mr1263309lfb.38.1692190478600;
        Wed, 16 Aug 2023 05:54:38 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id c5-20020ac25305000000b004ff7e742143sm984501lfh.61.2023.08.16.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:54:37 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:54:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 3/5] dt-bindings: net: Add Loongson-1 DWMAC glue layer
Message-ID: <thdwhlbs5salnufag24tqk4txqs3skidhq5nmzdeyxt3ni5pos@duj55rpqskl3>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151135.1028780-4-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keguang

On Sat, Aug 12, 2023 at 11:11:33PM +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 DWMAC glue layer.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../bindings/net/loongson,ls1x-dwmac.yaml     | 98 +++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  2 +
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> new file mode 100644
> index 000000000000..150799460599
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/loongson,ls1x-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +

> +title: Loongson-1 DWMAC glue layer

DT-schemas describe a device. It has nothing to do with the glue
driver/layer/whatever.

Also I suggest to add a brief device description in the
"description:" property and add there a brief info regarding the SoCs
the controllers can be found on, the DW (G)MAC IP-core version the
ethernet controllers are based on and if possible some data about the
synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA FIFOs size,
perfect and hash MAC-filters size, L3L4 frame filters availability,
PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE 1588(-2008)
Timestamping support, PMT and Wake-up frame support, MAC Management
counters (MMC).

Note DMA FIFO sizes can be also constrained in the properties
"rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter sizes -
in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".

> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls1b-dwmac
> +          - loongson,ls1c-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - loongson,ls1b-dwmac
> +          - loongson,ls1c-dwmac
> +      - const: snps,dwmac-3.50a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: stmmaceth
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: macirq
> +

> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon containing some extra configurations
> +      including PHY interface mode.

I believe the property is supposed to have a vendor-specific name like
"loongson,ls1-syscon" or similar.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phy-handle

> +  - phy-mode

You may want to specify the enum-constraints with the value permitted
for the particular Loongson (G)MAC controller. Seeing ls1b and ls1c
imply different sets of the PHY-modes the constraints are better to be
defined in the allOf sub-schemas. Alternatively you can split the
DT-schema file into two: one for ls1b-dwmac, another one for
ls1c-dwmac. IMO the later option seems better.

-Serge(y)

> +  - syscon
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gmac0: ethernet@1fe10000 {
> +        compatible = "loongson,ls1b-dwmac", "snps,dwmac-3.50a";
> +        reg = <0x1fe10000 0x10000>;
> +
> +        clocks = <&clkc LS1X_CLKID_AHB>;
> +        clock-names = "stmmaceth";
> +
> +        interrupt-parent = <&intc1>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "macirq";
> +
> +        phy-handle = <&phy0>;
> +        phy-mode = "mii";
> +
> +        snps,pbl = <1>;
> +        syscon = <&syscon>;
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "snps,dwmac-mdio";
> +
> +            phy0: ethernet-phy@0 {
> +                reg = <0x0>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..e1a956cf171e 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -66,6 +66,8 @@ properties:
>          - ingenic,x2000-mac
>          - loongson,ls2k-dwmac
>          - loongson,ls7a-dwmac
> +        - loongson,ls1b-dwmac
> +        - loongson,ls1c-dwmac
>          - qcom,qcs404-ethqos
>          - qcom,sa8775p-ethqos
>          - qcom,sc8280xp-ethqos
> -- 
> 2.39.2
> 
