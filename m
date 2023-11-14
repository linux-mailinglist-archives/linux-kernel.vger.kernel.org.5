Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAA7EB2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjKNO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:58:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC710D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:58:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A79EC433C8;
        Tue, 14 Nov 2023 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699973918;
        bh=0EG0AEP+OoGuvIOQpS68GDDBe/uBCpjeDc5+bp7MX8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0aobSsAdILu3wEY6NGHTWkUN5ZL4RJ7fB806eCXdAcEqEEuvwAom4L+HtjuSTklZ
         ANBiJltW/qtuqTjPzMhpDpmaGH3t17M/f1gXJ9cWunSTz46oA3s3nOfWJyIalKCJy6
         tI7wy+Uazfq/RX4ByDdVS+vpPHh2X9j/uH/eTFlnOTiMqxCvLITbY2XzHvDAGWK9+R
         USxZNZUuyWAhUuOe7jihyWNV0ukCrK4E3zRoY/1bnPMK1mSVRlcuuNbDsyD4iExwPg
         Xbh2gjsOcWSWa5x21UwbYS4lG9CgnDHcWErZajVjNki9liJDTkFphbQUYpv6TgY+5Y
         iUfyb8G+YMcTA==
Date:   Tue, 14 Nov 2023 22:46:11 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] riscv: dts: cv1800b: add pinctrl node for cv1800b
Message-ID: <ZVOIMy0BB1eVwWup@xhacker>
References: <20231113005702.2467-1-jszhang@kernel.org>
 <20231113005702.2467-2-jszhang@kernel.org>
 <MA0P287MB033298A1F0F1B59CDF110E52FEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB033298A1F0F1B59CDF110E52FEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:38:47AM +0800, Chen Wang wrote:
> 
> On 2023/11/13 8:57, Jisheng Zhang wrote:
> > Add the reset device tree node to cv1800b SoC reusing the
> > pinctrl-single driver.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/boot/dts/sophgo/cv-pinctrl.h | 19 +++++++++++++++++++
> >   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 10 ++++++++++
> >   2 files changed, 29 insertions(+)
> >   create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> 
> 
> I'm afraid there will not be more cv* chip in coming days. So I would
> suggest you use "cv1800b-pinctrl.h" first here. If we see more cv* coming,
> and if they will reuse the definition here, we can consider optimize the
> filename, what do you think?
> 
> BTW, how about defining the file name as "cv1800b.h" and I'm not sure if you

hmm, cv1800b-pinctrl.h is fine. Only pinctrl related stuff will be put
there.

> will have more macro const definition for other modules?
> 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv-pinctrl.h b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> > new file mode 100644
> > index 000000000000..ed78b6fb3142
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
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
> >   #include <dt-bindings/interrupt-controller/irq.h>
> >   #include <dt-bindings/reset/sophgo,cv1800b-reset.h>
> > +#include "cv-pinctrl.h"
> > +
> >   / {
> >   	compatible = "sophgo,cv1800b";
> >   	#address-cells = <1>;
> > @@ -55,6 +57,14 @@ soc {
> >   		dma-noncoherent;
> >   		ranges;
> > +		pinctrl0: pinctrl@3001000 {
> > +			compatible = "pinctrl-single";
> > +			reg = <0x3001000 0x130>;
> > +			#pinctrl-cells = <1>;
> > +			pinctrl-single,register-width = <32>;
> > +			pinctrl-single,function-mask = <0x00000007>;
> > +		};
> > +
> >   		rst: reset-controller@3003000 {
> >   			compatible = "sophgo,cv1800b-reset";
> >   			reg = <0x03003000 0x1000>;
