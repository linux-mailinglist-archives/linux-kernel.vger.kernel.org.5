Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F907B998A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbjJEBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbjJEBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:17:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0AC0;
        Wed,  4 Oct 2023 18:17:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3951Hlbm116088;
        Wed, 4 Oct 2023 20:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696468667;
        bh=IkVYO0CsC8EwgKF38pl+cqHfyQnDQ6Xtd1ZTQ39EZMY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dAAk877H6sEjKdMnm+YuwB6MGOflWCsaiv/3HuxrxEjFyz9/FoyVQYrWof2W3yfTX
         NL71tHXI8cq/nmuqzzRxSeN+ACz8+ZUzQ3Ng4SyDpxR1WlgID4ad5eXemzau/9U8ZA
         WODjiIdOISy9IHQJdx5Xpzp9gsPWdmOcV4o8BamM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3951Hlt1125810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 20:17:47 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 20:17:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 20:17:47 -0500
Received: from [10.249.131.134] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3951FQMc058551;
        Wed, 4 Oct 2023 20:17:43 -0500
Message-ID: <82902754-7a01-4c96-9201-3d1413ff376a@ti.com>
Date:   Thu, 5 Oct 2023 06:47:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] arm64: dts: ti: k3-j784s4-main: Add the main
 domain watchdog instances
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230927023357.9883-1-j-keerthy@ti.com>
 <20230927023357.9883-5-j-keerthy@ti.com>
 <a8749e98-7ead-939e-6fa6-35779593a5f4@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <a8749e98-7ead-939e-6fa6-35779593a5f4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 12:18 PM, Vignesh Raghavendra wrote:
> 
> 
> On 27/09/23 08:03, Keerthy wrote:
>> +	/*
>> +	 * The following RTI instances are coupled with MCU R5Fs, c7x and
>> +	 * GPU so keeping them disabled as these will be used by their
>> +	 * respective firmware
>> +	 */
>> +	watchdog16: watchdog@2300000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x2300000 0x00 0x100>;
>> +		clocks = <&k3_clks 356 1>;
>> +		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 356 0>;
>> +		assigned-clock-parents = <&k3_clks 356 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog17: watchdog@2310000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x2310000 0x00 0x100>;
>> +		clocks = <&k3_clks 357 1>;
>> +		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 357 0>;
>> +		assigned-clock-parents = <&k3_clks 357 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog18: watchdog@2320000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x2320000 0x00 0x100>;
>> +		clocks = <&k3_clks 358 1>;
>> +		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 358 0>;
>> +		assigned-clock-parents = <&k3_clks 358 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog19: watchdog@2330000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x2330000 0x00 0x100>;
>> +		clocks = <&k3_clks 359 1>;
>> +		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 359 0>;
>> +		assigned-clock-parents = <&k3_clks 359 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog15: watchdog@22f0000 {
> 
> 
> I understand you are arranging based on Firmware Device ID. But these
> numbers don't have much meaning when user maps to TRM. So, I suggest
> nodes to be arranged by TRM numbering or ascending order of register
> address so that its easier for end user to map the nodes to IP  instance
> in TRM.
> 

Okay. I will arrange them by the order of register addresses.

>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x22f0000 0x00 0x100>;
>> +		clocks = <&k3_clks 360 1>;
>> +		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 360 0>;
>> +		assigned-clock-parents = <&k3_clks 360 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog28: watchdog@23c0000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x23c0000 0x00 0x100>;
>> +		clocks = <&k3_clks 361 1>;
>> +		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 361 0>;
>> +		assigned-clock-parents = <&k3_clks 361 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog29: watchdog@23d0000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x23d0000 0x00 0x100>;
>> +		clocks = <&k3_clks 362 1>;
>> +		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 362 0>;
>> +		assigned-clock-parents = <&k3_clks 362 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog30: watchdog@23e0000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x23e0000 0x00 0x100>;
>> +		clocks = <&k3_clks 363 1>;
>> +		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 363 0>;
>> +		assigned-clock-parents = <&k3_clks 363 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog31: watchdog@23f0000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x23f0000 0x00 0x100>;
>> +		clocks = <&k3_clks 364 1>;
>> +		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 364 0>;
>> +		assigned-clock-parents = <&k3_clks 364 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog32: watchdog@2540000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x2540000 0x00 0x100>;
>> +		clocks = <&k3_clks 365 1>;
>> +		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 365 0>;
>> +		assigned-clock-parents = <&k3_clks 366 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	watchdog33: watchdog@2550000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x2550000 0x00 0x100>;
>> +		clocks = <&k3_clks 366 1>;
>> +		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 366 0>;
>> +		assigned-clock-parents = <&k3_clks 366 4>;
>> +		status = "disabled";
>> +	};
>>   };
>> -- 2.17.1
> 
