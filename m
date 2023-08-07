Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B84771984
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHGFlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHGFld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:41:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DD10EC;
        Sun,  6 Aug 2023 22:41:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3775fOoR031935;
        Mon, 7 Aug 2023 00:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691386884;
        bh=JfgYqNkxQ9xMWgd+flyGMgMXrutqakbXDj2wb3AvWDY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Wbb/CX5hWeTZ9Evej9mHKHEP0moK4T+hqjqwxzUIjmr3lqqotiXr2neoFGbIyt1nB
         AWy2A6zht8DEjLCQGXhti3e+f/7S96BakZ8ZoClDSLPQC3T75YScmzclfsrsBE5hza
         Yrzsit4tqPAN2mOjEOYCYBn0XajlkO+CRADLDnhI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3775fOS2006245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 00:41:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 00:41:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 00:41:24 -0500
Received: from [172.24.227.68] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3775fLVB062189;
        Mon, 7 Aug 2023 00:41:21 -0500
Message-ID: <6930dfae-89e3-2381-aaf7-e052a68ff7c3@ti.com>
Date:   Mon, 7 Aug 2023 11:11:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 13/13] arm64: dts: ti: k3-am64: Enable TSCADC nodes at the
 board level
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-14-afd@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230802205309.257392-14-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/23 02:23, Andrew Davis wrote:
> TSCADC nodes defined in the top-level AM64 SoC dtsi files are incomplete
> and may not be functional unless they are extended with pinmux and/or
> device information.
> 
> Disable the TSCADC nodes in the dtsi files and only enable the ones that
> are actually pinned out on a given board.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 4 ----
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 49f910e4b03fc..a9db9b6d03aca 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -773,6 +773,7 @@ tscadc0: tscadc@28001000 {
>   		assigned-clock-parents = <&k3_clks 0 3>;
>   		assigned-clock-rates = <60000000>;
>   		clock-names = "fck";
> +		status = "disabled";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index af06ccd466802..722fd285a34ec 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -513,10 +513,6 @@ cpsw3g_phy1: ethernet-phy@1 {
>   	};
>   };
>   
> -&tscadc0 {
> -	status = "disabled";
> -};
> -

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   &ospi0 {
>   	status = "okay";
>   	pinctrl-names = "default";

-- 
Thanks and Regards,
Dhruva Gole
