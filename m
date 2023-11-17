Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56107EEC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjKQF4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQF4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:56:13 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE919D;
        Thu, 16 Nov 2023 21:56:08 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH5tu45001196;
        Thu, 16 Nov 2023 23:55:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700200556;
        bh=6IJJMasqtf62CzmMKOg/hsNcw0Ujm/CcK4sypVuIlsk=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=N7mO7+9nQMaUcTtm1xXYJQbKbaT1hFgT2f6yAbWavPb/YuofmqLFrYzh3s6/MlEXf
         1wwtYbuxu02tmYxeFOYmf62NXNjRSnmp18oYx1mp7JPx+mMznCyGDbPYzY3NtXN/+c
         ih4nIkQFhZkoKysfHqIE2ujAOG4R2PxRhNKgj5Xc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH5tunW013043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Nov 2023 23:55:56 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 23:55:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 23:55:55 -0600
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH5trOa014125;
        Thu, 16 Nov 2023 23:55:54 -0600
Message-ID: <c693efec-ab67-44bb-8871-a40dc408f278@ti.com>
Date:   Fri, 17 Nov 2023 11:25:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/4] Add APIs to request TX/RX DMA channels by ID
Content-Language: en-US
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
References: <20231114083906.3143548-1-s-vadapalli@ti.com>
 <9d465de4-3930-4856-9d8e-7deb567a628f@gmail.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <9d465de4-3930-4856-9d8e-7deb567a628f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Péter,

On 16/11/23 01:29, Péter Ujfalusi wrote:
> 
> 
> On 14/11/2023 10:39, Siddharth Vadapalli wrote:
>> The existing APIs for requesting TX and RX DMA channels rely on parsing
>> a device-tree node to obtain the Channel/Thread IDs from their names.
> 
> Yes, since it is a DMA device and it is using the standard DMA mapping.
> It is by design that the standard DMAengine and the custom glue layer
> (which should have been a temporary solution) uses the same standard DMA
> binding to make sure that we are not going to deviate from the standard
> and be able to move the glue users to DMAengine (which would need core
> changes).
> 
>> However, it is possible to know the thread IDs by alternative means such
>> as being informed by Firmware on a remote core regarding the allocated
>> TX/RX DMA channel IDs. Thus, add APIs to support such use cases.
> 
> I see, so the TISCI res manager is going to managed the channels/flows
> for some peripherals?
> 
> What is the API and parameters to get these channels?
> 
> I would really like to follow a standard binding since what will happen
> if the firmware will start to provision channels/flows for DMAengine
> users? It is not that simple to hack that around.

Please consider the following use-case for which the APIs are being added by
this series. I apologize for not explaining the idea behind the APIs in more
detail earlier.

Firmware running on a remote core is in control of a peripheral (CPSW Ethernet
Switch for example) and shares the peripheral across software running on
different cores. The control path between the Firmware and the Clients on
various cores is via RPMsg, while the data path used by the Clients is the DMA
Channels. In the example where Clients send data to the shared peripheral over
DMA, the Clients send RPMsg based requests to the Firmware to obtain the
allocated thead IDs. Firmware allocates the thread IDs by making a request to
TISCI Resource Manager followed by sharing the thread IDs to the Clients.

In such use cases, the Linux Client is probed by RPMsg endpoint discovery over
the RPMsg bus. Therefore, there is no device-tree corresponding to the Client
device. The Client knows the DMA Channel IDs as well as the RX Flow details from
the Firmware. Knowing these details, the Client can request the configuration of
the TX and RX Channels/Flows by using the DMA APIs which this series adds.

Please let me know in case of any suggestions for an implementation which shall
address the above use-case.

> 
> My initial take is that this can be implemented via the existing DMA
> crossbar support. It has been created exactly for this sort of purpose.
> I'm sure you need to provide some sort of parameters to TISCI to get the
> channel/rflow provisioned for the host requesting, right?
> The crossbar implements the binding with the given set of parameters,
> does the needed 'black magic' to get the information needed for the
> target DMA and crafts the binding for it and get's the channel.
> 
> If you take a look at the drivers/dma/ti/dma-crossbar.c, it implements
> two types of crossbars.
> 
> For DMAengine, it would be relatively simple to write a new one for
> tisci, The glue layer might needs a bit more work as it is not relying
> on core, but I would not think that it is that much complicated to
> extend it to be able to handle a crossbar binding.
> The benefit is that none of the clients should not need to know about
> the way the channel is looked up, they just request for an RX channel
> and depending on the binding they will get it directly from the DMA or
> get the translation via the crossbar to be able to fetch the channel.
> 
> Can you check if this would be doable?
> 
> For reference:
> Documentation/devicetree/bindings/dma/dma-router.yaml
> Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> drivers/dma/ti/dma-crossbar.c
> 
>> Additionally, since the name of the device for the remote RX channel is
>> being set purely on the basis of the RX channel ID itself, it can result
>> in duplicate names when multiple flows are used on the same channel.
>> Avoid name duplication by including the flow in the name.
> 
> Make sense.

May I post that patch separately in that case?

>> Series is based on linux-next tagged next-20231114.
>>
>> RFC Series:
>> https://lore.kernel.org/r/20231111121555.2656760-1-s-vadapalli@ti.com/
>>
>> Changes since RFC Series:
>> - Rebased patches 1, 2 and 3 on linux-next tagged next-20231114.
>> - Added patch 4 to the series.
>>
>> Regards,
>> Siddharth.
>>
>> Siddharth Vadapalli (4):
>>   dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
>>   dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
>>   dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID
>>   dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
>>
>>  drivers/dma/ti/k3-udma-glue.c    | 306 ++++++++++++++++++++++---------
>>  include/linux/dma/k3-udma-glue.h |   8 +
>>  2 files changed, 228 insertions(+), 86 deletions(-)
>>
> 

-- 
Regards,
Siddharth.
