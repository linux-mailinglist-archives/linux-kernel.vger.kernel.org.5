Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAC76B9EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjHAQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHAQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E22114;
        Tue,  1 Aug 2023 09:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 817AB61632;
        Tue,  1 Aug 2023 16:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9E2C433C8;
        Tue,  1 Aug 2023 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908627;
        bh=CMXomY4yotIp2kIkZChPB9St3sxEG+GKrqn91PhJDqw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FAT7aNs/561AUrM0GVltCTks2f5kyQS/a68fwFq4srLQYyFH1g6m0PZk6bgj0c16h
         OSq1b2QKmneqwx65qmFZUYp0JyWm90CF9CFYLwT0ozKI8y72CvTdAkifcC8m5xinlN
         NceaVWngozJhDvq1Lnn15zN210aoU7JKyaOFJCW2D6W0dX+Sk9EJsiJBHiE+QJHMHh
         chCTGeHsOvzGfEMrg7v0y98fqd7dFwML3os0bnlfQBVP6hyKmqJOeJk/faUpq2hEHZ
         CpLXOWJUidtJglXY7zz2gk3UQ++l6PNswkVfZwDRsKI+JSUtEBIjgeObAxZGd90tbt
         M3/qb++3q+U3w==
Message-ID: <390ef20d-a225-e7cb-73bd-9ba8c1985a98@kernel.org>
Date:   Tue, 1 Aug 2023 19:50:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     s-vadapalli@ti.com, afd@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, a-bhatia1@ti.com, r-ravikumar@ti.com,
        sabiya.d@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-4-j-choudhary@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801070019.219660-4-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 10:00, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
> same as DSS IP in J721E, so same compatible is being used.
> The DP is Cadence MHDP8546.
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> [j-choudhary@ti.com: move dss & mhdp node together in main, fix dss node]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index fbf5ab94d785..975661948755 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1749,4 +1749,77 @@ c71_3: dsp@67800000 {
>  		resets = <&k3_reset 40 1>;
>  		firmware-name = "j784s4-c71_3-fw";
>  	};
> +
> +	mhdp: dp-bridge@a000000 {

bridge@a000000

> +		compatible = "ti,j721e-mhdp8546";
> +

why the new lines all over the place within nodes?

> +		reg = <0x0 0xa000000 0x0 0x30a00>,
> +		      <0x0 0x4f40000 0x0 0x20>;
> +		reg-names = "mhdptx", "j721e-intg";
> +
> +		clocks = <&k3_clks 217 11>;
> +
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
> +
> +		status = "disabled";
> +
> +		dp0_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	dss: dss@4a00000 {
> +		compatible = "ti,j721e-dss";
> +		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
> +		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
> +		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
> +		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
> +		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
> +		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
> +		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
> +		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
> +		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
> +		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
> +		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
> +		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
> +		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
> +		      <0x00 0x04aa0000 0x00 0x10000>, /* vp1 */
> +		      <0x00 0x04ac0000 0x00 0x10000>, /* vp1 */
> +		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
> +		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
> +
> +		reg-names = "common_m", "common_s0",
> +			    "common_s1", "common_s2",
> +			    "vidl1", "vidl2","vid1","vid2",
> +			    "ovr1", "ovr2", "ovr3", "ovr4",
> +			    "vp1", "vp2", "vp3", "vp4",
> +			    "wb";
> +
> +		clocks = <&k3_clks 218 0>,
> +			 <&k3_clks 218 2>,
> +			 <&k3_clks 218 5>,
> +			 <&k3_clks 218 14>,
> +			 <&k3_clks 218 18>;
> +		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
> +
> +		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
> +
> +		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "common_m",
> +				  "common_s0",
> +				  "common_s1",
> +				  "common_s2";
> +
> +		status = "disabled";
> +
> +		dss_ports: ports {
> +		};
> +	};
>  };

-- 
cheers,
-roger
