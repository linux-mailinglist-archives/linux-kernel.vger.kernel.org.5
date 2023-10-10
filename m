Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FF7BF907
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJJKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJJKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:52:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FFB9E;
        Tue, 10 Oct 2023 03:52:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39AAq6o5032829;
        Tue, 10 Oct 2023 05:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696935126;
        bh=oSPSnBKZdHVLcqT090/S3W4jEjltoaKY3E3PJVFhytY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eqyOML1ZIp1QDevFJMEcAlMdqrRTxUTKPJI7Adx0jLLo85EWiPALRCPqWgcD7yakX
         laDnidREGvB0EFHLfKyxHzy+5ifXVCYZwJLH2eEnhV28wA86ZDWSm0Rqm0GSiWvqi8
         7MOlMTCUrDdHR0E5eios5FuEE2XblLPQe2dNeQHQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39AAq64E013790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 05:52:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 05:52:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 05:52:06 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39AAq2ZV060182;
        Tue, 10 Oct 2023 05:52:03 -0500
Message-ID: <f7563d43-d944-4426-8616-a49329d69ecb@ti.com>
Date:   Tue, 10 Oct 2023 16:22:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721s2-main: Add BCDMA instance
 for CSI2RX
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20231010092700.2089-1-vaishnav.a@ti.com>
 <20231010092700.2089-2-vaishnav.a@ti.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20231010092700.2089-2-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vaishnav,

On 10/10/23 14:56, Vaishnav Achath wrote:
> J721S2 has a dedicated BCDMA controller for the Camera Serial Interface.
> Events from the BCDMA controller instance are routed through the
> main UDMA interrupt aggregator as unmapped events. Add the node for
> the DMA controller and keep it disabled by default.
> 
> See J721S2 Technical Reference Manual (SPRUJ28)
> for further details: http://www.ti.com/lit/pdf/spruj28
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 6d32544c8881..2a51a8d98c3c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -807,6 +807,7 @@
>   			ti,sci = <&sms>;
>   			ti,sci-dev-id = <265>;
>   			ti,interrupt-ranges = <0 0 256>;
> +			ti,unmapped-event-sources = <&main_bcdma_csi>;
>   		};
>   
>   		secure_proxy_main: mailbox@32c00000 {
> @@ -1103,6 +1104,22 @@
>   			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
>   		};
>   
> +		main_bcdma_csi: dma-controller@311a0000 {
> +			compatible = "ti,j721s2-dmss-bcdma-csi";
> +			reg = <0x00 0x311a0000 0x00 0x100>,
> +				<0x00 0x35d00000 0x00 0x20000>,
> +				<0x00 0x35c00000 0x00 0x10000>,
> +				<0x00 0x35e00000 0x00 0x80000>;

Indentation is off here...
Same in patch 2/2..


> +			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
> +			msi-parent = <&main_udmass_inta>;
> +			#dma-cells = <3>;
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <225>;
> +			ti,sci-rm-range-rchan = <0x21>;
> +			ti,sci-rm-range-tchan = <0x22>;
> +			status = "disabled";
> +		};
> +
>   		cpts@310d0000 {
>   			compatible = "ti,j721e-cpts";
>   			reg = <0x0 0x310d0000 0x0 0x400>;
