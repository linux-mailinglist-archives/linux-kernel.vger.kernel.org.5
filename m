Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB02A7591BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGSJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGSJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:34:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C919A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:34:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qM3Zs-0006cV-D8; Wed, 19 Jul 2023 11:34:36 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qM3Zr-0008Ta-Oi; Wed, 19 Jul 2023 11:34:35 +0200
Date:   Wed, 19 Jul 2023 11:34:35 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Message-ID: <20230719093435.mixoqke3dqtgwauh@pengutronix.de>
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-2-m.felsch@pengutronix.de>
 <66b096e1-fcdc-8af7-63ea-9b74013eb667@pengutronix.de>
 <20230717172424.yru3qqfz4xd7qw3a@pengutronix.de>
 <8c91fd56-a815-d2ff-6f62-168eb76ae6c1@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c91fd56-a815-d2ff-6f62-168eb76ae6c1@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad, Krzysztof,

On 23-07-17, Ahmad Fatoum wrote:
> On 17.07.23 19:24, Marco Felsch wrote:
> > On 23-07-17, Ahmad Fatoum wrote:
> >> On 17.07.23 18:51, Marco Felsch wrote:
> >>> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> >>> corresponding bindings by adding an own entry for it. Mark
> >>> polyhex,imx8mp-debix as deprecated but keep it within the dts file since
> >>> we already have a user for it [1].
> >>>
> >>> [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
> >>>     boards/polyhex-debix/board.c#L38
> >>>
> >>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> >>> ---
> >>> Changelog:
> >>>
> >>> v2:
> >>> - deprecate polyhex,imx8mp-debix
> >>>
> >>>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
> >>>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> index 15d4110840654..b29974e3c30b3 100644
> >>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> @@ -1019,8 +1019,6 @@ properties:
> >>>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
> >>>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
> >>>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
> >>> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
> >>> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
> >>>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
> >>>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
> >>>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
> >>> @@ -1054,6 +1052,14 @@ properties:
> >>>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
> >>>            - const: fsl,imx8mp
> >>>  
> >>> +      - description: Polyhex DEBIX i.MX8MP based SBCs
> >>> +        items:
> >>> +          - enum:
> >>> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> >>> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
> >>> +            deprecated: true
> >>
> >> I don't see why you need to deprecate this. Can't you just change the comment
> >> to read "Polyhex i.MX8MP SBCs" or similar?
> > 
> > This was suggested by Krzysztof, since polyhex,imx8mp-debix was to
> > generic. I can keep it without the deprecation notice and just change
> > the comment since we need to keep dts compatible anyway.
> 
> I agree that using it as compatible for both SBC and SoMs, when the boards
> aren't based on the SoM isn't useful. I still think it's useful to have
> a compatible for "Debix i.MX8MP SBCs" that spans current lineup of Model A,
> Model B, B SE and possible future compatibles.

Thanks for the input. @Krzysztof how do we proceed on this topic? I can
adapt the comment and drop the deprecated status.

Regards,
  Marco
