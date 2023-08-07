Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC7771901
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHGEbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGEbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:31:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA9310F3;
        Sun,  6 Aug 2023 21:31:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3774VLNx017247;
        Sun, 6 Aug 2023 23:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691382681;
        bh=KJS20ryd9xBB1za+5tMEZ5ZldFvoO9Xh9ZZd6xW/tIk=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=xdeyU6ids0SBPunXyPjAvV6BOB7EW4Z9v/nIcSYc/DBG1dbQfZ2iTxQRgz4Gf65YI
         FfUjX9PB8wP8h+XFBYAZ48m8mruRxI6lIfu6WjyXeBt3TfuHBiX7EysDVJgUH7VneM
         w/68UhGKCeEYnXPX3YAIM1k17Tw+oYj8GSwFt7sE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3774VLpt023129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 6 Aug 2023 23:31:21 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Aug 2023 23:31:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Aug 2023 23:31:21 -0500
Received: from [172.24.25.97] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3774VH7J111955;
        Sun, 6 Aug 2023 23:31:18 -0500
Message-ID: <3a2d1880-10aa-ac19-24e1-b2f697bc1a73@ti.com>
Date:   Mon, 7 Aug 2023 10:01:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add
 bootph-pre-ram property for SPL nodes
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20230806164838.18088-1-a-nandan@ti.com>
 <20230806164838.18088-3-a-nandan@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230806164838.18088-3-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Apurva

On 8/6/2023 10:18 PM, Apurva Nandan wrote:
> Add bootph-pre-ram property for all the nodes used in SPL stage,
> for syncing it later to u-boot j784s4 dts.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 740ee794d7b9..57bf0261c343 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -6,7 +6,9 @@
>    */
>   
>   &cbass_mcu_wakeup {
> +	bootph-pre-ram;
>   	sms: system-controller@44083000 {
> +		bootph-pre-ram;
>   		compatible = "ti,k2g-sci";
>   		ti,host-id = <12>;
>   
> @@ -19,22 +21,26 @@ sms: system-controller@44083000 {
>   		reg = <0x00 0x44083000 0x00 0x1000>;
>   
>   		k3_pds: power-controller {
> +			bootph-pre-ram;
>   			compatible = "ti,sci-pm-domain";
>   			#power-domain-cells = <2>;
>   		};
>   
>   		k3_clks: clock-controller {
> +			bootph-pre-ram;
>   			compatible = "ti,k2g-sci-clk";
>   			#clock-cells = <2>;
>   		};
>   
>   		k3_reset: reset-controller {
> +			bootph-pre-ram;
>   			compatible = "ti,sci-reset";
>   			#reset-cells = <2>;
>   		};
>   	};
>   
>   	chipid@43000014 {
> +		bootph-pre-ram;
>   		compatible = "ti,am654-chipid";
>   		reg = <0x00 0x43000014 0x00 0x4>;
>   	};
> @@ -442,6 +448,7 @@ mcu_spi2: spi@40320000 {
>   	};


mcu_timer0: timer@40400000 should be part of your list.

>   
>   	mcu_navss: bus@28380000 {
> +		bootph-pre-ram;
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> @@ -451,6 +458,7 @@ mcu_navss: bus@28380000 {
>   		dma-ranges;
>   
>   		mcu_ringacc: ringacc@2b800000 {
> +			bootph-pre-ram;
>   			compatible = "ti,am654-navss-ringacc";
>   			reg = <0x00 0x2b800000 0x00 0x400000>,
>   			      <0x00 0x2b000000 0x00 0x400000>,
> @@ -465,6 +473,7 @@ mcu_ringacc: ringacc@2b800000 {
>   		};
>   
>   		mcu_udmap: dma-controller@285c0000 {
> +			bootph-pre-ram;
>   			compatible = "ti,j721e-navss-mcu-udmap";
>   			reg = <0x00 0x285c0000 0x00 0x100>,
>   			      <0x00 0x2a800000 0x00 0x40000>,
