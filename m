Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA57EFB75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbjKQWbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:31:41 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65012D4F;
        Fri, 17 Nov 2023 14:31:38 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMVXRO125560;
        Fri, 17 Nov 2023 16:31:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700260293;
        bh=tEboc8imaZ8lgoNITxEkXtjHrBowVf0NeGv/0Wb/Bnk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uAfsRqb4B9W1RazSWaTVMwDrixbOu2DexwlgSnwS7aETJni5MUI2240RoaVT0EV0Z
         y06xb4Jm/G7K2H0SQh6+FX2gbL3+4NjRlQOM7dJMhiY2DdjDd+isIjxSiIxSzASPPh
         GVEhnPU2cm6ZWlLvXAhe8XuXqF9/V9xUQ1oiC1Yo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHMVXoo048524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 16:31:33 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 16:31:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 16:31:32 -0600
Received: from [10.250.36.5] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMVWTK075571;
        Fri, 17 Nov 2023 16:31:32 -0600
Message-ID: <64ac9f61-9a87-4d91-bab7-41cb10245de3@ti.com>
Date:   Fri, 17 Nov 2023 16:31:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] arm64: dts: ti: k3-am64: Convert serdes_ln_ctrl node
 into reg-mux
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231117222930.228688-1-afd@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231117222930.228688-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 4:29 PM, Andrew Davis wrote:
> This removes a dependency on the parent node being a syscon node.
> Convert from mmio-mux to reg-mux adjusting node name and properties
> as needed.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

This series depends on this driver fix[0].

Andrew

[0] https://lore.kernel.org/lkml/20231025161247.1283319-1-afd@ti.com/

>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 0be642bc1b86d..d630cbe6d7eb9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -51,10 +51,11 @@ chipid@14 {
>   			reg = <0x00000014 0x4>;
>   		};
>   
> -		serdes_ln_ctrl: mux-controller {
> -			compatible = "mmio-mux";
> +		serdes_ln_ctrl: mux-controller@4080 {
> +			compatible = "reg-mux";
> +			reg = <0x4080 0x4>;
>   			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
> +			mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
>   		};
>   
>   		phy_gmii_sel: phy@4044 {
