Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA777745A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHHSom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjHHSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4614A1558D;
        Tue,  8 Aug 2023 09:40:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378CaIN5068834;
        Tue, 8 Aug 2023 07:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691498178;
        bh=3hSAAtFdQ/105wifDbT6bIs+ir+qYDjjLCrmTGs7Z1o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Rcx9vaEnILLhkC3B9hzEUK2foLJmPTNEvoEdk/LAOh0NbBxi2CEmd3/aZfQm4lZ2P
         oNp5vJCWu1U+p3RYi/dimEbU9XzUQHneN/xSTw23IAmJek9lPNU1nR9+9kmDVu018Q
         D3hbEXl0jNiqwu+CLWxUVJ+PWh0mTXGk3sboSAuk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378CaISm018836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:36:18 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:36:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:36:18 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378CaC1W125832;
        Tue, 8 Aug 2023 07:36:12 -0500
Message-ID: <8bb5a1eb-3912-c418-88fe-b3d8870e7157@ti.com>
Date:   Tue, 8 Aug 2023 18:06:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Introduce IEP driver and packet timestamping
 support
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
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
 <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
 <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 5:52 pm, Roger Quadros wrote:
> 
> 
> On 08/08/2023 15:18, Md Danish Anwar wrote:
>> On 08/08/23 5:38 pm, Conor Dooley wrote:
>>> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
>>>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
>>>> support timestamping of ethernet packets and thus support PTP and PPS
>>>> for PRU ICSSG ethernet ports.
>>>>
>>>> This series also adds 10M full duplex support for ICSSG ethernet driver.
>>>>
>>>> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
>>>> is used for 10M full duplex support.
>>>>
>>>> This is v2 of the series [v1]. It addresses comments made on [v1].
>>>> This series is based on linux-next(#next-20230807). 
>>>>
>>>> Changes from v1 to v2:
>>>> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
>>>>    in patch 3 and 4 were not following reverse xmas tree variable declaration.
>>>>    Fixed it in this version.
>>>> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>>>>    comment in patch 1. 
>>>
>>> I'm sorry I missed responding there before you sent v2, it was a bank
>>> holiday yesterday. I'm curious why you removed them, rather than just
>>> added them with a fallback to the ti,am654-icss-iep compatible, given
>>> your comment that "the same compatible currently works for all these
>>> 3 SoCs".
>>
>> I removed them as currently the driver is being upstreamed only for AM654x,
>> once I start up-streaming the ICSSG driver for AM64 and any other SoC. I will
>> add them here. If at that time we are still using same compatible, then I will
>> modify the comment otherwise add new compatible.
>>
>> As of now, I don't see the need of adding other SoCs in iep binding as IEP
>> driver up-streaming is only planned for AM654x as of now.
> 
> But, is there any difference in IEP hardware/driver for the other SoCs?
> AFAIK the same IP is used on all SoCs.
> 
> If there is no hardware/code change then we don't need to introduce a new compatible.
> The comment for all SoCs can already be there right from the start.
> 

There is no code change. The same compatible is used for other SoCs. Even if
the code is same I was thinking to keep the compatible as below now

- ti,am654-icss-iep   # for K3 AM65x SoCs

and once other SoCs are introduced, I will just modify the comment,

- ti,am654-icss-iep   # for K3 AM65x, AM64x SoCs

But we can also keep the all SoCs in comment right from start as well. I am
fine with both.

Conor / Roger, Please let me know which approach should I go with in next revision?

-- 
Thanks and Regards,
Danish.
