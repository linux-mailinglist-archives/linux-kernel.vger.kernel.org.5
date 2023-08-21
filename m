Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE6782E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjHUQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbjHUQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:28:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3904BE8;
        Mon, 21 Aug 2023 09:28:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37LGSDiX027693;
        Mon, 21 Aug 2023 11:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692635293;
        bh=/UNxKltqQ/ret3XaUPX6Ti7vDc7NcT/jG5e5kOE4u+U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nGAJ8xzmXt9UOagiWrqO5QX/MnnKx2bJ/eo0WrJQBtzgagaCrs0mSZ4Dhif0H31Do
         i/1hu1aP7JH4c9wEYAnHLCz2NAsJk5Er0hO6lRVN/nM2ePSGgLxtCkpsjxXhsXWI8v
         Ai6RKV2QnKjWQ4mflPTvDh2kqaY1U9BYjCyaTV1k=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37LGSDMA074192
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Aug 2023 11:28:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Aug 2023 11:28:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Aug 2023 11:28:13 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37LGSCx6029193;
        Mon, 21 Aug 2023 11:28:12 -0500
Message-ID: <0137b4f7-799f-14ce-3cd6-0af24cab2d8a@ti.com>
Date:   Mon, 21 Aug 2023 11:28:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62-main: PM fixes in the fss
 node
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Vibhore Vardhan <vibhore@ti.com>
References: <20230818103750.516309-1-d-gole@ti.com>
 <20230818103750.516309-2-d-gole@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230818103750.516309-2-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 5:37 AM, Dhruva Gole wrote:
> * Make use of Simple Power-Managed Bus as the fss bus controller is under
> the control of a functional clock, and also is part of a PM domain.
> * Specify the appropriate k3 pd to the fss node as per tisci docs [0].
> 
> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62x/devices.html
> 

This doc makes it look like the number should be 73, but you have 74, what is FSAS?

Andrew

> Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 284b90c94da8..b23c9e3d91cd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -640,10 +640,11 @@ usb1: usb@31100000 {
>   	};
>   
>   	fss: bus@fc00000 {
> -		compatible = "simple-bus";
> +		compatible = "simple-pm-bus";
>   		reg = <0x00 0x0fc00000 0x00 0x70000>;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> +		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
>   		ranges;
>   
>   		ospi0: spi@fc40000 {
