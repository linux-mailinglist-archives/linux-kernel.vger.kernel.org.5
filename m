Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7975BD89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGUExf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUExc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:53:32 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C50B272C;
        Thu, 20 Jul 2023 21:53:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36L4qwGr081690;
        Thu, 20 Jul 2023 23:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689915178;
        bh=TJB0W8uMKkqeSiZJdeJ9vBNC463NlZcRNM7y5mRiSUA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UB9G2KGJR4bewLFkwJPxog4MvcNVgTiY5aS8SCtv/xGgc5HbRJut9yKXtA9hM5Zy7
         0r1dUSs2xTEN0XiLEGu+DwfVqoMK/NWBMAeOSG91xcvf/InbH68Id85/looHpprFmy
         47nkEnk7kpEoPRYoNw7Xfv3trNxZtvZ/C4ROqk8Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36L4qwQv106168
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jul 2023 23:52:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jul 2023 23:52:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jul 2023 23:52:58 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36L4qqfd066510;
        Thu, 20 Jul 2023 23:52:52 -0500
Message-ID: <4f793128-815c-dadd-f5d6-cb2603d2bee9@ti.com>
Date:   Fri, 21 Jul 2023 10:22:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v10 2/2] net: ti:
 icssg-prueth: Add ICSSG ethernet driver
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
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
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230719082755.3399424-1-danishanwar@ti.com>
 <20230719082755.3399424-3-danishanwar@ti.com>
 <20230719213543.0380e13e@kernel.org>
 <17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com>
 <2c9f7a88-1a99-73ce-e924-0effef399719@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <2c9f7a88-1a99-73ce-e924-0effef399719@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/23 1:11 am, Roger Quadros wrote:
> Hi Danish,
> 
> On 20/07/2023 14:42, Md Danish Anwar wrote:
>> Hi Jakub,
>>
>> On 20/07/23 10:05 am, Jakub Kicinski wrote:
>>> The patch is too big to review.
>>>
>>> Please break it apart separating into individual features, targeting
>>> around 10 patches in the series. That will make it easier for reviewers
>>> to take a look at the features in which they have expertise.
>>>
>>
>> Sure Jakub. I will try to break this patch in multiple patches as below.
>>
>> Patch 1: Introduce Firmware mapping for the driver (icss_switch_map.h)
>>
>> Patch 2: Introduce mii helper APIs. (icssg_mii_rt.h and icssg_mii_cfg.h). This
>> patch will also introduce basic prueth and emac structures in icssg_prueth.h as
>> these structures will be used by the helper APIs.
>>
>> Patch 3: Introduce firmware configuration and classification APIs.
>> (icssg_classifier.c, icssg_config.h and icssg_config.c)
>>
>> Patch 4: Introduce APIs for ICSSG Queues (icssg_queues.c)
>>
>> Patch 5: Introduce ICSSG Ethernet driver. (icssg_prueth.c and icssg_prueth.h)
>> This patch will enable the driver and basic functionality can work after this
>> patch. This patch will be using all the APIs introduced earlier. This patch
>> will also include Kconfig and Makefile changes.
> 
> DT binding documentation patch can come here.
> 

Sure, Roger. I will add DT binding documentation patch here.

>>
>> Patch 6: Enable standard statistics via ndo_get_stats64
>>
>> Patch 7: Introduce ethtool ops for ICSSG
>>
>> Patch 8: Introduce power management support (suspend / resume APIs)
>>
> 
> <snip>
> 

-- 
Thanks and Regards,
Danish.
