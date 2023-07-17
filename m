Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688C7569EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGQROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGQROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:14:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09AE43
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:14:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qLRnj-0000i6-Ri; Mon, 17 Jul 2023 19:14:23 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qLRnj-0003jo-C6; Mon, 17 Jul 2023 19:14:23 +0200
Date:   Mon, 17 Jul 2023 19:14:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Message-ID: <20230717171423.tf5i7hhjl5thoye7@pengutronix.de>
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-2-m.felsch@pengutronix.de>
 <22d68e14-5198-59ce-44cc-37e9ff5e367c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d68e14-5198-59ce-44cc-37e9ff5e367c@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-17, Krzysztof Kozlowski wrote:
> On 17/07/2023 18:51, Marco Felsch wrote:
> > The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> > corresponding bindings by adding an own entry for it. Mark
> > polyhex,imx8mp-debix as deprecated but keep it within the dts file since
> > we already have a user for it [1].
> > 
> > [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
> >     boards/polyhex-debix/board.c#L38
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Subject: fix is too generic and binding is redundant. You already state
> this is binding in your prefix. Describe more precise what you are doing.
> 
> > ---
> > Changelog:
> > 
> > v2:
> > - deprecate polyhex,imx8mp-debix
> > 
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 15d4110840654..b29974e3c30b3 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1019,8 +1019,6 @@ properties:
> >                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
> >                - fsl,imx8mp-evk            # i.MX8MP EVK Board
> >                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
> > -              - polyhex,imx8mp-debix      # Polyhex Debix boards
> > -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
> >                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
> >                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
> >                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
> > @@ -1054,6 +1052,14 @@ properties:
> >            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
> >            - const: fsl,imx8mp
> >  
> > +      - description: Polyhex DEBIX i.MX8MP based SBCs
> > +        items:
> > +          - enum:
> > +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> > +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
> > +            deprecated: true
> > +          - const: fsl,imx8mp
> 
> That's not how it works and it does not look like you tested the DTS
> against bindings. Please run `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> Don't deprecate some piece of entire compatible list, but entire list.
> 
> The commit which deprecates compatible should bring a proper one.

What did you mean by that?

Regards,
  Marco

> Otherwise at this point we have kernel only with deprecated compatibles.
> 
> 
> Best regards,
> Krzysztof
> 
> 
> 
