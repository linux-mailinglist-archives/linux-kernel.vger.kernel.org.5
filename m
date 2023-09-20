Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18D7A7899
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjITKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjITKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:08:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9990B9;
        Wed, 20 Sep 2023 03:08:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KA8ONP111098;
        Wed, 20 Sep 2023 05:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695204504;
        bh=KNiXL8yltTjYYUIgIVFgkURrsbSpcF7matGKWF6iaAI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=oNS7fIajLjiI7NKdaa6Ot2fGSRYAT6rsZLqm31RLuEE84hAdekFKsY7wUmZx9maio
         YZHb4vDZ+tuKhvJ1RLiTq3sEvl6q6CplYh2X+OxY9+s5ZqFfgzcORyc8Fl4XjZr7e4
         0z7eKq2+NVD6XFP8cqmqH1dQw+XH8Wa1KJf/4B8s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KA8OPV042246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 05:08:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 05:08:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 05:08:23 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KA8JPx098358;
        Wed, 20 Sep 2023 05:08:19 -0500
Message-ID: <524cb54d-c82e-d580-2cd3-17c5f1fc1e03@ti.com>
Date:   Wed, 20 Sep 2023 15:38:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721s2-main: Enable support for
 SDR104 speed mode
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>
References: <20230920094130.20279-1-b-kapoor@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230920094130.20279-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/2023 3:11 PM, Bhavya Kapoor wrote:
> According to TRM for J721S2, SDR104 speed mode is supported by the SoC
> but its capabilities were masked in device tree. Remove sdhci-caps-mask
> to enable support for SDR104 speed mode for SD card in J721S2 SoC. Also
> add itap delay select value for DDR50 High Speed Mode.
>
> [+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
> - https://www.ti.com/lit/zip/spruj28
>
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> ---
>
> Changelog v2->v3:
>   - Add Itap Delay Select value for DDR50 SD High Speed Mode
>
> Link to v2 patch : https://lore.kernel.org/all/20230412121415.860447-1-b-kapoor@ti.com/
>
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 084f8f5b6699..a5ab301b14f1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -766,11 +766,10 @@ main_sdhci1: mmc@4fb0000 {
>   		ti,itap-del-sel-sd-hs = <0x0>;
>   		ti,itap-del-sel-sdr12 = <0x0>;
>   		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,itap-del-sel-ddr50 = <0x2>;

Please elaborate , why we need itap delay

As per v2 
https://lore.kernel.org/all/d85fbd74-6470-f664-2eb6-ee02b8135b23@ti.com/

there should not be any change in tap delay


>   		ti,clkbuf-sel = <0x7>;
>   		ti,trm-icp = <0x8>;
>   		dma-coherent;
> -		/* Masking support for SDR104 capability */
> -		sdhci-caps-mask = <0x00000003 0x00000000>;
>   		status = "disabled";
>   	};
>   
