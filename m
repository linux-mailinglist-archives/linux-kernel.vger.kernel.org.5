Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07E0751141
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGLTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGLTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:30:41 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499991FCC;
        Wed, 12 Jul 2023 12:30:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99402E0002;
        Wed, 12 Jul 2023 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689190237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQi7H3c3nk4JZA7oSDJR3Dio4GsnvuYaaMgfNSDzDLI=;
        b=n/gz+p3zPYElbLusrTKvwGPoD0fyDRH1ZG9dINhPcFeVB9CVGFLlzwOGafXDh1hvlVjaKo
        Aqh1slY+fMjJG9kHCAfnMLMb+uB0qBbLQAPtF3tn7WZzpb1rcIXR+Bwi2StUwQSa9tqKnA
        1IlEiW7Mnty1JWJWTqNkT4sjVE6dr5/eqL+AM5N0wmVgoYL6ckqX9Dpa5VKw9ZyzCVUe5a
        K8fmi41fZR/oTh2rexjy3BKSnM0UFvMZMIdu0oA+4Ttc2dqYCMZWlUt8bqtuTRZBBWrUR8
        KtQTRCzaegQt36ssaqyj0KGT5Jbw4eMEUey2sETb19jHAwgI7DFZKPYtp97rdQ==
Date:   Wed, 12 Jul 2023 21:30:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, cristian.birsan@microchip.com,
        nicolas.ferre@microchip.com, krzysztof.kozlowski@linaro.org,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, jerry.ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, sergiu.moga@microchip.com,
        andre.przywara@arm.com, ada@thorsis.com
Subject: Re: [PATCH] ARM: dts: at91: sam9x60: fix the SOC detection
Message-ID: <202307121930333019a9d5@mail.local>
References: <20230712100042.317856-1-durai.manickamkr@microchip.com>
 <20230712-dweeb-suspend-27d0f7292a2d@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-dweeb-suspend-27d0f7292a2d@spud>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 19:43:51+0100, Conor Dooley wrote:
> Hey,
> 
> On Wed, Jul 12, 2023 at 03:30:42PM +0530, Durai Manickam KR wrote:
> > Remove the dbgu compatible strings in the UART submodule of the
> > flexcom for the proper SOC detection.
> 
> I am afraid that I do not understand what this means. The first
> compatible, before and after your patch, is a sam9x60 one, so I don't
> see how the SoC comes into it. Grepping to try and understand:
> rg microchip,sam9x60-usart drivers/
> 
> rg microchip,sam9x60-dbgu drivers/
> 
> rg atmel,at91sam9260-dbgu drivers/
> drivers/soc/atmel/soc.c
> 259:					     "atmel,at91sam9260-dbgu");
> 
> rg atmel,at91sam9260-usart drivers/
> drivers/tty/serial/atmel_serial.c
> 2723:OF_EARLYCON_DECLARE(atmel_serial, "atmel,at91sam9260-usart",
> 
> drivers/mfd/at91-usart.c
> 50:	{ .compatible = "atmel,at91sam9260-usart" },
> 
> It looks like you are trying to avoid the atmel soc driver from
> detecting the atmel,at91sam9260-dbgu compatible?
> Is this not actually compatible with the sam9260's debug uart?
> 
> Please try to explain things in more detail so that people unfamiliar
> with at91 hardware are not confused. As an outsider, removing
> compatibles to fix detection seems like it would not work - the sam9x60
> compatibles are first in the list. To me it seems like this removes,
> rather than fixes detection, and to fix detection you would need to
> make some changes to the driver?
> 
> Also, the binding says:
>       - items:
>           - const: microchip,sam9x60-dbgu
>           - const: microchip,sam9x60-usart
>           - const: atmel,at91sam9260-dbgu
>           - const: atmel,at91sam9260-usart
> 
> Your patch here makes the dts non-compliant with the bindings, as far as
> I can tell, so you will need to go and modify the bindings to do this
> either way.

There can be only one dbgu on a SoC and it has the chipid register. It
has always been wrong to have a dbgu compatible on the flexcom uart as
they are not dbgu.

Anyway, my advice has always been that you must not do chipid detection
on at91 because there is no point in doing it because you need to have
a correct dts to be able to find the dbgu chipid register so you either
you already know what you are running on or you are going to read bogus
registers anyway.

> 
> Thanks,
> Conor.
> 
> > 
> > Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
> > Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> > ---
> >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 26 ++++++++++++------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > index 8b53997675e7..73d570a17269 100644
> > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > @@ -172,7 +172,7 @@ flx4: flexcom@f0000000 {
> >  				status = "disabled";
> >  
> >  				uart4: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -240,7 +240,7 @@ flx5: flexcom@f0004000 {
> >  				status = "disabled";
> >  
> >  				uart5: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> >  					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> > @@ -370,7 +370,7 @@ flx11: flexcom@f0020000 {
> >  				status = "disabled";
> >  
> >  				uart11: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -419,7 +419,7 @@ flx12: flexcom@f0024000 {
> >  				status = "disabled";
> >  
> >  				uart12: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -576,7 +576,7 @@ flx6: flexcom@f8010000 {
> >  				status = "disabled";
> >  
> >  				uart6: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -625,7 +625,7 @@ flx7: flexcom@f8014000 {
> >  				status = "disabled";
> >  
> >  				uart7: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -674,7 +674,7 @@ flx8: flexcom@f8018000 {
> >  				status = "disabled";
> >  
> >  				uart8: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -723,7 +723,7 @@ flx0: flexcom@f801c000 {
> >  				status = "disabled";
> >  
> >  				uart0: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -791,7 +791,7 @@ flx1: flexcom@f8020000 {
> >  				status = "disabled";
> >  
> >  				uart1: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -859,7 +859,7 @@ flx2: flexcom@f8024000 {
> >  				status = "disabled";
> >  
> >  				uart2: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -927,7 +927,7 @@ flx3: flexcom@f8028000 {
> >  				status = "disabled";
> >  
> >  				uart3: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -1050,7 +1050,7 @@ flx9: flexcom@f8040000 {
> >  				status = "disabled";
> >  
> >  				uart9: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > @@ -1099,7 +1099,7 @@ flx10: flexcom@f8044000 {
> >  				status = "disabled";
> >  
> >  				uart10: serial@200 {
> > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> >  					reg = <0x200 0x200>;
> >  					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> >  					dmas = <&dma0
> > -- 
> > 2.25.1
> > 



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
