Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A51F774B16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjHHUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHHUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:39:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18966602;
        Tue,  8 Aug 2023 13:08:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378CJ2Uj083190;
        Tue, 8 Aug 2023 07:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691497142;
        bh=/jHNnUYH7ROpdhUSGQLwONQNz4yssgK4/U/2gECz7U0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ZyQFuGLLJu0tCvRgy+Dv/vU1mj5ZjLVFSNgA7raMTmBo06odCGopzmnnoS7xGRqjI
         eXLxctH8R0mIqtQCGbfVKRUjM5msWqo5Ofs/J0UqtQsjlyG7rcdWwHamlLkgO2Vl/7
         2jiPjko3JWnuKqre+YmnwMu2lfC1HkAYQryBlnyQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378CJ2aO055977
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:19:02 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:19:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:19:02 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378CIuHB090555;
        Tue, 8 Aug 2023 07:18:56 -0500
Message-ID: <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
Date:   Tue, 8 Aug 2023 17:48:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Introduce IEP driver and packet
 timestamping support
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
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
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230808-unnerving-press-7b61f9c521dc@spud>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230808-unnerving-press-7b61f9c521dc@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 5:38 pm, Conor Dooley wrote:
> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
>> support timestamping of ethernet packets and thus support PTP and PPS
>> for PRU ICSSG ethernet ports.
>>
>> This series also adds 10M full duplex support for ICSSG ethernet driver.
>>
>> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
>> is used for 10M full duplex support.
>>
>> This is v2 of the series [v1]. It addresses comments made on [v1].
>> This series is based on linux-next(#next-20230807). 
>>
>> Changes from v1 to v2:
>> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
>>    in patch 3 and 4 were not following reverse xmas tree variable declaration.
>>    Fixed it in this version.
>> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>>    comment in patch 1. 
> 
> I'm sorry I missed responding there before you sent v2, it was a bank
> holiday yesterday. I'm curious why you removed them, rather than just
> added them with a fallback to the ti,am654-icss-iep compatible, given
> your comment that "the same compatible currently works for all these
> 3 SoCs".

I removed them as currently the driver is being upstreamed only for AM654x,
once I start up-streaming the ICSSG driver for AM64 and any other SoC. I will
add them here. If at that time we are still using same compatible, then I will
modify the comment otherwise add new compatible.

As of now, I don't see the need of adding other SoCs in iep binding as IEP
driver up-streaming is only planned for AM654x as of now.

> 
> Thanks,
> Conor.
> 
>> *) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
>>    bindings for ICSSG.
>>
>> [v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.com/
>>
>> Thanks and Regards,
>> Md Danish Anwar
>>
>> Grygorii Strashko (1):
>>   net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
>>
>> MD Danish Anwar (1):
>>   dt-bindings: net: Add iep node in ICSSG driver dt binding
>>
>> Md Danish Anwar (1):
>>   dt-bindings: net: Add ICSS IEP
>>
>> Roger Quadros (2):
>>   net: ti: icss-iep: Add IEP driver
>>   net: ti: icssg-prueth: add packet timestamping and ptp support
>>
>>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  37 +
>>  .../bindings/net/ti,icssg-prueth.yaml         |   7 +
>>  drivers/net/ethernet/ti/Kconfig               |  12 +
>>  drivers/net/ethernet/ti/Makefile              |   1 +
>>  drivers/net/ethernet/ti/icssg/icss_iep.c      | 961 ++++++++++++++++++
>>  drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
>>  drivers/net/ethernet/ti/icssg/icssg_config.c  |   6 +
>>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 433 +++++++-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
>>  10 files changed, 1540 insertions(+), 7 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>>
>> -- 
>> 2.34.1
>>

-- 
Thanks and Regards,
Danish.
