Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6E775607
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHIJBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHIJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:01:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30451BD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:01:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qTf3w-0001AB-Ib; Wed, 09 Aug 2023 11:01:04 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qTf3t-0007CX-0k; Wed, 09 Aug 2023 11:01:01 +0200
Date:   Wed, 9 Aug 2023 11:01:00 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        joabreu@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        peppe.cavallaro@st.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: snps,dwmac: add
 phy-supply support
Message-ID: <20230809090100.pdtdidqk7mhvm4ks@pengutronix.de>
References: <20230721110345.3925719-1-m.felsch@pengutronix.de>
 <20230721142433.GA1012219-robh@kernel.org>
 <20230724093953.h7vs6gzrpk3ieznv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724093953.h7vs6gzrpk3ieznv@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 23-07-24, Marco Felsch wrote:
> Hi Rob,
> 
> On 23-07-21, Rob Herring wrote:
> > On Fri, Jul 21, 2023 at 01:03:43PM +0200, Marco Felsch wrote:
> > > Document the common phy-supply property to be able to specify a phy
> > > regulator.
> > 
> > What common property? I don't see any such property in 
> > ethernet-controller.yaml.
> 
> Not in ethernet-controller.yaml but there are at least a few user of
> this binding:
>  - allwinner,sun4i-a10-mdio.yaml
>  - allwinner,sun7i-a20-gmac.yaml
>  - allwinner,sun8i-a83t-emac.yaml
>  - fsl,fec.yaml
>  - rockchip-dwmac.yaml
>  - rockchip,emac.yaml
> 
> Also there is no <vendor>,phy-supply nor <ip-vendor>,phy-supply,
> therefore I thought this is common.

any further comments else I would like to gentle ping this series.

Regards,
  Marco

> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > > Changelog:
> > > v4:
> > > - no changes
> > > v3:
> > > - no changes
> > > v2
> > > - add ack-by
> > > 
> > >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > index ddf9522a5dc23..847ecb82b37ee 100644
> > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > @@ -160,6 +160,9 @@ properties:
> > >        can be passive (no SW requirement), and requires that the MAC operate
> > >        in a different mode than the PHY in order to function.
> > >  
> > > +  phy-supply:
> > > +    description: PHY regulator
> > 
> > Is this for an serdes, sgmii, etc. type phy or ethernet phy? Either way, 
> > this property belongs in the PHY's node because it is the PHY that has 
> > supply connection. I'm guessing you put this here for the latter case 
> > because ethernet PHYs on MDIO are "discoverable" except for the small 
> > problem that powering them on is not discoverable. 
> 
> All kind of ethernet phys connected to you etherent MAC which need to be
> power controlled by software. You're right this sould belong to the PHY
> node (as Krzysztof already mentioned) but this isn't the case yet. As
> you can see there are at least 6 user of the exact same binding.
> 
> Regards,
>   Marco
> 
> 
