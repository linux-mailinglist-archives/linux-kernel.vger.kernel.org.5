Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0D771906
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHGEfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGEe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:34:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218610F3;
        Sun,  6 Aug 2023 21:34:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3774Yga0026577;
        Sun, 6 Aug 2023 23:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691382882;
        bh=9esSEE+e7qpzEHxhmbtyvrf2sVUov2EDY6hsVInYwrE=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=lECcSZWAjb0Zoi+5CgR3cOBFJfHL8WRJBVWveWTS7apKJK/Y5oqsiZ+cOUFp2HXiN
         icvM2n5j7LoxtAG+DbjfDl9AmRhp0stTfuYE+urTvh+qVqFP4V3ml3FBQPLNbR4Phn
         TzmlVKuVxMMSD51qjRNgMOcq7K+TdW5cm6upc2ZU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3774Ygjb096130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 6 Aug 2023 23:34:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Aug 2023 23:34:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Aug 2023 23:34:41 -0500
Received: from [172.24.25.97] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3774YbbA062857;
        Sun, 6 Aug 2023 23:34:38 -0500
Message-ID: <93c0fdc0-994c-9f28-bec8-6d333335b2c7@ti.com>
Date:   Mon, 7 Aug 2023 10:04:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-evm: Add bootph-pre-ram
 property for SPL nodes
Content-Language: en-US
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
 <20230806164838.18088-4-a-nandan@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230806164838.18088-4-a-nandan@ti.com>
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

Hi Apurva,

On 8/6/2023 10:18 PM, Apurva Nandan wrote:
> Add bootph-pre-ram property for all the nodes used in SPL stage,
> for syncing it later to u-boot j784s4 dts.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 1e38a8f1bec5..12455baf68b0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -252,7 +252,9 @@ vdd_sd_dv: regulator-TLV71033 {
>   };
>   
>   &main_pmx0 {
> [...]
>   
>   	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
> +		bootph-pre-ram;
>   		pinctrl-single,pins = <
>   			J784S4_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
>   			J784S4_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */

Unfortunately this is not under correct pin mux , OSPI1 falls under 
wkup_pmx1.

Patch under review is 
https://lore.kernel.org/all/20230802114126.162445-1-u-kumar1@ti.com/


> @@ -399,6 +409,7 @@ J784S4_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
>   };
> [...]
>   
>
