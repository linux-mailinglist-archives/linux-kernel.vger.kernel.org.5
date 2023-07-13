Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835F0751C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGMJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjGMJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:00:13 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED75268D;
        Thu, 13 Jul 2023 01:59:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF94E4000B;
        Thu, 13 Jul 2023 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689238793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fp/T2auLWK8Fh3jBHDr22urRoZN6z4YaEPdbMmTfazs=;
        b=SbSb0sexsiPU6to0djhloJ9Q46blZelElo9R8OOsyL1JJoNool3laht22HNcGTaN+X1oQ/
        ABEVvuZlDh+rAtZR5TmJIRR1m3hgNeM4eamhXKT1NzCkZqlQEsqC51ED7qYR8ePoyPF7rB
        pzR6CZNV8C3CNSClazlFDuDZzQ2hdPD3Pt383ouKqr9Sjf10clOc7E/b86dwLts9dQS4pz
        KCmXSp9NzouXNAFqAkx2C6CO4O500HW8clabk9dtdnHkE1QktHlhzqurso5F+o/N7ZQZ6G
        eikDmyNQzqeb10Z/VwAHk5CVpXUikGaPjj1ftndFA6/kV3dERjaeonkVhc+DaQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 2/3] arm64: dts: marvell: Add NAND flash controller
 to AC5
In-Reply-To: <20230703035044.2063303-3-chris.packham@alliedtelesis.co.nz>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
 <20230703035044.2063303-3-chris.packham@alliedtelesis.co.nz>
Date:   Thu, 13 Jul 2023 10:59:52 +0200
Message-ID: <87h6q82nlj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> The AC5/AC5X SoC has a NAND flash controller (NFC). Add this to
> the base SoC dtsi file as a disabled node. The NFC integration
> on the AC5/AC5X only supports SDR timing modes up to 3 so requires a
> dedicated compatible property so this limitation can be enforced.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Now that binding and code has beeen applied I can apply this one on
mvebu/dt64

Thanks,

Gregory

> ---
>
> Notes:
>     Changes in v3:
>     - Use correct clock for NFC
>     Changes in v2:
>     - New.
>
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> index c9ce1010c415..c64aaf51deb8 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> @@ -297,6 +297,16 @@ spi1: spi@805a8000 {
>  			status = "disabled";
>  		};
>  
> +		nand: nand-controller@805b0000 {
> +			compatible = "marvell,ac5-nand-controller";
> +			reg =  <0x0 0x805b0000 0x0 0x00000054>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&nand_clock>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller@80600000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> @@ -319,5 +329,11 @@ spi_clock: spi-clock {
>  			#clock-cells = <0>;
>  			clock-frequency = <200000000>;
>  		};
> +
> +		nand_clock: nand-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
>  	};
>  };
> -- 
> 2.41.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
