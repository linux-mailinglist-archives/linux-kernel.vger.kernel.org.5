Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854A37E491C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjKGTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKGTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:22:36 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97BC93;
        Tue,  7 Nov 2023 11:22:34 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5875e24c749so2857892eaf.1;
        Tue, 07 Nov 2023 11:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699384954; x=1699989754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2LVUxVn/WYGw09VaClNEKd1bIRB6aUmkJKhH9M8Zr8=;
        b=GnkdB9nO/1i2Ddbr+4x4ViK2+FnYUiwmV9hCTTftzKlaa1MnhbYxpgn/IKn1r07w4N
         KgFY6Qfg1BoHY5xrl2Dv56silMlwg0WwAyWWPJNYVqN9YMuABBGyo2bZAMb3x+/rBWtg
         Hap2u6l6/SuwRZkXYVh+qAS6nNJ1y+8ylU99EJAIbnrx0zYxti/WyRZZ3MpQ/xCrwPTF
         wWhYNH+qa3D07GDES/Qt2vK1xth/JWXN2xT66iSKNNWDGJD6BRFASUp6tAY4duv/ydda
         LFoxM8N4J8LtxoN7rJ8pB4WLxuUrcB2p3U4Mr8nN2HbnSHoQ+ksG9MreVuohVkfgjVdx
         WRRg==
X-Gm-Message-State: AOJu0YxVe4VjjAxYjZsn+7JAF+GqOEpE0oN0Rzyf8/0Svh0RanbDc5NM
        o0t3YMzZK+kad3q5pXT8Ug==
X-Google-Smtp-Source: AGHT+IFXGZPFxTsmKHVs8vrn/0NhY6nr60EHAu+d/pvNfIoUxLdTw46mI0g8UGJwBLUFArpxUJJnnA==
X-Received: by 2002:a05:6870:d28e:b0:1ef:b809:3f26 with SMTP id d14-20020a056870d28e00b001efb8093f26mr4490129oae.17.1699384953861;
        Tue, 07 Nov 2023 11:22:33 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j9-20020a9d7389000000b006cd0a847138sm1673512otk.2.2023.11.07.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:22:33 -0800 (PST)
Received: (nullmailer pid 3312908 invoked by uid 1000);
        Tue, 07 Nov 2023 19:22:32 -0000
Date:   Tue, 7 Nov 2023 13:22:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v5 4/4] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Message-ID: <20231107192232.GA3296102-robh@kernel.org>
References: <20231106165433.2746-1-ansuelsmth@gmail.com>
 <20231106165433.2746-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106165433.2746-4-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 05:54:33PM +0100, Christian Marangi wrote:
> Document bindings for Marvell Aquantia PHY.

For the subject: dt-bindings: net: Add Marvell Aquantia PHY

('Document bindings' is redundant)

> 
> The Marvell Aquantia PHY require a firmware to work correctly and there
> at least 3 way to load this firmware.
> 
> Describe all the different way and document the binding "firmware-name"
> to load the PHY firmware from userspace.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v5:
> - Drop extra entry not related to HW description
> Changes v3:
> - Make DT description more OS agnostic
> - Use custom select to fix dtbs checks
> Changes v2:
> - Add DT patch
> 
>  .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> new file mode 100644
> index 000000000000..7106c5bdf73c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Aquantia Ethernet PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actually
> +  work.
> +
> +  This can be done and is implemented by OEM in 3 different way:
> +    - Attached SPI flash directly to the PHY with the firmware. The PHY
> +      will self load the firmware in the presence of this configuration.
> +    - Dedicated partition on system NAND with firmware in it. NVMEM
> +      subsystem will be used and the declared NVMEM cell will load
> +      the firmware to the PHY using the PHY mailbox interface.
> +    - Manually provided firmware loaded from a file in the filesystem.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id03a1.b445
> +          - ethernet-phy-id03a1.b460
> +          - ethernet-phy-id03a1.b4a2
> +          - ethernet-phy-id03a1.b4d0
> +          - ethernet-phy-id03a1.b4e0
> +          - ethernet-phy-id03a1.b5c2
> +          - ethernet-phy-id03a1.b4b0
> +          - ethernet-phy-id03a1.b662
> +          - ethernet-phy-id03a1.b712
> +          - ethernet-phy-id31c3.1c12
> +  required:
> +    - compatible
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: specify the name of PHY firmware to load
> +
> +  nvmem-cells:
> +    description: phandle to the firmware nvmem cell
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: firmware
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@0 {
> +            /*  Only needed to make DT lint tools work. Do not copy/paste
> +             *  into real DTS files.
> +             */

I don't agree with this statement. Pretty sure we've been through this 
before...

If we have a node, we need to define what it is. The way that is done is 
with compatible. Whether some particular OS implementation (currently) 
needs compatible or not is irrelevant. It's not about dtschema needing 
it, that just exposes the issue.

These MDIO PHY bindings are all broken because they are never actually 
applied to anything.

Rob
