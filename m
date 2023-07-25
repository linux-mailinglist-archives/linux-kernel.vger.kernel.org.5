Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F75761104
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGYKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjGYKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:37:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51618D;
        Tue, 25 Jul 2023 03:37:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PAap7v128610;
        Tue, 25 Jul 2023 05:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690281411;
        bh=si0RsurRtT3gRhZdEaCudl5DBgXDldw1oYByDtNVbgk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JcLni2IviYrzBNi1Y36iEUpfZ2E7RCS9HAn6BMDOgPWCcpmPDLBvyf4gPiydqPuAD
         VEw7g2ar1GWFG4RLGEr4qPEpuhw/Vmz2nUJC5ThAMJixtOA29h8Qv69yB93Y2R+3wR
         iBtf3FK719/9sI+IFIW7D29tqQ528YU1jPt4dNe0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PAapUd104428
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 05:36:51 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 05:36:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 05:36:51 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PAalT5113777;
        Tue, 25 Jul 2023 05:36:48 -0500
Message-ID: <c5b7564c-ca49-4c13-8da0-ea8149f24ce3@ti.com>
Date:   Tue, 25 Jul 2023 16:06:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
To:     Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Chai Wenle <Wenle.Chai@windriver.com>
References: <20230725053843.1721028-1-u-kumar1@ti.com>
 <20230725053843.1721028-2-u-kumar1@ti.com>
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230725053843.1721028-2-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit

Minor nits inline:

On 25/07/23 11:08, Udit Kumar wrote:
> This patch adds UFS support present in J784S4 SOC.

"This patch" perhaps is redundant

> 
> UFS is documentend in J784S4 TRM[1]

s/documentend/documented

> Section 12.3.7 'Universal Flash Storage (UFS) Interface'
> 
> [1] http://www.ti.com/lit/zip/spruj52
> 
> Cc: Chai Wenle <Wenle.Chai@windriver.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 11f163e5cadf..f1db1ca5d6b1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1370,6 +1370,30 @@ main_spi7: spi@2170000 {
>  		status = "disabled";
>  	};
>  
> +	ufs_wrapper: ufs-wrapper@4e80000 {
> +		compatible = "ti,j721e-ufs";
> +		reg = <0x0 0x4e80000 0x0 0x100>;

Inline with rest of the file please use 0x00

		reg = <0x00 0x4e80000 0x00 0x100>;

> +		power-domains = <&k3_pds 387 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 387 3>;
> +		assigned-clocks = <&k3_clks 387 3>;
> +		assigned-clock-parents = <&k3_clks 387 6>;
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		status = "disabled";
> +
> +		ufs@4e84000 {
> +			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
> +			reg = <0x0 0x4e84000 0x0 0x10000>;

Same here or perhaps use ranges in the parent node?

> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			freq-table-hz = <250000000 250000000>, <19200000 19200000>,
> +					<19200000 19200000>;
> +			clocks = <&k3_clks 387 1>, <&k3_clks 387 3>, <&k3_clks 387 3>;
> +			clock-names = "core_clk", "phy_clk", "ref_clk";
> +			dma-coherent;
> +		};
> +	};
> +
>  	main_r5fss0: r5fss@5c00000 {
>  		compatible = "ti,j721s2-r5fss";
>  		ti,cluster-mode = <1>;

-- 
Regards
Vignesh
