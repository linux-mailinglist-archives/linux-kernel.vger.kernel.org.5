Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0870C8133C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573608AbjLNPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573615AbjLNPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:00:26 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928512D;
        Thu, 14 Dec 2023 07:00:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BEF0ICf095598;
        Thu, 14 Dec 2023 09:00:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702566018;
        bh=pRDIpD/QeZgLIRILb+6vN3z+cOxSDrk0qAULjxDoPWw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nKNtomcVh+/5Rb9T6aQfwsQAIbrgeloEH38okHyXOeobuaIITGWIoI9J1TaPKk8On
         Rl8+Lun/aTO0GPC0HSJ1Ck5ezX/ZpuYqvO68zyLz1JcA2QACUZMh5IDiuXmFrd4yJA
         1GUj3TgqeEVDjGfCvdoGwRtUWgecS40ncJue4v2A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BEF0Ilt063048
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Dec 2023 09:00:18 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 09:00:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 09:00:17 -0600
Received: from [10.249.141.75] ([10.249.141.75])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BEF0Eg1020069;
        Thu, 14 Dec 2023 09:00:14 -0600
Message-ID: <f77b757c-492a-4a10-8fc1-03c6b3b423e8@ti.com>
Date:   Thu, 14 Dec 2023 20:30:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: ti: Add Itap Delay Value For High Speed
 DDR
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <u-kumar1@ti.com>
References: <20231201082045.790478-1-b-kapoor@ti.com>
 <30baf959-e486-4804-947b-516e53cce6fa@ti.com>
 <6230e848-15b8-48ba-8af4-5f90d7e1408c@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <6230e848-15b8-48ba-8af4-5f90d7e1408c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2023 4:37 PM, Bhavya Kapoor wrote:
>
> On 06/12/23 12:01 am, Kumar, Udit wrote:
>> Hi Bhavya
>>
>> On 12/1/2023 1:50 PM, Bhavya Kapoor wrote:
>>> This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
>>> J7200 and for DDR50 speed mode for MMCSD in J721s2 and J784s4 SoC.
>>>
>>> Rebased to next-20231201
>>>
>>> Bhavya Kapoor (3):
>>>    arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed
>>>      mode
>>>    arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed
>>>      mode
>>>    arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed
>>>      mode
>>
>> Could you confirm, after adding itap values, above modes are working 
>> fine apart from
>>
>> mode detection.
>>
>> Thanks
>>
>> Udit
>
> Hi Udit, Below are the links to the test logs
>
> j7200 ddr52 - 
> https://gist.github.com/a0498981/f9b7b7d3592eaca591dec3e72de45585
>
> j721s2 ddr50 - 
> https://gist.github.com/a0498981/9861e1df3fe0fc7c050db4f7a8cc34b8
>
> j784s4 ddr50 - 
> https://gist.github.com/a0498981/7c598dd708424252e2629fe0c7458a6d
>
> Thanks
>
> ~B-Kapoor
>

Thanks for logs Bhavya,

With that for series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>



>>
>>
>>> arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 1 +
>>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 1 +
>>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 1 +
>>>   3 files changed, 3 insertions(+)
>>>
