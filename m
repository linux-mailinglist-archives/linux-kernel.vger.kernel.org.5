Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73D7EB304
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjKNPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKNPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:07:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855410D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:07:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF6C433C8;
        Tue, 14 Nov 2023 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699974450;
        bh=BVqDcYpXntfuz/Ud2ECCfNPZwTZVgYgcP1GTHwqqbDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p42iCVOSIm4hBmO/hrs12ZZ5jZ5z0+3Rqok51445Q4YhW96mgui/5DgZwCZFualbd
         rti0OiAgRp2wj+61eCSAK8nG3Ol/RGAABzQVA2H09/+J4DlBgfhWCW+7Fvc+r9rD7T
         zY30yzlq+0PsKgnTATmj6IEehbD4CZ6qjBY1HcwZOQHDFkTU8LWvPUEAKscYwQsv4w
         smRfYNtg4ej7CGoJ13DEChuY2OECLt1ZCO8C4W9lVf3F6qLfEapgXqHu+mN9FKOeW6
         pzxL0grwu+p35eAAkzI4P9DcK0JRO/H/VODrLUtLm08LMwa8fyvfHn+r3YKjz2sNuQ
         ENex3QTkoXGDg==
Date:   Tue, 14 Nov 2023 22:55:06 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Yixun Lan <dlan@gentoo.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/4] riscv: dts: sophgo: add reset dt node for cv1800b
Message-ID: <ZVOKStmcyXtH4oZS@xhacker>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-4-jszhang@kernel.org>
 <20231113143224.GA130254@ofsar>
 <ZVI9bzAhPnHhVg8A@xhacker>
 <7cccf188-c47f-4865-95ce-dcfedc1429dc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cccf188-c47f-4865-95ce-dcfedc1429dc@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:37:35AM -0500, Samuel Holland wrote:
> Hi Jisheng,

Hi Samuel,

> 
> On 2023-11-13 9:14 AM, Jisheng Zhang wrote:
> > On Mon, Nov 13, 2023 at 02:32:24PM +0000, Yixun Lan wrote:
> >> On 08:55 Mon 13 Nov     , Jisheng Zhang wrote:
> >>> Add the reset device tree node to cv1800b SoC.
> >>>
> >>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >>> ---
> >>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> >>> index df40e87ee063..4032419486be 100644
> >>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> >>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> >>> @@ -54,6 +54,12 @@ soc {
> >>>  		dma-noncoherent;
> >>>  		ranges;
> >>>  
> >>> +		rst: reset-controller@3003000 {
> >>> +			compatible = "sophgo,cv1800b-reset";
> >>> +			reg = <0x03003000 0x1000>;
> >>                                           ~~~~~~~
> >> 			        it should be 0x28
> > 
> > The reg space is 4KB, but only 0x28 are used. I think 0x1000 or 0x28 are fine
> > since the ioremap granule is 4kB.
> >>
> >> while please also note the 0x24 == SOFT_CPUAC_RSTN, does not compatible
> >> with the reset-simple driver, but as it's not implemented nor used in this driver,
> > 
> > But the functionality of this "autoclear" reg isn't used at all since we also
> > have "sticky" reset to acchieve the same feature, I.E reset cpusys. And in the
> > usage case of reseting cpusys, I believe "sticky" reset is preferred.
> > 
> > And except the cpusys reset which has both autoclear and sticky, other
> > resets are sticky only. I'm not sure whether it's worth to write a new
> > driver for almost useless feature.
> 
> As long as the device has its own binding/compatible string, it is always
> possible to replace RESET_SIMPLE with a custom driver later if needed. (Or use a
> more complicated driver in some other context, e.g. firmware).

Good idea, indeed if needed we can implement a customized driver, and I think
this can acchieve both backward and forward DT compatbility ;)

As for firmware, I guess you mean the little c906 core os firmware. Here
is my draft plan:

a sophgo custom remoteproc driver which will do something like:

load the firmware;
reset_assert(rst);
prepara cpu entry address and so on;
reset_deassert(rst);

so sticky reset still works perfectly. While I believe autoclear reset
may not work if the reset clears something we have set.

> 
> Regards,
> Samuel
> 
> >> so we should be fine with this?
> >>
> >>> +			#reset-cells = <1>;
> >>> +		};
> >>> +
> >>>  		uart0: serial@4140000 {
> >>>  			compatible = "snps,dw-apb-uart";
> >>>  			reg = <0x04140000 0x100>;
> >>> -- 
> >>> 2.42.0
> >>>
> >>
> >> -- 
> >> Yixun Lan (dlan)
> >> Gentoo Linux Developer
> >> GPG Key ID AABEFD55
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
