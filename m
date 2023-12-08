Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31D809D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjLHH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjLHH24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:28:56 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CACB171F;
        Thu,  7 Dec 2023 23:28:59 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B87ShMV065745;
        Fri, 8 Dec 2023 01:28:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702020523;
        bh=P995/KmxRn+AapdfP+hEBCbOthYU7XKcxWvchCC87rQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tFVI8hH5Eg9BgaB/gBhm3uSRsd8lswY6AWXuNqBIucDUYWsFurUI6UpeU5XGErZS4
         2KUZ2L0nwJTNl5CDSvTH9U+C73lbAQ1zUz5rm6D3uKeNkAQbpaPRy7GTS73mJHyNIh
         rMbkkIn72dEmTKipGUWyvzPkhKLe4Yd3GtEZL4w4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B87ShWW011538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Dec 2023 01:28:43 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Dec 2023 01:28:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Dec 2023 01:28:43 -0600
Received: from [10.249.135.225] ([10.249.135.225])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B87SdsH056714;
        Fri, 8 Dec 2023 01:28:40 -0600
Message-ID: <afec7eaa-9ef5-447f-9619-9721937fe805@ti.com>
Date:   Fri, 8 Dec 2023 12:58:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am642-evm: add overlay for icssg1
 2nd port
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20231207081917.340167-1-danishanwar@ti.com>
 <20231207081917.340167-4-danishanwar@ti.com>
 <fe6499b3-fbda-4e2d-9b5e-92cc60d3a79c@lunn.ch>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <fe6499b3-fbda-4e2d-9b5e-92cc60d3a79c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2023 3:10 AM, Andrew Lunn wrote:
>> +	mdio-mux-2 {
>> +		compatible = "mdio-mux-multiplexer";
>> +		mux-controls = <&mdio_mux>;
>> +		mdio-parent-bus = <&icssg1_mdio>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		mdio@0 {
>> +			reg = <0x0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			icssg1_phy2: ethernet-phy@3 {
>> +				reg = <3>;
>> +				tx-internal-delay-ps = <250>;
>> +				rx-internal-delay-ps = <2000>;
>> +			};
>> +		};
> 
> That looks odd. A mux generally has > 1 mdio bus. Otherwise its not
> really a mux.
> 

We are disabling node `mdio-mux-1` which has the `cpsw3g_mdio` bus and
then adding a new node `mdio-mux-2` which has the `icssg1_mdio` bus. The
mux can actually have two different mdio buses. The patch actually
disables the mux1 node and creates a new node for icssg1_mdio bus so
that cpsw3g mdio bus is disabled properly.

We can modify the existing `mdio-mux-1` as well (added the code below)
instead of disabling mux1 and creating mux2 node.

&mdio_mux_1 {
	mdio-parent-bus = <&icssg1_mdio>;
	#address-cells = <1>;
	#size-cells = <0>;

	mdio@0 {
		reg = <0x0>;
		#address-cells = <1>;
		#size-cells = <0>;

		icssg1_phy2: ethernet-phy@3 {
			reg = <3>;
			tx-internal-delay-ps = <250>;
			rx-internal-delay-ps = <2000>;
		};
	};
};

Let me know what do you think. Is the approach in the patch correct or
should I modify existing mux node only?

> And this mux hardware exists all the time right? So it should be in
> the .dtsi file.
> 

Agreed. But the mdio-mux-1 node was added in k3-am642-evm.dts by the
commit 985204ecae1c37d55372874ff9146231d28fccc6. I did the same with
mdio-mux-2 node.

> 	Andrew

-- 
Thanks and Regards,
Md Danish Anwar
