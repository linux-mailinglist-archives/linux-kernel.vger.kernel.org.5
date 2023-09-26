Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC87AF196
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjIZROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:13:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13ED10A;
        Tue, 26 Sep 2023 10:13:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QHDemY053018;
        Tue, 26 Sep 2023 12:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695748420;
        bh=pAqjAHzJL/gEQqTo5/2Ffn6ANWX6xspZpkSBw/wOuNU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Epj2VFkOD1j9JBhOdza3Oud9xtvraBDWQMY8QdpHSDfwVWZFr/yqjYfmLfznqjbL4
         qwlZMkYTr28U2xsENki84GdB23fTtLi9YYcqn29XHaGU1MmmQqlAUFDjKwuAXqrG7t
         t05NofwXj5RghT4xcv6ogM3k5pHWmwMvR8xIpaZc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QHDeh0075877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 12:13:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 12:13:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 12:13:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QHDeBu106480;
        Tue, 26 Sep 2023 12:13:40 -0500
Date:   Tue, 26 Sep 2023 12:13:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] arm64: dts: ti: k3-j721s2-main: Add the main
 domain watchdog instances
Message-ID: <20230926171340.t227lqfjjcitx37z@clump>
References: <20230926132805.6518-1-j-keerthy@ti.com>
 <20230926132805.6518-7-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926132805.6518-7-j-keerthy@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:58-20230926, Keerthy wrote:
> There are totally 9 instances of watchdog module. One each for the
> 2 A72 cores, one each for the 2 C7x cores, 1 for the GPU, 1 each
> for the 4 R5F cores in the main domain. Keeping only the A72 instances
> enabled and disabling the rest by default.

Will be good to explain why in the commit message as well.

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 8a717b592238..5e3c0ef9b10b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -1702,4 +1702,92 @@
>  		ti,esm-pins = <688>, <689>;
>  		bootph-pre-ram;
>  	};
> +
> +	watchdog0: watchdog@2200000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2200000 0x00 0x100>;
> +		clocks = <&k3_clks 286 1>;
> +		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 286 1>;
> +		assigned-clock-parents = <&k3_clks 286 5>;
> +	};
> +
> +	watchdog1: watchdog@2210000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2210000 0x00 0x100>;
> +		clocks = <&k3_clks 287 1>;
> +		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 287 1>;
> +		assigned-clock-parents = <&k3_clks 287 5>;
> +	};
> +
> +	watchdog16: watchdog@2300000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2300000 0x00 0x100>;
> +		clocks = <&k3_clks 288 1>;
> +		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 288 1>;
> +		assigned-clock-parents = <&k3_clks 288 5>;
> +		status = "disabled";
> +	};
> +
> +	watchdog17: watchdog@2310000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2310000 0x00 0x100>;
> +		clocks = <&k3_clks 289 1>;
> +		power-domains = <&k3_pds 289 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 289 1>;
> +		assigned-clock-parents = <&k3_clks 289 5>;
> +		status = "disabled";
> +	};
> +
> +	watchdog15: watchdog@22f0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x22f0000 0x00 0x100>;
> +		clocks = <&k3_clks 290 1>;
> +		power-domains = <&k3_pds 290 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 290 1>;
> +		assigned-clock-parents = <&k3_clks 290 5>;
> +		status = "disabled";
> +	};
> +
> +	watchdog28: watchdog@23c0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23c0000 0x00 0x100>;
> +		clocks = <&k3_clks 291 1>;
> +		power-domains = <&k3_pds 291 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 291 1>;
> +		assigned-clock-parents = <&k3_clks 291 5>;
> +		status = "disabled";
> +	};
> +
> +	watchdog29: watchdog@23d0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23d0000 0x00 0x100>;
> +		clocks = <&k3_clks 292 1>;
> +		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 292 1>;
> +		assigned-clock-parents = <&k3_clks 292 5>;
> +		status = "disabled";
> +	};
> +
> +	watchdog30: watchdog@23e0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23e0000 0x00 0x100>;
> +		clocks = <&k3_clks 293 1>;
> +		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 293 1>;
> +		assigned-clock-parents = <&k3_clks 293 5>;
> +		status = "disabled";
> +	};
> +
> +	watchdog31: watchdog@23f0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23f0000 0x00 0x100>;
> +		clocks = <&k3_clks 294 1>;
> +		power-domains = <&k3_pds 294 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 294 1>;
> +		assigned-clock-parents = <&k3_clks 294 5>;
> +		status = "disabled";

Missing documentation here as well.

> +	};
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
