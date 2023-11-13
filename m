Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40BB7E9CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjKMNPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:15:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6C172D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:15:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC16CC433C8;
        Mon, 13 Nov 2023 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699881332;
        bh=IUou9g1eC7eRyhYqxTZ2wecJaQRhh+vOQhsR2yztLhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Za5Hz+lfHckCYadClxj9S0HmEayg0pbrmOvWPNveXQM/WkSLZXIDPV+PF8DOId7ba
         53CZUqxcsNJl3kGjiSzF5hUxbt0ONRMxi7QL6efvnR09VEVUA5159sq2m6I/FRL1j3
         j+sFscRcacyHwWiDba9D0GeFD+H3GgjmSoKPq0IFoBOGG24+piLxfuQVC5EypMSJcp
         2sA8cry5c8+XiHGZy/J3S3TML4us/VSr+lWvXxfiTA/Yf0O+mAX/plKxTr62YFSPMw
         hnL59cvZmWjmMtJMufOcp04JY8MuzNNquCr7RmvuUz38PSFwTmhuwMugmGv65z4dKI
         sD5XqKbud0cTQ==
Date:   Mon, 13 Nov 2023 21:03:11 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 1/2] riscv: dts: cv1800b: add pinctrl node for cv1800b
Message-ID: <ZVIejw2O6on8QMYy@xhacker>
References: <20231113005702.2467-1-jszhang@kernel.org>
 <20231113005702.2467-2-jszhang@kernel.org>
 <58a99001-8260-4970-9fc7-25fe81e557a5@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58a99001-8260-4970-9fc7-25fe81e557a5@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 08:51:20PM -0500, Samuel Holland wrote:
> On 2023-11-12 6:57 PM, Jisheng Zhang wrote:
> > Add the reset device tree node to cv1800b SoC reusing the
>           ^^^^^
>           I assume you mean pinctrl here?

oops copy and paste the commit msg ;) thanks
> 
> > pinctrl-single driver.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv-pinctrl.h | 19 +++++++++++++++++++
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 10 ++++++++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv-pinctrl.h b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> > new file mode 100644
> > index 000000000000..ed78b6fb3142
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> 
> A couple of questions: Should this go in include/dt-bindings? And is it worth

When I cooked this series two weeks ago, I did put it in dt-binding, but
then I found commit fe49f2d776f799 ("arm64: dts: ti: Use local header for
pinctrl register values"), "These definitions were previously put in the
bindings header to avoid code duplication and to provide some context
meaning (name), but they do not fit the purpose of bindings." which is
suggested and acked by Krzysztof, so I just want to follow the style
here.


> including macros for the actual function mappings, like in the vendor source[1]?

Do you want something as the following?

#define UART0_TX	0
#define CAM_MCLK1	1
...

#define REG_UART0_TX	0x24
...

pinctrl-single,pins = <REG_UART0_TX UART0_TX>;

Other pinctl-single users just uses the register value directly, I have
no preference. But I'd like to get suggestions from DT and pinctl-single
maintainers. Hi Rob, Krzysztof, Conor, Tony, what's your opinion?

> 
> [1]:
> https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/drivers/pinctrl/cvitek/cv180x_pinlist_swconfig.h
> 
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * This header provides constants for pinctrl bindings for Sophgo CV* SoC.
> > + *
> > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +#ifndef _DTS_RISCV_SOPHGO_CV_PINCTRL_H
> > +#define _DTS_RISCV_SOPHGO_CV_PINCTRL_H
> > +
> > +#define MUX_M0		0
> > +#define MUX_M1		1
> > +#define MUX_M2		2
> > +#define MUX_M3		3
> > +#define MUX_M4		4
> > +#define MUX_M5		5
> > +#define MUX_M6		6
> > +#define MUX_M7		7
> > +
> > +#endif
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > index e04df04a91c0..7a44d8e8672b 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -6,6 +6,8 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/reset/sophgo,cv1800b-reset.h>
> >  
> > +#include "cv-pinctrl.h"
> > +
> >  / {
> >  	compatible = "sophgo,cv1800b";
> >  	#address-cells = <1>;
> > @@ -55,6 +57,14 @@ soc {
> >  		dma-noncoherent;
> >  		ranges;
> >  
> > +		pinctrl0: pinctrl@3001000 {
> > +			compatible = "pinctrl-single";
> > +			reg = <0x3001000 0x130>;
> > +			#pinctrl-cells = <1>;
> > +			pinctrl-single,register-width = <32>;
> > +			pinctrl-single,function-mask = <0x00000007>;
> > +		};
> 
> From the vendor driver[2], it looks like this peripheral block only handles
> pinmuxing, so indeed this looks like a good use of pinctrl-single.

This is deffinitely pinctrl-single style pinmux controller ;)

> 
> [2]:
> https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/drivers/pinctrl/cvitek/pinctrl-cv180x.h
> 
> > +
> >  		rst: reset-controller@3003000 {
> >  			compatible = "sophgo,cv1800b-reset";
> >  			reg = <0x03003000 0x1000>;
> 
