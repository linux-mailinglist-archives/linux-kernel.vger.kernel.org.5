Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98817F86AB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjKXX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXX0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:26:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E91990;
        Fri, 24 Nov 2023 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZEmM+x5c4j9E2iYripoWJxHgYv7R98NUEa31meAyb3E=; b=uGtbsMYszf8pdWOAfR2MhpRlqV
        24g92f2VFULf7WTq8BWo5l/3XruHQvZr13mP5OFmGelaM3YxeSSS2yBBygiKA74EJKa+qbEbmA040
        u+t3KbeEDYIYMnJpUxJM0BZ6o/TFnIExVIRCdKpQOVZq3vDeASDU6zGVIgO/6OMynBis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6fYP-0018wU-SA; Sat, 25 Nov 2023 00:25:45 +0100
Date:   Sat, 25 Nov 2023 00:25:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Conor Dooley <conor@kernel.org>
Cc:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH RFC WIP 1/2] dt-bindings: net: rockchip-dwmac: add
 rockchip,phy-wol property
Message-ID: <42c5c174-e7f2-4323-8db0-0db1ede39ec5@lunn.ch>
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
 <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
 <20231123-operable-frustrate-6c71ab0dafbf@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-operable-frustrate-6c71ab0dafbf@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:20:48PM +0000, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 01:14:13PM +0100, Javier Carrasco wrote:
> > This property defines if PHY WOL is preferred. If it is not defined, MAC
> > WOL will be preferred instead.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> > ---
> >  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > index 70bbc4220e2a..fc4b02a5a375 100644
> > --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> > @@ -91,6 +91,12 @@ properties:
> >        The phandle of the syscon node for the peripheral general register file.
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >  
> > +  rockchip,phy-wol:
> > +    type: boolean
> > +    description:
> > +      If present, indicates that PHY WOL is preferred. MAC WOL is preferred
> > +      otherwise.
> 
> Although I suspect this isn't, it sounds like software policy. What
> attribute of the hardware determines which is preferred?

I tend to agree, its a software policy. Doing WoL in the PHY should be
the preferred solution, because it allows the MAC to be powered off,
saving more power. If the PHY does not implement it, then the MAC
should be used.

It should be possible for the MAC driver to pass the WoL settings to
the PHY, and if it returns EOPNOTSUPP, or maybe EINVAL, implement the
WoL in the MAC.

This might be a behaviour change, depending on the MAC driver. So i
could imaging a less risk tolerant developers wanting a knob to enable
this. However, if done correctly, using the PHY instead of the MAC
should not be visible from the users perspective.

    Andrew
