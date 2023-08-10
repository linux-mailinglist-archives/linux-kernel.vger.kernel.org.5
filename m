Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA537777E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjHJMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjHJMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:12:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841726B1;
        Thu, 10 Aug 2023 05:12:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ACBomG032763;
        Thu, 10 Aug 2023 07:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691669510;
        bh=kp91PrHjs1WM2izjm0PgsCJNWBWSWA0box+2Wy3ZnrE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XsAvofXzE+8SlfTElobc6QnbOXudvzJK3htRtSRwFdQNsfDOXzFGGCw3TBEpBstCa
         wKycc0GXtMxheZMjBPBz1jt1DOkkt1BMhq52hru8D9e+wL+egiERvoZ15kuVS72WhL
         5z3ebMIZ461tW41KzayigKVD3FbmohSGlmxpe8FI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ACBoDT084799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 07:11:50 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 07:11:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 07:11:49 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ACBh8u006339;
        Thu, 10 Aug 2023 07:11:44 -0500
Message-ID: <80071066-bec4-c2dd-8ad3-932e8d9e27c1@ti.com>
Date:   Thu, 10 Aug 2023 17:41:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-4-danishanwar@ti.com>
 <b43ee5ca-2aab-445a-e24b-cbc95f9186ea@ti.com>
 <c7ddb12d-ae18-5fc2-9729-c88ea73b21d7@ti.com>
 <1b05b4ae-00e7-0f90-9c63-7da8797bdb6a@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <1b05b4ae-00e7-0f90-9c63-7da8797bdb6a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/23 5:35 pm, Roger Quadros wrote:
> 
> 
> On 10/08/2023 14:50, Md Danish Anwar wrote:
>> Hi Andrew,
>>
>> On 09/08/23 8:30 pm, Andrew Davis wrote:
>>> On 8/9/23 6:49 AM, MD Danish Anwar wrote:
>>>> From: Roger Quadros <rogerq@ti.com>
>>>>
>>>> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
>>>> support timestamping of ethernet packets and thus support PTP and PPS
>>>> for PRU ethernet ports.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>   drivers/net/ethernet/ti/Kconfig          |  12 +
>>>>   drivers/net/ethernet/ti/Makefile         |   1 +
>>>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 935 +++++++++++++++++++++++
>>>>   drivers/net/ethernet/ti/icssg/icss_iep.h |  38 +
>>>>   4 files changed, 986 insertions(+)
>>>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>>>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>>>> index 63e510b6860f..88b5b1b47779 100644
>>>> --- a/drivers/net/ethernet/ti/Kconfig
>>>> +++ b/drivers/net/ethernet/ti/Kconfig
>>>> @@ -186,6 +186,7 @@ config CPMAC
>>>>   config TI_ICSSG_PRUETH
>>>>       tristate "TI Gigabit PRU Ethernet driver"
>>>>       select PHYLIB
>>>> +    select TI_ICSS_IEP
>>>
>>> Why not save selecting this until you add its use in the ICSSG_PRUETH driver in
>>> the next patch.
>>>
>>
>> The next patch is only adding changes to icssg-prueth .c /.h files. This patch
>> is adding changes to Kconfig and the Makefile. To keep it that way selecting
>> this is added in this patch. No worries, I will move this to next patch.
>>
>>> [...]
>>>
>>>> +
>>>> +static u32 icss_iep_readl(struct icss_iep *iep, int reg)
>>>> +{
>>>> +    return readl(iep->base + iep->plat_data->reg_offs[reg]);
>>>> +}
>>>
>>> Do these one line functions really add anything? Actually why
>>> not use the regmap you have here.
>>
>> These one line functions are not really adding anything but they are acting as
>> a wrapper around readl /writel and providing some sort of encapsulation as
>> directly calling readl will result in a little complicated code.
>>
>> /* WIth One line function */
>> ts_lo = icss_iep_readl(iep, ICSS_IEP_COUNT_REG0);
>>
>> /* Without one line function */
>> ts_lo = readl(iep->base, iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
>>
>> Previously regmap was used in this driver. But in older commit [1] in
>> 5.10-ti-linux-kernel (Before I picked the driver for upstream) it got changed
>> to readl / writel stating that regmap_read / write is too slow. IEP is time
>> sensitive and needs faster read and write, probably because of this they
>> changed it.
> 
> This is true. Can you please pick the exact reasoning mentioned there
> and put it as a comment where you use read/writel() instead of regmap()
> so we don't forget this and accidentally switch it back to regmap()
> in the future.
> 

Sure I can add this comment wherever we use readl / writel().

> I think this is only required for read/write to the IEP count register and
> SYNC_CTRL_REG when doing gettime/settime.
> 

Yes. This is only used in SYNC_CTRL_REG and IEP counters.

-- 
Thanks and Regards,
Danish.
