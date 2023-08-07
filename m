Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF2771980
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjHGFiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjHGFir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:38:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE610F2;
        Sun,  6 Aug 2023 22:38:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3775cdKQ040111;
        Mon, 7 Aug 2023 00:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691386719;
        bh=KLl2elqSbWIrTSkBwTJHXuEwi9i1a3EXzZT9tcJTyO4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IuaIeysv0hzhRqwchDTuERMXr765SdYg0jESiwSB/Tawu4QA57MNyBhD6NMb/CnWe
         gax0hHV+M27B03aawPEn9WxbiZ/ktkJHcO8ZcrRExyE139M5Cg51k5mSTiMJxGOVx8
         lU9zZQyr7JIO0qiA9TqRiTVu+360cbcs6Nzrlje0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3775ccSX014909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 00:38:38 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 00:38:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 00:38:38 -0500
Received: from [172.24.227.68] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3775cZmQ042491;
        Mon, 7 Aug 2023 00:38:35 -0500
Message-ID: <ea932535-b69c-ec57-0dfe-31a891b6df5c@ti.com>
Date:   Mon, 7 Aug 2023 11:08:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/13] arm64: dts: ti: k3-j7200: Enable GPIO nodes at the
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
 <20230802205309.257392-11-afd@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230802205309.257392-11-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 03/08/23 02:23, Andrew Davis wrote:
> GPIO nodes defined in the top-level J7200 SoC dtsi files are incomplete
> and may not be functional unless they are extended with pinmux and
> device information.
> 
> Disable the GPIO nodes in the dtsi files and only enable the ones that
> are actually pinned out on a given board.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 ++++--------------
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi      |  4 ++++
>   .../arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  2 ++
>   3 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index dee9056f56051..4a5c4f36baeec 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -240,27 +240,17 @@ &main_uart3 {
>   	pinctrl-0 = <&main_uart3_pins_default>;
>   };
>   
> -&main_gpio2 {
> -	status = "disabled";
> -};
> -
> -&main_gpio4 {
> -	status = "disabled";
> -};
> -
> -&main_gpio6 {
> -	status = "disabled";
> +&main_gpio0 {
> +	status = "okay";
> +	/* default pins */

Small question, where is the pmx for main_gpio0? What does "default pins"
refer to here? Where are they pinmuxed?

>   };
>   
>   &wkup_gpio0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wkup_gpio_pins_default>;
>   };
>   
> -&wkup_gpio1 {
> -	status = "disabled";
> -};
> -
>   &mcu_cpsw {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 5d7542ba41b93..6a776f3bbcb19 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -832,6 +832,7 @@ main_gpio0: gpio@600000 {
>   		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 105 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_gpio2: gpio@610000 {
> @@ -849,6 +850,7 @@ main_gpio2: gpio@610000 {
>   		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 107 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_gpio4: gpio@620000 {
> @@ -866,6 +868,7 @@ main_gpio4: gpio@620000 {
>   		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 109 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_gpio6: gpio@630000 {
> @@ -883,6 +886,7 @@ main_gpio6: gpio@630000 {
>   		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 111 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	main_spi0: spi@2100000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 571eb0e2eac92..5ae7320efad7b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -297,6 +297,7 @@ wkup_gpio0: gpio@42110000 {
>   		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 113 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	wkup_gpio1: gpio@42100000 {
> @@ -313,6 +314,7 @@ wkup_gpio1: gpio@42100000 {
>   		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 114 0>;
>   		clock-names = "gpio";
> +		status = "disabled";
>   	};
>   
>   	mcu_navss: bus@28380000 {

-- 
Thanks and Regards,
Dhruva Gole
