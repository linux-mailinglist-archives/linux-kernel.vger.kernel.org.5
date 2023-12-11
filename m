Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2680C7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjLKLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjLKLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:17:02 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0DEB0;
        Mon, 11 Dec 2023 03:17:07 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BBBGknS085705;
        Mon, 11 Dec 2023 05:16:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702293406;
        bh=fylZgBVW8i6eYuwRT+zXtBdya0Mm/BLDF11KB2kf4O8=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=Y8DiaeX3iSpym58Lh2kBXEH2LoZDuNmRm1bYguvcqqSycOnXhlucl7CdxWx8FqgUp
         P1vnM1VY3GTziiuSHEJtWCpY/ihet01OyKIhRfb/OWMLkIqRkfGD4dkPh9ax+OQz7S
         0P4vE81r9VzjRa+3lF1NsMClEGUi6HyRBZyY3RBg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BBBGkb0071434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 05:16:46 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 05:16:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 05:16:45 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BBBGfgw063959;
        Mon, 11 Dec 2023 05:16:42 -0600
Message-ID: <750c2b6b-8f24-4b86-996f-6f50cf46d81b@ti.com>
Date:   Mon, 11 Dec 2023 16:46:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-evm: Add overlay for
 PCIE0 Endpoint Mode
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>
References: <20231115085204.3578616-1-s-vadapalli@ti.com>
 <20231115085204.3578616-2-s-vadapalli@ti.com>
 <c50f5dc2-8ab8-4213-a809-fcd4cd18589d@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <c50f5dc2-8ab8-4213-a809-fcd4cd18589d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 05/12/23 21:43, Andrew Davis wrote:
> On 11/15/23 2:52 AM, Siddharth Vadapalli wrote:
>> Add overlay to enable the PCIE0 instance of PCIe on J721E-EVM in
>> Endpoint mode of operation.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |  3 ++
>>   .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    | 53 +++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 77a347f9f47d..5620db44d4dc 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -66,6 +66,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm.dtb
>>   k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb
>> k3-j721e-evm-quad-port-eth-exp.dtbo
>>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
>> +k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-evm.dtb k3-j721e-evm-pcie0-ep.dtbo
>> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtb
> 
> Do you really need to produce this pre-combined DTB file? If you would rather
> just the overlay produced which could be applied at load-time (I prefer this),
> then you should do as Jai has done[0]. Add just the overlay, and test its
> application using a dummy target.

Thank you for pointing it out. I will implement your suggestion and post the v3
series.

-- 
Regards,
Siddharth.
