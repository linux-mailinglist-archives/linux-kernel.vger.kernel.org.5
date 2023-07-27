Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB9764ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjG0JKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjG0JKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:10:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DC49D1;
        Thu, 27 Jul 2023 01:55:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36R8spY3085752;
        Thu, 27 Jul 2023 03:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690448091;
        bh=t+4azm4KlYuktXbiE4ao52lhG1hibV+ERkkezyQ6TDA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Op8Lw5S5B67i3rN97ILL+pvtnXXE0QzUSgqVj1k/QykvJtT2t6IEDF1Rc6jjGpn/n
         cR+LyumK80kYRyeqk5Zh/LpzKvGPdSih/iJ/Timyi2sA6bf9UjIkF5ZxwUNYtwGOtw
         g/42xtaOZ6I7SdpQYILTZv1nQqgAC+C1TuirUNvc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36R8spZv030181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 03:54:51 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 03:54:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 03:54:50 -0500
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36R8sg1j090960;
        Thu, 27 Jul 2023 03:54:43 -0500
Message-ID: <054c1444-10d7-6daa-ec62-0059c00cd32c@ti.com>
Date:   Thu, 27 Jul 2023 14:24:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 03/10]
 net: ti: icssg-prueth: Add Firmware config and classification APIs.
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
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
References: <20230724112934.2637802-1-danishanwar@ti.com>
 <20230724112934.2637802-4-danishanwar@ti.com> <ZL94/L1RMlU5TiAb@corigine.com>
 <b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com> <ZL99WfF7iuzeMP78@corigine.com>
 <5a4b293f-7729-ee03-2432-cd49ff92d809@ti.com> <ZMDOWecss/9F+0nb@corigine.com>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <ZMDOWecss/9F+0nb@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 1:12 PM, Simon Horman wrote:
> On Tue, Jul 25, 2023 at 01:28:21PM +0530, Md Danish Anwar wrote:
>> On 25/07/23 1:14 pm, Simon Horman wrote:
>>> On Tue, Jul 25, 2023 at 01:10:30PM +0530, Md Danish Anwar wrote:
>>>> Hi Simon,
>>>>
>>>> On 25/07/23 12:55 pm, Simon Horman wrote:
>>>>> On Mon, Jul 24, 2023 at 04:59:27PM +0530, MD Danish Anwar wrote:
>>>>>> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
>>>>>> configuration and classification related files. These will be used by
>>>>>> ICSSG ethernet driver.
>>>>>>
>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>>
>>>>> Hi Danish,
>>>>>
>>>>> some feedback from my side.
>>>>>
>>>>
>>>> Thanks for the feedback.
>>>>
>>>>> ...
>>>>>
>>>>>> diff --git a/drivers/net/ethernet/ti/icssg_classifier.c b/drivers/net/ethernet/ti/icssg_classifier.c
>>>>>
>>>>> ...
>>>>>
>>>>>> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
>>>>>
>>>>> This function appears to be unused.
>>>>> Perhaps it would be better placed in a later patch?
>>>>>
>>>>> Or perhaps not, if it makes it hard to split up the patches nicely.
>>>>> In which case, perhaps the __maybe_unused annotation could be added,
>>>>> temporarily.
>>>>>
>>>>
>>>> Due to splitting the patch into 8-9 patches, I had to introduce these helper
>>>> APIs earlier. All these APIs are helper APIs, they will be used in patch 6
>>>> (Introduce ICSSG Prueth driver).
>>>>
>>>> I had this concern that some APIs which will be used later but introduced
>>>> earlier can create some warnings, before splitting the patches.
>>>>
>>>> I had raised this concern in [1] and asked Jakub if it would be OK to introduce
>>>> these APIs earlier. Jakub said it would be fine [2], so I went ahead with this
>>>> approach.
>>>>
>>>> It will make very hard to break patches if these APIs are introduced and used
>>>> in same patch.
>>>
>>> Thanks, I understand.
>>>
>>> In that case my suggestion is to, temporarily, add __maybe_unused,
>>> which will allow static analysis tools to work more cleanly over the
>>> series. It is just a suggestion, not a hard requirement.
>>>
>>> Probably something along those lines applies to all the
>>> review I provided in my previous email. Please use your discretion here.
>>
>> For now I think I will leave it as it is. Let reviewers review all other
>> patches. Let's see if there are any other comments on all the patches in this
>> series. If there are any more comments on other patches, then while re-spinning
>> next revision I will keep this in mind and try to add __maybe_unused tags in
>> all APIs that are used later.
> 
> Sure, that sounds reasonable.
> 

I will be adding __maybe_unused tags to all the helper APIs introduced 
before the main driver patch. In the main driver patch I will be 
removing all those __maybe_unused tags and all the helper APIs will be 
back to their original name (without __maybe_unused tags)

>> The idea behind splitting the patches was to get them reviewed individually as
>> it is quite difficult to get one big patch reviewed as explained by Jakub. And
>> these warnings were expected. If there are any other comments on this series, I
>> will try to address all of them together in next revision.
> 
> Yes, I understand.
> Thanks for splitting things up into multiple patches.
> I know that is a lot of work. But it is very helpful.
> 
>> Meanwhile, Please let me know if you have any comments on other patches
>> in this series.
> 
> Will do, but I nothing to add at this time.

-- 
Thanks and Regards,
Md Danish Anwar
