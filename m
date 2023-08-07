Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A39771950
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHGFTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjHGFTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:19:48 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52B1711;
        Sun,  6 Aug 2023 22:19:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3775JW4Y043054;
        Mon, 7 Aug 2023 00:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691385572;
        bh=sT4lGek5KDpWP1V8MxGITG8VuZzcalCM7WIqRBvoSmo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IiSg856Y95tYat15Bcpd2WpurRcRDqLNm9aO6iSyINEAzSFooJlqmaEHYJEtVwTuP
         y6kcKPKp19+U6ZX/Ndqrtey+AQuz08XmIOPpslf5qP3LIaY/yFg6QNs4e73Upcq6fU
         eM3xk0MUeJzhhDcajNcsMyLhYkbwvCHH8lsN69BA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3775JWrD126053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 00:19:32 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 00:19:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 00:19:32 -0500
Received: from [172.24.227.68] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3775JSgp026031;
        Mon, 7 Aug 2023 00:19:29 -0500
Message-ID: <5c95ea3c-011e-2f39-e967-5713bd4b8bcf@ti.com>
Date:   Mon, 7 Aug 2023 10:49:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/13] arm64: dts: ti: k3-j7200: Enable OSPI nodes at the
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
 <20230802205309.257392-7-afd@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230802205309.257392-7-afd@ti.com>
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



On 03/08/23 02:23, Andrew Davis wrote:
> OSPI nodes defined in the top-level J7200 SoC dtsi files are incomplete
> and may not be functional unless they are extended with pinmux and
> device information.
> 
> As the attached OSPI device is only known about at the board integration
> level, these nodes should only be enabled when provided with this
> information.

Agree

> 
> Disable the OSPI nodes in the dtsi files and only enable the ones that
> are actually pinned out on a given board.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi     | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index ee7860913c387..571eb0e2eac92 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -544,6 +544,7 @@ ospi0: spi@47040000 {
>   			power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index b37f4f88ece4f..5a300d4c8ba03 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -267,6 +267,7 @@ eeprom@50 {
>   };
>   
>   &ospi0 {
> +	status = "okay";

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>   

-- 
Thanks and Regards,
Dhruva Gole
