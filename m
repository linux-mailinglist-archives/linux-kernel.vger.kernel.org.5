Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541E7D70D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbjJYP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344878AbjJYP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:26:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305EE1FCE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:25:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120C1C433C7;
        Wed, 25 Oct 2023 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698247557;
        bh=XNtqmjzlGoaxXATR3hfkSbSFqAPY5X6MkYdWKvJljr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIrWXIAj85SXqAP4C2Dj4+engdAvrNekV9ljm3XKOtePy1hwdO0o9VP+bsRJqORKU
         QKl2HohkReBC82jPccVy+9BMut/SzwcXVin5kZfm3Jtj3Nk+KSrnBH2Cfp4bhwANZW
         NirYI/ePMwf/Qkdc9+OxfABKlFuQe087xarez2hpsvDCoiggpoAjXBX8QjUGKrM6SM
         rYp6S7MJxBtBgphivsAxMga7Kx/8+09G6NesVDoBT2gNj98bE5InuOja7XGqU6LSyu
         c6HhMfQOAXYjGYSRISPo+cytz7GELTtK7WHHBLpz7FEIpHPBSim+ud/QRv+ON1P0Zs
         CnD8TAb41TYQw==
Date:   Wed, 25 Oct 2023 23:13:39 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: sophgo: remove address-cells from intc
 node
Message-ID: <ZTkwo/u6S9Atp2u3@xhacker>
References: <20231024-maternity-slang-fd3dcfb211c0@spud>
 <MA0P287MB0332C00AB091FD7139560E25FEDEA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB0332C00AB091FD7139560E25FEDEA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:48:57AM +0800, Chen Wang wrote:
> 
> On 2023/10/24 16:20, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > A recent submission [1] from Rob has added additionalProperties: false
> > to the interrupt-controller child node of RISC-V cpus, highlighting that
> > the new cv1800b DT has been incorrectly using #address-cells.
> > It has no child nodes, so #address-cells is not needed. Remove it.
> > 
> > Link: https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.4184468-1-robh@kernel.org/ [1]
> > Fixes: c3dffa879cca ("riscv: dts: sophgo: add initial CV1800B SoC device tree")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Nice catch!

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>


> > ---
> > CC: Chao Wei <chao.wei@sophgo.com>
> > CC: Chen Wang <unicorn_wang@outlook.com>
> > CC: Rob Herring <robh+dt@kernel.org>
> > CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: Albert Ou <aou@eecs.berkeley.edu>
> > CC: devicetree@vger.kernel.org
> > CC: linux-riscv@lists.infradead.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > index df40e87ee063..aec6401a467b 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -34,7 +34,6 @@ cpu0: cpu@0 {
> >   			cpu0_intc: interrupt-controller {
> >   				compatible = "riscv,cpu-intc";
> >   				interrupt-controller;
> > -				#address-cells = <0>;
> >   				#interrupt-cells = <1>;
> >   			};
> >   		};
> 
> Acked-by: Chen Wang <unicorn_wang@outlook.com>
> 
> Thanks，btw, will it be merged in 6.7?

Don't worry, this is a fix, I think Conor will submit fix PR once rc1 is out.

> 
> Looping Jisheng who is working on Duo/cv1800b.
> 
