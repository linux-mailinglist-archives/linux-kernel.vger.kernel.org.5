Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6518E769884
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjGaNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjGaNzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:55:02 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 06:52:59 PDT
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791A19B0;
        Mon, 31 Jul 2023 06:52:58 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:35:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1690810576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
         references:references; bh=D0C9W4jLWSTvnH8GOqVr0jR88Cd4UebzZne1ky7oQew=;
        b=MgCaJUUhtnwJoabwcOv/O2xDIrYyU6e2SrIdTvpRF6hQCBOUwM43hoGiBDHxfeOvLgytKm
        E/s1em5jauL5/eDip6Z0a0Q4wmHaM0lHd/YUnaNq57TZAb+jQ76miKtoulqJTKefuzPPMh
        YsK0EKUMHQKC6NxppBGQIvaQoi+KFwz6yBuWKu1lEg/FGUS2KWohgybOvHx031wiEV+pY1
        w1sU6nGM0DHfDX4/FjJ/MiD69uxnqc+4j2tz8JpfD0MPUCv4NevSDVAmibrOwwJUaqP3p7
        WL8TbB+VpJoKmCndRZDqIf+PGy3q9LgX0Ql1PsqQuunp4h+33rjJNlAH2JGdyw==
From:   Alexander Dahl <ada@thorsis.com>
To:     Durai Manickam KR <durai.manickamkr@microchip.com>
Cc:     Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, varshini.rajendran@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com, cristian.birsan@microchip.com,
        nicolas.ferre@microchip.com, krzysztof.kozlowski@linaro.org,
        alexandre.belloni@bootlin.com, davem@davemloft.net, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, Horatiu.Vultur@microchip.com,
        robh+dt@kernel.org, andrew@lunn.ch, michael@walle.cc,
        jerry.ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, andre.przywara@arm.com, ada@thorsis.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv3 2/2] ARM: dts: at91: sam9x60: fix the SOC detection
Message-ID: <20230731-confess-prison-0ce898c937ba@ifak-system.com>
Mail-Followup-To: Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com,
        balamanikandan.gunasundar@microchip.com, manikandan.m@microchip.com,
        varshini.rajendran@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com,
        cristian.birsan@microchip.com, nicolas.ferre@microchip.com,
        krzysztof.kozlowski@linaro.org, alexandre.belloni@bootlin.com,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, jerry.ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, andre.przywara@arm.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230718065735.10187-1-durai.manickamkr@microchip.com>
 <20230718065735.10187-3-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718065735.10187-3-durai.manickamkr@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Durai,

Am Tue, Jul 18, 2023 at 12:27:35PM +0530 schrieb Durai Manickam KR:
> Defining the dbgu compatible strings in the UART submodule of the
> flexcom gives the below error log,
> AT91: Could not find matching SoC description
> This error arises due to defining the dbgu compatible strings to
> the flexcom usart which is not valid because there is only one debug unit
> in the sam9x60 SOC and it has the chipid register. The dbgu compatible
> strings are valid only for debug usart and not valid for flexcom usart.
> Thus removing the dbgu compatible strings in the UART submodule of the
> flexcom for the proper SOC detection.
> 
> Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>

Acked-by: Alexander Dahl <ada@thorsis.com>

(The diff of the patch is identical to the diff of a quick hacked
patch I made weeks ago for my BSP which fixed the issue.  SoC variant
was reported correctly on serial console on boot again.  However I did
not actually test *your* patch on my hardware (sam9x60 curiosity),
thus Acked-by and not Tested-by.)

Greets
Alex

> ---
>  arch/arm/boot/dts/microchip/sam9x60.dtsi | 26 ++++++++++++------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 8b53997675e7..73d570a17269 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -172,7 +172,7 @@ flx4: flexcom@f0000000 {
>  				status = "disabled";
>  
>  				uart4: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -240,7 +240,7 @@ flx5: flexcom@f0004000 {
>  				status = "disabled";
>  
>  				uart5: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>  					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> @@ -370,7 +370,7 @@ flx11: flexcom@f0020000 {
>  				status = "disabled";
>  
>  				uart11: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -419,7 +419,7 @@ flx12: flexcom@f0024000 {
>  				status = "disabled";
>  
>  				uart12: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -576,7 +576,7 @@ flx6: flexcom@f8010000 {
>  				status = "disabled";
>  
>  				uart6: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -625,7 +625,7 @@ flx7: flexcom@f8014000 {
>  				status = "disabled";
>  
>  				uart7: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -674,7 +674,7 @@ flx8: flexcom@f8018000 {
>  				status = "disabled";
>  
>  				uart8: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -723,7 +723,7 @@ flx0: flexcom@f801c000 {
>  				status = "disabled";
>  
>  				uart0: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -791,7 +791,7 @@ flx1: flexcom@f8020000 {
>  				status = "disabled";
>  
>  				uart1: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -859,7 +859,7 @@ flx2: flexcom@f8024000 {
>  				status = "disabled";
>  
>  				uart2: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -927,7 +927,7 @@ flx3: flexcom@f8028000 {
>  				status = "disabled";
>  
>  				uart3: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -1050,7 +1050,7 @@ flx9: flexcom@f8040000 {
>  				status = "disabled";
>  
>  				uart9: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> @@ -1099,7 +1099,7 @@ flx10: flexcom@f8044000 {
>  				status = "disabled";
>  
>  				uart10: serial@200 {
> -					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
> +					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>  					reg = <0x200 0x200>;
>  					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
>  					dmas = <&dma0
> -- 
> 2.25.1
> 
