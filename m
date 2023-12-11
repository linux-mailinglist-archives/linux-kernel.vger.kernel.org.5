Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ECE80C67E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjLKK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjLKK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:27:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF13C1729
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:27:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B80A52F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:28:04 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1065F3F738
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:27:17 -0800 (PST)
Date:   Mon, 11 Dec 2023 10:27:06 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: juno: align thermal zone names with bindings
Message-ID: <ZXbj-jRJcpzam0wG@e110455-lin.cambridge.arm.com>
References: <20231209171612.250868-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231209171612.250868-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 06:16:12PM +0100, Krzysztof Kozlowski wrote:
> Thermal bindings require thermal zone node names to match
> certain patterns:
> 
>   juno.dtb: thermal-zones: 'big-cluster', 'gpu0', 'gpu1', 'little-cluster', 'pmic', 'soc'
>     do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for fixing this!

Best regards,
Liviu

> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 12 ++++++------
>  arch/arm64/boot/dts/arm/juno-scmi.dtsi | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 8b4d280b1e7e..b897f5542c0a 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -747,7 +747,7 @@ scpi_sensors0: sensors {
>  	};
>  
>  	thermal-zones {
> -		pmic {
> +		pmic-thermal {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 0>;
> @@ -760,7 +760,7 @@ pmic_crit0: trip0 {
>  			};
>  		};
>  
> -		soc {
> +		soc-thermal {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 3>;
> @@ -773,28 +773,28 @@ soc_crit0: trip0 {
>  			};
>  		};
>  
> -		big_cluster_thermal_zone: big-cluster {
> +		big_cluster_thermal_zone: big-cluster-thermal {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 21>;
>  			status = "disabled";
>  		};
>  
> -		little_cluster_thermal_zone: little-cluster {
> +		little_cluster_thermal_zone: little-cluster-thermal {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 22>;
>  			status = "disabled";
>  		};
>  
> -		gpu0_thermal_zone: gpu0 {
> +		gpu0_thermal_zone: gpu0-thermal {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 23>;
>  			status = "disabled";
>  		};
>  
> -		gpu1_thermal_zone: gpu1 {
> +		gpu1_thermal_zone: gpu1-thermal {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 24>;
> diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> index ec85cd2c733c..31929e2377d8 100644
> --- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
> @@ -76,27 +76,27 @@ scmi_sensors0: protocol@15 {
>  	};
>  
>  	thermal-zones {
> -		pmic {
> +		pmic-thermal {
>  			thermal-sensors = <&scmi_sensors0 0>;
>  		};
>  
> -		soc {
> +		soc-thermal {
>  			thermal-sensors = <&scmi_sensors0 3>;
>  		};
>  
> -		big-cluster {
> +		big-cluster-thermal {
>  			thermal-sensors = <&scmi_sensors0 21>;
>  		};
>  
> -		little-cluster {
> +		little-cluster-thermal {
>  			thermal-sensors = <&scmi_sensors0 22>;
>  		};
>  
> -		gpu0 {
> +		gpu0-thermal {
>  			thermal-sensors = <&scmi_sensors0 23>;
>  		};
>  
> -		gpu1 {
> +		gpu1-thermal {
>  			thermal-sensors = <&scmi_sensors0 24>;
>  		};
>  	};
> -- 
> 2.34.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
