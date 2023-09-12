Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30579C4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjILEgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjILEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:36:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E57B8;
        Mon, 11 Sep 2023 21:36:37 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C4aOL1028749;
        Mon, 11 Sep 2023 23:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694493384;
        bh=pAzHY0X+jRIjpgVJgkyvsyZaFVqA+M1u7WDWULb5P/o=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=yuIYtvaqI9yXYxF7UQqbzNqC4Snfx4c5RQwPRj9oByz88/ejGAI5iUzLTBrWolQxu
         JoRI3APZbq/J+Rrn0RZdsbWX7qRB84cnGrOtqUC2MN5YpzqG/V2tCyk1CGZ4IHJwSC
         WrdzfSm2/Fkfm4vj0Yzy7AIOkx2S7loG5NZqFDXw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C4aOE1020012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 23:36:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 23:36:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 23:36:24 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C4aKOO020303;
        Mon, 11 Sep 2023 23:36:21 -0500
Message-ID: <29739e31-a217-0fc2-fabf-30bd4f50c5b6@ti.com>
Date:   Tue, 12 Sep 2023 10:06:20 +0530
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
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
References: <20230911052158.89185-1-s-vadapalli@ti.com>
 <20230911165610.GA1362932-robh@kernel.org>
 <340bb897-d735-fabc-a031-8e4ebcfe79fa@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <340bb897-d735-fabc-a031-8e4ebcfe79fa@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/23 09:31, Siddharth Vadapalli wrote:
> Rob,
> 
> Thank you for reviewing the patch.
> 
> On 11/09/23 22:26, Rob Herring wrote:

...
>> Move this next to the "dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb" line.
> 
> Sure, I will place it above the k3-j721s2-evm.dtb line.
> 
>>
>>>  dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
>>> -dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>>> -dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
>>
>> I think dropping these will cause them to not get installed (by 
>> dtbs_install). Presumably you want them.
> 
> I will undo the above deletions in the v2 patch.

I have addressed the feedback and have posted the v2 patch at:
https://lore.kernel.org/r/20230912043308.20629-1-s-vadapalli@ti.com/

> 
>>
>>> +dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
>>>  
>>>  # Boards with J784s4 SoC
>>>  dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>>> -- 
>>> 2.34.1
>>>
> 

-- 
Regards,
Siddharth.
