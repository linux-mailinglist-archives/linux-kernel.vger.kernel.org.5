Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F49769425
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGaLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGaLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:04:24 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857098;
        Mon, 31 Jul 2023 04:04:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VB48XA090400;
        Mon, 31 Jul 2023 06:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690801449;
        bh=2s7y4x9ALMJcAPeRMbH4B/6pgYS7LMpTQw6PM++pX/Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kGDIAOS1gKI6fAu3Z2m5UlAhjf/zYtgOB2Ef4XSgqqNsKWLOC9XF3bX9Obd+C3dVl
         FVirPQJoXTi45ZqfuxCj0GwpTplkmPulcLCWYQhQU/hQRo4VwqaYalX409UdH5JQjW
         OZdVQuctl5zusU/gktlt2WsP1rgCk5YOh5jJQZdI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VB48f2025022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 06:04:08 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 06:04:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 06:04:08 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VB43it026616;
        Mon, 31 Jul 2023 06:04:04 -0500
Message-ID: <bb60a183-8f05-34cb-d26e-15405a19da27@ti.com>
Date:   Mon, 31 Jul 2023 16:34:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/4] Add peripherals for J784S4
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230728050859.7370-1-j-choudhary@ti.com>
 <20230728211217.mipwoira57g7dcc6@moody>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230728211217.mipwoira57g7dcc6@moody>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nishanth,

On 29/07/23 02:42, Nishanth Menon wrote:
> On 10:38-20230728, Jayesh Choudhary wrote:
>> This series adds support for:
>> - SERDES, WIZ DT nodes, Serdes lane control mux
>> - DSS and DisplayPort-0 nodes
>>
>> This support DEPENDS upon another series which was introduced as part
>> of discussion in v5. That series[1] moves the ti-serdes headers file
>> from bindings to "arch/arm64/boot/dts/ti". (That series is merged in
>> linux-next tree)
>>
>> Changelog v6->v7:
>> - change compatible for scm_conf to 'simple-bus'
>> - drop main_cpsw node due to driver dependency on [2]
>>

[...]

>>
>> v5 patch link:
>> <https://lore.kernel.org/all/20230721132029.123881-1-j-choudhary@ti.com/>
>>
>> [1]: <https://lore.kernel.org/all/20230721125732.122421-1-j-choudhary@ti.com/>
>> [2]: <https://lore.kernel.org/all/20230605154153.24025-1-afd@ti.com/>
>>
>> Rahul T R (2):
>>    arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
>>    arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0
>>
> 
> Could you enable AM69-SK as well? is there anything stopping it being part of the series?
> 

Okay I will add support for AM69-SK too.

Thanks,
-Jayesh
