Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C077D037B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbjJSVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:05:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05E124;
        Thu, 19 Oct 2023 14:05:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39JL58YC035873;
        Thu, 19 Oct 2023 16:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697749508;
        bh=bvZGh7LIGlVhObO1TE8H6Vk3xxmzzz72LiAF8VGrbXc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=D1fRjulmTVvirrQfz7nFJ7kp/VFGDQkUsL233j2mLKWnclxo+oWa6QEvHvmbZAxUf
         yvUU99cKiN1tsYvDAo4/OTp4tHdHm/n7u2xkMCW0fhzechX88TJJYm+sBBwhKb/rwT
         O1yuFuHkcY0Hl14JN58YJecZ2epQCCFLf9hma420=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39JL583D017871
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 16:05:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 16:05:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 16:05:08 -0500
Received: from [128.247.81.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39JL58j4025106;
        Thu, 19 Oct 2023 16:05:08 -0500
Message-ID: <33e958fb-71b9-43b2-911c-a187651a0de4@ti.com>
Date:   Thu, 19 Oct 2023 16:05:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: ti: k3-j7200-mcu-wakeup: Switch
 mcu_syscon to ti,j721e-system-controller
To:     Vaishnav Achath <vaishnav.a@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u-kumar1@ti.com>
References: <20231009082452.30684-1-vaishnav.a@ti.com>
 <20231009082452.30684-2-vaishnav.a@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231009082452.30684-2-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 3:24 AM, Vaishnav Achath wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> Use ti,j721e-system-controller to be explicit about the syscon node we
> are using.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> No changes since V1.
> 
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 6ffaf85fa63f..2ee6215e38a6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -165,7 +165,7 @@
>   	};
>   
>   	mcu_conf: syscon@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";

There is already a "ti,j721e-system-controller" in the main domain dtsi. And this
is not one of those. You are hiding a valid DT warning by adding an incorrect
compatible string that just so happens to not throw the warning.

This should be a "simple-bus" node.

Andrew

>   		reg = <0x00 0x40f00000 0x00 0x20000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
