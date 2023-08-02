Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705A76D5ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHBRsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjHBRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:47:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277613AAE;
        Wed,  2 Aug 2023 10:47:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372HlEcq005114;
        Wed, 2 Aug 2023 12:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690998434;
        bh=USGQbpqN+vK0VguJYau7guk5mtMbWHOA2QC9dBDh4yo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=sJ991u82vFPsO9OD6NpenqP67tdwZjI1h0za1UhafI4Tl1/qR0cAokcx+zptZf26r
         jq9qf5oeVsQjsK76PJ1+qOFZNqu7gRHWc2aHnmt4oGRv7EvXwDTJnwD/pxnOAdS3bI
         oiKYE0yTHHdQf89dlskvur5/7urO7cYTbLSrQ30s=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372HlE5v005734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 12:47:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 12:47:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 12:47:13 -0500
Received: from [10.250.36.161] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372HlDNW063790;
        Wed, 2 Aug 2023 12:47:13 -0500
Message-ID: <fe234498-4c41-7135-a02f-8676cd7ec3f8@ti.com>
Date:   Wed, 2 Aug 2023 12:47:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am64: Merge the two main_conf
 nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802174521.236255-1-afd@ti.com>
 <20230802174521.236255-2-afd@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230802174521.236255-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 12:45 PM, Andrew Davis wrote:
> There are two nodes representing the same register space, this looks to
> have been created by some merge or copy/paste error. Remove the second
> instance of this node and move its children into the first instance.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---


Nishanth, this is based/dependent on your -next branch.

Andrew

>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 42 ++++++++++--------------
>   1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index d3dd8c426dada..e27eb2e585f14 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -44,11 +44,28 @@ main_conf: syscon@43000000 {
>   		#size-cells = <1>;
>   		ranges = <0x0 0x0 0x43000000 0x20000>;
>   
> +		chipid@14 {
> +			compatible = "ti,am654-chipid";
> +			reg = <0x00000014 0x4>;
> +		};
> +
>   		serdes_ln_ctrl: mux-controller {
>   			compatible = "mmio-mux";
>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
>   		};
> +
> +		phy_gmii_sel: phy@4044 {
> +			compatible = "ti,am654-phy-gmii-sel";
> +			reg = <0x4044 0x8>;
> +			#phy-cells = <1>;
> +		};
> +
> +		epwm_tbclk: clock@4140 {
> +			compatible = "ti,am64-epwm-tbclk";
> +			reg = <0x4130 0x4>;
> +			#clock-cells = <1>;
> +		};
>   	};
>   
>   	gic500: interrupt-controller@1800000 {
> @@ -203,31 +220,6 @@ main_pmx0: pinctrl@f4000 {
>   		pinctrl-single,function-mask = <0xffffffff>;
>   	};
>   
> -	main_conf: syscon@43000000 {
> -		compatible = "syscon", "simple-mfd";
> -		reg = <0x00 0x43000000 0x00 0x20000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0x00 0x00 0x43000000 0x20000>;
> -
> -		chipid@14 {
> -			compatible = "ti,am654-chipid";
> -			reg = <0x00000014 0x4>;
> -		};
> -
> -		phy_gmii_sel: phy@4044 {
> -			compatible = "ti,am654-phy-gmii-sel";
> -			reg = <0x4044 0x8>;
> -			#phy-cells = <1>;
> -		};
> -
> -		epwm_tbclk: clock@4140 {
> -			compatible = "ti,am64-epwm-tbclk";
> -			reg = <0x4130 0x4>;
> -			#clock-cells = <1>;
> -		};
> -	};
> -
>   	main_timer0: timer@2400000 {
>   		compatible = "ti,am654-timer";
>   		reg = <0x00 0x2400000 0x00 0x400>;
