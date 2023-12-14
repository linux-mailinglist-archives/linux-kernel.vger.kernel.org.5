Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715118138EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjLNRlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjLNRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:40:56 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF0B7;
        Thu, 14 Dec 2023 09:41:01 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da3659535fso1679881a34.3;
        Thu, 14 Dec 2023 09:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575661; x=1703180461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zdZ0ienZCoKJGn2KtzvEpwkVAjav3OsYiEGG0EDFsQ=;
        b=MdxNoYG8mnf7H7rwtMbTgmgt657I4lZn/kg2GVj7uFbSm6VsWulkBaOPTvV7ov0IgM
         UIuLqZ9n4uqOYlWajNBo13ubh87/YbVRRzrSX0Ej0Izn5XTuRXsZgz6OULjZl40K7Kuv
         sJgbSLXdptUKCsnVmIZIipkaoWYcJLiXSxGDlUeZnuFrxx12MuCXmkAyEDm7wsazifSG
         FRzOKHyegNTMFTWrE5t3IfXnhCgRgeZaDwMCIC8Rcz94ng30lTI/BzFyUvAB0jl+JtEF
         Zx6sGlHxosJjQ2FDVJ5ywPUEhT9IPwJlwtVlpNGEiDqZtdUyzGAOKyCykdGIT87IwxQ9
         Y0mA==
X-Gm-Message-State: AOJu0YwNJH0PrXUL7+KwcVzov3q67NZaLuAyU/1X2MQM7+oSpJyjeudR
        lUItby6PTaiTb34UUT+Quw==
X-Google-Smtp-Source: AGHT+IHR2mKGPjA6Cg6K+KNOwWucrAolfXP5PFsqGvuPXW8Q0CZP7l8Ljjc4B2Rq9DyeloElLkdsyA==
X-Received: by 2002:a05:6830:4d6:b0:6da:2ec0:c738 with SMTP id s22-20020a05683004d600b006da2ec0c738mr4821847otd.31.1702575660920;
        Thu, 14 Dec 2023 09:41:00 -0800 (PST)
Received: from herring.priv ([2607:fb91:e6c7:a40:1c2d:b875:912d:c28])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d66cf000000b006d7f41c7e11sm3236498otm.33.2023.12.14.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:41:00 -0800 (PST)
Received: (nullmailer pid 637311 invoked by uid 1000);
        Thu, 14 Dec 2023 17:40:58 -0000
Date:   Thu, 14 Dec 2023 11:40:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/16] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <20231214174058.GA624576-robh@kernel.org>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-9-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-9-fancer.lancer@gmail.com>
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

