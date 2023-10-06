Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBFB7BB7B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjJFMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:33:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956ECE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:33:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7923DC433C7;
        Fri,  6 Oct 2023 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595599;
        bh=kaiiRDqph/9/dNfSPDM1f2ksRyqa+Xp41z4ukvjjt7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgybpyT9S78ECB5xM7ySYBUNt1IURI8e61hnxc3sraXfwIGf5mAyJiQkxEpV88wBT
         tRmt3Kc/yxWN8U7TyN7jhn5GImY+Ww6xRl5cV+kf+mzhLuSv6QC9rMnOgL3L4nHV74
         Gt6cwPlWo1BjJ/rzWZCqv3a0r2p7tMW4OoEuj8Cx+fVnI+uJYjFvdcbSGmG5jHunxU
         f/LpdwMIuMdIUKVsC8fZVBgzHL6zC8IkntP4kdgbTOsuFsw5U1Q2RJFCPrkLORondq
         C2rXbvhRjAriCd/OlD6MLROitNlWV2kOidzGhgazz2byw7eXw6cKwZchftqk0UZ3n6
         VzylQjTR1Ylcw==
Date:   Fri, 6 Oct 2023 20:21:09 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device
 tree
Message-ID: <ZR/7te8fdBQWIZXH@xhacker>
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-5-jszhang@kernel.org>
 <20231002-pessimism-sycamore-a854a098cf43@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002-pessimism-sycamore-a854a098cf43@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:09:38PM +0100, Conor Dooley wrote:
> On Sat, Sep 30, 2023 at 08:39:36PM +0800, Jisheng Zhang wrote:
> > Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 117 ++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > new file mode 100644
> > index 000000000000..8829bebaa017
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	compatible = "sophgo,cv1800b";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	cpus: cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		timebase-frequency = <25000000>;
> > +
> > +		cpu0: cpu@0 {
> > +			compatible = "thead,c906", "riscv";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			d-cache-block-size = <64>;
> > +			d-cache-sets = <512>;
> > +			d-cache-size = <65536>;
> > +			i-cache-block-size = <64>;
> > +			i-cache-sets = <128>;
> > +			i-cache-size = <32768>;
> > +			mmu-type = "riscv,sv39";
> > +			riscv,isa = "rv64imafdc";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> > +					       "zifencei", "zihpm";
> > +
> > +			cpu0_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#address-cells = <0>;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +	};
> > +
> > +	osc: oscillator {
> > +		compatible = "fixed-clock";
> > +		clock-output-names = "osc_25m";
> > +		#clock-cells = <0>;
> > +	};
> 
> Is this a stub that will later be replaced by a real clock controller
> node, or is this actually a fixed oscillator? If it is the former, could

Hi Conor,

This is a real 25MHZ oscillator. 

Thanks
