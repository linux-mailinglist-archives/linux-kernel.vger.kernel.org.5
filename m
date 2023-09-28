Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6947B1796
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjI1JjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjI1JjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:00 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5231BDC;
        Thu, 28 Sep 2023 02:38:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9cC0c122014;
        Thu, 28 Sep 2023 04:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695893892;
        bh=f0aP2zPIw8Ww5POXs3VDmPWZE2QQ78JrFXN3YNREGPQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NJeMxpLwda8cYHiIQzS3875RkjSFCXY6u/66nuL5s0NjOBlHClSw9o9ZkrTqgiU4X
         Yqg8H/usOo8tGXdNfYiAFqTBAkqNw0XYQGicReW30fPp/Xlh/lgoo1s3JAf+Yn1KZ5
         KAZWwYlhR3De2XjtVeB8jOTvbljh916YvkDW/b4g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9cCqO022484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 04:38:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:38:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:38:12 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9cBvR101747;
        Thu, 28 Sep 2023 04:38:11 -0500
Date:   Thu, 28 Sep 2023 15:08:10 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Muhammed Efe Cetin <efectn@6tel.net>
CC:     <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <heiko@sntech.de>, <sebastian.reichel@collabora.com>,
        <jonas@kwiboo.se>, <megi@xff.cz>
Subject: Re: [PATCH v3 2/3] arm64: dts: rockchip: Add sfc node to rk3588s
Message-ID: <20230928093810.iwz52glco2ywy2kc@dhruva>
References: <cover.1692632346.git.efectn@6tel.net>
 <70557b7843994a57c6d3422e00643cb75a698d0b.1692632346.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70557b7843994a57c6d3422e00643cb75a698d0b.1692632346.git.efectn@6tel.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 21, 2023 at 18:47:58 +0300, Muhammed Efe Cetin wrote:
> Add sfc node to rk3588s.dtsi from downstream kernel.

For those with lesser context, can you please mention what SFC means? I
did a quick grep on the compatible and that's how I got to know it's a
Serial Flash Controller

Also, not sure what you mean by downstream kernel, where is it located?
Why did you feel the need to mention it while upstreaming this patch?
Please can you provide more context or drop the downstream part
altogether?

> 
> Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 5544f66c6ff4..1a820a5a51eb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1424,6 +1424,17 @@ sata-port@0 {
>  		};
>  	};
>  
> +	sfc: spi@fe2b0000 {
> +		compatible = "rockchip,sfc";
> +		reg = <0x0 0xfe2b0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> +		clock-names = "clk_sfc", "hclk_sfc";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +

Otherwise, looks okay.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  	sdmmc: mmc@fe2c0000 {
>  		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x0 0xfe2c0000 0x0 0x4000>;
> -- 
> 2.41.0
> 
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
