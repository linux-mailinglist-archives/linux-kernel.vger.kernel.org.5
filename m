Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0207AFE44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjI0I0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjI0IZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:25:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC67DE;
        Wed, 27 Sep 2023 01:25:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R8P8Up005152;
        Wed, 27 Sep 2023 03:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695803108;
        bh=7JCLfOz6vi/ZAWl1OetwVW/EMHbMuWTaPqKghyNaO+Y=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=JbWc0Vn0XWM0m+nIRLLef+FHhnyaOsTZIVWnTDD1Ny9QqX5OZN+7tkV4M7Vo8tYO9
         IoAjPf8Frz2pzdcFl/ByTTLjlVdfhSrgWnmjdlP4yJGlM9IhX0cGm8Fo+vu8xJ8IPJ
         KwdQKIP0ShgnkdQOaSrfLDjb14DJKCxrshJLmIf4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R8P8mT096569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 03:25:08 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 03:25:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 03:25:07 -0500
Received: from [10.24.68.251] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R8P4x5093336;
        Wed, 27 Sep 2023 03:25:04 -0500
Message-ID: <0dfcac11-13d1-32fe-9c85-3663bcc34177@ti.com>
Date:   Wed, 27 Sep 2023 13:55:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 7/7] dts: ti: k3-j712s2-mcu: Add the mcu domain
 watchdog instances
Content-Language: en-US
From:   "J, KEERTHY" <j-keerthy@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230927023357.9883-1-j-keerthy@ti.com>
 <20230927023357.9883-8-j-keerthy@ti.com>
 <877f583e-ed08-4248-ac38-28e8c3039444@linaro.org>
 <78a9a231-ce53-7a3c-d9ce-af9d1c2a097d@ti.com>
In-Reply-To: <78a9a231-ce53-7a3c-d9ce-af9d1c2a097d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 1:46 PM, J, KEERTHY wrote:
> 
> 
> On 9/27/2023 1:23 PM, Krzysztof Kozlowski wrote:
>> On 27/09/2023 04:33, Keerthy wrote:
>>> There are totally 2 instances of watchdog module in MCU domain.
>>> These instances are coupled with the MCU domain R5F instances.
>>> Disabling them as they are not used by Linux.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>
>> Still incorrect subject prefix.
> 
> Sorry. I missed this :-(. I will fix all your comments in the next version.

Hi Krzysztof,

If there are no further comments on V6. Can i resend this patch alone 
with subject corrected?

Regards,
Keerthy

> 
>>
>> Best regards,
>> Krzysztof
>>
