Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C887C8163
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjJMJJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjJMJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:08:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725BDE;
        Fri, 13 Oct 2023 02:08:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39D98dDi099617;
        Fri, 13 Oct 2023 04:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697188119;
        bh=Y41yCTdbiYTT+zv2sI1u1rgezzJelM32derRG7Jsxgc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Mh3Ihs+TujT0SMFOofXVpSZgg0M5kuD7IMwKLx3w5A2IlaR2pyda3XwuGC+RXRvCk
         iiNLKEj5JF04iH19jaCTmdgMAwPFsFG9MYRwrqvM9fhqlOJrp4hNFqRYN4TOEi9K/3
         Io1yFmggYtYf+nz8roEOMIGJ4JjGOjn9SU7RG9wY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39D98dSm052310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 04:08:39 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 04:08:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 04:08:38 -0500
Received: from [10.249.131.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39D98UMR071644;
        Fri, 13 Oct 2023 04:08:31 -0500
Message-ID: <063395d4-16e5-8a56-1da3-5a04af3cdbce@ti.com>
Date:   Fri, 13 Oct 2023 14:38:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND v11 0/5] Enable Display for J784S4 and AM69-SK
 platform
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>
CC:     <afd@ti.com>, <rogerq@kernel.org>, <s-vadapalli@ti.com>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231005132732.7462-1-j-choudhary@ti.com>
 <f8d0f807-a7b1-4f17-a3d3-c9ef694da238@ti.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <f8d0f807-a7b1-4f17-a3d3-c9ef694da238@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/10/23 10:31, Vignesh Raghavendra wrote:
> 
> 
> On 05/10/23 18:57, Jayesh Choudhary wrote:
>> This series adds support for:
>> - DisplayPort for J784S4-EVM
>> - Displayport and HDMI for AM69-SK platform
>>
>> NOTE: Patch 4/5 introduces the following dtc warning which can be ignored
>> since its behind W=1 check:
>> Warning (graph_child_address): /bus@100000/dss@4a00000/ports: graph node
>> has single child node 'port@0', #address-cells/#size-cells are not
>> necessary
>>> (This is more accurate description for port and the dtc check should not
>> differentiate between port@0 and port@1.[0])
>>
> 
> Sorry, don't want to more warnings to the file while we are working
> constantly to reduce warnings on the other side. There are 3 options
> 
> a) Propose fix to dtc
> b) Minimally describe second port (DSI) and it keep disabled as its
> unusable currently (this more closely describes the HW and the reason
> why port indexing is needed in first place)
> c) Go back to v9 and describe second port once DSI supported is added in
> future,
> 
> [...]
> 

Posted a fix for the warning here,

https://lore.kernel.org/all/20231013085424.7137-1-a-bhatia1@ti.com/

Regards
Aradhya
