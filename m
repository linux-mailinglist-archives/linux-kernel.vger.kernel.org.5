Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57D7E9FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjKMP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKMP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:27:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0096D67
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:27:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35813C433C8;
        Mon, 13 Nov 2023 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699889236;
        bh=DRPBcEhQyl5dBAyB3ocbVXLLrdNG2CNj1hnyQAWHnHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYHatumpK1ANV48WUwMjoE3E52AEZimGacsM7qM5CtMdYWnLpO64MElZyeVRny1Ts
         dgte0Jjd2mztihTSm7cR8QfDZClb0X/qCPxHlGx8l3qCqJGb0a0EYvCyNC46vAPK9x
         1bvAJw7FdItWQ7rhdRpJw6TmVJ0DQdNiwBAbIj+Dx86gLuAdO4/nYT94nPU+qK1gpi
         n6PZ1irGbhIuqIYwnsM5WPYnw/PY2zCDBKputfvI+H/z1XzN9Bf/J54GAV/EivZpJj
         tEdCeYgBKvcIJ2ldwk9VjM56jhan8eGRy194Bh1yFTyWepLP1oTxBHwhfIsMg3h/iT
         ukM7SpElUSf5A==
Date:   Mon, 13 Nov 2023 23:14:55 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Yixun Lan <dlan@gentoo.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
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
Message-ID: <ZVI9bzAhPnHhVg8A@xhacker>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-4-jszhang@kernel.org>
 <20231113143224.GA130254@ofsar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113143224.GA130254@ofsar>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 02:32:24PM +0000, Yixun Lan wrote:
> Hi Jisheng:

Hi

> 
> On 08:55 Mon 13 Nov     , Jisheng Zhang wrote:
> > Add the reset device tree node to cv1800b SoC.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > index df40e87ee063..4032419486be 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -54,6 +54,12 @@ soc {
> >  		dma-noncoherent;
> >  		ranges;
> >  
> > +		rst: reset-controller@3003000 {
> > +			compatible = "sophgo,cv1800b-reset";
> > +			reg = <0x03003000 0x1000>;
>                                           ~~~~~~~
> 			        it should be 0x28

The reg space is 4KB, but only 0x28 are used. I think 0x1000 or 0x28 are fine
since the ioremap granule is 4kB.
> 
> while please also note the 0x24 == SOFT_CPUAC_RSTN, does not compatible
> with the reset-simple driver, but as it's not implemented nor used in this driver,

But the functionality of this "autoclear" reg isn't used at all since we also
have "sticky" reset to acchieve the same feature, I.E reset cpusys. And in the
usage case of reseting cpusys, I believe "sticky" reset is preferred.

And except the cpusys reset which has both autoclear and sticky, other
resets are sticky only. I'm not sure whether it's worth to write a new
driver for almost useless feature.

> so we should be fine with this?
> 
> > +			#reset-cells = <1>;
> > +		};
> > +
> >  		uart0: serial@4140000 {
> >  			compatible = "snps,dw-apb-uart";
> >  			reg = <0x04140000 0x100>;
> > -- 
> > 2.42.0
> > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
