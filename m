Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F37A5BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjISH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjISH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:56:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20811100;
        Tue, 19 Sep 2023 00:56:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4EC9E2CF;
        Tue, 19 Sep 2023 09:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695110097;
        bh=s3DFbRHL5Uw5SFTtFMVJ56NX7qIx57dK2xMZGJgyHb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciPVGy8W/ShWTxFYQVWOTALkChnpfVn/JcxOEXrsHuCp+4QNKmpvxdIHjLNHwe6ud
         f64D86jTv9RRg/zNsQMy+oIjZmd/YVXjWPeZatjf0oJQm4Uytk2GkCAh76RL6gAUfV
         z9rgK1o9k2Ez2n1rjEnr8StRhnQthel00SwwKKb8=
Date:   Tue, 19 Sep 2023 10:56:46 +0300
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
Message-ID: <20230919075646.GB27722@pendragon.ideasonboard.com>
References: <cover.1695040866.git.michal.simek@amd.com>
 <5137958580c85a35cf6aadd1c33a2f6bcf81a9e5.1695040866.git.michal.simek@amd.com>
 <20230918145616.GA16823@pendragon.ideasonboard.com>
 <3a11c2e6-2086-4b06-9b8c-177cfba06034@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a11c2e6-2086-4b06-9b8c-177cfba06034@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:47:52AM +0200, Michal Simek wrote:
> 
> 
> On 9/18/23 16:56, Laurent Pinchart wrote:
> > Hi Michal,
> > 
> > Thank you for the patch.
> > 
> > On Mon, Sep 18, 2023 at 02:41:12PM +0200, Michal Simek wrote:
> >> Character '_' not recommended in node name. Use '-' instead.
> >> Pretty much run seds below for node names.
> >> s/zynqmp_ipi/zynqmp-ipi/
> >> s/nvmem_firmware/nvmem-firmware/
> >> s/soc_revision/soc-revision/
> >> s/si5335_/si5335-/
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> > 
> > The si5335 nodes may be better named after the clock name instead of the
> > component type, but that's nitpicking.
> 
> I don't know what's the guidance on this. fixed-clock.yaml is using generic 
> "clock" name. I have no problem to do it if this is recommended way to go.
> 
> 
> >> ---
> >>
> >>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 4 ++--
> >>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 6 +++---
> >>   2 files changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >> index d0091d3cb764..52f998c22538 100644
> >> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >> @@ -123,13 +123,13 @@ ina226 {
> >>   		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
> >>   	};
> >>   
> >> -	si5335_0: si5335_0 { /* clk0_usb - u23 */
> >> +	si5335_0: si5335-0 { /* clk0_usb - u23 */
> >>   		compatible = "fixed-clock";
> >>   		#clock-cells = <0>;
> >>   		clock-frequency = <26000000>;
> >>   	};
> >>   
> >> -	si5335_1: si5335_1 { /* clk1_dp - u23 */
> >> +	si5335_1: si5335-1 { /* clk1_dp - u23 */
> >>   		compatible = "fixed-clock";
> >>   		#clock-cells = <0>;
> >>   		clock-frequency = <27000000>;
> >> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> index b61fc99cd911..e50e95cbe817 100644
> >> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> @@ -129,7 +129,7 @@ rproc_1_fw_image: memory@3ef00000 {
> >>   		};
> >>   	};
> >>   
> >> -	zynqmp_ipi: zynqmp_ipi {
> >> +	zynqmp_ipi: zynqmp-ipi {
> >>   		bootph-all;
> >>   		compatible = "xlnx,zynqmp-ipi-mailbox";
> >>   		interrupt-parent = <&gic>;
> >> @@ -194,12 +194,12 @@ zynqmp_power: zynqmp-power {
> >>   				mbox-names = "tx", "rx";
> >>   			};
> >>   
> >> -			nvmem_firmware {
> >> +			nvmem-firmware {
> >>   				compatible = "xlnx,zynqmp-nvmem-fw";
> >>   				#address-cells = <1>;
> >>   				#size-cells = <1>;
> >>   
> >> -				soc_revision: soc_revision@0 {
> >> +				soc_revision: soc-revision@0 {
> > 
> > Unless I'm mistaken, this will change the userspace API, as it changes
> > the nvmem cell name. Is it an issue ?
> 
> Based on
> https://docs.kernel.org/driver-api/nvmem.html#userspace-binary-interface
> 
> The only interface to user space is via nvmem file which has all of them 
> together. And reference to this node is the same if used inside kernel itself.
> That's why I think there is no change in connection to user space API from nvmem 
> side. Of course entry is listed differently if you parse DT names.

Ah my bad. It should be fine then, as long as nobody in the kernel calls
nvmem_cell_get("soc_revision"), which I didn't find any occurrence of.

-- 
Regards,

Laurent Pinchart