On Tue, Dec 05, 2023 at 01:35:29PM +0300, Serge Semin wrote:
> Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
> providing an interface between the Media Access Control (MAC) and Physical
> Medium Attachment Sublayer (PMA) through a Media independent interface.
> >From software point of view it exposes IEEE std. Clause 45 CSR space and
> can be accessible either by MDIO or MCI/APB3 bus interfaces. The later
> case is described by means of a dedicated DT-bindings which imply having
> the DW XPCS Management Interface defined as a DT-supernode which child the
> PCSs nodes would be (in the same way as the standard MDIO buses and
> devices are normally defined).
> 
> Besides of that DW XPCS DT-nodes can have the interrupts and clock source
> properties specified. The former one indicates the Clause 73/37
> auto-negotiation events like: negotiation page received, AN is completed
> or incompatible link partner. The clock DT-properties can describe up to
> two clock sources: internal one and the one connected to the chip pad.
> Either of them is supposed to be used as the device reference clocks.
> 
> Finally the DW XPCS IP-core can be optionally synthesized with a
> vendor-specific interface connected to Synopsys PMA (also called
> DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable
> anyhow so if the DW XPCS device has the respective PMA attached then it
> should be reflected in the DT-node compatible string so the driver would
> be aware of the PMA-specific device capabilities (mainly connected with
> CSRs available for the fine-tunings).
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../bindings/net/pcs/snps,dw-xpcs.yaml        | 88 +++++++++++++++++++
>  .../bindings/net/snps,dw-xpcs-mi.yaml         | 88 +++++++++++++++++++
>  2 files changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> new file mode 100644
> index 000000000000..9694ef51abad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare Ethernet PCS
> +
> +maintainers:
> +  - Jose Abreu <Jose.Abreu@synopsys.com>
> +
> +description:
> +  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
> +  between Media Access Control and Physical Medium Attachment Sublayer through
> +  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
> +  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
> +  optionally synthesized with a vendor-specific interface connected to
> +  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
> +  general it can be used to communicate with any compatible PHY.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Synopsys DesignWare XPCS with none or unknown PMA
> +        const: snps,dw-xpcs
> +      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> +        const: snps,dw-xpcs-gen1-3g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
> +        const: snps,dw-xpcs-gen2-3g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
> +        const: snps,dw-xpcs-gen2-6g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
> +        const: snps,dw-xpcs-gen4-3g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
> +        const: snps,dw-xpcs-gen4-6g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
> +        const: snps,dw-xpcs-gen5-10g
> +      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
> +        const: snps,dw-xpcs-gen5-12g
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
> +      auto-negotiation events like':' Page received, AN is completed or

like':' ?

> +      incompatible link partner.
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      PCS/PMA interface be can clocked either by internal reference clock
> +      source or by an externally connected (via a pad) clock generator.
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [ core, pad ]
> +
> +required:
> +  - compatible
> +  - reg

Don't you always need a clock?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mdio-bus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      xgmac_pcs: ethernet-pcs@0 {
> +        compatible = "snps,dw-xpcs";
> +        reg = <0>;
> +
> +        interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        clocks = <&ccu_core>, <&ccu_pad>;
> +        clock-names = "core", "pad";
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml b/Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml
> new file mode 100644
> index 000000000000..67ddba9d61fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/snps,dw-xpcs-mi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare Ethernet PCS Management Interface
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description:
> +  Synopsys DesignWare Ethernet PCS provides an interface between MAC and PMA
> +  through the Media Independent Interface. The PCS CSRs can be accessible over
> +  the Ethernet MDIO bus or directly by means of the APB3/MCI interfaces. In the
> +  later case the XPCS can be mapped right to the system IO memory space.
> +
> +allOf:
> +  - $ref: mdio.yaml#
> +
> +properties:
> +  compatible:
> +    const: snps,dw-xpcs-mi
> +
> +  reg:
> +    items:
> +      - description:
> +          DW XPCS CSRs space can be either 'directly' or 'indirectly'
> +          accessible. In the former case all Clause 45 registers are
> +          contiguously mapped within the address space MMD '[20:16]',
> +          Reg '[15:0]'. In the later case the space is divided to the
> +          multiple 256 register sets. There is a special viewport CSR
> +          which is responsible for the set selection. The upper part of
> +          the CSR address is supposed to be written in there thus the
> +          corresponding subset would be mapped over the lowest 255 CSRs.
> +
> +  reg-names:
> +    items:
> +      - enum: [ direct, indirect ]
> +
> +  reg-io-width:
> +    description:
> +      The way the CSRs are mapped to the memory is platform depended. Since

dependent

> +      each Clause 45 CSR is of 16-bits wide the access instructions must be
> +      two bytes aligned at least.
> +    default: 2
> +    enum: [ 2, 4 ]
> +
> +  clocks:
> +    items:
> +      - description: Peripheral MCI/APB3 bus clock source
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +
> +patternProperties:
> +  'ethernet-pcs@[0-9a-f]+$':
> +    type: object
> +
> +    $ref: pcs/snps,dw-xpcs.yaml#

This causes dw-xpcs to be validated twice. Does this MDIO bus support 
other devices on it or it is fixed config?

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio@1f05d000 {
> +      compatible = "snps,dw-xpcs-mi";
> +      reg = <0x1f05d000 0x1000>;
> +      reg-names = "indirect";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      clocks = <&ccu_pclk>;
> +      clock-names = "pclk";
> +
> +      reg-io-width = <4>;
> +
> +      ethernet-pcs@0 {
> +        compatible = "snps,dw-xpcs";
> +        reg = <0>;
> +      };
> +    };
> -- 
> 2.42.1
> 
