Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB51779259
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjHKPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjHKPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:03:43 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425530D0;
        Fri, 11 Aug 2023 08:03:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BF3PAF019291;
        Fri, 11 Aug 2023 10:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691766206;
        bh=bs8kMfudO9pdC5cA2qEDdp/+bpDxYybryr8W5ipx/hM=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=osTbtUMThp1YGzif4+2tw6WP5rRakG4OJf3KOrxdw/aaskfP7M69VbbrA5XlQWwze
         rGX87IrgeJYXxlg5jLhZL7ig6UxU72pk9S3+LWshOmsrc+jSetpZ9N3QB5o6OJMMvi
         gFkOVOJgzRbgiV0PwjyBnsfNfMDfLcfnHtSlylcM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BF3PjI035028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 10:03:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 10:03:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 10:03:24 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BF3NiN099499;
        Fri, 11 Aug 2023 10:03:24 -0500
Message-ID: <8f3c2172-8fc7-c90d-bd8f-ea2f0ab9dcc9@ti.com>
Date:   Fri, 11 Aug 2023 10:03:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: k3-j721s2-main: Add R5F and C7x
 remote processsor nodes
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>
References: <20230808201842.292911-1-a-nandan@ti.com>
 <20230808201842.292911-3-a-nandan@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230808201842.292911-3-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 3:18 PM, Apurva Nandan wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> The J721S2 SoCs have 2 dual-core Arm Cortex-R5F processor (R5FSS)
> subsystems/clusters in MAIN voltage domain. Each of these can be
> configured at boot time to be either run in a LockStep mode or in an
> Asymmetric Multi Processing (AMP) fashion in Split-mode. These
> subsystems have 64 KB each Tightly-Coupled Memory (TCM) internal
> memories for each core split between two banks - ATCM and BTCM
> (further interleaved into two banks). The TCMs of both Cores are
> combined in LockStep-mode to provide a larger 128 KB of memory, but
> otherwise are functionally similar to those on J721E SoCs.
> 
> Add the DT nodes for the MAIN domain R5F cluster/subsystems, the two
> R5F cores are added as child nodes to each of the R5F cluster nodes.
> The clusters are configured to run in LockStep mode by default, with
> the ATCMs enabled to allow the R5 cores to execute code from DDR
> with boot-strapping code from ATCM. The inter-processor communication
> between the main A72 cores and these processors is achieved through
> shared memory and Mailboxes.
> 
> The following firmware names are used by default for these cores, and
> can be overridden in a board dts file if desired:
>          MAIN R5FSS0 Core0: j721s2-main-r5f0_0-fw (both in LockStep & Split modes)
>          MAIN R5FSS0 Core1: j721s2-main-r5f0_1-fw (needed only in Split mode)
>          MAIN R5FSS1 Core0: j721s2-main-r5f1_0-fw (both in LockStep & Split modes)
>          MAIN R5FSS1 Core1: j721s2-main-r5f1_1-fw (needed only in Split mode)
> 
> The K3 J721S2 SoCs have two C71x DSP subsystems in MAIN voltage domain. The
> C71x DSPs are 64 bit machine with fixed and floating point DSP operations.
> Similar to the R5F remote cores, the inter-processor communication
> between the main A72 cores and these DSP cores is achieved through
> shared memory and Mailboxes.
> 
> The following firmware names are used by default for these DSP cores,
> and can be overridden in a board dts file if desired:
>          MAIN C71_0 : j721s2-c71_0-fw
>          MAIN C71_1 : j721s2-c71_1-fw
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 104 +++++++++++++++++++++
>   1 file changed, 104 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index dc7920a35237..c428a2b624fb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -1688,4 +1688,108 @@ dss: dss@4a00000 {
>   		dss_ports: ports {
>   		};
>   	};
> +
> +	main_r5fss0: r5fss@5c00000 {
> +		compatible = "ti,j721s2-r5fss";
> +		ti,cluster-mode = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
> +			 <0x5d00000 0x00 0x5d00000 0x20000>;
> +		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
> +
> +		main_r5fss0_core0: r5f@5c00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5c00000 0x00010000>,
> +			      <0x5c10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <279>;
> +			ti,sci-proc-ids = <0x06 0xff>;
> +			resets = <&k3_reset 279 1>;
> +			firmware-name = "j721s2-main-r5f0_0-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +
> +		main_r5fss0_core1: r5f@5d00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5d00000 0x00010000>,
> +			      <0x5d10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <280>;
> +			ti,sci-proc-ids = <0x07 0xff>;
> +			resets = <&k3_reset 280 1>;
> +			firmware-name = "j721s2-main-r5f0_1-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +	};
> +
> +	main_r5fss1: r5fss@5e00000 {
> +		compatible = "ti,j721s2-r5fss";
> +		ti,cluster-mode = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
> +			 <0x5f00000 0x00 0x5f00000 0x20000>;
> +		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
> +
> +		main_r5fss1_core0: r5f@5e00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5e00000 0x00010000>,
> +			      <0x5e10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <281>;
> +			ti,sci-proc-ids = <0x08 0xff>;
> +			resets = <&k3_reset 281 1>;
> +			firmware-name = "j721s2-main-r5f1_0-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +
> +		main_r5fss1_core1: r5f@5f00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5f00000 0x00010000>,
> +			      <0x5f10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <282>;
> +			ti,sci-proc-ids = <0x09 0xff>;
> +			resets = <&k3_reset 282 1>;
> +			firmware-name = "j721s2-main-r5f1_1-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +	};
> +
> +	c71_0: dsp@64800000 {
> +		compatible = "ti,j721s2-c71-dsp";
> +		reg = <0x00 0x64800000 0x00 0x00080000>,
> +		      <0x00 0x64e00000 0x00 0x0000c000>;
> +		reg-names = "l2sram", "l1dram";
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <8>;
> +		ti,sci-proc-ids = <0x30 0xff>;
> +		resets = <&k3_reset 8 1>;
> +		firmware-name = "j721s2-c71_0-fw";

We are moving to disabled by default for these nodes, see:

https://lore.kernel.org/lkml/20230809180145.53158-2-afd@ti.com/

The C7x stuff should be split out from the R5 stuff, each
should have a patch.

Andrew

> +	};
> +
> +	c71_1: dsp@65800000 {
> +		compatible = "ti,j721s2-c71-dsp";
> +		reg = <0x00 0x65800000 0x00 0x00080000>,
> +		      <0x00 0x65e00000 0x00 0x0000c000>;
> +		reg-names = "l2sram", "l1dram";
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <11>;
> +		ti,sci-proc-ids = <0x31 0xff>;
> +		resets = <&k3_reset 11 1>;
> +		firmware-name = "j721s2-c71_1-fw";
> +	};
>   };
