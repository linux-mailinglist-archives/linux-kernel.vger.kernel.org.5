Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72DB7E9D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjKMNV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjKMNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:21:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510D172A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:21:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB0CC433C9;
        Mon, 13 Nov 2023 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699881682;
        bh=KCjtPGRJNG1e0l55yc9Fl85FksaID/z/6qmz2c02TJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ru41IK3OjWDOaCHPpcYqHm3fHFO5FRHCFL0FJbo2Y83ZKmHP5bOm4QNc0vImoxxh5
         W8pK8ec66mMOEZBcl8QQcycHoQnP856N2TWp7LHx/gHrqCaRceS6nMqi1jMaOwGVvm
         rOtTxdv3Njs+wM3stEj2CqnL8iTNdldYRY8NVzI8X+KTlq8c6eUbv6nqwkjGXVcGlb
         REiwdE5bkoAOYhBkj6CMue73qy43GrBvQwiGq46F9CDBJDUyr0PFVOz5gPJTbbH7B0
         wP2KaM6MUkDyVjrmQdkTCNG5teii+HJdqM2PsT2Xlskh3Cnw8DrqLu+VJzUvndBeZB
         ne0EleduG7Q0Q==
Date:   Mon, 13 Nov 2023 21:09:01 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 4/4] riscv: dts: sophgo: add reset phandle to all uart
 nodes
Message-ID: <ZVIf7cw1ak+nxnuW@xhacker>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-5-jszhang@kernel.org>
 <95c20c6c-66cd-4f87-920b-5da766317e19@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95c20c6c-66cd-4f87-920b-5da766317e19@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 09:04:55PM -0500, Samuel Holland wrote:
> Hi Jisheng,
> 
> On 2023-11-12 6:55 PM, Jisheng Zhang wrote:
> > Although, the resets are deasserted by default. Add them for
> > completeness.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > index 4032419486be..e04df04a91c0 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/reset/sophgo,cv1800b-reset.h>
> >  
> >  / {
> >  	compatible = "sophgo,cv1800b";
> > @@ -65,6 +66,7 @@ uart0: serial@4140000 {
> >  			reg = <0x04140000 0x100>;
> >  			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&osc>;
> > +			resets = <&rst RST_UART0>;
> 
> Since it's not obvious: this breaks devicetree forward compatibility. An
> existing kernel will fail the devm_reset_control_get_optional_exclusive() in
> 8250_dw.c because it has no driver for the reset controller.
> 
> This may not be a concern yet, since the devicetree is still "in development".
> But it is something to keep in mind for the future. To avoid this sort of
> problem, it's best to fully model the clocks/resets/other dependencies as early
> as possible, and not rely on the firmware setting anything up.

Thank you. This may be discussed before, "DT backward compatibility is a
must while forward compatibility is optional"? maybe I'm wrong.

And Indeed, it's better if we can have forward compatibility, will take
care this in future.

> 
> Regards,
> Samuel
> 
> >  			reg-shift = <2>;
> >  			reg-io-width = <4>;
> >  			status = "disabled";
> > @@ -75,6 +77,7 @@ uart1: serial@4150000 {
> >  			reg = <0x04150000 0x100>;
> >  			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&osc>;
> > +			resets = <&rst RST_UART1>;
> >  			reg-shift = <2>;
> >  			reg-io-width = <4>;
> >  			status = "disabled";
> > @@ -85,6 +88,7 @@ uart2: serial@4160000 {
> >  			reg = <0x04160000 0x100>;
> >  			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&osc>;
> > +			resets = <&rst RST_UART2>;
> >  			reg-shift = <2>;
> >  			reg-io-width = <4>;
> >  			status = "disabled";
> > @@ -95,6 +99,7 @@ uart3: serial@4170000 {
> >  			reg = <0x04170000 0x100>;
> >  			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&osc>;
> > +			resets = <&rst RST_UART3>;
> >  			reg-shift = <2>;
> >  			reg-io-width = <4>;
> >  			status = "disabled";
> > @@ -105,6 +110,7 @@ uart4: serial@41c0000 {
> >  			reg = <0x041c0000 0x100>;
> >  			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&osc>;
> > +			resets = <&rst RST_UART4>;
> >  			reg-shift = <2>;
> >  			reg-io-width = <4>;
> >  			status = "disabled";
> 
