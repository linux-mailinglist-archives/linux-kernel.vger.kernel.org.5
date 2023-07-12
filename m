Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A417511A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjGLUE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGLUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:04:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8A1FE3;
        Wed, 12 Jul 2023 13:04:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23E21FF804;
        Wed, 12 Jul 2023 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689192291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uf07aWwxqS6bJXefNHLHC0SKpcJoW7tT0rLIzQvdFcY=;
        b=aVkJ5ervT6vBrP9wp2f90mAdQLLSE0Tdzt+cb2z48xTsyr9cOm8njToKJRB3LKZ9V7Y6b4
        Skf+r7RGLo443DAetD/M6Uad64wfO1Q/UrEDYR5TSm10zZ0leDqLaQbOmaEWSHvxC/18R8
        Y4OuVze7bDYK//U0UYdfOMg11Gf36XFJJ4Bm2XX6Mk+HjBZhjNtWGDVeF5LNKG+EJrXXdI
        ZDlGFHIqHy91jUceBgxhODLy7F3uX+0I+jwugcOcMhpcsFppH2a0a3sxzYDOqJBWCMU3jQ
        1orxO1mUjFD5mBtG/LIrNjngAECJ2Vdeo0pj0E7TBw6yydKMNtrFw7UJIY29ug==
Date:   Wed, 12 Jul 2023 22:04:47 +0200
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
Message-ID: <20230712200447118d91bc@mail.local>
References: <20230712100042.317856-1-durai.manickamkr@microchip.com>
 <20230712-dweeb-suspend-27d0f7292a2d@spud>
 <202307121930333019a9d5@mail.local>
 <20230712-revolving-tactful-67cdb02c664b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-revolving-tactful-67cdb02c664b@spud>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 20:42:00+0100, Conor Dooley wrote:
> > There can be only one dbgu on a SoC and it has the chipid register. It
> > has always been wrong to have a dbgu compatible on the flexcom uart as
> > they are not dbgu.
> 
> Ahh, thanks for the explanation. Sounds like stuff that might be obvious
> to those working on arm stuff all the time, but not all of those CCed on
> the patch ;)

Well, this is not really arm specific, rather microchip specific ;)

> The correct thing to do would seem to be updating the dt-binding to
> something that permits what is listed below, or just removing the second
> compatible, to leave "microchip,sam9x60-usart" in isolation, since that
> is permitted also.
> 
> > Anyway, my advice has always been that you must not do chipid detection
> > on at91 because there is no point in doing it because you need to have
> > a correct dts to be able to find the dbgu chipid register so you either
> > you already know what you are running on or you are going to read bogus
> > registers anyway.
> 
> I won't claim to have an opinion on any of that, but sounds like you'd
> be better off just reading the board/SoC level compatibles to figure out
> what you are running on...
> 

Yeah, exactly my point!

> Thanks,
> Conor.
> 
> > > > Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
> > > > Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> > > > ---
> > > >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 26 ++++++++++++------------
> > > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > > index 8b53997675e7..73d570a17269 100644
> > > > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > > @@ -172,7 +172,7 @@ flx4: flexcom@f0000000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart4: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -240,7 +240,7 @@ flx5: flexcom@f0004000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart5: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> > > >  					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> > > > @@ -370,7 +370,7 @@ flx11: flexcom@f0020000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart11: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -419,7 +419,7 @@ flx12: flexcom@f0024000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart12: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -576,7 +576,7 @@ flx6: flexcom@f8010000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart6: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -625,7 +625,7 @@ flx7: flexcom@f8014000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart7: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -674,7 +674,7 @@ flx8: flexcom@f8018000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart8: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -723,7 +723,7 @@ flx0: flexcom@f801c000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart0: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -791,7 +791,7 @@ flx1: flexcom@f8020000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart1: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -859,7 +859,7 @@ flx2: flexcom@f8024000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart2: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -927,7 +927,7 @@ flx3: flexcom@f8028000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart3: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -1050,7 +1050,7 @@ flx9: flexcom@f8040000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart9: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > @@ -1099,7 +1099,7 @@ flx10: flexcom@f8044000 {
> > > >  				status = "disabled";
> > > >  
> > > >  				uart10: serial@200 {
> > > > -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> > > > +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
> > > >  					reg = <0x200 0x200>;
> > > >  					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> > > >  					dmas = <&dma0
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > 
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
