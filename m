Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40A774160
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjHHRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjHHRSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:18:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82D282D66;
        Tue,  8 Aug 2023 09:07:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DGWi0021733;
        Tue, 8 Aug 2023 08:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691500592;
        bh=bIvQZUfUTs7cfe2MxD6gzLOpss1VlgflDBuAfiDDw28=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=e4fntY8yrfgX1M3Gv8SSeES03odglvg2KCHYUWqQSA3VSfi4FeJ4CVrIFTBOYBb3S
         SRCKzI57LoDlwEUWYoeGwr0a0Qg+DUoxyFRgA1Cj8afQ5YW3AkJrNcjHmPfUZkzupb
         s+M+w2b4TZ+7zdJEAEnKVXHdIrZNhAnZjqY65FFc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DGWGx124496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:16:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:16:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:16:32 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DGVcJ001287;
        Tue, 8 Aug 2023 08:16:31 -0500
Message-ID: <9830f204-0e4d-bfb0-aea4-9f63d3be9124@ti.com>
Date:   Tue, 8 Aug 2023 08:16:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/13] arm64: dts: ti: k3-am65: Enable OSPI nodes at the
 board level
To:     Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-5-afd@ti.com>
 <bb87effc-00c3-7d97-08c9-68408f9c514c@ti.com>
 <627ed411-a6f7-cbc9-d48f-2678bf63c609@ti.com>
 <a274dabf-3987-0885-54f5-3bd7e7f2d1d5@siemens.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <a274dabf-3987-0885-54f5-3bd7e7f2d1d5@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/8/23 12:27 AM, Jan Kiszka wrote:
> On 07.08.23 17:18, Andrew Davis wrote:
>> On 8/7/23 1:16 AM, Dhruva Gole wrote:
>>> Hi Andrew,
>>>
>>> On 03/08/23 02:23, Andrew Davis wrote:
>>>> OSPI nodes defined in the top-level AM65x SoC dtsi files are incomplete
>>>> and may not be functional unless they are extended with pinmux and
>>>> device information.
>>>>
>>>> As the attached OSPI device is only known about at the board integration
>>>> level, these nodes should only be enabled when provided with this
>>>> information.
>>>>
>>>> Disable the OSPI nodes in the dtsi files and only enable the ones that
>>>> are actually pinned out on a given board.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>    arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 +
>>>>    arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
>>>>    arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 +
>>>>    3 files changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>>> b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>>> index e26bd988e5224..6041862d5aa75 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>>> @@ -593,6 +593,7 @@ adc {
>>>>    };
>>>>    &ospi0 {
>>>> +    status = "okay";
>>>
>>> Ok, so this k3-am65-iot2050 series of DT files seem to be structured in
>>> a bit different manner than our SKs and EVMs?
>>>
>>> The terminologies like advanced, advanced-m2, basic, etc. are a little
>>> confusing to me. However, I am wondering if we don't do any status = ..
>>> here, and rather make ospi status okays from the iot2050 dts files?
>>>
>>> Pardon me if I am making an invalid suggestion, I don't have much
>>> background on these boards.
>>>
>>
>> This is a valid question, and yes the IOT2050 DTS organization is
>> slightly different than the one we use with our SK/EVMs.
>>
>> The way these DT files tend to work is layering more functionality
>> or information in each file, starting with the core/most common
>> in the base .dtsi, and ending with .dts that is specific to a given
>> board. (In that way I would consider instances of "/delete-node/"
>> to be an indicator of bad layering, but that is a different topic..)
>>
>> Any node that is only partially defined in a layer should be marked
>> disabled, and then only enabled in the layer that finally completes
>> the node. That is often the pinmux info at the board level.
>>
>> In this case, the OSPI nodes are complete after this point, there
>> is no additional information given in the DTS files, so we can
>> enable it here in this .dtsi file.
>>
> 
> Ack, this file is the right place to enable OSPI because all our boards
> have OSPI in use, and therefore it is configured at this common level
> already.
> 
> And the reasons for delete-node is obviously that there is no dtsi file
> that describes the AM6528 with its two cores only. If you consider that
> bad layering, you should change your dtsi files ;). But I see no real
> problem here, that pattern is not uncommon.

Yup, wasn't finger pointing, that is our layering problem. It actually
looks like an easy fix to add an k3-am652.dtsi with only two cores, I'll
go do that for next cycle.

Andrew

> 
> Jan
> 
