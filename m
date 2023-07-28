Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C309776761E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjG1TPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjG1TPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001C3C06;
        Fri, 28 Jul 2023 12:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C38621D8;
        Fri, 28 Jul 2023 19:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D455C433C8;
        Fri, 28 Jul 2023 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690571721;
        bh=7nzeD4OG5R60IdpA9pA5gs1FjPrFySMLyGJy7bncXK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTB/QMT0kAkyH3U3pWSEc1d0F7nimYpzDvIgsAgHf/gJhyelEZpiwRbR4RPWwb+UH
         RP4adOgXtSidC2l6ls1h603jiXFnz/wg8o3Q9+GEskggSiQDIk9HSZf3JiUBIZHIqH
         xmpmQbakO887Ps7lH3GCFoZHRwfYiLdlc2sWGw/bO6YgDVAWuVhkiRE9vPgaeEWCWE
         Ca6ysL1dr2LDWCOPtXrJovRA8vgmD+zylEYoO/gl2SqpK7nzbxWc2ECHyLvZu1OoTZ
         lruRSK09D0dMvCWv8zlrcsPS7jQT7fDZ8Z5izy+kA4Zbw4Pt1iZ7Ea94gqdSVPtY/z
         kMWfwERX96bRQ==
Received: (nullmailer pid 1121284 invoked by uid 1000);
        Fri, 28 Jul 2023 19:15:18 -0000
Date:   Fri, 28 Jul 2023 13:15:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 27/50] dt-bindings: usb: atmel: add sam9x7
Message-ID: <20230728191518.GA869757-robh@kernel.org>
References: <20230728102753.266660-1-varshini.rajendran@microchip.com>
 <f042b194-659a-b128-7f5a-572150bf532f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f042b194-659a-b128-7f5a-572150bf532f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 06:42:53PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 12:27, Varshini Rajendran wrote:
> > Add sam9x7 bindings.
> > 
> > Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/usb/atmel-usb.txt | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > index 12183ef47ee4..82bd0dbc2a48 100644
> > --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > @@ -3,8 +3,9 @@ Atmel SOC USB controllers
> >  OHCI
> >  
> >  Required properties:
> > - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> > -   used in host mode.
> > + - compatible: Should be "atmel,at91rm9200-ohci" or
> > +   "microchip,sam9x7-ohci", "atmel,at91rm9200-ohci"
> > +   for USB controllers used in host mode.
> >   - reg: Address and length of the register set for the device
> >   - interrupts: Should contain ohci interrupt
> >   - clocks: Should reference the peripheral, host and system clocks
> > @@ -30,8 +31,9 @@ usb0: ohci@500000 {
> >  EHCI
> >  
> >  Required properties:
> > - - compatible: Should be "atmel,at91sam9g45-ehci" for USB controllers
> > -   used in host mode.
> > + - compatible: Should be "atmel,at91sam9g45-ehci" or
> > +   "microchip,sam9x7-ehci", "atmel,at91sam9g45-ehci"
> 
> This confuses me. Isn't microchip,sam9x7-ehci already described in EHCI
> bindings?

The Atmel .dts (including the one in this series) files use usb-ohci and 
usb-ehci compatibles, but they have extra properties (and clocks are 
different IIRC). So they aren't 'generic' and should drop those 
compatibles. There's already warnings generated for this, but obviously 
no one is paying attention.

Rob
