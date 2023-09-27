Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5747AFE43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjI0I0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjI0IZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:25:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE810DC;
        Wed, 27 Sep 2023 01:16:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R8GDj7002230;
        Wed, 27 Sep 2023 03:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695802573;
        bh=yIn5zxmvYo4azr/4bZX+OLlJcq7q6KBIv0PdFQdZU1c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=s7AE6o+dTsauPL0S8UK3hjRhgIC5G4qNNri+jSfAcZUi9BuQLlL2mVh2AbgTNtpzH
         DsNw1FBK10MGqZdkt73VGQ+mEW70vGVqqsLYJCsO3RoG6YM1ffm6N7S9IEPLB5VDda
         4yLdX0Z76xpzk8H+76kFybPhoibPfdXcVzVSDpyA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R8GDrv013949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 03:16:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 03:16:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 03:16:12 -0500
Received: from [10.24.68.251] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R8G97O016607;
        Wed, 27 Sep 2023 03:16:09 -0500
Message-ID: <78a9a231-ce53-7a3c-d9ce-af9d1c2a097d@ti.com>
Date:   Wed, 27 Sep 2023 13:46:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 7/7] dts: ti: k3-j712s2-mcu: Add the mcu domain
 watchdog instances
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230927023357.9883-1-j-keerthy@ti.com>
 <20230927023357.9883-8-j-keerthy@ti.com>
 <877f583e-ed08-4248-ac38-28e8c3039444@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <877f583e-ed08-4248-ac38-28e8c3039444@linaro.org>
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



On 9/27/2023 1:23 PM, Krzysztof Kozlowski wrote:
> On 27/09/2023 04:33, Keerthy wrote:
>> There are totally 2 instances of watchdog module in MCU domain.
>> These instances are coupled with the MCU domain R5F instances.
>> Disabling them as they are not used by Linux.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Still incorrect subject prefix.

Sorry. I missed this :-(. I will fix all your comments in the next version.

> 
> Best regards,
> Krzysztof
> 
