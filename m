Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B226D80C8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjLKMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:03:47 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3C2695;
        Mon, 11 Dec 2023 04:02:51 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BBC2W2g078891;
        Mon, 11 Dec 2023 06:02:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702296152;
        bh=r4l2TpIecJ6incJwPZiirAr4p9X+dR1dJYdpttah6uA=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=LauqVCWnMw593PVx/DA6GMwPCzP76UR7p51z+d7ppkz9BXpj7yjZYgga7BsAitml8
         e14u5tReyVMz5aBjRAL5UQ+qtG8niaNwLVmezNZqf7mGB2XkIitVgXAeKZ9u562lAw
         zqF66VlPKJimHPrrzTCh+277r8TbNkJjy7yCSTo8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BBC2WUQ006625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 06:02:32 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 06:02:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 06:02:31 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BBC2R57116266;
        Mon, 11 Dec 2023 06:02:28 -0600
Message-ID: <4c033e0c-a453-4d30-814a-fda401ae82db@ti.com>
Date:   Mon, 11 Dec 2023 17:32:27 +0530
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
 <750c2b6b-8f24-4b86-996f-6f50cf46d81b@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <750c2b6b-8f24-4b86-996f-6f50cf46d81b@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/23 16:46, Siddharth Vadapalli wrote:
> Hello Andrew,
> 
> On 05/12/23 21:43, Andrew Davis wrote:
>> On 11/15/23 2:52 AM, Siddharth Vadapalli wrote:
>>> Add overlay to enable the PCIE0 instance of PCIe on J721E-EVM in
>>> Endpoint mode of operation.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/Makefile               |  3 ++
>>>   .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    | 53 +++++++++++++++++++
>>>   2 files changed, 56 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>> index 77a347f9f47d..5620db44d4dc 100644
>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>> @@ -66,6 +66,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm.dtb
>>>   k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb
>>> k3-j721e-evm-quad-port-eth-exp.dtbo
>>>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>>>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
>>> +k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-evm.dtb k3-j721e-evm-pcie0-ep.dtbo
>>> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtb
>>
>> Do you really need to produce this pre-combined DTB file? If you would rather
>> just the overlay produced which could be applied at load-time (I prefer this),
>> then you should do as Jai has done[0]. Add just the overlay, and test its
>> application using a dummy target.
> 
> Thank you for pointing it out. I will implement your suggestion and post the v3
> series.

I have posted the v3 series at:
https://lore.kernel.org/r/20231211115535.1264353-1-s-vadapalli@ti.com/

> 

-- 
Regards,
Siddharth.
