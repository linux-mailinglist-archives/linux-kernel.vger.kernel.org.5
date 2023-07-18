Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE7757251
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGRDa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGRDa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E391710;
        Mon, 17 Jul 2023 20:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3716141C;
        Tue, 18 Jul 2023 03:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A581C433C7;
        Tue, 18 Jul 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689651026;
        bh=z+z9lW6mMexaY47FcTYWGmyseM0LmHw63WGw8AdFcCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1LZVjPnDleC88cvMsPdvzalcfvzcb33HSio8liy2crAtXjJghJAKf1sACl1O4N9D
         Lcic5xV7hagW0s48QR7SLC707JC0zZ8gC0ZmbKAkixqHiJ9KtuAO+mXDm3QpHGqGdg
         FXMFsP0WUv4Sd3q/s9c+6Tz53jatEB7Aah9ePo2G6h8qaZBhjnifQD53Sib2rX0yi+
         7DrcgvbkxWH9j6nwM3Le3XfjAtvrzZFWy2JjLnYijKLLMBwMKB24LwMRS2VvVW0VXk
         7x0IeRhmKKcshvKr6qQNu4O6TpgwLS7Zk5pw0tO7H+fSZ9l1J8hdGcMP3YOc83qmni
         3waDHRMWSFHVQ==
Date:   Tue, 18 Jul 2023 11:30:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 03/10] arm64: dts: imx8ulp: add thermal node
Message-ID: <20230718033015.GD9559@dragon>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
 <20230625124238.4071717-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625124238.4071717-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:42:31PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add thermal node. Cooling map is not added, because frequency runtime
> changing not supported for now.
> 
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index ba0edb9a009b..fd30475a561d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/imx8ulp-power.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8ulp-pinfunc.h"
>  
> @@ -78,6 +79,27 @@ psci {
>  		method = "smc";
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&scmi_sensor 0>;

Have a newline between property list and child node.

Shawn

> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
> -- 
> 2.37.1
> 
