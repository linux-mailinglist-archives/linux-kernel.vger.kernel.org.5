Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A92C793C43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbjIFMHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjIFMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:07:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED310F5;
        Wed,  6 Sep 2023 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=HONuq0NAXDSinCSdNAk81emvfs27Qxol2w88sK/FGnw=; b=KiJs1rQEOtGrGQ1frkzZVM5G7k
        tkVdm3q2nXa1Ux62dURs6vv0mkHvLdM0loie+UoEYOZoKT3xHbHBlVZgr3uVUFVz+01NT/N+r6fE8
        Y+bvGGHYJCYiunNbIxrqM0s2eFeYr3B2dwFQTS78GIrtfznJC2ySNIQW5wK2/Ly2KZgc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qdrJ5-005tq0-Gj; Wed, 06 Sep 2023 14:06:51 +0200
Date:   Wed, 6 Sep 2023 14:06:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [RFC net-next v2 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Message-ID: <662be602-82a2-4e00-ba03-4b9e3aa0f8d2@lunn.ch>
References: <20230906105904.1477021-1-o.rempel@pengutronix.de>
 <20230906105904.1477021-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906105904.1477021-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:59:03PM +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> - microchip,io-drive-strength-microamp: Controls the drive strength for
>   for undocumented Pads on KSZ88xx variants.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/net/dsa/microchip,ksz.yaml       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index e51be1ac03623..66bd770839d50 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -49,6 +49,29 @@ properties:
>        Set if the output SYNCLKO clock should be disabled. Do not mix with
>        microchip,synclko-125.
>  
> +  microchip,io-drive-strength-microamp:
> +    description:
> +      IO Pad Drive Strength
> +    minimum: 8000
> +    maximum: 16000
> +    default: 16000

You should list the valid values, using the syntax:

enum: [ 250, 500, 750, 1000, ...];


    Andrew

---
pw-bot: cr
