Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0B754527
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGNWxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:53:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17838358E;
        Fri, 14 Jul 2023 15:53:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36EMqefp069962;
        Fri, 14 Jul 2023 17:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689375160;
        bh=Xdl/UIJvXkslSce1VW8MpUQaW13x/VEKlIU83ycgctw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=U5X1TK5CFUbSdhtkTtJhReDA0kFL8/EfI/E8YnqoRW/TMI3fH/H/GsIzFVpfkRJUe
         sxUWnGMgy3b/zmjbr9VApwWF3Yzd1Hei3fIpzs4y9NA0J8iZHfll/GiHtn+qR3ssRz
         H7H6ss7DNJeGUu+YnTRMpH9SpPLJ52y+fvuc3nG4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36EMqeBU012952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 17:52:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 17:52:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 17:52:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36EMqeCX093307;
        Fri, 14 Jul 2023 17:52:40 -0500
Date:   Fri, 14 Jul 2023 17:52:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <huaqian.li@siemens.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <huaqianlee@gmail.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jan.kiszka@siemens.com>,
        <baocheng.su@siemens.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdog
Message-ID: <20230714225240.dvlwqaodp2l3cczm@disfigure>
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-3-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230713095127.1230109-3-huaqian.li@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:51-20230713, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>

I guess I should be explicit about this: Lets keep this dts patch as
"DONOTMERGE" in subject line for driver subsystem maintainer (I don't
want a repeat of cpufreq maintainers picking up dts and associated
warnings that are now pending fixes), resubmit at next rc1 and I can
queue up the dts once the maintainers pick up the driver and bindings.

Ref: https://lore.kernel.org/all/20230714084725.27847-1-krzysztof.kozlowski@linaro.org/

> 
> This patch adds a reserved memory for the TI AM65X platform watchdog to
> reserve the specific info, triggering the watchdog reset in last boot,
> to know if the board reboot is due to a watchdog reset.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index e26bd988e522..4bb20d493651 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -63,6 +63,12 @@ rtos_ipc_memory_region: ipc-memories@a2000000 {
>  			alignment = <0x1000>;
>  			no-map;
>  		};
> +
> +		/* To reserve the power-on(PON) reason for watchdog reset */
> +		wdt_reset_memory_region: wdt-memory@a2200000 {
> +			reg = <0x00 0xa2200000 0x00 0x1000>;
> +			no-map;
> +		};
>  	};
>  
>  	leds {
> @@ -718,3 +724,7 @@ &mcu_r5fss0_core1 {
>  			<&mcu_r5fss0_core1_memory_region>;
>  	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
>  };
> +
> +&mcu_rti1 {
> +	memory-region = <&wdt_reset_memory_region>;
> +};
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
