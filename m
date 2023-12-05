Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF39A8057CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442311AbjLEOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbjLEOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:39:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57B1BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:39:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555E2C433C9;
        Tue,  5 Dec 2023 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701787150;
        bh=1+TU9RElFwgbEqSXLhGK9BZkBQKzExzi8AfeA+6CsRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJJZZkoHJrfrsoY2cWZVCyleDrJkdf2yphi6zHuaA9YOSG7ScuAb7NG0hEn2ebngi
         vV9yPmAlHn8qDGq4tUWn7qa8l6zp4msIaVwGZPkjc+PrAOHpxNyAxMQCafqUaO9hw+
         tMtZw/HpTwPjetJFULgPN2H+GeryOs1KnZabuFSOz9wc5H37SqQ327FIhqKvGhz1P9
         rSz7lS0ZfmDSb93O7URQSa4LZoZyMggJZ57MauFMuk6tLlI5EiUvcdU9Sa3hN/YXep
         KDQXnBwlnmY2CKsQCcez9IWq53iFM+2g8zL4za7OCC5SYtP1+o7uuNnveHx81ekHNI
         VHIDfRjsq4cFg==
Date:   Tue, 5 Dec 2023 22:26:38 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZW8zHoVWf94FDTx7@xhacker>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
 <20231129-th1520_mmc_dts-v7-2-c77fc19caa6f@baylibre.com>
 <CAJM55Z-qc7gc0fO-K8byqvpOBjDxFD4dP57mFHuijvpOzBWObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJM55Z-qc7gc0fO-K8byqvpOBjDxFD4dP57mFHuijvpOzBWObQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 01:47:45AM -0800, Emil Renner Berthing wrote:
> Drew Fustini wrote:
> > Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
> > controller instance which is typically connected to the eMMC device.
> > Add mmc1 node for the second mmc controller instance which is typically
> > connected to microSD slot.
> >
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index ba4d2c673ac8..af4fdcd82e0b 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -146,6 +146,13 @@ uart_sclk: uart-sclk-clock {
> >  		#clock-cells = <0>;
> >  	};
> >
> > +	sdhci_clk: sdhci-clock {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <198000000>;
> > +		clock-output-names = "sdhci_clk";
> > +		#clock-cells = <0>;
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&plic>;
> > @@ -304,6 +311,24 @@ dmac0: dma-controller@ffefc00000 {
> >  			status = "disabled";
> >  		};
> >
> > +		mmc0: mmc@ffe7080000 {
> > +			compatible = "thead,th1520-dwcmshc";
> > +			reg = <0xff 0xe7080000 0x0 0x10000>;
> > +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&sdhci_clk>;
> > +			clock-names = "core";
> > +			status = "disabled";
> > +		};
> > +
> > +		mmc1: mmc@ffe7090000 {
> > +			compatible = "thead,th1520-dwcmshc";
> > +			reg = <0xff 0xe7090000 0x0 0x10000>;
> > +			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&sdhci_clk>;
> > +			clock-names = "core";
> > +			status = "disabled";
> > +		};
> > +
> 
> Hi Drew,
> 
> This doesn't seem to match the documentation shared here:
> https://lore.kernel.org/linux-riscv/5f437109d2be2b8843f549a661054a2e3ec0d66e.camel@xry111.site/
> From the TH1520 System User Manual.pdf in there, I'd expect something like

> 
> 	emmc: mmc@ffe7080000 {
> 		compatible = "thead,th1520-dwcmshc";
> 		reg = <0xff 0xe7080000 0x0 0x10000>;
> 		...
> 	};

Hi Emil,

I think this isn't necessary. From other soc dts files, I see such
naming, but lots socs just use mmc0, mmc1, and so on.

And IIRC, the host for sd and sdio can support both, IOW, below
sdio0/sdio1 may be used for sdcard.

Thanks
> 
> 	sdio0: mmc@ffe7090000 {
> 		compatible = "thead,th1520-dwcmshc";
> 		reg = <0xff 0xe7090000 0x0 0x10000>;
> 		...
> 	};
> 
> 	sdio1: mmc@ffe70a0000 {
> 		compatible = "thead,th1520-dwcmshc";
> 		reg = <0xff 0xe70a0000 0x0 0x10000>;
> 		...
> 	};
> 
> /Emil
