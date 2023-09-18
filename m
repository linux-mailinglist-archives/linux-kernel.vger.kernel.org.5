Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C167A4D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjIRPrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjIRPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:47:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE81706;
        Mon, 18 Sep 2023 08:44:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D151D8813;
        Mon, 18 Sep 2023 16:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695048868;
        bh=b6UAEQyQKuuS5CA132hsYbv8kF2/Zn/dBQjv48MS1Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3FfkTgIdm2OnVtrOtQIdzhFtrC09vnsWVvFY3PoGF637tkTQCxsHso+pcE14A85c
         O7rKLq/wwbBVsIZiRwhxJTVYvQjU5sp8gr4RsuTssfCBh1pnsYynHT+dttzQ1k3hN4
         qPf1cVuECTnAzq6qFIhJd+MsIZgNbE9SFsHkjusI=
Date:   Mon, 18 Sep 2023 17:56:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] arm64: xilinx: Do not use '_' in DT node names
Message-ID: <20230918145616.GA16823@pendragon.ideasonboard.com>
References: <cover.1695040866.git.michal.simek@amd.com>
 <5137958580c85a35cf6aadd1c33a2f6bcf81a9e5.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5137958580c85a35cf6aadd1c33a2f6bcf81a9e5.1695040866.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Mon, Sep 18, 2023 at 02:41:12PM +0200, Michal Simek wrote:
> Character '_' not recommended in node name. Use '-' instead.
> Pretty much run seds below for node names.
> s/zynqmp_ipi/zynqmp-ipi/
> s/nvmem_firmware/nvmem-firmware/
> s/soc_revision/soc-revision/
> s/si5335_/si5335-/
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

The si5335 nodes may be better named after the clock name instead of the
component type, but that's nitpicking.

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 4 ++--
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index d0091d3cb764..52f998c22538 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -123,13 +123,13 @@ ina226 {
>  		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
>  	};
>  
> -	si5335_0: si5335_0 { /* clk0_usb - u23 */
> +	si5335_0: si5335-0 { /* clk0_usb - u23 */
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <26000000>;
>  	};
>  
> -	si5335_1: si5335_1 { /* clk1_dp - u23 */
> +	si5335_1: si5335-1 { /* clk1_dp - u23 */
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <27000000>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index b61fc99cd911..e50e95cbe817 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -129,7 +129,7 @@ rproc_1_fw_image: memory@3ef00000 {
>  		};
>  	};
>  
> -	zynqmp_ipi: zynqmp_ipi {
> +	zynqmp_ipi: zynqmp-ipi {
>  		bootph-all;
>  		compatible = "xlnx,zynqmp-ipi-mailbox";
>  		interrupt-parent = <&gic>;
> @@ -194,12 +194,12 @@ zynqmp_power: zynqmp-power {
>  				mbox-names = "tx", "rx";
>  			};
>  
> -			nvmem_firmware {
> +			nvmem-firmware {
>  				compatible = "xlnx,zynqmp-nvmem-fw";
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  
> -				soc_revision: soc_revision@0 {
> +				soc_revision: soc-revision@0 {

Unless I'm mistaken, this will change the userspace API, as it changes
the nvmem cell name. Is it an issue ?

>  					reg = <0x0 0x4>;
>  				};
>  			};

-- 
Regards,

Laurent Pinchart
