Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36A7F8D28
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjKYSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:36:25 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027FC1;
        Sat, 25 Nov 2023 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=42L+NV20mWtb2AR1GqvkTM6b9HRTWRYXBz/2ktpsdBY=; b=BdX8z48RvHVLH0sE+kC1szCxvW
        bSFhs83aymUOB8Rj/CkpRhF6VEf4afUT+m38myoK2lcdIqcc59wNwgu62ozJyMEnicJmnOBV8k3VR
        w5D55mrc2+gLZ0xha57cgRK75mnQzof6tVghhamIE7J0+piRtLl78/1ypHAsG4Ebzxaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6xVj-001CjP-DP; Sat, 25 Nov 2023 19:36:11 +0100
Date:   Sat, 25 Nov 2023 19:36:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH v2 02/11] dt-bindings: net: document
 ethernet PHY package nodes
Message-ID: <ec029afe-1961-4077-a28c-d4c1022c24f0@lunn.ch>
References: <20231125001127.5674-1-ansuelsmth@gmail.com>
 <20231125001127.5674-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125001127.5674-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:11:18AM +0100, Christian Marangi wrote:
> Document ethernet PHY package nodes used to describe PHY shipped in
> bundle of 4-5 PHY. These particular PHY require specific PHY in the
> package for global onfiguration of the PHY package.

I would not say that is true. We have been able to handle such PHYs
without a problem so far. This binding is not about a collection of
PHYs in one package with shared registers. Its about DT properties
which are shared across the package.

This binding is simply a container. It contains properties shared by
all PHYs in the container, and it contains the PHYs itself. The
properties should be described in another DT scheme, selected by a
compatible for the PHY package. The PHYs themselves a follow the
standard ethernet-phy scheme.

I would also add a comment about the reg value in the PHY properties
being absolute, not relative. You can make this clearer in the
example, by using a base address of 16, and PHYs 16 and 20.

Please include this is in the binding itself, as part of the
documentation.

> +properties:
> +  $nodename:
> +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> +
> +  reg:
> +    minimum: 0
> +    maximum: 31
> +    description:
> +      The ID number for the PHY.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ^ethernet-phy(@[a-f0-9]+)?$:
> +    $ref: /schemas/net/ethernet-phy.yaml#
> +
> +required:
> +  - reg

A compatible is required.

> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@0 {

A compatible is needed here.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0>;
> +
> +            ethernet-phy@0 {
> +              compatible = "ethernet-phy-ieee802.3-c22";

This compatible is optional, and c22 is the default, so i would not
list it.

     Andrew
