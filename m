Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0179C479
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjILECd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbjILECS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:02:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD210E9;
        Mon, 11 Sep 2023 21:01:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C41LFb037423;
        Mon, 11 Sep 2023 23:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694491281;
        bh=TZvjOuTthCUnn+wnX6VIpTXluyUFKyEBjC9L+CVAYto=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=CNErcRlHP0ocrkhy9c71VaQDHu5BwwNLk9brnhAN8haFrqcUIvs57wCuGjgzXokBd
         ByZaO/t5khNc9+COMlp0+HXDPfH/Pi+zNys2vhkB4euw/JibVpDIPPV2je6X733Agt
         aY2wuYqa5oNfXAQJUv8qlWhmrVICmUQxzdRSFjbA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C41Lar117082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 23:01:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 23:01:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 23:01:21 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C41HUN121677;
        Mon, 11 Sep 2023 23:01:18 -0500
Message-ID: <340bb897-d735-fabc-a031-8e4ebcfe79fa@ti.com>
Date:   Tue, 12 Sep 2023 09:31:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-evm-gesi: Specify base dtb for
 overlay file
To:     Rob Herring <robh@kernel.org>
References: <20230911052158.89185-1-s-vadapalli@ti.com>
 <20230911165610.GA1362932-robh@kernel.org>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230911165610.GA1362932-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

Thank you for reviewing the patch.

On 11/09/23 22:26, Rob Herring wrote:
> On Mon, Sep 11, 2023 at 10:51:58AM +0530, Siddharth Vadapalli wrote:
>> Specify the base dtb file k3-j721s2-common-proc-board.dtb on which the
>> k3-j721s2-evm-gesi-exp-board.dtbo overlay has to be applied. Name the
>> resulting dtb as k3-j721s2-evm.dtb.
>>
>> Fixes: cac04e27f093 ("arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI")
>> Reported-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Note: This patch is based on linux-next tagged next-20230911.
>>
>>  arch/arm64/boot/dts/ti/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index e7b8e2e7f083..ef8ca50fbb36 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -63,9 +63,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
>>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>>  
>>  # Boards with J721s2 SoC
>> +k3-j721s2-evm-dtbs := k3-j721s2-common-proc-board.dtb k3-j721s2-evm-gesi-exp-board.dtbo
> 
> Move this next to the "dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb" line.

Sure, I will place it above the k3-j721s2-evm.dtb line.

> 
>>  dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
>> -dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>> -dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
> 
> I think dropping these will cause them to not get installed (by 
> dtbs_install). Presumably you want them.

I will undo the above deletions in the v2 patch.

> 
>> +dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
>>  
>>  # Boards with J784s4 SoC
>>  dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>> -- 
>> 2.34.1
>>

-- 
Regards,
Siddharth.
